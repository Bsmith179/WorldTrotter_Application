//
//  MapViewController.swift
//  WorldTrotter
//  An app that runs region specific temperature conversions selectable by regions on a map.
//  Created by Brigitte on 2/21/26.
//  Updated on 2/27/26 - Refactored the MapViewController to load its view programmatically.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!

    override func loadView() {
        // Create a map view
        mapView = MKMapView()

        // Set it as *the* view of this view controller
        view = mapView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MapViewController loaded its view.")
    }

}
