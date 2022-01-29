//
//  WeatherViewController.swift
//  SwiftPlayground
//
//  Created by Augusto Monteiro on 06/01/22.
//

import UIKit

public final class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherListTableView: UITableView!
    @IBOutlet weak var errorView: ErrorView!
    
    private let refreshControl = UIRefreshControl()
    
    var viewModel: WeatherViewModel? {
        didSet { bind() }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        
        viewModel?.loadWeather()
    }
    
    private func configureRefreshControl() {
        weatherListTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        viewModel?.loadWeather()
    }
    
    func bind() {
        title = viewModel?.screenTitle
        
        viewModel?.onWeatherLoad = { [weak self] _ in
            self?.weatherListTableView.reloadData()
        }
        
        viewModel?.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.refreshControl.beginRefreshing()
                } else {
                    self?.refreshControl.endRefreshing()
                }
            }
        }

        viewModel?.onErrorStateChange = { [weak self] message in
            self?.errorView.showWithMessage(message)
        }
    }
    
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.weatherList?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier) as? WeatherCell,
           let weather = viewModel?.weatherList?[indexPath.row] {
            cell.configure(with: weather, presenting: .celsius)
            return cell
        }
        return UITableViewCell()
    }
    
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
