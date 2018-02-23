//
//  PhotosCollectionViewController.swift
//  pictureCollection
//
//  Created by Sheila Doherty on 2/22/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//
// Tutorial help for multiple sections: https://www.youtube.com/watch?v=uV_XmIF_BTU

import UIKit

private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController {
    
    var photoCategories: [PhotoCategory] = PhotosLibrary.fetchPhotos()
    var selectedImage: UIImage!
    
    struct Storyboard {
        static let photoCell = "Cell"
        static let leftAndRightPaddings: CGFloat = 2.0
        static let numberOfItemsPerRow: CGFloat = 3.0
        static let sectionHeaderView = "Header"
        //static let showDetailVC = "showDetail"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - Storyboard.leftAndRightPaddings)/Storyboard.numberOfItemsPerRow
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height:itemWidth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return photoCategories.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoCategories[section].imageNames.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.photoCell, for: indexPath) as! CollectionViewCell
        
        let photoCategory = photoCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
    
        return cell
    }
    
    //Section Header & Footer View
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //code help from https://www.raywenderlich.com/136161/uicollectionview-tutorial-reusable-views-selection-reordering
        //code help from https://stackoverflow.com/questions/29655652/how-to-make-both-header-and-footer-in-collection-view-with-swift/29656061
        
        switch kind{
        case UICollectionElementKindSectionHeader:
            var header: CollectinSupplementaryView?
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Storyboard.sectionHeaderView, for: indexPath) as? CollectinSupplementaryView
            let category = photoCategories[indexPath.section]
            header?.headerLabel.text = category.title
            return header!
        case UICollectionElementKindSectionFooter:
            let footer: FooterCollectionSupplementaryViewCollectionReusableView?
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? FooterCollectionSupplementaryViewCollectionReusableView
            return footer!
        default: assert(false, "Unexpected element kind")
        }
    }
/*
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = photoCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.item])
        //performSegue(withIdentifier: Storyboard.showDetailVC, sender: nil)
}
*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let indexPath = collectionView?.indexPath(for: sender as! CollectionViewCell)
            let category = photoCategories[(indexPath?.section)!]
            let detailVC = segue.destination as! DetailViewController
            detailVC.image = UIImage(named: category.imageNames[(indexPath?.item)!])
        }
    }
 /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let indexPath = collectionView?.indexPath(for: sender as! CollectionViewCell)
            let detailVC = segue.destination as! DetailViewController
            detailVC.imageName = disneyImages[(indexPath?.row)!]
        }
    }
 
*/
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
