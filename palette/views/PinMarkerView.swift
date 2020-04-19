//
//  PostMarkerView.swift
//  palette
//
//  Created by Sam on 4/4/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import MapKit

class PinMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let pin = newValue as? PinAnnotation else {
                return
            }
            canShowCallout = false
            calloutOffset = CGPoint(x: -3, y: 3)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            self.titleVisibility = .hidden
            self.subtitleVisibility = .hidden

            markerTintColor = pin.photo?.Color()
            glyphText = ""
//            if let letter = pin.photo?.name.first {
//                glyphText = String(letter)
//            }
        }
    }
}
