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
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stepLabel.text = "0 歩"
        startStepCounting() // 歩数カウントの有効化
        enableNotification() // ローカル通知を使えるようにする
        enableLocationManager() // バックグラウンドで位置情報更新毎にdidUpdateLocationsイベントが呼ばれるようにする
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        pedometer.stopUpdates()
    }

    let pedometer = CMPedometer()
    var locationManager: CLLocationManager!
    var step_count: Int = 0
    @IBOutlet var stepLabel: UILabel!
    
    /* ------------------------------
        CoreMotion関連の処理
     --------------------------------*/

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
                self.step_count = Int(exData.numberOfSteps)
                self.stepLabel.text = "\(self.step_count) 歩"
            })
        })
    }
    

    /* ------------------------------
        UserNotifications関連の処理
     --------------------------------*/

    func enableNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            if error != nil {
                return
            }
            
            if granted {
                print("通知許可")
            } else {
                print("通知拒否")
            }
        })
    }
    
    
    func reserveNotification() {
        let content = UNMutableNotificationContent()
        content.title = "step-shot"
        content.subtitle = "おめでとうございます！"
        content.body = "\(step_count)歩、歩きました！"
        content.sound = UNNotificationSound.default()
        
        // 1秒後に発火(強制的にローカル通知を発火させる)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "1Second",
                                            content: content,
                                            trigger: trigger)
        
        // ローカル通知予約
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    
    /* ------------------------------
        CoreLocation関連の処理
     --------------------------------*/
    
    func enableLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.distanceFilter = 1; // 1m毎に発火させる
            locationManager.allowsBackgroundLocationUpdates = true // バックグラウンドで位置情報を監視する
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways, .authorizedWhenInUse:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last,
            CLLocationCoordinate2DIsValid(newLocation.coordinate) else {
                print("Error: location update")
                return
        }
        
        // TODO: 現状、更新毎にローカル通知が発行されてうざいので、実際はxxx歩を達成する毎に呼ぶようにする
        reserveNotification()
    }
}
