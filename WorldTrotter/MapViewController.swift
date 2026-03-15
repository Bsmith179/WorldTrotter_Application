//
//  MapViewController.swift
//  WorldTrotter
//  An app that runs region specific temperature conversions selectable by regions on a map.
//  Created by Brigitte on 2/21/26.
//  Updated on 2/27/26 - Refactored the MapViewController to load its view programmatically.
//  Updated on 3/09/26 - Added UILabel and UISwitch for points of interest.
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
        
        // Set Initial PoI Visibility
        mapView.pointOfInterestFilter = .includingAll
        
        let segmentedControl
                    = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
            segmentedControl.backgroundColor = UIColor.systemBackground
            segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self,
                                   action: #selector(mapTypeChanged(_:)),
                                   for: .valueChanged)

            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(segmentedControl)
        
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        // Points of Interest Label
        let poiLabel = UILabel()
        poiLabel.text = "Points of Interest"
        poiLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiLabel)
        
        // Points of Interest Switch
        let poiSwitch = UISwitch()
        poiSwitch.isOn = true
        poiSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiSwitch)
        
        poiSwitch.addTarget(self,
                            action: #selector(togglePointsOfInterest(_:)),
                            for: .valueChanged)

        // Constraints for Label and Switch
        let labelTopConstraint =
            poiLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,
                                          constant: 16)
        let labelCenterConstraint =
            poiLabel.centerYAnchor.constraint(equalTo: poiSwitch.centerYAnchor)
        let labelLeadingConstraint =
            poiLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let switchCenterConstraint =
            poiSwitch.centerYAnchor.constraint(equalTo: poiLabel.centerYAnchor);
        let switchLeadingConstraint =
            poiSwitch.leadingAnchor.constraint(equalTo: poiLabel.trailingAnchor,
                                                constant: 8)
        
        labelTopConstraint.isActive = true
        labelLeadingConstraint.isActive = true
        labelCenterConstraint.isActive = true
        switchCenterConstraint.isActive = true
        switchLeadingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("MapViewController loaded its view.")
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    // Toggle Points of Interest
    @objc func togglePointsOfInterest(_ sender: UISwitch) {
        print("Switch toggled:", sender.isOn)

        if sender.isOn {
            mapView.pointOfInterestFilter = .includingAll
        } else {
            mapView.pointOfInterestFilter = .excludingAll }
    }
    
}
