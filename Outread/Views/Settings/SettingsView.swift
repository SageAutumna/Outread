import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    headerView(geometry: geometry)
                    settingsList
                    Spacer()
                    footerView
                }
                .background(Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0).edgesIgnoringSafeArea(.all))
                .navigationBarHidden(true)
            }
        }
    }
    
    func headerView(geometry: GeometryProxy) -> some View {
        VStack(alignment: .leading) {
            Text("Settings")
                .foregroundColor(.white)
                .font(.custom("Poppins-Medium", size: 36))
                .padding(.top, 16)
            
            Rectangle()
                .frame(height: 4)
                .foregroundColor(Color(red: 0x6F / 255.0, green: 0x99 / 255.0, blue: 0x6E / 255.0))
                .padding(.trailing, geometry.size.width * 0.6)
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 15)
    }
    
    var settingsList: some View {
        VStack(alignment: .leading, spacing: 15) {
            NavigationLink(destination: UpdateEmailView()) {
                settingsItem(title: "My Account")
            }
            settingsItem(title: "Membership")
            settingsItem(title: "Notifications")
            
            Divider()
                .background(Color.white)
                .padding(.vertical, 10)
            
            NavigationLink(destination: PrivacyPolicyView()) {
                settingsItem(title: "Privacy Policy")
            }
            settingsItem(title: "Terms of use")
            settingsItem(title: "Feedback")
            settingsItem(title: "Help Center")
            settingsItem(title: "Log out")
            
            Text("Delete Account")
                .foregroundColor(.red)
                .font(.custom("Poppins-Medium", size: 16))
                .padding(.leading, 15)
        }
        .padding(.horizontal, 15)
    }
    
    var footerView: some View {
        VStack {
            Divider()
                .background(Color.white)
            
            Text("Version 1.0")
                .foregroundColor(.white)
                .font(.custom("Poppins-Regular", size: 14))
                .padding(.vertical, 10)
        }
        .padding(.horizontal, 15)
        .padding(.bottom, 10)
    }
    
    func settingsItem(title: String) -> some View {
        Text(title)
            .foregroundColor(.white)
            .font(.custom("Poppins-Medium", size: 16))
            .padding(.leading, 15)
    }
}
