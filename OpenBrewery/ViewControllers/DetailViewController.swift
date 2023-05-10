//
//  DetailViewController.swift
//  OpenBrewery
//
//  Created by Andrey Matviets on 07.05.2023.
//
import MapKit
import UIKit

final class DetailViewController: UIViewController, UITextViewDelegate {
    
    var brewery: Brewery!
    
    @IBOutlet var flagOfProvince: UIImageView!
    @IBOutlet var breweryDetails: UILabel!
    @IBOutlet var webLink: UITextView!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        showOnMap()
    }
}

extension DetailViewController {
    private func setUpLabels() {
        navigationItem.title = brewery.name
        flagOfProvince.image = UIImage(named: brewery.stateProvince)
        flagOfProvince.layer.cornerRadius = 5
        
        breweryDetails.text = """
Brewery Info:
Name: \(brewery.name)
Size: \(brewery.breweryType)
Province, city: \(brewery.stateProvince), \(brewery.city),
Adress: \(brewery.address1 ?? "no data")
"""
    }
    
    private func showOnMap() {
        guard let latitude = Double(brewery.latitude ?? "no data") else { return }
        guard let longitude = Double(brewery.longitude ?? "no data") else { return }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        mapView.setRegion(region, animated: true)
    }
}
    
