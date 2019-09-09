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

    
    var partsRequestText: String?
    var selectSurgeryText: String?
    var detailPositiveText: String?
    var detailNegativeText: String?
    
    
    @IBOutlet weak var requestTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTextView.text = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cartaVC = segue.destination as! CartaViewController
        
        
    
    }
    

    
    
    @IBAction func makeCarta(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "カルテのタイトル", message: "カルテのタイトルを入力してください", preferredStyle: .alert)
        

        
        
        let object = NCMBObject(className: "OtherRequest")
        object?.setObject(requestTextView.text, forKey: NCMBUser.current()!.objectId)
        object?.saveInBackground({ (error) in
            if error != nil{
                print(error)
            }else{
                self.resignFirstResponder()
            }
        })

        //カルテへ遷移するコード
        var sb: UIStoryboard! = UIStoryboard(name: "Carta", bundle: nil)
        var identifier: String! = "RootNavigationCartaController"
        let nv = sb.instantiateViewController(withIdentifier: identifier)
        self.present(nv, animated: true, completion: nil)

        
        
        

    }
    
   
    @IBAction func done(_ sender: Any) {
        
        requestTextView.resignFirstResponder()
        
    }
    
    
    
    @IBAction func trash(_ sender: Any) {
        
        
        
    }
    
    
    
}
