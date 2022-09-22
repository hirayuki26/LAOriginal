//
//  AddYearViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/22.
//

import UIKit
import RealmSwift

class AddYearViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let realm = try! Realm()
    
//    @IBOutlet var yearTextField: UITextField!
    @IBOutlet var yearTextLabel: UILabel!
    @IBOutlet var pickerView: UIPickerView!
    
    let years = (1950...2030).map { $0 }
    
//    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()

//        datePicker.datePickerMode = UIDatePicker.Mode.date
//        datePicker.timeZone = NSTimeZone.local
//        datePicker.locale = Locale.current
//        yearTextField.inputView = datePicker
//
//        datePicker.preferredDatePickerStyle = .wheels
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        yearTextLabel.text = String(years[0])
        
//        yearTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
//
//        let yearPickerView = UIPickerView()
//        yearPickerView.delegate = self
//        yearPickerView.delegate = self
//        yearTextField.inputView = yearPickerView
        
//        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
//        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
//        toolbar.setItems([spacelItem, doneItem], animated: true)
        
    
//        yearTextField.inputView = datePicker
//        yearTextField.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
    }
    
//    @objc func done() {
//        yearTextField.endEditing(true)
//
////        let formatter = DateFormatter()
////        formatter.dateFormat = "yyyy-MM-dd"
////
////        yearTextField.text = "\(formatter.string(from: datePicker.date))"
//    }
//
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
        
        let newYear = Year()
        newYear.displeyName = Int(yearTextLabel.text ?? 2022!)
        
        print("あ")
        
        try! realm.write {
            realm.add(newYear)
            print(newYear.displeyName)
            print("success")
        }
        
        performSegue(withIdentifier: "AddYear", sender: nil)
    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0 {
//            return "\(years[row])年"
//        } else {
//            return nil
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        let year = years[pickerView.selectedRow(inComponent: 0)]
//        yearTextField.text = "\(year)年"
//    }
//
//    func setKeyboardAccessory() {
//        let keyboardAccessory = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
//        keyboardAccessory.backgroundColor = UIColor.white
//        yearTextField.inputAccessoryView = keyboardAccessory
//
//        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: keyboardAccessory.bounds.size.width, height: 0.5))
//        topBorder.backgroundColor = UIColor.lightGray
//        keyboardAccessory.addSubview(topBorder)
//
//        let completeButton = UIButton(frame: CGRect(x: keyboardAccessory.bounds.size.width - 48, y: 0, width: 48, height: keyboardAccessory.bounds.size.height - 0.5 * 2))
//        completeButton.setTitle("完了", for: UIControl.State())
//        completeButton.setTitleColor(UIColor.red, for: .highlighted)
//        completeButton.addTarget(self, action: Selector(("hidePickerView")), for: .touchUpInside)
//        keyboardAccessory.addSubview(completeButton)
//
//        let bottomBorder = UIView(frame: CGRect(x: 0, y: keyboardAccessory.bounds.size.height - 0.5, width: keyboardAccessory.bounds.size.width, height: 0.5))
//        bottomBorder.backgroundColor = UIColor.lightGray
//        keyboardAccessory.addSubview(bottomBorder)
//    }
//
//    func hidePickerView() {
//        yearTextField.resignFirstResponder()
//    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
