//
//  OnboardingView.swift
//  Outread
//
//  Created by AKASH BOGHANI on 08/06/24.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Properties
    @State private var currentPage = 0
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $currentPage) {
                
                ExplainerView1(currentPage: $currentPage)
                    .tag(0)
                
                ExplainerView2(currentPage: $currentPage)
                    .tag(1)
                
                LoginView ()
                    .tag(2)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    //MARK: - Functions
}

#Preview {
    OnboardingView()
}
