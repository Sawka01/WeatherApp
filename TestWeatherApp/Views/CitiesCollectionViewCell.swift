//
//  CitiesCollectionViewCell.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 12.06.2021.
//

import UIKit
import SDWebImageSVGCoder

final class CitiesCollectionViewCell: UICollectionViewCell {

    // MARK: - Public Properties
    static let reuseIdentifier = "CitiesCollectionViewCell"

    var city: String? {
        didSet {
            guard let city = city else { return }
            cityNameLabel.text = city
        }
    }

    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            temperatureLabel.text = "\(weather.fact.temp)°"
            humidityTextLabel.text = "\(weather.fact.humidity)%"
            windSpeedTextLabel.text = "\(weather.fact.windSpeed)m/s"
            fetchTemperatureIcon(from: weather)
        }
    }

    var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - Private Properties
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "humidity").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.3984864354, green: 0.5254383683, blue: 0.7126730084, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var humidityTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 10)
        label.textColor =  #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var windSpeedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wind").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.3984864354, green: 0.5254383683, blue: 0.7126730084, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var windSpeedTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 10)
        label.textColor =  #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        customViews()
        self.activityIndicator.startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    override func layoutSubviews() {
        layout()
    }

    // MARK: - Private Methods
    private func customViews() {
        backgroundColor = #colorLiteral(red: 0.08250149339, green: 0.1717924178, blue: 0.2216925323, alpha: 1)
        layer.cornerRadius = 16
        layer.cornerCurve = .continuous
        layer.masksToBounds = false
    }

    private func fetchTemperatureIcon(from weather: Weather) {
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather.fact.icon).svg") {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.weatherIconImageView.sd_setImage(with: url)
            }
        }
    }
}


// MARK: - Layout
private extension CitiesCollectionViewCell {
    func layout() {
        layoutTemperatureLabel(in: self.contentView)
        layoutTemperatureImageView(in: self.contentView)
        layoutActivityIndicator(in: self.contentView)
        layoutCityNameLabel(in: self.contentView)
        layoutHumidityImageView(in: self.contentView)
        layoutHumidityTextLabel(in: self.contentView)
        layoutWindSpeedImageView(in: self.contentView)
        layoutWindSpeedTextLabel(in: self.contentView)
    }

    func layoutTemperatureLabel(in container: UIView) {
        let label = temperatureLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            label.topAnchor.constraint(equalTo: container.topAnchor, constant: 16)
        ])
    }

    func layoutTemperatureImageView(in container: UIView) {
        let imageView = weatherIconImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40)
        ])
    }

    func layoutActivityIndicator(in container: UIView) {
        let indicator = activityIndicator
        container.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.leadingAnchor.constraint(equalTo: weatherIconImageView.leadingAnchor),
            indicator.topAnchor.constraint(equalTo: weatherIconImageView.topAnchor),
            indicator.trailingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor),
            indicator.bottomAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor)
        ])
    }

    func layoutCityNameLabel(in container: UIView) {
        let label = cityNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.temperatureLabel.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16)
        ])
    }

    func layoutHumidityImageView(in container: UIView) {
        let imageView = humidityImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    func layoutHumidityTextLabel(in container: UIView) {
        let label = humidityTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.humidityImageView.trailingAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
    }

    func layoutWindSpeedImageView(in container: UIView) {
        let imageView = windSpeedImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.humidityTextLabel.trailingAnchor, constant: 12),
            imageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 15)
        ])
    }

    func layoutWindSpeedTextLabel(in container: UIView) {
        let label = windSpeedTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.windSpeedImageView.trailingAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])
    }
}
