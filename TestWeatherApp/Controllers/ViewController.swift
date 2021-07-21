//
//  ViewController.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 12.06.2021.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Private Properties
    private lazy var citiesDataCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCity: [String] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    private var cities: [String] = [
        "Tashkent",
        "Moscow",
        "Saint-Petersburg",
        "London",
        "Ukraine",
        "Kazakhstan",
        "Sochi",
        "England",
        "US",
        "Egypt"
    ]

    private var cityWithWeather: [String: Weather] = [:]

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Weather"
        view.backgroundColor = #colorLiteral(red: 0.03214389458, green: 0.1046723947, blue: 0.1467950046, alpha: 1)
        layout()
        setupCollectionView()
        setupSearchController()
        DispatchQueue.global().async {
            self.fetchWeatherData()
        }
    }

    // MARK: - Private Methods
    private func setupCollectionView() {
        citiesDataCollectionView.register(CitiesCollectionViewCell.self, forCellWithReuseIdentifier: CitiesCollectionViewCell.reuseIdentifier)
        citiesDataCollectionView.delegate = self
        citiesDataCollectionView.dataSource = self
        citiesDataCollectionView.contentInset = .zero
    }

    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search city"
        searchController.searchBar.barTintColor = #colorLiteral(red: 0.7780510783, green: 0.7922836542, blue: 0.792152822, alpha: 1)
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func fetchWeatherData() {
        cities.forEach { city in
            NetworkManager.shared.getWeatherData(for: city) { (result) in
                switch result {
                case .success(let weather):
                DispatchQueue.main.async {
                    self.cityWithWeather[city.capitalized] = weather
                    self.citiesDataCollectionView.reloadData()
                }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

// MARK: - UISearchResultsUpdating
extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

    private func filterContentForSearchText(_ searchText: String) {
        filteredCity = cities.filter { city in
            city.lowercased().contains(searchText.lowercased())
        }

        citiesDataCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredCity.count : cities.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CitiesCollectionViewCell.reuseIdentifier, for: indexPath) as! CitiesCollectionViewCell

        let city = isFiltering ? filteredCity[indexPath.row] : cities[indexPath.row]
        cell.city = city
        if let weather = cityWithWeather[city.capitalized] {
            cell.weather = weather
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CitiesCollectionViewCell

        let detailsVC = DetailsViewController()
        let city = isFiltering ? filteredCity[indexPath.row] : cities[indexPath.row]
        detailsVC.weather = cityWithWeather[city.capitalized]
        detailsVC.weatherIconImageView.image = cell.weatherIconImageView.image
        detailsVC.cityNameLabel.text = city
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = Constants.sectionInsets.left + Constants.sectionInsets.right + Constants.minimumItemSpacing * (Constants.itemsPerRow - 1)
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        let heightPerItem = widthPerItem * 0.85
        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumItemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.minimumItemSpacing
    }
}

// MARK: - Layout
private extension ViewController {
    func layout() {
        layoutCitiesCollectionView(in: self.view)
    }

    func layoutCitiesCollectionView(in container: UIView) {
        let collectionView = citiesDataCollectionView
        container.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

