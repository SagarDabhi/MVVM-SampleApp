//
//  BaseVC.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 28/01/22.
//

import Foundation
import UIKit
import SafariServices
class BaseVC: UIViewController {
    
    func setTitle(strTitle: String) {
        title = strTitle
    }
    
    func openURL(strUrl: String) {
        if let url = URL(string: strUrl) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
