//
//  OilChangeTableViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class OilChangeTableViewController: UITableViewController {
    
    let realm = try! Realm() //Realm database instance
    lazy var oilChangeList: Results<OilChange> = { realm.objects(OilChange.self) }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background3.png"))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return oilChangeList.count
    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oilchangecell") as! OilChangeTableViewCell
        let oil = oilChangeList[indexPath.row]
        cell.autoLabel.text = oil.auto
        cell.mileageLabel.text = oil.mileage
        cell.dateLabel.text = oil.oilDate
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "oildetailsegue"{
            let detailVC = segue.destination as! OilDetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let auto = oilChangeList[(indexPath?.row)!]
            detailVC.auto = auto.auto
            detailVC.mileage = auto.mileage
            detailVC.date = auto.oilDate
        }
    }
    
    @IBAction func unwindfromOilAddSegue(segue: UIStoryboardSegue){
        
    }
  

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
   

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = oilChangeList[indexPath.row]
            try! self.realm.write{
                self.realm.delete(item) //deletes item from realm database
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
