import SwiftUI

struct FlashcardView: View {
    //MARK: - Properties
    @Environment(\.dismiss) var dismiss
    
    @State private var articleContent: String?
    @State private var currentSectionIndex = 0
    
    let productName: String
    var list: [ListType]
    
    //MARK: - Body
    var body: some View {
        ZStack {
            Color.COLOR_141_D_2_A.edgesIgnoringSafeArea(.all)
            
            ZStack {
                Color(UIColor(named: "COLOR_27394F")!)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                
                ZStack {
                    Group {
                        if !list.isEmpty {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(list[currentSectionIndex].str1)
                                    .foregroundColor(Color.white)
                                    .font(.poppins(weight: .medium, size: 30))
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 25)
                                
                            
                                ScrollView(showsIndicators: false) {
                                    Text(list[currentSectionIndex].str2)
                                        .foregroundColor(Color.white)
                                        .font(.poppins(weight: .regular, size: 20))
                                        .padding(.horizontal, 25)
                                    
                                }
                                .padding(.bottom, 10)
                            }
                        } else {
                            Text("Unable to load article")
                                .font(.poppins(weight: .medium, size: 25))
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(15)
            }
        }
        .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                switch (value.translation.width, value.translation.height) {
                case (...0, -30...30):  if currentSectionIndex < list.count - 1 {
                    currentSectionIndex = currentSectionIndex + 1
                }
                case (0..., -30...30):  if currentSectionIndex == 0 {
                    dismiss()
                    
                } else {
                    currentSectionIndex = currentSectionIndex - 1
                }
                default:  print("no clue")
                }
            }
    }
    
    //MARK: - Functions
}
