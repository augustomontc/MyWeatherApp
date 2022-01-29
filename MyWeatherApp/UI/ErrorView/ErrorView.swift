//
//  ErrorView.swift
//  MyWeatherApp
//
//  Created by Augusto Monteiro on 22/01/22.
//

import UIKit

@IBDesignable
class ErrorView: UIStackView {
    
    @IBInspectable var message: String? = "" {
        didSet { setupView() }
    }
    
    @IBInspectable var imageSystemName: String = "" {
        didSet { setupView() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }
    
    // MARK: - Setup View
    private func setupView() {
        setupStackView()
        setupOtherViews()
    }
    
    private func setupStackView() {
        alpha = 0
        layer.cornerRadius = 8
        backgroundColor = .red
        axis = .vertical
    }
    
    private func setupOtherViews() {
        prepareForReuse()
        setupInnerStackView()
        setupImageView()
        setupMessageLabel()
    }
    
    private func prepareForReuse() {
        arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    var innerStackView = UIStackView(frame: CGRect.zero)
    private func setupInnerStackView() {
        innerStackView = UIStackView(arrangedSubviews: [])
        innerStackView.alignment = .center
        innerStackView.axis = .horizontal
        innerStackView.spacing = 12
        addArrangedSubview(innerStackView)
        
        innerStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50.0).isActive = true
        innerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0).isActive = true
        innerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
    }
    
    var iconImageView = UIImageView(frame: CGRect.zero)
    private func setupImageView() {
        iconImageView.image = UIImage(systemName: imageSystemName)
        iconImageView.tintColor = .white
        innerStackView.addArrangedSubview(iconImageView)
        
        iconImageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
    }
    
    var messageLabel = UILabel(frame: CGRect.zero)
    private func setupMessageLabel() {
        messageLabel.text = message
        messageLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 2
        messageLabel.lineBreakMode = .byWordWrapping
        innerStackView.addArrangedSubview(messageLabel)
    }
    
    // MARK: - Actions
    public func showWithMessage(_ message: String?) {
        if let message = message {
            self.message = message
        }
        UIView.animate(withDuration: 0.25) {
            self.alpha = message == nil ? 0 : 1
        }
    }
}
