//
//  WeatherLoader.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 09/01/22.
//

import Foundation

public protocol WeatherLoader {
    typealias Result = Swift.Result<[Weather], Error>

    func load(completion: @escaping (Result) -> Void)
}

public final class RemoteWeatherLoader: WeatherLoader {
    
    private let url = "https://mocki.io/v1/d421adf1-1445-491c-aff6-577b68b4487e"
    private let client: HTTPClient
    
    init(client: HTTPClient) {
        self.client = client
    }
    
    public enum Error: Swift.Error {
        case invalidURL
        case connectivity
        case invalidData
    }
    
    public func load(completion: @escaping (WeatherLoader.Result) -> Void) {
        guard let url = URL(string: url) else {
            return completion(.failure(Error.invalidURL))
        }
        
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                completion(WeatherMapper.map(data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
    
}
