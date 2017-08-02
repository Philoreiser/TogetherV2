//
//  MsgtableViewController.swift
//  together
//
//  Created by ooo on 29/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class MsgtableViewController: UIViewController {

    
    @IBOutlet weak var review: UITextView!
    
    @IBAction func back(_ sender: Any) {
    }
    
    
    
    
    
    @IBAction func save(_ sender: Any) {
        
        if self.review.text == "" {
            //super.showMsg("請輸入評論", showMsgStatus: .loginFail, handler: nil)
            return
        }
        
        // 新增節點資料
        let reference: DatabaseReference! = Database.database().reference().child("groupReviews").child("groupId-0000001")
        let childRef: DatabaseReference = reference.childByAutoId() // 隨機生成的節點唯一識別碼，用來當儲存時的key值
        
        var movieReview: [String : AnyObject] = [String : AnyObject]()
        movieReview["groupId"] = "groupId-0000001" as AnyObject
        movieReview["childId"] = childRef.key as AnyObject
        movieReview["groupName"] = "玩命關頭8" as AnyObject
        movieReview["groupReview"] = self.review.text as AnyObject
        movieReview["userId"] = (Properties.user?.uid)! as AnyObject
        movieReview["userEmail"] = (Properties.user?.email)! as AnyObject
        movieReview["createDate"] = "20170424" as AnyObject
        
        let movieReviewReference = reference.child(childRef.key)
        movieReviewReference.updateChildValues(movieReview) { (err, ref) in
            if err != nil{
                print("err： \(err!)")
                return
            }
            
            print(ref.description())
            
            // 返回上一頁
            _ = self.navigationController?.popViewController(animated: true)
        }
 
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
