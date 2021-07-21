//
//  DetailsViewController.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 12.06.2021.
//

import UIKit

final class DetailsViewController: UIViewController {

    // MARK: - Public Properties
    var weather: Weather? {
        didSet {
            guard let weather = weather else { return }
            temperatureLabel.text = "\(weather.fact.temp)°"
            humidityTextLabel.text = "\(weather.fact.humidity)%"
            windSpeedTextLabel.text = "\(weather.fact.windSpeed)m/s"
            conditionLabel.text = "\(weather.fact.condition)"
            pressureTextLabel.text = "\(weather.fact.pressurePA)Pa"
            hourlyDataCollectionView.reloadData()
            weeklyDataTableView.reloadData()
        }
    }

    lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Private Properties
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = .white
        label.font = .systemFont(ofSize: 70, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.font = .systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "humidity").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.3984864354, green: 0.5254383683, blue: 0.7126730084, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var humidityTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 16)
        label.textColor =  #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var pressureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "pressure").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.3984864354, green: 0.5254383683, blue: 0.7126730084, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var pressureTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 16)
        label.textColor =  #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var windSpeedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "wind").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0.3984864354, green: 0.5254383683, blue: 0.7126730084, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var windSpeedTextLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.font = .systemFont(ofSize: 16)
        label.textColor =  #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var todayTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Today"
        label.textColor = #colorLiteral(red: 0.6912692189, green: 0.7022468448, blue: 0.7060245872, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var hourlyDataCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.itemSize = CGSize(width: 50, height: 90)
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 10.0
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private lazy var weeklyDataTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupHourlyDataCollectionView()
        setupWeeklyDataTableView()
        view.backgroundColor = #colorLiteral(red: 0.03214389458, green: 0.1046723947, blue: 0.1467950046, alpha: 1)
        navigationController?.navigationItem.leftBarButtonItem?.title = ""
    }

    // MARK: - Private Methods
    private func setupHourlyDataCollectionView() {
        hourlyDataCollectionView.register(HourlyDataCollectionViewCell.self, forCellWithReuseIdentifier: HourlyDataCollectionViewCell.reuseIdentifier)
        hourlyDataCollectionView.delegate = self
        hourlyDataCollectionView.dataSource = self
    }

    private func setupWeeklyDataTableView() {
        weeklyDataTableView.register(WeeklyDataTableViewCell.self, forCellReuseIdentifier: WeeklyDataTableViewCell.reuseIdentifier)
        weeklyDataTableView.delegate = self
        weeklyDataTableView.dataSource = self
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather?.forecasts.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeeklyDataTableViewCell.reuseIdentifier, for: indexPath) as! WeeklyDataTableViewCell

        cell.weekly = weather?.forecasts[indexPath.row]

        return cell
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather?.forecasts[0].hours.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyDataCollectionViewCell.reuseIdentifier, for: indexPath) as! HourlyDataCollectionViewCell

        cell.hourly = weather?.forecasts[0].hours[indexPath.item]

        return cell
    }
}

// MARK: - Layout
private extension DetailsViewController {
    func layout() {
        layoutWeatherIconImageView(in: self.view)
        layoutCityNameLabel(in: self.view)
        layoutTemperatureLabel(in: self.view)
        layoutConditionLabel(in: self.view)
        layoutHumidityImageView(in: self.view)
        layoutHumidityTextLabel(in: self.view)
        layoutWindSpeedTextLabel(in: self.view)
        layoutWindSpeedImageView(in: self.view)
        layoutPressureTextLabel(in: self.view)
        layoutPressureImageView(in: self.view)
        layoutTodayTextLabel(in: self.view)
        layoutCollectionView(in: self.view)
        layoutWeeklyDataTableView(in: self.view)
    }

    func layoutWeatherIconImageView(in container: UIView) {
        let imageView = weatherIconImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalToConstant: 160)
        ])
    }

    func layoutCityNameLabel(in container: UIView) {
        let label = cityNameLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: self.weatherIconImageView.leadingAnchor, constant: -5)
        ])
    }

    func layoutTemperatureLabel(in container: UIView) {
        let label = temperatureLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.cityNameLabel.bottomAnchor, constant: 7),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            label.trailingAnchor.constraint(equalTo: self.weatherIconImageView.leadingAnchor, constant: -5)
        ])
    }

    func layoutConditionLabel(in container: UIView) {
        let label = conditionLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            label.topAnchor.constraint(equalTo: self.temperatureLabel.bottomAnchor, constant: 5)
        ])
    }

    func layoutHumidityImageView(in container: UIView) {
        let imageView = humidityImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor, constant: 35),
            imageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    func layoutHumidityTextLabel(in container: UIView) {
        let label = humidityTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.humidityImageView.trailingAnchor, constant: 12),
            label.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor, constant: 35)
        ])
    }

    func layoutPressureImageView(in container: UIView) {
        let imageView = pressureImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor, constant: 35),
            imageView.trailingAnchor.constraint(equalTo: self.pressureTextLabel.leadingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    func layoutPressureTextLabel(in container: UIView) {
        let label = pressureTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor, constant: 35)
        ])
    }

    func layoutWindSpeedImageView(in container: UIView) {
        let imageView = windSpeedImageView
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor, constant: 35),
            imageView.trailingAnchor.constraint(equalTo: self.windSpeedTextLabel.leadingAnchor, constant: -12),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }

    func layoutWindSpeedTextLabel(in container: UIView) {
        let label = windSpeedTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -25),
            label.topAnchor.constraint(equalTo: self.conditionLabel.bottomAnchor, constant: 35)
        ])
    }

    func layoutTodayTextLabel(in container: UIView) {
        let label = todayTextLabel
        container.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            label.topAnchor.constraint(equalTo: self.windSpeedImageView.bottomAnchor, constant: 30)
        ])
    }

    func layoutCollectionView(in container: UIView) {
        let collectionView = hourlyDataCollectionView
        container.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            collectionView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -25),
            collectionView.topAnchor.constraint(equalTo: self.todayTextLabel.bottomAnchor, constant: 15.0),
            collectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

    func layoutWeeklyDataTableView(in container: UIView) {
        let tableView = weeklyDataTableView
        container.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.hourlyDataCollectionView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -25),
            tableView.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


