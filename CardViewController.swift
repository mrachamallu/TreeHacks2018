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
        let parameters: Parameters = [
            "characterId": "1009610",
            "limit": 10
        ]

        Alamofire.request("http://marvelous-195508.appspot.com/cards", method: .get, parameters: parameters).validate().responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
//                            self.swipeView. = json[0]["name"].string
//                            self.displayQuote.text = json[0]["name"].string
//                            print("This is the name: \(json[0]["name"].string )")
//                            print("JSON: \(json)")
                            
                            // optional customization
                            var swipeOptions = SwipeOptions()
                            swipeOptions.allowVerticalSwipes = true
                            self.swipeView.setup(options: swipeOptions)
                            
                            for i in 1...10 {
                                if let title = json[i]["name"].string{
                                    var exampleData = ExampleData(title: title)
                                    self.swipeView.addCard(exampleData)
                                }
                                
                            }
                            
                            // even more optional, observe swipe view events
                            self.swipeView.getSwipes().subscribe(onNext: { swipe in
                                print("RX SWIPE EVENT: \(swipe.direction)")
                            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposableBag)
                            
                            self.swipeView.needsRefill().subscribe(onNext: { swipe in
                                print("RX REFILL EVENT")
                            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposableBag)
                        case .failure(let error):
                            print(error)
                        }
                    }

        
    }
}



class ExampleData: SwipableData {
    
    var title: String
    
    func getView(with frame: CGRect) -> SwipableView {
        let view = Card(frame: frame)
        view.setData(self, value: self.title)
        return view
    }
    
    init(title: String) {
        self.title = title
    }
}








