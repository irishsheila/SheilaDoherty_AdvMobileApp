//
//  ViewController.swift
//  Movies
//
//  Created by Sheila Doherty on 2/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var genreList = Movies()
    let kfilename = "data.plist"
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //enables large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
            genreList.genreData = try plistdecoder.decode([String: [String]].self, from: data)
            genreList.genre = Array(genreList.genreData.keys)
        } catch {
            // handle error
            print(error)
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
        
        //search results
        let resultsController = SearchResultsController()
        resultsController.allwords = genreList.genre
        searchController = UISearchController(searchResultsController: resultsController)
        
        //search bar configuration
        searchController.searchBar.placeholder = "Enter a search term"
        //searchController.searchBar.sizeToFit()
        tableView.tableHeaderView=searchController.searchBar
        searchController.searchResultsUpdater = resultsController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    @objc func applicationWillResignActive(_ notification: NSNotification){
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        print(docDir)
        
        let dataFileURL = docDir.appendingPathComponent(kfilename)
        print(dataFileURL)
        //creates a property list decoder object
        let plistencoder = PropertyListEncoder()
        plistencoder.outputFormat = .xml
        do{
            let data = try plistencoder.encode(genreList.genreData)
            try data.write(to: dataFileURL)
        } catch {
            //handle error
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of rows in the section
    override func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        return genreList.genre.count
    }

    //Displays table view cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //configure the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        cell.textLabel?.text = genreList.genre[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "moviesegue" {
            let detailVC = segue.destination as! DetailTableViewController
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            //sets the data for the destination controller
            detailVC.title = genreList.genre[indexPath.row]
            detailVC.genreListDetail=genreList
            detailVC.selectedGenre = indexPath.row
        }
        else if segue.identifier == "genresegue"{
            let infoVC = segue.destination as! GenreInfoTableTableViewController
            let editingCell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: editingCell)
            infoVC.name = genreList.genre[indexPath!.row]
            let movies = genreList.genreData[infoVC.name]! as [String]
            infoVC.number = String(movies.count)
        }
    }
}

