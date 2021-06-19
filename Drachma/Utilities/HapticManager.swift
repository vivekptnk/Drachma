//
//  HapticManager.swift
//  Drachma
//
//  Created by Vivek Pattanaik on 6/19/21.
//

import Foundation
import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type : UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
