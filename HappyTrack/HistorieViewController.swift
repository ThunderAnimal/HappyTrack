//
//  HistorieController.swift
//  HappyTrack
//
//  Created by Martin Weber on 10.08.17.
//  Copyright © 2017 Martin Weber. All rights reserved.
//

import Foundation
import UIKit
import Realm
import RealmSwift


class HistorieViewController: UITableViewController {
    
    let items = try! Realm().objects(TrackDataEntity.self).sorted(byKeyPath: "realDate", ascending: false)
    
    var realmNotifiction: RLMNotificationToken?
    
    var sectionNames: [String] {
        return Set(items.value(forKeyPath: "date") as! [String]).sorted(by: { (date1, date2) -> Bool in
            let dateFormatDay = DateFormatter()
            dateFormatDay.dateFormat = "dd.MM.yyyy"
            
            if (dateFormatDay.date(from: date1)! > dateFormatDay.date(from: date2)!){
                return true
            }else{
                return false
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellIdentifier")
        
        let realm = try! Realm()
        realmNotifiction = realm.addNotificationBlock({ note, realm in
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        let entity = items.filter("date == %@", sectionNames[indexPath.section])[indexPath.row]
        cell.textLabel?.text = entity.time + " - " + entity.feeling.uppercased()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity = items.filter("date == %@", sectionNames[indexPath.section])[indexPath.row]
        
        performSegue(withIdentifier: "showHistorieDetail", sender: entity)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionNames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionNames[section]
    }
    
    override func tableView(_ tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return items.filter("date == %@", sectionNames[section]).count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showHistorieDetail") {
            //initialize new view controller and cast it as your view controller
            let viewController = segue.destination as! HistorieDetailViewController
            //your new view controller should have property that will store passed value
            viewController.setDetailData(trackData: sender as! TrackDataEntity)
        }
    }
    
    deinit {
        realmNotifiction?.stop()
    }
}
