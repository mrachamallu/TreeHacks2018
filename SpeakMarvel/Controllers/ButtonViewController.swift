//
//  ButtonViewController.swift
//  SpeakMarvel
//
//  Created by Admin on 2/17/18.
//  Copyright © 2018 meera. All rights reserved.
//

import Foundation
import UIKit

class ButtonViewController: UIViewController {
    @IBAction func spiderButton(_ sender: Any) {
        performSegue(withIdentifier: "toCardViewController", sender: nil)
    }
    
    
    override func viewDidLoad() {
        print("")
    }
    
    
}
