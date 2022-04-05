//
//  TravelInfoViewController.swift
//  subwayDoorPositionApp
//
//  Created by hong on 2022/04/05.
//

import UIKit
import CoreLocation
import MapKit

class TravelInfoViewController: UIViewController {
    
    var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // 정확한 위치 정보 받기
        locationManager.startUpdatingLocation()
        return locationManager
    }()
    
    var currentLocation = CLLocationCoordinate2D()
    
    let mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
               
        getLocationUsagePermission()
        locationManager.delegate = self
              
        mapView.showsUserLocation = true // 현재 위치 표시 
        self.view.addSubview(mapView)
        
        
    }
   
    override func viewDidLayoutSubviews() {
        mapView.frame = self.view.bounds
    }


}

extension TravelInfoViewController: CLLocationManagerDelegate {
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("최신 정보 받음")
        
        guard let latestLocation = locations.first else {return}
        
        currentLocation = latestLocation.coordinate

        mapView.centerToLocation(currentLocation)
        
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

private extension MKMapView {
  func centerToLocation(_ location: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 1000) {
    let coordinateRegion = MKCoordinateRegion(center: location,
                                              latitudinalMeters: regionRadius,
                                              longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
