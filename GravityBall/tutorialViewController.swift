//
//  tutorialViewController.swift
//  gravity
//
//  Created by 清水健志 on 2018/09/14.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import AVKit



class tutorialViewController: UIViewController,AVAudioPlayerDelegate{
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    var select:AVAudioPlayer!
    var back:AVAudioPlayer!
    var bgmplayer:AVAudioPlayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        bgmread()
        let xx = w / 10
        let yy = h / 18
        
        //ビューおよびシーンの作成
        let sv = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
        sv.backgroundColor = .clear
        view.addSubview(sv)
        let ss = SKScene(size: sv.frame.size)
        let background = SKSpriteNode(imageNamed: "bg0")
        background.position = CGPoint(x: w / 2, y: h / 2)
        background.size = CGSize(width: w, height: h)
        ss.addChild(background)
        sv.presentScene(ss)
        
        //チュートリアルステージ０１ボタンの位置
        let tstage01px: CGFloat = 1
        let tstage01py: CGFloat = 3
        //チュートリアルステージ０１ボタンのサイズ
        let tstage01sx: CGFloat = 8
        let tstage01sy: CGFloat = 2
        
        //チュートリアルステージ０２ボタンの位置
        let tstage02px: CGFloat = 1
        let tstage02py: CGFloat = 6
        //チュートリアルステージ０２ボタンのサイズ
        let tstage02sx: CGFloat = 8
        let tstage02sy: CGFloat = 2
        
        //チュートリアルステージ０３ボタンの位置
        let tstage03px: CGFloat = 1
        let tstage03py: CGFloat = 9
        //チュートリアルステージ０３ボタンのサイズ
        let tstage03sx: CGFloat = 8
        let tstage03sy: CGFloat = 2
        
        //チュートリアルステージ０４ボタンの位置
        let tstage04px: CGFloat = 1
        let tstage04py: CGFloat = 12
        //チュートリアルステージ０４ボタンのサイズ
        let tstage04sx: CGFloat = 8
        let tstage04sy: CGFloat = 2
    
     
 
        //バックボタン作成
        let backButton = UIButton(frame: CGRect(x: xx * 0.2 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
        backButton.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
        backButton.addTarget(self, action: #selector(StageSelectViewController.back(_:)), for: .touchUpInside)
        view.addSubview(backButton)
        
        //チュートリアル０１
        let tstage01 = UIButton(frame: CGRect(x: xx * tstage01px,y: yy * tstage01py,width: xx * tstage01sx,height:yy * tstage01sy)) //ボタンのサイズと位置を設定
        tstage01.setImage(UIImage.init(named: "チュートリアル01"), for: .normal)
        tstage01.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
        tstage01.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
        tstage01.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
        tstage01.layer.cornerRadius = xx / 2
        tstage01.accessibilityValue = "-3"
        tstage01.addTarget(self, action: #selector(tutorialViewController.goNext(_:)), for: .touchUpInside) //ボタンのアクションを設定
        view.addSubview(tstage01)
        //チュートリアル０２
        let tstage02 = UIButton(frame: CGRect(x: xx * tstage02px,y: yy * tstage02py,width: xx * tstage02sx,height:yy * tstage02sy)) //ボタンのサイズと位置を設定
        tstage02.setImage(UIImage.init(named: "チュートリアル02"), for: .normal)
        tstage02.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
        tstage02.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
        tstage02.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
        tstage02.layer.cornerRadius = xx / 2
        tstage02.accessibilityValue = "-4"
        tstage02.addTarget(self, action: #selector(tutorialViewController.goNext(_:)), for: .touchUpInside) //ボタンのアクションを設定
        view.addSubview(tstage02)
        //チュートリアル０３
        let tstage03 = UIButton(frame: CGRect(x: xx * tstage03px,y: yy * tstage03py,width: xx * tstage03sx,height:yy * tstage03sy)) //ボタンのサイズと位置を設定
        tstage03.setImage(UIImage.init(named: "チュートリアル03"), for: .normal)
        tstage03.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
        tstage03.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
        tstage03.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
        tstage03.layer.cornerRadius = xx / 2
        tstage03.accessibilityValue = "-5"
        tstage03.addTarget(self, action: #selector(tutorialViewController.goNext(_:)), for: .touchUpInside) //ボタンのアクションを設定
        view.addSubview(tstage03)
        //チュートリアル０４
        let tstage04 = UIButton(frame: CGRect(x: xx * tstage04px,y: yy * tstage04py,width: xx * tstage04sx,height:yy * tstage04sy)) //ボタンのサイズと位置を設定
        tstage04.setImage(UIImage.init(named: "チュートリアル04"), for: .normal)
        tstage04.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
        tstage04.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
        tstage04.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
        tstage04.layer.cornerRadius = xx / 2
        tstage04.accessibilityValue = "-6"
        tstage04.addTarget(self, action: #selector(tutorialViewController.goNext(_:)), for: .touchUpInside) //ボタンのアクションを設定
        view.addSubview(tstage04)
        
    }

    
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
    
    @objc func goNext(_ sender: UIButton) {
        bgmplayer.stop()
        select.play()
        let statas = Int(sender.accessibilityValue!)
        UserDefaults.standard.set(statas, forKey: "viewstatas")
        let relayVC = presentingViewController as! relayViewController
        relayVC.updatestagestatas()
        self.dismiss(animated: false, completion: nil)
        
    }
    
    func bgmread(){
        do{
            let audioPath = Bundle.main.path(forResource: "エディットモード01", ofType: "mp3")
            let bgmurl = URL(fileURLWithPath: audioPath!)
            bgmplayer = try AVAudioPlayer(contentsOf: bgmurl)
        }catch{
            print("error")
        }
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
    }
}
