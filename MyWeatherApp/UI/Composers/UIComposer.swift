//
//  UIComposer.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 29/01/22.
//

import UIKit

public final class UIComposer {
    private init() {}
    
    public static func weatherViewComposedWith(weatherLoader: WeatherLoader) -> WeatherViewController {
        let weatherViewModel = WeatherViewModel(
            weatherLoader: MainQueueDispatchDecorator(decoratee: weatherLoader))
        
        let weatherViewController = WeatherViewController.makeWith(viewModel: weatherViewModel)
        
        return weatherViewController
    }
}

private extension WeatherViewController {
    static func makeWith(viewModel: WeatherViewModel) -> WeatherViewController {
        let bundle = Bundle(for: WeatherViewController.self)
        let storyboard = UIStoryboard(name: "Weather", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! WeatherViewController
        feedController.viewModel = viewModel
        return feedController
    }
}
