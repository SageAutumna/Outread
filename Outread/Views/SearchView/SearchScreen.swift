//
//  SearchScreen.swift
//  Outread
//
//  Created by AKASH BOGHANI on 25/05/24.
//

import SwiftUI

struct SearchScreen: View {
    //MARK: - Properties
    @ObservedObject private var searchViewModel = SearchScreenViewModel()
    @State var isLoading: Bool = true
    
    private var data  = ["AI techniques", "Mind over mute", "Human Centromeres", "Machine learining", "Surgery anxiety", "Nature's network in computing"]
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                searchSection
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 24) {
                        if searchViewModel.searchText.isEmpty {
                            LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                                ForEach(data, id: \.self) { item in
                                    VStack(spacing: 10) {
                                        Button {
                                            searchViewModel.searchText = item
                                        } label: {
                                            HStack(spacing: 10) {
                                                Image(.icSearch)
                                                    .resizable()
                                                    .frame(width: 16, height: 16)
                                                    .foregroundStyle(.white.opacity(0.7))
                                                
                                                Text(item)
                                                    .foregroundStyle(.white.opacity(0.7))
                                                    .font(.poppins(weight: .medium, size: 15))
                                                    .multilineTextAlignment(.leading)
                                                
                                                Spacer()
                                            }
                                        }
                                        
                                        Divider()
                                            .frame(height: 2)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                        }
                        
                        if let arrProduct = searchViewModel.product, !arrProduct.isEmpty {
                            LazyVStack(spacing: 16) {
                                ForEach(arrProduct, id: \.id) { product in
                                    ProductView(product: product)
                                        .redacted(reason: (searchViewModel.isLoading || isLoading) ? .placeholder : [])
                                        .onAppear(perform: {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                                isLoading = false
                                            }
                                        })
                                }
                            }
                        } else {
                            Text("Couldn't find anything relevant")
                                .foregroundStyle(.white.opacity(0.7))
                                .font(.poppins(weight: .medium, size: 15))
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
        }
        .onAppear {
            searchViewModel.setupDebounce()
        }
//        .hud(isLoading: $searchViewModel.isLoading)
    }
    
    var searchSection: some View {
        HStack(spacing: 10) {
            TextField(text: $searchViewModel.searchText) {
                Text("Search")
                    .foregroundStyle(.white.opacity(0.7))
                    .font(.poppins(weight: .medium, size: 18))
            }
            .foregroundStyle(.white.opacity(0.7))
            .font(.poppins(weight: .medium, size: 18))
            .padding(.leading, 16)
            
            Button {} label: {
                Image(.icSearch)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 16)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.white.opacity(0.3))
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
    }
    
    //MARK: - Functions
}

#Preview {
    SearchScreen()
}
