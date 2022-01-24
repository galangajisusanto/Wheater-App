//
//  WheaterModel.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation


struct WheaterModel: Codable, Equatable {
    let temp, tempMin, tempMax, windSpeed: Double
    let sunrise, sunset, pressure, humidity: Int
    let cretedBy, dateTime, city, wheater: String
}
