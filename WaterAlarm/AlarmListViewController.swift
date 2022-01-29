//
//  AlarmListViewController.swift
//  WaterAlarm
//
//  Created by LeeHsss on 2022/01/29.
//

import UIKit
import UserNotifications

class AlarmListViewController: UITableViewController {
    
    var alarmList: [Alarm] = []
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "WaterAlarmCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "WaterAlarmCell")

        self.alarmList = getList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func getList() -> [Alarm] {
        if UserDefaults.standard.object(forKey: "alarms") != nil {
            guard let data = UserDefaults.standard.object(forKey: "alarms") as? Data else { return [] }
            
            guard let dataList = try? PropertyListDecoder().decode([Alarm].self, from: data) else { return [] }
            
            return dataList
        } else { return [] }
    }

    @IBAction func addAlarmButton(_ sender: UIBarButtonItem) {
        guard let addAlarmVC = self.storyboard?.instantiateViewController(withIdentifier: "AddAlarmViewController") as? AddAlarmViewController else { return }
        
        addAlarmVC.dataSendClosure = { [weak self] alarm in
            guard let self = self else { return }
            
            self.alarmList.append(alarm)
            self.alarmList.sort { $0.date < $1.date }
            self.userNotificationCenter.addNotificationRequset(by: alarm)
            
            let data = try? PropertyListEncoder().encode(self.alarmList)
            UserDefaults.standard.set(data, forKey: "alarms")
            
            self.tableView.reloadData()
        }
        
        self.present(addAlarmVC, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return alarmList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WaterAlarmCell", for: indexPath) as? WaterAlarmCell else { return WaterAlarmCell()}

        cell.dateLabel.text = alarmList[indexPath.row].time
        cell.AMPMLabel.text = alarmList[indexPath.row].ampm
        cell.onoffSwitch.isOn = alarmList[indexPath.row].isOn
        cell.onoffSwitch.tag = indexPath.row

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "물마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alarmList[indexPath.row].id])
            alarmList.remove(at: indexPath.row)
            
            let data = try? PropertyListEncoder().encode(alarmList)
            UserDefaults.standard.set(data, forKey: "alarms")
            
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

}
