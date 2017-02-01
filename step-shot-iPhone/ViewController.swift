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
        stepLabel.text = "0 歩"
        startStepCounting()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pedometer.stopUpdates()
    }

    let pedometer = CMPedometer()
    @IBOutlet var stepLabel: UILabel!
  
    func startStepCounting() {
        let now = Date()    // 現在時間
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month, .day], from: now)
        let today = calendar.date(from: components) // 今日の0時
        
        self.pedometer.startUpdates(from: today!, withHandler: {
            (data: CMPedometerData?, error: Error?) in
            DispatchQueue.main.async(execute: { () in
                guard let exData = data, error == nil else {
                    // 取得できなかった場合ここで抜ける
                    return
                }
                // 歩数取得
                self.stepLabel.text = "\(exData.numberOfSteps) 歩"
            })
        })
    }
}
