//
//  MainTabView.swift
//  Outread
//
//  Created by AKASH BOGHANI on 08/06/24.
//

import SwiftUI

struct MainTabView: View {
    // MARK: - Properties
    @State var selectedTab: TabItem = .home
    
    // MARK: - Life-Cycle
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                MainPageView()
                    .tag(TabItem.home)
                
                SearchScreen()
                    .tag(TabItem.search)
                
                BookmarkView()
                    .tag(TabItem.bookmark)
                
                SettingsView()
                    .tag(TabItem.settings)
            }
            
            HStack(spacing: 0) {
                ForEach(TabItem.allCases, id: \.self) { tab in
                    Button {
                        withAnimation(.spring()) {
                            HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
                            selectedTab = tab
                        }
                    } label: {
                        tab.image
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundStyle(selectedTab == tab ? Color.COLOR_86_AD_72 : Color.white)
                            .padding(selectedTab == tab ? 15 : 0)
                    }
                    .frame(width: 25, height: 30)
                    
                    if tab != TabItem.allCases.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.vertical)
            .background(Color.COLOR_141_D_2_A)
            .padding(.bottom, UIApplication.keyWindow?.safeAreaInsets.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // MARK: - Functions
}
