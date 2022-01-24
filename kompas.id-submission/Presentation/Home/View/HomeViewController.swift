//
//  HomeViewController.swift
//  kompas.id-submission
//
//  Created by Galang Aji Susanto on 23/01/22.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var scroolView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var sunriseView: UIView!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetView: UIView!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var presureView: UIView!
    @IBOutlet weak var presureLabel: UILabel!
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var createdByView: UIView!
    @IBOutlet weak var createdByLabel: UILabel!
    
    let injection = Injection()
    var homeViewModel: HomeViewModel?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupBackgroundColor()
        setupViewModel()
        setupBinding()
        fetchCurentWheater()
    }
    
    
//    func getMapCountAlphabet (text: String) -> [Character : Int] {
//        
//        var mapCount = [Character: Int]()
//        
//        for char in text {
//            if ()
//        }
//        
//        
//    }
    
    private func setupBackgroundColor() {
        let colorTop = UIColor.systemIndigo.cgColor
        let colorBottom = UIColor.purple.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.colors = [colorTop, colorBottom]
        self.contentView.layer.insertSublayer(gradientLayer, at: 0)
        self.view.backgroundColor = .systemIndigo
        self.sunriseView.backgroundColor = .white.withAlphaComponent(0.2)
        self.sunsetView.backgroundColor = .white.withAlphaComponent(0.2)
        self.windView.backgroundColor = .white.withAlphaComponent(0.2)
        self.presureView.backgroundColor = .white.withAlphaComponent(0.2)
        self.humidityView.backgroundColor = .white.withAlphaComponent(0.2)
        self.createdByView.backgroundColor = .white.withAlphaComponent(0.2)
    }
    
    private func setupRefreshControl() {
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.scroolView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        fetchCurentWheater()
        self.refreshControl.endRefreshing()
    }
    
    private func setupViewModel() {
        self.homeViewModel = injection.provideHomeViewModel()
    }
    
    private func setupBinding() {
        homeViewModel?.wheaterModel.subscribe(
            onNext: { result in
                self.setUI(model: result)
            }
        ).disposed(by: disposeBag)
        
        homeViewModel?.errorMessage.subscribe(onNext: { error in
            self.showAllert(title: "Error", subtitle: error.localizedDescription)
        }).disposed(by: disposeBag)
        
        homeViewModel?.loadingState.subscribe(
            onNext: { status in
                if status {
                    self.startActivityIndicator()
                } else {
                    self.stopActivityIndicator()
                }
            }).disposed(by: disposeBag)
    }
    
    private func fetchCurentWheater() {
        homeViewModel?.fetchWheater(lat: -6.200000, long: 106.816666)
    }
    
    private func setUI(model wheaterModel: WheaterModel) {
        cityLabel.text = wheaterModel.city
        dateTimeLabel.text = "Updated: \(wheaterModel.dateTime)"
        weatherLabel.text = wheaterModel.wheater
        tempLabel.text = "\(wheaterModel.temp) °C"
        minTempLabel.text = "Min Temp: \(wheaterModel.tempMin) °C"
        maxTempLabel.text = "Max Temp: \(wheaterModel.tempMax) °C"
        sunriseLabel.text = "\(wheaterModel.sunrise.unixUTCToTimeString())"
        sunsetLabel.text = "\(wheaterModel.sunset.unixUTCToTimeString())"
        windLabel.text = "\(wheaterModel.windSpeed)"
        presureLabel.text = "\(wheaterModel.pressure)"
        humidityLabel.text = "\(wheaterModel.humidity)"
        createdByLabel.text = wheaterModel.cretedBy
    }
    
}
