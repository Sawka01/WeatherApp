//
//  WeeklyDataTableViewCell.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 13.06.2021.
//

import UIKit

final class WeeklyDataTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeeklyDataTableViewCell"

    var weekly: Forecast? {
        didSet {
            guard let weekly = weekly else { return }
//            weeklyTemperatureLabel.text = "\(weekly.tempMax)°"
//            weeklyFeelsLikeLabel.text = "\(weekly.feelsLike)"
//            fetchTemperatureIcon(from: weekly)
        }
    }

    private lazy var weekTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var weeklyWeatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var weeklyTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var weeklyFeelsLikeLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = #colorLiteral(red: 0.1711477041, green: 0.3001840711, blue: 0.3959158659, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        layout()
    }

//    private func fetchTemperatureIcon(from week: Forecast) {
//        if let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(week.icon).svg") {
//            DispatchQueue.main.async {
//                self.weeklyWeatherImageView.sd_setImage(with: url)
//            }
//        }
//    }
}

// MARK: - Layout
extension WeeklyDataTableViewCell {
    private func layout() {
        layoutWeekTextLabel(in: self.contentView)
        layoutWeeklyWeatherImageView(in: self.contentView)
        layoutWeeklyFeelsLikeLabel(in: self.contentView)
        layoutWeeklyTemperatureLabel(in: self.contentView)
    }

    private func layoutWeekTextLabel(in container: UIView) {
        let label = weekTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor)
        ])
    }

    private func layoutWeeklyWeatherImageView(in container: UIView) {
        let imageView = weeklyWeatherImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }

    private func layoutWeeklyTemperatureLabel(in container: UIView) {
        let label = weeklyTemperatureLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: self.weeklyFeelsLikeLabel.leadingAnchor, constant: -8)
        ])
    }

    private func layoutWeeklyFeelsLikeLabel(in container: UIView) {
        let label = weeklyFeelsLikeLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor)
        ])
    }
}
