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
        let userScript = WKUserScript(
            source: "helloFromApp()",
            injectionTime: WKUserScriptInjectionTime.atDocumentEnd,
            forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        
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
        
        let myURL = URL(string: "http://localhost:8080")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }

}

extension PaymentWeb: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "callbackHandler" {
            let paymentMessage = message.body as? String
            let components = paymentMessage?.components(separatedBy: [":"])
            if let token = components?.last {
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.synchronize()
                self.dismissVC(nil)
            }
            
        }
    }
    
    
}

