//
//  WeatherViewModel.swift
//  SwiftPlayground
//
//  Created by Augusto Monteiro on 06/01/22.
//

import Foundation

final class WeatherViewModel {
    typealias Observer<T> = (T) -> Void
    
    var onLoadingStateChange: Observer<Bool>?
    var onWeatherLoad: Observer<Void>?
    var onErrorStateChange: Observer<String?>?
    
    private let weatherLoader: WeatherLoader

    init(weatherLoader: WeatherLoader) {
        self.weatherLoader = weatherLoader
    }
    
    var weatherList: [Weather]? {
        didSet {
            onWeatherLoad?(())
        }
    }
    
    var screenTitle: String {
        Localized.WeatherView.title
    }
    
    private var loadError: String {
        Localized.WeatherView.loadError
    }
    
    func loadWeather() {
        onLoadingStateChange?(true)
        onErrorStateChange?(nil)
        weatherLoader.load { [weak self] result in
            switch result {
            case let .success(weatherList):
                self?.weatherList = weatherList
            case .failure:
                self?.onErrorStateChange?(self?.loadError)
            }
            self?.onLoadingStateChange?(false)
        }
        
    }
    
}
