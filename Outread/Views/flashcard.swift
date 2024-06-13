import SwiftUI

struct FlashcardView: View {
    let productName: String
    @State private var articleContent: String?
    @State private var isLoading = false
    @State private var currentSectionIndex = 0
     var list: [ListType]
    @Environment(\.dismiss) var dismiss
    
    private var contentSections: [String] {
        articleContent?.split(separator: "\n").map(String.init) ?? []
    }
    
    
    
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    var body: some View {
        ZStack {
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            ZStack {
                Color(UIColor(named: "COLOR_27394F")!)
                    .cornerRadius(20)
                    .padding([.leading,.trailing], 15)
                    .padding(.bottom, 10)
                ZStack {
                    
                    Group {
                        if isLoading {
                            HUDView(showHUD: $isLoading)
                            
                        } else if !list.isEmpty {
                            VStack(alignment: .leading,spacing: 0) {
                                Text(list[currentSectionIndex].str1)
                                    .foregroundColor(Color.white)
                                    .font(.poppins(weight: .medium, size: 30))
                                    .padding([.top,.bottom],10)
                                    .padding([.leading,.trailing],25)
                                
                                
                                ScrollView {
                                    Text(list[currentSectionIndex].str2)
                                        .foregroundColor(Color.white)
                                        .font(.poppins(weight: .regular, size: 20))
                                        .padding([.leading,.trailing],25)
                                    
                                }.padding(.bottom,10)
                                
                                //                            HStack {
                                //                                Button(action: {
                                //                                    withAnimation {
                                //                                        currentSectionIndex = currentSectionIndex - 1
                                //                                }
                                //                                }) {
                                //                                    Text("Previous")
                                //                                        .foregroundColor(Color.white).opacity(currentSectionIndex <= 0 ? 0.5 : 1)
                                //                                }
                                //                                .disabled(currentSectionIndex <= 0)
                                //
                                //                                Spacer()
                                //
                                //                                Button(action: {
                                //                                    withAnimation {
                                //                                        currentSectionIndex = currentSectionIndex + 1
                                //                                    }
                                //                                }) {
                                //                                    Text("Next")
                                //                                        .foregroundColor(Color.white).opacity(currentSectionIndex >= list.count - 1 ? 0.5 : 1)
                                //                                }
                                //                                .disabled(currentSectionIndex >= list.count - 1)
                                //                            }
                                // .padding()
                            }
                        } else {
                            Text("Unable to load article")
                                .foregroundColor(Color.white)
                        }
                    }
                }.padding(.all,15)
                
                .onAppear {
                   // loadArticle()
                }
            }
        }
        .navigationBarTitle("Article", displayMode: .inline)
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width, value.translation.height) {
                    case (...0, -30...30):  if currentSectionIndex < list.count - 1 {
                                        currentSectionIndex = currentSectionIndex + 1
                                    }
                    case (0..., -30...30):  if currentSectionIndex == 0 {
                                        dismiss()
                        
                                    } else {
                                        currentSectionIndex = currentSectionIndex - 1
                                    }
                    default:  print("no clue")
                }
            }
        )
        
        
    }
    
//    private func loadArticle() {
//        NetworkManager.shared.fetchArticleByTitle(productName) { fetchedContent in
//            if let content = fetchedContent {
//                // Convert HTML to plain text
//                let plainText = content.htmlToString
//                articleContent = plainText
//                var arrDetails = [String]()
//                    let body = content.allStringsBetween(start: "<p>", end: "</p>")
//                for i in body {
//                    arrDetails.append((i as? String)?.htmlToString ?? "")
//                }
//                arrDetails = arrDetails.filter{!($0.isEmpty)}
//                for i in arrDetails {
//                    if i.count < 100 {
//                        list.append((i,""))
//                    } else {
//                        if !list.isEmpty {
//                            let obj = list.last
//                            let body = "\(obj?.1 ?? "")\n\(i)"
//                            list.removeLast()
//                            list.append((obj?.0 ?? "",body))
//                        }
//                    }
//
//                }
//            }
//            self.isLoading = false
//        }
//    }
}

extension String {

var htmlToString: String {
    guard let data = data(using: .utf8) else { return "" }
    do {
        let nsAttributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return nsAttributedString.string
    } catch {
        print("Error:", error)
        return ""
    }
}
}

extension NetworkManager {
    func fetchArticleByTitle(_ title: String, completion: @escaping (String?) -> Void) {
        let encodedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://out-read.com/wp-json/wp/v2/article?search=\(encodedTitle)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Network error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            do {
                let articles = try JSONDecoder().decode([Article].self, from: data)
                // Assuming the first match is the desired one
                if let article = articles.first {
                    DispatchQueue.main.async {
                        completion(article.content.rendered)
                    }
                } else {
                    // No article found
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } catch {
                print("Decoding error: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
extension String{

  func allStringsBetween(start: String, end: String) -> [Any] {
            var strings = [Any]()
            var startRange: NSRange = (self as NSString).range(of: start)

            while true {
                if startRange.location != NSNotFound {
                    var targetRange = NSRange()
                    targetRange.location = startRange.location + startRange.length
                    targetRange.length = self.count - targetRange.location
                    let endRange: NSRange = (self as NSString).range(of: end, options: [], range: targetRange)
                    if endRange.location != NSNotFound {
                        targetRange.length = endRange.location - targetRange.location
                        strings.append((self as NSString).substring(with: targetRange))
                        var restOfString =  NSRange()
                        restOfString.location = endRange.location + endRange.length
                        restOfString.length = self.count - restOfString.location
                        startRange = (self as NSString).range(of: start, options: [], range: restOfString)
                    }
                    else {
                        break
                    }
                }
                else {
                    break
                }

            }
            return strings
        }

    }
