//
//  LocalNotificationCenter.swift
//  WaterAlarm
//
//  Created by LeeHsss on 2022/01/29.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequset(by alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에요~"
        content.body = "세계보건기구(WHO)가 권장하는 하루 물 섭취량은 1.5~2L 입니다."
        content.sound = .default
        content.badge = 1
        
        let dateComponet = Calendar.current.dateComponents([.hour, .minute], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponet, repeats: alarm.isOn)
        
        let request = UNNotificationRequest(identifier: alarm.id, content: content, trigger: trigger)
        
        self.add(request, withCompletionHandler: nil)
    }
}
