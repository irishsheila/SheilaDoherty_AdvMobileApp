//
//  CollectionViewCell.swift
//  pictureCollection
//
//  Created by Sheila Doherty on 2/19/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    
    var imageName: String! {
        didSet {
            cellImage.image = UIImage(named: imageName)
        }
    }
    
}
