//
//  TabItem.swift
//  Outread
//
//  Created by AKASH BOGHANI on 09/06/24.
//

import SwiftUI

enum TabItem: CaseIterable {
    case home, search, bookmark, settings
    
    var image: Image {
        switch self {
        case .home:
            return Image(.tabHome)
        case .search:
            return Image(.tabSearch)
        case .bookmark:
            return Image(.tabBookmark)
        case .settings:
            return Image(.tabSettings)
        }
    }
}
