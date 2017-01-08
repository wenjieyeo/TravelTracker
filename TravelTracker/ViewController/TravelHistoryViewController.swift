//
//  TravelHistoryViewController.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class TravelHistoryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var travels: [Travel]?
    var dateFormatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        travels = TravelStore.sharedInstance.getLongTravels()
        tableView.reloadData()
    
        dateFormatter.dateStyle = .medium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

extension TravelHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let travel = travels![indexPath.row]
        cell.textLabel?.text = dateFormatter.string(from: travel.startDate)
        cell.detailTextLabel?.text = "\(Int(travel.distance)) m"
        return cell
    }
}
