import SwiftUI

struct FlashcardView: View {
    // MARK: - Properties
    @EnvironmentObject private var router: Router<AppRoutes>
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel = FlashcardMainVm()
    
    @State private var currentSectionIndex = 0
    
    let productName: String
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            contentView
                .padding(.top, 16)
        }
        .redacted(reason: viewModel.isLoading ? .placeholder : [])
        .navigationTitle("Article")
        .navigationBarColor(backgroundColor: .COLOR_141_D_2_A, titleColor: .white)
        .task {
            viewModel.loadArticle(name: productName)
        }
    }
    
    private var contentView: some View {
        Color.COLOR_27394_F
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            .overlay {
                if !viewModel.list.isEmpty {
                    articalView
                } else {
                    VStack(spacing: 10) {
                        Text("Test Tes Test Test Test")
                            .foregroundColor(Color.white)
                            .font(.poppins(weight: .medium, size: 27))
                            .multilineTextAlignment(.center)
                        
                        Text("Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test Test Tes Test Test Test")
                            .foregroundColor(Color.white)
                            .font(.poppins(weight: .regular, size: 17))
                        
                        Spacer()
                    }
                    .padding(.bottom, 40)
                    .padding(.top, 10)
                    .padding(.horizontal, 32)
                }
            }
    }
    
    private var articalView: some View {
        TabView {
            ForEach(viewModel.list, id: \.self) { listData in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        Text(listData.str1)
                            .foregroundColor(Color.white)
                            .font(.poppins(weight: .medium, size: 27))
                            .multilineTextAlignment(.center)
                        
                        Text(listData.str2)
                            .foregroundColor(Color.white)
                            .font(.poppins(weight: .regular, size: 17))
                    }
                }
                .padding(.bottom, 40)
                .padding(.top, 10)
            }
        }
        .padding(.horizontal, 32)
        .tabViewStyle(.page(indexDisplayMode: .automatic))
    }
    
    // MARK: - Functions
}
