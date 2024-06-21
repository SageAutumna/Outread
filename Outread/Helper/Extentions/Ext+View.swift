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

// MARK: - HUD Hide & Show
extension View {
    func hud(isLoading: Binding<Bool>) -> some View {
        ZStack {
             self
            
            if isLoading.wrappedValue {
                ZStack {
                    HUDView(showHUD: isLoading)
                }
                .ignoresSafeArea()
            }
        }
    }
}
