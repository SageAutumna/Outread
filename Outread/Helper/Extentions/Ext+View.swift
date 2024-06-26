//
//  Ext+View'.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import SwiftUI
import Kingfisher

// MARK: - KFImage
extension View {
    func kfImage(from url: URL?, placeHolderImage: Image = Image(systemName: "photo")) -> KFImage {
        KFImage.url(url)
            .resizable()
            .placeholder {
                placeHolderImage
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )
                    .redacted(reason: .placeholder)
            }
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.5)
    }
}

extension View {
    func makeNavBar(title: String, isBackButtonHidden: Bool = false, didTapBack: @escaping () -> Void) -> some View {
        ZStack {
            if !isBackButtonHidden {
                HStack {
                    Button {
                        didTapBack()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.backward")
                                .tint(.white)
                            
                            Text("Back")
                                .font(.poppins(weight: .regular, size: 16))
                                .foregroundColor(.white)
                        }
                    }
                    
                    Spacer()
                }
            }
            
            Text(title)
                .font(.poppins(weight: .regular, size: 20))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 15)
        .frame(height: 55.asDeviceHeight)
    }
}
