//
//  ViewController.swift
//  alarm_practice
//
//  Created by YOONJONG on 2021/08/24.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let timeSelector:Selector = #selector(ViewController.updateTime)
    let interval = 0.1
    var count = 0
    
    @IBOutlet weak var lblCurrentTime: UILabel!
    @IBOutlet weak var lblPickerTime: UILabel!
    
    var pickerTime = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, Error in
            print(didAllow)
        })
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender;
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblPickerTime.text = "선택시각 : " + formatter.string(from: datePickerView.date)
        
        let alarmformatter = DateFormatter()
        alarmformatter.dateFormat = "hh:mm aaa"
        pickerTime = alarmformatter.string(from: datePickerView.date)
        
    }
    @objc func updateTime(){
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재시각 : " + formatter.string(from: date as Date)
        
        let alarmformatter = DateFormatter()
        alarmformatter.dateFormat = "hh:mm aaa"
        
        if (alarmformatter.string(from: date as Date) == pickerTime){
            view.backgroundColor = UIColor.orange
            
            let content = UNMutableNotificationContent()
            content.title = "Alarm App Practice"
            content.subtitle = "GitHub에 커밋할 시각이에요."
            content.body = "얼른 하세요!"
            content.badge = 1
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: "commitalert", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        } else {
            view.backgroundColor = UIColor.yellow
        }
    }
}

