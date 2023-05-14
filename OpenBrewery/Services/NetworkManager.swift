//
//  NetworkManager.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 09.05.2023.
//
import Alamofire
import Foundation

enum Link {
    case brewery
    
    var url: URL {
        switch self {
        case .brewery:
            return URL(string: "https://api.openbrewerydb.org/breweries")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchBreweries(from url: URL, completion: @escaping(Result<[Brewery], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let breweries = Brewery.getBreweries(from: value)
                    completion(.success(breweries))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
//    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let dataModel = try decoder.decode(T.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(dataModel))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
//    }
}
