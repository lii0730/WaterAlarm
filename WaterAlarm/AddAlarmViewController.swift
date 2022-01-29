//
//  AddAlarmViewController.swift
//  WaterAlarm
//
//  Created by LeeHsss on 2022/01/29.
//

import UIKit

class AddAlarmViewController: UIViewController {
    
    var dataSendClosure: ((Alarm) -> Void)?
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveAlarmButton(_ sender: UIBarButtonItem) {
        let newAlarm = Alarm(date: datePicker.date, isOn: true)
        dataSendClosure?(newAlarm)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAlarmButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
