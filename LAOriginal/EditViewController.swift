//
//  EditViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/24.
//

import UIKit
import RealmSwift
import DropDown

class EditViewController: UIViewController {
    
    let realm = try! Realm()
    
//    var addstory: Year!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dropdownView: UIView!
    @IBOutlet var categoryLabel: UILabel!
    //@IBOutlet var flagTextField: UITextField!
    @IBOutlet var whenTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    //@IBOutlet var photoTextField: UITextField!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    let dropDown = DropDown()
    let categoryValues = ["なし", "思い出", "職歴", "資格"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.layer.borderWidth = 0.1
        memoTextView.layer.cornerRadius = 5.0
        
        dropdownView.layer.borderWidth = 0.1
        dropdownView.layer.cornerRadius = 5.0
        
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
        
        dropDown.anchorView = dropdownView // UIView or UIBarButtonItem
        dropDown.dataSource = categoryValues
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y:-(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.categoryLabel.text = categoryValues[index]
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func done() {
        whenTextField.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        whenTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    @IBAction func showCategoriesOptions() {
        dropDown.show()
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
