//
//  HTTPClient.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 29/01/22.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func get(from url: URL, completion: @escaping (Result) -> Void)
}

final class URLSessionClient: HTTPClient {

    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse {
                completion(.success((data,response)))
            } else if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
