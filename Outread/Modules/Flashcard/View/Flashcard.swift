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
            
            VStack {
                makeNavBar(title: "Article", isBackButtonHidden: true) {}
                
                contentView
                    .redacted(reason: viewModel.isLoading ? .placeholder : [])
            }
        }
        .gesture(dragGesture)
        .task {
            viewModel.loadArticle(name: productName)
        }
    }
    
    private var contentView: some View {
        ZStack {
            Color.COLOR_27394_F
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading, spacing: 0) {
                if !viewModel.list.isEmpty {
                    Text(viewModel.list[currentSectionIndex].str1)
                        .foregroundColor(Color.white)
                        .font(.poppins(weight: .medium, size: 30))
                        .padding(.bottom, 10)
                        .padding(.horizontal, 25)
                    
                    ScrollView(showsIndicators: false) {
                        Text(viewModel.list[currentSectionIndex].str2)
                            .foregroundColor(Color.white)
                            .font(.poppins(weight: .regular, size: 20))
                            .padding(.horizontal, 25)
                    }
                    .padding(.bottom, 10)
                } else {
                    VStack(alignment: .center, spacing: 0) {
                        Text("Contrary to popular belief, Lorem Ipsum is not simply random text.")
                            .foregroundColor(Color.clear)
                            .font(.poppins(weight: .medium, size: 30))
                            .padding(.bottom, 10)
                            .padding(.horizontal, 25)
                        
                        
                        Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")
                            .font(.poppins(weight: .medium, size: 25))
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 23)
                        
                        Spacer()
                    }
                }
            }
            .padding([.vertical, .bottom], 15)
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                switch (value.translation.width, value.translation.height) {
                case (...0, -30...30):
                    if currentSectionIndex < viewModel.list.count - 1 {
                        currentSectionIndex += 1
                    }
                case (0..., -30...30):
                    if currentSectionIndex == 0 {
                        dismiss()
                    } else {
                        currentSectionIndex -= 1
                    }
                default:
                    break
                }
            }
    }
    
    // MARK: - Functions
}
