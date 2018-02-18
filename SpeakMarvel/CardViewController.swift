//
//  MainViewController.swift
//  SpeakMarvel
//
//  Created by Meera Rachamallu on 2/16/18.
//  Copyright © 2018 meera. All rights reserved.
//

import UIKit
import CardsLayout

class CardViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardCollectionView.collectionViewLayout = CardsCollectionViewLayout()
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
        cardCollectionView.isPagingEnabled = true
        cardCollectionView.showsHorizontalScrollIndicator = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

var colors: [UIColor] = [
    UIColor(red: 237, green: 37, blue: 78),
    UIColor(red: 249, green: 220, blue: 92),
    UIColor(red: 194, green: 234, blue: 189),
    UIColor(red: 1,   green: 25,  blue: 54),
    UIColor(red: 255, green: 184, blue: 209)
]

// CONFORM. TO. THE PROTOCOL!
extension CardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Tell the collection view how MANY cards to show
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    // Tell the collectionview how to display the cards
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellReuseIdentifier", for: indexPath)
        cell.layer.cornerRadius = 7.0
        cell.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


// because we clean like dis
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: 1.0)
    }
}



