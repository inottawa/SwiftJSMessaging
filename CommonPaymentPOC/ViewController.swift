//
//  ViewController.swift
//  CommonPaymentPOC
//
//  Created by Ryan Spears on 2018-01-10.
//  Copyright © 2018 Canada Post Corporation. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var paymentTokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let paymentToken = UserDefaults.standard.value(forKey: "token") as? String {
            paymentTokenLabel.text = paymentToken
            UserDefaults.standard.set(nil, forKey: "token")
            UserDefaults.standard.synchronize()
        }
    }

}

