//
//  RemoteDataSource.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation
import RxSwift

protocol RemoteDataSource {
    func fectCurrentWheater(lat: Double, long: Double) -> Single<WheaterResponse>
}
