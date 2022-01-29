//
//  WeatherCondition.swift
//  SwiftPlayground
//
//  Created by Augusto Monteiro on 06/01/22.
//

import Foundation

enum ConditionType: Int {
    case none
    case sunnyDay
    case clearNight
    case cloudy
    case raining
    case snowing
}

extension ConditionType {
    var systemImage: String {
        switch self {
        case .none: return ""
        case .sunnyDay: return "sun.max"
        case .clearNight: return "moon"
        case .cloudy: return "cloud"
        case .raining: return "cloud.rain"
        case .snowing: return "snow"
        }
    }
}
