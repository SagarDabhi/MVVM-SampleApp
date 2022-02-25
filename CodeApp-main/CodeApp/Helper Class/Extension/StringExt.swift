//
//  StringExt.swift
//  CodeApp
//
//  Created by Sagar Dabhi on 28/01/22.
//

import Foundation

extension String {
    func convertToDateFormat(convertFrom: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", convertTo: String = "MM-dd-yyyy") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = convertFrom
        guard let date = dateFormatter.date(from: self) else {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss UTC"
            dateFormatter.dateFormat = convertTo
            guard let date = dateFormatter.date(from: self) else {
                return self
            }
            return dateFormatter.string(from: date)
        }
        dateFormatter.dateFormat = convertTo
        return dateFormatter.string(from: date)
    }
}
