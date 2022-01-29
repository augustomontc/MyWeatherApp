//
//  WeatherCell.swift
//  SwiftPlayground
//
//  Created by Augusto Monteiro on 06/01/22.
//

import UIKit

final class WeatherCell: UITableViewCell {
    
    @IBOutlet private(set) public var cellView: UIView!
    @IBOutlet private(set) public var locationLabel: UILabel!
    @IBOutlet private(set) public var descriptionLabel: UILabel!
    @IBOutlet private(set) public var temperatureLabel: UILabel!
    @IBOutlet private(set) public var weatherIcon: UIImageView!
    
    enum PresentationMode {
        case celsius
        case farenheit
    }
    
    func configure(with weather: Weather, presenting mode: PresentationMode) {
        cellView.addViewBorder(borderColor: UIColor.gray.cgColor, borderWith: 1.0, borderCornerRadius: 16.0)
        setLocationLabel(weather.location)
        setDescriptionLabel(weather.condition.description)
        setTemperatureLabel(weather.temperature, presenting: mode)
        setIconImage(weather.condition.type.systemImage)
    }
    
    private func setLocationLabel(_ text: String) {
        locationLabel.addDropShadow()
        locationLabel.text = text
    }
    
    private func setDescriptionLabel(_ text: String) {
        descriptionLabel.addDropShadow()
        descriptionLabel.text = text
    }
    
    private func setTemperatureLabel(_ temperature: Temperature, presenting mode: PresentationMode) {
        temperatureLabel.addDropShadow()
        switch mode {
        case .celsius:
            temperatureLabel.text = String(format: "%.0fº", temperature.celsius)
        case .farenheit:
            temperatureLabel.text = String(format: "%.0fº", temperature.farenheit)
        }
    }
    
    private func setIconImage(_ imageName: String) {
        weatherIcon.image = UIImage(systemName: imageName)
    }
}

extension UILabel {
    func addDropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
}

extension UIView {
    func addViewBorder(borderColor:CGColor, borderWith:CGFloat, borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
    }
}
