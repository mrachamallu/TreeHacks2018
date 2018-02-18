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


class CardViewController: UIViewController {
    
    @IBOutlet var swipeView: SwipeView!
 
    private var disposableBag = DisposeBag() // for error handling later
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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








