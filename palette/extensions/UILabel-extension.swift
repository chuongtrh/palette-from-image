//
//  UILabel-extension.swift
//  palette
//
//  Created by Sam on 4/6/20.
//  Copyright © 2020 Sam. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setTextOutline(text:String, font: UIFont, strokeColor: UIColor, foregroundColor: UIColor){
        let strokeTextAttributes = [
          NSAttributedString.Key.strokeColor : strokeColor,
          NSAttributedString.Key.foregroundColor : foregroundColor,
          NSAttributedString.Key.strokeWidth : -1.0,
          NSAttributedString.Key.font : font]
          as [NSAttributedString.Key : Any]

        self.attributedText = NSMutableAttributedString(string: text, attributes: strokeTextAttributes)
    }
}
