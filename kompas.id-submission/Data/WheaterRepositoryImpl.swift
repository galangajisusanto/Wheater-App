//
//  WheaterRepositoryImpl.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation
import RxSwift

class WheaterRepositoryImpl: WheaterRepository {
    
    
    
    var remoteDataSource: RemoteDataSource
    var localDataSource: LocalDataSource
    
    init(remoteDataSource: RemoteDataSource, localDataSource: LocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    
    func fetchCurentWheater(lat: Double, long: Double) -> Single<WheaterModel> {
        
        switch Reachability.isConnectedToNetwork() {
        case true :
            return remoteDataSource.fectCurrentWheater(lat: lat, long: long).map { response in
                let wheaterModel =  self.mapResponseToModelWheater(response: response)
                self.saveWheaterModel(model: wheaterModel)
                return wheaterModel
            }
        case false:
            return getWheaterModel()
        }
    }
    
    func saveWheaterModel(model: WheaterModel) -> Completable {
        return localDataSource.saveWheaterModel(model: model)
    }
    
    func getWheaterModel() -> Single<WheaterModel> {
        return localDataSource.getWheaterModel()
    }
    
    
    private func mapResponseToModelWheater(response: WheaterResponse) -> WheaterModel {
        let wheater = response.weather.first?.main ?? ""
        return WheaterModel(
            temp: response.main.temp,
            tempMin: response.main.tempMin,
            tempMax: response.main.tempMax,
            windSpeed: response.wind.speed,
            sunrise: response.sys.sunrise,
            sunset: response.sys.sunset,
            pressure: response.main.pressure,
            humidity: response.main.humidity,
            cretedBy: "Galang",
            dateTime: Date.now.dateToDateTimeString(),
            city: "\(response.name) \(response.sys.country)" ,
            wheater: wheater)
    }
}
