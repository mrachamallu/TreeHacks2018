//
//  MainViewController.swift
//  SpeakMarvel
//
//  Created by Meera Rachamallu on 2/16/18.
//  Copyright © 2018 meera. All rights reserved.
//

import UIKit
import KSSwipeStack
import RxSwift
import Alamofire
import SwiftyJSON



class CardViewController: UIViewController {
    
    @IBOutlet var swipeView: SwipeView!
    @IBOutlet weak var displayQuote: UILabel!
 
    private var disposableBag = DisposeBag() // for error handling later
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request("http://marvelous-195508.appspot.com/cards", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.displayQuote.text = json["quote"].string
                print("This is the quote: \(json["quote"] )")
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }
        
        // optional customization
        var swipeOptions = SwipeOptions()
        swipeOptions.allowVerticalSwipes = true
        swipeView.setup(options: swipeOptions)
        
        for _ in 1...15 {
            swipeView.addCard(ExampleData())
        }
        
        // even more optional, observe swipe view events
        swipeView.getSwipes().subscribe(onNext: { swipe in
            print("RX SWIPE EVENT: \(swipe.direction)")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposableBag)
        
        swipeView.needsRefill().subscribe(onNext: { swipe in
            print("RX REFILL EVENT")
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposableBag)
        
    }
}



class ExampleData: SwipableData {
    func getView(with frame: CGRect) -> SwipableView {
        let view = Card(frame: frame)
        view.setData(self)
        return view
    }
}








