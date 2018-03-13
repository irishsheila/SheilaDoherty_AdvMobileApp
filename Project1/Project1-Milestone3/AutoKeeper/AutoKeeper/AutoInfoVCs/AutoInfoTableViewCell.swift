//
//  AutoInfoTableViewCell.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/8/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class AutoInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var autoYear: UILabel!
    @IBOutlet weak var autoMake: UILabel!
    @IBOutlet weak var autoModel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
