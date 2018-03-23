//
//  MapViewController.swift
//  postlaju
//
//  Created by Ying Mei Lum on 23/03/2018.
//  Copyright © 2018 Ying Mei Lum. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBAction func getaddressBtn(_ sender: UIButton) {
        
        let userLocation = mapView.userLocation
//        let selectedItem = MKPlacemark.init(placemark: userLocation)
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 1000, 1000)
        mapView.setRegion(region, animated: true)
        
        
        var longitude : CLLocationDegrees = (self.locationManager.location?.coordinate.longitude)!
        var latitude : CLLocationDegrees = (self.locationManager.location?.coordinate.latitude)!
        var location = CLLocation(latitude: latitude, longitude: longitude)
        
        var mapItems: [MKMapItem]!
        let distanceFormatter = MKDistanceFormatter()
        
//        parseAddress(selectedItem: MKPlacemark)
        
        
//        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) -> Void in
//            if error != nil {
//                print("failed")
//                return
//            }
//            if (placemarks?.count)! > 0 {
//                guard let pm = placemarks?[0] as? CLPlacemark! else {return}
//
//                let address = (pm?.subThoroughfare)! + " " + (pm?.thoroughfare)! + (pm?.locality)! + "," + (pm?.administrativeArea)! + " " + (pm?.postalCode)! + " " + (pm?.isoCountryCode)!
//
//                print(address)
//
//            } else {
//                print("error")
//            }
//        }
    }
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        self.sortMapItems()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
    
    func parseAddress(selectedItem:MKPlacemark) -> String {
        // put a space between "4" and "Melrose Place"
        let firstSpace = (selectedItem.subThoroughfare != nil && selectedItem.thoroughfare != nil) ? " " : ""
        // put a comma between street and city/state
        let comma = (selectedItem.subThoroughfare != nil || selectedItem.thoroughfare != nil) && (selectedItem.subAdministrativeArea != nil || selectedItem.administrativeArea != nil) ? ", " : ""
        // put a space between "Washington" and "DC"
        let secondSpace = (selectedItem.subAdministrativeArea != nil && selectedItem.administrativeArea != nil) ? " " : ""
        let addressLine = String(
            format:"%@%@%@%@%@%@%@",
            // street number
            selectedItem.subThoroughfare ?? "",
            firstSpace,
            // street name
            selectedItem.thoroughfare ?? "",
            comma,
            // city
            selectedItem.locality ?? "",
            secondSpace,
            // state
            selectedItem.administrativeArea ?? ""
        )
        return addressLine
    }
    
    func sortMapItems()  {
//        self.mapItems = self.mapItems.sorted(by: { (b, a) -> Bool in
//            return self.userLocation.location!.distance(from: a.placemark.location!) > self.userLocation.location!.distance(from: b.placemark.location!)
//        })
    }
    

}
