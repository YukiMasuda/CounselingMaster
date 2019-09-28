//
//  ContactViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/23.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import MessageUI
import NCMB

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var contactTextView: UITextView!
    
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
        self.tabBarController?.tabBar.tintColor = UIColor(red: 255/255, green: 90/255, blue: 86/255, alpha: 100/100)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("キャンセル")
        case .saved:
            print("下書き保存")
        case .sent:
            print("送信成功")
        default:
            print("送信失敗")
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func contact(_ sender: Any) {
        if contactTextView.text.count == 0{
            let alert = UIAlertController(title: "文章が認識できません", message: "再度ご入力ください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            let object = NCMBObject(className: "Contact")
            object?.setObject(contactTextView.text, forKey: "feedback")
            object?.setObject(NCMBUser.current()?.objectId, forKey: "user")
            object?.saveInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    let thanksAlert = UIAlertController(title: "貴重なご意見ありがとうございます", message: "", preferredStyle: .alert)
                    let thanksOkAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                         self.dismiss(animated: true, completion: nil)
                    })
                    thanksAlert.addAction(thanksOkAction)
                    self.present(thanksAlert, animated: true, completion: nil)
                }
            })
        }
    }
    
    
    @IBAction func sendMail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["yukimasuda21@gmail.com"]) // 宛先アドレス
            mail.setSubject("お問い合わせ") // 件名
            mail.setMessageBody("", isHTML: false) // 本文
            present(mail, animated: true, completion: nil)
        } else {
            print("送信できません")
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
