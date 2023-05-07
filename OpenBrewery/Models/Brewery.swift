//
//  Brewery.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 06.05.2023.
//
import Foundation

struct Brewery: Codable {
    let id: String
    let name: String
    let breweryType: String
    let address1: String?
    let city: String
    let stateProvince: String
    let postalCode: String
    let country: String
    let longitude: String?
    let latitude: String?
    let websiteUrl: URL?
}
