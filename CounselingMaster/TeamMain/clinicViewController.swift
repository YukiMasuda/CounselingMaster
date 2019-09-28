//
//  clinicViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/26.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class clinicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var window: UIWindow?
    var object: [NCMBObject] = []
    
    @IBOutlet weak var memoTableView: UITableView!
    
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
        memoTableView.delegate = self
        memoTableView.dataSource = self
        memoTableView.tableFooterView = UIView()
        // 引っ張って更新
        setRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadTimeline()
    }
    
    func setRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadTimeline(refreshControl:)), for: .valueChanged)
        memoTableView.addSubview(refreshControl)
    }
    
    @objc func reloadTimeline(refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        self.loadTimeline()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = object[indexPath.row].object(forKey: "memoTitle") as! String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toDetail", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadTimeline(){
        
        let query = NCMBQuery(className: "Memo")
        
        //降順に
        query?.order(byDescending: "createDate")
        query?.whereKey("userId", equalTo: NCMBUser.current()?.objectId)
        query?.findObjectsInBackground({ (result, error) in
            if error != nil{
                print(error)
            }else{
                self.object = result as! [NCMBObject]
                self.memoTableView.reloadData()
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let selectedIndex = memoTableView.indexPathForSelectedRow
            let detailMemoVC = segue.destination as! DetailMemoViewController
            detailMemoVC.selectedObject = object[selectedIndex!.row]
        }
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
            let deleteAlert = UIAlertController(title: "退会", message: "一度退会したらデータは復元できません。本当に退会しますか？", preferredStyle: .alert)
            let deleteOkAction = UIAlertAction(title: "OK", style: .default) { (action) in
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
            let deleteCancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (al) in
                deleteAlert.dismiss(animated: true, completion: nil)
            }
            deleteAlert.addAction(deleteOkAction)
            deleteAlert.addAction(deleteCancelAction)
            self.present(deleteAlert, animated: true, completion: nil)
        }
        let contactAction = UIAlertAction(title: "ご意見、お問い合わせ", style: .default) { (action) in
            self.performSegue(withIdentifier: "toContact", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(signOutAction)
        alert.addAction(deleteAction)
        alert.addAction(contactAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.view
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        print("AA")
    }
    
    /*func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let changeRed: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "赤にする") { (action, indexPath) in
            tableView.cellForRow(at: indexPath)?.backgroundColor = .red
        }
        let changeBlue: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "青にする") { (action, indexPath) in
            tableView.cellForRow(at: indexPath)?.backgroundColor = .blue
        }
        return [changeRed, changeBlue]
 }*/
}
