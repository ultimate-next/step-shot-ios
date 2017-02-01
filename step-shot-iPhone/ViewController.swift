//
//  ViewController.swift
//  step-shot-iPhone
//
//  Created by Syoko Matsumura on 2017/01/29.
//  Copyright © 2017年 ultimate-next. All rights reserved.
//

import UIKit
import Foundation
import CoreMotion
import UserNotifications

class ViewController: UIViewController {
    let pedometer = CMPedometer()
    @IBOutlet var stepLabel: UILabel!
//    let shutterChanceMap = Dictionary(dictionaryLiteral: (_, _))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepLabel.text = "Hello World"
        startStepCounting()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pedometer.stopUpdates()
    }

    /**
     *  Start step count.
     **/
    func startStepCounting() {
        pedometer.startUpdates(from: NSDate() as Date, withHandler: { (data, error) -> Void in
            if error==nil {
                let myStep = data!.numberOfSteps
                self.stepLabel.text = "\(myStep) 歩"
            }
        })
    }
    
    /**
     *  Send sound notification that shutter chance each defined number.
     **/
    func sendShutterChanceNotification() {
        
    }

    /**
     * Judge notification target or not
     * @return bool
     */
    func isNotificationTarget() {
    }
}

