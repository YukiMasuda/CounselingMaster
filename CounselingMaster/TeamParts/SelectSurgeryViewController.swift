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
    
    var partsRequestText: String?
    
    @IBOutlet weak var requestTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        requestTextView.text = ""
 
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToNext"{
            
            let detailPositiveRequestVC = segue.destination as! DetailPositiveRequestViewController
          
                detailPositiveRequestVC.partsRequestText = self.partsRequestText

                detailPositiveRequestVC.selectSurgeryText = requestTextView.text

        }
        
    }
    
    
    
    @IBAction func saveInfo(_ sender: Any) {
        
        let object = NCMBObject(className: "SelectSurgery")
        object?.setObject(requestTextView.text, forKey: NCMBUser.current()!.objectId)
        object?.saveInBackground({ (error) in
            if error != nil{
                
                print(error)
                
            }else{
                self.requestTextView.resignFirstResponder()
                self.performSegue(withIdentifier: "goToNext", sender: nil)
                
            }
        })
        
    }
    
    @IBAction func done(_ sender: Any) {
        
        requestTextView.resignFirstResponder()
        
    }
    
    
    @IBAction func trash(_ sender: Any) {
        
        let alert = UIAlertController(title: "カルテの破棄", message: "カルテを破棄しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let object2 = NCMBObject(className: "PartsRequest")
            object2?.deleteInBackground({ (error) in
                if error != nil{
                    print(error)
                }else{
                    
                    //Mainへ遷移するコード
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(withIdentifier: "RootTabBarController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                }
            })
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
