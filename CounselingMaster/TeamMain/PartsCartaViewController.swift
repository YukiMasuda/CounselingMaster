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

class PartsCartaViewController: UIViewController {
    
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
    
    
    var tappedEditButton = 0
    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var selectPartsLabel: UILabel!
    @IBOutlet weak var partsRequestTextView: UITextView!
    @IBOutlet weak var partsRequestImageView: UIImageView!
    @IBOutlet weak var selectSurgeryTextView: UITextView!
    @IBOutlet weak var detailPositiveRequestTextView: UITextView!
    @IBOutlet weak var detailPositiveRequestImageView: UIImageView!
    @IBOutlet weak var detailNegativeRequestTextView: UITextView!
    @IBOutlet weak var detailNegativeRequestImageView: UIImageView!
    @IBOutlet weak var otherRequestTextView: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ScrollFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.frame = ScrollFrame
        let contentRect = contentView.bounds
        scrollView.contentSize = CGSize(width: contentRect.width, height: contentRect.height)
        
        
        
    }
    
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        /*partsRequestTextView.text = partsRequestText
        partsRequestImageView.image = partsRequestImage
        selectSurgeryTextView.text = selectSurgeryText
        detailPositiveRequestTextView.text = detailPositiveText
        detailPositiveRequestImageView.image = detailPositiveImage
        detailNegativeRequestTextView.text = detailNegativeText
        detailNegativeRequestImageView.image = detailNegativeImage
        otherRequestTextView.text = otherRequestText
        navigationItem.title = cartaTitleText*/
        
        loadDate()
        
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

        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func editable() {
        
        
        partsRequestTextView.isEditable = true
        selectSurgeryTextView.isEditable = true
        detailPositiveRequestTextView.isEditable = true
        detailNegativeRequestTextView.isEditable = true
        otherRequestTextView.isEditable = true
        
        
    }
    
    
    func notEditable() {
        
        partsRequestTextView.isEditable = false
        selectSurgeryTextView.isEditable = false
        detailPositiveRequestTextView.isEditable = false
        detailNegativeRequestTextView.isEditable = false
        otherRequestTextView.isEditable = false
        
        
        
    }
    
    
    func loadDate(){
        let partsRequestImageUrl = selectedObject.object(forKey: "partsRequestImage") as! String
        let detailPositiveRequestImageUrl = selectedObject.object(forKey: "detailPositiveRequestImage") as! String
        let detailNegativeRequestImageUrl = selectedObject.object(forKey: "detailNegativeRequestImage") as! String
        partsRequestImageView.kf.setImage(with: URL(string: partsRequestImageUrl), placeholder: UIImage(named: "picturePlaceholder100.png"))
        detailPositiveRequestImageView.kf.setImage(with: URL(string: detailPositiveRequestImageUrl), placeholder: UIImage(named: "picturePlaceholder100.png"))
        detailNegativeRequestImageView.kf.setImage(with: URL(string: detailNegativeRequestImageUrl), placeholder: UIImage(named: "picturePlaceholder100.png"))
            
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

