//
//  OtherRequestViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/31.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class OtherRequestViewController: UIViewController{

    var selectedPartsName: String!
    var partsRequestText: String!
    var partsRequestImage: UIImage?
    var selectSurgeryText: String!
    var detailPositiveText: String!
    var detailPositiveImage: UIImage?
    var detailNegativeText: String!
    var detailNegativeImage: UIImage?
    var cartaTitleText: String!
    
    @IBOutlet weak var requestTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTextView.text = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cartaVC = segue.destination as! CartaViewController
        
        
        
        cartaVC.partsRequestText = self.partsRequestText
        cartaVC.partsRequestImage = self.partsRequestImage
        cartaVC.selectSurgeryText = self.selectSurgeryText
        cartaVC.selectedPartsName = self.selectedPartsName
        cartaVC.detailPositiveText = self.detailPositiveText
        cartaVC.detailPositiveImage = self.detailPositiveImage
        cartaVC.detailNegativeText = self.detailNegativeText
        cartaVC.detailNegativeImage = self.detailNegativeImage
        cartaVC.otherRequestText = requestTextView.text
        cartaVC.cartaTitleText = self.cartaTitleText
        
        
    }
    

    

    
    
    @IBAction func makeCarta(_ sender: Any) {
        
        let alert = UIAlertController(title: "カルテのタイトル", message: "カルテのタイトルを入力してください", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let textFields:[UITextField]? =  alert.textFields as [UITextField]?
            if textFields != nil {
                for textField:UITextField in textFields! {
                    
                    self.cartaTitleText = textField.text
                    
                }
                self.performSegue(withIdentifier: "goToNext", sender: nil)
                
            }
 
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addTextField { (text:UITextField!) in
            text.placeholder = "タイトル"
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
   
    @IBAction func done(_ sender: Any) {
        
        requestTextView.resignFirstResponder()
        
    }
    
    @IBAction func backToBeforePage(_ sender: Any) {
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
