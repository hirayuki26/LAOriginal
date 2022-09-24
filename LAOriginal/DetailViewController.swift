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
    
    @IBOutlet var whenLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var memoLabel: UILabel!

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
        
        // Do any additional setup after loading the view.
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
