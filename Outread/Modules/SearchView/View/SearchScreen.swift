//
//  SearchScreen.swift
//  Outread
//
//  Created by AKASH BOGHANI on 25/05/24.
//

import SwiftUI
import SwiftData
import Combine

struct SearchScreen: View {
    // MARK: - Properties
    @State private var searchText: String = ""
    @State private var isLoading: Bool = true
    
    private let searchTextPublisher = PassthroughSubject<String, Never>()
    private let adaptiveColumn = [GridItem(.adaptive(minimum: 150))]

    @EnvironmentObject private var router: Router<AppRoutes>
    @ObservedObject private var searchViewModel = SearchScreenViewModel()
    @Environment(\.modelContext) private var context
    @Query private var bookmarksList: [LocalDataStorage]

    private let data = ["AI techniques", "Mind over mute", "Human Centromeres", "Machine learning", "Surgery anxiety", "Nature's network in computing"]

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            headerView
            
            contentView
                .padding([.bottom, .leading, .trailing], 15)
        }
        .hideKeyboardWhenTappedAround()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.COLOR_141_D_2_A)
        .onAppear {
            searchViewModel.fetchProduct(query: "")
        }
        .onChange(of: searchText) { newText in
            searchTextPublisher.send(newText)
        }
        .onReceive(searchTextPublisher.debounce(for: .milliseconds(1500), scheduler: DispatchQueue.main)) { debouncedText in
            searchViewModel.fetchProduct(query: debouncedText)
        }
    }

    private var contentView: some View {
        VStack(spacing: 16) {
            searchSection
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    if searchText.isEmpty {
                        LazyVGrid(columns: adaptiveColumn, spacing: 20) {
                            ForEach(data, id: \.self) { item in
                                VStack(spacing: 10) {
                                    Button {
                                        HapticManager.generateHapticFeedback(for: .impact(feedbackStyle: .light))
                                        searchText = item
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
                                ProductView(product: product) {
                                    bookmarkProduct(product)
                                }
                                .redacted(reason: (searchViewModel.isLoading || isLoading) ? .placeholder : [])
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        isLoading = false
                                    }
                                }
                                .onTapGesture {
                                    router.push(.flashcardMain(product: product, categories: []))
                                }
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
                .padding(.bottom, ((UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0) + 35))
            }
        }
    }

    private var headerView: some View {
        Text("Search")
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

    private var searchSection: some View {
        HStack(spacing: 10) {
            TextField("Search", text: $searchText)
                .foregroundStyle(.white.opacity(0.7))
                .font(.poppins(weight: .medium, size: 18))
                .padding(.leading, 16)
                .disabled(searchViewModel.isLoading)
            
            Button {} label: {
                Image(.icSearch)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 15)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(Color.white.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }

    // MARK: - Functions
    private func bookmarkProduct(_ product: Product) {
        let item = LocalDataStorage(id: product.id ?? 0, name: product.name ?? "", shortDescription: product.shortDescription ?? "", categories: product.categories ?? [], images: product.images ?? [], metaData: product.metaData ?? [], descData: product.desc ?? "")
        
        if let existingIndex = bookmarksList.firstIndex(where: { $0.id == item.id }) {
            context.delete(bookmarksList[existingIndex])
        } else {
            context.insert(item)
        }
        
        do {
            try context.save()
        } catch {
            UIApplication.keyWindow?.rootViewController?.showAlert(msg: error.localizedDescription)
        }
    }
}

#Preview {
    SearchScreen()
}
