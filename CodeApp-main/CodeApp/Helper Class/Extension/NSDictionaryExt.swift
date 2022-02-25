//
//  NSDictionaryExt.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 27/01/22.
//

import Foundation
import UIKit
extension NSDictionary {
    /// decoding json value and convert it into data
    func dataReturn() -> Data? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self.value(forKey: "data") as Any, options: .prettyPrinted)
                
                let reqJSONStr = String(data: jsonData, encoding: .utf8)
                let data = reqJSONStr?.data(using: .utf8)
                return data
        } catch let err {
            print("Error while converting data", err.localizedDescription)
            return nil
        }
    }
}
