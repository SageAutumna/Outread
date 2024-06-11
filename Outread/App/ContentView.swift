//
//  ContentView.swift
//  Outread
//
//  Created by Dhruv Sirohi on 17/1/2024.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    //MARK: - Body
    var body: some View {
        Group {
//            if hasCompletedOnboarding {
//                MainTabView()
//            } else {
//                OnboardingView()
//            }
            
            MainTabView()
        }
    }
    
    //MARK: - Functions
}
