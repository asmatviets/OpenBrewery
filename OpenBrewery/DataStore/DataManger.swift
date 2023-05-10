//
//  DataFetched.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 07.05.2023.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    var breweries: [Brewery] = []
    
    func fetchBreweries() {
        URLSession.shared.dataTask(with: URL(string: "https://api.openbrewerydb.org/breweries")!) { [self] data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let breweriesLoaded = try decoder.decode([Brewery].self, from: data)
                breweries = breweriesLoaded
//                print(breweriesLoaded)
                
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    private init() {}
}




/*
 import Foundation

 final class DataManager {
     
     static let shared = DataManager()
     
     var breweries: [Brewery] = []
     
     func fetchBreweries() {
         URLSession.shared.dataTask(with: URL(string: "https://api.openbrewerydb.org/breweries")!) { data, _, error in
             guard let data else {
                 print(error?.localizedDescription ?? "No error description")
                 return
             }
             
             do {
                 let decoder = JSONDecoder()
                 decoder.keyDecodingStrategy = .convertFromSnakeCase
                 let breweriesLoaded = try decoder.decode([Brewery].self, from: data)
                 print(breweriesLoaded)
                 
             } catch {
                 print(error.localizedDescription)
             }
         }.resume()
     }
     
     func printBreweries() {
         print(breweries)
     }
     
     private init() {}
 }
 */
