//
//  partsViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/26.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class partsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var window: UIWindow?
    
    @IBOutlet weak var memoTableView: UITableView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.dataSource = self
        memoTableView.delegate = self
        
        memoTableView.tableFooterView = UIView()
        
        
        
        

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        return cell
    }
    
    @IBAction func showMenu(_ sender: Any) {
        
        let alert = UIAlertController(title: "メニュー", message: "メニューを選択してください。", preferredStyle: .actionSheet)
        let signOutAction = UIAlertAction(title: "ログアウト", style: .default) { (action) in
            NCMBUser.logOutInBackground({ (error) in
                if error != nil{
                    print("ログアウトエラーです。")
                    print(error)
                }else{
                    
                    //ログアウト成功
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main
                    )
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //保存
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                }
            })
        }
        
        let deleteAction = UIAlertAction(title: "退会", style: .default) { (action) in
            let user = NCMBUser.current()
            
            user?.deleteInBackground({ (error) in
                if error != nil{
                    print("退会エラーです。")
                    print(error)
                }else{
                    
                    //ログアウト
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main
                    )
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    //保存
                    let ud = UserDefaults.standard
                    ud.set(false, forKey: "isLogin")
                    ud.synchronize()
                    
                }
            })
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(signOutAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func goToPartsCarta(_ sender: Any) {
        
        //partsViewに行くコード
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Parts", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootNavigationPartsController")
        self.window?.rootViewController = rootViewController
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
    }
    
    
    
}
