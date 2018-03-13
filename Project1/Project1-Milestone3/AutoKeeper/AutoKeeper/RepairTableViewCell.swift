//
//  RepairTableViewCell.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/11/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class RepairTableViewCell: UITableViewCell {

    @IBOutlet weak var vehicleLabel: UILabel!
    @IBOutlet weak var repairLabel: UILabel!
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
