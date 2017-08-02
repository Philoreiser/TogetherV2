//
//  messageboard.swift
//  together
//
//  Created by ooo on 27/07/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase

class messageboard: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var reviewBtn: UIButton!
    
     var groupReviews: [GroupReviewItem] = [GroupReviewItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reviewBtn.isEnabled = false        
        // 查詢節點資料
        let reference: DatabaseReference! = Database.database().reference().child("groupReviews").child("groupId-0000001")
        
        reference.queryOrderedByKey().observe(.value, with: { snapshot in
           if snapshot.childrenCount > 0 {
                var dataList: [GroupReviewItem] = [GroupReviewItem]()
                
                for item in snapshot.children {
                    let data = GroupReviewItem(snapshot: item as! DataSnapshot)
                    dataList.append(data)
                }
                
                self.groupReviews = dataList
                self.tableview.reloadData()
            }
            
            self.reviewBtn.isEnabled = true
        })
        
        
        
        

        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupReviews.count
    }
    
    // 表格的儲存格設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupReviewTableViewCell", for: indexPath) as! GroupReviewTableViewCell
        
        cell.reViewTextView?.text = self.groupReviews[indexPath.row].groupReview
        cell.loginUser.text = self.groupReviews[indexPath.row].userEmail
        
        return cell
    }
 
    
    
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Msgboard" {
            _ = segue.destination as! MsgtableViewController
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
