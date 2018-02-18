//
//  CardsViewController.swift
//  SpeakMarvel
//
//  Created by Meera Rachamallu on 2/17/18.
//  Copyright © 2018 meera. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import HoundifySDK

class CardsViewController: UIViewController {

    @IBOutlet weak var displayQuote: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
//            if((responseData.result.value) != nil) {
//                let swiftyJsonVar = JSON(responseData.result.value!)
//                print(swiftyJsonVar)
//            }
//        }
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
