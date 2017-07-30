//
//  manageApplyVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/31.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class manageApplyVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tbView: UITableView!

    
    
    
    
    
    var mydataGroup:Array<String> = ["111","111","111"]
    var mydataMaid:Array<String> = ["222","222","222"]
    var mydataStatus:Array<String> = ["333","333","333"]
    
    //暫時假裝登入者
    let mid = "0"
    
    
    
    
    //ＴＢV數量
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mydataGroup.count
    }
    
    
    
    //ＴＢ內容
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //////////這是table 我的揪團審核用的
        let cell = tbView.dequeueReusableCell(withIdentifier: "manageapplycell", for: indexPath) as! applyGroupTBVCell
        
        
        cell.labelCell.text = mydataGroup[indexPath.row]
        
        
        
        return cell
        
        
        
    }
    
    
    //選擇ＴＢV的實作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let cell = tbView.dequeueReusableCell(withIdentifier: "manageapplycell", for: indexPath) as! applyGroupTBVCell
        
        
        cell.labelCell.text = mydataGroup[indexPath.row]
        
        
        
        
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
