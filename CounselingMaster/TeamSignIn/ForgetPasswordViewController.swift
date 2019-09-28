//
//  ForgetPasswordViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/19.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var userIdTextField: UITextField!
    @IBOutlet weak var mailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userIdTextField.delegate = self
        mailAddressTextField.delegate = self
    }
    
    
    
}
