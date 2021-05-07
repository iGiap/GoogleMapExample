//
//  MapViewController.swift
//  GoogleMapExample
//
//  Created by sotatek on 06/05/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {

  var resultsViewController: GMSAutocompleteResultsViewController?
  var searchController: UISearchController?
  var resultView: UITextView?

  
    private var mapView: GMSMapView!
    let hanoiCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 21.0, longitude: 105.8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMapView()
        // Do any additional setup after loading the view.
      resultsViewController = GMSAutocompleteResultsViewController()
          resultsViewController?.delegate = self

          searchController = UISearchController(searchResultsController: resultsViewController)
          searchController?.searchResultsUpdater = resultsViewController

      let subView = UIView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.height ?? 24) + 64, width: 350.0, height: 45.0))

          subView.addSubview((searchController?.searchBar)!)
          view.addSubview(subView)
          searchController?.searchBar.sizeToFit()
          searchController?.hidesNavigationBarDuringPresentation = false

          // When UISearchController presents the results view, present it in
          // this view controller, not one further up the chain.
          definesPresentationContext = true
    }
    
    func setMapView() {
        let camera = GMSCameraPosition.camera(withTarget: hanoiCoordinate, zoom: 10)
        mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = hanoiCoordinate
        marker.map = mapView
    }
}

// Handle the user's selection.
extension MapViewController: GMSAutocompleteResultsViewControllerDelegate {
  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didAutocompleteWith place: GMSPlace) {
    searchController?.isActive = false
    let position = GMSCameraPosition.camera(withLatitude: place.coordinate.latitude, longitude: place.coordinate.longitude, zoom: 20)
//    mapView.camera = position
    mapView.animate(to: position)
    // Do something with the selected place.
    print("Place coor: \(place.coordinate)")
    print("Place name: \(place.name)")
    print("Place address: \(place.formattedAddress)")
    print("Place attributions: \(place.attributions)")
  }

  func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                         didFailAutocompleteWithError error: Error){
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
