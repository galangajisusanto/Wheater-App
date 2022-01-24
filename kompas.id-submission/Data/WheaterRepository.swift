//
//  WheaterRepository.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation
import RxSwift

protocol WheaterRepository{
    func fetchCurentWheater(lat: Double, long: Double) -> Single<WheaterModel>
    func saveWheaterModel(model: WheaterModel)-> Completable
    func getWheaterModel() -> Single<WheaterModel>
}
