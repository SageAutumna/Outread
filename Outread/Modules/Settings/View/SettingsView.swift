import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @EnvironmentObject private var router: Router<AppRoutes>
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        headerView
                        
                        settingsList
                        
                        footerView
                    }
                    .padding(.bottom, ((UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 35))
                }
                .padding(.top, 15)
            }
        }
    }
    
    var headerView: some View {
        Text("Settings")
            .foregroundColor(.white)
            .font(.poppins(weight: .medium, size: 36))
            .overlay(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 2)
                    .frame(height: 4)
                    .foregroundColor(Color.COLOR_9178_A_8)
                    .offset(y: 10)
            }
            .padding(.horizontal, 15)
    }
    
    var settingsList: some View {
        VStack(alignment: .leading, spacing: 15) {
            settingsItem(title: "My Account") {
                router.push(.updateEmail)
            }
            
            settingsItem(title: "Membership")
            
            settingsItem(title: "Notifications")
            
            Divider()
                .background(Color.white)
                .padding(.bottom, 10)
            
            settingsItem(title: "Privacy Policy") {
                router.push(.privacyPolicy)
            }
            
            settingsItem(title: "Terms of use")
            
            settingsItem(title: "Feedback")
            
            settingsItem(title: "Help Center")
            
            settingsItem(title: "Log out") {
                Alert.shared.showAlert(msg: "Are you sure you want to logout?", options: "Cancel", "Logout", btnStyle: .default, .destructive, completion: { option in
                    switch option {
                    case 0: break
                    case 1:
                        hasCompletedOnboarding = false
                        router.popTo(.explainer1, inclusive: true)
                    default: break
                    }
                })
            }
            
            settingsItem(title: "Delete Account", color: .red) {
                Alert.shared.showAlert(msg: "Are you sure you want to delete account?", options: "Cancel", "Delete", btnStyle: .default, .destructive, completion: { option in
                    switch option {
                    case 0: break
                    case 1: break
                    default: break
                    }
                })
            }
        }
        .padding(.top, 5)
        .padding(.horizontal, 15)
    }
    
    var footerView: some View {
        VStack {
            Divider()
                .background(Color.white)
            
            Text("Version 1.0")
                .foregroundColor(.white)
                .font(.poppins(weight: .regular, size: 16))
                .padding(.vertical, 10)
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 15)
    }
    
    func settingsItem(title: String, color: Color = .white, complition: (() -> Void)? = nil) -> some View {
        Button {
            HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
            complition?()
        } label: {
            HStack {
                Text(title)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(color)
                    .font(.poppins(weight: .medium, size: 20))
                    .padding(.bottom, 10)
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    //MARK: - Functions
}
