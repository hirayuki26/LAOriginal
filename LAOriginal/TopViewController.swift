//
//  TopViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/19.
//

import UIKit
import RealmSwift

class TopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var yeartable: UITableView!
    
    let realm = try! Realm()
    
    var years: Results<Year>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        years = realm.objects(Year.self).sorted(byKeyPath: "displayName", ascending: true)
        
        yeartable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toList" {
            if let indexPath = yeartable.indexPathForSelectedRow {
                guard let destination = segue.destination as? ListViewController else {
                    fatalError("Failed to prepare ListViewController.")
                }
                
                destination.eachyear = years[indexPath.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "yearCell", for: indexPath)
        
        cell.textLabel!.text = String(years[indexPath.row].displayName)
        print(years[indexPath.row].displayName)
        
        return cell
    }
    
    @IBAction func unwindToTopController(segue: UIStoryboardSegue) {
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
