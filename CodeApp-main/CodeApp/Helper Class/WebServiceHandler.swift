//
//  WebServiceHandler.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 27/01/22.
//


import Foundation

enum API : String {
    static let BaseURL = "https://kontests.net/api/v1/"
    case all = "all"
    
    var url : URL {
        get{
            return URL(string: API.BaseURL + self.rawValue)! 
        }
    }
}

protocol WebServiceHandlerProtocol {
    func getWebService(wsMethod: URL, complete:@escaping (_ response: [String:Any]?) -> Void)
}

class WebServiceHandler: WebServiceHandlerProtocol {
    static let shared = WebServiceHandler()
    
    func getWebService(wsMethod: URL, complete:@escaping (_ response: [String:Any]?) -> Void) {
    
        let session = URLSession.shared
        let request = URLRequest(url: wsMethod)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                complete(nil)
                return
            }
            
            guard let data = data else {
                complete(nil)
                return
            }
            
            if let response = response as?
                HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        complete(["data": json])
                    } catch {
                        print(error)
                        complete(nil)
                    }
                    break
                default:
                    print("Err Status Code: \(response.statusCode)")
                    complete(nil)
                }
            }
        })
        task.resume()
    }
}

