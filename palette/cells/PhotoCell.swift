//
//  PhotoCell.swift
//  palette
//
//  Created by Sam on 4/6/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class PhotoCell: UITableViewCell {
    
    @IBOutlet var ivPhoto:UIImageView!
    @IBOutlet var lbName:UILabel!

    static func identifier() -> String {
        return "PhotoCellIdentifier"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let transition = SDWebImageTransition.fade
        transition.prepares = { (view, image, imageData, cacheType, imageURL) in
            view.transform = .init(rotationAngle: .pi)
        }
        ivPhoto.sd_imageTransition = transition
        ivPhoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    func loadData(photo: Photo) {
        ivPhoto.cancelImageLoad()
        ivPhoto.sd_setImage(with: photo.photoUrl, placeholderImage: nil)
        
        lbName.setTextOutline(text: photo.name, font: UIFont.systemFont(ofSize: 18), strokeColor: UIColor.black, foregroundColor: UIColor.white)
    }
}
