//
//  Double+Ext.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 24/01/22.
//

import Foundation

extension Int {
    
    func unixUTCToTimeString() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "h:mm a"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
}
