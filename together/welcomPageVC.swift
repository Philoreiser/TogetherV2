//
//  welcomPageVC.swift
//  together
//
//  Created by Seven Tsai on 2017/7/23.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class welcomPageVC: UIViewController {

    
    
    func gotoVC(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "opengroupvc")
        
            self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.white
        self.title = "Welcom"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewBounds = self.view.bounds
        
      
        let btnNext = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        btnNext.setTitle("next", for: .normal)
        btnNext.backgroundColor = UIColor.green
        btnNext.addTarget(self, action: #selector(gotoVC), for: .touchUpInside)
        self.view.addSubview(btnNext)
        
        
        
        
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
