//
//  tstageVC03.swift
//  gravity
//
//  Created by 清水健志 on 2018/09/26.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit
import AVFoundation

class tstageVC03: UIViewController,AVAudioPlayerDelegate{
    var select:AVAudioPlayer!
    var backbgm:AVAudioPlayer!
    var bgmplayer:AVAudioPlayer!
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    let stagew = 4
    let stageh = 1
    var gameTimer: Timer!
    var GTFlag = true
    var disc: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        let ws = w * CGFloat(stagew)
        let hs = h * CGFloat(stageh)
        let wd = -CGFloat(stagew - 1) * w / 2
        let hd = -CGFloat(stageh - 1) * h / 2
        let xx = w / 10
        let yy = h / 18
        
        var shouldAutorotate: Bool{
            get{
                return false
            }
        }
        bgmread()
        
        bgmplayer.play()
        bgmplayer.numberOfLoops = -1
        
        let sv = SKView(frame: CGRect(x: wd , y: hd , width: ws, height: hs))
        view.addSubview(sv)
        let ss = tstage03(size: sv.frame.size)
        ss.backgroundColor = .white
        sv.presentScene(ss)
        
        //バックボタン作成
        let backButton = UIButton(frame: CGRect(x: xx * 0.2 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
        backButton.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
        backButton.addTarget(self, action: #selector(tstageVC03.back(_:)), for: .touchUpInside)
        view.addSubview(backButton)
        
        //説明表示
        disc = 0
        let Description = UIButton(frame: CGRect(x: xx, y: yy, width: xx * 8, height: yy * 16))
        Description.setImage(UIImage.init(named: "t3_1"), for: .normal)
        Description.addTarget(self, action: #selector(firstViewController.dis(_:)), for: .touchUpInside)
        view.addSubview(Description)
        
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            let GFlag = UserDefaults.standard.bool(forKey: "gameover")
            let CFlag = UserDefaults.standard.bool(forKey: "clear")
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){ _ in
                if self.GTFlag{
                    if GFlag{
                        self.GTFlag = false
                        UserDefaults.standard.set(false, forKey: "gameover")
                        self.back2()
                    }
                    if CFlag{
                        self.GTFlag = false
                        UserDefaults.standard.set(false, forKey: "clear")
                        UserDefaults.standard.set(-2, forKey: "viewstatas")
                        self.back2()
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back2(){
        gameTimer.invalidate()
        let relayVC = presentingViewController as! relayViewController
        relayVC.updatestagestatas()
        self.dismiss(animated: false, completion: nil)
    }
    
    func bgmread(){
        do{
            let audioPath = Bundle.main.path(forResource: "休日", ofType: "mp3")
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
            backbgm = try AVAudioPlayer(contentsOf: backurl)
        }catch{
            print("error")
        }
    }
    
    @objc func back(_ sender: UIButton) {
        sender.isEnabled = false
        backbgm.play()
        bgmplayer.stop()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            UserDefaults.standard.set(-2, forKey: "viewstatas")
            let relayVC = self.presentingViewController as! relayViewController
            relayVC.updatestagestatas()
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @objc func dis(_ sender: UIButton) {
        disc = 1 + disc
        if disc == 1{
            sender.setImage(UIImage.init(named: "t3_2"), for: .normal)
        }
        if disc == 2{
            sender.setImage(UIImage.init(named: "t3_3"), for: .normal)
        }
        if disc == 3{
            sender.setImage(UIImage.init(named: "t3_4"), for: .normal)
        }
        if disc == 4{
            sender.removeFromSuperview()
        }
    }
}



