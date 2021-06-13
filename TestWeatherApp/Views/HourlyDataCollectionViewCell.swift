//
//  HourlyDataCollectionViewCell.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 13.06.2021.
//

import UIKit

final class HourlyDataCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "HourlyDataCollectionViewCell"

    var hourly: Hourly? {
        didSet {
            guard let hourly = hourly else { return }
            hourTextLabel.text = hourly.hour
            hourlyTemperatureLabel.text = "\(hourly.temp)°"
            fetchTemperatureIcon(from: hourly)
        }
    }

    private lazy var hourTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var hourlyWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var hourlyTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        layout()
    }

    private func fetchTemperatureIcon(from hour: Hourly) {
        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(hour.icon).svg") {
            DispatchQueue.main.async {
                self.hourlyWeatherImageView.sd_setImage(with: url)
            }
        }
    }
}

// MARK: - Layout
extension HourlyDataCollectionViewCell {
    private func layout() {
        layoutHourTextLabel(in: self.contentView)
        layoutHourlyWeatherImageView(in: self.contentView)
        layoutHourlyTemperatureLabel(in: self.contentView)
    }

    private func layoutHourTextLabel(in container: UIView) {
        let label = hourTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.topAnchor.constraint(equalTo: container.topAnchor)
        ])
    }

    private func layoutHourlyWeatherImageView(in container: UIView) {
        let imageView = hourlyWeatherImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func layoutHourlyTemperatureLabel(in container: UIView) {
        let label = hourlyTemperatureLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
}
