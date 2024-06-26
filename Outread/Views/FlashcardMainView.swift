//
//  FlashcardView.swift
//  Outread
//
//  Created by Jaspreet Singh on 30/05/24.
//

import SwiftUI
import SwiftData
struct FlashcardMainView: View {
    @State private var isLoading = true
    @State var product: Product
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    var width = (UIScreen.main.bounds.size.width - 45 )/2
    var height = ((UIScreen.main.bounds.size.width - 45  )/2) * 1.3
    @State private var articleContent: String?
    @State private var list = [(String,String)]()
    @Environment(\.dismiss) var dismiss
    @State private var isSwipe = false
    @Environment(\.modelContext) var context
    @Query var bookmarksList: [LocalDataStorage]
    var categories : [Category]
    @State var isShowCategory = false
    @State var isSwipeUpActive = false
    @State var isSwipeDownActive = false
    @State var categoriesList = [Category]()
    @State var scrollViewSize: CGSize = .zero
    let spaceName = "scroll"
    @State var wholeSize: CGSize = .zero
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            ZStack {
                Color(UIColor(named: "COLOR_27394F")!)
                    .cornerRadius(20)
                    .padding([.leading,.trailing], 15)
                    .padding(.bottom, 10)
                ZStack {
                    ChildSizeReader(size: $wholeSize) {
                    ScrollView{
                        ChildSizeReader(size: $scrollViewSize) {
                            ZStack {
                                VStack(alignment: .leading,spacing: 8) {
                                    if isShowCategory {
                                        showTopView
                                        headerTitle
                                        subHeader
                                        addLine
                                        readingTime
                                        addLine
                                        descriptionView
                                        CategoriesScrollView(categories: categoriesList.filter{ $0.colorCategory != "" },
                                                             products: [product],
                                                             isNeedFilter: false) { id in }
                                            .padding(.bottom,15)
                                    }
                                    
                                }
                                .padding([.leading,.trailing],15)
                                  if isLoading {
                                    HUDView(showHUD: $isLoading)
                                  }
                            }
                            .background(
                                GeometryReader { proxy in
                                    Color.clear.preference(
                                        key: ViewOffsetKey.self,
                                        value: -1 * proxy.frame(in: .named(spaceName)).origin.y
                                    )
                                }
                            )
                            .onPreferenceChange(
                                ViewOffsetKey.self,
                                perform: { value in
                                    print("offset: \(value)") // offset: 1270.3333333333333 when User has reached the bottom
                                    print("height: \(scrollViewSize.height)") // height: 2033.3333333333333
                                    if value >= scrollViewSize.height - wholeSize.height  && value != 0.0 && scrollViewSize.height != 0.0{
                                        isSwipeDownActive = true
                                        isSwipeUpActive = false
                                        print("User has reached the bottom of the ScrollView.")
                                    } else if value == 0.0 && scrollViewSize.height != 0.0 || value == 0.0 && scrollViewSize.height == 0.0{
                                        isSwipeUpActive = true
                                        isSwipeDownActive = false
                                        print("User has reached the up of the ScrollView.")
                                    }else{
                                        isSwipeUpActive = false
                                        isSwipeDownActive = false
                                        print("not reached.")
                                    }
                                    
                                    if scrollViewSize.height < wholeSize.height{
                                        isSwipeDownActive = true
                                    }
                                }
                            )
                        }
                    }
                    .coordinateSpace(name: spaceName)
                    .onChange(
                        of: scrollViewSize,
                        perform: { value in
                            print(value)
                        }
                    )
                   }.padding([.top,.bottom],10)
                        .opacity(!isLoading ? 1 : 0.2)
                        .onAppear(perform: {
                            UIScrollView.appearance().bounces = false
                        })
                }
            }
            .gesture(DragGesture(minimumDistance: 3, coordinateSpace: .global)
                .onChanged{ value in
                    if value.translation.height <= 0 && isSwipeDownActive{
                            isSwipe = true
                       // up
                    }else if value.translation.height > 0 && isSwipeUpActive{
                            dismiss()
                    }else{
                        print("no clue")
                    }
                print(value.translation)
            }
            )
            .onTapGesture {
                bookmarkProduct(product)
            }
        }.onAppear(perform: {
                loadArticle()
                for i in 0..<(product.categories?.count ?? 0) {
                    let filter = categories.filter{$0.name.lowercased() == product.categories?[i].name.lowercased() }
                    if filter.count > 0 {
                        categoriesList.append(filter.first!)
                    } else {
                        if let category = product.categories?[i] {
                            categoriesList.append(category)
                        }
                    }
                    if i == (product.categories?.count ?? 0)-1 {
                        isShowCategory = true
                    }
                }
            })
    }
    
    
    
    private var showTopView : some View {
        HStack(alignment: .top){
            Spacer()
            articleImage
            Spacer()
            bookmarks
        }.padding(.top,10)
    }
    
    private func loadArticle() {
        NetworkManager.shared.fetchArticleByTitle(product.name ?? "") { fetchedContent in
            if let content = fetchedContent {
                // Convert HTML to plain text
                let plainText = content.htmlToString
                articleContent = plainText
                var arrDetails = [String]()
                let body = content.allStringsBetween(start: "<p>", end: "</p>")
                for i in body {
                    arrDetails.append((i as? String)?.htmlToString ?? "")
                }
                arrDetails = arrDetails.filter{!($0.isEmpty)}
                for i in arrDetails {
                    if i.count < 100 {
                        list.append((i,""))
                    } else {
                        if !list.isEmpty {
                            let obj = list.last
                            let body = "\(obj?.1 ?? "")\n\(i)"
                            list.removeLast()
                            list.append((obj?.0 ?? "",body))
                        } else {
                            if i.contains(":") {
                                let data = i.components(separatedBy: ":")
                                list.append((data[0],data[1]))
                            }
                        }
                    }
                }
                list = list.filter{!($0.1.isEmpty)}
                isLoading = false
            }
        }
    }
    
    
    func bookmarkProduct(_ product: Product) {
        let item = LocalDataStorage(id: product.id ?? 0, name: product.name ?? "", shortDescription: product.shortDescription ?? "", categories: product.categories ?? [], images: product.images ?? [], metaData: product.metaData ?? [], descData: product.desc ?? "")
        if let existingIndex = bookmarksList.firstIndex(where: { $0.id == item.id }) {
            context.delete(bookmarksList[existingIndex])
        } else {
            context.insert(item)
        }
        do {
            try context.save()
        } catch {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
        }
    }
    
    
    
    private var articleImage : some View {
        VStack {
            if let firstImage = product.images?.first, let imageUrl = URL(string: firstImage.src) {
                NavigationLink(destination: FlashcardView(productName: product.name ?? "",list: list),isActive: $isSwipe) {}
                kfImage(from: imageUrl)
                    .aspectRatio(0.8, contentMode: .fill)
                    .frame(width:width,height: height,alignment: .center)
                    .cornerRadius(8)
                    .padding(.leading,15)
            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(0.8, contentMode: .fill)
                    .frame(width:width,height: height,alignment: .center)
                    .cornerRadius(8)
                    .padding(.leading,15)
            }
        }
        
    }
    
    
    private var bookmarks : some View {
        VStack {
            ZStack {
                if isBookmarkAdded {
                    Image(uiImage: UIImage(resource: .icBookmarked))
                        .resizable()
                        .frame(width:22, height: 28)
                        .foregroundColor(.white)
                        .padding(.trailing, 0)
                        .padding([.trailing],15)
                } else {
                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width:22, height: 28)
                        .foregroundColor(.white)
                        .padding(.trailing, 0)
                        .padding([.trailing],15)
                }
            }
        }
        
    }
    
    
    var isBookmarkAdded : Bool {
         bookmarksList.filter{$0.id == product.id ?? 0}.count > .zero
    }
    
    var headerTitle : some View {
        VStack(alignment: .leading){
            Text(product.name ?? "")
                .font(.custom("Poppins-Medium", size: 22))
                .foregroundColor(.white)
                .padding([.leading,.trailing], 15)
        }
    }
    
    var subHeader : some View {
        VStack {
            Text(product.shortDescription?.removeHtmlTags ?? "")
                .font(.custom("Poppins-Regular", size: 17))
                .foregroundColor(.white)
                .padding([.leading,.trailing], 15)
                .padding(.bottom,-15)
        }
    }
    
    var addLine: some View {
        VStack {
            Rectangle().frame(height: 0.5,alignment: .center).foregroundColor(Color.white).padding([.leading,.trailing], 15)
        }
    }
    
    var readingTime: some View {
        HStack(spacing: 0) {
            let duration = product.metaData?.filter{$0.key == "reading-time"}
            let readingTime = (duration?.isEmpty ?? false ? "0 min" : "\(duration?.first?.value ?? "") mins")
            Image(.icReadingTime)
                .frame(width: 20, height: 20, alignment: .leading)
                .padding(.leading, 15).padding(.top,-2)
            Text(readingTime)
                .font(.custom("Poppins-Regular", size: 17))
                .foregroundColor(.white)
        }.padding([.leading,.trailing], 15)
    }
    
    var descriptionView : some View {
        VStack {
            Text(product.desc?.removeHtmlTags ?? "")
                .font(.custom("Poppins-Medium", size: 17))
                .foregroundColor(.white)
                .padding([.leading,.trailing], 15)
        }
    }
}

extension View {
    func swipe(
        up: @escaping (() -> Void) = {},
        down: @escaping (() -> Void) = {},
        left: @escaping (() -> Void) = {},
        right: @escaping (() -> Void) = {}
    ) -> some View {
        return self.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded({ value in
                if value.translation.width < 140 { left() }
                if value.translation.width > 140 { right() }
                //  if value.translation.height < 0 { up() }
                // if value.translation.height > 0 { down() }
            }))
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
struct ChildSizeReader<Content: View>: View {
  @Binding var size: CGSize

  let content: () -> Content
  var body: some View {
    ZStack {
      content().background(
        GeometryReader { proxy in
          Color.clear.preference(
            key: SizePreferenceKey.self,
            value: proxy.size
          )
        }
      )
    }
    .onPreferenceChange(SizePreferenceKey.self) { preferences in
      self.size = preferences
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero

  static func reduce(value _: inout Value, nextValue: () -> Value) {
    _ = nextValue()
  }
}
