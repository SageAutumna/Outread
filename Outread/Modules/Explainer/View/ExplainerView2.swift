import SwiftUI

struct ExplainerView2: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            Image(.imgExplainer2)
                .resizable()
                .frame(width: UIApplication.keyWindow?.bounds.width,
                       height: (UIApplication.keyWindow?.bounds.height ?? 0) - (UIApplication.keyWindow?.safeAreaInsets.top ?? 0))
        }
        .hideNavigationBar()
        .overlay {
            buttonsView
                .padding(.horizontal)
        }
    }
    
    private var buttonsView: some View {
        VStack {
            Spacer()
            
            Button {
                HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
                router.push(.login)
            } label: {
                Text("Log In")
                    .foregroundStyle(.white)
                    .font(.poppins(weight: .medium, size: 20))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            .padding(.bottom, 30)
        }
    }
    
    //MARK: - Functions
}

struct ExplainerView2_Previews: PreviewProvider {
    static var previews: some View {
        ExplainerView2()
    }
}

