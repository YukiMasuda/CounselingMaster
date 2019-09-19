//
//  OtherRequestViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/31.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class OtherRequestViewController: UIViewController{
    
    @IBOutlet weak var requestTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestTextView.text = ""
    }
    
    //次のページへ（カルテ作成）
    @IBAction func makeCarta(_ sender: Any) {
        let alert = UIAlertController(title: "カウンセリングシートのタイトル", message: "カウンセリングシートのタイトルを入力してください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let textFields:[UITextField]? =  alert.textFields as [UITextField]?
            if textFields != nil {
                for textField:UITextField in textFields! {
                    cartaTitleName = textField.text
                }
                otherText = self.requestTextView.text
                self.performSegue(withIdentifier: "goToNext", sender: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addTextField { (text:UITextField!) in
            text.placeholder = "タイトル"
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //カルテを削除
    @IBAction func trash(_ sender: Any) {
        let alert = UIAlertController(title: "カルテの破棄", message: "カルテを破棄しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //Mainへ遷移するコード
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
            UIApplication.shared.keyWindow?.rootViewController = rootViewController
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
