//
//  CollectionViewController.swift
//  pictureCollection
//
//  Created by Sheila Doherty on 2/19/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var disneyImages = [String]()
    
    let reuseIndentifier = "Cell"
    
    let sectionInsets = UIEdgeInsets(top: 25.0, left: 10.0, bottom: 25.0, right: 10)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 1...16{
            disneyImages.append("disney" + String(i))
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let image = UIImage(named: disneyImages[indexPath.row])
        let newSize = CGSize(width: (image?.size.width)!/5, height: (image?.size.height)!/5)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        image?.draw(in: rect)
        let image2 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return(image2?.size)!
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //code help from https://www.raywenderlich.com/136161/uicollectionview-tutorial-reusable-views-selection-reordering
        //code help from https://stackoverflow.com/questions/29655652/how-to-make-both-header-and-footer-in-collection-view-with-swift/29656061
        
        switch kind{
        case UICollectionElementKindSectionHeader:
            var header: CollectinSupplementaryView?
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as? CollectinSupplementaryView
            header?.headerLabel.text = "DisneyWorld"
            return header!
        case UICollectionElementKindSectionFooter:
            let footer: FooterCollectionSupplementaryViewCollectionReusableView?
            footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as? FooterCollectionSupplementaryViewCollectionReusableView
            return footer!
        default: assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView (_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return sectionInsets
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let indexPath = collectionView?.indexPath(for: sender as! CollectionViewCell)
            let detailVC = segue.destination as! DetailViewController
            detailVC.imageName = disneyImages[(indexPath?.row)!]
        }
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return disneyImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let image = UIImage(named: disneyImages[indexPath.row])
        cell.cellImage.image = image
    
        return cell
    }

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
