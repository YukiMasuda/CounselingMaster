//
//  DetailMemoViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/15.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import NYXImagesKit
import Fusuma

class DetailMemoViewController: UIViewController, UITextViewDelegate{
    var selectedObject: NCMBObject!
    var image1: UIImage?
    var image2: UIImage?
    var passedImage1: UIImage?
    var passedImage2: UIImage?
    
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
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
        memoTextView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoTextView.text = selectedObject.object(forKey: "memoText") as! String
        var memoImage1Url = selectedObject.object(forKey: "memoImage1") as! String
        var memoImage2Url = selectedObject.object(forKey: "memoImage2") as! String
        firstImageView.kf.setImage(with: URL(string: memoImage1Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        secondImageView.kf.setImage(with: URL(string: memoImage2Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectDetailImageVC = segue.destination as! SelectDetailImageViewController
        selectDetailImageVC.selectedObject = self.selectedObject
        selectDetailImageVC.passedImage1 = self.firstImageView.image
        selectDetailImageVC.passedImage2 = self.secondImageView.image
    }
    
    @IBAction func upDate(_ sender: Any) {
        /*var memoImage1Data = self.firstImageView.image?.scale(byFactor: 0.3).pngData()
        var memoImage2Data = self.secondImageView.image?.scale(byFactor: 0.3).pngData()
        
        var memoImage1File = NCMBFile.file(with: memoImage1Data) as! NCMBFile
        var memoImage2File = NCMBFile.file(with: memoImage2Data) as! NCMBFile
        
        memoImage1File.saveInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                memoImage2File.saveInBackground({ (error) in
                    if error != nil{
                        print(error)
                    }else{
                        self.selectedObject?.setObject(self.memoTextView.text, forKey: "memoText")
                        let url1 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + memoImage1File.name
                        let url2 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + memoImage2File.name
                        self.selectedObject?.setObject(url1, forKey: "memoImage1")
                        self.selectedObject?.setObject(url2, forKey: "memoImage2")
                        self.selectedObject?.saveInBackground({ (error) in
                            if error != nil{
                                print(error)
                            }else{
                                print("保存成功")
                            }
                        })
                    }
                })
            }
        }*/
        
        self.selectedObject?.setObject(self.memoTextView.text, forKey: "memoText")
        self.selectedObject?.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                print("保存成功")
            }
        })
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func trash(_ sender: Any) {
        selectedObject.deleteInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}
