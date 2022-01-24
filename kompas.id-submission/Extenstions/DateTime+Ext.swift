//
//  DateTime+Ext.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 24/01/22.
//

import Foundation

extension Date {
    func dateToDateTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.dateFormat = "dd/MM/yyyy h:mm a"
        let localDate = dateFormatter.string(from: self)
        return localDate
    }
}
