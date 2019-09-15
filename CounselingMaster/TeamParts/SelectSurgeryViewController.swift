//
//  SelectSurgeryViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/31.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class SelectSurgeryViewController: UIViewController {
    
    var selectedPartsName: String!
    var partsRequestText: String!
    var partsRequestImage: UIImage?
    
    @IBOutlet weak var requestTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        requestTextView.text = ""
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(partsRequestImage)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

            
        let detailPositiveRequestVC = segue.destination as! DetailPositiveRequestViewController
        
        detailPositiveRequestVC.selectedPartsName = self.selectedPartsName
        detailPositiveRequestVC.partsRequestText = self.partsRequestText
        detailPositiveRequestVC.partsRequestImage = self.partsRequestImage
        detailPositiveRequestVC.selectSurgeryText = requestTextView.text

    }
    
    
    
    @IBAction func saveInfo(_ sender: Any) {

                self.performSegue(withIdentifier: "goToNext", sender: nil)
    }
    
    
    
    @IBAction func done(_ sender: Any) {
        
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
