//
//  testPickMapVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 02/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class testPickMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate  {
    
    var lmgr:CLLocationManager!
    var annotation:MKPointAnnotation?
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBAction func mapZoomToCurrentLoc(_ sender: Any) {
        //        locMgr.startUpdatingLocation()
        mapView.setCenter(mapView.userLocation.coordinate, animated: true)
    }
    
    @IBAction func mapZoomIn(_ sender: Any) {
        
        var region = MKCoordinateRegion()
        // 還有另一個建構式: MKCoordinateRegion(center: CLLocationCoordinate2D, span: MKCoordinateSpan)
        
        let latDelta = mapView.region.span.latitudeDelta * 0.5
        let lngDelta = mapView.region.span.longitudeDelta * 0.5
        
        region.span.latitudeDelta = latDelta
        region.span.longitudeDelta = lngDelta
        region.center = mapView.region.center
        
        mapView.setRegion(region, animated: true)
    }
    
    @IBAction func mapZoomOut(_ sender: Any) {
        var region = MKCoordinateRegion()
        
        let latDelta = mapView.region.span.latitudeDelta * 2
        let lngDelta = mapView.region.span.longitudeDelta * 2
        
        region.span.latitudeDelta = latDelta
        region.span.longitudeDelta = lngDelta
        region.center = mapView.region.center
        
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation = locations.first!
        
        print("locationManager: \(userLocation.coordinate.latitude), \(userLocation.coordinate.longitude)")
    }
    
    public func initStat() {
        if CLLocationManager.locationServicesEnabled() {
            
            lmgr = CLLocationManager()
            
            lmgr?.delegate = self
            lmgr?.desiredAccuracy = kCLLocationAccuracyBest
            lmgr?.requestWhenInUseAuthorization()
            lmgr?.startUpdatingLocation()
            lmgr?.distanceFilter = CLLocationDistance(10)
        }
    }
    
    private func initStatMap() {
        mapView.delegate = self
        
        let mapSingleTapReg = UITapGestureRecognizer(target: self, action: #selector(mapTapHandle) )
        mapSingleTapReg.delegate = self as? UIGestureRecognizerDelegate
        
        mapSingleTapReg.numberOfTapsRequired = 1
        mapSingleTapReg.numberOfTouchesRequired = 1
        
        let mapDoubleTapReg = UITapGestureRecognizer(target: self, action: nil)
        mapDoubleTapReg.delegate = self as? UIGestureRecognizerDelegate
        mapDoubleTapReg.numberOfTapsRequired = 2
        mapDoubleTapReg.numberOfTouchesRequired = 1
        
        // to distinguish single- and double-tap
        mapSingleTapReg.require(toFail: mapDoubleTapReg )
        
        // to make mapView recognizing single- and double-tap gestures
        mapView.addGestureRecognizer(mapSingleTapReg)
        mapView.addGestureRecognizer(mapDoubleTapReg)
        
        annotation = MKPointAnnotation()
        
    }
    
    var countTap:Int = 0
    func mapTapHandle( tapReg: UITapGestureRecognizer ) {
        let allAnnotations = mapView.annotations
        mapView.removeAnnotations(allAnnotations)
        
        countTap += 1
        
        let location = tapReg.location(in: mapView)
        let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
        
        print("Tap(\(countTap)) on mapView: \(coordinate.latitude),\(coordinate.longitude)")
        
        // add annotation
        
//        let annotation = MKPointAnnotation()
        
        annotation?.coordinate = coordinate
        annotation?.title = "Tap(\(countTap))"
        annotation?.subtitle = "\(coordinate.latitude),\(coordinate.longitude)"
        
        mapView.addAnnotation(annotation!)
//        mapView.addAnnotation(annotation)
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initStat()
        initStatMap()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let segueId:String = segue.identifier!
        let vc = segue.destination as! testChoosePlaceVC
        
        if segueId == "segChosenPlace" {
            
//            vc.lat = 120.12345
//            vc.lng = 23.54321
            vc.lat = annotation?.coordinate.latitude
            vc.lng = annotation?.coordinate.longitude
            
        } else {
    
            print("error")
        }
        
    }


}
