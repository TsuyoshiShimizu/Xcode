//
//  Stage05ViewController.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/05.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit
import AVFoundation

class stageS1ViewController: UIViewController,AVAudioPlayerDelegate{
    var bgmplayer:AVAudioPlayer!
    //画面幅
    let w = UIScreen.main.bounds.size.width
    //画面高さ
    let h = UIScreen.main.bounds.size.height
    //ステージ幅
    let stagew = 4
    //ステージ高さ
    let stageh = 6
    var gameTimer: Timer!
    var GTFlag = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let ws = w * CGFloat(stagew)
        let hs = h * CGFloat(stageh)
        let wd = -CGFloat(stagew - 1) * w / 2
        let hd = -CGFloat(stageh - 1) * h / 2
        
        //ステージBGMの設定
        do{
            let audioPath = Bundle.main.path(forResource: "Samurai Moon", ofType: "mp3")
            let bgmurl = URL(fileURLWithPath: audioPath!)
            bgmplayer = try AVAudioPlayer(contentsOf: bgmurl)
        }catch{
            print("error")
        }
        bgmplayer.play()
        bgmplayer.numberOfLoops = -1

        //Scene表示用のmainViewを作成
        let sv = SKView(frame: CGRect(x: wd , y: hd , width: ws, height: hs))
        

        //Sceneの作成
        let ss = stageS1(size: sv.frame.size)
        sv.presentScene(ss)
        

        //グラデーションを表示させるViewの作成
        //mainViewの表示
        self.view.addSubview(sv)
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            let GFlag = UserDefaults.standard.bool(forKey: "gameover")
            let CFlag = UserDefaults.standard.bool(forKey: "clear")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                if self.GTFlag{
                    if GFlag || CFlag{
                        self.GTFlag = false
                        self.back()
                    }
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func back(){
        gameTimer.invalidate()
        let relayVC = presentingViewController as! relayViewController
        relayVC.gcstagestatas()
        self.dismiss(animated: false, completion: nil)
    }
}
    
