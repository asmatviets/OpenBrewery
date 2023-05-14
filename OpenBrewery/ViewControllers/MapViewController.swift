//
//  MapViewController.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 11.05.2023.
//
import MapKit
import UIKit

final class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    var breweries: [Brewery]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var annotations: [Locations] = []
        
        for brewery in breweries {
            if let latitude = Double(brewery.latitude ?? "no data"), let longitude = Double(brewery.longitude ?? " no data") {
                let location = Locations(title: brewery.name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), size: brewery.breweryType)
                annotations.append(location)
            }
        }
        
        func createAnnotation(locations: [Locations]){
            for location in locations {
                let annotations = MKPointAnnotation()
                annotations.title = location.title
                annotations.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                mapView.addAnnotation(annotations)
            }
        }
        
        createAnnotation(locations: annotations)
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298), animated: true)
        
    }
}

class Locations: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var size: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, size: String) {
        self.title = title
        self.coordinate = coordinate
        self.size = size
    }
}
