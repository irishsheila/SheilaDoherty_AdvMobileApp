//
//  DetailRepairViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class DetailRepairViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var repairLabel: UILabel!
    @IBOutlet weak var vehicleLabel: UILabel!
    var date = String()
    var notes = String()
    var repair = String()
    var auto = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateLabel.text = date
        notesLabel.text = notes
        repairLabel.text = repair
        vehicleLabel.text = auto
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repairEditSegue"{
            let nav = segue.destination as! UINavigationController
            let detailVC = nav.topViewController as! RepairEditViewController
            detailVC.date = date
            detailVC.notes = notes
            detailVC.repair = repair
            detailVC.vehicle = auto
        }
    }
    
    @IBAction func unwindfromRepairEditSegue(segue: UIStoryboardSegue){
        let source = segue.source as! RepairEditViewController
        date = source.date
        notes = source.notes
        repair = source.repair
        auto = source.vehicle
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
