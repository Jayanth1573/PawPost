//
//  AnalyticsService.swift
//  PawPost
//
//  Created by Jayanth Ambaldhage on 16/10/24.
//

import Foundation
import FirebaseAnalytics

class AnalyticsService {
    static let instance = AnalyticsService()
    
    func likePostDoubleTap() {
        Analytics.logEvent("like_double_tap", parameters: nil)
    }
    
    func likePostHeartPressed() {
        Analytics.logEvent("like_heart_clicked", parameters: nil)
    }
}
