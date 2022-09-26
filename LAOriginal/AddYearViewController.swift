//
//  AddYearViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/22.
//

import UIKit
import RealmSwift
import DropDown

class AddYearViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    
    @IBOutlet var yearTextLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    let years = (1950...2030).map { $0 }
    
    let newYear = Year()
    
//    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        yearTextLabel.text = String(years[0])
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
//
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return String(years[row])
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        yearTextLabel.text = String(years[row])
    }
    
    @IBAction func done() {
        
        print("あ")
        newYear.displayName = Int(yearTextLabel.text!)!
        
        let sameyear = realm.objects(Year.self).filter("displayName == \(newYear.displayName)")
        print(sameyear.count)
        
        if sameyear.count != 0 {
            let alert: UIAlertController = UIAlertController(title: "追加エラー", message: "すでに追加されています", preferredStyle: .alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "別の年を追加",
                    style: .default,
                    handler: { action in
                        print("push OK button")
                    }
                )
            )
            present(alert, animated: true, completion: nil)
        } else {
            try! realm.write {
                realm.add(newYear)
                print(newYear.displayName)
                print("success")
            }
            
            performSegue(withIdentifier: "AddYear", sender: nil)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
