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
import Kingfisher


class Card: SwipableView {
    var uiColorArray = [UIColor.blue, UIColor.red, UIColor.yellow, UIColor.green]
    func setData(_ data: SwipableData, titleVal: String, imageVal: String) {
        super.setData(data)
        let n = Int(arc4random_uniform(4))
        backgroundColor = uiColorArray[n]
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width - 100, height: 200))
        imageView.contentMode = .scaleAspectFit
        let url = URL(string: imageVal)
        //imageView.image =
        imageView.kf.setImage(with: url)
        imageView.center = CGPoint(x: center.x, y: center.y - 150)
        imageView.layer.cornerRadius = 10
        addSubview(imageView)
        
        let title = UILabel(frame: CGRect(x:0, y:0, width: frame.width - 100, height: 100))
        title.center = CGPoint(x: center.x, y: center.y + 50)
        title.text = titleVal
        title.textColor = UIColor.white
        title.textAlignment = .center
        title.numberOfLines = 5
        //title.backgroundColor = UIColor.clear
        title.font = UIFont(name: "HarabaraMaisBold-HarabaraMaisBold", size: 40)
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



