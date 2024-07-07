//
//  SignUpScreen.swift
//  Outread
//
//  Created by iOS DEVELOPER on 07/07/24.
//

import SwiftUI

struct SignUpScreen: View {
    //MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @ObservedObject private var viewModel = SignUpVm()
    @FocusState private var focusedField: FocusableFieldSignUp?
    
    @State private var email: String = ""
    @State private var fName: String = ""
    @State private var lName: String = ""
    @State private var phoneNum: String = ""
    @State private var password: String = ""
    @State private var currentIndex = 0
    @State private var xOffset: CGFloat = 0
    
    enum FocusableFieldSignUp: Hashable {
        case fName, lName, phoneNum, email, password
    }
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 15) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome to \(Text("OutRead").foregroundStyle(Color.COLOR_9178_A_8))")
                                .foregroundStyle(.white)
                                .font(.poppins(weight: .semibold, size: 30))
                            
                            Text("Sign Up to continue")
                                .foregroundStyle(.white)
                                .font(.poppins(weight: .medium, size: 20))
                        }
                        .padding(.vertical, 15)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 32)
                    
                    footerSec
                    
                    Spacer()
                }
            }
        }
        .hideKeyboardWhenTappedAround()
        .hideNavigationBar()
    }
    
    var footerSec: some View {
        VStack(spacing: 15) {
            makeTextField(title: "First Name", txtStr: $fName)
                .keyboardType(.default)
                .focused($focusedField, equals: .fName)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .lName
                }
            
            makeTextField(title: "Last Name", txtStr: $lName)
                .keyboardType(.default)
                .focused($focusedField, equals: .lName)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .phoneNum
                }
            
            makeTextField(title: "Phone Number", txtStr: $phoneNum)
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .phoneNum)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .email
                }
            
            makeTextField(title: "Email", txtStr: $email)
                .keyboardType(.emailAddress)
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
                guard !fName.isEmpty else {
                    Alert.shared.showAlert(msg: "First Name Must Not Empty.")
                    return
                }
                
                guard !lName.isEmpty else {
                    Alert.shared.showAlert(msg: "Last Name Must Not Empty.")
                    return
                }
                
                guard !phoneNum.isEmpty else {
                    Alert.shared.showAlert(msg: "Phone Number Must Not Empty.")
                    return
                }
                
                guard phoneNum.isPhoneNumber else {
                    Alert.shared.showAlert(msg: "Please Enter Valid Phone number.")
                    return
                }
                
                guard !email.isEmpty else {
                    Alert.shared.showAlert(msg: "Email Must Not Empty.")
                    return
                }
                
                guard email.isEmail else {
                    Alert.shared.showAlert(msg: "Please Enter Valid Email.")
                    return
                }
                
                guard !password.isEmpty else {
                    Alert.shared.showAlert(msg: "Password Must Not Empty.")
                    return
                }
                
                guard password.isValidPassword else {
                    Alert.shared.showAlert(msg: "Please Enter Valid Password.")
                    return
                }
                
                let model = SignUpModel(username: email, password: password, email: email, nickname: fName, last_name: lName, first_name: fName, phone_number: phoneNum)
                
                viewModel.sinUpUser(model: model) { }
            } label: {
                HStack {
                    Spacer()
                    
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.poppins(weight: .semibold, size: 18))
                    
                    Spacer()
                }
                .padding(.vertical, 15)
                .background(Color.orange)
                .cornerRadius(8)
                .padding(.horizontal, 15)
            }
            .padding(.top, 32)
            
            HStack(spacing: 3) {
                Spacer()
                
                Text("Already have an account?")
                    .foregroundStyle(.white)
                    .font(.poppins(weight: .medium, size: 14))
                
                Button {
                    HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
                    router.pop()
                } label: {
                    Text("Log In")
                        .foregroundStyle(Color.COLOR_9178_A_8)
                        .font(.poppins(weight: .medium, size: 14))
                }
                
                Spacer()
            }
        }
    }
    
    //MARK: - Functions
    @ViewBuilder
    func makeTextField(title: String, txtStr: Binding<String>) -> some View {
        TextField(title, text: txtStr)
            .font(.poppins(weight: .regular, size: 18))
            .padding()
            .background(Color.white.opacity(0.8))
            .cornerRadius(8)
            .autocapitalization(.none)
            .padding(.horizontal)
    }
}

#Preview {
    SignUpScreen()
}
