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
    
    let title: String? // 어노테이션 이름 
    
    init(name: String?, lineName: String?, coordinate: CLLocationCoordinate2D, doorPosition: String?, heading: String?) {
        self.name = name
        self.lineName = lineName
        self.coordinate = coordinate
        self.doorPosition = doorPosition
        self.heading = heading
        
        self.title = name // 어노테이션 이름 나오게 함
        
        super.init()
    }
    
    var subtitle: String? { // 클릭하면 어노테이션 나오게 함
        return heading
    }

}
