//
//  Weather.swift
//  SwiftPlayground
//
//  Created by Augusto Monteiro on 06/01/22.
//

import Foundation

public struct Weather {
    let location: String
    let temperature: Temperature
    let condition: Condition
}

public struct Temperature {
    let celsius: Double
    let farenheit: Double
}

public struct Condition {
    let type: ConditionType
    let description: String
}
