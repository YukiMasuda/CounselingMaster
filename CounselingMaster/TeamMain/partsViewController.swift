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
    
    var object: [NCMBObject] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.dataSource = self
        memoTableView.delegate = self
        
        memoTableView.tableFooterView = UIView()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255, green: 50, blue: 41, alpha: 1)
        // 引っ張って更新
        setRefreshControl()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadTimeline()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return object.count
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        cell.textLabel?.text = object[indexPath.row].object(forKey: "cartaTitle") as? String
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toCarta", sender: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCarta"{
            let selectedIndex = memoTableView.indexPathForSelectedRow
            let partsCarteVC = segue.destination as! PartsCartaViewController
            partsCarteVC.selectedObject = object[selectedIndex!.row]
        }
    }
    
    func loadTimeline(){
        
        let query = NCMBQuery(className: "Parts")
        
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
    
    @IBAction func swipeRight(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    
    
}
