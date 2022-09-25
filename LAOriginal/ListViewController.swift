//
//  ListViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let realm = try! Realm()
    
    @IBOutlet var storytable: UITableView!
    
    var eachyear: Year!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "\(String(eachyear.displayName))年"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(eachyear.stories.count)
        print(eachyear)
        
        storytable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
            guard let destination = segue.destination as? AddViewController else {
                fatalError("Failed to prepare AddViewController.")
            }
            
            destination.addstory = eachyear
        } else if segue.identifier == "toDetail" {
            if let indexPath = storytable.indexPathForSelectedRow {
                guard let destination = segue.destination as? DetailViewController else {
                    fatalError("Failed to prepare DetailViewController.")
                }

                destination.storydetail = eachyear.stories[indexPath.row]
                destination.objindex = indexPath.row
                destination.objyear = eachyear
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eachyear.stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath)
        
        cell.textLabel!.text = eachyear.stories[indexPath.row].title
        print("indexPath.row = \(indexPath.row)")
        
        return cell
    }
    
    @IBAction func unwindToListController(segue: UIStoryboardSegue) {
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
