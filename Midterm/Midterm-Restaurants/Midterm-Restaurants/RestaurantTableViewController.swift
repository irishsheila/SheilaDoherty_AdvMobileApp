//
//  RestaurantTableViewController.swift
//  Midterm-Restaurants
//
//  Created by Sheila Doherty on 3/15/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class RestaurantTableViewController: UITableViewController {
    
    var addRestaurant = ["Luciles", "Rincon Argentina", "Backcountry Pizza", "West End Tavern"]
    var addURL = ["https://www.luciles.com/", "https://www.rinconargentinoboulder.com", "https://www.backcountrypizzaandtaphouse.com", "https://www.thewestendtavern.com/"]
    
    var realm: Realm!
    var restaurantList: Results<Restaurant>{
        get{
            return realm.objects(Restaurant.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            realm = try Realm()
        }catch let error{
            print(error.localizedDescription)
        }
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        for item in 0..<addRestaurant.count-1 {
            let realm = try! Realm()
            try! realm.write {
                let newRestaurantItem = Restaurant() //create a new Repairs instance
                newRestaurantItem.name = addRestaurant[item]
                newRestaurantItem.url = addURL[item]
                realm.add(newRestaurantItem)
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return restaurantList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellidentifier", for: indexPath)
        let rest = restaurantList[indexPath.row]
        cell.textLabel!.text = rest.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showsegue"{
            let detailVC = segue.destination as! WebViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let rest = restaurantList[indexPath.row]
            detailVC.title = rest.name
            detailVC.webpage = rest.url
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
            // Delete the row from the data source
            let item = restaurantList[indexPath.row]
            try! self.realm.write {
                self.realm.delete(item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier=="saveSegue"{
            let source = segue.source as! AddViewController
            do{
                try self.realm.write({
                    self.realm.add(source.newRestaurantInfoItem)
                    self.tableView.insertRows(at: [IndexPath.init(row:self.restaurantList.count-1, section:0)], with: .automatic)
                    tableView.reloadData()
                })
            }catch let error{
                print(error.localizedDescription)
            }
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
