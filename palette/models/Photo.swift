//
//  Photo.swift
//  palette
//
//  Created by Sam on 4/4/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit

struct Photo: Decodable {
    let id: String
    let name: String
    let slug: String
    let title: String
    let primaryColor: [Float]
    let hue: Int
    let lat: Double
    let lng: Double
    let country: String?
    let region: String?
    let attribution: String?
    let thumbUrl: URL
    let photoUrl: URL
    let nextSlug: String
    let prevSlug: String
    let earthLink: URL
    let mapsLink: URL
    
    func Color() -> UIColor {
        return UIColor(red: CGFloat(self.primaryColor[0]/255), green:CGFloat( self.primaryColor[1]/255), blue: CGFloat(self.primaryColor[2]/255), alpha: CGFloat(self.primaryColor[3]/255))
    }
    func coordinateString() -> String {
        var latSeconds = Int(lat * 3600)
        let latDegrees = latSeconds / 3600
        latSeconds = abs(latSeconds % 3600)
        let latMinutes = latSeconds / 60
        latSeconds %= 60
        var longSeconds = Int(lng * 3600)
        let longDegrees = longSeconds / 3600
        longSeconds = abs(longSeconds % 3600)
        let longMinutes = longSeconds / 60
        longSeconds %= 60
        return String(format:"%d°%d'%d\"%@ %d°%d'%d\"%@",
                      abs(latDegrees),
                      latMinutes,
                      latSeconds, latDegrees >= 0 ? "N" : "S",
                      abs(longDegrees),
                      longMinutes,
                      longSeconds,
                      longDegrees >= 0 ? "E" : "W" )
    }

}
