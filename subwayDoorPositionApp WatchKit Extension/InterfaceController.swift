//
//  InterfaceController.swift
//  subwayDoorPositionApp WatchKit Extension
//
//  Created by hong on 2022/04/04.
//

import WatchKit
import Foundation
import UIKit

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var SubwayInfoButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        SubwayInfoButton.setTitle("지하철 정보")
    }
    
    @IBAction func SubwayInfoButtonTapped() {
        presentController(withName: "subwayInfo", context: .none)
    }
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
