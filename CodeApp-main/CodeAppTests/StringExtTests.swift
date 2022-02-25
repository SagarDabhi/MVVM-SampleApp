//
//  StringExtTests.swift
//  CodeAppTests
//
//  Created by Sagar Dabhi on 28/01/22.
//

import XCTest
@testable import CodeApp

class StringExtTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStringExtension_convertDate() throws {
        let strDate = "2024-07-30T18:30:00.000Z"
        let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let strConvertTo = "MM-dd-yyyy"
        let result = strDate.convertToDateFormat(convertFrom: strConvertFrom, convertTo: strConvertTo)
        XCTAssertNotNil(result)
    }
    
    func testStringExtension_convertDate_DifferentType() throws {
        let strDate = "2024-07-30T18:30:00.000Z"
        let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let strConvertTo = "MM-dd-yyyy HH:mm a"
        let result = strDate.convertToDateFormat(convertFrom: strConvertFrom, convertTo: strConvertTo)
        XCTAssertNil(result)
    }
    
    func testStringExtension_convertDate_Different_From() throws {
         let strDate = "2022-01-28 17:30:00"
        let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss"
        let strConvertTo = "MM-dd-yyyy HH:mm a"
        
        let result = strDate.convertToDateFormat(convertFrom: strConvertFrom, convertTo: strConvertTo)
        XCTAssertNotNil(result)
    }
    
    func testStringExtension_convertDate_Different_To() throws {
         let strDate = "2022-01-28 17:30:00"
       let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss"
       let strConvertTo = "MM-dd-yyyy"
        
       let result = strDate.convertToDateFormat(convertFrom:strConvertFrom, convertTo: strConvertTo)
        XCTAssertNil(result)
    }
    
    func testStringExtension_convertDate_WrongDate() throws {
         let strDate = "2022-01-28 $%# 17:30:00"
       let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss"
       let strConvertTo = "MM2-dd-yyyy"
        
       let result = strDate.convertToDateFormat(convertFrom:strConvertFrom, convertTo: strConvertTo)
        XCTAssertNotEqual(result, strDate)
    }
    
    func testStringExtension_convertDate_WrongFormat() throws {
         let strDate = "2022-01-28 17:30:00"
       let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss"
       let strConvertTo = "MM2-dd-yyyy1"
        
       let result = strDate.convertToDateFormat(convertFrom:strConvertFrom, convertTo: strConvertTo)
        XCTAssertNotNil(result)
    }
    
    func testStringExtension_convertDate_nilDate() throws {
       let strDate = ""
       let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss"
        let strConvertTo = "MM2-dd-yyyy1"
        
       let result = strDate.convertToDateFormat(convertFrom:strConvertFrom, convertTo: strConvertTo)
        XCTAssertNotEqual(result, strDate)
    }
    
    func testStringExtension_convertDate_nilFromDate() throws {
       let strDate = "2022-01-28 17:30:00"
       let strConvertFrom = ""
        let strConvertTo = "MM-dd-yyyy"
        
       let result = strDate.convertToDateFormat(convertFrom:strConvertFrom, convertTo: strConvertTo)
    
        XCTAssertEqual(result, strDate)
    }
    
    func testStringExtension_convertDate_nilToDate() throws {
       let strDate = "2022-01-28 17:30:00"
       let strConvertFrom = "yyyy-MM-dd'T'HH:mm:ss"
        let strConvertTo = ""
        
       let result = strDate.convertToDateFormat(convertFrom:strConvertFrom, convertTo: strConvertTo)
        XCTAssertEqual(result, strDate)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
