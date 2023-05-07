//
//  ViewController.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 06.05.2023.
//

import UIKit

enum Link {
    case brewery
    
    var url: URL {
        switch self {
        case .brewery:
            return URL(string: "https://api.openbrewerydb.org/breweries")!
        }
    }
}

final class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }

    @IBAction func fetchData() {
        fetchBrewery()
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchBrewery() {
        URLSession.shared.dataTask(with: Link.brewery.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let brewery = try decoder.decode([Brewery].self, from: data)
                print(brewery)

            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
