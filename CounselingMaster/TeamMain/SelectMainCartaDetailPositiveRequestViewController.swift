//
//  SelectMainCartaDetailPositiveRequestViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/16.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB
import Fusuma
import NYXImagesKit

class SelectMainCartaDetailPositiveRequestViewController: UIViewController, FusumaDelegate {

    var selectedObject: NCMBObject!
    var passedImage1: UIImage?
    var passedImage2: UIImage?
    var image1: UIImage?
    var image2: UIImage?
    
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
        firstImageView.image = passedImage1
        secondImageView.image = passedImage2
    }
    
    //一枚画像が選択された時
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        print("イメージが一枚のみの")
        partsRequestImage1 = image
        secondImageView?.image = image.scale(byFactor: 0.4)
    }
    
    /*func fusumaDismissedWithImage(_ image: UIImage, source: FusumaMode) {
     print("EE")
     
     }*/
    
    //複数画像が選択された時
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode, metaData: [ImageMetadata]) {
        print("選択された写真の数は\(images.count)枚です")
        var count: Double = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + (3.0 * count)) {
            if images.count == 1{
                self.image1 = images[0].scale(byFactor: 0.4)
                self.firstImageView.image = self.image1
            }else{
                self.image1 = images[0].scale(byFactor: 0.4)
                self.image2 = images[1].scale(byFactor: 0.4)
                self.firstImageView.image = self.image1
                self.secondImageView.image = self.image2
            }
            self.fusumaClosed()
        }
        count += 1
    }
    
    //カメラが使用できなかった時
    func fusumaCameraRollUnauthorized() {
        let alert = UIAlertController(title: "カメラが使えません",
                                      message: "この機種ではカメラが使えません",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "設定へ", style: .default) { (action) -> Void in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        })
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel) { (action) -> Void in
        })
        
        guard let vc = UIApplication.shared.delegate?.window??.rootViewController, let presented = vc.presentedViewController else {
            return
        }
        presented.present(alert, animated: true, completion: nil)
    }
    
    //無意味
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
        print("無意味")
    }
    
    //ビデオがを選択された時
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
        print("無意味")
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusuma.allowMultipleSelection = true
        fusuma.availableModes = [.library, .camera]
        fusuma.photoSelectionLimit = 2
        fusumaSavesImage = true
        present(fusuma, animated: true, completion: nil)
    }
    @IBAction func upDateImage(_ sender: Any) {
        var detailPositiveRequestImage1Data = firstImageView.image?.pngData()
        var detailPositiveRequestImage2Data = secondImageView.image?.pngData()
        var detailPositiveRequestImage1File = NCMBFile.file(with: detailPositiveRequestImage1Data) as! NCMBFile
        var detailPositiveRequestImage2File = NCMBFile.file(with: detailPositiveRequestImage2Data) as! NCMBFile
        detailPositiveRequestImage1File.saveInBackground { (error) in
            if error != nil{
                print(error)
            }else{
                detailPositiveRequestImage2File.saveInBackground({ (error) in
                    if error != nil{
                        print(error)
                    }else{
                        let url3 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailPositiveRequestImage1File.name
                        let url4 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailPositiveRequestImage2File.name
                        self.selectedObject?.setObject(url3, forKey: "detailPositiveRequestImage1")
                        self.selectedObject?.setObject(url4, forKey: "detailPositiveRequestImage2")
                        self.selectedObject?.saveInBackground({ (error) in
                            if error != nil{
                                print(error)
                            }else{
                                print("保存したで")
                                self.navigationController?.popViewController(animated: true)
                            }
                        })
                    }
                })
            }
        }
    }
    @IBAction func deleteImage(_ sender: Any) {
        firstImageView.image = nil
        secondImageView.image = nil
    }



}
