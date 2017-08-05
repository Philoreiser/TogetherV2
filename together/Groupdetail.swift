//
//  Groupdetail.swift
//  together
//
//  Created by ooo on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit

class Groupdetail: UIViewController {

   
    let app = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var subjectpicView: UIImageView!
    
    @IBOutlet weak var subjectDescrption: UITextView!
    
    @IBOutlet weak var subject: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var starttime: UILabel!
    
    @IBOutlet weak var endtime: UILabel!
    
    var GStartime:String?
    
    var GEndtime:String?
    
    var GLocaion:String?
    
  //  var Gsubjectpic:UIImage
    
    var Gsubject:String?
    
    
    //loadtogether
    
    
    func loadmygroup(){
        
        
        if let mid = String("8RM5OZY7f4cmj2YVPbN9eOIocm42") {
            
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
                            
                            
                            self.subject.text = a["subject"]
                            self.starttime.text = a["starttime"]
                            self.endtime.text = a["endtime"]
                            self.location.text = a["location"]
                            self.subjectDescrption.text = a["detail"]
                            let url = URL(string:"\(a["subjectpic"])")
                            
                                do{
                                    if url != nil{
                                        let data = try Data(contentsOf: url!)
                                        self.subjectpicView.image = UIImage(data: data)
                                    }else {
                                        self.subjectpicView.image = UIImage(named:"question.jpg")
                                        
                                    }
                                    
                                    
                                   
                                }catch{
                                    print(error)
                                }
                        }
                        
                        
                        //self.tbView.reloadData()
                        
                    }catch {
                        print("thisis \(error)")
                    }
                }
                
            })
            
            task.resume()
            
        }else {
            
            //沒輸入帳號直接跑到的話 給他一個假帳號
            print("no account")
            
            
        }
        
        
        //  sleep(1)
        
        
        // func putimage() {
        
        
        //      do{
        
        //        for i in 0..<subjectpic.count {
        //            let url = URL(string:"\(subjectpic[i])")
        
        //let url = URL(string:"")
        //            let data = try Data(contentsOf: url!)
        //             images.append(UIImage(data: data)!)
        //mygroupImage.image = UIImage(data: data)
        //mygroupControl.numberOfPages = subjectpic.count
        
        
        //        }
        
        
        //     }catch{
        //         print(error)
        //     }
        
        //print(subjectpic)
        //print(images)
        //mygroupImage.image = images[0]
        //mygroupControl.numberOfPages = images.count
        
        
        //  }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadmygroup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
