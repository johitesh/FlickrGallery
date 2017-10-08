//
//  FlickrGalleryImageManagerTests.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 07/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//
@testable import FlickrGallery

import Foundation
import Quick
import Nimble

class FlickrGalleryImageManagerTests: QuickSpec{
    override func spec() {
        describe("FlickrGalleryImageManagerTests"){
            var subject: FlickrGalleryImageManager?
            
            beforeEach {
                subject = FlickrGalleryImageManager()
                subject?.imageArray = []
            }
            
            context("Image download manager api"){
                
                it("Should get the image URL list from flickr feed and send callback")
                {
                    //If Network is slow we may need to increase the timeout to make this test pass
                    waitUntil(timeout: 10, action: { done in
                        subject?.getImageURLList(callback: { data in
                            expect(data?.count).toNot(equal(0))
                            done()
                        })
                    })
                }
                
                it("Should retrieve images and send callback")
                {
                    var imageItems = [FlickrGalleryImageModel]()
                    let mockModelObject = FlickrGalleryImageModel(imageUrl: URL(string: "https://farm5.staticflickr.com/4452/23709812468_284462d434_m.jpg")!)
                    imageItems.append(mockModelObject)
                    waitUntil(timeout: 5, action: { done in
                        subject?.retrieveImage(urlArray: imageItems, callback: { arrayItem in
                            print("Item:\(arrayItem)")
                            print("Count: \(String(describing: imageItems.count))")
                            print("Count-1: \(String(describing: arrayItem.count))")
                            expect(1).to(equal(arrayItem.count))
                            done()
                        })
                    })
                }
            }
        }
    }
    
}
