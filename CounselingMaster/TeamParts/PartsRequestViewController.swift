//
//  PartsRequestViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/30.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB
import NYXImagesKit
import Fusuma


class PartsRequestViewController :
UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FusumaDelegate {

    var selectedPartsName: String!
    var selectedImages: [UIImage]!
    var resizedImage: UIImage!

    @IBOutlet weak var titleText: UITextView!
    @IBOutlet weak var requestTextView: UITextView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTextView.text = ""
        titleText.text = selectedPartsName + "をどんな印象に変えたいですか？"
    }
    
    //一枚画像が選択された時
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        print("イメージが一枚飲みの")
        partsRequestImage1 = image
        secondImageView?.image = image
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
                    partsRequestImage1 = images[0]
                   self.firstImageView.image = images[0]
                }else{
                    partsRequestImage1 = images[0]
                    partsRequestImage2 = images[1]
                    self.firstImageView.image = images[0]
                    self.secondImageView.image = images[1]
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
    
    //次のページに渡す
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectSurgeryVC = segue.destination as! SelectSurgeryViewController
        selectSurgeryVC.selectedPartsName = self.selectedPartsName
        selectSurgeryVC.partsRequestImage = self.resizedImage
        selectSurgeryVC.partsRequestText = requestTextView.text
    }*/
    
    //画像の選択
    @IBAction func selectFirstImage(_ sender: Any) {
        firstImageView?.image = nil
        secondImageView?.image = nil
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        fusuma.cropHeightRatio = 1.0
        fusuma.allowMultipleSelection = true
        fusuma.availableModes = [.library, .camera]
        fusuma.photoSelectionLimit = 2
        fusumaSavesImage = true
        present(fusuma, animated: true, completion: nil)
    }
    
    //次のページへ
    @IBAction func saveInfo(_ sender: Any) {
        self.performSegue(withIdentifier: "goToNext", sender: nil)
    }
    
    //キーボードを下げる
    @IBAction func endEditingTextView(_ sender: Any) {
        requestTextView.resignFirstResponder()
    }
    
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
