//
//  AddViewController.swift
//  Recipes
//
//  Created by Sheila Doherty on 3/4/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var recipeurl: UITextField!
    @IBOutlet weak var recipename: UITextField!
    var addedrecipe = String()
    var addedurl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue from Add to Recipe")
        if segue.identifier == "savesegue" {
            if recipename.text?.isEmpty == false {
                addedrecipe = recipename.text!
                addedurl = recipeurl.text!
            }
        }
        print("prepare for segue from Add to Recipe End")
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
