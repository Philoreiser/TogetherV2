//
//  FirstViewController.swift
//  together
//
//  Created by ooo on 03/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var registerView: UIView!
    @IBAction func Segmentedvalue(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.loginView.isHidden = false
            self.registerView.isHidden = true
        case 1:
            self.registerView.isHidden = false
            self.loginView.isHidden = true
        default:
            break
            
        }
        
        
        
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginView.isHidden = false
        self.registerView.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
