//
//  DetailTableViewController.swift
//  Movies
//
//  Created by Sheila Doherty on 2/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var movies = [String]()
    var selectedGenre = 0
    var genreListDetail = Movies()
    var searchController: UISearchController!
    
    let kfilename = "data.plist"
    
    @IBAction func unwindSegue (_ segue: UIStoryboardSegue){
        if segue.identifier == "doneSegue"{
            let source = segue.source as! AddMovieViewController
            //only add a movie if there is text in the textfield
            if ((source.addedMovie.isEmpty) == false){
                //add movie to the array
                movies.append(source.addedMovie)
                tableView.reloadData()
                let chosenGenre = genreListDetail.genre[selectedGenre]
                //add movie to our data model instance
                genreListDetail.genreData[chosenGenre]?.append(source.addedMovie)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL for the data
        let pathURL:URL?
        //get path for data file
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0] //documents directory
        print(docDir)
        
        // URL for our plist
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        print(dataFileURL)
        
        //if the data file exists, use it
        if FileManager.default.fileExists(atPath: dataFileURL.path){
            pathURL = dataFileURL
        }
        else {
            // URL for our plist
            pathURL = Bundle.main.url(forResource: "movies", withExtension: "plist")
        }
        //creates a property list decoder object
        let plistdecoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: pathURL!)
            //decodes the property list
            genreListDetail.genreData = try plistdecoder.decode([String: [String]].self, from: data)
            genreListDetail.genre = Array(genreListDetail.genreData.keys)
            let chosenGenre = genreListDetail.genre[selectedGenre]
            movies = genreListDetail.genreData[chosenGenre]! as [String]
        } catch {
            // handle error
            print(error)
        }
        
        //search results
        let resultsController = SearchTableViewController() //create an instance of our SearchResultsController class
        resultsController.allwords = movies //set the allwords property to our words array
        searchController = UISearchController(searchResultsController: resultsController) //initialize our search controller with the resultsController when it has search results to display
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term" //place holder text
        //searchController.searchBar.sizeToFit() //sets appropriate size for the search bar
        tableView.tableHeaderView=searchController.searchBar //install the search bar as the table header
        searchController.searchResultsUpdater = resultsController //sets the instance to update search results

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return movies.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        genreListDetail.genre = Array(genreListDetail.genreData.keys)
        let chosenGenre = genreListDetail.genre[selectedGenre]
        movies = genreListDetail.genreData[chosenGenre]! as [String]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)

        cell.textLabel?.text = movies[indexPath.row]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            movies.remove(at: indexPath.row)
            let chosenGenre = genreListDetail.genre[selectedGenre]
            //Delete from the data model instance
            genreListDetail.genreData[chosenGenre]?.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {
        let fromRow = fromIndexPath.row //row being moved from
        let toRow = toIndexPath.row //row being moved to
        let moveMovie = movies[fromRow] //movie being moved
        //move in array
        movies.remove(at: fromRow)
        movies.insert(moveMovie, at: toRow)
        //move in data model instance
        let chosenGenre = genreListDetail.genre[selectedGenre]
        genreListDetail.genreData[chosenGenre]?.remove(at: fromRow)
        genreListDetail.genreData[chosenGenre]?.insert(moveMovie, at: toRow)

    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
