//
//  myAllOpenGroupVC.swift
//  together
//
//  Created by Seven Tsai on 2017/8/10.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class myAllOpenGroupVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

        
    @IBOutlet weak var tbView: UITableView!

        var mydataGroup:Array<String> = []
        var mydatatid:Array<String> = []
        var mydataStatus:Array<String> = []
        var mydataPic:Array<String> = []
        let app = UIApplication.shared.delegate as! AppDelegate

    
        //暫時假裝登入者
        //    let mid = "0"
        var mid:String?
        var tid:String?
    var myAllGroupSelectedTid:String?
        //ＴＢV數量
        public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return mydataGroup.count
        }
        
        
        
        
        
        //ＴＢ內容
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //////////這是table 我的揪團審核用的
//            let cell = tbView.dequeueReusableCell(withIdentifier: "myallopengroupcell", for: indexPath) as! myAllOpenGroupTBVCell
            
            let cell = tbView.dequeueReusableCell(withIdentifier: "myallopengroupcell", for: indexPath) as! myAllOpenGroupTBVCell
          
            cell.labelCell.text = mydataGroup[indexPath.row]
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
            
            
            
      
            let cell = tbView.dequeueReusableCell(withIdentifier: "myallopengroupcell", for: indexPath) as! myAllOpenGroupTBVCell
           
            ////點擊後的顯示文字。要讓他不變
            cell.labelCell.text = mydataGroup[indexPath.row]
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
            
            /////將選擇的tid值傳給appdelegate
            app.myAllGroupSelectedTid =  mydatatid[indexPath.row]
            print("我的揪團選到的揪團tid是\(app.myAllGroupSelectedTid!)")
            let vc = storyboard?.instantiateViewController(withIdentifier: "whojoinmyopengroupvc")
            show(vc!, sender: self)
        }
        

    
        func reload(){
            let vc = storyboard?.instantiateViewController(withIdentifier: "managegroupvc")
            //        show(vc!, sender: self)
            //        self.tabBarController?.selectedIndex = 2
            //        self.handleRefresh()
            
        }
        
        
        
        
        ///VIEWDIDLOAD   讀取ＤＢ資料
        func loadDB(){
            
            
            mydataGroup = []
            mydatatid = []
            mydataStatus = []
            
            //c9資料庫 post
            let url = URL(string: "https://together-seventsai.c9users.io/getMyAllGroup.php")
            let session = URLSession(configuration: .default)
            
            
            var req = URLRequest(url: url!)
            
            req.httpMethod = "POST"
            req.httpBody = "mid=\(mid!)".data(using: .utf8)
            
            let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                //                print(source!)
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            
                            
                            
                            var tid = a["tid"]!
                            var opengroupmid = a["opengroupmid"]!
                            var groupstatus = a["groupstatus"]!
                            var subjectpic = a["subjectpic"]!
                            var subject = a["subject"]!
                            var starttime = a["starttime"]!
                            var endtime = a["endtime"]!
                            //                        var displayLebel = "id:\(maid)的揪團主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                            
                            //                        var displayLebel = "maid:\(maid)主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                            var displayLebel = "tid:\(tid)開團者是\(opengroupmid)"
                            
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
                            self.mydataStatus.append("\(groupstatus)")
                            self.mydataGroup.append("\(displayLebel)")
                            self.mydatatid.append("\(tid)")
                            self.mydataPic.append("\(subjectpic)")
                            //                        }
                            
                        }
                        print("我的所有開團tid是：\(self.mydatatid)")
                        
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
        
        
    
//        func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        
//        //ask where it is first tab bar item
//        if self.tabBarController?.selectedIndex == 1 {
//            // your action, e.g.:
//            self.loadDB()
//            self.tbView.reloadData()
//            print("從1來成功")
//        }
//        if self.tabBarController?.selectedIndex == 2 {
//            // your action, e.g.:
//            self.loadDB()
//            self.tbView.reloadData()
//            print("從2來成功")
//        }
//        
//        if self.tabBarController?.selectedIndex == 3 {
//            // your action, e.g.:
//            self.loadDB()
//            self.tbView.reloadData()
//            print("從3來成功")
//        }
//    }
//    
    
    
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()

            
            
            
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
            loadDB()
            tbView.reloadData()
            print("開團過來會執行嗎？？？")
        }
    
    override func viewWillAppear(_ animated: Bool) {
        
//             loadDB()
//        tbView.reloadData()
//        print("點ＴＡＢ會執行嗎？？？")
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
