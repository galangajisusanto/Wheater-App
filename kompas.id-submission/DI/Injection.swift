//
//  Injection.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation


final class Injection: NSObject{
    private func provideRemoteDataSource() ->  RemoteDataSource {
        return RemoteDataSourceImpl()
    }
    private func provideLocalDataSource() -> LocalDataSource {
        return LocalDataSourceImpl()
    }
    
    private func provideWheaterRepository() -> WheaterRepository {
        let remoteDataSource = provideRemoteDataSource()
        let localDataSource = provideLocalDataSource()
        return WheaterRepositoryImpl(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
    }
    
    func provideHomeViewModel() -> HomeViewModel {
        return HomeViewModel(repository: provideWheaterRepository())
    }
    
}
