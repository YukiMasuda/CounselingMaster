//
//  SelectDetailPositiveImageViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/09/19.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit

class SelectDetailPositiveImageViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstImageView.image = partsRequestImage1
        secondImageView.image = partsRequestImage2
        
    }
    
    @IBAction func upDateImage(_ sender: Any) {
        partsRequestImage1 = firstImageView.image
        partsRequestImage2 = secondImageView.image
    }
    @IBAction func selectImage(_ sender: Any) {
    }
    
    @IBAction func deleteImage(_ sender: Any) {
        firstImageView.image = nil
        secondImageView.image = nil
        partsRequestImage1 = nil
        partsRequestImage2 = nil
    }
    
}
