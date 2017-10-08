//
//  FlickrGalleryImageModelTests.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 08/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import FlickrGallery
class FlickrGalleryImageModelTests: QuickSpec{
    override func spec() {
        describe("FlickrGalleryImageModelTests"){
            var feedUrl: URL?
            var urlString: String?
            
            beforeEach{
                urlString = "https:www.google.com"
                feedUrl = URL(string: urlString!)
            }
            
            it("should initialize with url"){
                let mockUrlObj = FlickrGalleryImageModel(imageUrl: feedUrl!)
                expect(mockUrlObj.imageUrl).to(equal(feedUrl))
            }
            
            it("should initialize with Image and URL"){
                let image = UIImage()
                let mockUrlObj = FlickrGalleryImageModel(flickrGalleryimage: image, imageUrl:feedUrl!)
                expect(mockUrlObj.imageUrl).to(equal(feedUrl))
                expect(mockUrlObj.flickrGalleryimage).toNot(beNil())
            }
        }
    }
}
