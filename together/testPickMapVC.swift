//
//  testPickMapVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 02/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class testPickMapVC: UIViewController {

    var saySomething:String = "I'm storyboard \"testPickMapVC\""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let segueId:String = segue.identifier!
        let vc = segue.destination as! testChoosePlaceVC
        
        switch segueId {
            case "segChosenPlace":
            
            vc.lat = 120.12345
            vc.lng = 23.54321
            
            case "segEditPlace":
                
                if vc.lat != nil && vc.lng != nil {
                    vc.lat! += 1.0
                    vc.lng! += 1.0
                }
            
            
        default:
            print("error")
            break
        }
        
    }


}
