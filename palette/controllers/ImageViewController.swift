//
//  ImageViewController.swift
//  palette
//
//  Created by Sam on 4/4/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageViewController: UIViewController {
    var photo: Photo?
    @IBOutlet var ivPhoto:UIImageView!
    @IBOutlet var lbSource:UILabel!
    @IBOutlet var btShowMap:UIButton!
    @IBOutlet var btLoopMode:UIButton!
    @IBOutlet var btMore:UIButton!
    @IBOutlet var btName:UIButton!
    
    //@IBOutlet var paletteLabels: [UILabel]!
    @IBOutlet var paletteViews: [UIView]!
    @IBOutlet var paletteContentView: UIStackView!
    
    var timer: Timer?
    var isLoop = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        paletteContentView.backgroundColor = .white
        view.backgroundColor = .white
        
        
        btShowMap.layer.cornerRadius = 15
        btShowMap.layer.borderWidth = 1
        btShowMap.layer.borderColor = UIColor.black.cgColor
        
        btLoopMode.layer.cornerRadius = 8
        btLoopMode.layer.borderWidth = 1
        btLoopMode.layer.borderColor = UIColor.black.cgColor
        btLoopMode.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        btMore.layer.cornerRadius = 8
        btMore.layer.borderWidth = 1
        btMore.layer.borderColor = UIColor.black.cgColor
        btMore.imageEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        for i in 0 ..< 5 {
            paletteViews[i].layer.cornerRadius = 16
            //paletteViews[i].layer.borderWidth = 1
            //paletteViews[i].layer.borderColor = UIColor.white.cgColor
        }
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeHandler))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        
        let transition = SDWebImageTransition.fade
        transition.prepares = { (view, image, imageData, cacheType, imageURL) in
            view.transform = .init(rotationAngle: .pi)
        }
        ivPhoto.sd_imageTransition = transition
        
        loadPhoto()
    }
    
    func loadPhoto(){
        
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.foregroundColor : UIColor.white,
        NSAttributedString.Key.strokeWidth : -1.0,
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)]
        as [NSAttributedString.Key : Any]
        
        btName.setAttributedTitle(NSAttributedString.init(string: photo!.name, attributes: strokeTextAttributes), for: .normal)
        
            
        lbSource.setTextOutline(text: (photo?.attribution)! + " " + (photo?.coordinateString())!, font: UIFont.systemFont(ofSize: 16), strokeColor: UIColor.black, foregroundColor: UIColor.white)

        
        ivPhoto.cancelImageLoad()
        ivPhoto.alpha = 0.2
        ivPhoto.sd_setImage(with: photo!.photoUrl, placeholderImage: nil) { [weak self] (fetchedImage, error, cacheType, url) in
            if error != nil {
                print("Error loading Image:\n(error?.localizedDescription)")
            }
            
            self?.ivPhoto.fadeIn(2)
            self?.paletteContentView.fadeOut(1)
            self?.ivPhoto.image = fetchedImage
            
            DispatchQueue.global(qos: .default).async {
                guard let colors = ColorThief.getPalette(from: fetchedImage!, colorCount: 5, quality: 15, ignoreWhite: true) else {
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.paletteContentView.fadeIn(1)
                    
                    for i in 0 ..< 5 {
                        if i < colors.count {
                            let color = colors[i]
                            self?.paletteViews[i].backgroundColor = color.makeUIColor()
                            //self?.paletteLabels[i].text = "R\(color.r) G\(color.g) B\(color.b)"
                        } else {
                            self?.paletteViews[i].backgroundColor = UIColor.white
                            //self?.paletteLabels[i].text = "-"
                        }
                    }
                }
            }
            
        }
    }
    func nextPhoto(){
        photo = PhotoManager.shared.nextPhoto(photo: photo!)
        loadPhoto()
    }
    func prevPhoto(){
        photo = PhotoManager.shared.prevPhoto(photo: photo!)
        loadPhoto()
    }
    
    func startTimer() {
        guard timer == nil else { return }
        
        timer =  Timer.scheduledTimer(
            timeInterval: TimeInterval(3.5),
            target      : self,
            selector    : #selector(runTimedCode),
            userInfo    : nil,
            repeats     : true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

extension ImageViewController {
    
    @IBAction func onShowMap(sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onName(sender:UIButton){
        if let link = photo?.mapsLink {
            UIApplication.shared.open(link)
        }
    }
    @IBAction func onLoopMode(sender:UIButton){
        isLoop = !isLoop
        if(isLoop){
            btLoopMode.setImage(UIImage(named: "pause"), for: .normal)
            startTimer()
        }else{
            btLoopMode.setImage(UIImage(named: "play"), for: .normal)
            stopTimer()
        }
    }
    @IBAction func onShare(sender:UIButton){
        let firstActivityItem = photo?.name
        // If you want to put an image
        let image:UIImage = ivPhoto.image!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem!, image], applicationActivities: nil)
        
        activityViewController.isModalInPresentation = true

        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = .down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    @objc func swipeHandler(_ recognizer: UISwipeGestureRecognizer) {
        if (recognizer.direction == .left) {
            prevPhoto()
        } else if recognizer.direction == .right {
            nextPhoto()
        }
    }
    
    @objc func runTimedCode(_ timer: Timer) {
        nextPhoto()
    }
}
