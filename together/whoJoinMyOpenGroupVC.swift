//
//  whoJoinMyOpenGroupVC.swift
//  together
//
//  Created by Seven Tsai on 2017/8/10.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class whoJoinMyOpenGroupVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tbView: UITableView!
    
    var mydataGroup:Array<String> = []
    var mydatamaid:Array<String> = []
    var mydataStatus:Array<String> = []
    var mydataPic:Array<String> = []
    
    
    //暫時假裝登入者
    //    let mid = "0"
    var mid:String?
    var tid:String?
    
    //ＴＢV數量
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mydataGroup.count
    }
    
    
    
    
    
    //ＴＢ內容
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //////////這是table 我的揪團審核用的
        //            let cell = tbView.dequeueReusableCell(withIdentifier: "myallopengroupcell", for: indexPath) as! myAllOpenGroupTBVCell
        
        let cell = tbView.dequeueReusableCell(withIdentifier: "whojoinmyopengroupcell", for: indexPath) as! whojoinmyopengroupTBVCell
        //
        //
        cell.labelCell.text = mydataGroup[indexPath.row]
        //            //        cell.labelStatus.text = "0"
        if mydataStatus[indexPath.row] == "" {
            cell.labelStatus.text = "沒資料"
            cell.labelStatus.textColor = UIColor.blue
            
        }
        else if mydataStatus[indexPath.row] == "0" {
            cell.labelStatus.text = "揪團中"
            cell.labelStatus.textColor = UIColor.black
            
        }else if mydataStatus[indexPath.row] == "1" {
            cell.labelStatus.text = "揪團結束"
            cell.labelStatus.textColor = UIColor.black
        }
        //
        //
        //
        //
        //            ////////////這是table 我的申請 用的
        //
        //
        
        return cell
        
        
        
    }
    
    
    //選擇ＴＢV的實作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //測試
        //        print(indexPath.row)
        //        print(mydata[indexPath.row])
        //        print(myidtoimg[indexPath.row])
        //        self.app.sentToDetailId = myidtoimg[indexPath.row]
        //        print(self.app.sentToDetailId)
        //        gowhere(whichVC: indexPath.row)
        
        
        
        //table 我的揪團審核用
        //
        let cell = tbView.dequeueReusableCell(withIdentifier: "whojoinmyopengroupcell", for: indexPath) as! whojoinmyopengroupTBVCell
        cell.labelCell.text = mydataGroup[indexPath.row]
        
        cell.labelStatus.text = "待審核"
        cell.labelStatus.textColor = UIColor.blue
        
        
    }
    
    
    
    func reload(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "managegroupvc")
        //        show(vc!, sender: self)
        //        self.tabBarController?.selectedIndex = 2
        //        self.handleRefresh()
        
    }
    
    
    
    
    ///VIEWDIDLOAD   讀取ＤＢ資料
    func loadDB(){
        ////先假定選到的團ＴＩＤ
        let applygrouptid = "3"
        
        mydataGroup = []
        mydatamaid = []
        mydataStatus = []
        
        //c9資料庫 post
        let url = URL(string: "https://together-seventsai.c9users.io/getWhoJoinMygroup.php")
        let session = URLSession(configuration: .default)
        
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "applygrouptid=\(applygrouptid)".data(using: .utf8)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
            let source = String(data: data!, encoding: .utf8)
            
            //                print(source!)
            
            DispatchQueue.main.async {
                do{
                    
                    
                    let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    
                    for a in  jsonobj as! [[String:String]] {
                        
                        
                        
                        var maid = a["maid"]!
                        var mastatus = a["mastatus"]!
                        var applygrouptid = a["applygrouptid"]!
                        var applyusermid = a["applyusermid"]!
                        var admitordeny = a["admitordeny"]!
                        var applytime = a["applytime"]!
                        var judgetime = a["judgetime"]!
                         var updatetime = a["updatetime"]!
                        //                        var displayLebel = "id:\(maid)的揪團主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                        
                        //                        var displayLebel = "maid:\(maid)主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                        var displayLebel = "maid:\(maid)申請者是\(applyusermid)"
                        
                        //                        print("manageid:\(maid)")
                        //                        print("mastatus:\(mastatus)")
                        //                        print("揪團主題是\(subject)")
                        //                        print("揪團ＩＤ是\(applyGrouptId)")
                        //                        print("創辦者是\(openGroupmId)")
                        //                        print("申請者是\(applyUsermId)")
                        //                        print("-----------")
                        
                        //全部顯示用
                        
                        
                        
                        
                        //
                        //                        if mastatus == "0" &&  openGroupmId == self.mid {
                        self.mydataStatus.append("\(mastatus)")
                        self.mydataGroup.append("\(displayLebel)")
                        self.mydatamaid.append("\(maid)")
//                        self.mydataPic.append("\(subjectpic)")
                        //                        }
                        
                    }
                    print("申請我揪團的maid是：\(self.mydatamaid)")
                    
                    self.tbView.reloadData()
                    
                }catch {
                    print("thisis \(error)")
                }}
            
            
            
        })
        
        task.resume()
        
        
        
        
    }
    
    
    ///////下拉更新用
    func handleRefresh(){
        
        tbView.refreshControl?.endRefreshing()
        
        
        loadDB()
        tbView.reloadData()
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app = UIApplication.shared.delegate as! AppDelegate
        mid = app.mid
        
        if mid == nil {
            mid = "0"
        }
        
        print("myAllOpenGroupVC我是使用者：\(mid!)")
        
        loadDB()
        
        tbView.refreshControl = UIRefreshControl()
        tbView.refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tbView.refreshControl?.attributedTitle = NSAttributedString(string: "更新中")
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
