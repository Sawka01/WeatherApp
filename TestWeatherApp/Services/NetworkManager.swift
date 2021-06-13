//
//  NetworkManager.swift
//  TestWeatherApp
//
//  Created by Khushvaktov Temur on 12.06.2021.
//

import Foundation
import CoreLocation

final class NetworkManager {

    static let shared = NetworkManager()

    func getWeatherData(for city: String, completion: @escaping (Result<Weather, Error>) -> Void) {
        guard let request = getWeatherDataRequest(for: city) else { return }

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }

            guard let data = data else { return }

            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                completion(.success(weather))
            } catch let error {
                completion(.failure(error))
            }

        }.resume()
    }

    func getWeatherDataRequest(for city: String) -> URLRequest? {
        var locationCoordinate: CLLocationCoordinate2D?
        let group = DispatchGroup()
        group.enter()
        getCoordinatesOf(city: city) { (coordinate) in
            locationCoordinate = coordinate
            group.leave()
        }
        group.wait()
        guard let coordinate = locationCoordinate else { return nil }
        let url = URL(string: "https://api.weather.yandex.ru/v2/forecast?lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&extra=true")!
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = ["X-Yandex-API-Key": Constants.APIKey]
        return urlRequest
    }

    private func getCoordinatesOf(city: String, completion: @escaping (CLLocationCoordinate2D) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let coordinate = placemarks?.first?.location?.coordinate {
                completion(coordinate)
            }

            if let error = error as? CLError {
                print(error)
            }
        }
    }
}
