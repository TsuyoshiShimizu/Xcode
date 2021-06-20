//
//  relayViewController.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/13.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import NendAd

class relayViewController: UIViewController,AVAudioPlayerDelegate,NADViewDelegate,NADInterstitialVideoDelegate{
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.height
    var select:AVAudioPlayer!
    var back:AVAudioPlayer!
    var retrybutton: UIButton!
    var stageselect: UIButton!
    var nextbutton: UIButton!
    var nextbuttonflag: Bool = false
    var glabel:UILabel = UILabel()
    var relabel:UILabel = UILabel()
    var sslabel:UILabel = UILabel()
    var nextlabel:UILabel = UILabel()
    private var nadView: NADView!
    private let interstitialVideo = NADInterstitialVideo(spotId: "910972", apiKey: "f1b58f42b09f0eceb2ee86afcfafdeaba417b225")
    
    override func viewDidLoad() {
        self.interstitialVideo.delegate = self
        self.interstitialVideo.loadAd()
        nadView = NADView(frame: CGRect(x: (w - 300) / 2, y: (h - 250) / 2, width: 300, height: 250))
        nadView.setNendID("308bc8dcddec389849526f377fbf92805860033f", spotID: "909810")
        nadView.delegate = self
        nadView.load()
        super.viewDidLoad()
        let sv = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
        view.addSubview(sv)
        let ss = SKScene(size: sv.frame.size)
     //   ss.backgroundColor = .white
        let background = SKSpriteNode(imageNamed: "bg0")
        background.position = CGPoint(x: w / 2, y: h / 2)
        background.size = CGSize(width: w, height: h)
        ss.addChild(background)
        sv.presentScene(ss)
        
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
        
        let stagestatas = UserDefaults.standard.integer(forKey: "viewstatas")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            if stagestatas == 0{
                let nextvc = StageSelectViewController()
                self.present(nextvc, animated: false, completion: nil)
            }
            if stagestatas == -2{
                let nextvc = tutorialViewController()
                self.present(nextvc, animated: false, completion: nil)
            }
        }
    }
    
    func updatestagestatas(){
        let stagestatas = UserDefaults.standard.integer(forKey: "viewstatas")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            if stagestatas == -1{
                let nextvc = firstViewController()
                self.present(nextvc, animated: false, completion: nil)
            }
            else if stagestatas == -2{
                let nextvc = tutorialViewController()
                self.present(nextvc, animated: false, completion: nil)
            }
            else if stagestatas == -3{
                let nextvc = tstageVC01()
                self.present(nextvc, animated: false, completion: nil)
            }
            else if stagestatas == -4{
                let nextvc = tstageVC02()
                self.present(nextvc, animated: false, completion: nil)
            }
            else if stagestatas == -5{
                let nextvc = tstageVC03()
                self.present(nextvc, animated: false, completion: nil)
            }
            else if stagestatas == -6{
                let nextvc = tstageVC04()
                self.present(nextvc, animated: false, completion: nil)
            }
            else if stagestatas == 0{
                let nextvc = StageSelectViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 1{
                let nextvc = Stage01ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 2{
                let nextvc = Stage02ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 3{
                let nextvc = stage03ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 4{
                let nextvc = stage04ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 5{
                let nextvc = stage05ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 6{
                let nextvc = stage06ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 7{
                let nextvc = stage07ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 8{
                let nextvc = stage08ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 9{
                let nextvc = stage09ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 10{
                let nextvc = stage10ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 11{
                let nextvc = stage11ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 12{
                let nextvc = stage12ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 13{
                let nextvc = stage13ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 14{
                let nextvc = stage14ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 15{
                let nextvc = stage15ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 16{
                let nextvc = stage16ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 101{
                let nextvc = stageS1ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 102{
                let nextvc = stageS2ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 103{
                let nextvc = stageS3ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }else if stagestatas == 104{
                let nextvc = stageS4ViewController()
                self.present(nextvc, animated: false, completion: nil)
            }
        }
    }
    
    func gcstagestatas(){
   //     let stagestatas = UserDefaults.standard.integer(forKey: "viewstatas")
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        let xx = w / 10
        let yy = h / 18
        let gameover = UserDefaults.standard.bool(forKey: "gameover")
        let clear = UserDefaults.standard.bool(forKey: "clear")
        let stage = UserDefaults.standard.integer(forKey: "playstage")
        var CMcount = UserDefaults.standard.integer(forKey: "cmcount")
        
        let gxp: CGFloat = 0 //GAME OVERおよびCLEARのxの位置
        let gyp: CGFloat = 1 //GAME OVERおよびCLEARのyの位置
        let gsx: CGFloat = 10 //GAME OVERおよびCLEARの幅
        let gsy: CGFloat = 3 //GAME OVERおよびCLEARの高さ
        let gtexts: CGFloat = 1.4 //GAME OBERおよびCLEARの文字サイズ
        
        let nextxp: CGFloat = 7.5 //次のステージのxの位置
        let nextyp: CGFloat = 15 //次のステージのyの位置
        let nextsx: CGFloat = 2 //次のステージの幅
        let nextsy: CGFloat = 2 //次のステージの高さ
        
        let rexp: CGFloat = 3.5 //リトライのステージのxの位置
        let reyp: CGFloat = 15 //リトライのyの位置
        let resx: CGFloat = 3 //リトライの幅
        let resy: CGFloat = 2 //リトライの高さ
        
        let ssxp: CGFloat = 0.5 //ステージセレクトの位置
        let ssyp: CGFloat = 15 //ステージセレクトのyの位置
        let sssx: CGFloat = 2 //ステージセレクトの幅
        let sssy: CGFloat = 2 //ステージセレクトの高さ
        
        var gstatas: String = "GAME OVER"
        
        view.addSubview(nadView)
    
  //      self.showButtonClicked()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            if clear{
                UserDefaults.standard.set(false, forKey: "clear")
                gstatas = "GAME CLEAR"
                CMcount += 1
                if CMcount == 3{
                    if self.interstitialVideo.isReady {
                        self.interstitialVideo.showAd(from: self)
                    }
                    CMcount = 0
                }
                UserDefaults.standard.set(CMcount, forKey: "cmcount")
                //次のステージのボタン表示設定(ステージクリア時のみ)
                if stage < 100 && stage != 16{
                    self.nextbuttonflag = true
                    self.nextbutton = UIButton(frame: CGRect(x: xx * nextxp,y:yy * nextyp,width: xx * nextsx,height:yy * nextsy))
                    self.nextbutton.setImage(UIImage.init(named: "共有矢印"), for: .normal)
                    self.nextbutton.addTarget(self, action: #selector(relayViewController.next(_:)), for: .touchUpInside)
                    self.view.addSubview(self.nextbutton)
                    
                    self.nextlabel.text = "次へ"
                    self.nextlabel.font = UIFont(name: "GeezaPro", size: yy / 2)
                    self.nextlabel.frame = CGRect(x: xx * nextxp, y: yy * (nextyp - 1), width: xx * nextsx, height: yy)
                    self.nextlabel.textAlignment = NSTextAlignment.center
                    self.view.addSubview(self.nextlabel)
                }
            }else if gameover{
                self.nextbuttonflag = false
                UserDefaults.standard.set(false, forKey: "gameover")
                CMcount += 1
                if CMcount == 3{
                    if self.interstitialVideo.isReady {
                        self.interstitialVideo.showAd(from: self)
                    }
                    CMcount = 0
                }
                UserDefaults.standard.set(CMcount, forKey: "cmcount")
            }
            
            //ゲームオーバー or ゲームクリアの表示設定
            /*
            let labelgradient: CAGradientLayer = CAGradientLayer()
            labelgradient.name = "garadation"
            labelgradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            labelgradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            let gradientColer = [UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 232.0 / 255.0, alpha: 1.0).cgColor, UIColor(red: 117.0 / 255.0, green: 46.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor]
            labelgradient.colors = gradientColer
            */
     //       let gradationimage = UIImage(named: "garadation")!
            
            self.glabel.text = gstatas
            self.glabel.font = UIFont(name: "GeezaPro", size: xx * gtexts)
            self.glabel.frame = CGRect(x: xx * gxp, y: yy * gyp, width: gsx * xx, height: gsy * yy)
            self.glabel.textColor = .red
            self.glabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(self.glabel)
            //ここまで
            
            //リトライボタンの表示設定
            self.retrybutton = UIButton(frame: CGRect(x: xx * rexp,y: yy * reyp,width: xx * resx,height:yy * resy))
            self.retrybutton.setImage(UIImage.init(named: "リピートボタン"), for: .normal)
            self.retrybutton.addTarget(self, action: #selector(relayViewController.retry(_:)), for: .touchUpInside)
            self.view.addSubview(self.retrybutton)
            
            self.relabel.text = "リトライ"
            self.relabel.font = UIFont(name: "GeezaPro", size: yy / 2)
            self.relabel.frame = CGRect(x: xx * rexp, y: yy * (reyp - 1), width: xx * resx, height: yy)
            self.relabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(self.relabel)
            
            
            //ステージセレクトボタンの表示設定
            self.stageselect = UIButton(frame: CGRect(x: ssxp * xx,y: ssyp * yy,width: xx * sssx,height:yy * sssy))
            self.stageselect.setImage(UIImage.init(named: "メニューアイコン"), for: .normal)
            self.stageselect.addTarget(self, action: #selector(relayViewController.stageselect(_:)), for: .touchUpInside)
            self.view.addSubview(self.stageselect)
            
            self.sslabel.text = "戻る"
            self.sslabel.font = UIFont(name: "GeezaPro", size: yy / 2)
            self.sslabel.frame = CGRect(x: xx * ssxp, y: yy * (ssyp - 1), width: xx * sssx, height: yy)
            self.sslabel.textAlignment = NSTextAlignment.center
            self.view.addSubview(self.sslabel)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        nadView.pause()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nadView.resume()
    }
    
    
    
    @objc func retry(_ sender: UIButton) {
        self.interstitialVideo.delegate = self
        self.interstitialVideo.loadAd()
        sender.isEnabled = false
        select.play()
        self.glabel.removeFromSuperview()
        self.retrybutton.removeFromSuperview()
        self.stageselect.removeFromSuperview()
        self.relabel.removeFromSuperview()
        self.sslabel.removeFromSuperview()
        if self.nextbuttonflag{
            self.nextbutton.removeFromSuperview()
            self.nextlabel.removeFromSuperview()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.updatestagestatas()
        }
    }
    
    @objc func stageselect(_ sender: UIButton) {
        self.interstitialVideo.delegate = self
        self.interstitialVideo.loadAd()
        sender.isEnabled = false
        back.play()
        self.glabel.removeFromSuperview()
        self.retrybutton.removeFromSuperview()
        self.stageselect.removeFromSuperview()
        self.relabel.removeFromSuperview()
        self.sslabel.removeFromSuperview()
        if self.nextbuttonflag{
            self.nextbutton.removeFromSuperview()
            self.nextlabel.removeFromSuperview()
        }
        UserDefaults.standard.set(0, forKey: "viewstatas")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.updatestagestatas()
        }
     //   self.showButtonClicked()
    }
    
    @objc func next(_ sender: UIButton) {
        self.interstitialVideo.delegate = self
        self.interstitialVideo.loadAd()
        sender.isEnabled = false
        UserDefaults.standard.set(0, forKey: "middleflag")
        UserDefaults.standard.set(false, forKey: "coinflag")
        select.play()
        self.glabel.removeFromSuperview()
        self.retrybutton.removeFromSuperview()
        self.stageselect.removeFromSuperview()
        self.relabel.removeFromSuperview()
        self.sslabel.removeFromSuperview()
        if self.nextbuttonflag{
            self.nextbutton.removeFromSuperview()
            self.nextlabel.removeFromSuperview()
        }
        let stage = UserDefaults.standard.integer(forKey: "viewstatas")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            UserDefaults.standard.set(stage + 1, forKey: "viewstatas")
            self.updatestagestatas()
        }
    }
    
    func showButtonClicked() {
        let showResult = NADInterstitial.sharedInstance().showAd(from: UIApplication.shared.keyWindow?.rootViewController)
        
        switch(showResult){
        case .AD_SHOW_SUCCESS:
            print("広告の表示に成功しました。")
            break
        case .AD_SHOW_ALREADY:
            print("既に広告が表示されています。")
            break
        case .AD_FREQUENCY_NOT_REACHABLE:
            print("広告のフリークエンシーカウントに達していません。")
            break
        case .AD_LOAD_INCOMPLETE:
            print("抽選リクエストが実行されていない、もしくは実行中です。")
            break
        case .AD_REQUEST_INCOMPLETE:
            print("抽選リクエストに失敗しています。")
            break
        case .AD_DOWNLOAD_INCOMPLETE:
            print("広告のダウンロードが完了していません。")
            break
        case .AD_CANNOT_DISPLAY:
            print("指定されたViewControllerに広告が表示できませんでした。")
            break
        }
    }
}



