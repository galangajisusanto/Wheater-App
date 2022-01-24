//
//  LocalDataSource.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 24/01/22.
//

import RxSwift

protocol LocalDataSource {
    func saveWheaterModel(model: WheaterModel) -> Completable
    func getWheaterModel() -> Single<WheaterModel>
}
