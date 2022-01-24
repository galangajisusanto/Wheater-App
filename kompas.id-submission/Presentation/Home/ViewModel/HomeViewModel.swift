//
//  HomeViewModel.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    private let repository: WheaterRepository
    private let disposeBag = DisposeBag()
    
    let wheaterModel = PublishSubject<WheaterModel>()
    var errorMessage = PublishSubject<Error>()
    var loadingState = PublishSubject<Bool>()
    
    init(repository: WheaterRepository) {
        self.repository = repository
    }
    
    func fetchWheater(lat: Double, long: Double) {
        loadingState.onNext(true)
        repository.fetchCurentWheater(lat: lat, long: long)
            .subscribe { result in
                self.loadingState.onNext(false)
                self.wheaterModel.onNext(result)
            } onFailure: { error in
                self.loadingState.onNext(false)
                self.errorMessage.onNext(error)
            } .disposed(by: disposeBag)
    }
}
