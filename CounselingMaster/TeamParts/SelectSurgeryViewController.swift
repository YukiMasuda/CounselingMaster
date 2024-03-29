//
//  SelectSurgeryViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/31.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class SelectSurgeryViewController: UIViewController {
    
    @IBOutlet weak var requestTextView: UITextView!
    
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
        requestTextView.text = ""
    }


    //次のページへ
    @IBAction func saveInfo(_ sender: Any) {
        selectSurgeryText = requestTextView.text
        self.performSegue(withIdentifier: "goToNext", sender: nil)
    }
    
    //カルテの破棄
    @IBAction func trash(_ sender: Any) {
        let alert = UIAlertController(title: "カウンセリングシートの破棄", message: "カウンセリングシートを破棄しますか？", preferredStyle: .alert)
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
