//
//  StageS4ViewController.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import GameplayKit
import SpriteKit
import AVFoundation

class stageS4ViewController: UIViewController,AVAudioPlayerDelegate{
    var bgmplayer:AVAudioPlayer!
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    let stagew = 4
    let stageh = 5
    var gameTimer: Timer!
    var GTFlag = true
    override func viewDidLoad() {
        super.viewDidLoad()
        let ws = w * CGFloat(stagew)
        let hs = h * CGFloat(stageh)
        let wd = -CGFloat(stagew - 1) * w / 2
        let hd = -CGFloat(stageh - 1) * h / 2
        
        do{
            let audioPath = Bundle.main.path(forResource: "獄門鬼・羅刹", ofType: "mp3")
            let bgmurl = URL(fileURLWithPath: audioPath!)
            bgmplayer = try AVAudioPlayer(contentsOf: bgmurl)
            bgmplayer.numberOfLoops = -1
        }catch{
            print("error")
        }
        bgmplayer.play()
        bgmplayer.numberOfLoops = -1
        
        let sv = SKView(frame: CGRect(x: wd , y: hd , width: ws, height: hs))
        view.addSubview(sv)
        
        let ss = stageS4(size: sv.frame.size)
        sv.presentScene(ss)
        
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ _ in
            let GFlag = UserDefaults.standard.bool(forKey: "gameover")
            let CFlag = UserDefaults.standard.bool(forKey: "clear")
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){ _ in
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
