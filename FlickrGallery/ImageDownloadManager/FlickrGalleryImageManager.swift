//
//  FlickrGalleryImageManager.swift
//  FlickrGallery
//
//  Created by Hitesh Joshi on 07/10/17.
//  Copyright © 2017 Hitesh. All rights reserved.
//

/* Image Manager class */
/* Create the image array from the flickr feed url
 * Uses Framework:
 * Alamofire for Network reachability, network call and Image downloads.
 * Haneke for Image Caching in Disk
 * Sends the callback as FlickrGalleryImageModel array.
 */

import Foundation
import Alamofire
import AlamofireImage
import Haneke


class FlickrGalleryImageManager{
    var imageArray = [FlickrGalleryImageModel]()
    
    //MARK: - Image Downloading
    
    /// Get the Image URL from flickr feed and create the Array of urls and pass to retrieveImage api.
    ///
    /// - Parameter callback: callback FlickrGalleryImageModel array to fill UI.
    func getImageURLList( callback:@escaping (([FlickrGalleryImageModel]?) -> Void)){
        var imageItems = [FlickrGalleryImageModel]()
        guard let url = URL(string: FlickrGalleryConstant.flickrFeedUrl) else { return }
        let request = URLRequest(url: url)
        //Check Network reachability
        let manager = NetworkReachabilityManager(host: FlickrGalleryConstant.flickrFeedUrl)
        let isHostReachable = manager?.isReachable
        if (isHostReachable == true) {
            Alamofire.request(request)
                .responseJSON { response in
                    if let responseData = response.data{
                        guard let dict = (try? JSONSerialization.jsonObject(with: responseData, options: [])) as? NSDictionary,
                            let items = dict["items"] as? [NSDictionary]
                            else { return }
                        
                        for item in items {
                            if let media = item["media"] as? NSDictionary,
                                let m = media["m"] as? String,
                                let url = URL(string: m) {
                                
                                let imageItem = FlickrGalleryImageModel(imageUrl: url)
                                imageItems.append(imageItem)
                            }
                        }
                        print(imageItems)
                        self.retrieveImage(urlArray: imageItems,callback: {data in
                            callback(data)
                        })
                    }
            }
        }
    }
    
    
    /// Api to get the images from the URL array gets created in getImageURLList api
    /// and cache them for later use.
    ///
    /// - Parameters:
    ///   - urlArray: List of urls
    ///   - callback: FlickrGalleryImageModel object array.
    func retrieveImage(urlArray: [FlickrGalleryImageModel], callback:@escaping (([FlickrGalleryImageModel]) -> Void)) {
        // MLADataManager.sharedInstance.createFolderInDocumentsDirectoryForImagesDownloaded()
        for menuModel in urlArray
        {
            //Check if Image is cached.If cached get them from cache.
            //Otherwise make a Network call to get the images and save in Cache for later use.
            Shared.imageCache.fetch(key: "\(menuModel.imageUrl)").onSuccess {
                (image) in
                print("Image Cached")
                let photo = FlickrGalleryImageModel(flickrGalleryimage: image, imageUrl: menuModel.imageUrl)
                self.imageArray.append(photo)
                if(urlArray.count == self.imageArray.count) {
                    callback(self.imageArray)
                }
                }.onFailure { (error) in
                    print("Image not Cached")
                    let urlString = "\(String(describing: menuModel.imageUrl))"
                    //Check Network reachability
                    let manager = NetworkReachabilityManager(host: urlString)
                    let isHostReachable = manager?.isReachable
                    if (isHostReachable == true) {
                        let request = Alamofire.SessionManager.default.request(urlString, method: .get)
                        let serializer = DataRequest.imageResponseSerializer()
                        request.response(responseSerializer: serializer) { response in
                            guard response.result.value != nil else {
                                return }
                            if let image = response.result.value
                            {
                                let imageCache = Shared.imageCache
                                imageCache.set(value: image, key: "\(menuModel.imageUrl)")
                                let photo = FlickrGalleryImageModel(flickrGalleryimage: image, imageUrl: menuModel.imageUrl)
                                self.imageArray.append(photo)
                                if(urlArray.count == self.imageArray.count) {
                                    callback(self.imageArray)
                                }
                            }
                        }
                    }
            }
        }
    }
}
