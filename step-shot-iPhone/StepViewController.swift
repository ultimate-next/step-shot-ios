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

class StepViewController: UIViewController {

    let pedometer = CMPedometer()
    @IBOutlet weak var stepLabel: UILabel!
    
    func startStepCounting() {
        if CMPedometer.isStepCountingAvailable() {
            self.pedometer.startUpdates(from: Date(), withHandler: {
                [weak self] (data: CMPedometerData?, error: NSError?) -> Void in
                DispatchQueue.main.async(execute: {
                    if data != nil && error == nil {
                        self?.stepLabel.text = "step: \(data!.numberOfSteps)"
                    }
                })
                } as! CMPedometerHandler)
        }
    }
}
