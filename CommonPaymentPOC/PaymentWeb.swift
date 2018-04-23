//
//  PaymentWeb.swift
//  CommonPaymentPOC
//
//  Created by Ryan Spears on 2018-01-10.
//  Copyright © 2018 Canada Post Corporation. All rights reserved.
//

import UIKit
import WebKit

class PaymentWeb: UIViewController {

    var webView: WKWebView!
    
    @IBAction func dismissVC(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
}

extension PaymentWeb {
    
    override func loadView() {
        let contentController = WKUserContentController();
        
        //call a web javascript method after document is loaded
//        let userScript = WKUserScript(
//            source: "helloFromApp()",
//            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
//            forMainFrameOnly: true
//        )
//        contentController.addUserScript(userScript)

        //register a listener for self
        contentController.add(
            self,
            name: "callbackHandler"
        )
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.userContentController = contentController
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.canadapost.ca/cpo/mc/zDemo/mobile-test.html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }

}

struct PaymentData: Codable {
    var rs: Int
    var payload: String
}

extension PaymentWeb: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler" {
            if let paymentMessage = message.body as? Dictionary<String, AnyObject>,
                let token = paymentMessage["payload"] {
                UserDefaults.standard.set(token, forKey: "payload")
                UserDefaults.standard.synchronize()
                self.dismissVC(nil)
            }
        }
    }
    
    
}

