//
//  TravelInfoViewController.swift
//  subwayDoorPositionApp
//
//  Created by hong on 2022/04/05.
//

import UIKit
import CoreLocation

class TravelInfoViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        getLocationUsagePermission()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확한 위치 정보 받기
        locationManagerDidChangeAuthorization(locationManager)
        
    }


}

extension TravelInfoViewController: CLLocationManagerDelegate {
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways :
            print("권한 설정 됨")
        case .restricted, .notDetermined :
            print("권한 설정 되지 않음")
        case .denied :
            print("권한 요청 거부 됨")
        default :
            print("GPS, Default")
        }
        
    }
}
