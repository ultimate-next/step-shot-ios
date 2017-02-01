//
//  NotificationManager.swift
//  step-shot-iPhone
//
//  Created by Syoko Matsumura on 2017/01/31.
//  Copyright © 2017年 ultimate-next. All rights reserved.
//

import Foundation
import UIKit

public class NotificationManager: NSObject {
    
    func setNotification(
        timeZone: NSTimeZone? = nil,
        repeatInterval: NSCalendarUnit = NSCalendarUnit.init(rawValue: 0),
        repeatCalendar: NSCalendar? = nil,
        alertAction: String? = nil,
        alertBody: String? = nil,
        alertTitle: String? = nil,
        hasAction: Bool = true,
        applicationIconBadgeNumber: Int = 0,
        soundName: String? = nil,
        userInfo: NSDictionary? = nil)
    {
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
}
