//
//  SelectPartsViewController.swift
//  CounselingMaster
//
//  Created by 増田悠希 on 2019/08/31.
//  Copyright © 2019 Yuki Masuda. All rights reserved.
//

import UIKit
import NCMB

class SelectPartsViewController: UIViewController {
    
    var selectedParts: String!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 90/255, blue: 86/255, alpha: 100/100)
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .white
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
            // 文字の色
            .foregroundColor: UIColor.white
        ]
        
        button1.layer.cornerRadius = 6.0
        button2.layer.cornerRadius = 6.0
        button3.layer.cornerRadius = 6.0
        button4.layer.cornerRadius = 6.0
        button5.layer.cornerRadius = 6.0
        button6.layer.cornerRadius = 6.0
        button7.layer.cornerRadius = 6.0
        button8.layer.cornerRadius = 6.0
        button9.layer.cornerRadius = 6.0
        button10.layer.cornerRadius = 6.0
        button11.layer.cornerRadius = 6.0
        case0()
    }

    //セグメントの切り替え
    @IBAction func segment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            case0()
        case 1:
            case1()
        case 2:
            case2()
        case 3:
            case3()
        default:
            break
        }
    }
    
    //次ページへ遷移
    @IBAction func goToNext(_ sender: Any) {
        if selectedParts == nil{
            let alert = UIAlertController(title: "手術する部位が未選択です", message: "手術部位を選択してください", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            selectPartsName = selectedParts
            performSegue(withIdentifier: "goToNext", sender: nil)
        }
    }
    
    //カルテの破棄
    @IBAction func trash(_ sender: Any) {
        let alert = UIAlertController(title: "カウンセリングシートの破棄", message: "カウンセリングシートを破棄しますか？", preferredStyle: .alert)
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
    
    func case0(){
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        button5.isHidden = false
        button6.isHidden = false
        button7.isHidden = true
        button8.isHidden = true
        button9.isHidden = true
        button10.isHidden = true
        button11.isHidden = true
        
        button1.setTitle("目", for: .normal)
        button2.setTitle("鼻", for: .normal)
        button3.setTitle("口もと、唇", for: .normal)
        button4.setTitle("輪郭、あご、小顔", for: .normal)
        button5.setTitle("耳", for: .normal)
        button6.setTitle("歯", for: .normal)
    }
    
    func case1(){
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        button5.isHidden = false
        button6.isHidden = false
        button7.isHidden = false
        button8.isHidden = false
        button9.isHidden = true
        button10.isHidden = true
        button11.isHidden = true
        button1.setTitle("胸", for: .normal)
        button2.setTitle("痩身", for: .normal)
        button3.setTitle("わきが、多汗症", for: .normal)
        button4.setTitle("脱毛", for: .normal)
        button5.setTitle("へそ", for: .normal)
        button6.setTitle("性器", for: .normal)
        button7.setTitle("植毛", for: .normal)
        button8.setTitle("傷跡修正", for: .normal)
    }
    
    func case2() {
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        button5.isHidden = false
        button6.isHidden = false
        button7.isHidden = false
        button8.isHidden = false
        button9.isHidden = false
        button10.isHidden = false
        button11.isHidden = false
        
        button1.setTitle("にきび", for: .normal)
        button2.setTitle("にきび跡", for: .normal)
        button3.setTitle("毛穴", for: .normal)
        button4.setTitle("しみ、そばかす", for: .normal)
        button5.setTitle("あざ", for: .normal)
        button6.setTitle("赤ら顔", for: .normal)
        button7.setTitle("くすみ", for: .normal)
        button8.setTitle("ほくろ", for: .normal)
        button9.setTitle("イボ", for: .normal)
        button10.setTitle("肝斑", for: .normal)
        button11.setTitle("粉瘤", for: .normal)
    }
    
    func case3() {
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false
        button5.isHidden = false
        button6.isHidden = false
        button7.isHidden = false
        button8.isHidden = false
        button9.isHidden = true
        button10.isHidden = true
        button11.isHidden = true
        
        button1.setTitle("しわ", for: .normal)
        button2.setTitle("たるみ", for: .normal)
        button3.setTitle("小じわ", for: .normal)
        button4.setTitle("ほうれい線", for: .normal)
        button5.setTitle("ミッドチークライン", for: .normal)
        button6.setTitle("マリオネットライン", for: .normal)
        button7.setTitle("目のくぼみ", for: .normal)
        button8.setTitle("こめかみのくぼみ", for: .normal)
    }
    
    //各々のボタンがタップされた時のアクション
    @IBAction func tappedButton1(_ sender: Any) {
        selectedParts = button1.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor.blue
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton2(_ sender: Any) {
        selectedParts = button2.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor.blue
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton3(_ sender: Any) {
        selectedParts = button3.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor.blue
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton4(_ sender: Any) {
        selectedParts = button4.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor.blue
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton5(_ sender: Any) {
        selectedParts = button5.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor.blue
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton6(_ sender: Any) {
        selectedParts = button6.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor.blue
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton7(_ sender: Any) {
        selectedParts = button7.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor.blue
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton8(_ sender: Any) {
        selectedParts = button8.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor.blue
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton9(_ sender: Any) {
        selectedParts = button9.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor.blue
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton10(_ sender: Any) {
        selectedParts = button10.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor.blue
        button11.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
    }
    @IBAction func tappedButton11(_ sender: Any) {
        selectedParts = button11.titleLabel!.text!
        print(selectedParts)
        button1.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button2.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button3.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button4.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button5.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button6.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button7.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button8.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button9.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button10.backgroundColor = UIColor(red: 31/255, green: 227/255, blue: 255/255, alpha: 1)
        button11.backgroundColor = UIColor.blue
    }


    
}
