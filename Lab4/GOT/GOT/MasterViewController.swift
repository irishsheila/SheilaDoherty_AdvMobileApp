//
//  MasterViewController.swift
//  GOT
//
//  Created by Sheila Doherty on 2/27/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var gotCharacters = [GOT]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadjson()
    }

    func loadjson(){
        let urlPath = "https://www.anapioficeandfire.com/api/characters?page=4&pageSize=50"
        guard let url = URL(string: urlPath)
            else {
                print("url error")
                return
            }

        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard statusCode == 200
                else {
                    print("file download error")
                    return
            }
            //download successful
            print("download complete")
            DispatchQueue.main.async {self.parsejson(data!)}
        })
        //must call resume to run session
        session.resume()
    }
    
    func parsejson(_ data: Data){
        //print(data)
        do {
            // get json data
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
            //get all results
            guard let array = json as? [Any] else {return}
            print(array)

            
            //add results to objects
            for result in array {
                //check that data exists
                guard let resultDict = result as? [String: Any] else {return}

                guard let newname = resultDict["name"] as? String else {continue}

                guard let newgender = resultDict["gender"] as? String else {continue}

                guard let newculture = resultDict["culture"] as? String else {continue}
                guard let newborn = resultDict["born"] as? String else {continue}
                guard let newdied = resultDict["died"] as? String else {continue}
                guard let newplayedBy = resultDict["playedBy"] as? [String] else {continue}
                let newPBValue = newplayedBy[0] as String

                
                //create new object
                let newGOTChar = GOT(name: newname, gender: newgender, culture: newculture, born: newborn, died: newdied, playedBy: newPBValue)
                //add object to array

                self.gotCharacters.append(newGOTChar)

            }
            //handle thrown error
        } catch {
            print("Error with JSON: \(error)")
            return
        }
        //reload the table data after the json data has been downloaded
        print("reloading tableview")
        tableView.reloadData()
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let gotChar = gotCharacters[indexPath.row]
                let name = gotChar.name
                let gender = gotChar.gender
                let culture = gotChar.culture
                let born = gotChar.born
                let died = gotChar.died
                let playedBy = gotChar.playedBy
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                //controller.title = title
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.detailItem = name
                controller.genderItem = gender
                controller.cultureItem = culture
                controller.bornItem = born
                controller.diedItem = died
                controller.playedByItem = playedBy
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gotCharacters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let gotCharacter = gotCharacters[indexPath.row]
        cell.textLabel!.text = gotCharacter.name
        
        
        return cell
    }

/*
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
*/

}
