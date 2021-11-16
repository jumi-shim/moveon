//
//  MapViewController.swift
//  MoveOn
//
//  Created by 심주미 on 2021/11/13.
//

import UIKit
import NMapsMap
import CoreLocation

class MapViewController:UIViewController,CLLocationManagerDelegate,NMFMapViewCameraDelegate {

    var locationManager: CLLocationManager = CLLocationManager()
    var naverMapView: NMFNaverMapView!
    var locationOverlay: NMFLocationOverlay!
    
    @IBOutlet weak var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naverMapView = NMFNaverMapView(frame: view.frame)
        naverMapView.mapView.addCameraDelegate(delegate: self)
        print(naverMapView.mapView.cameraPosition)
        
        
        mapView.addSubview(naverMapView)
        
        naverMapView.showLocationButton = true
        naverMapView.mapView.positionMode = .direction
        
        
        locationOverlay = naverMapView.mapView.locationOverlay
        locationOverlay.hidden = false
        
        locationOverlay.icon = NMFOverlayImage(name: "photo")
        locationOverlay.iconWidth = 15
        locationOverlay.iconHeight = 15
        
        
        locationOverlay.mapView = naverMapView.mapView
        
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            print("위치 서비스 On상태")
            locationManager.startUpdatingLocation()
        }else{
            print("off")
        }
        
        // Do any additional setup after loading the view.
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        if let location = locations.first {
            print(location.coordinate.longitude)
            print(location.coordinate.latitude)
            locationOverlay.location = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: locationOverlay.location )
            naverMapView.mapView.moveCamera(cameraUpdate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        print("!!!!!!!!!!!!!!")
    }
    
    
}
