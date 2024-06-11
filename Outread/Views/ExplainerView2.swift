import SwiftUI

struct ExplainerView2: View {
    var goToNextPage: () -> Void
    
    // The names of your images
    let imageNames = ["Graphic101", "Graphic102", "Graphic100"]
    @State private var selectedImageIndex = 0
    
    // Timer to change the image every few seconds
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background color to cover safe area
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                // Background image
                Image(.imgExplainer2) // Use the ID of your background image in the asset catalog
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                VStack {
                    TabView(selection: $selectedImageIndex) {
                        ForEach(imageNames.indices, id: \.self) { index in
                            Image(imageNames[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: geometry.size.height * 0.4)
                    .padding(.top, geometry.size.height * 0.1) // Dynamic top padding
                    .onReceive(timer) { _ in
                        withAnimation {
                            selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
                        }
                    }
                    Spacer()
                    Button(action: goToNextPage) {
                        Text("Log In")
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 19))
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 24)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 30)
                }
                .padding(.horizontal)
            }
        }
        .onDisappear {
            self.timer.upstream.connect().cancel()
        }
    }
}
