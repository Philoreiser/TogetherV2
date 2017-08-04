//
//  registerViewController.swift
//  together
//
//  Created by ooo on 03/08/2017.
//  Copyright © 2017 Seven Tsai. All rights reserved.
//

import UIKit
import Firebase
class registerViewController: UIViewController {

    let app = UIApplication.shared.delegate as! AppDelegate
    var passwd:String?
    var account:String?
    var isLogin = true
    var id:String?
    
    
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBAction func registerBtn(_ sender: Any) {
        
        let url = URL(string: "https://together-seventsai.c9users.io/addMember.php")
        var request = URLRequest(url: url!)
        if emailText.text != "" && passwordText.text != "" {
            
            passwordText.isSecureTextEntry = true
            
            let account = emailText.text!
            let passwd = passwordText.text!
            
            
            Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordText.text!) { (user, error) in
                if error != nil {
                    self.alertWrong()
                    print("error")
                }else {
                    
                    //      }
                    //    }
                    
                    
                    do {
                        let urlGet = URL(string: "https://together-seventsai.c9users.io/addMember.php?account=\(account)&passwd=\(passwd)")
                        let source = try String(contentsOf: urlGet!, encoding: .utf8)
                        
                        if source == "accountok" {
                            print("add OK")
                            self.app.account = account
                            
                            //                    let vc = storyboard?.instantiateViewController(withIdentifier: "MainView")
                            //                    show(vc!, sender: self)
                            
                            self.alertSuccess()
                            print("show")
                            
                            
                        }else if source == "accountexist" {
                            
                            print("exist")
                            self.alertExist()
                            
                            
                        }else {
                            print("else")
                        }
                        
                        
                    }catch{
                        print(error)
                    }
                    
                }
            }
            
            
        }else {
            print("no words")
            alertEmpty()
        }
        
    }
    
    
    //驗證密碼安全性
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    //alert 空白
    func alertEmpty() {
        
        let alertController = UIAlertController(title: "帳號申請/登入", message: "不能空白喔！", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    //alert 存在
    func alertExist() {
        let alertController = UIAlertController(title: "帳號已重複", message: "請重新輸入", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    //alert 錯誤
    func alertWrong() {
        let alertController = UIAlertController(title: "帳號登入", message: "帳號或密碼錯誤", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
    }
    //register 成功
    func alertSuccess() {
        let alertController = UIAlertController(title: "帳號註冊", message: "註冊成功", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "確認", style: .default, handler: {(action) in
            go()
            //            self.dismiss(animated: true, completion: {(action) in
            //
            //
            //            })
        })
        
        
        func go(){
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "MainView")
            show(vc!, sender: self)
        }
        
        
        
        alertController.addAction(okaction)
        self.present(alertController, animated: true, completion: nil)
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
