//
//  SignUpViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/25.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//



//saveButton全てのtextField埋めるまで押せないようにしたい。
import UIKit
import NCMB

class SignUpViewController: UIViewController, UITextFieldDelegate {


    
    
    
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    
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
        mailAddressTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    
    
    
    
    @IBAction func signUp(_ sender: Any) {
        
        let user = NCMBUser()
        
        if userIdTextField.text!.count >= 4{
           user.userName = userIdTextField.text
        }else{
            let alert = UIAlertController(title: "ユーザーIDの文字数が足りません。", message: "ユーザーIDは4文字以上にしてください。", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.userIdTextField.text = ""
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        user.mailAddress = mailAddressTextField.text
        
        if passwordTextField.text == confirmTextField.text{
            
            user.password = passwordTextField.text
            
        }else{
            let alert = UIAlertController(title: "パスワードが一致しません。", message: "再度入力し直してください。", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                self.passwordTextField.text = ""
                self.confirmTextField.text = ""
                self.dismiss(animated: true, completion: nil)
        }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        user.saveInBackground { (error) in
            if error != nil{
                print("ユーザー情報をNCMBに送る過程でエラーが出ました。")
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
        
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
