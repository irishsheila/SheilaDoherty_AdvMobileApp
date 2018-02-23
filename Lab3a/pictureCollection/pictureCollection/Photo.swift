//
//  Photo.swift
//  pictureCollection
//
//  Created by Sheila Doherty on 2/22/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import Foundation

//online help: https://www.youtube.com/watch?v=iID0I0aEzGw

struct PhotoCategory
{
    var categoryImageName: String
    var title: String
    var imageNames: [String]
    
}

class PhotosLibrary{
    
    class func fetchPhotos() -> [PhotoCategory]{
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotosData()
        for (categoryTitle, dict) in photosData {
            if let dict = dict as? [String: Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageNames: imageNames)
                    categories.append(newCategory)
                }
            }
        }
        return categories
    }
    
    class func downloadPhotosData()-> [String: Any]{
        return [
            "Magic Kingdom" : [
                "categoryImageName" : "magickingdom",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "mk", numberOfImages: 4)
            ],
            "Epcot" : [
                "categoryImageName" : "epcot",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "e", numberOfImages: 5)
            ],
            "Hollywood Studios" : [
                "categoryImageName" : "hollywoodstudios",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "hs", numberOfImages: 7)
            ],
            "Animal Kingdom" : [
                "categoryImageName" : "animalkingdom",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "ak", numberOfImages: 5)
            ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        for i in 1...numberOfImages{
            imageNames.append("\(categoryPrefix)\(i)")
        }
        
        return imageNames
    }
    
}













