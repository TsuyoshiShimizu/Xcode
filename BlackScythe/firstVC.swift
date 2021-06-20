//
//  ViewController.swift
//  Sickle Master
//
//  Created by 清水健志 on 2018/09/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import NendAd

class firstVC: UIViewController,NADViewDelegate,NADInterstitialVideoDelegate{
    let w = UIScreen.main.bounds.size.width;let h = UIScreen.main.bounds.size.height
    let w1 = UIScreen.main.bounds.size.width / 10;let h1 = UIScreen.main.bounds.size.height / 10
    //BGM,効果音を管理
    var playingBGM: AVAudioPlayer!  //再生中のBGMを管理
    var BGM: [AVAudioPlayer] = []   //BGMを管理
    var SE: [AVAudioPlayer] = []    //SEを管理

    //ビューを管理
    var firstView:SKView!; var stageselectView:SKView!
    var stageView:SKView!;
    var stageFrontView:TransparentView!
    var gameclearView:SKView!; var gameoverView:SKView!
    var stageStartView:UIImageView!
    var stopView:SKView!
    var stagePView: SKView!
    var loadingView: UIImageView!
    var StageFinishView: SKView!

    //説明ビューに使用するやつ
    var discriptionView: SKView!
    var discriptionN = 0
    var discriptionPageN = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
    var discriptionPageCount: [Int] = [0,2,4,2,1,3,3,3,1,4,1,2,2,3,1,1,2]
    var discriptionLabel1: UILabel = UILabel()
    var discriptionLabel2: UILabel = UILabel()
    
    var startlabel: UILabel = UILabel() //ステージクリア条件の文字を管理
    var stopButton: UIButton!           //ストップボタンを管理
    var playstage: Bool = false         //ステージをプレイ中か否か
    var disc: Int!                      //チュートリアル表示に使用
    var SButton: [UIButton] = []        //ステージセレクトのボタンを管理
    var SSChageButton: [UIButton] = []  //ステージセレクトのページ変更ボタン
    var NextButton: UIButton!           //次のステージのボタンを管理
    var NextLabel:UILabel = UILabel()   //次のステージのラベルを管理
    var stageN: Int = 0                 //プレイしているステージを管理
    var stageN2: Int = 0                //ステージのどの面にいるかを管理
    let stagesize: [Int] = [4,4]        //ステージのビューサイズを管理
    let stageCount = 42                 //総ステージ数を管理
    var Scene:[SKScene] = []            //ステージのシーンを管理
    var SceneF:[SKScene] = []           //ゲームオーバー、ステージクリア時のシーンを管理
    var HPgauge:UIProgressView!         //HPゲージを管理
    var pHP: Int = 100                  //プレイヤーのHP
    var SSPage: Int = 1                 //ステージセレクトのページ数
   
    //ここから広告表示に関するや
    //バナー広告の設定
    private var BannerViwe: [NADView] = [] //Nendのバナーを管理
    var Viewtype = 1 //(表示ビューを管理) 1:タイトル画面  2:ステージセレクト画面  3:ゲームオーバー  4:ステージクリア画面　5:ストップビュー
    let ViweCount = 5  //広告表示させるビューの数
                             //    小　  中　     大
    var BannerDisplay: [[Int]] = [[0,0],[0,0],[0,0,0]] //広告の表示数、最初の広告の表示か、どのビューに表示しているか、表示したバナーが停止中か読み込み中かを管理
    var BannerNumber: [[Int]] = [[0,0],[0,0],[0,0,0]]  //バナー広告が配列のどこに格納されているかを管理（最初の0は空打ち）
    var BannerCount = 0                                //バナーの表示順番
    
    //動画インターステシャルの設定
    private let interstitialVideo = NADInterstitialVideo(spotId: "946842", apiKey: "e98434288de0b8283cf5ea25ebfd71f5e2348dc7")
    var InterType: Int = 0      //動画インターステシャルの表示後の実行コードの違い
    // type:0 何も操作しない　type:1 ゲームオーバービューを表示　type:2 ステージクリアビューを表示
    var GOCount = UserDefaults.standard.integer(forKey: "GOCountI")  //ゲームオーバー回数
    var SCCount = UserDefaults.standard.integer(forKey: "SCCountI")  //ステージクリア回数
    var GOInterN = 2                                                 //何回目のゲームオーバーで広告を表示させるか
    var GSCInterN = 3                                                //何回目のステージクリアで広告を表示させるか
    var InterReadFlag = true                                         //動画インターステシャルをロードする必要があるか
    //広告表示はここまで
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InterstitialSetUP()   //Nend広告の表示準備
        SoundRead()           //BGM、効果音の読み込み
        displayFirstView()    //タイトル画面の表示
    }
    
    //ゲームオーバーまたはステージクリア時に表示されるビュー
    func displayStageFinishView(){
        if StageFinishView == nil {
            StageFinishView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
            view.addSubview(StageFinishView)
        }else{
            view.bringSubviewToFront(StageFinishView)
        }
        var StageFScean: SKScene!
        var displaytime: Double!
        
        if InterType == 1{
            StageFScean = GameOverScean(size: StageFinishView.frame.size)
            displaytime = 5.0
        }else if InterType == 2 {
            StageFScean = StageClearScean(size: StageFinishView.frame.size)
            displaytime = 5.0
        }
        StageFinishView.presentScene(StageFScean)
        SceneF.append(StageFScean)
        DispatchQueue.main.asyncAfter(deadline: .now() + displaytime){
            self.StageFinishInterD()
        }
    }
    
    //ゲームオーバーまたはステージクリア時の広告表示判定
    func StageFinishInterD(){
        if InterType == 1{
            GOCount += 1
            if GOCount == GOInterN{
                GOCount = 0
                UserDefaults.standard.set(GOCount, forKey: "GOCountI")
                InterstitialDisplay()
            }else{
                UserDefaults.standard.set(GOCount, forKey: "GOCountI")
                InterstitialFinish()
            }
        }
        if InterType == 2{
            SCCount += 1
            if SCCount == GOInterN{
                SCCount = 0
                UserDefaults.standard.set(SCCount, forKey: "SCCountI")
                InterstitialDisplay()
            }else{
                UserDefaults.standard.set(SCCount, forKey: "SCCountI")
                InterstitialFinish()
            }
        }
    }
    //ゲームオーバー時に呼び出される関数
    func GameOver(){
        InterType = 1
        playingBGM.stop()
        PlaySE(SEnumber: 7)
        Scene[0].removeFromParent()
        Scene[0].removeAllChildren()
        Scene[0].removeAllActions()
        Scene.removeAll()
        playstage = false
        displayStageFinishView()
    }
    //ステージクリア時に呼び出される関数
    func GameClear(){
        InterType = 2
        playingBGM.stop()
        PlaySE(SEnumber: 8)
        Scene[0].removeFromParent()
        Scene[0].removeAllChildren()
        Scene[0].removeAllActions()
        Scene.removeAll()
        UserDefaults.standard.set(1, forKey: "stage\(stageN)statas")
        playstage = false
        displayStageFinishView()
    }
    
    //ステージBGMの管理
    func stageBGM(){
        if (1 <= stageN && stageN <= 6) || (8 <= stageN && stageN <= 12) || stageN == 15
        { PlayBGM(BGMnumber: 7) }
        
        if stageN == 7 || stageN == 13 || (16 <= stageN && stageN <= 18)
        { PlayBGM(BGMnumber: 8) }
        
        if stageN == 14 || (19 <= stageN && stageN <= 21)
        { PlayBGM(BGMnumber: 9) }
        
        if 22 <= stageN && stageN <= 23 || stageN == 30
        { PlayBGM(BGMnumber: 10) }
        
        if 24 <= stageN && stageN <= 29
        { PlayBGM(BGMnumber: 2) }
        
        if 31 <= stageN && stageN <= 33
        { PlayBGM(BGMnumber: 11) }
        
        if 34 <= stageN && stageN <= 35 || stageN == 37
        { PlayBGM(BGMnumber: 1) }
      
        if stageN == 36 || stageN == 38 || stageN == 39
        { PlayBGM(BGMnumber: 3) }
        
        if stageN == 40 || stageN == 41
        { PlayBGM(BGMnumber: 4) }
        
        if stageN == 42
        { PlayBGM(BGMnumber: 5) }
    }
    
    //ステージプレイ中のシーン移動に使用
    func stageChange(HP: Int){
        PlaySE(SEnumber: 6)
        stageN2 += 1
        UserDefaults.standard.set(stageN2, forKey: "stageScean\(stageN)")
        Scene[0].removeFromParent()
        Scene[0].removeAllChildren()
        Scene[0].removeAllActions()
        Scene.removeAll()
        playstage = false
        CreateStage(HP: HP)
    }
    //ステージの扉に入った時に使用
    func blackout(){
        PlaySE(SEnumber: 6)
        if loadingView == nil{
            loadingView = UIImageView(frame: CGRect(x: 0, y: 0, width: w, height: h))
            loadingView.center = view.center
            loadingView.image = UIImage(named: "doormove")
            loadingView.backgroundColor = .clear
            view.addSubview(loadingView)
        }else{
            view.bringSubviewToFront(loadingView)
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.loadingView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { (finished: Bool) in
            self.view.sendSubviewToBack(self.loadingView)
            self.loadingView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    //効果音、BGMの読み込み
    func SoundRead(){
        ReadSE(SEname: "システム効果音")
        ReadSE(SEname: "ステージ選択音")
        ReadSE(SEname: "start1")
        ReadSE(SEname: "discription1")
        ReadSE(SEname: "discription2")
        ReadSE(SEname: "pageC")
        ReadSE(SEname: "door")
        ReadSE(SEname: "gemeover")
        ReadSE(SEname: "stageclear")
        
        ReadBGM(BGMname: "Owe world")
        ReadBGM(BGMname: "宵闇残花" ,Volume: 0.2)
        ReadBGM(BGMname: "士魂之壱刀" ,Volume: 0.2)
        ReadBGM(BGMname: "木漏れ日" ,Volume:  0.2)
        ReadBGM(BGMname: "Sunset Our Memories" ,Volume:  0.3)
        ReadBGM(BGMname: "神話的亜空間" ,Volume:  0.2)
        ReadBGM(BGMname: "神風" ,Volume:  0.2)
        ReadBGM(BGMname: "Spring Pop" ,Volume:  0.3)
        ReadBGM(BGMname: "フロウレス・ドロウレス" ,Volume:  0.3)
        ReadBGM(BGMname: "BAYASHI" ,Volume:  0.3)
        ReadBGM(BGMname: "未来世界でこんにちは" ,Volume:  0.2)
        ReadBGM(BGMname: "Survive" ,Volume:  0.2)
    }
   
    //ステージの作成
    func CreateStage(HP:Int = 100){
        InterstitialLoad()
        Viewtype = 0
        BannerStatasChange()
        stageBGM()
 //       let stagess = Stage(size: stageView.frame.size)
        let stagess = Stage(size: CGSize(width: w + 4, height: h * 4))
        Scene.append(stagess)
        stopButton.isEnabled = false
        (Scene[0] as! object).viewnode = self
        pHP = HP
        HPgauge.setProgress(Float(HP) / 100.0, animated: false)
        playstage = true
        stageView.presentScene(Scene[0])
    }
    
    //ステージをどこから始めるかを確認するビューの作成
    func displaystagePView(){
        if stagePView == nil{
            stagePView = SKView(frame: CGRect(x: 0, y: 0, width: h1 * 12, height: h1 * 8))
            stagePView.center = view.center
            stagePView.backgroundColor = .clear
            view.addSubview(stagePView)
            let bgimage = SKSpriteNode(imageNamed: "sumi5")
            bgimage.position = CGPoint(x: h1 * 6, y: h1 * 4)
            bgimage.size = CGSize(width: h1 * 12, height: h1 * 8)
            let stagePSS = SKScene(size: stagePView.frame.size)
            stagePSS.addChild(bgimage)
            stagePSS.backgroundColor = .clear
            stagePView.presentScene(stagePSS)
            
            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: h1 * 11, height: h1))
            label.text = "続きから再開しますか？"
            label.font = UIFont(name: "Ronde-B", size: h1 * 1.0)
            label.textColor = .white
            label.center = CGPoint(x: h1 * 6, y: h1 * 3)
            label.textAlignment = NSTextAlignment.center
            stagePView.addSubview(label)
            
            let noB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            noB.center = CGPoint(x: h1 * 9, y: h1 * 5)
            noB.setBackgroundImage(UIImage(named: "waku1"), for: .normal)
            noB.setTitle("いいえ", for: .normal)
            noB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            noB.addTarget(self, action: #selector(firstVC.nostart(_:)), for: .touchUpInside)
            noB.setTitleColor(.white, for: .normal)
            stagePView.addSubview(noB)
            
            let yesB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            yesB.center = CGPoint(x: h1 * 3, y: h1 * 5)
            yesB.setBackgroundImage(UIImage(named: "waku1"), for: .normal)
            yesB.setTitle("はい", for: .normal)
            yesB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            yesB.addTarget(self, action: #selector(firstVC.yesstart(_:)), for: .touchUpInside)
            yesB.setTitleColor(.white, for: .normal)
            stagePView.addSubview(yesB)
        }else{
            self.view.bringSubviewToFront(stagePView)
        }
    }
    
    //ステージを続きから始める場合に使用
    @objc func yesstart(_ sender: UIButton){
        self.view.sendSubviewToBack(stagePView)
        PlaySE(SEnumber: 1)
        displayStageView()
    }
    
    //ステージを最初から始める場合に使用
    @objc func nostart(_ sender: UIButton){
        self.view.sendSubviewToBack(stagePView)
        PlaySE(SEnumber: 1)
        stageN2 = 1
        UserDefaults.standard.set(stageN2, forKey: "stageScean\(stageN)")
        displayStageView()
    }
   
    //ステージナンバーの取得に使用
    func getSTageN() -> Int{
        return stageN
    }
    //ステージシーンナンバーの取得に使用
    func getSTageSceanN() -> Int{
        return stageN2
    }
    //プレイヤーHPの取得に使用
    func getplayerHP() -> Int{
        return pHP
    }
    
    //説明用のビュー表示に使用
    func displaydiscriptionView(){
        if discriptionView == nil {
            discriptionView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            discriptionView.backgroundColor = .clear
            let disSS = SKScene(size: discriptionView.frame.size)
            disSS.backgroundColor = .clear
            discriptionView.presentScene(disSS)
            discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1)
            view.addSubview(discriptionView)
            
            let disButton = UIButton(frame: CGRect(x: 0, y: 0, width: w * 0.8, height: h * 0.8))
            disButton.center = discriptionView.center
            disButton.addTarget(self, action: #selector(firstVC.dislabel(_:)), for: .touchUpInside)
            disButton.setBackgroundImage(UIImage(named: "waku2"), for: .normal)
            discriptionView.addSubview(disButton)
            
            discriptionLabel1.frame = CGRect(x: 0, y: 0, width: w * 0.6, height: h * 0.15)
            discriptionLabel1.center = CGPoint(x: view.center.x, y: view.center.y - h1 * 2.5)
            discriptionLabel1.font = UIFont(name: "Ronde-B", size: w1 * 0.6) //文字サイズ
            discriptionLabel1.textColor = .white
            discriptionLabel1.textAlignment = NSTextAlignment.center
            discriptionView.addSubview(discriptionLabel1)
            
            discriptionLabel2.frame = CGRect(x: 0, y: 0, width: w * 0.58, height: h * 0.6)
            discriptionLabel2.center = CGPoint(x: view.center.x, y: view.center.y + h1 * 0.1)
            discriptionLabel2.font = UIFont(name: "Ronde-B", size: w1 * 0.45) //文字サイズ
            discriptionLabel2.textColor = .white
            discriptionLabel2.textAlignment = NSTextAlignment.left
            discriptionLabel2.lineBreakMode = NSLineBreakMode.byWordWrapping
            discriptionLabel2.numberOfLines = 0
            discriptionView.addSubview(discriptionLabel2)
        }else{
            discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1)
            view.bringSubviewToFront(discriptionView)
        }
        OpendiscriptionView()
    }
    
    //ゲームオーバービュー表示に使用
    func displayGameOverView(){
        Viewtype = 3
        BannerStatasChange()
        PlayBGM(BGMnumber: 0)
        if gameoverView == nil{
            let xx = w / 18
            let yy = h / 10
            let rexp:CGFloat = 3.5,reyp:CGFloat = 7,resx:CGFloat = 3,resy:CGFloat = 2
            let ssxp: CGFloat = 0.5,ssyp: CGFloat = 7,sssx: CGFloat = 2,sssy: CGFloat = 2

            gameoverView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(gameoverView)
            let gameoverss = SKScene(size:  gameoverView.frame.size)
            //背景画像の表示
            let background = SKSpriteNode(imageNamed: "bgO2")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            gameoverss.addChild(background)
            gameoverView.presentScene(gameoverss)
            
            let retrybutton = UIButton(frame: CGRect(x: xx * rexp,y: yy * reyp,width: xx * resx,height:yy * resy))
            retrybutton.setImage(UIImage.init(named: "リピートボタン"), for: .normal)
            retrybutton.addTarget(self, action: #selector(firstVC.retry01(_:)), for: .touchUpInside)
            gameoverView.addSubview(retrybutton)
            let relabel:UILabel = UILabel()
            relabel.text = "リトライ"
            relabel.font = UIFont(name: "Ronde-B", size: yy / 2)
            relabel.frame = CGRect(x: xx * rexp, y: yy * (reyp - 1), width: xx * resx, height: yy)
            relabel.textAlignment = NSTextAlignment.center
            gameoverView.addSubview(relabel)
            
            let stageselect = UIButton(frame: CGRect(x: ssxp * xx,y: ssyp * yy,width: xx * sssx,height:yy * sssy))
            stageselect.setImage(UIImage.init(named: "メニューアイコン"), for: .normal)
            stageselect.addTarget(self, action: #selector(firstVC.displayeSS(_:)), for: .touchUpInside)
            gameoverView.addSubview(stageselect)
            let sslabel:UILabel = UILabel()
            sslabel.text = "戻る"
            sslabel.font = UIFont(name: "Ronde-B", size: yy / 2)
            sslabel.frame = CGRect(x: xx * ssxp, y: yy * (ssyp - 1), width: xx * sssx, height: yy)
            sslabel.textAlignment = NSTextAlignment.center
            gameoverView.addSubview(sslabel)
        }else{
            self.view.bringSubviewToFront(gameoverView)
        }
        addNendbanner(xp: 5.5, yp: 0, type: 3, Number: 1, Ycenter: true)
    }
    
    //ステージクリアビュー表示に使用
    func displayStageClearView(){
        Viewtype = 4
        BannerStatasChange()
        PlayBGM(BGMnumber: 0)
        let playstage = stageN
        let stagestatas = UserDefaults.standard.integer(forKey: "stage\(playstage)statas")
        let xx = w / 18
        let yy = h / 10
        
        if gameclearView == nil{
            let rexp:   CGFloat = 3.5 ,reyp:   CGFloat = 7 ,resx:   CGFloat = 3 ,resy:   CGFloat = 2
            let ssxp:   CGFloat = 0.5 ,ssyp:   CGFloat = 7 ,sssx:   CGFloat = 2 ,sssy:   CGFloat = 2
            let nextxp: CGFloat = 7.5 ,nextyp: CGFloat = 7 ,nextsx: CGFloat = 2 ,nextsy: CGFloat = 2
            
            gameclearView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(gameclearView)
            let gameclearss = SKScene(size:  gameclearView.frame.size)
            //背景画像の表示
            let background = SKSpriteNode(imageNamed: "bgC2")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            gameclearss.addChild(background)
            gameclearView.presentScene(gameclearss)
            
            let retrybutton = UIButton(frame: CGRect(x: xx * rexp,y: yy * reyp,width: xx * resx,height:yy * resy))
            retrybutton.setImage(UIImage.init(named: "リピートボタン"), for: .normal)
            retrybutton.addTarget(self, action: #selector(firstVC.retry02(_:)), for: .touchUpInside)
            gameclearView.addSubview(retrybutton)
            let relabel:UILabel = UILabel()
            relabel.text = "リトライ"
            relabel.font = UIFont(name: "Ronde-B", size: yy / 2)
            relabel.frame = CGRect(x: xx * rexp, y: yy * (reyp - 1), width: xx * resx, height: yy)
            relabel.textAlignment = NSTextAlignment.center
            gameclearView.addSubview(relabel)
            
            let stageselect = UIButton(frame: CGRect(x: ssxp * xx,y: ssyp * yy,width: xx * sssx,height:yy * sssy))
            stageselect.setImage(UIImage.init(named: "メニューアイコン"), for: .normal)
            stageselect.addTarget(self, action: #selector(firstVC.displayeSS(_:)), for: .touchUpInside)
            gameclearView.addSubview(stageselect)
            let sslabel:UILabel = UILabel()
            sslabel.text = "戻る"
            sslabel.font = UIFont(name: "Ronde-B", size: yy / 2)
            sslabel.frame = CGRect(x: xx * ssxp, y: yy * (ssyp - 1), width: xx * sssx, height: yy)
            sslabel.textAlignment = NSTextAlignment.center
            gameclearView.addSubview(sslabel)
            
            NextButton = UIButton(frame: CGRect(x: xx * nextxp,y:yy * nextyp,width: xx * nextsx,height:yy * nextsy))
            NextButton.setImage(UIImage.init(named: "共有矢印"), for: .normal)
            NextButton.addTarget(self, action: #selector(firstVC.NextStage(_:)), for: .touchUpInside)
            gameclearView.addSubview(NextButton)
            NextLabel.text = "次へ"
            NextLabel.font = UIFont(name: "Ronde-B", size: yy / 2)
            NextLabel.frame = CGRect(x: xx * nextxp, y: yy * (nextyp - 1), width: xx * nextsx, height: yy)
            NextLabel.textAlignment = NSTextAlignment.center
            gameclearView.addSubview(NextLabel)
        }else{
            self.view.bringSubviewToFront(gameclearView)
        }
        addNendbanner(xp: 5.5, yp: 0, type: 3, Number: 2, Ycenter: true)
        if stagestatas == 1 && playstage < stageCount{ // 次のステージボタンが使用できる場合
            NextButton.isEnabled = true
            NextButton.alpha = 1.0
            NextLabel.alpha = 1.0
        }else{
            NextButton.isEnabled = false
            NextButton.alpha = 0.1
            NextLabel.alpha = 0.1
        }
    }
    
    //ステージビュー表示に使用
    func displayStageView(){
        if stageView == nil{
            /*
            let ws = w * CGFloat(stagesize[0])
            let hs = h * CGFloat(stagesize[1])
            let wd = -CGFloat(stagesize[0] - 1) * w / 2
            let hd = -CGFloat(stagesize[1] - 1) * h / 2
            stageView = SKView(frame: CGRect(x: wd , y: hd , width: ws, height: hs))
 */
            stageView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(stageView)
            stageFrontView = TransparentView(frame: CGRect(x: 0, y: 0, width: w, height: h))
            stageFrontView.clearView()
            view.addSubview(stageFrontView)
            HPgauge = UIProgressView(frame: CGRect(x: 0, y: 0, width: w1 * 8 , height: h1 * 3))
            HPgauge.center = CGPoint(x: w1 * 5, y:h1 )
            HPgauge.progressImage = UIImage(named: "gage2")
            HPgauge.trackImage = UIImage(named: "gage1")
            HPgauge.setProgress(1.0, animated: false)
            HPgauge.transform = CGAffineTransform.init(scaleX: 1.0, y: 20.0)
            stageFrontView.addSubview(HPgauge)
            
            stopButton = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 2, height: h1))
            stageFrontView.addNotTransparentArea(Rect: stopButton.frame)
            stopButton.setImage(UIImage(named: "一時停止"), for: .normal)
            stopButton.addTarget(self, action: #selector(firstVC.stop(_:)), for: .touchUpInside)
            stageFrontView.addSubview(stopButton)
            
           // stageFrontView.backgroundColor = .black
        }else{
            self.view.bringSubviewToFront(stageView)
            self.view.bringSubviewToFront(stageFrontView)
        }
        CreateStage()
    }
    //ダメージ時のHPバー減少に使用
    func Damage(pHP: Int){
        var HP: Float!
        if pHP <= 0{ HP = 0.0 }else{HP = Float(pHP) / 100.0}
        HPgauge.setProgress(HP, animated: true)
    }
    //ステージ開始時にクリア方法表示に使用
    func HTClear(CrearP:Int){
        Scene[0].isPaused = true
        if stageStartView == nil{
            let ssx: CGFloat = 9,ssy: CGFloat = 3
            let sCR = CGRect(x: 0, y: 0, width:w1 * ssx, height: h1 * ssy)
            stageStartView = UIImageView(frame: sCR)
            stageStartView.center = CGPoint(x: w / 2, y: h / 2)
            stageStartView.image = UIImage(named: "sumi1")
            stageStartView.backgroundColor = .clear
            stageStartView.transform = CGAffineTransform(scaleX: 0, y: 1)
            view.addSubview(stageStartView)
            if      CrearP == 1 { startlabel.text = "特定エリアに到達せよ" }
            else if CrearP == 2 { startlabel.text = "敵を全滅させろ"}
            else if CrearP == 3 { startlabel.text = "特定の敵を倒せ"}
            startlabel.frame = sCR
            startlabel.font = UIFont(name: "Ronde-B", size: h / 10)
            startlabel.textColor = .white
            startlabel.textAlignment = NSTextAlignment.center
            stageStartView.addSubview(startlabel)
        }else{
            self.view.bringSubviewToFront(stageStartView)
            stageStartView.alpha = 1
            if      CrearP == 1 { startlabel.text = "特定エリアに到達せよ" }
            else if CrearP == 2 { startlabel.text = "敵を全滅させろ"}
            else if CrearP == 3 { startlabel.text = "特定の敵を倒せ"}
        }
        PlaySE(SEnumber: 2)
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
            self.stageStartView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (finished: Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear, animations: {
                    self.stageStartView.alpha = 0
                }) { (finished: Bool) in
                    self.stageStartView.transform = CGAffineTransform(scaleX: 0, y: 1)
                    if self.discriptionN == 0{
                        self.Scene[0].isPaused = false
                        self.stopButton.isEnabled = true
                    }else{
                        self.displaydiscriptionView()
                    }
                }
            }
        }
    }
    //ステージストップボタンを有効にする
    func stopBvalid(){
        stopButton.isEnabled = true
    }
    
    //ステージセレクトボタンの作成
    func CreateSSButton(){
        let xx = w / 18 ;let yy = h / 10
        //スタージのクリア状況に読み込み
        let downN = (21 * (SSPage - 1)) + 1
        var upN = 21 * SSPage
        if upN > stageCount { upN = stageCount }
        var stagestatas = [Int](repeating: 0, count: stageCount + 1)
        for n in downN - 1 ... upN{
            if n != 0 { stagestatas[n] = UserDefaults.standard.integer(forKey: "stage\(n)statas") }
        }
        stagestatas[0] = 1
        
        let ChangeStageN = stageCount / 21 + 1
        var Cstagestatas = [Int](repeating: 0, count: ChangeStageN + 1)
        for n in 1 ... ChangeStageN{
            Cstagestatas[n] =  UserDefaults.standard.integer(forKey: "stage\(n * 21)statas")
        }
        //スタージのクリア状況に読み込み ここまで
        //一つめの位置
        let fx:CGFloat = 0.4 ,fy:CGFloat = 2
        //間隔
        let dx:CGFloat = 2.4 ,dy:CGFloat = 2.5
        //大きさ
        let sx:CGFloat = 2   ,sy:CGFloat = 2
        //横への表示数
        let xcount = 7
        var pn = 1
        for n in downN...upN{
            let xn    = (pn + xcount - 1) % xcount + 1     ,yn     = (pn + xcount - 1) / xcount
            let fxp   = xx * fx                  ,fyp    = yy * fy
            let dwx   = (xn.cgf() - 1) * xx * dx ,dwy    = (yn.cgf() - 1) * yy * dy
            let width = xx * sx                  ,height = yy * sy
            let stageBotton = UIButton(frame: CGRect(x:fxp + dwx, y:fyp + dwy, width: width,height:height)) //ボタンの位置およびサイズ
            stageBotton.setTitle("\(n)",for: .normal)                             //ボタンの文字
            stageBotton.titleLabel?.font = UIFont(name: "Ronde-B", size: w / 15)  //ボタンの文字のフォントおよび大きさ
            stageBotton.setTitleColor(UIColor.black, for: .normal)                //文字の色
            //  stageBotton.backgroundColor = UIColor(red: 218.0/255.0, green:242.4/255.0, blue: 241.0/255.0, alpha: 1)
            stageBotton.setBackgroundImage(UIImage(named: "sumi3"), for: .normal)
            
            //クリア状況によって外枠の色を変更
            if stagestatas[n] == 0{ //ステージをクリアしてない場合
                //stageBotton.layer.borderColor = UIColor.black.cgColor //黒
                stageBotton.backgroundColor = .white
            }else{ //クリアした場合
                // stageBotton.layer.borderColor = UIColor(red: 255.0/255.0, green:215.0/255.0, blue: 0.0/255.0, alpha: 1).cgColor //金
                stageBotton.backgroundColor = UIColor(red: 255.0/255.0, green:215.0/255.0, blue: 0.0/255.0, alpha: 1)
            }
            stageBotton.layer.borderWidth = h / 100 //外枠の幅の設定
            stageBotton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
            stageBotton.layer.cornerRadius = h / 40 //角アールの作成
            //ボタンを押した時のアクションを設定
            stageBotton.addTarget(self, action: #selector(firstVC.stageselect(_:)), for: .touchUpInside)
            stageBotton.accessibilityValue = "\(n)"
            
            SButton.append(stageBotton)
            stageselectView.addSubview(stageBotton)
            pn += 1
        }
        var BN = 0
        for n in downN ... upN{
            if n != 1{
                if stagestatas[n - 1] == 0{ SButton[BN].isEnabled = false ;SButton[BN].alpha = 0.1 }  //前のステージをクリアしている場合の処理
                else                      { SButton[BN].isEnabled = true  ;SButton[BN].alpha = 1.0 }  //前のステージをクリアしてない場合の処理
            }
            if stagestatas[n] == 1 { SButton[BN].backgroundColor = UIColor(red: 255.0/255.0, green:215.0/255.0, blue: 0.0/255.0, alpha: 1)}
            BN +=   1
        }
        
        if SSPage == 1{
            SSChageButton[0].alpha = 0.1
            SSChageButton[0].isEnabled = false
        }else{
            SSChageButton[0].alpha = 1.0
            SSChageButton[0].isEnabled = true
        }
        if Cstagestatas[SSPage] != 1 || stageCount <= SSPage * 21{
            SSChageButton[1].alpha = 0.1
            SSChageButton[1].isEnabled = false
        }else{
            SSChageButton[1].alpha = 1.0
            SSChageButton[1].isEnabled = true
        }
    }
    //ステージセレクト画面切り替え（ダウン時）に使用
    @objc func SSChangeBD(_ sender: UIButton) {
        PlaySE(SEnumber: 5)
        SSPage -= 1
        for n in 0..<SButton.count{ SButton[n].removeFromSuperview() }  //ボタンを消去
        SButton.removeAll()                                             //ボタンの配列の初期化
        CreateSSButton()                                                //ボタンを再配置
    }
    //ステージセレクト画面切り替え（アップ時）に使用
    @objc func SSChangeBU(_ sender: UIButton) {
        PlaySE(SEnumber: 5)
        SSPage += 1
        for n in 0..<SButton.count{ SButton[n].removeFromSuperview() }  //ボタンを消去
        SButton.removeAll()                                             //ボタンの配列の初期化
        CreateSSButton()                                                //ボタンを再配置
    }
    
    //ステージセレクトビューに表示に使用
    func displaySetageSelectView(){
        Viewtype = 2
        BannerStatasChange()
        PlayBGM(BGMnumber: 0)
        let xx = w / 18 ;let yy = h / 10
        let downN = 21 * (SSPage - 1) + 1
        var upN = 21 * SSPage
        if upN > stageCount { upN = stageCount }
        var stagestatas = [Int](repeating: 0, count: stageCount + 1)
        for n in downN - 1 ... upN{
            if n != 0 { stagestatas[n] = UserDefaults.standard.integer(forKey: "stage\(n)statas") }
        }
        stagestatas[0] = 1
        
        let ChangeStageN = stageCount / 21 + 1
        var Cstagestatas = [Int](repeating: 0, count: ChangeStageN + 1)
        for n in 1 ... ChangeStageN{
            Cstagestatas[n] =  UserDefaults.standard.integer(forKey: "stage\(n * 21)statas")
        }
        if stageselectView == nil{ //スタージセレクトビューがない場合　SS作成　および　バックボタンの作成
            //ステージセレクトビューの作成
            stageselectView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            stageselectView.backgroundColor = .clear
            view.addSubview(stageselectView)
            let stageselectss = SKScene(size: stageselectView.frame.size)
            let background = SKSpriteNode(imageNamed: "bg0")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            stageselectss.addChild(background)
            stageselectView.presentScene(stageselectss)
            
            //バックボタンの作成
            let backButton = UIButton(frame: CGRect(x: xx * 0.2 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
            backButton.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
            backButton.addTarget(self, action: #selector(firstVC.displayFV(_:)), for: .touchUpInside)
            stageselectView.addSubview(backButton)
            
            //ステージセレクトのベージ変更ボタンの作成
            let SSChangeDownB = UIButton(frame: CGRect(x: xx * 13 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
            SSChangeDownB.setImage(UIImage.init(named: "leftV"), for: .normal)
            SSChangeDownB.addTarget(self, action: #selector(firstVC.SSChangeBD(_:)), for: .touchUpInside)
            stageselectView.addSubview(SSChangeDownB)
            SSChageButton.append(SSChangeDownB)
            let SSChangeUPB = UIButton(frame: CGRect(x: xx * 16 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
            SSChangeUPB.setImage(UIImage.init(named: "rightV"), for: .normal)
            SSChangeUPB.addTarget(self, action: #selector(firstVC.SSChangeBU(_:)), for: .touchUpInside)
            stageselectView.addSubview(SSChangeUPB)
            SSChageButton.append(SSChangeUPB)
            CreateSSButton()
        }else{//スタージセレクトビューがすでに作成済みの場合　スタージセレクトビューを最前面に表示
            self.view.bringSubviewToFront(stageselectView)
        }
        addNendbanner(xp: 0, yp: 0, Xcenter: true)
    
        var BN = 0
        for n in downN ... upN{
            if n != 1{
                if stagestatas[n - 1] == 0{ SButton[BN].isEnabled = false ;SButton[BN].alpha = 0.1 }  //前のステージをクリアしている場合の処理
                else                      { SButton[BN].isEnabled = true  ;SButton[BN].alpha = 1.0 }  //前のステージをクリアしてない場合の処理
            }
            if stagestatas[n] == 1 { SButton[BN].backgroundColor = UIColor(red: 255.0/255.0, green:215.0/255.0, blue: 0.0/255.0, alpha: 1)}
            BN +=   1
        }
        if SSPage == 1{
            SSChageButton[0].alpha = 0.1
            SSChageButton[0].isEnabled = false
        }else{
            SSChageButton[0].alpha = 1.0
            SSChageButton[0].isEnabled = true
        }
        if Cstagestatas[SSPage] != 1{
            SSChageButton[1].alpha = 0.1
            SSChageButton[1].isEnabled = false
        }else{
            SSChageButton[1].alpha = 1.0
            SSChageButton[1].isEnabled = true
        }
    }
   
    //タイトル画面表示に使用
    func displayFirstView(){
        Viewtype = 1
        BannerStatasChange()
        PlayBGM(BGMnumber: 0)
        if firstView == nil{
            let xx = w / 18
            let yy = h / 10
            //タイトル名の位置
          //  let titlepy: CGFloat = 15
            //タイトル名のサイズ
          //  let titlesx: CGFloat = 9 ;let titlesy: CGFloat = 3
            //セレクトボタンのサイズ
            let sssx: CGFloat = 8;let sssy: CGFloat = 2

            firstView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(firstView)
            let firstss = SKScene(size: firstView .frame.size)
            //背景画像の表示
            let background = SKSpriteNode(imageNamed: "bgF")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            firstss.addChild(background)
            firstView.presentScene(firstss)
        
            let stageselect = UIButton(frame: CGRect(x: 0,y: 0,width: xx * sssx,height:yy * sssy)) //ボタンのサイズと位置を設定
            stageselect.center = CGPoint(x: xx * 9, y: yy * 8)
            stageselect.setBackgroundImage(UIImage.init(named: "sumi2"), for: .normal)
            stageselect.setTitle("start", for: .normal)
            stageselect.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10 * 1.5)
            stageselect.setTitleColor(.white, for: .normal)
            stageselect.addTarget(self, action: #selector(firstVC.displayeSS(_:)), for: .touchUpInside) //ボタンのアクションを設定
            firstView.addSubview(stageselect) //ボタンを表示
        }else{
            self.view.bringSubviewToFront(firstView)
        }
    }
    //ポーズ画面表示に使用
    func displayStopView(){
        Viewtype = 5
        BannerStatasChange()
        if stopView == nil{
            stopView = SKView(frame: CGRect(x: 0, y: 0, width: h1 * 12, height: h1 * 8))
            stopView.center = view.center
            stopView.backgroundColor = .clear
            view.addSubview(stopView)
            let stopss = SKScene(size: stopView.frame.size)
            let bgimage = SKSpriteNode(imageNamed: "sumi5")
            bgimage.position = CGPoint(x: h1 * 6, y: h1 * 4)
            bgimage.size = CGSize(width: h1 * 12, height: h1 * 8)
            stopss.addChild(bgimage)
            stopss.backgroundColor = .clear
            stopView.presentScene(stopss)
            
            let startB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            startB.center = CGPoint(x: h1 * 6, y: h1 * 3)
            startB.setBackgroundImage(UIImage(named: "waku1"), for: .normal)
            startB.setTitle("再開", for: .normal)
            startB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            startB.addTarget(self, action: #selector(firstVC.start(_:)), for: .touchUpInside)
            startB.setTitleColor(.white, for: .normal)
            stopView.addSubview(startB)
            
            let retryB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            retryB.center = CGPoint(x: h1 * 9, y: h1 * 5)
            retryB.setBackgroundImage(UIImage(named: "waku1"), for: .normal)
            retryB.setTitle("リトライ", for: .normal)
            retryB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            retryB.addTarget(self, action: #selector(firstVC.retry03(_:)), for: .touchUpInside)
            retryB.setTitleColor(.white, for: .normal)
            stopView.addSubview(retryB)
            
            let retrunB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            retrunB.center = CGPoint(x: h1 * 3, y: h1 * 5)
            retrunB.setBackgroundImage(UIImage(named: "waku1"), for: .normal)
            retrunB.setTitle("戻る", for: .normal)
            retrunB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            retrunB.addTarget(self, action: #selector(firstVC.return1(_:)), for: .touchUpInside)
            retrunB.setTitleColor(.white, for: .normal)
            stopView.addSubview(retrunB)
        }else{
            self.view.bringSubviewToFront(stopView)
        }
        addNendbanner(xp: 1.1, yp: 6, type: 1)
    }
    //ステージセレクト表示のボタン
    @objc func displayeSS(_ sender: UIButton) {
        PlaySE(SEnumber: 0)
        displaySetageSelectView()
    }
    //タイトル画面表示のボタン
    @objc func displayFV(_ sender: UIButton) {
        PlaySE(SEnumber: 0)
        displayFirstView()
    }
    //ステージセレクトのボタン（スタージを表示する）
    @objc func stageselect(_ sender: UIButton) {
        PlaySE(SEnumber: 0)
        stageN = Int(sender.accessibilityValue!)!
        stageN2 = UserDefaults.standard.integer(forKey: "stageScean\(stageN)")
        if stageN2 == 1{
            displayStageView()
        }else if stageN2 >= 2 {
            displaystagePView()
        }
    }
    //次のステージを表示するボタン
    @objc func NextStage(_ sender: UIButton){
        PlaySE(SEnumber: 1)
        stageN += 1
        displayStageView()
    }
    //ステージの一時停止
    @objc func stop(_ sender: UIButton){
        Scene[0].isPaused = true
        displayStopView()
    }
    //一時停止ビューのリトライボタン
    @objc func retry03(_ sender: UIButton){
        Scene[0].removeFromParent()
        Scene[0].removeAllChildren()
        Scene[0].removeAllActions()
        Scene.removeAll()
        self.view.sendSubviewToBack(stopView)
        playstage = false
        CreateStage()
    }
    //一時停止ビューのステージセレクト画面に戻るボタン
    @objc func return1(_ sender: UIButton){
        Scene[0].removeFromParent()
        Scene[0].removeAllChildren()
        Scene[0].removeAllActions()
        Scene.removeAll()
        self.view.sendSubviewToBack(stopView)
        playstage = false
        displaySetageSelectView()
    }
    //次の説明内容を表示する
    @objc func dislabel(_ sender: UIButton){
        NextdiscriptionView()
    }
    //一時停止ビューの一時停止を解除するボタン
    @objc func start(_ sender: UIButton){
        PlaySE(SEnumber: 0)
        Viewtype = 0
        BannerStatasChange()
        self.view.sendSubviewToBack(stopView)
        Scene[0].isPaused = false
    }
    //ゲームオーバービューでもう一度そのステージをプレイするボタン
    @objc func retry01(_ sender: UIButton) {
        PlaySE(SEnumber: 1)
        self.view.sendSubviewToBack(gameoverView)
        CreateStage()
    }
    //ステージクリアビューでもう一度そのステージをプレイするボタン
    @objc func retry02(_ sender: UIButton) {
        PlaySE(SEnumber: 1)
        self.view.sendSubviewToBack(gameclearView)
        CreateStage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //どの説明ビューを表示するかを決める（displayがtrueならそのまま説明ビューを表示）
    func discriptionChangeN(disN: Int, display:Bool = false){
        discriptionN = disN
        if display{ displaydiscriptionView() }
    }
    
    //説明ビューのアニメーション設定
    func OpendiscriptionView(){ //開くアニメ
        disLabeltext()
        PlaySE(SEnumber: 3)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.discriptionView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func NextdiscriptionView(){//次の文章を表示するアニメ
        PlaySE(SEnumber: 4)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
            self.discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
        }) { (finished: Bool) in
            self.discriptionPageN += 1
            self.disLabeltext()
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                self.discriptionView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        }
    }
    
    func finishdiscriptionView(){//閉じるアニメ
        PlaySE(SEnumber: 4)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
        }) { (finished: Bool) in
            self.discriptionLabel1.text = ""
            self.discriptionLabel2.text = ""
            self.discriptionPageN = 1
            self.discriptionN = 0
            self.view.sendSubviewToBack(self.discriptionView)
            if self.playstage { self.Scene[0].isPaused = false; self.stopButton.isEnabled = true }
        }
    }
    
    //説明ビューの文字を管理
    func disLabeltext(){
        if discriptionPageN <= discriptionPageCount[discriptionN]{
            if discriptionN == 1{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "歩く、走る"
                    discriptionLabel2.text = "左右にスワイプすることで歩く(走る)ことができる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "スワイプ量により、歩く、走るなどの動作が変化する。"
                }
            }else if discriptionN == 2{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "ジャンプ"
                    discriptionLabel2.text = "上方向にフリックすることでジャンプすることができる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "ジャンプ中に左右にスワイプすることで、スワイプしている方向に移動(空中移動)ができる。"
                }else if discriptionPageN == 3{
                    discriptionLabel2.text = "着地に失敗した場合、転倒してしまう。転倒中はタップで起き上がることができる。"
                }else if discriptionPageN == 4{
                    discriptionLabel2.text = "また、ジャンプ力はスワイプ量により変化する。"
                }
            }else if discriptionN == 3{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "落下アクション"
                    discriptionLabel2.text = "ジャンプ中に下フリックすると、落下アクションが使用できる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "落下アクションを使用した場合、着地した瞬間に立ち姿勢を取ることができる。"
                }
            }else if discriptionN == 4{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "ステージクリア"
                    discriptionLabel2.text = "クリア条件が特定エリアに到達せよの場合、青ブロックに触れるとステージクリアになる。"
                }
            }else if discriptionN == 13{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "ダメージブロック"
                    discriptionLabel2.text = "赤色のブロックに接触すると、ダメージを受ける。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "ダメージを受けると、下のHPバーが減少し、なくなるとゲームオーバーになる。"
                }else if discriptionPageN == 3{
                    discriptionLabel2.text = "また、受けるダメージはブロックにより異なる。"
                }
            }else if discriptionN == 6{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "回避アクション"
                    discriptionLabel2.text = "地上にいる状態で、左右にフリックすることで、回避アクションを行うことができる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "回避アクション中はダメージを受けない。"
                }else if discriptionPageN == 3{
                    discriptionLabel2.text = "薄い赤ブロックの場合、ダメージを受けず通過することができる。"
                }
            }else if discriptionN == 7{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "壁キック"
                    discriptionLabel2.text = "ジャンプ中にブロックと接触している場合、フリックすることで壁キックが使用できる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "また、壁キック後にブロックと接触したいる場合、フリックでさらに壁キックを使用できる。"
                }else if discriptionPageN == 3{
                    discriptionLabel2.text = "スワイプによる空中移動と組み合わせることで、高い場所に上ることができる。"
                }
            }else if discriptionN == 8{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "地上弱攻撃"
                    discriptionLabel2.text = "立ち姿勢の時にタップすることで、弱攻撃を行うことができる。"
                }
            }else if discriptionN == 9{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "地上強攻撃"
                    discriptionLabel2.text = "地上弱攻撃中にタップすることで、地上強攻撃を行うことができる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "地上強攻撃中はダメージを受けない。そのため、攻撃回避にも利用できる。"
                }else if discriptionPageN == 3{
                    discriptionLabel2.text = "さらに、地上強攻撃中にタップすることで回避アクションが使用できる。"
                }else if discriptionPageN == 4{
                    discriptionLabel2.text = "画面の右をタップで右に、画面の左をタップで左に回避を行う。"
                }
            }else if discriptionN == 10{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "空中弱攻撃"
                    discriptionLabel2.text = "ジャンプ中にタップすることで空中弱攻撃を行うことができる。"
                }
            }else if discriptionN == 11{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "空中強攻撃"
                    discriptionLabel2.text = "壁キック後、または空中で敵を攻撃後に、フリックすることで空中強攻撃を行うことができる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "空中強攻撃中はダメージを受けない。そのため、敵の攻撃回避にも利用できる。"
                }
            }else if discriptionN == 12{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "大ジャンプ"
                    discriptionLabel2.text = "斜め上方向にフリックすることで、その方向にジャンプすることができる。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "さらに、その状態で進行方向にスワイプすることで、長距離を跳躍することができる。"
                }
            }else if discriptionN == 14{
                if discriptionPageN == 1{
                    discriptionLabel1.text = ""
                    discriptionLabel2.text = "空中強攻撃の無敵時間を利用しようして進もう。"
                }
            }else if discriptionN == 15{
                if discriptionPageN == 1{
                    discriptionLabel1.text = ""
                    discriptionLabel2.text = "空中強攻撃を連続使用して進もう。"
                }
            }else if discriptionN == 16{
                if discriptionPageN == 1{
                    discriptionLabel1.text = "灰色ブロック"
                    discriptionLabel2.text = "灰色ブロックには着地することができない。"
                }else if discriptionPageN == 2{
                    discriptionLabel2.text = "また、灰色ブロックに触れると強制的に空中状態になる。"
                }
            }
        }else{
            finishdiscriptionView()
        }
   
    }
    //BGMの読み込み
    func ReadBGM(BGMname: String,Volume: Float = 1.0){
        do{
            let BGMPath = Bundle.main.path(forResource: "BGM/" + BGMname, ofType: "mp3")
            let BGMurl = URL(fileURLWithPath: BGMPath!)
            let RBGM = try AVAudioPlayer(contentsOf: BGMurl)
            BGM.append(RBGM)
            RBGM.numberOfLoops = -1
            RBGM.volume = Volume
        }catch{
            print("error")
        }
    }
    //効果音の読み込み
    func ReadSE(SEname: String,Volume: Float = 1.0){
        do{
            let SEPath = Bundle.main.path(forResource: "BGM/" + SEname, ofType: "mp3")
            let SEurl = URL(fileURLWithPath: SEPath!)
            let RSE = try AVAudioPlayer(contentsOf: SEurl)
            SE.append(RSE)
            RSE.volume = Volume
        }catch{
            print("error")
        }
    }
    //効果音を再生
    func PlaySE(SEnumber n: Int){
        if SE[n].isPlaying{ SE[n].pause() }
        SE[n].currentTime = 0
        SE[n].play()
    }
    //BGMを再生
    func PlayBGM(BGMnumber n: Int){
        if playingBGM != nil{
            playingBGM.stop()
            playingBGM.currentTime = 0
        }
        BGM[n].play()
        playingBGM = BGM[n]
    }
    //ここからNend広告表示に関する関数
    //バナー広告を追加する
    func addNendbanner(xp:CGFloat, yp:CGFloat,type:Int = 1,Number: Int = 1 , Xcenter: Bool = false ,Ycenter: Bool = false){
        let h1 = h / 10
        let w1 = w / 10
        // type:1 バナー小 2:バナー中 3:バナー大
        var nadView: NADView!
        if BannerDisplay[type - 1][Number] == 0{
            BannerDisplay[type - 1][Number] = Viewtype
            BannerNumber[type - 1][Number] = BannerCount
            if type == 1{
                nadView = NADView(frame: CGRect(x: w1 * xp, y: h1 * yp, width: 320, height: 50 ))
                if Number == 1 { nadView.setNendID("594e21727a27c613ae62b6210efbe97172a44cfb", spotID: "946843") }
                if Number == 2 { nadView.setNendID("594e21727a27c613ae62b6210efbe97172a44cfb", spotID: "946843") }
                if Number == 3 { nadView.setNendID("594e21727a27c613ae62b6210efbe97172a44cfb", spotID: "946843") }
            }
            if type == 2{
                nadView = NADView(frame: CGRect(x: w1 * xp, y: h1 * yp, width: 320, height: 100 ))
                if Number == 1 { nadView.setNendID("eb5ca11fa8e46315c2df1b8e283149049e8d235e", spotID: "70996") }
            }
            if type == 3{
                nadView = NADView(frame: CGRect(x: w1 * xp, y: h1 * yp, width: 300, height: 250 ))
                if Number == 1 { nadView.setNendID("f6237be4a884a67297affa7351ae5e7458e456c9", spotID: "946844") }
                if Number == 2 { nadView.setNendID("f6237be4a884a67297affa7351ae5e7458e456c9", spotID: "946844") }
            }
            if Xcenter{ nadView.center.x = self.view.center.x  }
            if Ycenter{ nadView.center.y = self.view.center.y  }
            nadView.delegate = self
            nadView.load()
            BannerViwe.append(nadView)
            if Viewtype == 1{ firstView.addSubview(nadView) }
            if Viewtype == 2{ stageselectView.addSubview(nadView) }
            if Viewtype == 3{ gameoverView.addSubview(nadView) }
            if Viewtype == 4{ gameclearView.addSubview(nadView) }
            if Viewtype == 5{ stopView.addSubview(nadView) }
            BannerCount += 1
        }
    }
    //バナー広告の通信のON、OFFの切り替え
    func BannerStatasChange(){
        for i in 0..<BannerDisplay.count{
            if BannerNumber[i].count != 1{
                for j in 1..<BannerDisplay[i].count{
                    if BannerDisplay[i][j] == Viewtype + ViweCount{//バナーの通信をON
                        BannerDisplay[i][j] = Viewtype
                        BannerViwe[BannerNumber[i][j]].resume()
                       // print("AAAAA")
                    }
                    if BannerDisplay[i][j] != Viewtype && 1 <= BannerDisplay[i][j] && BannerDisplay[i][j] <= ViweCount {//バナーの通信をOFF
                        BannerDisplay[i][j] += ViweCount
                        BannerViwe[BannerNumber[i][j]].pause()
                    }
                }
            }
        }
    }
    //動画インターステシャル広告の表示準備を行う関数
    func InterstitialSetUP(){
         self.interstitialVideo.delegate = self
    }
    //動画インターステシャル広告の読み込みに使う関数
    func InterstitialLoad(){
        if InterReadFlag{
            self.interstitialVideo.loadAd()
            InterReadFlag = false
        }
    }
    //動画インターステシャルすの表示
    func InterstitialDisplay(){
        if self.interstitialVideo.isReady {
            self.interstitialVideo.showAd(from: self)
        }else{
            InterstitialFinish()
        }
    }
    //動画インターステシャル広告を閉じた時に行う操作
    func InterstitialFinish(){
        if InterType == 1 || InterType == 2{
            if InterType == 1{ displayGameOverView() }
            if InterType == 2{ displayStageClearView() }
            view.sendSubviewToBack(StageFinishView)
            SceneF[0].removeFromParent()
            SceneF[0].removeAllChildren()
            SceneF.removeAll()
        }
        InterType = 0
        InterReadFlag = true
    }
    //動画インターステシャル広告を閉じた時に呼び出される
    func nadInterstitialVideoAdDidClose(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Close.")
        InterstitialFinish()
    }
    
    //Nendのデフォルトのまま使用
    //バナー広告のロード終了時に呼び出される
    func nadViewDidFinishLoad(_ adView: NADView!) {
        print("delegate nadViewDidFinishLoad:")
    }
    //バナー広告の通信受信時に呼び出される
    func nadViewDidReceiveAd(_ adView: NADView!) {
        print("delegate nadViewDidReceiveAd")
    }
    //バナー広告のロード終了時に呼び出される
    func nadInterstitialVideoAdDidReceiveAd(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Receive.")
    }
    //動画インターステシャル広告のロード失敗時に呼び出される
    func nadInterstitialVideoAd(_ nadInterstitialVideoAd: NADInterstitialVideo!, didFailToLoadWithError error: Error!){
        print("Interstitial Load failed.")
    }
    //動画インターステシャル広告の表示失敗時に呼び出される
    func nadInterstitialVideoAdDidFailed(toPlay nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Fail to Show.")
    }
    //動画インターステシャル広告の表示時に呼び出される
    func nadInterstitialVideoAdDidOpen(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Open.")
    }
    //動画インターステシャル広告を最後まで再生した時に呼び出される
    func nadInterstitialVideoAdDidCompletePlaying(_ nadInterstitialVideoAd: NADInterstitialVideo!){
        print("Interstitial Video Did Complete Playing.")
    }
}

//ゲームオーバー時に表示するシーンを作成
class GameOverScean: SKScene{
    let w = UIScreen.main.bounds.size.width;let h = UIScreen.main.bounds.size.height
    let w1 = UIScreen.main.bounds.size.width / 10;let h1 = UIScreen.main.bounds.size.height / 10
    override func didMove(to view: SKView) {
        let backgroundimage = SKSpriteNode(imageNamed: "bgO")
        backgroundimage.position = CGPoint(x: w / 2, y: h / 2)
        backgroundimage.size = CGSize(width: w, height: h)
        addChild(backgroundimage)
        let intime = 1.0
        let movetime = 3.0
        let lagtime = 0.1
        let text = "GAMEOVER"
        let StartP: [[CGFloat]] = [[1,1],[2,9],[3,1],[4,9],[6,1],[7,9],[8,1],[9,9]]
        let FinishP: [[CGFloat]] = [[1,5],[2,5],[3,5],[4,5],[6,5],[7,5],[8,5],[9,5]]

        for n in 0 ..< StartP.count{
            let startIndex = text.index(text.startIndex, offsetBy: n)
            let endIndex = text.index(startIndex, offsetBy: 1)
            let Str = text[startIndex..<endIndex]
            let charaSprite = SKSpriteNode(imageNamed: "O" + Str)
            charaSprite.position = CGPoint(x: w1 * StartP[n][0], y: h1 * StartP[n][1])
            charaSprite.size = CGSize(width: h1, height: h1)
            charaSprite.alpha = 0
            addChild(charaSprite)
            let moveAction = SKAction.move(to: CGPoint(x: w1 * FinishP[n][0], y: h1 * FinishP[n][1]), duration: movetime)
            let inAction = SKAction.fadeIn(withDuration: intime)
            let rotateAction = SKAction.rotate(byAngle: 360.0 * .pi / 180.0 , duration: movetime)
            let playAction = SKAction.group([moveAction,inAction,rotateAction])
            self.run(SKAction.wait(forDuration: lagtime * Double(n))){
                charaSprite.run(playAction)
            }
        
        }
    }
}
//ステージクリア時に表示するシーンを作成
class StageClearScean: SKScene{
    let w = UIScreen.main.bounds.size.width;let h = UIScreen.main.bounds.size.height
    let w1 = UIScreen.main.bounds.size.width / 10;let h1 = UIScreen.main.bounds.size.height / 10
    override func didMove(to view: SKView) {
        let backgroundimage = SKSpriteNode(imageNamed: "bgC")
        backgroundimage.position = CGPoint(x: w / 2, y: h / 2)
        backgroundimage.size = CGSize(width: w, height: h)
        addChild(backgroundimage)
        let intime = 1.0
        let movetime = 2.0
        let lagtime = 0.15
        let text = "STAGECLEAR"
      //  let StartP: [[CGFloat]] = [[1,1],[1.8,9],[2.6,1],[3.4,9],[4.2,1],[5.8,9],[6.6,1],[7.4,9],[8.2,1],[9,9]]
        let StartP: [[CGFloat]] = [[9.5,5],[9.5,5],[9.5,5],[9.5,5],[9.5,5],[9.5,5],[9.5,5],[9.5,5],[9.5,5],[9.5,5]]
        let FinishP: [[CGFloat]] = [[1,5],[1.8,5],[2.6,5],[3.4,5],[4.2,5],[5.8,5],[6.6,5],[7.4,5],[8.2,5],[9,5]]
        for n in 0..<StartP.count{
            let startIndex = text.index(text.startIndex, offsetBy: n)
            let endIndex = text.index(startIndex, offsetBy: 1)
            let Str = text[startIndex..<endIndex]
            let charaSprite = SKSpriteNode(imageNamed: "C" + Str)
            charaSprite.position = CGPoint(x: w1 * StartP[n][0], y: h1 * StartP[n][1])
            charaSprite.size = CGSize(width: h1, height: h1)
            charaSprite.alpha = 0
            addChild(charaSprite)
            let moveAction = SKAction.move(to: CGPoint(x: w1 * FinishP[n][0], y: h1 * FinishP[n][1]), duration: movetime)
            let inAction = SKAction.fadeIn(withDuration: intime)
            let rotateAction = SKAction.rotate(byAngle: 360.0 * .pi / 180.0 , duration: movetime)
            let playAction = SKAction.group([moveAction,inAction,rotateAction])
            self.run(SKAction.wait(forDuration: lagtime * Double(n))){
                charaSprite.run(playAction)
            }
        }
    }
}


//タッチイベントを部分的に透過させるビュークラスの作成（ステージのインターフェイスに使用）
class TransparentView: SKView{
    var NotouchRect: [CGRect] = []
    func addNotTransparentArea(Rect:CGRect){
        NotouchRect.append(Rect)
    }
    
    func clearView(){
        self.backgroundColor = .clear
        let ss = SKScene(size: self.frame.size)
        ss.backgroundColor = .clear
        self.presentScene(ss)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if NotouchRect.count >= 1{
            for n in 0..<NotouchRect.count{
                if (NotouchRect[n].contains(point)){
                    return true
                }
            }
        }
        return false
    }
}
