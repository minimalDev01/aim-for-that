//
//  AboutAsViewController.swift
//  AimForThat
//
//  Created by Sergio Carralero Nuño on 24/11/20.
//

import UIKit
import WebKit

class AboutAsViewController: UIViewController {

    /* Better use a text input, engouht latency with this method */
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = Bundle.main.url(forResource: "AimForThat", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                self.webView.load(htmlData, mimeType: "text/html", characterEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }
    
    @IBAction func backPress(){
        dismiss(animated: true, completion: nil)
    }
    
}
