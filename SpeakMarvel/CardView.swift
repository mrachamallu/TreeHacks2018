//
//  CardView.swift
//  SpeakMarvel
//
//  Created by Admin on 2/17/18.
//  Copyright © 2018 meera. All rights reserved.
//

import Foundation
import UIKit
import KSSwipeStack
import RxSwift

class Card: SwipableView {
    
    func setData(_ data: SwipableData, value: String) {
        super.setData(data)
        
        let title = UILabel(frame: CGRect(x:0, y:0, width: frame.width - 100, height: 100))
        title.center = CGPoint(x: center.x, y: center.y + 50)
        title.text = value
        title.textColor = .kicksortPink
        title.textAlignment = .center
        title.font = UIFont(name: "HarabaraMaisBold-HarabaraMaisBold", size: 30)
        addSubview(title)
        
    }
    
    

}

extension UIColor {
    public static var kicksortGray: UIColor {
        get {
            return UIColor(hex: 0x333333)
        }
    }
        
    public static var kicksortPink: UIColor {
        get {
            return UIColor(hex: 0xea1e63)
        }
    }
    
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert( red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red)/255.0,
                  green: CGFloat(green)/255.0,
                  blue: CGFloat(blue)/255.0,
                  alpha: 1.0)
        
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
            )
    }
    
}



