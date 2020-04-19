//
//  PhotoManager.swift
//  palette
//
//  Created by Sam on 4/4/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
class PhotoManager{
    
    static let shared = PhotoManager()
    
    var photos: [Photo] = []
    //Initializer access level change now
    private init() {}
    
    func loadPhoto(){
        if let path = Bundle.main.path(forResource: "photos", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                self.photos = try JSONDecoder().decode([Photo].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    func nextPhoto(photo:Photo)->Photo?{
        if let temp = photos.filter({$0.slug==photo.nextSlug}).first {
            return temp
        }
        return nil
    }
    func prevPhoto(photo:Photo)->Photo?{
        if let temp = photos.filter({$0.slug==photo.prevSlug}).first {
            return temp
        }
        return nil
    }
}
