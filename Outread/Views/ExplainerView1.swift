import SwiftUI

struct ExplainerView1: View {
    // Define your navigation actions here
    var goToLogin: () -> Void
    var goToNext: () -> Void
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color to cover safe area
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                // Use the provided image as the background
                Image(.imgExplainer1) // Make sure to add this image to your Xcode asset catalog
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                // Overlay content
                VStack {
                    Spacer()
                    
                    // Next Button
                    Button(action: goToNext) {
                        Text("Next")
                            .font(.custom("Poppins-Bold", size: 19))
                            .foregroundColor(.black)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 10) // Spacing between buttons
                    
                    // Log In Button
                    Button(action: goToLogin) {
                        Text("Log In")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 19))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 30) // Padding at the bottom to ensure buttons stay up
                }
                .padding(.horizontal) // Padding on the sides of the buttons
            }
        }
    }
}
