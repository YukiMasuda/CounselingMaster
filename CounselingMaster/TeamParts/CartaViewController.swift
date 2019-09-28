//
//  CartaViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/03.
//  Copyright © 2019 Yuki Masuda. All rights reserved.


import UIKit
import NCMB
import IQKeyboardManagerSwift

class CartaViewController: UIViewController {
    var tappedEditButton = 0
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var selectPartsLabel: UILabel!
    @IBOutlet weak var partsRequestTextView: UITextView!
    @IBOutlet weak var partsRequestImageView1: UIImageView!
    @IBOutlet weak var partsRequestImageView2: UIImageView!
    @IBOutlet weak var selectSurgeryTextView: UITextView!
    @IBOutlet weak var detailPositiveRequestTextView: UITextView!
    @IBOutlet weak var detailPositiveRequestImageView1: UIImageView!
    @IBOutlet weak var detailPositiveRequestImageView2: UIImageView!
    @IBOutlet weak var detailNegativeRequestTextView: UITextView!
    @IBOutlet weak var detailNegativeRequestImageView1: UIImageView!
    @IBOutlet weak var detailNegativeRequestImageView2: UIImageView!
    @IBOutlet weak var otherRequestTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var selectpartsRequestImageButton: UIButton!
    @IBOutlet weak var selectDetailPositiveImageButton: UIButton!
    @IBOutlet weak var selectDetailNegativeButton: UIButton!
    
    
    
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
        let ScrollFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.frame = ScrollFrame
        let contentRect = contentView.bounds
        scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)
        notEditable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectPartsLabel.text = selectPartsName
        partsRequestTextView.text = partsRequestText
        partsRequestImageView1.image = partsRequestImage1
        partsRequestImageView2.image = partsRequestImage2
        selectSurgeryTextView.text = selectSurgeryText
        detailPositiveRequestTextView.text = detailPositiveText
        detailPositiveRequestImageView1.image = detailPositiveImage1
        detailPositiveRequestImageView2.image = detailPositiveImage2
        detailNegativeRequestTextView.text = detailNegativeText
        detailNegativeRequestImageView1.image = detailNegativeImage1
        detailNegativeRequestImageView2.image = detailNegativeImage2
        otherRequestTextView.text = otherText
        navigationItem.title = cartaTitleName
    }
    
    @IBAction func edit(_ sender: Any) {
        //button押された回数に応じてbuttonのlabelをeditかdoneに変更する。
        tappedEditButton += 1
        if tappedEditButton % 2 == 0{
            editButton.title = "編集"
            notEditable()
        }else{
            editButton.title = "完了"
            editable()
        }
    }
    
    
    @IBAction func backToMainTableView(_ sender: Any) {
        
        var partsRequestImage1Data = partsRequestImageView1.image?.pngData()
        var partsRequestImage2Data = partsRequestImageView2.image?.pngData()
        var detailPositiveRequestImage1Data = detailPositiveRequestImageView1.image?.pngData()
        var detailPositiveRequestImage2Data = detailPositiveRequestImageView2.image?.pngData()
        var detailNegativeRequestImage1Data = detailNegativeRequestImageView1.image?.pngData()
        var detailNegativeRequestImage2Data = detailNegativeRequestImageView2.image?.pngData()
    
        var partsRequestImage1File = NCMBFile.file(with: partsRequestImage1Data) as! NCMBFile
        var partsRequestImage2File = NCMBFile.file(with: partsRequestImage2Data) as! NCMBFile
        var detailPositiveRequestImage1File = NCMBFile.file(with: detailPositiveRequestImage1Data) as! NCMBFile
        var detailPositiveRequestImage2File = NCMBFile.file(with: detailPositiveRequestImage2Data) as! NCMBFile
        var detailNegativeRequestImage1File = NCMBFile.file(with: detailNegativeRequestImage1Data) as! NCMBFile
        var detailNegativeRequestImage2File = NCMBFile.file(with: detailNegativeRequestImage2Data) as! NCMBFile
        partsRequestImage1File.saveInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                partsRequestImage2File.saveInBackground({ (error) in
                    if error != nil{
                        print(error)
                    }else{
                        detailPositiveRequestImage1File.saveInBackground({ (error) in
                            if error != nil{
                                print(error)
                            }else{
                                detailPositiveRequestImage2File.saveInBackground({ (error) in
                                    if error != nil{
                                        print(error)
                                    }else{
                                        detailNegativeRequestImage1File.saveInBackground({ (error) in
                                            if error != nil{
                                                print(error)
                                            }else{
                                                detailNegativeRequestImage2File.saveInBackground({ (error) in
                                                    if error != nil{
                                                        print(error)
                                                    }else{
                                                        //画像アップロード成功後にobject保存
                                                        let object = NCMBObject(className: "Parts")
                                                        
                                                        object?.setObject(self.partsRequestTextView.text, forKey: "partsRequest")
                                                        object?.setObject(self.selectSurgeryTextView.text, forKey: "selectSurgery")
                                                        object?.setObject(self.detailPositiveRequestTextView.text, forKey: "detailPositiveRequest")
                                                        object?.setObject(self.detailNegativeRequestTextView.text, forKey: "detailNegativeRequest")
                                                        object?.setObject(self.otherRequestTextView.text, forKey: "otherRequest")
                                                        object?.setObject(self.selectPartsLabel.text, forKey: "selectedParts")
                                                        object?.setObject(cartaTitleName, forKey: "cartaTitle")
                                                        object?.setObject(NCMBUser.current()?.objectId, forKey: "userId")
                                                        
                                                        let url1 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + partsRequestImage1File.name
                                                        let url2 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + partsRequestImage2File.name
                                                        let url3 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailPositiveRequestImage1File.name
                                                        let url4 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailPositiveRequestImage2File.name
                                                        let url5 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailNegativeRequestImage1File.name
                                                        let url6 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailNegativeRequestImage2File.name
                                                        object?.setObject(url1, forKey: "partsRequestImage1")
                                                        object?.setObject(url2, forKey: "partsRequestImage2")
                                                        object?.setObject(url3, forKey: "detailPositiveRequestImage1")
                                                        object?.setObject(url4, forKey: "detailPositiveRequestImage2")
                                                        object?.setObject(url5, forKey: "detailNegativeRequestImage1")
                                                        object?.setObject(url6, forKey: "detailNegativeRequestImage2")
                                                        
                                                        object?.saveInBackground({ (error) in
                                                            if error != nil{
                                                                print(error)
                                                            }else{
                                                                print("保存成功")
                                                            }
                                                        })
                                                    }
                                                })
                                            }
                                        })
                                    }
                                })
                            }
                        })
                    }
                })
            }
        }
        //Mainへ遷移
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
        UIApplication.shared.keyWindow?.rootViewController = rootViewController
    }
    
    func editable() {
        partsRequestTextView.isEditable = true
        selectSurgeryTextView.isEditable = true
        detailPositiveRequestTextView.isEditable = true
        detailNegativeRequestTextView.isEditable = true
        otherRequestTextView.isEditable = true
        selectpartsRequestImageButton.isHidden = false
        selectDetailPositiveImageButton.isHidden = false
        selectDetailNegativeButton.isHidden = false
        
    }
    
    func notEditable() {
        partsRequestTextView.isEditable = false
        selectSurgeryTextView.isEditable = false
        detailPositiveRequestTextView.isEditable = false
        detailNegativeRequestTextView.isEditable = false
        otherRequestTextView.isEditable = false
        selectpartsRequestImageButton.isHidden = true
        selectDetailPositiveImageButton.isHidden = true
        selectDetailNegativeButton.isHidden = true
    }
}
