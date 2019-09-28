//
//  SignInViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/25.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class SignInViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userIdTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 90/255, blue: 86/255, alpha: 100/100)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.white
        ]
        userIdTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        
        if (userIdTextField.text?.count)! > 0 && (passwordTextField.text?.count)! > 0{
            
            NCMBUser.logInWithUsername(inBackground: userIdTextField.text, password: passwordTextField.text) { (user, error) in
                if error != nil{
                    let alert = UIAlertController(title: "ログインエラー", message: "ユーザーID、またはパスワードが違います", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        alert.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true
                        , completion: nil)

                    print(error)
                }else{
                    
                    //登録成功したら画面遷移するコード
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //保存のコード
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogin")
                    ud.synchronize()
                }
            }
            
        }else{
            let alert = UIAlertController(title: "ログインエラー", message: "ユーザーID、またはパスワードが違います", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true
                , completion: nil)
        }
            

        
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        
        
        
    }
    
    
    
}
