//
//  DongtaiDetailViewController.swift
//  T_New
//
//  Created by C.z on 2020/5/27.
//  Copyright © 2020 C.z. All rights reserved.
//

import UIKit
import WebKit

class DongtaiDetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var url: String = ""
    
    @IBOutlet weak var shareWeb: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("url ---- \(url)")
        self.shareWeb.load(URLRequest(url: URL(string: url)!))
    }
}

extension DongtaiDetailViewController{
    
}
