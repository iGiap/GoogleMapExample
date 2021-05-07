/*
 * Copyright 2020 Google Inc. All rights reserved.
 *
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this
 * file except in compliance with the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under
 * the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
 * ANY KIND, either express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = viewModel
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getItem(index: indexPath.row).type {
        case .mapView:
            if let mapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MapViewController") as? MapViewController {
                self.navigationController?.pushViewController(mapViewController, animated: true)
            }
        case .cluster:
            if let clusterViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ClusterViewController") as? ClusterViewController {
                self.navigationController?.pushViewController(clusterViewController, animated: true)
            }
        case .wmsDemo:
            //WMSDemoViewController
            if let wMSDemoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "WMSDemoViewController") as? WMSDemoViewController {
                self.navigationController?.pushViewController(wMSDemoViewController, animated: true)
            }
        case .autoSearch:
            break
        }
    }
}

