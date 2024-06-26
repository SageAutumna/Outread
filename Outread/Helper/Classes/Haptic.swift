//
//  Haptic.swift
//  Outread
//
//  Created by AKASH BOGHANI on 25/06/24.
//

import UIKit

class HapticManager {
    class func generateHapticFeedback(for hapticFeedback: HapticFeedback) {
        switch hapticFeedback {
        case .selection:
            let feedbackGenerator = UISelectionFeedbackGenerator()
            feedbackGenerator.selectionChanged()
        case let .impact(feedbackStyle):
            let feedbackGenerator = UIImpactFeedbackGenerator(style: feedbackStyle)
            feedbackGenerator.impactOccurred()
        case let .notification(feedbackType):
            let feedbackGenerator = UINotificationFeedbackGenerator()
            feedbackGenerator.notificationOccurred(feedbackType)
        }
    }

    // MARK: - HapticFeedback
    enum HapticFeedback {
        case selection
        case impact(feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle)
        case notification(feedbackType: UINotificationFeedbackGenerator.FeedbackType)
    }
}
