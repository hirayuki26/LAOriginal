//
//  DetailViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    let realm = try! Realm()
    
    var storydetail: Story!
    var objyear: Year!
    var objindex: Int!
    
    @IBOutlet var whenLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!
    @IBOutlet var showImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        memoLabel.layer.borderWidth = 0.1
        memoLabel.layer.cornerRadius = 5.0
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        whenLabel.text = "\(formatter.string(from: storydetail.when))"
        
        titleLabel.text = storydetail.title
        categoryLabel.text = storydetail.category
        memoLabel.text = storydetail.memo
        
        if storydetail.imageURL != "" {
            let filename = storydetail.imageURL
            let newImage = UIImage.getFromDocuments(filename: filename)
            showImageView.image = newImage
        } else {
            showImageView.image = nil
        }
        
        print(showImageView.image)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        whenLabel.text = "\(formatter.string(from: storydetail.when))"
        
        titleLabel.text = storydetail.title
        categoryLabel.text = storydetail.category
        memoLabel.text = storydetail.memo
        
        if storydetail.imageURL != "" {
            let filename = storydetail.imageURL
            let newImage = UIImage.getFromDocuments(filename: filename)
            showImageView.image = newImage
        } else {
            showImageView.image = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEdit" {
            guard let destination = segue.destination as? EditViewController else {
                fatalError("Failed to prepare EditViewController.")
            }
            
            destination.editstory = storydetail
            destination.edityear = objyear
            destination.editindex = objindex
        }
    }
    
    @IBAction func unwindToDetailController(segue: UIStoryboardSegue) {
    }
    
    @IBAction func delete() {
        try! realm.write {
            objyear.stories.remove(at: objindex)
        }
        performSegue(withIdentifier: "deleteStory", sender: nil)
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

