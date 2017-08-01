//
//  testChoosePlaceVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 02/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import MapKit

class testChoosePlaceVC: UIViewController, MKMapViewDelegate {

    var lat:CLLocationDegrees?
    var lng:CLLocationDegrees?
    
    @IBAction func backPickPlaceTest( sender: UIStoryboardSegue) {
        if lat != nil && lng != nil {
            print("lat: \(lat!), lng: \(lng!)")
        }
    }
    
    @IBAction func pickPlace(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "testPickMapVC") as! testPickMapVC
        
        show(vc, sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
