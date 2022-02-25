//
//  DashboardViewModel.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 27/01/22.
//

import Foundation

class ContestsViewModel {
    var objContestsList = [Contests]()
    var objTempContestsList = [Contests]()
    
    /// contest list fetch and save data into the variable
    func apiFetchContests(completion :@escaping (_ isSuccess : Bool?) -> Void) {
        LoadingView.display(true)
        WebServiceHandler.shared.getWebService(wsMethod: API.all.url) { data in
            do {
                if let data = data {
                    let contests = try JSONDecoder().decode([Contests].self, from: ((data as NSDictionary).dataReturn()!))
                    self.objContestsList = contests
                    self.objTempContestsList = contests
                    LoadingView.display(false)
                    completion(true)
                }
            } catch let err {
                print("Error while converting data into model", err.localizedDescription)
                completion(false)
            }
        }
    }
    
    func filterData(strSerchText: String, completion: @escaping (_ isSuccess: Bool)->Void) {
        
        if strSerchText == "" {
            completion(false)
            return
        }
        objContestsList = strSerchText.count == 0 ? objTempContestsList :  objTempContestsList.filter { singleContest in
            singleContest.name!.lowercased().contains(strSerchText.lowercased())
        }
        completion(objContestsList.count > 0 ? true : false)
    }
}
