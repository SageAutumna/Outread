import SwiftUI

struct UpdateEmailView: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @ObservedObject private var viewModel = UpdateEmailVm()
    
    //MARK: - Body
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 16) {
                TextField("New Email", text: $viewModel.email)
                    .padding()
                    .font(.poppins(weight: .regular, size: 20))
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 15)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                
                Button(action: viewModel.updateEmail) {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(8)
                    } else {
                        Text("Update Email")
                            .foregroundColor(.white)
                            .font(.poppins(weight: .semibold, size: 18))
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 15)
                .disabled(viewModel.isLoading)
            }
            .padding(.top, 16)
            
            Spacer()
        }
        .hideKeyboardWhenTappedAround()
        .background(Color.COLOR_141_D_2_A)
        .navigationTitle("Update Email")
        .navigationBarColor(backgroundColor: .COLOR_141_D_2_A, titleColor: .white)
    }
    
    //MARK: - Functions
}

struct UpdateEmailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailView()
    }
}
