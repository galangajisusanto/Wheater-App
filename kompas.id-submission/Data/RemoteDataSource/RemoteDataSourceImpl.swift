//
//  RemoteDataSourceImpl.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation
import RxSwift
import Alamofire

class RemoteDataSourceImpl: RemoteDataSource {
    
    private let url = "https://api.openweathermap.org/data/2.5/weather"
    
    func fectCurrentWheater(lat: Double, long: Double) -> Single<WheaterResponse> {
        
        let parameters: Parameters = [
            "lat" : lat,
            "lon" : long,
            "appid" : "477f9dd9658e66df97bfeecc601da683",
            "units" : "metric"
        ]
        
        return Single.create { (observer) in
            if let url = URL(string: self.url) {
                AF.request(url,method: .get, parameters: parameters)
                    .validate()
                    .responseDecodable(of: WheaterResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer(.success(value))
                        case .failure(let error):
                            print("error_nih", error.localizedDescription)
                            observer(.failure(error))
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
