//
//  MapDemoModel.swift
//  GoogleMapExample
//
//  Created by sotatek on 06/05/2021.
//

import Foundation

enum DemoType: String {
    case mapView = "Map View"
    case cluster = "Cluster"
    case wmsDemo = "WMS Demo"
    case autoSearch = "Demo Auto Search Location"
}

struct MapDemoModel {
    var type: DemoType
    
    init(_ type: DemoType) {
        self.type = type
    }
}
