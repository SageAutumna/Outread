import SwiftUI

struct FeaturedArticle: View {
    var image: String
    var title: String
    var duration: String
    var product : Product
    var boormark : ((Product)->())
    
    var body: some View {
      //  ZStack {
            // Display the background image
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()
                .cornerRadius(15)
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                    .font(.custom("Poppins-Bold", size: 24))
                    .foregroundColor(.white)
                    .padding([.leading, .trailing, .bottom], 15)
                
                HStack {
                    Text(duration)
                        .font(.custom("Poppins-Regular", size: 16))
                        .foregroundColor(.white)
                        .padding(.leading, 15)
                    
                    Spacer()
                    
                    Button(action: {
                        boormark(product)
                    }) {
                        Image(systemName: "bookmark")
                            .foregroundColor(.white)
                            .padding(.trailing, 15)
                    }
                }
                .padding(.bottom, 10)
            }
            .background(Color.black.opacity(0.3))
            .cornerRadius(15)
       // }
        .padding(.horizontal)
    }
}
