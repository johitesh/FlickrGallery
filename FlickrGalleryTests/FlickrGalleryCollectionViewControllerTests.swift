//
//  FlickrGalleryCollectionViewControllerTests.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 08/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import FlickrGallery

class FlickrGalleryCollectionViewControllerTests: QuickSpec{
    override func spec() {
        describe("FlickrGalleryCollectionViewControllerTests"){
            var subject: UINavigationController?
            var subjectVC :FlickrGalleryCollectionViewController?
            var cell: UICollectionViewCell?
            beforeEach{
                //subject = FlickrGalleryCollectionViewController()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let subjectViewController = (storyboard.instantiateViewController(withIdentifier:"FlickrGalleryNav") as? UINavigationController) {
                    subject = subjectViewController
                    subjectVC = subject?.viewControllers[0] as? FlickrGalleryCollectionViewController
                    _ = subjectVC?.view
                    for _ in 0..<3{
                        let mockModelObject = FlickrGalleryImageModel(imageUrl: URL(string: "https://farm5.staticflickr.com/4452/23709812468_284462d434_m.jpg")!)
                        subjectVC?.imageArray.append(mockModelObject)
                    }
                    subjectVC?.collectionView?.reloadData()
                }
            }
            
            it("Should have datasource"){
                expect(subjectVC?.collectionView?.dataSource).toNot(beNil())
            }
            
            it("Should have non empty section"){
                let sectionCount = subjectVC?.collectionView?.dataSource?.numberOfSections!(in: (subjectVC?.collectionView)!)
                expect(sectionCount).to(equal(1))
            }
            
            it("Should have cell of type FlickrGalleryCollectionViewCell "){
                let indexPath = IndexPath(row: 1, section: 0)
                cell = subjectVC?.collectionView?.dataSource?.collectionView((subjectVC?.collectionView)!, cellForItemAt: indexPath)
                expect(cell is FlickrGalleryCollectionViewCell).to(beTrue())
            }
            
            it("Should have non empty cell"){
                let indexPath = IndexPath(row: 1, section: 0)
                cell = subjectVC?.collectionView?.dataSource?.collectionView((subjectVC?.collectionView)!, cellForItemAt: indexPath)
                expect(cell).toNot(beNil())
            }
            
            it("Should have items"){
                let items = subjectVC?.collectionView?.numberOfItems(inSection: 0)
                expect(items).toNot(equal(0))
            }
            
            it("Should have items equal to FlickrGalleryImageModel array object count"){
                let items = subjectVC?.collectionView?.numberOfItems(inSection: 0)
                expect(items).to(equal(subjectVC?.imageArray.count))
            }
 
            it("Should Segue"){
                let detail = FlickrGalleryDetailViewController()
                let segue = UIStoryboardSegue(identifier: "flickrDetailSegue", source: subjectVC!, destination: detail)
                subjectVC?.prepare(for: segue, sender: subjectVC!)
            }
        }
    }
    
}
