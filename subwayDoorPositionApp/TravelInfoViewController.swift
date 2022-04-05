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
        
        let annot = stopInfo(name: "숭실대역", lineName: "7호선", coordinate: CLLocationCoordinate2D(latitude: 37.498566910001166, longitude: 126.94889144107556), doorPosition: "동", heading: "노원")
        
        mapView.addAnnotation(annot)
        
        mapView.delegate = self
              
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
        
        let region = MKCoordinateRegion(center: currentLocation,
                                        latitudinalMeters: 100000,
                                        longitudinalMeters: 100000)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region),animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 1000000)
        mapView.setCameraZoomRange(zoomRange, animated: true)

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

extension TravelInfoViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? stopInfo else {return nil}
        
        let identifier = "stopInfo"
        var view : MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view

    }
}
