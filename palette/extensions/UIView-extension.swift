//
//  UIView-extension.swift
//  palette
//
//  Created by Sam on 4/5/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration) {
                self.alpha = alpha
            }
        }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.3) {
        fadeTo(1.0, duration: duration)
    }
    
    func fadeOut(_ duration: TimeInterval = 0.3) {
        fadeTo(0.0, duration: duration)
    }
    
    func fade(_ duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 0
            }) { (completed) in
                UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve, animations: { () -> Void in
                    self.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    func flipFromBottom(_ duration: TimeInterval = 0.3) {
        DispatchQueue.main.async {
            self.alpha = 0
            UIView.transition(with: self, duration: duration, options: .transitionFlipFromBottom, animations: { () -> Void in
                self.alpha = 1
            }, completion: nil)
        }
    }
}
