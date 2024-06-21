import SwiftUI
import SwiftData

struct ProductRow: View {
    //MARK: - Properties
    @State private var isBookmarked: Bool = false
    @Query private var bookmarksList : [LocalDataStorage]
    
    var product: Product
    var width = (UIScreen.main.bounds.size.width - 45) / 2
    var height: CGFloat { width * 1.3 }
    var boormark : ((Product)->())
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            kfImage(from: URL(string: product.images?.first?.src ?? ""))
                .frame(width: width,
                       height: height)
                .clipShape (
                    RoundedRectangle(cornerRadius: 8)
                )
            
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(product.name ?? "")
                        .font(.poppins(weight: .medium, size: 14))
                        .lineLimit(3)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 4)
                    
                    Spacer()
                    
                    Button {
                        boormark(product)
                    } label: {
                        bookmarks
                    }
                }
                .padding(.bottom, 8)
                
                Spacer()
                
                HStack(spacing: 8) {
                    let duration = product.metaData?.filter{$0.key == "reading-time"}
                    let readingTime = (duration?.isEmpty ?? false ? "0 min" : "\(duration?.first?.value ?? "") mins")
                    
                    Text(readingTime)
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.poppins(weight: .medium, size: 11))
                        .padding(.all, 4)
                        .background(Color.COLOR_4_B_7_E_68)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 4)
                        )
                    
                    Image(.icListen)
                        .padding(.all, 8)
                        .background(Color.COLOR_4_B_7_E_68)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 4)
                        )
                }
                .frame(height: 12)
            }
            .padding(.bottom, 8)
        }
    }
    
    var bookmarks: some View {
        VStack {
            let filter = bookmarksList.filter{ $0.id == product.id }
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
    
    //MARK: - Functions
}

enum ArticleType {
    case playlist, other
}
