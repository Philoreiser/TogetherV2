//
//  searchResultVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class searchResultVC: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var contViewList: UIView!
    @IBOutlet weak var contViewMap: UIView!
    
    
    @IBAction func changeShowMode(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 0:
            print("List")
            
            contViewMap.isHidden = true
            contViewList.isHidden = false
            
        case 1:
            print("Map")
            
            contViewMap.isHidden = false
            contViewList.isHidden = true
            
        default:
            print("Map")
            
            contViewMap.isHidden = false
            contViewList.isHidden = true
            
            break
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.selectedSegmentIndex = 1 // Map
        
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
