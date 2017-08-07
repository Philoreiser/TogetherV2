//
//  resultListVC.swift
//  together
//
//  Created by Chuei-Ching Chiou on 04/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class resultListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func testGroupDict(_ sender: Any) {
        let parentVC = parent as! resultMapListVC
        
//        print(parentVC.groupDict?.description)
        
        if parentVC.groupDict != nil {
            
            print( parentVC.groupDict?.description)
            
            for group in parentVC.groupDict! {
                for (key, value) in group {
                    print("\(key): \(value)")
                }
            }
        }
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultcell") as! resultListTbCell
        
        cell.groupTitle.text = "DaBuIN"
        cell.groupContent.text = "我的老天鵝啊"
        cell.groupDistance.text = "100m"
        cell.groupStatus.text = "Hot"
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.testGroupDict(self)
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
