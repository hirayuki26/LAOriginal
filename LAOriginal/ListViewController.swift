//
//  ListViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController {
    
    let realm = try! Realm()
    
    var eachyear: Year!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "\(String(eachyear.displeyName))年"
        
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
