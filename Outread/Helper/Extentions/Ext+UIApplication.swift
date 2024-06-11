//
//  Ext+UIApplication.swift
//  Outread
//
//  Created by AKASH BOGHANI on 26/05/24.
//

import UIKit

extension UIApplication {
    static var keyWindow: UIWindow? {
        shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.last
    }
}
