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
import HoundifySDK


class CardViewController: UIViewController {
    
    fileprivate func dismissSearch() {
        
        Houndify.instance().dismissListeningViewController(animated: true, completionHandler: nil)
    }
    @IBAction func microphonePress(_ sender: Any) {
        
        Houndify.instance().presentListeningViewController(in: self,
                                                           from: nil,
                                                           style: nil,
                                                           requestInfo: [:],
                                                           responseHandler:
            { (error: Error?, response: Any?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
                
                
                if  let serverData = response as? HoundDataHoundServer,
                    let commandResult = serverData.allResults?.firstObject() as? HoundDataCommandResult,
                    let nativeData = commandResult["NativeData"]
                {
                    let myStringDict = nativeData as? [String : AnyObject]
                    let test = myStringDict!["RawTranscription"]! as! String
                    print(myStringDict!["RawTranscription"]!)
                    print("Using the Houndify API")
                    if player.currentQuote.checkQuoteSaidIsCorrect(spokenQuote:test)
                    {
                        //code to change the image here and update stuff
                        player.updateScore(spokenSentence: test)
                        
                    }
                    player.updateDifficulty()
                    //here is where we update everything
                }
                
                self.dismissSearch()
        }
        )
        
    }
    
    @IBOutlet var swipeView: SwipeView!

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
                                let title = json[i]["quote"].string
                                let image = json[i]["image"].string
                                let char = json[i]["name"].string
                                
                                
                                //let image = json[i]["image"].string
                                if ((title != nil) ) {
                                    let exampleData = ExampleData(title: title!, char: char!, image: image!)
                                    self.swipeView.addCard(exampleData)
                                }

                            }

                            // even more optional, observe swipe view events
                            self.swipeView.getSwipes().subscribe(onNext: { swipe in
                                print("RX SWIPE EVENT: \(swipe.direction)")
                            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: self.disposableBag)
                            print("Using the Alamofire API")

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
    var char: String
    var image: String

    func getView(with frame: CGRect) -> SwipableView {
        let view = Card(frame: frame)
        view.setData(self, titleVal: self.title)
        player.updateQuote(quote: Quote(quote: self.title, character: self.char, imageURL: self.image))
        //view.setData(self, imageVal: self.image)
        return view
    }

    init(title: String, char: String, image: String) {
        self.title = title
        self.char = char
        self.image = image
        //self.image = image
    }
}









