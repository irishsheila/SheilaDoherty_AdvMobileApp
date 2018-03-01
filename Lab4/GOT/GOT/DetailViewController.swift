//
//  DetailViewController.swift
//  GOT
//
//  Created by Sheila Doherty on 2/27/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    
    @IBOutlet weak var playedByLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let nameLabel = detailDescriptionLabel {
                nameLabel.text = detail.description
            }
        }
        if let gender = genderItem {
            if let gLabel = genderLabel {
                if gender.description == ""{
                    gLabel.text = "No Gender Listed"
                }
                else{
                    gLabel.text = gender.description
                }
                
            }
        }
        
        if let culture = cultureItem {
            if let cLabel = cultureLabel {
                if culture.description == ""{
                    cLabel.text = "No Place Listed"
                }
                else{
                    cLabel.text = culture.description
                }
            }
        }
        
        if let playedBy = playedByItem {
            if let pLabel = playedByLabel {
                if playedBy.description == "" {
                    pLabel.text = "No Actor Listed"
                }
                else{
                    pLabel.text = playedBy.description
                }
            }
        }
        
        if let born = bornItem {
            if let bLabel = bornLabel {
                if born.description == "" {
                    bLabel.text = "No Birthplace Listed"
                }
                else{
                    bLabel.text = born.description
                }
            }
        }
        
        if let died = diedItem {
            if let dLabel = diedLabel {
                if died.description == "" {
                    dLabel.text = "No Deathplace Listed"
                }
                else{
                    dLabel.text = died.description
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var genderItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var cultureItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var bornItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var diedItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    var playedByItem: String? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    


}

