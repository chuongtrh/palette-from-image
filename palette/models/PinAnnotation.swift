//
//  Post.swift
//  palette
//
//  Created by Sam on 4/4/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import MapKit

class PinAnnotation: NSObject, MKAnnotation {
    let photo: Photo?
    
    let coordinate: CLLocationCoordinate2D
    
    init(
        photo: Photo?,
        coordinate: CLLocationCoordinate2D
    ) {
        self.coordinate = coordinate
        self.photo = photo
        
        super.init()
    }
    
    var subtitle: String? {
        return photo?.name
    }
}

