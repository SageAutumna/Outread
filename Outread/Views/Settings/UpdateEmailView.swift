import SwiftUI

struct UpdateEmailView: View {
    @State private var newEmail: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Update Email")
                .foregroundColor(.white)
                .font(.custom("Poppins-Medium", size: 36))
                .padding(.top, 16)
                .padding(.horizontal, 15)
            
            TextField("New Email", text: $newEmail)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .padding(.horizontal, 15)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.custom("Poppins-Regular", size: 14))
                    .padding(.horizontal, 15)
            }
            
            Button(action: updateEmail) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                } else {
                    Text("Update Email")
                        .foregroundColor(.white)
                        .font(.custom("Poppins-Bold", size: 18))
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 15)
            .disabled(isLoading)
            
            Spacer()
        }
        .background(Color(red: 0x11 / 255.0, green: 0x1E / 255.0, blue: 0x2B / 255.0).edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Update Email", displayMode: .inline)
    }
    
    func updateEmail() {
        guard !newEmail.isEmpty else {
            errorMessage = "Email cannot be empty"
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        // Implement the network request to update the email on WordPress
        NetworkManager.shared.updateEmail(newEmail: newEmail) { success, error in
            isLoading = false
            if success {
                // Handle success (e.g., show a success message or navigate back)
            } else {
                errorMessage = error?.localizedDescription ?? "An unknown error occurred"
            }
        }
    }
}

struct UpdateEmailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailView()
    }
}
