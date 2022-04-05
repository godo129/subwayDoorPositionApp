//
//  stopInfo.swift
//  subwayDoorPositionApp
//
//  Created by hong on 2022/04/05.
//

import MapKit

class stopInfo: NSObject, MKAnnotation {
    
    let name : String?
    let lineName : String?
    let coordinate : CLLocationCoordinate2D
    let doorPosition : String?
    let heading : String?
    
    init(name: String?, lineName: String?, coordinate: CLLocationCoordinate2D, doorPosition: String?, heading: String?) {
        self.name = name
        self.lineName = lineName
        self.coordinate = coordinate
        self.doorPosition = doorPosition
        self.heading = heading
        
        super.init()
    }
    
    var title: String? {
        return name
    }

}
