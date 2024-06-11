//
//  ProductView.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import SwiftUI

struct ProductView: View {
    //MARK: - Properties
    @State var product: Product
    
    //MARK: - Body
    var body: some View {
        let readingTime: String = product.metaData?.first(where: { $0.key == "reading-time" })?.value ?? "0"
        
        HStack(spacing: 16) {
            
            kfImage(from: URL(string: product.images?.first?.src ?? ""))
                .resizable()
                .frame(width: 100, height: 150)
                .clipShape(
                    RoundedRectangle(cornerRadius: 8)
                )
                .padding(.leading, 16)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 10) {
                    Text(product.name ?? "")
                        .foregroundStyle(.white)
                        .font(.poppins(weight: .medium, size: 13))
                    
                    Spacer()
                    
                    Button {} label: {
                        Image(.icBookmark)
                            .resizable()
                            .frame(width: 20, height: 30)
                    }
                }
                
                Text(product.desc?.stripOutHtml() ?? "")
                    .foregroundStyle(.white.opacity(0.7))
                    .font(.poppins(weight: .medium, size: 11))
                    .lineLimit(4)
                    .padding(.bottom, 12)
                
                HStack(spacing: 8) {
                    Text("\(readingTime) min")
                        .foregroundStyle(.white.opacity(0.7))
                        .font(.poppins(weight: .medium, size: 11))
                        .padding(.all, 4)
                        .background(Color.COLOR_4_B_7_E_68)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 4)
                        )
                    
                    Image(.icListen)
                        .padding(.all, 8)
                        .background(Color.COLOR_4_B_7_E_68)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 4)
                        )
                }
                .frame(height: 12)
            }
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity)
            
        }
        .padding(.vertical, 16)
        .background(Color.COLOR_27394_F)
        .clipShape(
            RoundedRectangle(cornerRadius: 14)
        )
    }
    
    //MARK: - Functions
}

#Preview {
    ProductView(product: Product(id: 0,
                                 name: "Eco-Friendly Recyclable Resins for 3D Printing",
                                 permalink: "",
                                 desc: "",
                                 shortDescription: "",
                                 status: "",
                                 price: "",
                                 categories: [],
                                 images: [],
                                 metaData: []))
    .frame(height: 150)
    .padding(.horizontal, 20)
}
