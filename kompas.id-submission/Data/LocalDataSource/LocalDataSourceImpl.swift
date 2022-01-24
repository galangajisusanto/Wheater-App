//
//  LocalDataSourceImpl.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 24/01/22.
//

import Foundation
import RxSwift


class LocalDataSourceImpl: LocalDataSource {
    let userDefaults = UserDefaults.standard
    let keyWheater = "keyWheater"
    
    func saveWheaterModel(model: WheaterModel) -> Completable {
        do{
            try userDefaults.setObject(model, forKey: keyWheater)
            return Completable.empty()
        } catch {
            return Completable.error(error)
        }
    }
    
    func getWheaterModel() -> Single<WheaterModel> {
        return Single.create { (observer) in
            do {
                let wheaterModel = try self.userDefaults.getObject(forKey: self.keyWheater, castTo: WheaterModel.self)
                observer(.success(wheaterModel))
            } catch {
                observer(.failure(error))
            }
            return Disposables.create()
        }
    }
    
    
    
    
    func saveWheaterModel(model: WheaterModel) throws {
    }
    
}
