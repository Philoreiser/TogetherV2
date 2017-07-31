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
    
    
    @IBAction func changeShowMode(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
        case 0:
            print("List")
            
        case 1:
            print("Map")
        default:
            print("Map")
            break
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.selectedSegmentIndex = 1
        
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
