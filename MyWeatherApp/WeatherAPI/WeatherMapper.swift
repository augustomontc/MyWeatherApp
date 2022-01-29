//
//  WeatherMapper.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 29/01/22.
//

import Foundation

final class WeatherMapper {
    
    /*
     [
        {
           "location": "Belo Horizonte",
           "temperature":{
              "celsius": 24.5,
              "farenheit": 76.1
           },
            "condition": {
              "type": 1,
              "description": "Sunny day"
           }
        }
     ]
     */
    
    private struct WeatherDTO: Decodable {
        let location: String?
        let temperature: TemperatureDTO
        let condition: ConditionDTO
        
        var model: Weather {
            return Weather(location: location ?? "", temperature: temperature.model, condition: condition.model)
        }
    }

    private struct TemperatureDTO: Decodable {
        let celsius: Double
        let farenheit: Double
        
        var model: Temperature {
            return Temperature(celsius: celsius, farenheit: farenheit)
        }
    }

    private struct ConditionDTO: Decodable {
        let type: Int
        let description: String?
        
        var model: Condition {
            return Condition(type: ConditionType(rawValue: type) ?? .none, description: description ?? "")
        }
    }

    
    static func map(_ data: Data, from response: HTTPURLResponse) -> WeatherLoader.Result {
        guard response.statusCode == 200, let itemsDTO = try? JSONDecoder().decode([WeatherDTO].self, from: data) else {
            return .failure(RemoteWeatherLoader.Error.invalidData)
        }
        
        let items = itemsDTO.map { $0.model }
        return .success(items)
    }
    
}
