//
//  SelectPartsRequestImageViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/19.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NYXImagesKit
import Fusuma

class SelectPartsRequestImageViewController: UIViewController, FusumaDelegate {
    var image1: UIImage?
    var image2: UIImage?
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstImageView.image = partsRequestImage1
        secondImageView.image = partsRequestImage2
        
    }
    
    //一枚画像が選択された時
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        print("イメージが一枚のみの")
        firstImageView.image = image.scale(byFactor: 0.4)
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
                self.firstImageView.image = images[0].scale(byFactor: 0.4)
            }else{
                self.firstImageView.image = images[0].scale(byFactor: 0.4)
                self.secondImageView.image = images[1].scale(byFactor: 0.4)
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
    
    //画像の選択
    @IBAction func selectFirstImage(_ sender: Any) {
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
        partsRequestImage1 = firstImageView.image
        partsRequestImage2 = secondImageView.image
        self.navigationController?.popViewController(animated: true)
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
    
    @IBAction func deleteImage(_ sender: Any) {
        firstImageView.image = nil
        secondImageView.image = nil
        partsRequestImage1 = nil
        partsRequestImage2 = nil
    }
    


}
