//
//  ViewModel.swift
//  GoogleMapExample
//
//  Created by sotatek on 06/05/2021.
//

import Foundation
import UIKit

class ViewModel: NSObject {
    private let items: [MapDemoModel] = [
        MapDemoModel(.mapView),
        MapDemoModel(.cluster),
        MapDemoModel(.wmsDemo),
        MapDemoModel(.autoSearch)
    ]
    
    func getItem(index: Int) -> MapDemoModel {
        return items[index]
    }
}

extension ViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MapDemoCell", for: indexPath) as? MapDemoCell else {
            return UITableViewCell()
        }
        cell.textLabel?.text = items[indexPath.row].type.rawValue
        return cell
    }
}
