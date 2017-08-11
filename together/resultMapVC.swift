//
//  resultMapVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 04/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import MapKit
//import CoreLocation

class resultMapVC: UIViewController, MKMapViewDelegate {
    
    var app = UIApplication.shared.delegate as! AppDelegate
//    var lmgr:CLLocationManager?

    @IBOutlet weak var mapView: MKMapView!
    
    func initStat() {
        
        
//        lmgr = CLLocationManager()
//        lmgr?.requestWhenInUseAuthorization()
//        lmgr?.desiredAccuracy = kCLLocationAccuracyBest
//        lmgr?.delegate = self

        mapView.delegate = self

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         print("我是使用者：\(app.mid!)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView.setNeedsDisplay()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
