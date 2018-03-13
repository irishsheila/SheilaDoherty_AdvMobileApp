//
//  RepairInfoTableViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/11/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

//TODO: Add photo capability
//TODO: Delete Rows


import UIKit
import RealmSwift

//Realm Tutorial: https://www.raywenderlich.com/112544/realm-tutorial-getting-started

class RepairInfoTableViewController: UITableViewController {
    
    let realm = try! Realm() //Realm database instance
    lazy var repairList: Results<Repairs> = { realm.objects(Repairs.self) }()
    /*
    var repairList: Results<Repairs>{
        get{
            print("Get realm repair")
            return realmRepair.objects(Repairs.self) //returns all Repairs objects from Realm
        }
    }*/
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background2.png"))
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
        return repairList.count
        
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autorepaircell") as! RepairTableViewCell
        let autoRepair = repairList[indexPath.row]
        cell.repairLabel.text = autoRepair.repair
        cell.dateLabel.text = autoRepair.date
        cell.vehicleLabel.text = autoRepair.car
        return cell
     }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailrepairsegue"{
            let detailVC = segue.destination as! DetailRepairViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            let auto = repairList[(indexPath?.row)!]
            detailVC.auto = auto.car
            detailVC.date = auto.date
            detailVC.repair = auto.repair
            detailVC.notes = auto.notes
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = repairList[indexPath.row]
            try! self.realm.write{
                self.realm.delete(item) //deletes item from realm database
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func unwindfromRepairAddSegue(segue: UIStoryboardSegue){
 
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
