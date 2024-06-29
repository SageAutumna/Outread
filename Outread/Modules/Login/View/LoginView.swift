import SwiftUI

struct LoginView: View {
    //MARK: - Properties
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @ObservedObject private var viewModel = LoginVm()
    @FocusState private var focusedField: FocusableField?
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var currentIndex = 0
    @State private var xOffset: CGFloat = 0
    
    let imageNames = ["img_graphic_1", "img_graphic_2", "img_graphic_3", "img_graphic_4", "img_graphic_5"]
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    enum FocusableField: Hashable {
        case email, password
    }
    
    //MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 15) {
                    ZStack {
                        ForEach(0..<imageNames.count * 50, id: \.self) { index in
                            Image(imageNames[index % imageNames.count])
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(15)
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
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome to \(Text("OutRead").foregroundStyle(Color.COLOR_9178_A_8))")
                                .foregroundStyle(.white)
                                .font(.poppins(weight: .semibold, size: 30))
                            
                            Text("Signin to continue")
                                .foregroundStyle(.white)
                                .font(.poppins(weight: .medium, size: 20))
                        }
                        .padding(.vertical, 15)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    
                    footerSec
                }
            }
        }
        .hideKeyboardWhenTappedAround()
        .hideNavigationBar()
    }
    
    var footerSec: some View {
        VStack(spacing: 15) {
            TextField("Email", text: $username)
                .font(.poppins(weight: .regular, size: 18))
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding(.horizontal)
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
            
            SecureField("Password", text: $password)
                .font(.poppins(weight: .regular, size: 18))
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(8)
                .padding(.horizontal)
                .focused($focusedField, equals: .password)
                .submitLabel(.done)
            
            Button {
                HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
                viewModel.authenticateUser(username: username, password: password) {
                    hasCompletedOnboarding = true
                }
            } label: {
                HStack {
                    Spacer()
                    
                    Text("Log in")
                        .foregroundColor(.white)
                        .font(.poppins(weight: .semibold, size: 18))
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color.orange)
                .cornerRadius(8)
                .padding(.horizontal, 15)
            }
        }
    }
    
    //MARK: - Functions
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
