//
//  FlickrGalleryDetailViewController.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 07/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
/* FlickrGalleryDetailViewController
 * This class is the controller class responsible for displaying the a single image.
 */

import UIKit

class FlickrGalleryDetailViewController: UIViewController {

    @IBOutlet weak var flickrGalleryDetailImageView: UIImageView!
    var flickrImage: FlickrGalleryImageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set the image in detail image view.
        flickrGalleryDetailImageView.image = flickrImage?.flickrGalleryimage
    }
}
