//
//  AddViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    let realm = try! Realm()
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var categoryTextField: UITextField!
    @IBOutlet var flagTextField: UITextField!
    @IBOutlet var whenTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    @IBOutlet var photoTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        whenTextField.inputView = datePicker
        
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        whenTextField.inputView = datePicker
        whenTextField.inputAccessoryView = toolbar
        
        // Do any additional setup after loading the view.
    }
    
    @objc func done() {
        whenTextField.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        whenTextField.text = "\(formatter.string(from: datePicker.date))"
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
