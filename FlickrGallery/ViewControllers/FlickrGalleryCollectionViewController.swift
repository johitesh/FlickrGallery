//
//  FlickrGalleryCollectionViewController.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 07/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

import UIKit
import Haneke

private let reuseIdentifier = "flickrGalleryCell"

class FlickrGalleryCollectionViewController: UICollectionViewController {
    @IBOutlet weak var activityIndicatory: UIActivityIndicatorView!

    var imageArray = [FlickrGalleryImageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicatory.startAnimating()
        let flickrImageManager = FlickrGalleryImageManager()
        flickrImageManager.getImageURLList() { photos in
            self.imageArray = photos!
            self.activityIndicatory.stopAnimating()
            self.collectionView?.reloadData()
        }
        makeEqualSizeOfCells(horizontalCellCount: 3)
    }
    
    /// Customize the collection view layout
    ///
    /// - Parameter horizontalCellCount: require cells in a row
    func makeEqualSizeOfCells(horizontalCellCount: Int) {
        let screenWidth = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: screenWidth/CGFloat(horizontalCellCount), height: screenWidth/CGFloat(horizontalCellCount))
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detail = segue.destination as? FlickrGalleryDetailViewController
        let cell = sender as? FlickrGalleryCollectionViewCell
        detail?.flickrImage = cell?.flickrImage
    }
 
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FlickrGalleryCollectionViewCell else{ return cell}
        collectionCell.flickrGalleryImageView.image = imageArray[indexPath.row].flickrGalleryimage
        collectionCell.flickrImage = imageArray[indexPath.row]
        return collectionCell
    }

}
