//
//  WaterAlarmCell.swift
//  WaterAlarm
//
//  Created by LeeHsss on 2022/01/29.
//

import UIKit

class WaterAlarmCell: UITableViewCell {

    @IBOutlet weak var AMPMLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var onoffSwitch: UISwitch!
    var userNotificationCenter = UNUserNotificationCenter.current()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func swithChanged(_ sender: Any) {
        
        guard let sender = sender as? UISwitch else { return }
        
        guard let data = UserDefaults.standard.object(forKey: "alarms") as? Data else { return }
        
        guard var dataList = try? PropertyListDecoder().decode([Alarm].self, from: data) else { return }
        
        dataList[sender.tag].isOn = sender.isOn
        
        if sender.isOn {
            userNotificationCenter.addNotificationRequset(by: dataList[sender.tag])
        } else {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [dataList[sender.tag].id])
        }
    
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(dataList), forKey: "alarms")
        
    }
}
