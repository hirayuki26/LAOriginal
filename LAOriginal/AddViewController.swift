//
//  AddViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import UIKit
import RealmSwift
import DropDown

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let realm = try! Realm()
    
    var addstory: Year!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var dropdownView: UIView!
    @IBOutlet var categoryLabel: UILabel!
    //@IBOutlet var flagTextField: UITextField!
    @IBOutlet var whenTextField: UITextField!
    @IBOutlet var memoTextView: UITextView!
    
    @IBOutlet var photoImageView: UIImageView!
    
    var datePicker: UIDatePicker = UIDatePicker()
    
    let dropDown = DropDown()
    let categoryValues = ["カテゴリなし", "思い出", "職歴", "資格"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.layer.borderWidth = 0.1
        memoTextView.layer.cornerRadius = 5.0
        
        dropdownView.layer.borderWidth = 0.1
        dropdownView.layer.cornerRadius = 5.0
        
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        
        let minDateString = String(addstory.displayName) + "-01-01"
        let maxDateString = String(addstory.displayName) + "-12-31"

        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        var minDate = dateFormatter.date(from: minDateString)
        var maxDate = dateFormatter.date(from: maxDateString)

        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        
        whenTextField.inputView = datePicker
        
        datePicker.preferredDatePickerStyle = .wheels
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        
        whenTextField.inputView = datePicker
        whenTextField.inputAccessoryView = toolbar
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        whenTextField.text = "\(formatter.string(from: datePicker.date))"
        
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
    
    @IBAction func openAlbum() {        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = info[.editedImage] as? UIImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save() {
        let newstory = Story()
        
        newstory.title = titleTextField.text!
        newstory.category = categoryLabel.text!
        newstory.when = datePicker.date
        newstory.memo = memoTextView.text!
        
        if photoImageView.image != nil {
            let image = photoImageView.image!
            let filename = UUID.init().uuidString + ".jpg"
            newstory.imageURL = filename
            image.saveToDocuments(filename: filename)
        }
        
        if titleTextField.text == Optional("") {
            let alert: UIAlertController = UIAlertController(title: "保存エラー", message: "タイトルを入力してください", preferredStyle: .alert)
            
            alert.addAction(
                UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: { action in
                        print("push OK button")
                    }
                )
            )
            present(alert, animated: true, completion: nil)
        } else {
            try! realm.write {
                addstory.stories.append(newstory)
            }
            
            print("addstory")
            
            performSegue(withIdentifier: "AddStory", sender: nil)
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
