//
//  ViewController.swift
//  gravity
//
//  Created by 清水健志 on 2018/07/28.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import NendAd

class StageSelectViewController: UIViewController,AVAudioPlayerDelegate,NADViewDelegate{
    var bgmplayer:AVAudioPlayer!
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    var select:AVAudioPlayer!
    var back:AVAudioPlayer!
    let firstplay = UserDefaults.standard.bool(forKey: "firstplay")
    var disc: Int!
    private var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "coinflag")
        let stages: Int = 201
        //ステージのクリア情報の読み取り
        var stagestatas = [Int](repeating: 0, count: stages)
        for n in 1 ... stages - 1{
            stagestatas[n] = UserDefaults.standard.integer(forKey: "stage\(n)statas")
        }
        stagestatas[0] = 2
        
        nadView = NADView(frame: CGRect(x: (w - 320) / 2, y: h - 50, width: 320, height: 50))
        nadView.setNendID("b1193adf1d89be532e7a8d18f8f033b3e5fafdfe", spotID: "909793")
        nadView.delegate = self
        nadView.load()
    
        
        let xx = w / 10
        let yy = h / 18
        
        let sv = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
        sv.backgroundColor = .clear
        view.addSubview(sv)
        let ss = SKScene(size: sv.frame.size)
        let background = SKSpriteNode(imageNamed: "bg0")
        background.position = CGPoint(x: w / 2, y: h / 2)
        background.size = CGSize(width: w, height: h)
        ss.addChild(background)
        sv.presentScene(ss)
        view.addSubview(nadView)

        do{
            let audioPath = Bundle.main.path(forResource: "エディットモード01", ofType: "mp3")
            let bgmurl = URL(fileURLWithPath: audioPath!)
            bgmplayer = try AVAudioPlayer(contentsOf: bgmurl)
        }catch{
            print("error")
        }
        bgmplayer.play()
        bgmplayer.numberOfLoops = -1
        
        //ステージ選択音の読み込み
        do{
        let selectPath = Bundle.main.path(forResource: "ステージ選択音", ofType: "mp3")
        let selecturl = URL(fileURLWithPath: selectPath!)
        select = try AVAudioPlayer(contentsOf: selecturl)
        }catch{
            print("error")
        }
        do{
            let backPath = Bundle.main.path(forResource: "システム効果音", ofType: "mp3")
            let backurl = URL(fileURLWithPath: backPath!)
            back = try AVAudioPlayer(contentsOf: backurl)
        }catch{
            print("error")
        }
        
        //バックボタン作成
        let backButton = UIButton(frame: CGRect(x: xx * 0.2 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
        backButton.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
        backButton.addTarget(self, action: #selector(StageSelectViewController.back(_:)), for: .touchUpInside)
        view.addSubview(backButton)
        
        //デバック用デリートボタン
        /*
        let deleteButton = UIButton(frame: CGRect(x: w - w / 5,y: 0,width: w / 5,height:w / 10))
        deleteButton.setTitle("デリート", for: .normal)
        deleteButton.backgroundColor = UIColor.black
        deleteButton.addTarget(self, action: #selector(StageSelectViewController.deletedate(_:)), for: .touchUpInside)
        view.addSubview(deleteButton)
 */
        //ステージボタン表示
        //通常ステージ
        //一つめの位置
        let fx:CGFloat = 0.4
        let fy:CGFloat = 2
        //間隔
        let dx:CGFloat = 2.4
        let dy:CGFloat = 2.5
        //大きさ
        let sx:CGFloat = 2
        let sy:CGFloat = 2
        
        //スペシャルステーシ
        //一つめの位置
        let sfx:CGFloat = 0.4
        let sfy:CGFloat = 12
        //間隔
        let sdx:CGFloat = 2.4
        let sdy:CGFloat = 2.5
        //大きさ
        let ssx:CGFloat = 2
        let ssy:CGFloat = 2
        
        
        for n in 1...16{
            let xn = (n + 3) % 4 + 1
            let yn  = (n + 3) / 4
            
            let fxp = xx * fx
            let fyp = yy * fy
            let dwx = (xn.cgf() - 1) * xx * dx
            let dwy = (yn.cgf() - 1) * yy * dy
            let width = xx * sx
            let height = yy * sy
     
            let stageBotton = UIButton(frame: CGRect(x:fxp + dwx, y:fyp + dwy, width: width,height:height)) //ボタンの位置およびサイズ
            stageBotton.setTitle("\(yn)-\(xn)",for: .normal) //ボタンの文字
            stageBotton.titleLabel?.font = UIFont(name: "GeezaPro", size: w / 15)
            stageBotton.setTitleColor(UIColor.black, for: .normal)

            
            //面によってボタンの色を変更
            if yn == 1{//1面
                stageBotton.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
            }else if yn == 2{//2面
                stageBotton.backgroundColor = UIColor(red:  255.0/255.0, green: 255.0/255.0, blue: 153.0/255.0, alpha: 1)
            }else if yn == 3{//3面
                stageBotton.backgroundColor = UIColor(red: 192.0/255.0, green:209.0/255.0, blue: 83.0/255.0, alpha: 1)
            }else{//4面
                stageBotton.backgroundColor = UIColor(red: 209.0/255.0, green:144.0/255.0, blue: 220.0/255.0, alpha: 1)
            }
            
            //クリア状況によって外枠の色を変更
            if stagestatas[n] == 0{ //ステージをクリアしてない場合
                stageBotton.layer.borderColor = UIColor.black.cgColor //黒
                
            }else if stagestatas[n] == 1{ //アイテムを取らずにクリアした場合
                stageBotton.layer.borderColor = UIColor(red: 154.0/255.0, green:154.0/255.0, blue: 154.0/255.0, alpha: 1).cgColor //銀
                
            }else{//アイテムを取ってクリアした場合
                stageBotton.layer.borderColor = UIColor(red: 255.0/255.0, green:215.0/255.0, blue: 0.0/255.0, alpha: 1).cgColor //金
                
            }
                stageBotton.layer.borderWidth = w / 70 //外枠の幅の設定
                stageBotton.layer.cornerRadius = w / 40 //角アールの作成
            
                //ボタンを押した時のアクションを設定
                stageBotton.addTarget(self, action: #selector(StageSelectViewController.stageselect(_:)), for: .touchUpInside)
                stageBotton.accessibilityValue = "\(n)"
            
            if stagestatas[n - 1] == 0{//前のステージをクリアしてない場合
                stageBotton.isEnabled = false //ボタンを選択できなくする
                stageBotton.layer.borderColor = UIColor.clear.cgColor //外枠の色を灰色に変更
                stageBotton.backgroundColor = UIColor(red: 235.0/255.0, green:231.0/255.0, blue: 225.0/255.0, alpha: 1) //ボタンの色を灰色に変更
                stageBotton.setTitleColor(UIColor.white, for: .normal)
            }
            view.addSubview(stageBotton)
        }
        //シークレットステージ
        for n in 1...4{
            let nn = (n - 1) * 4
            if stagestatas[nn + 1] == 2 && stagestatas[nn + 2] == 2 && stagestatas[nn + 3] == 2 && stagestatas[nn + 4] == 2{
                let xn = (n + 3) % 4 + 1
                let yn  = (n + 3) / 4
                
                let fxp = xx * sfx
                let fyp = yy * sfy
                let dwx = (xn.cgf() - 1) * xx * sdx
                let dwy = (yn.cgf() - 1) * yy * sdy
                let width = xx * ssx
                let height = yy * ssy
                
                let stageBotton = UIButton(frame: CGRect(x:fxp + dwx, y:fyp + dwy, width: width,height:height)) //ボタンの位置およびサイズ
                stageBotton.setTitle("S-\(n)", for: .normal) //ボタンの文字
                stageBotton.titleLabel?.font = UIFont(name: "GeezaPro", size: w / 15)
                if stagestatas[n + 100] == 0{
                    stageBotton.layer.borderColor = UIColor.black.cgColor
                }else if stagestatas[n + 100] == 1{
                    stageBotton.layer.borderColor = UIColor(red: 154.0/255.0, green:154.0/255.0, blue: 154.0/255.0, alpha: 1).cgColor
                }else{
                    stageBotton.layer.borderColor = UIColor(red: 255.0/255.0, green:215.0/255.0, blue: 0.0/255.0, alpha: 1).cgColor
                }
                
                if n == 1{
                    stageBotton.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
                }else if n == 2{
                    stageBotton.backgroundColor = UIColor(red:  255.0/255.0, green: 255.0/255.0, blue: 153.0/255.0, alpha: 1)
                }else if n == 3{
                    stageBotton.backgroundColor = UIColor(red: 192.0/255.0, green:209.0/255.0, blue: 83.0/255.0, alpha: 1)
                }else{
                    stageBotton.backgroundColor = UIColor(red: 209.0/255.0, green:144.0/255.0, blue: 220.0/255.0, alpha: 1)
                }
                stageBotton.layer.borderWidth = w / 70 //外枠の幅の設定
                stageBotton.layer.cornerRadius = w / 40 //角アールの作成
                
                stageBotton.accessibilityValue = "\(100 + n)"
                stageBotton.addTarget(self, action: #selector(StageSelectViewController.stageselect(_:)), for: .touchUpInside)
                stageBotton.setTitleColor(UIColor.black, for: .normal)
                view.addSubview(stageBotton)
            }
        }
        
        if firstplay{
            disc = 0
            let Description = UIButton(frame: CGRect(x: xx, y: yy, width: xx * 8, height: yy * 16))
            Description.setImage(UIImage.init(named: "t1"), for: .normal)
            Description.addTarget(self, action: #selector(StageSelectViewController.dis(_:)), for: .touchUpInside)
            view.addSubview(Description)
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // デバック用デリートボタン
    /*
    @objc func deletedate(_ sender: UIButton) {
        for n in 1...50{
            UserDefaults.standard.set(0, forKey: "stage\(n)statas")
        }
    }
    */
    @objc func back(_ sender: UIButton) {
        sender.isEnabled = false
        back.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            UserDefaults.standard.set(-1, forKey: "viewstatas")
            let relayVC = self.presentingViewController as! relayViewController
            relayVC.updatestagestatas()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func stageselect(_ sender: UIButton) {
        sender.isEnabled = false
        select.play()
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        let stage = Int(sender.accessibilityValue!)
        let middleflagstatas = UserDefaults.standard.integer(forKey:"middleflag" + sender.accessibilityValue!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            let xx = w / 10
            let yy = h / 18
            UserDefaults.standard.set(stage, forKey: "viewstatas")
            if middleflagstatas == 0{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    let relayVC = self.presentingViewController as! relayViewController
                    relayVC.updatestagestatas()
                    self.dismiss(animated: false, completion: nil)
                }
            }else{
                let middlesv = SKView(frame: CGRect(x: xx , y: yy * 6 , width: xx * 8, height: yy * 7))
      //          let middless = SKScene(size: middlesv.frame.size)
                
                middlesv.layer.cornerRadius = w / 15
                middlesv.layer.masksToBounds = true
                middlesv.layer.borderColor = UIColor.black.cgColor
                middlesv.layer.borderWidth = w / 50
                
                let gradL = CAGradientLayer()
                gradL.frame = CGRect(x: 0 , y: 0 , width: xx * 8, height: yy * 7)
                let color1 = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor
                let color2 = UIColor(red: 240.0/255.0, green:255.0/255.0, blue: 255.0/255.0, alpha: 1).cgColor
                gradL.colors = [color1,color2]
                gradL.startPoint = CGPoint.init(x: 0.5, y: 1)
                gradL.endPoint = CGPoint.init(x: 0.5 , y: 0 )
                
                middlesv.layer.insertSublayer(gradL, at: 0)
                
                self.view.addSubview(middlesv)
  //              middless.backgroundColor = .white
 //               middlesv.presentScene(middless)
                let button01 = UIButton(frame: CGRect(x: xx * 1.5 , y: yy * 10 , width: xx * 3, height: yy * 2))
                button01.layer.cornerRadius = w / 20
                button01.setTitle("最初から", for: .normal)
                button01.backgroundColor = .white
                button01.accessibilityValue = sender.accessibilityValue!
                button01.addTarget(self, action: #selector(StageSelectViewController.next01(_:)), for: .touchUpInside)
                button01.layer.borderColor = UIColor.black.cgColor
                button01.layer.borderWidth = w / 100
                self.view.addSubview(button01)
                button01.titleLabel?.font = UIFont(name: "GeezaPro", size: w / 20)
                button01.setTitleColor(UIColor.black, for: .normal)
                let button02 = UIButton(frame: CGRect(x: xx * 5.5 , y: yy * 10 , width: xx * 3, height: yy * 2))
                button02.layer.cornerRadius = w / 20
                button02.setTitle("続きから", for: .normal)
                button02.backgroundColor = .white
                button02.titleLabel?.font = UIFont(name: "GeezaPro", size: w / 20)
                button02.accessibilityValue = sender.accessibilityValue!
                button02.addTarget(self, action: #selector(StageSelectViewController.next02(_:)), for: .touchUpInside)
                button02.layer.borderColor = UIColor.black.cgColor
                button02.layer.borderWidth = w / 100
                button02.setTitleColor(UIColor.black, for: .normal)
                self.view.addSubview(button02)
                let label1: UILabel = UILabel()
                label1.text = "中間ポイントから開始できます。"
                label1.font = UIFont(name: "GeezaPro", size: w / 20)
                label1.frame = CGRect(x: xx * 1.5 , y: yy * 7.0, width: xx * 8, height: yy)
                self.view.addSubview(label1)
                let label2: UILabel = UILabel()
                label2.text = "どこから開始しますか？"
                label2.font = UIFont(name: "GeezaPro", size: w / 20)
                label2.frame = CGRect(x: xx * 1.5 , y: yy * 8.0, width: xx * 8, height: yy)
                self.view.addSubview(label2)
            }
        }
    }
    
    @objc func next01(_ sender: UIButton) {
        sender.isEnabled = false
        UserDefaults.standard.set(0, forKey: "middleflag" + sender.accessibilityValue!)
        select.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let relayVC = self.presentingViewController as! relayViewController
            relayVC.updatestagestatas()
            self.dismiss(animated: false, completion: nil)
        }
    }
    @objc func next02(_ sender: UIButton) {
        sender.isEnabled = false
        select.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            let relayVC = self.presentingViewController as! relayViewController
            relayVC.updatestagestatas()
            self.dismiss(animated: false, completion: nil)
        }
    }
    @objc func dis(_ sender: UIButton) {
        disc = 1 + disc
        if disc == 1{
            sender.setImage(UIImage.init(named: "t2"), for: .normal)
        }
        if disc == 2{
            sender.setImage(UIImage.init(named: "t3"), for: .normal)
        }
        if disc == 3{
            sender.setImage(UIImage.init(named: "t4"), for: .normal)
        }
        if disc == 4{
            sender.setImage(UIImage.init(named: "t5"), for: .normal)
        }
        if disc == 5{
            sender.removeFromSuperview()
            UserDefaults.standard.set(false, forKey: "firstplay")
        }
    }
    
}
