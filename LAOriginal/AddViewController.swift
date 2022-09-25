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
    
    // ドキュメントディレクトリの「ファイルURL」（URL型）定義
    var documentDirectoryFileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    // ドキュメントディレクトリの「パス」（String型）定義
    let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]

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
    
    @IBAction func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
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
        
        let image = photoImageView.image!
        print(type(of: image))
        print(image)
        let filename = UUID.init().uuidString + ".jpg"
        newstory.imageURL = filename
        image.saveToDocuments(filename: filename)
        
//        try newstory.imageURL = documentDirectoryFileURL.absoluteString
        
        try! realm.write {
            addstory.stories.append(newstory)
        }
        
        print("addstory")
        
        performSegue(withIdentifier: "AddStory", sender: nil)
    }
    
//    //保存するためのパスを作成する
//    func createLocalDataFile() {
//        // 作成するテキストファイルの名前
//        let fileName = "\(NSUUID().uuidString).png"
//
//        // DocumentディレクトリのfileURLを取得
//        if documentDirectoryFileURL != nil {
//            // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
//            let path = documentDirectoryFileURL.appendingPathComponent(fileName)
//            documentDirectoryFileURL = path
//        }
//    }
//
//    //画像を保存する関数の部分
//    func saveImage() {
//        createLocalDataFile()
//        //pngで保存する場合
//        let pngImageData = photoImageView.image?.pngData()
//        do {
//            try pngImageData!.write(to: documentDirectoryFileURL)
//        } catch {
//            //エラー処理
//            print("エラー")
//        }
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

extension UIImage {
    func saveToDocuments(filename: String) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        if let data = self.jpegData(compressionQuality: 1.0) {
            do {
                try data.write(to: fileURL)
            } catch {
                print(error)
            }
        }
    }
}
