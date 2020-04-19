//
//  UIImageView-extension.swift
//  palette
//
//  Created by Sam on 4/5/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    public func setImageWithFadeFromURL(with url: URL, placeholderImage placeholder: UIImage? = nil, animationDuration: Double = 0.5) {
        self.sd_setImage(with: url, placeholderImage: placeholder) { (fetchedImage, error, cacheType, url) in
            if error != nil {
                print("Error loading Image:\n(error?.localizedDescription)")
            }
            
            self.alpha = 0
            self.image = fetchedImage
            UIView.transition(with: self, duration: (cacheType == .none ? animationDuration : 0), options: .transitionCrossDissolve, animations: { () -> Void in
                self.alpha = 1
            }, completion: nil)
        }
    }
    
    public func cancelImageLoad() {
        self.sd_cancelCurrentImageLoad()
    }
}
