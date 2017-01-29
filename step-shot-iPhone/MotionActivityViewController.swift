//
//  MotionActivityViewController.swift
//  step-shot-iPhone
//
//  Created by Syoko Matsumura on 2017/01/29.
//  Copyright © 2017年 ultimate-next. All rights reserved.
//

import Foundation
import CoreMotion
import UIKit

class MotionActibityViewController: UIViewController {

    let pedometer = CMPedometer()
    
    func startStepCounting() {
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: {
                [weak self] (data: CMPedometerData?, error: NSError?) -> Void in
                // 歩数が更新されるたびに呼ばれる
                dispatch_async(dispatch_get_main_queue(), {
                    if data != nil && error == nil {
                        self?.stepLabel.text = "step: \(data!.numberOfSteps)"
                    }
                })
            })
        })
    }
}
