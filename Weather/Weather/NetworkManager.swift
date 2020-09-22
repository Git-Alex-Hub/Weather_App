//
//  NetworkManager.swift
//  Homework 24 Peniaz
//
//  Created by MacOS on 25.08.2020.
//  Copyright © 2020 MacOS. All rights reserved.
//

import Foundation

class NetworkManager {
    private init () {}
    
    static let shared: NetworkManager = NetworkManager()
    
    func getWeather(city: String, result: @escaping ((weatherCodable?) -> ())) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=111e4a374088d12c66c3b0789dc4f87b"
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data {
            if error == nil {
                let decoder = JSONDecoder()
                var decodeWeatherCodable: weatherCodable?
                if data != nil {
                    decodeWeatherCodable = try? decoder.decode(weatherCodable.self, from: data)
                }
                result(decodeWeatherCodable)
            } else {
                print(error as Any)
            }
            }
        }.resume()
    }
    
    func getWeatherInMyLocation(lat: String, lon: String, result: @escaping ((weatherCodable?) -> ())) {
            let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=111e4a374088d12c66c3b0789dc4f87b"
                
                guard let url = URL(string: urlString) else { return }
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    if error == nil {
                        let decoder = JSONDecoder()
                        var decodeWeatherCodable: weatherCodable?
                        if data != nil {
                            decodeWeatherCodable = try? decoder.decode(weatherCodable.self, from: data)
                        }
                        result(decodeWeatherCodable)
                    } else {
                        print(error as Any)
                    }
                    }
                }.resume()
    }
}
