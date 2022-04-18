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

    @IBOutlet weak var myTimer: WKInterfaceTimer!
    
    @IBOutlet weak var timerButton: WKInterfaceButton!
    
    var isTimerStarted = false
    var startTime = Date()
    var elapsedTime: TimeInterval = 0.1
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
        timerButton.setTitle("START")
    }
    
    
    @IBAction func myTimeAction() {
        isTimerStarted = !isTimerStarted
        if isTimerStarted {
            startTime = Date()
            timerButton.setTitle("STOP")
            myTimer.setDate(Date(timeIntervalSinceNow: 10))
        } else {
            let stoppedTime = Date()
            elapsedTime += stoppedTime.timeIntervalSince(startTime)
            timerButton.setTitle("START")
            myTimer.stop()
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
