//
//  UIImageView+Additions.swift
//  OBSCodingTest
//
//  Created by ShujaMBP on 26/03/2023.
//

import Foundation
import UIKit

// Create a shared image cache to store downloaded images
fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    /**
     Downloads an image from the specified URL and sets it as the image of the image view.
     
     If the image has already been downloaded and cached, it will be loaded from the cache instead of being downloaded again.
     
     While the image is being downloaded, a spinner is displayed in the center of the image view.
     
     - Parameter urlString: The URL of the image to download and display.
     */
    func loadImageUsingCache(withUrl urlString : String) {
        // Convert the URL string to a URL object
        guard let url = URL(string: urlString) else { return }
        
        // Clear the current image from the image view
        self.image = nil
        
        // Check if the image has already been cached
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        // Create a spinner and add it to the image view
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center
        
        // If the image is not in the cache, download it from the URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Check for errors
            if error != nil {
                activityIndicator.removeFromSuperview()
                return
            }
            
            // Convert the downloaded data to an image and set it as the image of the image view
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }
        }.resume()
    }
}
