//
//  FlickrGalleryDetailViewControllerTests.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 08/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import FlickrGallery

class FlickrGalleryDetailViewControllerTests: QuickSpec{
    override func spec() {
        describe("FlickrGalleryDetailViewControllerTests"){
            var subjectVC: FlickrGalleryDetailViewController?
            
            beforeEach{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let subject = (storyboard.instantiateViewController(withIdentifier:"FlickrGalleryDetail") as? FlickrGalleryDetailViewController) {
                    subjectVC = subject
                    _ = subjectVC?.view
                }
                
            }
            
            it("should initialize with url"){
                expect(subjectVC).toNot(beNil())
                let image = UIImage()
                subjectVC?.flickrImage =   FlickrGalleryImageModel(flickrGalleryimage: image, imageUrl: URL(string: "https://farm5.staticflickr.com/4452/23709812468_284462d434_m.jpg")!)
                subjectVC?.viewDidLoad()
                expect(subjectVC?.flickrGalleryDetailImageView.image).to(equal(image))
            }
        }
    }
}
