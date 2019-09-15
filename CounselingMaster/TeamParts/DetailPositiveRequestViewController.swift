//
//  DetailPositiveRequestViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/31.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//


import UIKit
import NCMB
import NYXImagesKit



class DetailPositiveRequestViewController :
UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selectedPartsName: String!
    var partsRequestText: String!
    var partsRequestImage: UIImage?
    var selectSurgeryText: String!
   
    
    
    var resizedImage: UIImage?
    
    @IBOutlet weak var requestTextView: UITextView!
    
    
    @IBOutlet weak var firstImageView: UIImageView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        requestTextView.text = ""
        
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
            
        let detailNegativeRequestVC = segue.destination as! DetailNegativeRequestViewController
            
        detailNegativeRequestVC.partsRequestText = self.partsRequestText
        detailNegativeRequestVC.partsRequestImage = self.partsRequestImage
        detailNegativeRequestVC.selectSurgeryText = self.selectSurgeryText
        detailNegativeRequestVC.detailPositiveImage = self.resizedImage
        detailNegativeRequestVC.detailPositiveText = self.requestTextView.text
        detailNegativeRequestVC.selectedPartsName = self.selectedPartsName
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //写真撮り終えたらfivに写真を格納する
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.resizedImage = selectedImage.scale(byFactor: 0.4)
        
        firstImageView.image = self.resizedImage
        
        picker.dismiss(animated: true, completion: nil)

        
    }
    
    
    
    
    
    
    
    
    
    
    
    //画像の選択
    @IBAction func selectFirstImage(_ sender: Any) {
        
        let actioncontroller = UIAlertController(title: "画像選択", message: "選択してください", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) == true{
                
                //カメラ起動のコード
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }else{
                
                print("この機種ではカメラは使えません。")
                
            }
        }
        
        
        let albumAction = UIAlertAction(title: "アルバム", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                //アルバム起動のコード
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self.present(picker, animated: true, completion: nil)
                
            }else{
                
                print("この機種ではアルバムは使えません。")
            }
        }
        
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        
        actioncontroller.addAction(cameraAction)
        actioncontroller.addAction(albumAction)
        actioncontroller.addAction(cancelAction)
        self.present(actioncontroller, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @IBAction func saveInfo(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goToNext", sender: nil)
    }
    
    
    
    @IBAction func endEditingTextView(_ sender: Any) {
        
        requestTextView.resignFirstResponder()
        
    }
    
    
    @IBAction func backToBeforepage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

