//
//  DataStore.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 07.05.2023.
//

import Foundation

class DataManager {
    
    
    
    
    extension NavigationViewController {
        private func fetchBrewery() {
            URLSession.shared.dataTask(with: URL(string: "https://api.openbrewerydb.org/breweries")!) { [self] data, _, error in
                guard let data else {
                    print(error?.localizedDescription ?? "No error description")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let brewery = try decoder.decode([Brewery].self, from: data)
//                    print(brewery)
                    breweries = brewery

                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}
