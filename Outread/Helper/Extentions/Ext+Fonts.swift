//
//  Ext+Fonts.swift
//  Outread
//
//  Created by AKASH BOGHANI on 25/05/24.
//

import SwiftUI

extension Font {
    static func poppins(weight: Font.Weight, size: CGFloat) -> Self {
        switch weight {
        case .black:
            return .custom("Poppins-Black", size: size)
        case .bold:
            return .custom("Poppins-Bold", size: size)
        case .light:
            return .custom("Poppins-Light", size: size)
        case .medium:
            return .custom("Poppins-Medium", size: size)
        case .regular:
            return .custom("Poppins-Regular", size: size)
        case .semibold:
            return .custom("Poppins-SemiBold", size: size)
        case .thin:
            return .custom("Poppins-Thin", size: size)
        default:
            fatalError("No font found")
        }
    }
}
