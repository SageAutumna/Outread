//
//  Ext+Numbers.swift
//  Outread
//
//  Created by AKASH BOGHANI on 20/06/24.
//

import UIKit

// MARK: - Int
extension Int {
    var asDeviceHeight: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.size.height / 812
    }

    var asDeviceWidth: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.size.width / 430
    }
}

// MARK: - Double
extension Double {
    var asDeviceHeight: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.size.height / 812
    }

    var asDeviceWidth: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.size.width / 430
    }
}

// MARK: - Float
extension Float {
    var asDeviceHeight: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.size.height / 812
    }

    var asDeviceWidth: CGFloat {
        CGFloat(self) * UIScreen.main.bounds.size.width / 430
    }
}

// MARK: - CGFloat
extension CGFloat {
    var asDeviceHeight: CGFloat {
        self * UIScreen.main.bounds.size.height / 812
    }

    var asDeviceWidth: CGFloat {
        self * UIScreen.main.bounds.size.width / 430
    }
}
