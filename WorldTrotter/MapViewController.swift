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
    var poiSwitch: UISwitch!
    
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
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        
        let margins = view.layoutMarginsGuide
        let topConstraint =
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                              constant: 8)
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
        poiSwitch = UISwitch()
        poiSwitch.isOn = true
        poiSwitch.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(poiSwitch)
        poiSwitch.addTarget(self, action: #selector(updateMap(_:)), for: .valueChanged)
        
        
        // Constraints for Label and Switch
        let labelTopConstraint =
        poiLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,
                                      constant: 16)
        let labelLeadingConstraint =
        poiLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let switchLeadingConstraint =
        poiSwitch.leadingAnchor.constraint(equalTo: poiLabel.trailingAnchor,
                                           constant: 8)
        let switchTopConstraint =
        poiSwitch.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor,
                                       constant: 8)
        
        labelTopConstraint.isActive = true
        labelLeadingConstraint.isActive = true
        switchTopConstraint.isActive = true
        switchLeadingConstraint.isActive = true
        
        // Action to change both controls
        segmentedControl.addTarget(self, action: #selector(updateMap(_:)), for: .valueChanged); poiSwitch.addTarget(self, action: #selector(updateMap(_:)), for: .valueChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    // Handler For Map And PoI Filters
    @objc func updateMap(_ sender: Any) {
        
        // Determine PoI Filter From Switch
        var poiFilter: MKPointOfInterestFilter = .includingAll
        if let poiSwitch = view.subviews.compactMap({ $0 as? UISwitch }).first {
            poiFilter = poiSwitch.isOn ? .includingAll : .excludingAll
        }
        
        // Determine Which Map Type Is Currently Selected
        let selectedIndex: Int
        if let segControl = view.subviews.compactMap({ $0 as? UISegmentedControl }).first {
            selectedIndex = segControl.selectedSegmentIndex
        } else {
            selectedIndex = 0
        }
        
        // Show Correct Map Type And Switch Configuration
        switch selectedIndex {
        case 0:
            let config = MKStandardMapConfiguration()
            config.pointOfInterestFilter = poiFilter
            mapView.preferredConfiguration = config
            poiSwitch.onTintColor = UIColor.systemGreen
            poiSwitch.isEnabled = true
        case 1:
            let config = MKHybridMapConfiguration()
            config.pointOfInterestFilter = poiFilter
            mapView.preferredConfiguration = config
            poiSwitch.isEnabled = true
            poiSwitch.onTintColor = UIColor.systemGreen
        case 2:
            mapView.mapType = .satellite
            poiSwitch.isEnabled = false
            poiSwitch.onTintColor = UIColor.systemGray
        default:
            let config = MKStandardMapConfiguration()
            config.pointOfInterestFilter = poiFilter
            mapView.preferredConfiguration = config
            poiSwitch.isEnabled = true
            poiSwitch.onTintColor = UIColor.systemGreen
        }
        
    }
}
