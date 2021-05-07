//
//  AppDelegate.swift
//  GoogleMapExample
//
//  Created by sotatek on 05/05/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
  
    private let mapsAPIKey = "AIzaSyADjIu-o1-NPax2GdESpiuiYUE1_6lckRg"
    private let mapId = "9bcbc98feb431924"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey(mapsAPIKey)
        GMSPlacesClient.provideAPIKey(mapsAPIKey)
        return true
    }

}

