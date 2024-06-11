import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginFailed: Bool = false
    var onLoginSuccess: () -> Void
    
    // The names of your images
    let imageNames = ["img_graphic_1", "img_graphic_2", "img_graphic_3", "img_graphic_4", "img_graphic_5"]
    @State private var currentIndex = 0
    @State private var xOffset: CGFloat = 0
    
    // Timer to change the image every few seconds
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    let backgroundColor = Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0)
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    // Background color to cover safe area
                    backgroundColor
                        .edgesIgnoringSafeArea(.all)
                    
                    Image(.imgLoginBG) // Make sure to add this image to your Xcode asset catalog
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                    
                    VStack {
                        Spacer()
                        
                        // Carousel
                        ZStack {
                            ForEach(0..<imageNames.count * 50, id: \.self) { index in
                                Image(imageNames[index % imageNames.count])
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                                    .frame(width: geometry.size.width * 0.55)
                                    .scaleEffect(index % imageNames.count == currentIndex ? 1 : 0.8)
                                    .opacity(index % imageNames.count == currentIndex ? 1 : 0.5)
                                    .offset(x: xOffset + CGFloat(index - currentIndex) * geometry.size.width * 0.65)
                                    .animation(.easeInOut(duration: 1), value: currentIndex)
                            }
                        }
                        .frame(height: geometry.size.height * 0.4)
                        .onReceive(timer) { _ in
                            withAnimation {
                                currentIndex = (currentIndex + 1) % imageNames.count
                                if currentIndex == 0 {
                                    xOffset -= geometry.size.width * 0.65 * CGFloat(imageNames.count)
                                }
                            }
                        }

                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()





                        
                        if loginFailed {
                            Text("Login failed. Please try again.")
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        
                        VStack(spacing: 15) {
                            TextField("Email", text: $username)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(5.0)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .padding(.horizontal)
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .cornerRadius(5.0)
                                .padding(.horizontal)
                            
                            Button("Log in") {
                                authenticateUser(username: username, password: password)
                            }
                            .foregroundColor(.white)
                            .font(.custom("Poppins-Bold", size: 19))
                            .frame(minWidth: 0, maxWidth: 350)
                            .padding(.vertical, 12)
                            .background(Color.orange)
                            .cornerRadius(8)
                        }
                        .padding(.bottom, 20)
                        
                        Spacer()
                        
                    }
                    
                }
            }
        }
    }
    
    func authenticateUser(username: String, password: String) {
        // Authentication logic remains unchanged
        guard let url = URL(string: "https://out-read.com/wp-json/jwt-auth/v1/token") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    self.loginFailed = true
                    return
                }
                if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self.onLoginSuccess()
                    
                    // Decode the JWT token from the response
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let loginResponse = try? decoder.decode(LoginResponse.self, from: data) {
                            print("JWT Token: \(loginResponse.token)")
                            // You can also store the token securely here
                        } else {
                            print("Failed to decode JWT token")
                        }
                    }
                } else {
                    self.loginFailed = true
                }
            }
        }.resume()
    }
    
    struct LoginResponse: Codable {
        var token: String
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(onLoginSuccess: {})
    }
}
