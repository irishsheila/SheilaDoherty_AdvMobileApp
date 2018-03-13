//
//  AutoInfoTableViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/8/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

//TODO: Add photo capability

import UIKit
import RealmSwift

class AutoInfoTableViewController: UITableViewController {
    
    var realm: Realm! //Realm database instance
    var autoList: Results<AutoInfo>{
        get{
            print("Get realm")
            return realm.objects(AutoInfo.self) //returns all AutoInfo objects from Realm
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            realm = try Realm()
        } catch let error {
            print(error.localizedDescription)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.backgroundView = UIImageView(image: UIImage(named: "Background1.png"))
        tableView.reloadData()
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
        return autoList.count
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier=="saveSegue"{
            let source = segue.source as! AddAutoInfoViewController
            do{
                try self.realm.write({
                    self.realm.add(source.newAutoInfoItem)
                    self.tableView.insertRows(at: [IndexPath.init(row:self.autoList.count-1, section:0)], with: .automatic)
                    tableView.reloadData()
                })
            }catch let error{
                print(error.localizedDescription)
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "autoinfocell") as! AutoInfoTableViewCell
        let auto = autoList[indexPath.row]
        cell.autoYear.text = auto.year
        cell.autoMake.text = auto.make
        cell.autoModel.text = auto.model
        return cell
    }
 /*
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 330
    }
*/
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = autoList[indexPath.row]
            try! self.realm.write{
                self.realm.delete(item) //deletes item from realm database
            }
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailviewsegue"{
            let detailVC = segue.destination as! AutoDetailViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let auto = autoList[indexPath.row]
            detailVC.year = auto.year
            detailVC.make = auto.make
            detailVC.model = auto.model
            detailVC.vin = auto.vin
            detailVC.license = auto.license
            detailVC.company = auto.insuranceco
            detailVC.policy = auto.insurancepolicynum
            detailVC.phone = auto.insurancephone
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
