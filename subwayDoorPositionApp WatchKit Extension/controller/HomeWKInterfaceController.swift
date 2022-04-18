//
//  HomeWKInterfaceController.swift
//  subwayDoorPositionApp WatchKit Extension
//
//  Created by hong on 2022/04/18.
//

import UIKit
import WatchKit

class HomeWKInterfaceController: WKInterfaceController {
    
    @IBOutlet weak var TrainLaneInfoButton: WKInterfaceButton!
    @IBOutlet weak var LocationInfoButton: WKInterfaceButton!
    
    @IBOutlet weak var DoorPosiInfoButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        TrainLaneInfoButton.setTitle("지하철 정보")
        LocationInfoButton.setTitle("현재 위치")
        DoorPosiInfoButton.setTitle("문 정보")
    }
    
    
    @IBAction func DoorPosiButtonTapped() {
        self.pushController(withName: "TrainLaneInfoView", context: nil)
    }
    
    @IBAction func TrainLaneInfoButtonTapped() {
        self.pushController(withName: "CurrentLocationView", context: nil)
    }
    
    @IBAction func LocationInfoButtonTapped() {
        self.pushController(withName: "DoorInfoView", context: nil)
    }
}
