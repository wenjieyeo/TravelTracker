//
//  CurrentTravelController.swift
//  TravelTracker
//
//  Created by user on 1/7/17.
//  Copyright © 2017 user. All rights reserved.
//

import UIKit

class CurrentTravelController: UIViewController {
    
    @IBOutlet var distanceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let travel = TravelStore.sharedInstance.getCurrentTravel()
        distanceLabel.text = "\(Int(travel.distance)) m"
        LocationManager.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CurrentTravelController: LocationManagerDelegate {
    func locationManager(manager: LocationManager, didSaveTravel travel: Travel) {
        distanceLabel.text = "\(Int(travel.distance)) m"
    }
}
