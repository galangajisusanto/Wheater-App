//
//  kompas_id_submissionTests.swift
//  kompas.id-submissionTests
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import XCTest
@testable import kompas_id_submission
import RxSwift

class kompas_id_submissionTests: XCTestCase {
    
    static var wheaterMock = WheaterModel(
        temp: 0.0,
        tempMin: 0.0,
        tempMax: 0.0,
        windSpeed: 0.0,
        sunrise: 0,
        sunset: 0,
        pressure: 0,
        humidity: 0,
        cretedBy: "",
        dateTime: "",
        city: "",
        wheater: ""
    )
    
    static var responseJson: String = """
    {
        "coord": {
            "lon": 106.8167,
            "lat": -6.2
        },
        "weather": [
            {
                "id": 802,
                "main": "Clouds",
                "description": "scattered clouds",
                "icon": "03d"
            }
        ],
        "base": "stations",
        "main": {
            "temp": 306.93,
            "feels_like": 313.93,
            "temp_min": 305.17,
            "temp_max": 307.25,
            "pressure": 1005,
            "humidity": 58
        },
        "visibility": 7000,
        "wind": {
            "speed": 3.09,
            "deg": 240
        },
        "clouds": {
            "all": 40
        },
        "dt": 1643007348,
        "sys": {
            "type": 1,
            "id": 9383,
            "country": "ID",
            "sunrise": 1642978338,
            "sunset": 1643023009
        },
        "timezone": 25200,
        "id": 1642911,
        "name": "Jakarta",
        "cod": 200
    }
    """
    
    let disposeBag = DisposeBag()
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRemoteDataSource() throws {
        // Given
        let dataSource = RemoteDataSourceMock(_endpoint: "https://api.openweathermap.org/data/2.5/weather")
        var test: WheaterResponse?
        // When
        dataSource.fectCurrentWheater(lat: -54, long: 393)
            .subscribe { result in
                test = result
            }.disposed(by: disposeBag)
        XCTAssertTrue(dataSource.verify())
        XCTAssertNotNil(test)
    }
    
    func testLocalDataSource() throws {
        let dataSource = LocalDataSourceMock()
        
        
        //~ Save Test
        
        let testWheater = WheaterModel(
            temp: 26.0,
            tempMin: 27.4,
            tempMax: 32.4,
            windSpeed: 1.4,
            sunrise: 100000,
            sunset: 100000,
            pressure: 1003,
            humidity: 13,
            cretedBy: "Galang",
            dateTime: "23 February 2022",
            city: "Jakarta ID",
            wheater: "Cloudy"
        )
        
        dataSource.saveWheaterModel(model: testWheater)
        XCTAssertTrue(dataSource.saveVerify())
        
        //~ Get Test
        dataSource.getWheaterModel()
            .subscribe { result in
                XCTAssertEqual(result, testWheater)
            }.disposed(by: disposeBag)
        XCTAssertTrue(dataSource.getVerify())
        
        
    }
    
}

extension kompas_id_submissionTests {
    
    class RemoteDataSourceMock: RemoteDataSource {
        
        internal init(_endpoint: String) {
            self._endpoint = _endpoint
        }
        
        var _endpoint: String
        
        var functionWasCalled = false
        
        func fectCurrentWheater(lat: Double, long: Double) -> Single<WheaterResponse> {
            return Single.create { (observer) in
                if URL(string: self._endpoint) != nil {
                    if !self._endpoint.isEmpty {
                        do {
                            let value = try JSONDecoder().decode(WheaterResponse.self, from: Data(responseJson.utf8))
                            observer(.success(value))
                            self.functionWasCalled = true
                        } catch {
                            observer(.failure(error))
                        }
                    }
                }
                return Disposables.create()
            }
        }
        
        func verify() -> Bool {
            return functionWasCalled
        }
    }
    
    
    class LocalDataSourceMock: LocalDataSource {
        
        var saveFunctionWasCalled = false
        var getFunctionWasCalled = false
        
        func saveWheaterModel(model: WheaterModel) -> Completable {
            saveFunctionWasCalled = true
            wheaterMock = model
            return Completable.empty()
        }
        
        func getWheaterModel() -> Single<WheaterModel> {
            return Single.create { (observer) in
                self.getFunctionWasCalled = true
                observer(.success(wheaterMock))
                return Disposables.create()
            }
        }
        
        func saveVerify() -> Bool {
            return saveFunctionWasCalled
        }
        
        func getVerify() -> Bool {
            return getFunctionWasCalled
        }
    }
}
