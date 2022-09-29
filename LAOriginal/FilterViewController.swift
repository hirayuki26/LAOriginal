//
//  FilterViewController.swift
//  LAOriginal
//
//  Created by Yuki Hirayama on 2022/09/25.
//

import UIKit
import RealmSwift

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var filtertable: UITableView!
    @IBOutlet var countLabel: UILabel!
    
    let realm = try! Realm()
    
    var years: Results<Year>!
    
    var resultyear: [Year] = []
    var resultindex: [Int] = []
    
    var filtername: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = filtername

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resultyear.removeAll()
        resultindex.removeAll()
        
        switch filtername {
        case "全て":
            years = realm.objects(Year.self).sorted(byKeyPath: "displayName", ascending: true)
            for year in years {
                for i in 0 ..< year.stories.count {
                    print(year.displayName)
                    print(year.stories[i].title)
                    print(year.stories[i].category)
                    print(type(of: year))
                    print(type(of: i))
                    resultyear.append(year)
                    resultindex.append(i)
                }
            }
        case "カテゴリなし":
            searchYear(Query: "カテゴリなし", filteryear: &resultyear, filterindex: &resultindex)
        case "思い出":
            searchYear(Query: "思い出", filteryear: &resultyear, filterindex: &resultindex)
        case "職歴":
            searchYear(Query: "職歴", filteryear: &resultyear, filterindex: &resultindex)
        case "資格":
            searchYear(Query: "資格", filteryear: &resultyear, filterindex: &resultindex)
        default:
            print("検索結果なし")
        }
        
        countLabel.text = "結果: " + String(resultyear.count) + "件"
        
        print(years)
        print(resultyear)
        print(resultindex)
        
        filtertable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterToDetail" {
            if let indexPath = filtertable.indexPathForSelectedRow {
                guard let destination = segue.destination as? FilterDetailViewController else {
                    fatalError("Failed to prepare FilterDetailViewController.")
                }

                destination.storydetail = resultyear[indexPath.row].stories[resultindex[indexPath.row]]
                destination.objindex = resultindex[indexPath.row]
                destination.objyear = resultyear[indexPath.row]
            }
        }
    }
    
    func searchYear(Query query: String, /*Result resultyear: Results<Year>, */filteryear: inout [Year], filterindex: inout [Int]) {
        let predicate = NSPredicate(format: "ANY stories.category == %@", query)
        years = realm.objects(Year.self).filter(predicate).sorted(byKeyPath: "displayName", ascending: true)
        for year in years {
            for i in 0 ..< year.stories.count {
                if year.stories[i].category == query {
                    print(year.displayName)
                    print(year.stories[i].title)
                    print(year.stories[i].category)
                    print(type(of: year))
                    print(type(of: i))
                    filteryear.append(year)
                    filterindex.append(i)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(resultyear.count)
        return resultyear.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "filterCell", for: indexPath)
        
        cell.textLabel!.text = resultyear[indexPath.row].stories[resultindex[indexPath.row]].title
//        print(years[indexPath.row].displayName)
        
        return cell
    }
    
    @IBAction func unwindToFilterController(segue: UIStoryboardSegue) {
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
