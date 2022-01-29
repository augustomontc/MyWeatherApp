//
//  Localized.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 09/01/22.
//

import Foundation

final class Localized {
    static var bundle: Bundle {
        Bundle(for: Localized.self)
    }
}

extension Localized {
    enum WeatherView {
        static var table: String { "Weather" }

        static var title: String {
            NSLocalizedString(
                "WEATHER_VIEW_TITLE",
                tableName: table,
                bundle: bundle,
                comment: "Title for the weather view")
        }

        static var loadError: String {
            NSLocalizedString(
                "WEATHER_VIEW_CONNECTION_ERROR",
                tableName: table,
                bundle: bundle,
                comment: "Error message displayed when the weather couldn't be loaded from the server")
        }
    }
}
