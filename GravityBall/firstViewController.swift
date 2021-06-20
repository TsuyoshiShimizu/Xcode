//
//  firstViewController.swift
//  testgame
//
//  Created by 清水健志 on 2018/07/28.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//
import UIKit
import SpriteKit
import AVFoundation
import NendAd


class firstViewController: UIViewController,AVAudioPlayerDelegate,NADViewDelegate{
    var bgmplayer:AVAudioPlayer!
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    var back:AVAudioPlayer!
    var disc: Int!
    private var nadView: NADView!
    private var adLoader: NADFullBoardLoader!
    private var ad: NADFullBoard?
        override func viewDidLoad() {
            super.viewDidLoad()
            let xx = w / 10
            let yy = h / 18
            UserDefaults.standard.set(0, forKey: "viewstatas")
            UserDefaults.standard.set(true, forKey: "first")
            NADLogger.setLogLevel(.info)
            
            nadView = NADView(frame: CGRect(x: (w - 320) / 2, y: h - 100, width: 320, height: 100 ))
            nadView.setNendID("53a1d908a7acb319e103add2feef91687be2390c", spotID: "909814")
            nadView.delegate = self
            nadView.load()
            
            self.adLoader = NADFullBoardLoader(spotId: "485504", apiKey: "30fda4b3386e793a14b27bedb4dcd29f03d638e5")
       //     view.addSubview(nadView)
            
            //タイトル名の位置
       //     let titlepx: CGFloat = 1
            let titlepy: CGFloat = 15
            //タイトル名のサイズ
            let titlesx: CGFloat = 9
            let titlesy: CGFloat = 3
            
            //セレクトボタンの位置
            let sspx: CGFloat = 1
            let sspy: CGFloat = 6
            //セレクトボタンのサイズ
            let sssx: CGFloat = 8
            let sssy: CGFloat = 2
            
            //操作説明ボタンの位置
            let tutorialpx: CGFloat = 1
            let tutorialpy: CGFloat = 9
            //操作説明ボタンのサイズ
            let tutorialsx: CGFloat = 8
            let tutorialsy: CGFloat = 2
            
            //チュートリアルボタンの位置
            let tutorial2px: CGFloat = 1
            let tutorial2py: CGFloat = 12
            //チュートリアルボタンのサイズ
            let tutorial2sx: CGFloat = 8
            let tutorial2sy: CGFloat = 2
        
            /*
            UserDefaults.standard.set(2, forKey: "stage1statas")
            UserDefaults.standard.set(2, forKey: "stage2statas")
            UserDefaults.standard.set(2, forKey: "stage3statas")
            UserDefaults.standard.set(2, forKey: "stage4statas")
         
            UserDefaults.standard.set(2, forKey: "stage5statas")
            UserDefaults.standard.set(2, forKey: "stage6statas")
            UserDefaults.standard.set(2, forKey: "stage7statas")
            UserDefaults.standard.set(2, forKey: "stage8statas")
            UserDefaults.standard.set(2, forKey: "stage9statas")
            UserDefaults.standard.set(2, forKey: "stage10statas")
            UserDefaults.standard.set(2, forKey: "stage11statas")
            UserDefaults.standard.set(2, forKey: "stage12statas")
            UserDefaults.standard.set(2, forKey: "stage13statas")
            UserDefaults.standard.set(2, forKey: "stage14statas")
            UserDefaults.standard.set(2, forKey: "stage15statas")
            UserDefaults.standard.set(2, forKey: "stage16statas")
 */

            let sv = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(sv)
            let ss = SKScene(size: sv.frame.size)
            
            //背景画像の表示
            let background = SKSpriteNode(imageNamed: "bg0")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            ss.addChild(background)
            sv.presentScene(ss)
            
            do{
                let backPath = Bundle.main.path(forResource: "システム効果音", ofType: "mp3")
                let backurl = URL(fileURLWithPath: backPath!)
                back = try AVAudioPlayer(contentsOf: backurl)
            }catch{
                print("error")
            }
            
            do{
                let audioPath = Bundle.main.path(forResource: "多次元空間系少女いずみえちゃん", ofType: "mp3")
                let bgmurl = URL(fileURLWithPath: audioPath!)
                bgmplayer = try AVAudioPlayer(contentsOf: bgmurl)
            }catch{
                print("error")
            }
            bgmplayer.play()
            bgmplayer.numberOfLoops = -1
            
            
            let title = SKSpriteNode(imageNamed: "title")
            title.position = CGPoint(x: w / 2, y: yy * titlepy)
            title.size = CGSize(width:xx * titlesx, height: yy * titlesy)
            ss.addChild(title)
        
            let stageselect = UIButton(frame: CGRect(x: xx * sspx,y: yy * sspy,width: xx * sssx,height:yy * sssy)) //ボタンのサイズと位置を設定
            stageselect.setImage(UIImage.init(named: "start"), for: .normal)
            stageselect.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1) //ボタンの背景色を設定
            stageselect.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
            stageselect.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
            stageselect.layer.cornerRadius = xx / 2
            stageselect.accessibilityValue = "0"
            stageselect.addTarget(self, action: #selector(firstViewController.goNext(_:)), for: .touchUpInside) //ボタンのアクションを設定
            view.addSubview(stageselect) //ボタンを表示
            
            let tutorial = UIButton(frame: CGRect(x: xx * tutorialpx,y: yy * tutorialpy,width: xx * tutorialsx,height:yy * tutorialsy)) //ボタンのサイズと位置を設定
            tutorial.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1) //ボタンの背景色を設定
            tutorial.setImage(UIImage.init(named: "操作説明"), for: .normal)
            tutorial.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
            tutorial.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
            tutorial.layer.cornerRadius = xx / 2
            tutorial.addTarget(self, action: #selector(firstViewController.tyut(_:)), for: .touchUpInside) //ボタンのアクションを設定
            view.addSubview(tutorial) //ボタンを表示
            
            let tutorial2 = UIButton(frame: CGRect(x: xx * tutorial2px,y: yy * tutorial2py,width: xx * tutorial2sx,height:yy * tutorial2sy)) //ボタンのサイズと位置を設定
            tutorial2.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1) //ボタンの背景色を設定
            tutorial2.setImage(UIImage.init(named: "チュートリアル"), for: .normal)
            tutorial2.layer.borderColor = UIColor.black.cgColor //ボタンの外枠の色を設定
            tutorial2.layer.borderWidth = xx / 10 //ボタンの外枠の幅を設定
            tutorial2.layer.cornerRadius = xx / 2
            tutorial2.accessibilityValue = "-2"
            tutorial2.addTarget(self, action: #selector(firstViewController.goNext(_:)), for: .touchUpInside) //ボタンのアクションを設定
            view.addSubview(tutorial2) //ボタンを表示
            
            view.addSubview(nadView)
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    
    @objc func goNext(_ sender: UIButton) {
        bgmplayer.stop()
        back.play()
        let statas = Int(sender.accessibilityValue!)
        UserDefaults.standard.set(statas, forKey: "viewstatas")
        let first = UserDefaults.standard.bool(forKey: "first")
        if first {
            UserDefaults.standard.set(false, forKey: "first")
            let nextvc = relayViewController()
            self.present(nextvc, animated: false, completion: nil)
        }else{
            let relayVC = presentingViewController as! relayViewController
            relayVC.updatestagestatas()
            self.dismiss(animated: false, completion: nil)
        }
    }
    @objc func tyut(_ sender: UIButton) {
        disc = 0
        let xx = w / 10
        let yy = h / 18
        let Description = UIButton(frame: CGRect(x: xx, y: yy, width: xx * 8, height: yy * 16))
        Description.setImage(UIImage.init(named: "t1"), for: .normal)
        Description.addTarget(self, action: #selector(firstViewController.dis(_:)), for: .touchUpInside)
        view.addSubview(Description)
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
        }
    }
}
