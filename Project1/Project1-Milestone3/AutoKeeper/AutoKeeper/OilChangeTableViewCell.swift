//
//  OilChangeTableViewCell.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

//TODO: Delete Rows
//TODO: Add Calendar Reminder
//TODO: Add Mileage of next oil change


import UIKit
import RealmSwift

class OilChangeTableViewCell: UITableViewCell {

    @IBOutlet weak var mileageLabel: UILabel!
    @IBOutlet weak var autoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
