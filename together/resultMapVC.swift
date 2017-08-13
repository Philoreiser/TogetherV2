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

class MyAnnotation: MKPointAnnotation {
    var tidTag:Int?
}

class resultMapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var app = UIApplication.shared.delegate as! AppDelegate
//    var lmgr:CLLocationManager?

    var groupPins:[MKPointAnnotation]?


    @IBOutlet weak var mapView: MKMapView!

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? MyAnnotation else {
            return nil
        }
        
        let reuseId = "pin"
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if annView == nil {
            annView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        }
        
        let btnDetail = UIButton(type: .detailDisclosure)
        btnDetail.tag = annotation.tidTag!
        btnDetail.addTarget(self, action: #selector(btnDetailPress(_:)), for: .touchUpInside)
        
        annView?.rightCalloutAccessoryView = btnDetail

        
        let labelCont = UILabel()
        labelCont.text = annotation.subtitle!
        annView?.detailCalloutAccessoryView = labelCont
        
        
        annView?.canShowCallout = true
        
        return annView
    }
    
    func btnDetailPress( _ sender: UIButton ) {
        
        print("tag: \(sender.tag)")
        app.tid = String(sender.tag)
//        print("app.tag: \(app.tid!)")
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Gpdetail") as! Groupdetail
        show(vc, sender: self)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initStat()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    
    private func makePin( tid:String, title:String, subtitle:String, coordinate: CLLocationCoordinate2D ) -> MyAnnotation {
//        let annotation:MKPointAnnotation = MKPointAnnotation()
        let annotation:MyAnnotation = MyAnnotation()
        
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = coordinate
        annotation.tidTag = (tid as NSString).integerValue
        
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

                self.groupPins! += [self.makePin( tid: group["tid"]!, title: group["subject"]!, subtitle: group["detail"]!, coordinate: coor)]
//                self.groupPins! += [self.makePin(title: group["subject"]!, subtitle: group["tid"]!, coordinate: coor)]

            }
        }
        
    }
    
    private func refreshGroupPins() {
        mapView.addAnnotations(self.groupPins!)
    }
    
}
