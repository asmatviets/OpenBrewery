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
    let websiteUrl: String?
    
    init(id: String, name: String, breweryType: String, address1: String?, city: String, stateProvince: String, postalCode: String, country: String, longitude: String?, latitude: String?, websiteUrl: String?) {
        self.id = id
        self.name = name
        self.breweryType = breweryType
        self.address1 = address1
        self.city = city
        self.stateProvince = stateProvince
        self.postalCode = postalCode
        self.country = country
        self.longitude = longitude
        self.latitude = latitude
        self.websiteUrl = websiteUrl
    }
    
    init(from breweryData: [String: Any]) {
        id = breweryData["id"] as? String ?? ""
        name = breweryData["name"] as? String ?? ""
        breweryType = breweryData["brewery_type"] as? String ?? ""
        address1 = breweryData["address_1"] as? String ?? ""
        city = breweryData["city"] as? String ?? ""
        stateProvince = breweryData["state_province"] as? String ?? ""
        postalCode = breweryData["postal_code"] as? String ?? ""
        country = breweryData["country"] as? String ?? ""
        longitude = breweryData["longitude"] as? String ?? ""
        latitude = breweryData["latitude"] as? String ?? ""
        websiteUrl = breweryData["website_url"] as? String ?? ""
    }
    
    static func getBreweries(from value: Any) -> [Brewery] {
        guard let breweryData = value as? [[String: Any]] else { return [] }
        return breweryData.map { Brewery(from: $0)}
    }
}



