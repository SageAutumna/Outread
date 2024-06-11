import SwiftUI
import SwiftData

struct ProductRow: View {
    var product: Product
    @State private var isBookmarked: Bool = false
    var articleType : ArticleType
    var isArticlesList = false
    var width = (UIScreen.main.bounds.size.width - 45 )/2
    var height = ((UIScreen.main.bounds.size.width - 45  )/2) * 1.3
    var playlistWidth : CGFloat = .zero
    var playlistHeight : CGFloat = .zero
    @Query private var bookmarksList : [LocalDataStorage]
    var boormark : ((Product)->())
    
    var body: some View {
        VStack(alignment: .leading) {
            kfImage(from: URL(string: product.images?.first?.src ?? ""))
                .aspectRatio(articleType == .playlist ? 1.3 : 0.8, contentMode: .fill)
                .frame(width:playlistHeight != .zero ? playlistWidth: articleType == .playlist ? height : width , height: playlistHeight != .zero ? playlistHeight : articleType == .playlist ? width : height )
                .cornerRadius(8)
            
            VStack(alignment: .leading,spacing: 5) {
                ZStack(alignment: .top){
                    HStack(alignment: .top) {
                        Text(product.name ?? "")
                            .font(.custom("Poppins-Medium", size: 12))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding([.trailing, .bottom], 0)
                            .padding(.top,4)
                            .lineLimit(4)
                        Spacer()
                        Button(action: {
                            boormark(product)
                        }) {
                            bookmarks
                        }
                        .padding(.top,4)
                    }
                    
                    HStack {
                        let duration = product.metaData?.filter{$0.key == "reading-time"}
                        let readingTime = (duration?.isEmpty ?? false ? " 0 min  " : " \(duration?.first?.value ?? "") mins  ")
                        Text(articleType == .other ? readingTime : " \(product.count ?? 0) Articles  ")
                            .font(.custom("Poppins-Regular", size: 12))
                            .foregroundColor(.white)
                            .frame(height: 20)
                            .background(articleType == .other ? Color.COLOR_4_B_7_E_68 : Color.COLOR_4_F_4_B_82 )
                            .cornerRadius(3)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {}, label: {
                            Image(.icListen)
                                .resizable()
                                .frame(width:10, height: 10)
                                .foregroundColor(.white)
                        })
                        .frame(width: 20,height: 20)
                        .background(articleType == .other ? Color.COLOR_4_B_7_E_68 : Color.COLOR_4_F_4_B_82 )
                        .cornerRadius(3)
                        
                        Spacer()
                    }
                    .padding(.top,80)
                }
                .padding(.bottom, 10)
            }
        }
    }
    
    var bookmarks : some View {
        VStack {
            let filter = bookmarksList.filter{$0.id == product.id}
            if filter.count > 0 {
                Image(.icBookmarked)
                    .resizable()
                    .frame(width:12, height: 16)
                    .foregroundColor(.white)
                    .padding(.trailing, 0)
                    .padding(.top,4)
            } else {
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width:12, height: 16)
                    .foregroundColor(.white)
                    .padding(.trailing, 0)
                    .padding(.top,4)
            }
        }
    }
    
}
enum ArticleType {
    case playlist,other
}
