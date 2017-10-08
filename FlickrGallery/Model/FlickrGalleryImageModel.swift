//
//  FlickrGalleryImageModel.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 07/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
/* FlickrGalleryImageModel
 * This is a model to store the Image and Image urls.
 */

import UIKit

struct FlickrGalleryImageModel {
    var flickrGalleryimage: UIImage? = nil
    var imageUrl: URL = URL(string: "https://www.google.com")!

    init(imageUrl: URL){
       self.imageUrl = imageUrl
    }
    
    init(flickrGalleryimage: UIImage,imageUrl: URL){
        self.flickrGalleryimage = flickrGalleryimage
        self.imageUrl = imageUrl
    }
}
