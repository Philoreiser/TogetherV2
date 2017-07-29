//
//  manageGroupVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/28.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class manageGroupVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tbView: UITableView!

    
    var mydataGroup:Array<String> = []
    var mydataMaid:Array<String> = []
    var mydataStatus:Array<String> = []
    
    //暫時假裝登入者
     let mid = "0"
    
    
    //拒絕 入團申請
    @IBAction func deny(_ sender: Any) {
    }
    //允許入團申請
    @IBAction func admit(_ sender: Any) {
        
        
        
    }

    
    //ＴＢV數量
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return mydataGroup.count
        }
    
    
  
    //ＴＢ內容
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tbView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! openGroupTbViCell
        cell.labelCell.text = mydataGroup[indexPath.row]
//        cell.labelStatus.text = "0"
        if mydataStatus[indexPath.row] == "0" {
        cell.labelStatus.text = "待審核"
        cell.labelStatus.textColor = UIColor.blue

        }else if mydataStatus[indexPath.row] == "1" {
        cell.labelStatus.text = "通過申請"
            cell.labelStatus.textColor = UIColor.black
        
        }else if mydataStatus[indexPath.row] == "2" {
            cell.labelStatus.text = "拒絕申請"
            cell.labelStatus.textColor = UIColor.black
        }
        
        
        return cell
        
        
    
    }
    
    
    //選擇ＴＢV的實作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        print(indexPath.row)
//        print(mydata[indexPath.row])
//        print(myidtoimg[indexPath.row])
//        self.app.sentToDetailId = myidtoimg[indexPath.row]
//        print(self.app.sentToDetailId)
//        gowhere(whichVC: indexPath.row)
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! openGroupTbViCell
        cell.labelCell.text = mydataGroup[indexPath.row]
//        cell.labelStatus.text = "0"
        
        if mydataStatus[indexPath.row] == "0" {
            cell.labelStatus.text = "待審核"
            cell.labelStatus.textColor = UIColor.blue

        alertAdmitOrDeny(selectWhich:indexPath.row)
        }else if mydataStatus[indexPath.row] == "1" {
            cell.labelStatus.text = "通過申請"
            cell.labelStatus.textColor = UIColor.black
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            
        }else if mydataStatus[indexPath.row] == "2" {
            cell.labelStatus.text = "拒絕申請"
            cell.labelStatus.textColor = UIColor.black
            cell.selectionStyle = UITableViewCellSelectionStyle.none
        }
    
    
    
       
    }
    
    

    

    
    
    
    //選擇ＴＢＶ後的ＡＬＥＲＴ
    func alertAdmitOrDeny(selectWhich:Int){
        print(selectWhich)
        print(mydataGroup[selectWhich])
        print(mydataMaid[selectWhich])
        let alertController = UIAlertController(title: "會員申請", message: "申請成功", preferredStyle: .alert)
        
        //允許申請
        let admitAction = UIAlertAction(title: "允許申請", style: .default, handler: {(action) in
        
            let maidForManage = self.mydataMaid[selectWhich]
            let openGroupMid = self.mid
            let admitordeny = "1"
            //1 表狀態為通過申請
            let mastatus = "1"
//            let maidForManage = "5"
//            let openGroupMid = "0"
//            let admitordeny = "777"
            
            
            
            //如果按允許update資料庫admitordeny欄位改為1
            let url = URL(string: "https://together-seventsai.c9users.io/manageGroup.php")
            let session = URLSession(configuration: .default)
            var req = URLRequest(url: url!)
            req.httpBody = "maid=\(maidForManage)&opengroupmid=\(openGroupMid)&mid=\(self.mid)&admitordeny=\(admitordeny)&mastatus=\(mastatus)".data(using: .utf8)
            req.httpMethod = "POST"
            
            let task = session.dataTask(with: req, completionHandler: {(data,response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                print(source!)
            })
            
            task.resume()
            
            sleep(1)
          
                self.reload()
            
            
//            self.dismiss(animated: true, completion: nil
            //重新讀取ＴＢＶＩＥＷ 不知道有沒有用
//                self.reload()
            
//            )
            
        })
        
        //deny拒絕申請
        let denyAction = UIAlertAction(title: "拒絕申請", style: .default, handler: {(action) in
            
            //2 表狀態為拒絕
            let mastatus = "2"
            let maidForManage = self.mydataMaid[selectWhich]
            let openGroupMid = self.mid
            let admitordeny = "0"
            
            //            let maidForManage = "5"
            //            let openGroupMid = "0"
            //            let admitordeny = "777"
            
            
            
            //如果按拒絕 update資料庫admitordeny欄位改為0
            let url = URL(string: "https://together-seventsai.c9users.io/manageGroup.php")
            let session = URLSession(configuration: .default)
            var req = URLRequest(url: url!)
            req.httpBody = "maid=\(maidForManage)&opengroupmid=\(openGroupMid)&mid=\(self.mid)&admitordeny=\(admitordeny)&mastatus=\(mastatus)".data(using: .utf8)
            req.httpMethod = "POST"
            
            let task = session.dataTask(with: req, completionHandler: {(data,response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                print(source!)
            })
            
            task.resume()
            
            sleep(1)

            
                self.reload()
           
            

            
//            self.dismiss(animated: true, completion:nil)
        })
        
        alertController.addAction(admitAction)
        alertController.addAction(denyAction)
        self.present(alertController, animated: true, completion: nil )
    
    }
    
    func reload(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "managegroupvc")
        show(vc!, sender: self)
    
    }
    
    
    
    
    ///VIEWDIDLOAD   讀取ＤＢ資料
    func loadDB(){
        
        
         mydataGroup = []
         mydataMaid = []
         mydataStatus = []
        //先假裝給一個tid
        let tid = "1"
       
        //c9資料庫 post
        let url = URL(string: "https://together-seventsai.c9users.io/getMyOpenGroup.php")
        let session = URLSession(configuration: .default)
        
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "tid=\(tid)&mid=\(mid)".data(using: .utf8)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
            let source = String(data: data!, encoding: .utf8)
            
            //                print(source!)
            
            DispatchQueue.main.async {
                do{
                    
                    
                    let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    
                    for a in  jsonobj as! [[String:String]] {
                        //                        print(a["account"]!)
                        
                        
                        //                           print (a["mastername"]! + "正在" + a["doing"]! + "於" + a["createdate"]!)
                        
                        var maid = a["maid"]!
                        var mastatus = a["mastatus"]!
                        var applyGrouptId = a["applygrouptid"]!
                        var applyUsermId = a["applyusermid"]!
                        var openGroupmId = a["opengroupmid"]!
                        var subject = a["subject"]!
                        
                        var displayLebel = "id:\(maid)的揪團主題是\(subject),創辦者是\(openGroupmId),申請者是\(applyUsermId)"
                        
                        print("manageid:\(maid)")
                        print("mastatus:\(mastatus)")
                        print("揪團主題是\(subject)")
                        print("揪團ＩＤ是\(applyGrouptId)")
                        print("創辦者是\(openGroupmId)")
                        print("申請者是\(applyUsermId)")
                        print("-----------")
                       
                        //全部顯示用
                        self.mydataGroup.append("\(displayLebel)")
                        self.mydataStatus.append("\(mastatus)")
                        
                        //
                        self.mydataMaid.append("\(maid)")
                        
                        
                    }
    
                    
                    self.tbView.reloadData()
                    
                }catch {
                    print("thisis \(error)")
                }}
            
           
            
        })
        
        task.resume()
        
        


    }
    
    
    
    func handleRefresh(){
        
     tbView.refreshControl?.endRefreshing()
        
        
        loadDB()
        tbView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
    }
    

  

}
