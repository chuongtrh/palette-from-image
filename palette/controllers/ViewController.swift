//
//  ViewController.swift
//  palette
//
//  Created by Sam on 4/4/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet private var mapView:MKMapView! = nil
    @IBOutlet var btShowList:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        btShowList.layer.cornerRadius = 15
        btShowList.layer.borderWidth = 1
        btShowList.layer.borderColor = UIColor.black.cgColor
        
        mapView.register(PinMarkerView.self,forAnnotationViewWithReuseIdentifier:MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        PhotoManager.shared.loadPhoto()
        
        let photos = PhotoManager.shared.photos
        photos.forEach { (photo) in
            
            let artwork = PinAnnotation(
                photo:photo,
                coordinate: CLLocationCoordinate2D(latitude: photo.lat, longitude: photo.lng))
            mapView.addAnnotation(artwork)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? PinAnnotation else {
            return nil
        }
        let identifier = MKMapViewDefaultAnnotationViewReuseIdentifier
        var view: PinMarkerView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? PinMarkerView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = PinMarkerView(annotation: annotation,reuseIdentifier: identifier)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {

        guard let view = view as? PinMarkerView else {
            return
        }
        guard let annotation = view.annotation as? PinAnnotation else {
            return
        }
        mapView.deselectAnnotation(annotation, animated: true)

        guard let vc = self.storyboard!.instantiateViewController(withIdentifier: "ImageCVIdentifier") as? ImageViewController else {
            return
        }
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.photo = annotation.photo
        self.present(vc, animated: true, completion: nil)
        
    }
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
