//
//  Alarm.swift
//  WaterAlarm
//
//  Created by LeeHsss on 2022/01/29.
//

import UIKit

struct Alarm: Codable {
    let id: String = UUID().uuidString
    let date: Date
    var isOn: Bool
    
    var ampm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter.string(from: date)
    }
    
    var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: date)
    }
}
