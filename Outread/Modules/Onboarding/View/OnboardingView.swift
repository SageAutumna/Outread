//
//  OnboardingView.swift
//  Outread
//
//  Created by AKASH BOGHANI on 08/06/24.
//

import SwiftUI

struct OnboardingView: View {
    //MARK: - Properties
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    @State private var currentPage = 0
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $currentPage) {
                
                ExplainerView1 {
                    withAnimation {
                        currentPage = 2
                    }
                } goToNext: {
                    withAnimation {
                        currentPage = 1
                    }
                }
                .tag(0)
                
                ExplainerView2 {
                    withAnimation {
                        goToNextPage()
                    }
                }
                .tag(1)
                
                LoginView {
                    withAnimation {
                        hasCompletedOnboarding = true
                    }
                }
                .tag(2)
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
    
    //MARK: - Functions
    private func goToNextPage() {
        if currentPage < 2 {
            currentPage += 1
        }
    }
}

#Preview {
    OnboardingView()
}
