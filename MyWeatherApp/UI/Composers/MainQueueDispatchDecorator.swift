//
//  MainQueueDispatchDecorator.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 29/01/22.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T

    init(decoratee: T) {
        self.decoratee = decoratee
    }

    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }

        completion()
    }
}

extension MainQueueDispatchDecorator: WeatherLoader where T == WeatherLoader {
    func load(completion: @escaping (WeatherLoader.Result) -> Void) {
        decoratee.load { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
