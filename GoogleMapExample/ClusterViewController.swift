//
//  ClusterViewController.swift
//  GoogleMapExample
//
//  Created by sotatek on 06/05/2021.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils

class ClusterViewController: UIViewController {
    
    private var mapView: GMSMapView!
    private var clusterManager: GMUClusterManager!
    let hanoiCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 21.0, longitude: 105.8)
    let kClusterItemCount = 1000
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withTarget: hanoiCoordinate, zoom: 8)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCluster()
    }
    
    func setCluster() {
        // Set up the cluster manager with default icon generator and renderer.
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        // Register self to listen to GMSMapViewDelegate events.
        clusterManager.setMapDelegate(self)
        generateClusterItems()
        // Call cluster() after items have been added to perform the clustering and rendering on map.
        clusterManager.cluster()
    }
    
    // Randomly generates cluster items within some extent of the camera and adds them to the cluster manager.
    private func generateClusterItems() {
        let extent = 0.2
        for _ in 1...kClusterItemCount {
            let lat = hanoiCoordinate.latitude + extent * randomScale()
            let lng = hanoiCoordinate.longitude + extent * randomScale()
            let position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let marker = GMSMarker(position: position)
            clusterManager.add(marker)
        }
    }
    
    // Returns a random value between -1.0 and 1.0.
    private func randomScale() -> Double {
        print("random: \(Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0)")
        return Double(arc4random()) / Double(UINT32_MAX) * 2.0 - 1.0
    }
    
}

extension ClusterViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.animate(toLocation: marker.position)
        if let _ = marker.userData as? GMUCluster {
            mapView.animate(toZoom: mapView.camera.zoom + 1)
            NSLog("Did tap cluster")
            return true
        }
        NSLog("Did tap marker")
        return false
    }
}
