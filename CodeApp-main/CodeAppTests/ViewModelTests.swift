//
//  ViewModelTest.swift
//  CodeAppTests
//
//  Created by Sagar Dabhi on 28/01/22.
//

import XCTest
@testable import CodeApp

class MockNetworkRequestManager: WebServiceHandlerProtocol {
    
    enum ResponseType {
        case error
        case success
    }
    
    var responseType: ResponseType = .error
    
    func getWebService(wsMethod: URL, complete: @escaping ([String : Any]?) -> Void) {
        switch responseType {
        case .error:
            complete(nil)
        case .success:
            let t = type(of: self)
            let bundle = Bundle(for: t.self)
            let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
            let data = try! Data(contentsOf: path)
            let json = try! JSONSerialization.jsonObject(with: data, options: [])
            complete(["data": json])
        }
    }
}

class ViewModelTest: XCTestCase {

    var viewModelTest: ContestsViewModel!
    var mockRequestManager: MockNetworkRequestManager!
    
    override func setUpWithError() throws {
        viewModelTest = ContestsViewModel()
        mockRequestManager = MockNetworkRequestManager()
        prepareMockData()
    }
    
    override func tearDownWithError() throws {
//        viewModelTest = nil
//        mockRequestManager = nil
    }

    func prepareMockData() {
        let t = type(of: self)
        let bundle = Bundle(for: t.self)
        let path = bundle.url(forResource: "sampleResponse", withExtension: "json")!
        let data = try! Data(contentsOf: path)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        do {
            let contests = try JSONDecoder().decode([Contests].self, from: ((["data": json] as! NSDictionary).dataReturn()!))
            viewModelTest.objContestsList = contests
            viewModelTest.objTempContestsList = contests
        } catch let err {
            print("Error while converting data into model", err.localizedDescription)
        }
    }
    
    func testFetchContestApi() throws {
        mockRequestManager.getWebService(wsMethod: API.all.url) {data in
            XCTAssertTrue(data == nil)
        }
    }

    func testViewModel_SearchNameFromData_IsEmpty() {
        viewModelTest.filterData(strSerchText: "") { isSuccess in
            XCTAssert(isSuccess)
        }
    }
    
    func testViewModel_SearchNameFromData_WithString() {
        viewModelTest.filterData(strSerchText: "hi") { isSuccess in
            XCTAssert(isSuccess)
        }
    }
    
    func testViewModel_SearchNameFromData_WithSpecialCharacter() {
        viewModelTest.filterData(strSerchText: "(*/") { isSuccess in
            XCTAssert(isSuccess)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
