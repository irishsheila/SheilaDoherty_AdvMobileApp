//
//  CollectinSupplementaryView.swift
//  pictureCollection
//
//  Created by Sheila Doherty on 2/19/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class CollectinSupplementaryView: UICollectionReusableView {
    @IBOutlet weak var headerLabel: UILabel!
    var categoryTitle: String!{
        didSet{
            headerLabel.text = categoryTitle
        }
    }
    
}
