
import SwiftUI

struct FeatureTopArticle: View {
    //MARK: - Properties
    var image: String
    var title: String
    var duration: String
    var product : Product
    var didBookmark : ((Product)->())
    
    //MARK: - Body
    var body: some View {
        VStack(spacing: 0) {
            kfImage(from: URL(string: image))
                .frame(height: 200)
                .padding(.leading,0)
                .clipped()
                .cornerRadius(15)
            
            VStack(alignment: .leading, spacing: 5) {
                
                HStack(alignment: .top, spacing: 0) {
                    Text(title)
                        .font(.custom("Poppins-Medium", size: 18))
                        .foregroundColor(.white)
                        .padding([.trailing, .bottom], 0)
                        .padding(.top,4)
                    
                    Spacer()
                    
                    Button(action: {
                        didBookmark(product)
                    }) {
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width:16, height: 22)
                            .foregroundColor(.white)
                            .padding(.trailing, 0)
                            .padding(.top,4)
                        
                    }
                    .padding(.top,4)
                }
                
                HStack {
                    Text(duration)
                        .font(.poppins(weight: .regular, size: 16))
                        .foregroundColor(.white)
                        .padding(.leading, 0)
                        .frame(width: 72,height: 25)
                        .background(Color.COLOR_4_B_7_E_68)
                        .cornerRadius(3)
                        .multilineTextAlignment(.center)
                    
                    Button {} label: {
                        Image(.icListen)
                            .resizable()
                            .frame(width:12, height: 12)
                            .foregroundColor(.white)
                    }
                    .frame(width: 25,height: 25)
                    .background(Color.COLOR_4_B_7_E_68)
                    .cornerRadius(3)
                    
                    Spacer()
                    
                }
                .padding(.top,0)
                .padding(.bottom, 10)
            }
            .padding(.top,0)
            .background(Color.clear)
        }
        .padding([.leading,.trailing], 15)
    }
    
    //MARK: - Functions
}

struct CategoryHeader: View {
    //MARK: - Properties
    var title: String
    var ButtonTitle: String = "View All"
    var didTapButton: (() -> Void)
    
    //MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .font(.poppins(weight: .medium, size: 18))
                .foregroundColor(.white)
                .padding(.leading, 15)
                .padding(.top, 10)
            
            Spacer()
            
            Button {
                didTapButton()
            } label: {
                Text(ButtonTitle)
                    .font(.poppins(weight: .medium, size: 18))
                    .foregroundColor(Color.COLOR_86_AD_72)
                    .padding(.trailing, 15)
                    .padding(.top, 10)
            }
            
        }
    }
    
    //MARK: - Functions
}
