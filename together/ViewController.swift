//
//  ViewController.swift
//  together
//
//  Created by Seven Tsai on 2017/7/17.
//  Copyright © 2017年 Seven Tsai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let app = UIApplication.shared.delegate as! AppDelegate
    var passwd:String?
    var account:String?
    var isLogin = true
    // test commit 1707777777
    // test commit 1708888888
    // test commit 1697979797
    ///test branch testt2
    
    
    ///test by seven

    // test commit by Dylan
    
    
    
    @IBAction func Gotomyile(_ sender: Any) {
        //let vc = storyboard?.instantiateViewController(withIdentifier: "MainView")
       // show(vc!, sender: self)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyfileViewController1")
        show(vc!, sender: self)
    }
    
    @IBOutlet weak var login: UIButton!
  
    @IBOutlet weak var register: UIButton!
    
    
    @IBOutlet weak var accountText: UITextField!

    
    @IBOutlet weak var passwdText: UITextField!
   // 登入button，以及檢查帳號密碼是否正確
    
    @IBOutlet weak var addaccountText: UITextField!
    
    @IBOutlet weak var addpasswdText: UITextField!
    
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBAction func segmentLoginRegister(_ sender: Any) {
        switch segmentedController.selectedSegmentIndex {
        case 1:
            isLogin = false
            addMemberOrLogin()
        case 0:
            isLogin = true
            addMemberOrLogin()
        default:
            isLogin = false
            addMemberOrLogin()
            
        }
        
    }
    
    
    
    @IBAction func login(_ sender: Any) {
        do {
           let account = accountText.text!
           let passwd = passwdText.text!
            let urlString:String = "https://together-seventsai.c9users.io/checkLogin.php?account=\(account)&passwd=\(passwd)"
            let url = URL(string:urlString)
            let source = try String(contentsOf: url!, encoding: .utf8)
            if source == "pass" {
                self.app.account = account
                self.app.passwd = passwd
                //let vc = storyboard?.instantiateViewController(withIdentifier: "tableviewvc")
                //show(vc!, sender: self)
                print("ok")
            }else if source == "passwdwrong"{
                print("抱歉，密碼錯誤．")
                alertWrong()
            }else if source == "accountwrong"{
                print("抱歉，帳號錯誤．")
                alertWrong()
            }
            
        }catch{
            print(error)
        }
        
        
    }
    //新增會員
    @IBAction func addMember(_ sender: Any) {
        let url = URL(string: "https://together-seventsai.c9users.io/addMember.php")
        var request = URLRequest(url: url!)
        if addaccountText.text != "" && addpasswdText.text != "" {
            let account = addaccountText.text!
            let passwd = addpasswdText.text!
            
            do {
                let urlGet = URL(string: "https://together-seventsai.c9users.io/addMember.php?account=\(account)&passwd=\(passwd)")
                let source = try String(contentsOf: urlGet!, encoding: .utf8)
                
                if source == "accountok" {
                    print("add OK")
                    self.app.account = account
                    
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "MainView")
//                    show(vc!, sender: self)
                    
                    alertSuccess()
                    print("show")
                    
                    
                }else if source == "accountexist" {
                    
                    print("exist")
                    alertExist()
                    
                    
                }else {
                    print("else")
                }
                
                
            }catch{
                print(error)
            }
            
            
            
            
        }else {
            print("no words")
            alertEmpty()
        }
        
        
    }
    //變換註冊跟登入
    func addMemberOrLogin() {
        //註冊
        if isLogin == false {
            accountText.isHidden = true
            passwdText.isHidden = true
            login.isHidden = true
            
            addaccountText.isHidden = false
            addpasswdText.isHidden = false
            register.isHidden = false
        }else {
        //登入
            accountText.isHidden = false
            passwdText.isHidden = false
            login.isHidden = false
            
            addaccountText.isHidden = true
            addpasswdText.isHidden = true
            register.isHidden = true
        }
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
        isLogin = true
        addMemberOrLogin()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

