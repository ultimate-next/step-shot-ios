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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepLabel.text = "Hello World"
        startStepCounting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    let pedometer = CMPedometer()
    @IBOutlet var stepLabel: UILabel!

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

