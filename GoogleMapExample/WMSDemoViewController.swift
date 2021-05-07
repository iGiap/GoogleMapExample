//
//  WMSDemoViewController.swift
//  GoogleMapExample
//
//  Created by sotatek on 06/05/2021.
//

import UIKit
import ArcGIS
import GoogleMaps

class WMSDemoViewController: UIViewController {

    @IBOutlet weak var agsMapView: AGSMapView!
    private var mapView: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize the map with a light gray basemap
        let map = AGSMap(basemapStyle: .arcGISLightGrayBase)
        
        // assign the map to the map view
        agsMapView.map = map
        agsMapView.setViewpoint(AGSViewpoint(latitude: 35.3, longitude: 139.5, scale: 1))
        
        // a URL to the GetCapabilities endpoint of a WMS service
        let wmsServiceURL = URL(string: "https://nowcoast.noaa.gov/arcgis/services/nowcoast/radar_meteo_imagery_nexrad_time/MapServer/WMSServer?request=GetCapabilities&service=WMS")!
        // the names of the layers to load at the WMS service
        let wmsServiceLayerNames = ["1"]
        
        // initialize the WMS layer with the service URL and uniquely identifying WMS layer names
        let wmsLayer = AGSWMSLayer(url: wmsServiceURL, layerNames: wmsServiceLayerNames)
        
        // load the WMS layer
        wmsLayer.load { [weak self] (error) in
            if let error = error {
                print(error)
            } else if wmsLayer.loadStatus == .loaded {
                // add the WMS layer to the map
                map.operationalLayers.add(wmsLayer)
            } else {
                print("wmsLayer.loadStatus : \(wmsLayer.loadStatus)")
            }
        }
        
    }
}

