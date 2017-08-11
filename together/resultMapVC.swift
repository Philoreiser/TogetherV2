//
//  resultMapVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 04/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class resultMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var app = UIApplication.shared.delegate as! AppDelegate
//    var lmgr:CLLocationManager?

    var groupPins:[MKPointAnnotation]?


    @IBOutlet weak var mapView: MKMapView!

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let sub = view.annotation?.subtitle!
        print("\(sub!)")
        
//        let label = UILabel()
//        label.text = sub!
//
//        view.detailCalloutAccessoryView = label
//        view.canShowCallout = true

    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if annView == nil {
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        
        let btnDetail = UIButton(type: .detailDisclosure)
        btnDetail.tag = 100
        btnDetail.addTarget(self, action: #selector(btnDetailPress(_:)), for: .touchUpInside)
        
        annView?.rightCalloutAccessoryView = btnDetail

        
        let labelCont = UILabel()
        labelCont.text = "我的老天鵝啊啊啊啊啊啊..."
        annView?.detailCalloutAccessoryView = labelCont
        
        
        annView?.canShowCallout = true
        
        return annView
    }
    
    func btnDetailPress( _ sender: UIButton ) {
        if sender.tag == 100 {
            print("tag: \(sender.tag)")
//            show(....)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initStat()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let parentVC = parent as! resultMapListVC
//        
//        for _ in 1...3 {
//        
//            sleep(1)
//            if parentVC.groupDict != nil {
//                self.createGroupPins()
//                break
//            }
//        }
        
        createGroupPins()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(groupPins!.description)
        sleep(1)
        
        self.refreshGroupPins()
//        mapView.setNeedsDisplay()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    private func initStat() {
        
//        groupPins = []
        
        mapView.delegate = self
        
    }
    
    private func makePin( title:String, subtitle:String, coordinate: CLLocationCoordinate2D ) -> MKPointAnnotation {
        let annotation:MKPointAnnotation = MKPointAnnotation()
        
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = coordinate
        
        
        return annotation
    }
    
    private func createGroupPins() {
        
        let parentVC = parent as! resultMapListVC
        
        if parentVC.groupDict != nil {
            
            self.groupPins = []
            
            for group in parentVC.groupDict! {
                
                let tid = group["tid"]!
                let lat = CLLocationDegrees(group["lat"]!)
                let lng = CLLocationDegrees(group["lng"]!)
                
//                if lat != nil && lng != nil {
//                    print("\(tid): \(lat!), \(lng!)")
//                } else {
//                    print("\(tid)")
//                }
                
                let coor = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
                print("\(tid): \(coor.latitude), \(coor.longitude)")

                self.groupPins! += [self.makePin(title: group["subject"]!, subtitle: group["detail"]!, coordinate: coor)]
                
            }
        }
        
    }
    
    private func refreshGroupPins() {
        mapView.addAnnotations(self.groupPins!)
    }
    
}
