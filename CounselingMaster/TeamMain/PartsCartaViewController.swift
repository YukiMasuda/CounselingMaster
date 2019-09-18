//
//  PartsCartaViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/10.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import Fusuma

class PartsCartaViewController: UIViewController {
    
    var tappedEditButton = 0
    var selectedObject: NCMBObject!
    
    var partsRequestText: String!
    var partsRequestImage: UIImage?
    var selectSurgeryText: String!
    var detailPositiveText: String!
    var detailPositiveImage: UIImage?
    var detailNegativeText: String!
    var detailNegativeImage: UIImage?
    var otherRequestText: String!
    var cartaTitleText: String!
    
    

    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var selectPartsLabel: UILabel!
    @IBOutlet weak var partsRequestTextView: UITextView!
    @IBOutlet weak var partsRequestImage1View: UIImageView!
    @IBOutlet weak var partsRequestImage2View: UIImageView!
    @IBOutlet weak var selectSurgeryTextView: UITextView!
    @IBOutlet weak var detailPositiveRequestTextView: UITextView!
    @IBOutlet weak var detailPositiveRequestImage1View: UIImageView!
    @IBOutlet weak var detailPositiveRequestImage2View: UIImageView!
    @IBOutlet weak var detailNegativeRequestTextView: UITextView!
    @IBOutlet weak var detailNegativeRequestImage1View: UIImageView!
    @IBOutlet weak var detailNegativeRequestImage2View: UIImageView!
    @IBOutlet weak var otherRequestTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    @IBOutlet weak var selectPartsRequestImageButton: UIButton!
    @IBOutlet weak var selectDetailPositiveRequestImageButton: UIButton!
    @IBOutlet weak var selectDetailNegativeRequestImageButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ScrollFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.frame = ScrollFrame
        let contentRect = contentView.bounds
        scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)
        self.dismiss(animated: true, completion: nil)
        
        notEditable()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadDate()
    }
    
    //遷移先によって渡すものを分けた
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPartsRequest"{
            let selectMainCartaPartsRequestImageVC = segue.destination as! SelectMainCartaPartsRequestImageViewController
            selectMainCartaPartsRequestImageVC.selectedObject = self.selectedObject
            selectMainCartaPartsRequestImageVC.passedImage1 = self.partsRequestImage1View.image
            selectMainCartaPartsRequestImageVC.passedImage2 = self.partsRequestImage2View.image
        }
        if segue.identifier == "toDetailPositive"{
            let selectMainCartaDetailPositiveRequestVC = segue.destination as! SelectMainCartaDetailPositiveRequestViewController
            selectMainCartaDetailPositiveRequestVC.selectedObject = self.selectedObject
            selectMainCartaDetailPositiveRequestVC.passedImage1 = self.detailPositiveRequestImage1View.image
            selectMainCartaDetailPositiveRequestVC.passedImage2 = self.detailPositiveRequestImage2View.image
        }
        if segue.identifier == "toDetailNegative"{
            let selectMainCartaDetailNegativeRequestVC = segue.destination as! SelectMainCartaDetailNegativeRequestViewController
            selectMainCartaDetailNegativeRequestVC.selectedObject = self.selectedObject
            selectMainCartaDetailNegativeRequestVC.passedImage1 = self.detailNegativeRequestImage1View.image
            selectMainCartaDetailNegativeRequestVC.passedImage2 = self.detailNegativeRequestImage2View.image
        }
        
    }
    
    @IBAction func trash(_ sender: Any) {
        let alert = UIAlertController(title: "削除", message: "このカルテを削除しますか？", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.selectedObject.deleteInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func edit(_ sender: Any) {
  //button押された回数に応じてbuttonのlabelをeditかdoneに変更する。
        tappedEditButton += 1
        if tappedEditButton % 2 == 0{
            editButton.title = "edit"
            notEditable()
        }else{
            editButton.title = "done"
            editable()
        }
    }
    
    @IBAction func backToMainTableView(_ sender: Any) {
        
        
        var partsRequestImage1Data = partsRequestImage1View.image?.pngData()
        var partsRequestImage2Data = partsRequestImage2View.image?.pngData()
        var detailPositiveRequestImage1Data = detailPositiveRequestImage1View.image?.pngData()
        var detailPositiveRequestImage2Data = detailPositiveRequestImage2View.image?.pngData()
        var detailNegativeRequestImage1Data = detailNegativeRequestImage1View.image?.pngData()
        var detailNegativeRequestImage2Data = detailNegativeRequestImage2View.image?.pngData()
        
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
                                                        
                                                        
                                                        self.selectedObject?.setObject(self.partsRequestTextView.text, forKey: "partsRequest")
                                                        self.selectedObject?.setObject(self.selectSurgeryTextView.text, forKey: "selectSurgery")
                                                        self.selectedObject?.setObject(self.detailPositiveRequestTextView.text, forKey: "detailPositiveRequest")
                                                        self.selectedObject?.setObject(self.detailNegativeRequestTextView.text, forKey: "detailNegativeRequest")
                                                        self.selectedObject?.setObject(self.otherRequestTextView.text, forKey: "otherRequest")
                                                        self.selectedObject?.setObject(self.selectPartsLabel.text, forKey: "selectedParts")
                                                        self.selectedObject?.setObject(NCMBUser.current()?.objectId, forKey: "userId")
                                                        
                                                        let url1 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + partsRequestImage1File.name
                                                        let url2 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + partsRequestImage2File.name
                                                        let url3 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailPositiveRequestImage1File.name
                                                        let url4 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailPositiveRequestImage2File.name
                                                        let url5 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailNegativeRequestImage1File.name
                                                        let url6 = "https://mb.api.cloud.nifty.com/2013-09-01/applications/pgdHTTCiw5m6VaxV/publicFiles/" + detailNegativeRequestImage2File.name
                                                        self.selectedObject?.setObject(url1, forKey: "partsRequestImage1")
                                                        self.selectedObject?.setObject(url2, forKey: "partsRequestImage2")
                                                        self.selectedObject?.setObject(url3, forKey: "detailPositiveRequestImage1")
                                                        self.selectedObject?.setObject(url4, forKey: "detailPositiveRequestImage2")
                                                        self.selectedObject?.setObject(url5, forKey: "detailNegativeRequestImage1")
                                                        self.selectedObject?.setObject(url6, forKey: "detailNegativeRequestImage2")
                                                        
                                                        self.selectedObject?.saveInBackground({ (error) in
                                                            if error != nil{
                                                                print(error)
                                                            }else{
                                                                print("保存したで")
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
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func editable() {
        partsRequestTextView.isEditable = true
        selectSurgeryTextView.isEditable = true
        detailPositiveRequestTextView.isEditable = true
        detailNegativeRequestTextView.isEditable = true
        otherRequestTextView.isEditable = true
        selectPartsRequestImageButton.isHidden = false
        selectDetailPositiveRequestImageButton.isHidden = false
        selectDetailNegativeRequestImageButton.isHidden = false
    }
    
    func notEditable() {
        partsRequestTextView.isEditable = false
        selectSurgeryTextView.isEditable = false
        detailPositiveRequestTextView.isEditable = false
        detailNegativeRequestTextView.isEditable = false
        otherRequestTextView.isEditable = false
        selectPartsRequestImageButton.isHidden = true
        selectDetailPositiveRequestImageButton.isHidden = true
        selectDetailNegativeRequestImageButton.isHidden = true
    }
    
    
    func loadDate(){
        var partsRequestImage1Url = selectedObject.object(forKey: "partsRequestImage1") as! String
        var partsRequestImage2Url = selectedObject.object(forKey: "partsRequestImage2") as! String
        var detailPositiveRequestImage1Url = selectedObject.object(forKey: "detailPositiveRequestImage1") as! String
        var detailPositiveRequestImage2Url = selectedObject.object(forKey: "detailPositiveRequestImage2") as! String
        var detailNegativeRequestImage1Url = selectedObject.object(forKey: "detailNegativeRequestImage1") as! String
        var detailNegativeRequestImage2Url = selectedObject.object(forKey: "detailNegativeRequestImage2") as! String
        partsRequestImage1View.kf.setImage(with: URL(string: partsRequestImage1Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        partsRequestImage2View.kf.setImage(with: URL(string: partsRequestImage2Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        detailPositiveRequestImage1View.kf.setImage(with: URL(string: detailPositiveRequestImage1Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        detailPositiveRequestImage2View.kf.setImage(with: URL(string: detailPositiveRequestImage2Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        detailNegativeRequestImage1View.kf.setImage(with: URL(string: detailNegativeRequestImage1Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        detailNegativeRequestImage2View.kf.setImage(with: URL(string: detailNegativeRequestImage2Url), placeholder: UIImage(named: "picturePlaceholder100.png"))
        partsRequestTextView.text = selectedObject.object(forKey: "partsRequest") as! String
        selectSurgeryTextView.text = selectedObject.object(forKey: "selectSurgery") as! String
        detailPositiveRequestTextView.text = selectedObject.object(forKey: "detailPositiveRequest") as! String
        detailNegativeRequestTextView.text = selectedObject.object(forKey: "detailNegativeRequest") as! String
        otherRequestTextView.text = selectedObject.object(forKey: "otherRequest") as! String
        selectPartsLabel.text = selectedObject.object(forKey: "selectedParts") as! String
        self.navigationItem.title = selectedObject.object(forKey: "cartaTitle") as! String
        
//イメージだけ未取得

        
    }
    
    

    
}

