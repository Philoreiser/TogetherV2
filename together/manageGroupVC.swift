//
//  manageGroupVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/28.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class manageGroupVC: UIViewController{
//    @IBOutlet weak var tbView: UITableView!
//    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    @IBOutlet weak var containerManageGroup: UIView!
    @IBOutlet weak var containerApplyGroup: UIView!

    
    

    
    @IBAction func segmetAction(_ sender: Any) {
        switch segmentOutlet.selectedSegmentIndex {
        case 0:
            apperaPage1()
        case 1:
            apperaPage2()
        default:
            break
        }
        
    }
    
    
    
    
    
    
    
    func apperaPage1(){
        containerManageGroup.isHidden = false
        containerApplyGroup.isHidden = true
    }
    func apperaPage2(){
        containerManageGroup.isHidden = true
        containerApplyGroup.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        apperaPage1()
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}
