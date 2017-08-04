//
//  openGroupMapPickVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 04/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class openGroupMapPickVC: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var isMapTapped:Bool!
    var annotation:MKPointAnnotation!
    var location:CLLocation!
    var geocoder:CLGeocoder!
    
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
        
        
    }
    
    var countTap:Int = 0
    func mapTapHandle( tapReg: UITapGestureRecognizer ) {

        mapView.removeAnnotations(mapView.annotations)
        
        countTap += 1
        
        let cgLoc = tapReg.location(in: mapView)
        let coordinate = mapView.convert(cgLoc,toCoordinateFrom: mapView)
        
        print("Tap(\(countTap)) on mapView: \(coordinate.latitude),\(coordinate.longitude)")
        self.location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        // add annotation
        
//        let annotation = MKPointAnnotation()
        
        self.annotation.coordinate = coordinate
        self.annotation.title = "Tap(\(countTap))"
        self.annotation.subtitle = "\(coordinate.latitude),\(coordinate.longitude)"
        
        mapView.addAnnotation(annotation)
        isMapTapped = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initStatMap()
        
        isMapTapped = false
        annotation = MKPointAnnotation()
        geocoder = CLGeocoder()
        


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
        
        let segId:String = segue.identifier!
        
        if segId == "segPickPlaceDone" && isMapTapped == true {
            
            let vc = segue.destination as! openGroupVC
            
            print("lat:\(self.annotation.coordinate.latitude), lng:\(self.annotation.coordinate.longitude)")
            
            vc.locationLat = self.annotation.coordinate.latitude
            vc.locationLng = self.annotation.coordinate.longitude
            
            self.geocoder.reverseGeocodeLocation(self.location, completionHandler: { (placemark, error) in
                guard error == nil else {
                    return
                }
                
                guard placemark == nil else {
                    return
                }
                
            
            })
            
        }
    }



}
