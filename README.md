# FlickrGallery
Flickr gallery app is developed in Swift 3.1 and Xcode 8.3 using various third party frameworks.<br />
• Hits the endpoint to request images-  https://www.flickr.com/services/feeds/docs/photos_public<br />
• Get the Images and display them in UI.<br />
• Supports poth potrait and landscape views.<br />

# App images:<br />
<img src="https://github.com/joshihitesh/FlickrGallery/blob/master/flickrGallery.png" width="300">  <img src="https://github.com/joshihitesh/FlickrGallery/blob/master/flickrdetail.png" width="300"><br />

# Steps to run project.<br />
•	Download or clone the project from Github<br />
•	Navigate to project directory and run the “pod install” command<br />
(I assume you have cocoapods installed in the machine )<br />
•	Open the “FlickrGallery.xcworkspace”, build and run the project.<br />

# Technical Details: <br />
• Tool: Xcode 8.3<br />
• Language: Swift 3.1 <br />
• For UI I have used Collection view and written a ImageDownloadManager class to download the images and send call back to view controller for Image display<br />
• Third Party frameworks: <br />
    • Alamofire: For Network reachability and newtwork request <br /> 
    • Haneke : For Image caching in Local disk <br />
    • Quick and Nimble: For Unit test <br />
 • Code Coverage : Currenlty 90% <br />
