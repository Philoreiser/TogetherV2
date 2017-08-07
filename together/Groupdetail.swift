//
//  Groupdetail.swift
//  together
//
//  Created by ooo on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class Groupdetail: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    let app = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var subjectpicView: UIImageView!
    @IBOutlet weak var subjectDescrption: UITextView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var starttime: UILabel!
    @IBOutlet weak var endtime: UILabel!
    @IBOutlet weak var Msgboard: UITableView!
    
    @IBAction func ReviewBtn(_ sender: Any) {
        
        alertReview()
    }
    
    @IBOutlet weak var JoinGroup: UIButton!
    var GStartime:String?
    var GEndtime:String?
    var GLocaion:String?
    var Gsubject:String?
    var groupReviews: [GroupReviewItem] = [GroupReviewItem]()
    //loadtogether

    func loadmygroup(){
        
        
        if let mid = String("kO2iktB0BHRkDEhZVn8ds0s3G572") {
            
            //c9資料庫 post
            let url = URL(string: "https://together-seventsai.c9users.io/loadDBmembertogether.php")
            let session = URLSession(configuration: .default)
            
            
            var req = URLRequest(url: url!)
            
            req.httpMethod = "POST"
            req.httpBody = "mid=\(mid)".data(using: .utf8)
            
            let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
                let source = String(data: data!, encoding: .utf8)
                
                //                print(source!)
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let jsonobj = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        
                        for a in  jsonobj as! [[String:String]] {
                            
                            self.Gsubject = a["subject"]
                            self.subject.text = a["subject"]
                            self.starttime.text = a["starttime"]
                            self.endtime.text = a["endtime"]
                            self.location.text = a["location"]
                            self.subjectDescrption.text = a["detail"]
                            var TempSubjectpic:String = a["subjectpic"]!
                            let url = URL(string:"\(TempSubjectpic)")
                            
                            do{
                                if url != nil{
                                    let data = try Data(contentsOf: url!)
                                    if (UIImage(data: data) != nil) {
                                        print("OK")
                                        self.subjectpicView.image = UIImage(data: data)!
                                    }else {
                                        self.subjectpicView.image = UIImage(named:"question.jpg")
                                    }
                                    
                                    
                                    
                                    
                                    
                                }else {
                                    self.subjectpicView.image = UIImage(named:"question.jpg")
                                    
                                }
                                
                                
                                
                            }catch{
                                print(error)
                            }
     
                        }
 
                    }catch {
                        print("thisis \(error)")
                    }
                }
                
            })
            
            task.resume()
            
        }else {
            
            //沒輸入帳號直接跑到的話 給他一個假帳號
            print("no mid")
 
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupReviews.count
    }
    
    // 表格的儲存格設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupReviewTableViewCell", for: indexPath) as! GroupReviewTableViewCell
        
        var temppic = self.groupReviews[indexPath.row].userId
        
        let mid = "kO2iktB0BHRkDEhZVn8ds0s3G572"
        
        let url = URL(string: "https://together-seventsai.c9users.io/tableviewcellpersonalpic.php")
        let session = URLSession(configuration: .default)
        
        var req = URLRequest(url: url!)
        
        req.httpMethod = "POST"
        req.httpBody = "mid=\(temppic)".data(using: .utf8)
        
        let task = session.dataTask(with: req, completionHandler: {(data, response,error) in
            
            DispatchQueue.main.async {
                let source = String(data: data!, encoding: .utf8)
                
                if source != "" {
                    let url = URL(string:"\(source)")
                    do{
                        let data = try Data(contentsOf: url!)
                        cell.ProfileImg.image = UIImage(data: data)!
                    }catch{
                        print(error)
                    }
                }else {
                    cell.ProfileImg.image = UIImage(named:"question.jpg")
                }
                
            }
        })
        
        task.resume()
        
        cell.reViewTextView?.text = self.groupReviews[indexPath.row].groupReview
        cell.loginUser.text = self.groupReviews[indexPath.row].userEmail
        
        
        
        return cell
    }
    
    // use alert function to edit review
    
    func alertReview() {
        let alert = UIAlertController(title: "輸入留言", message: "請輸入留言", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        
        let reviewAction = UIAlertAction(title: "留言", style: .default, handler: {(action) in
            
            let reviewText = alert.textFields![0].text as! String
            
            //print ("\(reviewText)")
            
            if reviewText == "" {
                self.alertEmpty()
                return
            }
            
            // 新增節點資料
            let reference: DatabaseReference! = Database.database().reference().child("groupReviews").child("groupId-0000001")
            let childRef: DatabaseReference = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
            
            // get date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/M/d H:m"
            let string = formatter.string(from: Date())
            
            
            //id name 再修正為團名以及ID
            var movieReview: [String : AnyObject] = [String : AnyObject]()
            movieReview["groupId"] = "groupId-0000001" as AnyObject
            movieReview["childId"] = childRef.key as AnyObject
            movieReview["groupName"] = "\(self.Gsubject)" as AnyObject
            movieReview["groupReview"] = reviewText as AnyObject
            movieReview["userId"] = (Properties.user?.uid)! as AnyObject
            movieReview["userEmail"] = (Properties.user?.email)! as AnyObject
            movieReview["createDate"] = "\(string)" as AnyObject
            
            
            
            
            let movieReviewReference = reference.child(childRef.key)
            movieReviewReference.updateChildValues(movieReview) { (err, ref) in
                if err != nil{
                    print("err： \(err!)")
                    return
                }
                
                print(ref.description())
                
                // 返回上一頁
                //_ = self.navigationController?.popViewController(animated: true)
                self.go()
                
                
            }
            
            
        })
        
        alert.addTextField {
            (textField) in textField.placeholder = "留言"
        }
        
        alert.addAction(cancelAction)
        alert.addAction(reviewAction)
        
        show(alert, sender: self)
        
        
    }
    
    
    func go(){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "Gpdetail")
        show(vc!, sender: self)
    }
    
    
    func alertEmpty() {
        
        let alertController = UIAlertController(title: "請輸入評論", message: "不能空白喔！", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        loadmygroup()
        
        let reference: DatabaseReference! = Database.database().reference().child("groupReviews").child("groupId-0000001")
        
        reference.queryOrderedByKey().observe(.value, with: { snapshot in
            if snapshot.childrenCount > 0 {
                var dataList: [GroupReviewItem] = [GroupReviewItem]()
                
                for item in snapshot.children {
                    let data = GroupReviewItem(snapshot: item as! DataSnapshot)
                    dataList.append(data)
                }
                
                self.groupReviews = dataList
                self.Msgboard.reloadData()
            }
            
            //self.reviewBtn.isEnabled = true
        })
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
