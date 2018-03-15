//
//  AddViewController.swift
//  Midterm-Restaurants
//
//  Created by Sheila Doherty on 3/15/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    @IBOutlet weak var urlTextfield: UITextField!
    @IBOutlet weak var restaurantTextfield: UITextField!
    let newRestaurantInfoItem = Restaurant()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue"{
            newRestaurantInfoItem.name = restaurantTextfield.text!
            newRestaurantInfoItem.url = urlTextfield.text!
        }
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
