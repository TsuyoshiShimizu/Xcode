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
import StoreKit
import youtube_ios_player_helper

class firstVC: UIViewController,NADViewDelegate,NADInterstitialVideoDelegate,IAPManagerDelegate,YTPlayerViewDelegate,UITextViewDelegate{
    let w = UIScreen.main.bounds.size.width;let h = UIScreen.main.bounds.size.height
    let w1 = UIScreen.main.bounds.size.width / 10;let h1 = UIScreen.main.bounds.size.height / 10
    let x1 = UIScreen.main.bounds.size.width / 100
    let y1 = UIScreen.main.bounds.size.height / 100
    //BGM,効果音を管理
    var playingBGM: AVAudioPlayer!  //再生中のBGMを管理
    var BGM: [AVAudioPlayer] = []   //BGMを管理
    var SE: [AVAudioPlayer] = []    //SEを管理
    
    var UpdateFirst: Bool = true    //アップデート時に一回だけ実行するために使用
    var UpdateN = 1                 //アップデートの回数
    
    //動画を管理
    var playMovie: AVPlayer!        //再生中の動画を管理
    var readMovie: [AVPlayer] = []
    var MovieLayer: AVPlayerLayer!
    
    var TVView: SKView!                   //TVを表示するビュー
    var TVMovieView: SKView!             //TVの動画を表示するビュー
    var TVScene: SKScene!                 //TVシーンを管理
    var TVCount: Int = 0                  //現在テレビで何番目のテレビを表示しているかを管理
    var TVMovie: [AVPlayer] = []          //テレビに表示する動画の管理
    var TVPicture: [SKTexture] = []       //テレビに表示する静止画の管理
    var TVMovieScene: AVPlayerLayer!      //テレビの動画を表示するスクリーン
    var TVPictureScene: SKSpriteNode!     //テレビの静止画を表示するスクリーン
    
    var SubTextView: UIView!
    
    //4¥ビューの管理
    var titleView:SKView!                 //タイトルビュー
    var stageView:SKView!                 //ステージビュー
    var LoadView:SKView!                  //ロード画面を表示するビュー
    var stageFrontView:TransparentView!   //ステージプレイ時のインターフェイスビュー
    var menuView:SKView!
    var SystemMenuView:SystemView!
    
    
   // var SubSystemView: [SKView] = []
    var SubSystemView: [UIView] = []
    
    var stageclearView:SKView!            //ステージクリアビュー
    var stagePView: SKView!               //ステージを途中から開始できる時にどこから開始するかを確認するビュー
    var StageFinishView: SKView!          //ステージクリアまたはゲームオーバー時に呼び出されるビュー（ステージクリア、ゲームオーバーの演出）
    var HowToPlayView: SKView!            //操作方法を説明するビュー

    //説明ビューに使用するやつ
    var discriptionView: SKView!
    var discriptionN = 0
    var discriptionPageN = 1          // 1 2 3 4 5 6 7 8 9 10 11 12 13 14
    var discriptionPageCount: [Int] = [0,1,2,1,1,1,1,1,1,2, 2, 4, 1, 2, 3]
    var discriptionLabel1: UILabel = UILabel()
    var discriptionLabel2: UILabel = UILabel()
  
    var stopButton: UIButton!                                   //ストップボタンを管理
    var menuButton: UIButton!                                   //メニューボタンを管理
    var playstage: Bool = false                                 //ステージをプレイ中か否か
    var stageN: Int = 0                                         //プレイしているステージを管理
    var stagesceneN: Int = 0                                    //ステージのシーンを管理
    var StageCount: Int = 120                                   //ステージ数
    var StageSceneSave = [Int](repeating: 0, count: 121)        //ステージシーンの読み込み用
    var StageCF = [Int](repeating: 0, count: 121)               //ステージクリア状況
    var SSSave: Int = 0                                         //ステージセレクト用ステージの記憶
    var SSBSave: Int = 0                                        //ステージセレクト用ステージの記憶
    let stagesize: [Int] = [4,4]                                //ステージのビューサイズを管理
    var playScene:[SKScene] = []                                //再生中のシーンを管理
    var SceneF:[SKScene] = []                                   //ゲームオーバー、ステージクリア時のシーンを管理
    var PlayerHP: Int = 100                                     //プレイヤーのHP
    var PlayerMP: Int = 100                                     //プレイヤーのMP
    var PlayerMaxHP: Int = 100                                  //プレイヤー最大HP
    var PlayerMaxMP: Int = 100                                  //プレイヤー最大HP
    var PlayerAttackP: Int = 10                                 //攻撃力
    var HPgauge:UIProgressView!
    var MPgauge:UIProgressView!
    var LoadPicture: SKSpriteNode!
    var menuDViwe: [UIView] = []                                //メニュー非表示時に消すものを格納
    
    var ReviewFlag: Bool = false
    
    var PictureFlag = [Bool](repeating: false, count: 31)       //ポン吉の写真の表示履歴を記憶(ポン吉の写真の枚数　+ 1)
    var PictureTapFlag = [Bool](repeating: false, count: 31)
    var PictureCount = 30
    var PictureView: [SKView] = []
    var PictureButton: [UIButton] = []
    var AlbumPage: Int = 0
    
    //通常時のスキル状況を管理
    var PSGet = [Bool](repeating: false, count: 21)
    var PSOn = [Bool](repeating: false, count: 21)
    var HAType = 0
    
    //練習エリアのスキル状況を管理
    var Practice: Bool = false
    var PraPSGet = [Bool](repeating: false, count: 21)
    var PraPSOn = [Bool](repeating: false, count: 21)
    var PraHAType = 0
    
    var CFitemF = [Bool](repeating: false, count: 21)
    var difficulty = 0                                          //難易度
    var HPMaxfalg: Bool = true
    
    var Pointerflag = true
    var FirstPlay = false

    var menuScene:SKScene!
    var menuLabel: [SKLabelNode] = []
    var MButton: [UIButton] = []
    
    var retrunB: UIButton!
    var cB: UIButton!
    
    var Loadcat: [SKTexture] = []
    var Loadtext: [SKTexture] = []
    var LoadTextSprite: SKSpriteNode!
    var LoadCatSprite: SKSpriteNode!
    
    var titleButton: [UIButton] = []
    var titleObjectT: [SKTexture] = []
    var titleCatT: [SKTexture] = []
    var CatBO:SKSpriteNode!
    var ClockBO:SKSpriteNode!
    var TVBO:SKSpriteNode!
    var titleCatAnime1: [SKTexture] = []
    var titleCatAnime2: [SKTexture] = []
    var titleCatAnime3: [SKTexture] = []
    var titleStatas: Int = 0
    var titleClockF: Bool = true
    
    //課金ボタン、課金に必要なパラメータの管理
    var MoneyFlag1:Bool = UserDefaults.standard.bool(forKey: "MoneyF")
    var ProductID:String!                                               //課金メニュービュー

    //課金により広告を非表示にしているか
    var BannerView:[SKView] = []
    var goC: Int = 0
    var stopC: Int = 0

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
    private let interstitialVideo = NADInterstitialVideo(spotId: "963900", apiKey: "6eee3b2b6ddd95459126b97a16683fdaa5e20bc4")
    var InterType: Int = 0      //動画インターステシャルの表示後の実行コードの違い
    // type:0 何も操作しない　type:1 ゲームオーバービューを表示　type:2 ステージクリアビューを表示
    var InterCount = UserDefaults.standard.integer(forKey: "InterCountI")   //ゲームオーバー回数
    var InterFN = 4                                                         //何回目のゲームオーバーで広告を表示させるか
    var InterReadFlag = true                                                //動画インターステシャルをロードする必要があるか
    //広告表示はここまで
    
    //4¥最初に実行する処理
    override func viewDidLoad() {
        super.viewDidLoad()
        IAPManager.shared.delegate = self
        
        //ゲームのクリア状況を操作する関数
        //リリーズ時は必ず無効化する必要あり
      //  GameFlagControll()
        SoundRead()           //BGM、効果音の読み込み
        ReadPlayerSkill()
        
        if MoneyFlag1 == false { InterstitialSetUP() }
           //Nend インターステシャル動画広告の表示準備
        difficulty = UserDefaults.standard.integer(forKey: "difficulty")
        Pointerflag = UserDefaults.standard.bool(forKey: "Pointerflag")
        FirstPlay = UserDefaults.standard.bool(forKey: "firstplay")
        SSSave = UserDefaults.standard.integer(forKey: "SSSave")
        SSBSave = UserDefaults.standard.integer(forKey: "SSBSave")
        UpdateFirst = UserDefaults.standard.bool(forKey: "UpdateFirst\(UpdateN)")
        for n in 1...StageCount{
            StageSceneSave[n] = UserDefaults.standard.integer(forKey: "stageScene\(n)")
            StageCF[n] =  UserDefaults.standard.integer(forKey: "stageclear\(n)")
        }
        for n in 1 ..< PictureFlag.count{
            PictureFlag[n] = UserDefaults.standard.bool(forKey: "PictureFlag\(n)")
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.endofMovie), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        CreateLoadScene()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            self.SetUpView()
        }
    
    }
    
    //4¥ロード画面の作成
    func CreateLoadScene(){
        //ロードビューの作成と追加
        LoadView = SKView(frame: view.frame) ;view.addSubview(LoadView)
        let LoadScene = SKAnimeScene(size: view.frame.size)
        let LoadTexter = SKTexture(imageNamed: "P21")
        LoadPicture = SKSpriteNode(texture: LoadTexter)
        LoadPicture.position = CGPoint(x: self.w / 2, y: self.h / 2)
        LoadPicture.size = CGSize(width: self.w, height: self.w * 3 / 4)
        LoadScene.addChild(self.LoadPicture)
        
        let LCatSize: CGFloat = 2.5
        let LCatP: [CGFloat] = [9.0 ,1.2]
        let textSize: CGFloat = 2.0
        let textP: [CGFloat] = [9.0 ,0.3]
        
        Loadtext = LoadScene.ReadTextureAnime(AtlasNamed: "Ltextanime", fileNamed: "Loadtext", Count: 3)
        Loadcat = LoadScene.ReadTextureAnime(AtlasNamed: "Lcatanime", fileNamed: "catanime1_", Count: 18)
        titleObjectT = LoadScene.ReadTextureAnime(AtlasNamed: "titleO", fileNamed: "titleO", Count: 31)
        titleCatT = LoadScene.ReadTextureAnime(AtlasNamed: "TcatButton", fileNamed: "Tcat", Count: 8)
        titleCatAnime1 = LoadScene.ReadTextureAnime(AtlasNamed: "Tcatanime1", fileNamed: "Tcatanime1_", Count: 18)
        titleCatAnime2 = LoadScene.ReadTextureAnime(AtlasNamed: "Tcatanime2", fileNamed: "Tcatanime2_", Count: 18)
        titleCatAnime3 = LoadScene.ReadTextureAnime(AtlasNamed: "Tcatanime3", fileNamed: "Tcatanime3_", Count: 13)
        
        LoadTextSprite = SKSpriteNode(texture: Loadtext[0])
        LoadTextSprite.scale(to: CGSize(width: w1 * textSize, height: w1 * textSize * 0.32))
        LoadTextSprite.position = CGPoint(x: w1 * textP[0], y: w1 * textP[1])
        LoadScene.addChild(LoadTextSprite)
        LoadCatSprite = SKSpriteNode(texture: Loadcat[0])
        LoadCatSprite.scale(to: CGSize(width: w1 * LCatSize, height: w1 * LCatSize))
        LoadCatSprite.position = CGPoint(x: w1 * LCatP[0], y: w1 * LCatP[1])
        LoadScene.addChild(LoadCatSprite)
        LoadView.presentScene(LoadScene)
        
        let catanime = SKAction.animate(with: Loadcat, timePerFrame: 1.0 / 18.0)
        let textanime = SKAction.animate(with: Loadtext, timePerFrame: 0.05)
        LoadCatSprite.run(SKAction.repeatForever(catanime))
        LoadTextSprite.run(SKAction.repeatForever(textanime))
        
        
    }
    
    //4¥システムメニュー画面
    func displaySystemMenuViwe(){
        if SystemMenuView == nil {
            
            let BackButtonSize:CGFloat = 8                  //メニューを消すボタンのサイズ(画面横の百分率)
            let BackButtonPosition:CGFloat = 6              //メニューを消すボタンの位置(画面左上が基準_画面横百分率)
            
            let Btitle: [String] = ["お知らせ","操作説明","練習エリア","エリアセレクト","ポン吉の動画","ポン吉のアルバム","有料コンテンツ","レビューを書く","他作品の紹介","ご意見箱"]
            let SMenuBSize:[CGFloat] = [45,15]              //メニューボタンのサイズ(画面サイズ百分率)
            let SMenuBFirstP: CGFloat = 25                  //メニューボタンの一番上の高さ(画面上が基準_画面縦百分率)
            let SMenuBWidthP: CGFloat = 25                  //メニューボタンのx座標位置(画面中心が基準_画面横百分率)
            let SMenuBHeightP: CGFloat = 15                 //メニューボタンのy座標間隔(画面縦百分率)
            let SMenuBFontSize: CGFloat = 4                 //メニューボタンのフォントサイズ(画面横百分率)
            
            //ビューの作成
            SystemMenuView = SystemView(frame: CGRect(x: 0, y: 0, width: w, height: h))
            SystemMenuView.ClearView()
            self.view.addSubview(SystemMenuView)

            //バックボタンの作成(バツボタン)
            let BackButton = UIButton(frame: CGRect(x: 0, y: 0, width: BackButtonSize * x1, height: BackButtonSize * x1))
            BackButton.center = CGPoint(x: BackButtonPosition * x1, y: BackButtonPosition * x1)
            BackButton.setBackgroundImage(UIImage(named: "MenuClose"), for: .normal)
            BackButton.addTarget(self, action: #selector(firstVC.SystemBackButton(_:)), for: .touchUpInside)
            SystemMenuView.addSubview(BackButton)
            
            //メニュボタンの作成
            for n in 0 ..< Btitle.count{
                var xB: CGFloat = 1.0  ;if n % 2 == 0{ xB = -1.0 }
                let yB = CGFloat( n / 2 )
                let SMButton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 * SMenuBSize[0], height: y1 * SMenuBSize[1]))
                SMButton.center = CGPoint(x: w / 2 + xB * SMenuBWidthP * x1, y: (SMenuBFirstP + yB * SMenuBHeightP) * y1  )
                SMButton.setBackgroundImage(UIImage(named: "MenuButton"), for: .normal)
                SMButton.setTitle(Btitle[n], for: .normal)
                SMButton.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * SMenuBFontSize)
                SMButton.addTarget(self, action: #selector(firstVC.SMenyButton(_:)), for: .touchUpInside)
                SMButton.accessibilityValue = String(n)
                SMButton.setTitleColor(.white, for: .normal)
                SystemMenuView.addSubview(SMButton)
            }
        }else{
            self.view.bringSubviewToFront(SystemMenuView)
        }
    }
    
    @objc func SystemBackButton(_ sender: UIButton){
        PlaySE(SEnumber: 12)
        self.view.sendSubviewToBack(SystemMenuView)
        
        
    }
    
    //4¥システムメニューボタン
    @objc func SMenyButton(_ sender: UIButton){
        if let Name = sender.accessibilityValue{
            if let Number = Int(Name){
                if Number == 0{//お知らせ
                    //4¥******お知らせ
                    
                    PlaySE(SEnumber: 5)
                    SystemMenuView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
                    nextView.ClearView()
                    view.addSubview(nextView)
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    
                    let Button1 = CreateButton(Px: 0, Py: 38, width: 70, height: 20, FontSize: 4, text: "アップデート情報", ButtonNumber: 12)
                    nextView.addSubview(Button1)
                    
                    let Label1 = CreateLabel(Px: 0, Py: 17, width: 80, height: 20, FontSize: 3, text: "練習エリアを追加しました。\n操作に慣れていない人はこのエリアで練習しよう！")
                    nextView.addSubview(Label1)
                    
                    let Button2 = CreateButton(Px: 0, Py: -3, width: 70, height: 20, FontSize: 4, text: "練習エリアへ移動", ButtonNumber: 13)
                    nextView.addSubview(Button2)
                    
                    let Label2 = CreateLabel(Px: 0, Py: -22, width: 80, height: 15, FontSize: 3, text: "新エリア　天空エリアを追加しました。")
                    nextView.addSubview(Label2)
                    
                    nextView.addSubview(CreateButton(Px: 0, Py: -40, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "天空エリア　ダイジェスト", ButtonNumber: 92,textColor: .brown))
                    
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    
                }
                if Number == 1{//操作説明
                    PlaySE(SEnumber: 0)
                    displayHowToPlayView()
                }
                if Number == 2{//練習エリア
                    PlaySE(SEnumber: 5)
                    SystemMenuView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateLabel(Px: 0, Py: 15, width: 80, height: 20, FontSize: 4, text: "練習エリアに移動しますか？"))
                    nextView.addSubview(CreateButton(Px: -25, Py: -15, width: 45, height: 15, FontSize: 4, text: "移動する", ButtonNumber: 1))
                    nextView.addSubview(CreateButton(Px: 25, Py: -15, width: 45, height: 15, FontSize: 4, text: "移動しない", ButtonNumber: 2))
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                if Number == 3{//エリアセレクト
                    PlaySE(SEnumber: 5)
                    SystemMenuView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateLabel(Px: 0, Py: 30, width: 80, height: 20, FontSize: 4, text: "どのエリアに移動しますか？"))
                    let MButton1 = CreateButton(Px: -25, Py: 10, width: 45, height: 15, FontSize: 4, text: "草原エリア", ButtonNumber: 101)
                    if StageCF[1] == 0 && StageCF[2] == 0 && StageCF[3] == 0 && StageCF[4] == 0 && StageCF[5] == 0{
                        MButton1.alpha = 0.2 ;MButton1.isEnabled = false
                    }
                    nextView.addSubview(MButton1)
                    
                    let MButton2 = CreateButton(Px: 25, Py: 10, width: 45, height: 15, FontSize: 4, text: "森林エリア", ButtonNumber: 102)
                    if StageCF[7] == 0 && StageCF[8] == 0 && StageCF[9] == 0 && StageCF[10] == 0 && StageCF[11] == 0 && StageCF[12] == 0{
                        MButton2.alpha = 0.2 ;MButton2.isEnabled = false
                    }
                    nextView.addSubview(MButton2)
                    
                    let MButton3 = CreateButton(Px: -25, Py: -5, width: 45, height: 15, FontSize: 4, text: "洞窟エリア", ButtonNumber: 103)
                    if StageCF[14] == 0 && StageCF[15] == 0 && StageCF[16] == 0 && StageCF[17] == 0 && StageCF[18] == 0 && StageCF[19] == 0{
                        MButton3.alpha = 0.2 ;MButton3.isEnabled = false
                    }
                    nextView.addSubview(MButton3)
                    
                    let MButton4 = CreateButton(Px: 25, Py: -5, width: 45, height: 15, FontSize: 4, text: "火山エリア", ButtonNumber: 104)
                    if StageCF[21] == 0 && StageCF[22] == 0 && StageCF[23] == 0 && StageCF[24] == 0 && StageCF[25] == 0 && StageCF[26] == 0{
                        MButton4.alpha = 0.2 ;MButton4.isEnabled = false
                    }
                    nextView.addSubview(MButton4)
                    
                    let MButton5 = CreateButton(Px: -25, Py: -20, width: 45, height: 15, FontSize: 4, text: "氷雪エリア", ButtonNumber: 105)
                    if StageCF[28] == 0 && StageCF[29] == 0 && StageCF[30] == 0 && StageCF[31] == 0 && StageCF[32] == 0 && StageCF[33] == 0{
                        MButton5.alpha = 0.2 ;MButton5.isEnabled = false
                    }
                    nextView.addSubview(MButton5)
                    
                    let MButton6 = CreateButton(Px: 25, Py: -20, width: 45, height: 15, FontSize: 4, text: "天空エリア", ButtonNumber: 106)
                    if StageCF[35] == 0 && StageCF[36] == 0 && StageCF[37] == 0 && StageCF[38] == 0 && StageCF[39] == 0 && StageCF[40] == 0{
                        MButton6.alpha = 0.2 ;MButton5.isEnabled = false
                    }
                    nextView.addSubview(MButton6)
        
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                //4¥******動画ボタンの設定
                if Number == 4{//ポン吉の動画
                    PlaySE(SEnumber: 0)
                    let NextView = CreateImageView(ImageName: "Mbg")
                    view.addSubview(NextView)
                    SubSystemView.append(NextView)
                    NextView.addSubview(CreateSubSystemCloseButton())
                    NextView.addSubview(CreateButton(Px: 0, Py: 35, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "ポン吉の大冒険PV", ButtonNumber: 6,textColor: .brown))
                    NextView.addSubview(CreateButton(Px: 0, Py: 12, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "ポン吉水没！", ButtonNumber: 7,textColor: .brown))
                    NextView.addSubview(CreateButton(Px: 0, Py: -11, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "ボン吉キレる", ButtonNumber: 8,textColor: .brown))
                    NextView.addSubview(CreateButton(Px: 0, Py: -34, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "押すな！絶対押すなよ！", ButtonNumber: 9,textColor: .brown))
                    NextView.addSubview(CreateButton(Px: 43, Py: 40, width: 8, YScale: 1, ImageName: "YouTube", ButtonNumber: 20))
                }
                if Number == 5{//ポン吉のアルバム
                    PlaySE(SEnumber: 0)
                    CreateAlbumView()
                    SubSystemView[0].CenterPosition()
                }
                if Number == 6{//有料コンテンツ
                    PlaySE(SEnumber: 5)
                    SystemMenuView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateLabel(Px: 0, Py: 25, width: 70, height: 20, FontSize: 4, text: "課金メニュー"))
                    let Button1 = CreateButton(Px: 0, Py: 5, width: 70, height: 20, FontSize: 4, text: "広告非常時　２５０円", ButtonNumber: 3)
                    nextView.addSubview(Button1)
                    
                    if MoneyFlag1{
                        Button1.alpha = 0.7 ; Button1.isEnabled = false
                        nextView.addSubview(CreateText(Px: 35, Py: 5, width: 30, height: 20, text: "購入済み", FontSize: 4, FontColor: .red))
                    }
                    let Button2 = CreateButton(Px: 0, Py: -15, width: 70, height: 20, FontSize: 4, text: "チート化　４９０円", ButtonNumber: 50)
                    nextView.addSubview(Button2)
                    Button2.alpha = 0.7
                    Button2.isEnabled = false
                    nextView.addSubview(CreateText(Px: 35, Py: -15, width: 30, height: 20, text: "実装予定", FontSize: 4, FontColor: .green))
                    let Button3 = CreateButton(Px: 0, Py: -40, width: 70, height: 20, FontSize: 4, text: "購入履歴の復元", ButtonNumber: 5)
                    nextView.addSubview(Button3)
                    
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                if Number == 7{//アプリレビュー
                    if let url = URL(string: "https://itunes.apple.com/us/app/itunes-u/id1474041840?action=write-review") {
                        UIApplication.shared.open(url)
                    }
                }
                //¥¥アプリの紹介
                if Number == 8{//他作品の紹介
                    PlaySE(SEnumber: 5)
                    SystemMenuView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateScrollSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateBackButton())
                    
                    let text1 = "ネコたま\nリアルにゃんこの本格3Dアクションアドベンチャーゲーム。８つのアクションを使い3Dの世界を冒険しよう(難易度普通)"
                    let Label1 = CreateLabel(Px: 0, Py: 35, width: 80, height: 40, FontSize: 3, text: text1)
                    nextView.addSubview(Label1)
                    
                    let Button1 = CreateButton(Px: -10, Py: 10, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "ネコたま紹介動画", ButtonNumber: 94,textColor: .brown)
                    nextView.addSubview(Button1)
                    let Button2 = CreateButton(Px: 30, Py: 10, width: 10, YScale: 1, ImageName: "Download", ButtonNumber: 21)
                    nextView.addSubview(Button2)
                    
                    let text2 = "ブラックサイズ\n大鎌を持ったシルエット少女の本格2Dアクションアドベンチャーゲーム。壁キックや回転斬りを駆使してゴールを目指そう(難易度普通)"
                    let Label2 = CreateLabel(Px: 0, Py: -15, width: 80, height: 40, FontSize: 3, text: text2)
                    nextView.addSubview(Label2)
                
                    let Button3 = CreateButton(Px: -10, Py: -40, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "ブラックサイズ紹介動画", ButtonNumber: 91,textColor: .brown)
                    nextView.addSubview(Button3)
                    let Button4 = CreateButton(Px: 30, Py: -40, width: 10, YScale: 1, ImageName: "Download", ButtonNumber: 14)
                    nextView.addSubview(Button4)
                    
                    let text3 = "GravityBall - freely\nボールを転がしてゴールを目指すアクションゲーム\n一時的に無重力にできる能力を駆使してステージをクリアしよう(難易度激ムズ)"
                    let Label3 = CreateLabel(Px: 0, Py: -65, width: 80, height: 40, FontSize: 3, text: text3)
                    nextView.addSubview(Label3)
                    
                    let Button5 = CreateButton(Px: -10, Py: -90, width: 60, height: 15, ImageName: "firm", FontSize: 4, text: "GravityBall紹介動画", ButtonNumber: 90,textColor: .brown)
                    nextView.addSubview(Button5)
                    let Button6 = CreateButton(Px: 30, Py: -90, width: 10, YScale: 1, ImageName: "Download", ButtonNumber: 15)
                    nextView.addSubview(Button6)
                    
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                
                if Number == 9{//ご意見箱
                    PlaySE(SEnumber: 5)
                    SystemMenuView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateBackButton())
                    
                    let text1 = "ご意見箱\nポン吉の大冒険に関するご意見、ご要望、不具合などがありましたら、気軽に送信してください。\n\n例\n・〇〇の機能が欲しい\n・〇〇の様なステージをプレイしたい\n・〇〇のステージが難しくてクリアできない\n・〇〇のバグがある"
                    let Label = CreateLabel(Px: 0, Py: 10, width: 80, height: 100, FontSize: 3, text: text1)
                    nextView.addSubview(Label)
                    
                    let Button1 = CreateButton(Px: 0, Py: -40, width: 70, height: 20, FontSize: 4, text: "ご意見・ご要望を書く", ButtonNumber: 16)
                    nextView.addSubview(Button1)
                    
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    
                    Button1.SaveView = nextView
                }
            }
        }
    }

    
    //CreateButton の動作内容
    @objc func SystemButton(_ sender: CustomButton){
        if let Name = sender.accessibilityValue{
            if let Number = Int(Name){
                if Number == 1{//練習エリアに移動する
                    PlaySE(SEnumber: 1)
                    SubSystemViewDelete()
                    SystemMenuView.CenterPosition()
                    Movestage(MoveStageN: -12, MoveSceneN: 0)
                }
                if Number == 2{//サブシステムビューを閉じるて、初期化
                    PlaySE(SEnumber: 12)
                    SubSystemViewDelete()
                    SystemMenuView.CenterPosition()
                    view.sendSubviewToBack(SystemMenuView)
                }
                if 101 <= Number && Number <= 110{//通常エリアに移動を確認するビュー
                    PlaySE(SEnumber: 5)
                    SubSystemView[0].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    var areaName: String!
                    if Number == 101 { areaName = "草原" }
                    if Number == 102 { areaName = "森林" }
                    if Number == 103 { areaName = "洞窟" }
                    if Number == 104 { areaName = "火山" }
                    if Number == 105 { areaName = "氷雪" }
                    if Number == 106 { areaName = "天空" }
                    
                    nextView.addSubview(CreateLabel(Px: 0, Py: 15, width: 80, height: 20, FontSize: 4, text: areaName + "エリアに移動しますか？"))
                    nextView.addSubview(CreateButton(Px: -25, Py: -15, width: 45, height: 15, FontSize: 4, text: "移動する", ButtonNumber: Number + 10))
                    nextView.addSubview(CreateButton(Px: 25, Py: -15, width: 45, height: 15, FontSize: 4, text: "移動しない", ButtonNumber: 2))
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                if 111 <= Number && Number <= 120{//通常エリアに移動する
                    PlaySE(SEnumber: 1)
                    SubSystemViewDelete()
                    SystemMenuView.CenterPosition()
                    Movestage(MoveStageN: 109 - Number, MoveSceneN: 0)
                }
                if Number == 3{//広告非表示ビュー
                    PlaySE(SEnumber: 5)
                    SubSystemView[0].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateLabel(Px: 0, Py: 15, width: 80, height: 20, FontSize: 4, text: "250円で広告を非表示にしますか？"))
                    nextView.addSubview(CreateButton(Px: -25, Py: -15, width: 45, height: 15, FontSize: 4, text: "はい", ButtonNumber: 4))
                    nextView.addSubview(CreateButton(Px: 25, Py: -15, width: 45, height: 15, FontSize: 4, text: "いいえ", ButtonNumber: 2))
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                if Number == 4{//広告非表示
                    SubSystemViewDelete()
                    SystemMenuView.CenterPosition()
                    view.sendSubviewToBack(SystemMenuView)
                    
                    ProductID = "ponkiticminvalid"
                    PlaySE(SEnumber: 2)
                    IAPManager.shared.buy(productIdentifier: ProductID)
                }
                if Number == 5{//購入履歴を復元
                    SubSystemViewDelete()
                    SystemMenuView.CenterPosition()
                    view.sendSubviewToBack(SystemMenuView)
                    
                    PlaySE(SEnumber: 2)
                    IAPManager.shared.restore()
                }
                if Number == 100{ //タップでボタンを消去
                    sender.removeFromSuperview()
                }
                //¥¥YouTubeの動画表示設定
                if 6 <= Number && Number <= 9 || 90 <= Number && Number <= 99{ //動画再生ボタン(ポン吉水没)
                    let PView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
                    PView.ClearView()
                    view.addSubview(PView)
                    //BGMの停止
                    StopBGN()
                    //動画再生ビューの作成
                    let NextView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
                    NextView.LowerPosition()
                    NextView.ClearView()
                    view.addSubview(NextView)
                    
                    //動画の表示サイズと位置の計算
                    let TVwidth:CGFloat = 90
                    let TVheight:CGFloat = 90
                    let TVPx:CGFloat = 0
                    let TVPy:CGFloat = (TVheight - 100) / 2
                    let Moviewidth = TVwidth * 0.596
                    let Movieheight = TVheight * 0.722
                    let MoviePx = TVwidth * -0.111 + TVPx
                    let MoviePy = TVheight * -0.004 + TVPy
                    
                    //4¥******動画ボタンのアドレス
                    //YouTubeの動画IDの読み込み
                    var MovieID: String!
                    if       Number == 6{ //動画メニュー１番上
                        MovieID = "xnMzzSbgpQw"
                    }else if Number == 7{ //動画メニュー２番目
                        MovieID = "j9NhETh-ke4"
                    }else if Number == 8{ //動画メニュー３番目
                        MovieID = "_A28Qqa6IYU"
                    }else if Number == 9{ //動画メニュー４番目
                        MovieID = "iEsZQxuGKXM"
                    }else if Number == 90{ //他作品紹介
                        MovieID = "DklZskxPDNY"
                    }else if Number == 91{ //他作品紹介
                        MovieID = "rYItYYsi3-s"
                    }else if Number == 92{ ///天空エリア
                        MovieID = "MRThcsZwP_8"
                    }else if Number == 93{
                        MovieID = "xnMzzSbgpQw"
                    }else if Number == 94{
                        MovieID = "3Hc1Bqv3crc"
                    }else{
                        MovieID = "xnMzzSbgpQw"
                    }
                    
                    
                    //YouTubeビューおよびテレビのビューを作成
                    let MovieView = CreateYouTubeView(Px: MoviePx, Py: MoviePy, width: Moviewidth, height: Movieheight, MovieID: MovieID)
                    MovieView.backgroundColor = .clear
                    NextView.addSubview(MovieView)
                    let TVImage = CreateImageView(ImageName: "MTV", Px: TVPx, Py: TVPy, width: TVwidth, height: TVheight,TransparentFlag: true)
                    NextView.addSubview(TVImage)
                    
                    //拡大縮小ボタンの作成
                    let ScaleButton = CreateButton(Px: 0, Py: 0, width: 10, YScale: 1, ImageName: "BigButton", ButtonNumber: 10, Option: "bottom_right")
                    ScaleButton.SaveSize = MovieView.frame.size
                    ScaleButton.SavePoint = MovieView.center
                    ScaleButton.SaveView = MovieView
                    ScaleButton.SaveView2 = NextView
                    NextView.addSubview(ScaleButton)
                    
                    //動画再生ビューを閉じるボタンの作成
                    let CloseButton = CreateButton(Px: 34.75, Py: -9, width: 10, YScale: 1, ImageName: "MenuDown", ButtonNumber: 11)
                    CloseButton.SaveView = NextView
                    NextView.addSubview(CloseButton)
                    
                    PlaySE(SEnumber: 20)
                    DelayRun(time: 0.4) {
                        //動画再生ビューを下からスライドさせて表示させる
                        NextView.MoveAnime(MoveX: 0, MoveY: 100, time: 2.0){
                            PView.removeFromSuperview()
                        }
                    }
                }
        
                if Number == 10{ //動画の拡大縮小ボタン
                    if sender.OnFlag{  //縮小する
                        sender.isEnabled = false
                        sender.OnFlag = false
                        sender.SaveView.TransformAnime(Point: sender.SavePoint, Size: sender.SaveSize, time: 0.5) {
                            sender.setImage(UIImage(named: "BigButton"), for: .normal)
                            sender.alpha = 1.0
                            sender.isEnabled = true
                            sender.SaveView2.sendSubviewToBack(sender.SaveView)
                        }
                    }else{  //拡大する
                        sender.isEnabled = false
                        sender.OnFlag = true
                        sender.SaveView2.bringSubviewToFront(sender.SaveView)
                        sender.SaveView2.bringSubviewToFront(sender)
                        sender.SaveView.TransformAnime(MovePX: 0, MovePY: 0, Width: 100, Yscale: 0.5625, time: 0.5) {
                            sender.setImage(UIImage(named: "SmallButton"), for: .normal)
                            sender.alpha = 0.5
                            sender.isEnabled = true
                        }
                    }
                }
                if Number == 11{ //動画再生ビューを閉じる
                    PlaySE(SEnumber: 20)
                    DelayRun(time: 0.4) {
                        sender.SaveView.MoveAnime(MoveX: 0, MoveY: -100, time: 2.0) {
                            sender.SaveView.removeFromSuperview()
                            self.PlayBGM(BGM_Name: "BGM0_1", Volume: 0.5)
                        }
                    }
                }
                
   
                if Number == 12{ //アップデート情報
                    //4¥******アップデート情報
                    PlaySE(SEnumber: 5)
                    SubSystemView[0].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateBackButton())
                    
                    let text = "Var1.0.9\nメニュー機能を追加\nポン吉のアルバム閲覧機能をを追加\nポン吉の動画閲覧機能を追加\n\nVar1.0.8\n練習エリアを追加\n\nVar1.0.7\n氷雪エリアを追加\n\nVar1.0.11\n天空エリアを追加\n\n\n次回実装予定(12月中)\n研究所エリア"
                    let Label = CreateLabel(Px: 0, Py: 0, width: 80, height: 120, FontSize: 3, text: text)
                    nextView.addSubview(Label)
                    
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                
                if Number == 13{ //練習エリアに移動するかを確認するビュー
                    PlaySE(SEnumber: 5)
                    SubSystemView[0].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    let nextView = CreateSyseteView()
                    SubSystemView.append(nextView)
                    nextView.RightPosition()
                    nextView.addSubview(CreateLabel(Px: 0, Py: 15, width: 80, height: 20, FontSize: 4, text: "練習エリアに移動しますか？"))
                    nextView.addSubview(CreateButton(Px: -25, Py: -15, width: 45, height: 15, FontSize: 4, text: "移動する", ButtonNumber: 1))
                    nextView.addSubview(CreateButton(Px: 25, Py: -15, width: 45, height: 15, FontSize: 4, text: "移動しない", ButtonNumber: 2))
                    nextView.addSubview(CreateBackButton())
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                
                //¥¥1他アプリのURL
                if Number == 14 || Number == 15 || (21 <= Number && Number <= 25){ //
                    var AppNumber = "00000000"
                    if Number == 14{
                        AppNumber = "1457372354"
                    }
                    if Number == 15{
                        AppNumber = "1436678056"
                    }
                    if Number == 21{
                        AppNumber = "1506407180"
                    }
                    if let url = URL(string: "https://itunes.apple.com/us/app/itunes-u/id" + AppNumber) {
                        UIApplication.shared.open(url)
                    }
                }
                
                
                if Number == 16{ //ご意見箱の内容入力画面
                    PlaySE(SEnumber: 5)
                    //ビューの作成
                    let nextView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
                    nextView.ClearView()
                    view.addSubview(nextView)
                    nextView.RightPosition()
                    SubSystemView.append(nextView)
                    
                    //ラベルの作成
                    let Label = CreateLabel(Px: 0, Py: 10, width: 80, height: 100, FontSize: 3, text: "")
                    nextView.addSubview(Label)
                    let text = CreateText(Px: 0, Py: 37, width: 80, height: 20, text: "送信内容を書き込んでください。", FontSize: 4, FontColor: .white)
                    nextView.addSubview(text)
                    //テキストボックスの作成
                    let textViewwidth: CGFloat = 72
                    let textViewheight:CGFloat = 50
                    let textViewPx:    CGFloat = 0
                    let textViewPy:    CGFloat = 2
                    let FontSize:       CGFloat = 3
                    let textView = DoneTextView(frame: CGRect(x: 0, y: 0, width: x1 * textViewwidth, height: y1 * textViewheight))
                     //   UITextView(frame: CGRect(x: 0, y: 0, width: x1 * textViewwidth, height: y1 * textViewheight))
                    textView.center = CGPoint(x: x1 * (50 + textViewPx) , y: y1 * (50 - textViewPy) )
                    textView.keyboardType = .default
                    textView.textColor = .white
                    textView.backgroundColor = .gray
                    textView.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
                    textView.returnKeyType = .default
                    nextView.addSubview(textView)
                    textView.delegate = self
                    textView.showsHorizontalScrollIndicator = true
    
                    //送信確認ボタンを作成
                    let Button1 = CreateButton(Px: 0, Py: -40, width: 70, height: 20, FontSize: 4, text: "送信内容の確認", ButtonNumber: 17)
                    Button1.SavetextView = textView
                    nextView.addSubview(Button1)
                    
                    //バックボタンの作成
                    nextView.addSubview(CreateBackButton())
                    
                    PlaySE(SEnumber: 5)
                    SubSystemView[0].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
                
                if Number == 17 { //ご意見箱の送信内容の確認
                    //ビューの作成
                    let nextView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
                    nextView.ClearView()
                    view.addSubview(nextView)
                    nextView.RightPosition()
                    SubSystemView.append(nextView)
                    
                    //ボタンの配置
                    let retrunButton = CreateButton(Px: -25, Py: -40, width: 45, height: 15, FontSize: 4, text: "送信内容を修正する", ButtonNumber: 19)
                    let sendButoon = CreateButton(Px: 25, Py: -40, width: 45, height: 15, FontSize: 4, text: "この内容で送信する", ButtonNumber: 18)
                    
                    
                    if let text = sender.SavetextView.text{
                        if text == ""{  //内容が入力されていないと表示する
                            sendButoon.isEnabled = false
                            sendButoon.alpha = 0.5
                        }

                        let Label = CreateLabel(Px: 0, Py: 10, width: 80, height: 100, FontSize: 3, text: "")
                        nextView.addSubview(Label)
                        
                        //テキストボックスの作成
                        let textViewwidth: CGFloat = 72
                        let textViewheight:CGFloat = 65
                        let textViewPx:    CGFloat = 0
                        let textViewPy:    CGFloat = 10
                        let FontSize:      CGFloat = 3
                        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: x1 * textViewwidth, height: y1 * textViewheight))
                        textView.center = CGPoint(x: x1 * (50 + textViewPx) , y: y1 * (50 - textViewPy) )
                        textView.textColor = .white
                        textView.backgroundColor = .clear
                        textView.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
                        textView.isEditable = false
                        textView.text = text
                        nextView.addSubview(textView)
                        
                        sendButoon.SaveText = text
                    }
                    
                    nextView.addSubview(retrunButton)
                    nextView.addSubview(sendButoon)
                    PlaySE(SEnumber: 5)
                    SubSystemView[1].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                    nextView.MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
                }
               
                if Number == 18{ //ご意見箱の内容を送信
                    PlaySE(SEnumber: 21)
                    
                    let text0 = sender.SaveText.replacingOccurrences(of: "\n", with: "<br>")
                    let text1 = "<br><br>" + UIDevice.current.systemName
                    let text2 = UIDevice.current.systemVersion
                    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
                    let text3 = "<br>アプリのバーション" + "\(version)"
                    let text4 = "<br>" + getDeviceInfo()
                    let text = text0 + text1 + text2 + text3 + text4
                    
                    sendMail(text: text)
                    SubSystemViewDelete()
                    SystemMenuView.CenterPosition()
                    view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "送信が完了しました。", ButtonNumber: 100))
                }
                
                if Number == 19 { //ビューを一つ戻る
                    let SCount = SubSystemView.count
                    PlaySE(SEnumber: 5)
                    if SCount == 1{
                        SystemMenuView.MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
                        SubSystemView[0].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5){
                            self.SubSystemView[0].removeFromSuperview()
                            self.SubSystemView.removeAll()
                        }
                    }else if SCount >= 2{
                        SubSystemView[SCount - 2].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
                        SubSystemView[SCount - 1].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5){
                            self.SubSystemView[SCount - 1].removeFromSuperview()
                            self.SubSystemView.removeLast()
                        }
                    }
                }
                
                if Number == 20{//YouTubeのチャンネルの表示
                    if let url = URL(string: "https://www.youtube.com/playlist?list=PLxiWyYdbH_Fkk2NA3jDU3fRlPStKpyIBt") {
                        UIApplication.shared.open(url)
                    }
                }
                
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("Start")
        textView.TransformAnime(MovePX: 0, MovePY: 32, Width: 72, Height: 30, time: 0.1)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("End")
        textView.TransformAnime(MovePX: 0, MovePY: 2, Width: 72, Height: 50, time: 0.1)
    }
    //イメージビューの作成
    func CreateImageView(ImageName:String,Px:CGFloat = 0.0,Py:CGFloat = 0.0 ,width:CGFloat = 100, height:CGFloat = 100,TransparentFlag:Bool = false) -> SKView{
        var View = SKView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        if TransparentFlag{ View = TransparentView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height) ) }
        View.center = CGPoint(x: (50 + Px) * x1, y: (50 - Py) * y1)
        View.backgroundColor = .clear
        
        let Scene = SKScene(size: View.frame.size)
        Scene.backgroundColor = .clear
        View.presentScene(Scene)
        
        let Image = SKSpriteNode(imageNamed: ImageName)
        Image.scale(to: View.frame.size)
        Image.position = CGPoint(x: View.frame.size.width / 2, y: View.frame.size.height / 2)
        Scene.addChild(Image)
        
        return View
    }
    
    func CreateImageView(ImageName:String,width:CGFloat, YScale:CGFloat,Px:CGFloat = 0.0,Py:CGFloat = 0.0,TransparentFlag:Bool = false) -> SKView{
        var View = SKView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: width * x1 * YScale))
        if TransparentFlag{ View = TransparentView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: width * x1 * YScale) ) }
        View.center = CGPoint(x: (50 + Px) * x1, y: (50 - Py) * y1)
        View.backgroundColor = .clear
        
        let Scene = SKScene(size: View.frame.size)
        Scene.backgroundColor = .clear
        View.presentScene(Scene)
        
        let Image = SKSpriteNode(imageNamed: ImageName)
        Image.scale(to: View.frame.size)
        Image.position = CGPoint(x: View.frame.size.width / 2, y: View.frame.size.height / 2)
        Scene.addChild(Image)
        
        return View
    }
    
    func CreateImageView(ImageName:String,height:CGFloat,Xscale:CGFloat,Px:CGFloat = 0.0,Py:CGFloat = 0.0,TransparentFlag:Bool = false) -> SKView{
        var View = SKView(frame: CGRect(x: 0, y: 0, width: x1 * height * Xscale, height: y1 * height))
        if TransparentFlag{ View = TransparentView(frame: CGRect(x: 0, y: 0, width: x1 * height * Xscale, height: y1 * height) ) }
        View.center = CGPoint(x: (50 + Px) * x1, y: (50 - Py) * y1)
        View.backgroundColor = .clear
        
        let Scene = SKScene(size: View.frame.size)
        Scene.backgroundColor = .clear
        View.presentScene(Scene)
        
        let Image = SKSpriteNode(imageNamed: ImageName)
        Image.scale(to: View.frame.size)
        Image.position = CGPoint(x: View.frame.size.width / 2, y: View.frame.size.height / 2)
        Scene.addChild(Image)
        
        return View
    }
    
    func CreateYouTubeView(Px:CGFloat,Py:CGFloat,width:CGFloat,height:CGFloat,MovieID:String) -> YTPlayerView{
        let YouTubeView = YTPlayerView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        YouTubeView.center = CGPoint(x: (50 + Px) * x1, y: (50 - Py) * y1)
        YouTubeView.delegate = self
        YouTubeView.load(withVideoId: MovieID, playerVars: ["playsinline":1])
        return YouTubeView
    }
    
    func CreateYouTubeView(Px:CGFloat,Py:CGFloat,width:CGFloat,height:CGFloat,PlayListID:String) -> YTPlayerView{
        let YouTubeView = YTPlayerView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        YouTubeView.center = CGPoint(x: (50 + Px) * x1, y: (50 - Py) * y1)
        YouTubeView.delegate = self
        YouTubeView.load(withPlaylistId: PlayListID, playerVars:["playsinline":1])
        return YouTubeView
    }
    
    func CreateAlbumView(){
        var PageMax = (PictureCount - 1) / 6
        if PictureFlag.count % 6 != 0{ PageMax += 1 }
        let PViewSize: CGFloat = 25.4
        let PViewDx: CGFloat = 32.6
        let PViewDy: CGFloat = 35.4
        let PViewFDy: CGFloat = 25
        AlbumPage = 1
        for Page in 1 ... PageMax{
            let nextView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h) )
            SubSystemView.append(nextView)
            nextView.RightPosition()
            let Scene = SKScene(size: CGSize(width: w, height: h))
            let BG = SKSpriteNode(imageNamed: "Album")
            BG.scale(to: CGSize(width: w, height: h))
            BG.position = CGPoint(x: w / 2, y: h / 2)
            Scene.addChild(BG)
            nextView.presentScene(Scene)
            view.addSubview(nextView)
            
            if Page != 1{ nextView.addSubview( CreatePBackButton() ) }
            if Page != PageMax { nextView.addSubview( CreatePNextButton() ) }
            nextView.addSubview(CreatePCloseButton())
            for yi in 0 ... 1{
                for xi in -1 ... 1{
                    let xn = CGFloat(xi)
                    let yn = CGFloat(yi)
                    let PView = SKView(frame: CGRect(x: 0, y: 0, width: x1 * PViewSize, height: y1 * PViewSize))
                    PView.center = CGPoint(x: x1 * (50 + xn * PViewDx), y: y1 * (100 - PViewFDy + PViewDy * (yn - 1.0) ))
                    nextView.addSubview(PView)
                    PictureView.append(PView)
                    let PictureNumber = PictureView.count
                    let PScene = SKScene(size: CGSize(width: x1 * PViewSize, height: y1 * PViewSize))
                    PView.presentScene(PScene)
                    
                    var PictureName: String = "NoPicture"
                    if PictureFlag[PictureNumber] { PictureName = "P\(PictureNumber)" }
                    let Picture = SKSpriteNode(imageNamed: PictureName)
                    Picture.scale(to: CGSize(width: x1 * PViewSize, height: x1 * PViewSize * 3 / 4))
                    Picture.position = CGPoint(x: x1 * PViewSize / 2, y: y1 * PViewSize / 2)
                    PScene.addChild(Picture)
                    
                    let PButton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 * PViewSize, height: y1 * PViewSize))
                    PictureButton.append(PButton)
                    PButton.center = CGPoint(x: x1 * PViewSize / 2, y: y1 * PViewSize / 2)
                    PButton.backgroundColor = .clear
                    PButton.addTarget(self, action: #selector(firstVC.AlbumButton(_:)), for: .touchUpInside)
                    PButton.accessibilityValue = String(PictureNumber)
                    PView.addSubview(PButton)
                }
            }
        }
    }
    
 
    func sendMail(text:String){
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.port = 465
        smtpSession.username = "pongame1127@gmail.com"
        smtpSession.password = "tyuke1127"
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.TLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "ポン吉", mailbox: "PonGames11@gmail.com") as Any]
        builder.header.from = MCOAddress(displayName: "ポン吉の大冒険 ご意見箱", mailbox: "ponkiti27@gmail.com")
        builder.header.subject = "ポン吉の大冒険のご意見箱"
        builder.htmlBody = text
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data!)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(String(describing: error))")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
    
//アルバムビューのバックボタンの作成
    func CreatePBackButton() -> UIButton{
        let ButtonSize: CGFloat = 8                 //ボタンのサイズ(画面横の百分率)
        let ButtonPositionX:CGFloat = 20            //ボタンの位置(画面左上が基準_画面横百分率)
        let ButtonPositionY:CGFloat = 6             //ボタンの位置(画面左上が基準_画面横百分率)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: ButtonPositionX * x1, y: ButtonPositionY * x1)
        Button.setBackgroundImage(UIImage(named: "MenuBack"), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.PViewBack(_:)), for: .touchUpInside)
        return Button
    }
    @objc func PViewBack(_ sender :UIButton){
        PlaySE(SEnumber: 5)
        SubSystemView[AlbumPage - 1].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
        SubSystemView[AlbumPage - 2].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
        AlbumPage -= 1
    }

    //アルバムビューの次のページへ移動ボタンの作成
    func CreatePNextButton() -> UIButton{
        let ButtonSize: CGFloat = 8                 //ボタンのサイズ(画面横の百分率)
        let ButtonPosition:CGFloat = 6              //ボタンの位置(画面左上が基準_画面横百分率)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: w - (ButtonPosition + ButtonSize) * x1, y: ButtonPosition * x1)
        Button.setBackgroundImage(UIImage(named: "MenuNext"), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.PViewNext(_:)), for: .touchUpInside)
        return Button
    }
    @objc func PViewNext(_ sender :UIButton){
        PlaySE(SEnumber: 5)
        SubSystemView[AlbumPage - 1].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
        SubSystemView[AlbumPage].MoveAnime(MoveX: -100, MoveY: 0, time: 0.5)
        AlbumPage += 1
    }
    
    func DelayRun(time:Double, run:@escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + time){
            run()
        }
    }
    
    func CreateDeleteViewButton(deleteView: UIView) -> CustomButton{
        let ButtonSize:CGFloat = 8                  //メニューを消すボタンのサイズ(画面横の百分率)
        let ButtonPosition:CGFloat = 6              //メニューを消すボタンの位置(画面左上が基準_画面横百分率)
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: ButtonPosition * x1, y: ButtonPosition * x1)
        Button.setBackgroundImage(UIImage(named: "MenuClose"), for: .normal)
        Button.SaveView = deleteView
        Button.addTarget(self, action: #selector(firstVC.DeleteView(_:)), for: .touchUpInside)
        return Button
    }
    @objc func DeleteView(_ sender :CustomButton){
        PlaySE(SEnumber: 12)
        sender.SaveView.removeFromSuperview()
    }
    
    func CreateBackViewButton(BackView1: UIView,BackView2: UIView) -> CustomButton{
        let ButtonSize:CGFloat = 8                  //メニューを消すボタンのサイズ(画面横の百分率)
        let ButtonPosition:CGFloat = 6              //メニューを消すボタンの位置(画面左上が基準_画面横百分率)
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: ButtonPosition * x1, y: ButtonPosition * x1)
        Button.setBackgroundImage(UIImage(named: "MenuBack"), for: .normal)
        Button.SaveView = BackView1
        Button.SaveView2 = BackView2
        Button.addTarget(self, action: #selector(firstVC.BackView(_:)), for: .touchUpInside)
        return Button
    }
    @objc func BackView(_ sender :CustomButton){
        PlaySE(SEnumber: 12)
        PlaySE(SEnumber: 5)
        sender.SaveView.MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
        sender.SaveView2.MoveAnime(MoveX: 100, MoveY: 0, time: 0.5){
            sender.SaveView2.removeFromSuperview()
        }
    }
    
    //アルバムビューを閉じるボタンの作成
    func CreatePCloseButton() -> UIButton{
        let ButtonSize:CGFloat = 8                  //メニューを消すボタンのサイズ(画面横の百分率)
        let ButtonPosition:CGFloat = 6              //メニューを消すボタンの位置(画面左上が基準_画面横百分率)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: ButtonPosition * x1, y: ButtonPosition * x1)
        Button.setBackgroundImage(UIImage(named: "MenuClose"), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.PViewClose(_:)), for: .touchUpInside)
        return Button
    }
    
    @objc func PViewClose(_ sender :UIButton){
        PlaySE(SEnumber: 12)
        SubSystemViewDelete()
        for n in 0 ..< PictureView.count{ PictureView[n].removeFromSuperview() }
        PictureView.removeAll()
        for n in 0 ..< PictureButton.count{ PictureButton[n].removeFromSuperview() }
        PictureButton.removeAll()
        for n in 0 ..< PictureTapFlag.count{ PictureTapFlag[n] = false }
    }
    
    //サブシステムビューを閉じるボタンの作成
    func CreateSubSystemCloseButton() -> UIButton{
        let ButtonSize:CGFloat = 8                  //メニューを消すボタンのサイズ(画面横の百分率)
        let ButtonPosition:CGFloat = 6              //メニューを消すボタンの位置(画面左上が基準_画面横百分率)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: ButtonPosition * x1, y: ButtonPosition * x1)
        Button.setBackgroundImage(UIImage(named: "MenuClose"), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.SubSystemClose(_:)), for: .touchUpInside)
        return Button
    }
    @objc func SubSystemClose(_ sender :UIButton){
        PlaySE(SEnumber: 12)
        SubSystemViewDelete()
    }
    
    
    @objc func AlbumButton(_ sender: UIButton){
        PlaySE(SEnumber: 6)
        let Size: CGFloat = 25.4
        var Position: [CGPoint] = []
        Position.append( CGPoint(x: -32.6, y: 10.4) )
        Position.append( CGPoint(x: 0, y: 10.4) )
        Position.append( CGPoint(x: 32.6, y: 10.4) )
        Position.append( CGPoint(x: -32.6, y: -25) )
        Position.append( CGPoint(x: 0, y: -25) )
        Position.append( CGPoint(x: 32.6, y: -25) )
        let time = 0.2
        if let Name = sender.accessibilityValue{
            if let Number = Int(Name){
                let Page = (Number - 1) / 6
                let PNumber = (Number - 1) % 6 + 1
                if PictureTapFlag[Number - 1]{
                    PictureTapFlag[Number - 1] = false
                    PictureView[Number - 1].TransformAnime(MovePX: Position[PNumber - 1].x, MovePY: Position[PNumber - 1].y, Width: Size, Height: Size, time: time)
                    PictureButton[Number - 1].ScaleAnime(Width: Size, Height: Size, time: time)
                }else{
                    PictureTapFlag[Number - 1] = true
                    PictureView[Number - 1].TransformAnime(MovePX: 0, MovePY: 0, Width: 100, Height: 100, time: time)
                    PictureButton[Number - 1].ScaleAnime(Width: 100, Height: 100, time: time)
                }
                SubSystemView[Page].bringSubviewToFront(PictureView[Number - 1])
            }
        }
    }
    
    //システムビューの透過バーションを作成
    func CreateSyseteView() -> SKView{
        let SView = SystemView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        SView.ClearView()
        view.addSubview(SView)
        return SView
    }
    //¥¥スクロールビュー作成
    func CreateScrollSyseteView() -> UIView{
      //  let SView = SystemScrollView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        let SView = UIScrollView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        SView.contentSize = CGSize(width: w, height: 1.5 * h)
        view.addSubview(SView)
        
      //  let ContentView = UIView(frame: CGRect(x: 0, y: h, width: w, height: 1.5 * h))
        
      //  SView.addSubview(ContentView)
        
        return SView
    }

    //システム用のボタンを作成(中心基準_標準画像)
    func CreateButton(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat ,FontSize:CGFloat,text:String,ButtonNumber n1:Int) -> CustomButton{
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        Button.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        Button.setBackgroundImage(UIImage(named: "MenuButton"), for: .normal)
        Button.setTitle(text, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(.white, for: .normal)
        return Button
    }
    //システム用のボタンを作成(中心基準_任意のイメージのボタン)
    func CreateButton(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat ,ImageName:String,FontSize:CGFloat,text:String,ButtonNumber n1:Int,textColor:UIColor = .white) -> CustomButton{
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        Button.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        Button.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        Button.setTitle(text, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(textColor, for: .normal)
        return Button
    }
    func CreateButton(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,YScale:CGFloat ,ImageName:String,FontSize:CGFloat,text:String,ButtonNumber n1:Int,textColor:UIColor = .white) -> CustomButton{
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: x1 * width, height: x1 * width * YScale))
        Button.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        Button.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        Button.setTitle(text, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(textColor, for: .normal)
        return Button
    }
    func CreateButton(Px:CGFloat ,Py:CGFloat ,height:CGFloat ,XScale:CGFloat ,ImageName:String,FontSize:CGFloat,text:String,ButtonNumber n1:Int,textColor:UIColor = .white) -> CustomButton{
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: y1 * height * XScale, height: y1 * height))
        Button.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        Button.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        Button.setTitle(text, for: .normal)
        Button.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(textColor, for: .normal)
        return Button
    }
    func CreateButton(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat ,ImageName:String,ButtonNumber n1:Int,Option:String = "no") -> CustomButton{
        let Size = CGSize(width: width * x1, height: height * y1)
        var Point: CGPoint!
        if  Option != "no"{ Point = Size.CGPointCalculation(OptionName: Option) }
        else{ Point = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py)) }
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: Size.width, height: Size.height))
        Button.center = Point
        Button.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(.white, for: .normal)
        return Button
    }
    func CreateButton(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,YScale:CGFloat ,ImageName:String,ButtonNumber n1:Int,Option:String = "no") -> CustomButton{
        let Size = CGSize(width: width * x1, height: x1 * width * YScale)
        var Point: CGPoint!
        if  Option != "no"{ Point = Size.CGPointCalculation(OptionName: Option) }
        else              { Point = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py)) }
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: Size.width, height: Size.height))
        Button.center = Point
        Button.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(.white, for: .normal)
        return Button
    }
    func CreateButton(Px:CGFloat ,Py:CGFloat ,height:CGFloat ,XScale:CGFloat ,ImageName:String,ButtonNumber n1:Int,Option:String = "no") -> CustomButton{
        let Size = CGSize(width: height * x1 * XScale, height: height * y1)
        var Point: CGPoint!
        if  Option != "no"{ Point = Size.CGPointCalculation(OptionName: Option) }
        else{ Point = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py)) }
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: Size.width, height: Size.height))
        Button.center = Point
        Button.setBackgroundImage(UIImage(named: ImageName), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        Button.setTitleColor(.white, for: .normal)
        return Button
    }
    func CreateClearButton(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat,ButtonNumber n1:Int,Option:String = "no") -> CustomButton{
        let Size = CGSize(width: width * x1, height: height * y1)
        var Point: CGPoint!
        if  Option != "no"{ Point = Size.CGPointCalculation(OptionName: Option) }
        else{ Point = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py)) }
        let Button = CustomButton(frame: CGRect(x: 0, y: 0, width: Size.width, height: Size.height))
        Button.center = Point
        Button.backgroundColor = .clear
        Button.addTarget(self, action: #selector(firstVC.SystemButton(_:)), for: .touchUpInside)
        Button.accessibilityValue = String(n1)
        return Button
    }
    //システムラベルを作成(中心基準)
    func CreateLabel(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat ,FontSize:CGFloat,text:String) -> SKView{
        let LabelView = SKView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        LabelView.backgroundColor = .clear
        LabelView.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        
        let VSize = LabelView.frame.size
        let Scene = SKScene(size: LabelView.frame.size)
        Scene.backgroundColor = .clear
        let BackImage = SKSpriteNode(imageNamed: "MenuLabel")
        BackImage.scale(to: LabelView.frame.size)
        BackImage.position = CGPoint(x: VSize.width / 2, y: VSize.height / 2)
        Scene.addChild(BackImage)
        
        let Label = SKLabelNode(text: text)
        Label.position = CGPoint(x: VSize.width / 2, y: VSize.height / 2)
        Label.fontName = "Ronde-B"
        Label.fontSize = x1 * FontSize
        Label.color = .white
        Label.verticalAlignmentMode = .center
        Label.numberOfLines = -1
        Label.preferredMaxLayoutWidth = x1 * width * 0.9
        
        Scene.addChild(Label)
        LabelView.presentScene(Scene)
        return LabelView
    }
    
    func CreateLabel(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat ,FontSize:CGFloat,text:String,ImageName:String) -> SKView{
        let LabelView = SKView(frame: CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height))
        LabelView.backgroundColor = .clear
        LabelView.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        let VSize = LabelView.frame.size
        let Scene = SKScene(size: LabelView.frame.size)
        Scene.backgroundColor = .clear
        let BackImage = SKSpriteNode(imageNamed: ImageName)
        BackImage.scale(to: LabelView.frame.size)
        BackImage.position = CGPoint(x: VSize.width / 2, y: VSize.height / 2)
        Scene.addChild(BackImage)
        let Label = SKLabelNode(text: text)
        Label.position = CGPoint(x: VSize.width / 2, y: VSize.height / 2)
        Label.fontName = "Ronde-B"
        Label.fontSize = x1 * FontSize
        Label.color = .white
        
        Label.verticalAlignmentMode = .center
        Label.numberOfLines = -1
        Label.preferredMaxLayoutWidth = x1 * width * 0.9
        
        Scene.addChild(Label)
        LabelView.presentScene(Scene)
        return LabelView
    }
    
    func CreateText(Px:CGFloat ,Py:CGFloat ,width:CGFloat ,height:CGFloat,text:String ,FontSize:CGFloat, FontColor:UIColor) -> UILabel{
        let Text = UILabel()
        Text.text = text
        Text.frame = CGRect(x: 0, y: 0, width: x1 * width, height: y1 * height)
        Text.center = CGPoint(x: x1 * (Px + 50), y: y1 * (50 - Py))
        Text.textColor = FontColor
        Text.textAlignment = NSTextAlignment.center
        Text.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        return Text
    }
    
    func CreateBackButton() -> UIButton{
        let ButtonSize: CGFloat = 8                 //ボタンのサイズ(画面横の百分率)
        let ButtonPosition:CGFloat = 6              //ボタンの位置(画面左上が基準_画面横百分率)
        let Button = UIButton(frame: CGRect(x: 0, y: 0, width: ButtonSize * x1, height: ButtonSize * x1))
        Button.center = CGPoint(x: ButtonPosition * x1, y: ButtonPosition * x1)
        Button.setBackgroundImage(UIImage(named: "MenuBack"), for: .normal)
        Button.addTarget(self, action: #selector(firstVC.SystemBack(_:)), for: .touchUpInside)
        return Button
    }
    @objc func SystemBack(_ sender :UIButton){
        let SCount = SubSystemView.count
        PlaySE(SEnumber: 5)
        if SCount == 1{
            SystemMenuView.MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
            SubSystemView[0].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5){
                self.SubSystemView[0].removeFromSuperview()
                self.SubSystemView.removeAll()
            }
        }else if SCount >= 2{
            SubSystemView[SCount - 2].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5)
            SubSystemView[SCount - 1].MoveAnime(MoveX: 100, MoveY: 0, time: 0.5){
                self.SubSystemView[SCount - 1].removeFromSuperview()
                self.SubSystemView.removeLast()
            }
        }
    }
    

    func SubSystemViewDelete(){
        for n in 0 ..< SubSystemView.count{ SubSystemView[n].removeFromSuperview() }
        SubSystemView.removeAll()
    }
    
    func getDeviceInfo () -> String{
        var size : Int = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0, count: Int(size))
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let code:String = String(cString:machine)
        
        let deviceCodeDic:[String:String] = [
            /* Simulator */
            "i386"      :"Simulator",
            "x86_64"    :"Simulator",
            /* iPod */
            "iPod1,1"   :"iPod Touch 1st",            // iPod Touch 1st Generation
            "iPod2,1"   :"iPod Touch 2nd",            // iPod Touch 2nd Generation
            "iPod3,1"   :"iPod Touch 3rd",            // iPod Touch 3rd Generation
            "iPod4,1"   :"iPod Touch 4th",            // iPod Touch 4th Generation
            "iPod5,1"   :"iPod Touch 5th",            // iPod Touch 5th Generation
            "iPod7,1"   :"iPod Touch 6th",            // iPod Touch 6th Generation
            /* iPhone */
            "iPhone1,1"   :"iPhone 2G",                 // iPhone 2G
            "iPhone1,2"   :"iPhone 3G",                 // iPhone 3G
            "iPhone2,1"   :"iPhone 3GS",                // iPhone 3GS
            "iPhone3,1"   :"iPhone 4",                  // iPhone 4 GSM
            "iPhone3,2"   :"iPhone 4",                  // iPhone 4 GSM 2012
            "iPhone3,3"   :"iPhone 4",                  // iPhone 4 CDMA For Verizon,Sprint
            "iPhone4,1"   :"iPhone 4S",                 // iPhone 4S
            "iPhone5,1"   :"iPhone 5",                  // iPhone 5 GSM
            "iPhone5,2"   :"iPhone 5",                  // iPhone 5 Global
            "iPhone5,3"   :"iPhone 5c",                 // iPhone 5c GSM
            "iPhone5,4"   :"iPhone 5c",                 // iPhone 5c Global
            "iPhone6,1"   :"iPhone 5s",                 // iPhone 5s GSM
            "iPhone6,2"   :"iPhone 5s",                 // iPhone 5s Global
            "iPhone7,1"   :"iPhone 6 Plus",             // iPhone 6 Plus
            "iPhone7,2"   :"iPhone 6",                  // iPhone 6
            "iPhone8,1"   :"iPhone 6S",                 // iPhone 6S
            "iPhone8,2"   :"iPhone 6S Plus",            // iPhone 6S Plus
            "iPhone8,4"   :"iPhone SE" ,                // iPhone SE
            "iPhone9,1"   :"iPhone 7",                  // iPhone 7 A1660,A1779,A1780
            "iPhone9,3"   :"iPhone 7",                  // iPhone 7 A1778
            "iPhone9,2"   :"iPhone 7 Plus",             // iPhone 7 Plus A1661,A1785,A1786
            "iPhone9,4"   :"iPhone 7 Plus",             // iPhone 7 Plus A1784
            "iPhone10,1"  :"iPhone 8",                  // iPhone 8 A1863,A1906,A1907
            "iPhone10,4"  :"iPhone 8",                  // iPhone 8 A1905
            "iPhone10,2"  :"iPhone 8 Plus",             // iPhone 8 Plus A1864,A1898,A1899
            "iPhone10,5"  :"iPhone 8 Plus",             // iPhone 8 Plus A1897
            "iPhone10,3"  :"iPhone X",                  // iPhone X A1865,A1902
            "iPhone10,6"  :"iPhone X",                  // iPhone X A1901
            "iPhone11,8"  :"iPhone XR",                 // iPhone XR A1984,A2105,A2106,A2108
            "iPhone11,2"  :"iPhone XS",                 // iPhone XS A2097,A2098
            "iPhone11,4"  :"iPhone XS Max",             // iPhone XS Max A1921,A2103
            "iPhone11,6"  :"iPhone XS Max",             // iPhone XS Max A2104
            
            /* iPad */
            "iPad1,1"   :"iPad 1 ",                     // iPad 1
            "iPad2,1"   :"iPad 2 WiFi",                 // iPad 2
            "iPad2,2"   :"iPad 2 Cell",                 // iPad 2 GSM
            "iPad2,3"   :"iPad 2 Cell",                 // iPad 2 CDMA (Cellular)
            "iPad2,4"   :"iPad 2 WiFi",                 // iPad 2 Mid2012
            "iPad2,5"   :"iPad Mini WiFi",              // iPad Mini WiFi
            "iPad2,6"   :"iPad Mini Cell",              // iPad Mini GSM (Cellular)
            "iPad2,7"   :"iPad Mini Cell",              // iPad Mini Global (Cellular)
            "iPad3,1"   :"iPad 3 WiFi",                 // iPad 3 WiFi
            "iPad3,2"   :"iPad 3 Cell",                 // iPad 3 CDMA (Cellular)
            "iPad3,3"   :"iPad 3 Cell",                 // iPad 3 GSM (Cellular)
            "iPad3,4"   :"iPad 4 WiFi",                 // iPad 4 WiFi
            "iPad3,5"   :"iPad 4 Cell",                 // iPad 4 GSM (Cellular)
            "iPad3,6"   :"iPad 4 Cell",                 // iPad 4 Global (Cellular)
            "iPad4,1"   :"iPad Air WiFi",               // iPad Air WiFi
            "iPad4,2"   :"iPad Air Cell",               // iPad Air Cellular
            "iPad4,3"   :"iPad Air China",              // iPad Air ChinaModel
            "iPad4,4"   :"iPad Mini 2 WiFi",            // iPad mini 2 WiFi
            "iPad4,5"   :"iPad Mini 2 Cell",            // iPad mini 2 Cellular
            "iPad4,6"   :"iPad Mini 2 China",           // iPad mini 2 ChinaModel
            "iPad4,7"   :"iPad Mini 3 WiFi",            // iPad mini 3 WiFi
            "iPad4,8"   :"iPad Mini 3 Cell",            // iPad mini 3 Cellular
            "iPad4,9"   :"iPad Mini 3 China",           // iPad mini 3 ChinaModel
            "iPad5,1"   :"iPad Mini 4 WiFi",            // iPad Mini 4 WiFi
            "iPad5,2"   :"iPad Mini 4 Cell",            // iPad Mini 4 Cellular
            "iPad5,3"   :"iPad Air 2 WiFi",             // iPad Air 2 WiFi
            "iPad5,4"   :"iPad Air 2 Cell",             // iPad Air 2 Cellular
            "iPad6,3"   :"iPad Pro 9.7inch WiFi",       // iPad Pro 9.7inch WiFi
            "iPad6,4"   :"iPad Pro 9.7inch Cell",       // iPad Pro 9.7inch Cellular
            "iPad6,7"   :"iPad Pro 12.9inch WiFi",      // iPad Pro 12.9inch WiFi
            "iPad6,8"   :"iPad Pro 12.9inch Cell",      // iPad Pro 12.9inch Cellular
            "iPad6,11"  :"iPad 5th",                    // iPad 5th Generation WiFi
            "iPad6,12"  :"iPad 5th",                    // iPad 5th Generation Cellular
            "iPad7,1"   :"iPad Pro 12.9inch 2nd",       // iPad Pro 12.9inch 2nd Generation WiFi
            "iPad7,2"   :"iPad Pro 12.9inch 2nd",       // iPad Pro 12.9inch 2nd Generation Cellular
            "iPad7,3"   :"iPad Pro 10.5inch",           // iPad Pro 10.5inch A1701 WiFi
            "iPad7,4"   :"iPad Pro 10.5inch",           // iPad Pro 10.5inch A1709 Cellular
            "iPad7,5"   :"iPad 6th",                    // iPad 6th Generation WiFi
            "iPad7,6"   :"iPad 6th",                     // iPad 6th Generation Cellular
            "iPad8,1"   :"iPad Pro 11inch WiFi",        // iPad Pro 11inch WiFi
            "iPad8,2"   :"iPad Pro 11inch WiFi",        // iPad Pro 11inch WiFi
            "iPad8,3"   :"iPad Pro 11inch Cell",        // iPad Pro 11inch Cellular
            "iPad8,4"   :"iPad Pro 11inch Cell",        // iPad Pro 11inch Cellular
            "iPad8,5"   :"iPad Pro 12.9inch WiFi",      // iPad Pro 12.9inch WiFi
            "iPad8,6"   :"iPad Pro 12.9inch WiFi",      // iPad Pro 12.9inch WiFi
            "iPad8,7"   :"iPad Pro 12.9inch Cell",      // iPad Pro 12.9inch Cellular
            "iPad8,8"   :"iPad Pro 12.9inch Cell",      // iPad Pro 12.9inch Cellular
            "iPad11,1"  :"iPad Mini 5th WiFi",          // iPad mini 5th WiFi
            "iPad11,2"  :"iPad Mini 5th Cell",          // iPad mini 5th Cellular
            "iPad11,3"  :"iPad Air 3rd WiFi",           // iPad Air 3rd generation WiFi
            "iPad11,4"  :"iPad Air 3rd Cell"            // iPad Air 3rd generation Cellular
        ]
        
        if let deviceName = deviceCodeDic[code] {
            return deviceName
        }else{
            if code.range(of: "iPod") != nil {
                return "iPod Touch"
            }else if code.range(of: "iPad") != nil {
                return "iPad"
            }else if code.range(of: "iPhone") != nil {
                return "iPhone"
            }else{
                return "unknownDevice"
            }
        }
    }
    
    //4¥ゲームのクリア状況を操作する関数 (デバック用)
    func GameFlagControll(){
        //ステージクリア状況
        //範囲指定
        let SCN1:[Int] = [1,34]
        for n in SCN1[0] ... SCN1[1]{
            UserDefaults.standard.set(1, forKey: "stageclear\(n)")
        }
        //個別指定
    
        //スキル習得状況
        //範囲指定
        let SN1:[Int] = [1,8]
        for n in SN1[0] ... SN1[1]{
            UserDefaults.standard.set(true, forKey:"SkillGet\(n)")
        }
        //個別指定
        UserDefaults.standard.set(true, forKey:"SkillGet14")
        UserDefaults.standard.set(true, forKey:"SkillGet15")
        
        //クリアアイテム取得状況
        //範囲指定
        let CIN1:[Int] = [1,5]
        for n in CIN1[0] ... CIN1[1]{
            UserDefaults.standard.set(true, forKey: "ClearItemn\(n)")
        }
        //個別指定
    }
    
    //4¥プレイヤーのスキル状況の読み込み
    func ReadPlayerSkill(){
        for n in 1...20{
            PSGet[n] = UserDefaults.standard.bool(forKey: "SkillGet\(n)")
            PSOn[n] = UserDefaults.standard.bool(forKey: "SkillOn\(n)")
            CFitemF[n] = UserDefaults.standard.bool(forKey: "ClearItemn\(n)")   //クリアアイテムのし取得状況
        }
        HAType = UserDefaults.standard.integer(forKey: "HAType")
    }
    
    //ステージ再開時のスキル状況反映用関数
    func SkillTake() -> [Bool] { return PSOn   }
    func SkillGTake() -> [Bool]{ return PSGet  }
    func HSkillTake() -> Int   { return HAType }
    func PraSkillTake() -> [Bool]{ return PraPSOn }
    func PraSkillGTake() -> [Bool]{ return PraPSGet }
    func PraHSkillTake() -> Int{ return PraHAType }
    
    //練習ステージのスキル状況をて適応させる関数
    func SetPractice(PracticeFlag:Bool){ Practice = PracticeFlag }
    func SetPraSkillON(PraSkillOn: [Bool]) { PraPSOn = PraSkillOn }
    func SetPraSkillGet(PraSkillGet: [Bool]) { PraPSGet = PraSkillGet }
    func SetPraHoldA(PraHoldAType: Int) { PraHAType = PraHoldAType }
    
    //4¥表示ビューの準備
    //タイトルビュー、ロードビュー、ステージビュー、インターフェイスビューの変更しない部分の作成
    func SetUpView(){
        
        //タイトルビューの作成と追加
        titleView = SKView(frame: view.frame) ;view.addSubview(titleView)
        //ステージビューの作成と追加
        stageView = SKView(frame: view.frame) ;view.addSubview(stageView)
        //ステージインターファイスの作成と追加
        stageFrontView = TransparentView(frame: view.frame)
        stageFrontView.ClearView();view.addSubview(stageFrontView)

        
        //タイトルビュー
        let StartBS: CGFloat = 8          //スタートボタンのサイズ
        let StartBP: [CGFloat] = [90,15]  //スタートボタンの位置
        let BookBS: CGFloat = 15          //説明ビュー表示ボタンのサイズ
        let BookBP: [CGFloat] = [8,10]    //説明ビュー表示ボタンの位置
        let helpBS: CGFloat = 10          //ヘルプ表示ボタンのサイズ
        let helpBP: [CGFloat] = [5,92]    //ヘルプ表示ボタンの位置
        
        let diffTS: [CGFloat] = [20,10]   //難易度ラベルのサイズ
        let diffTP: [CGFloat] = [20,92]   //難易度ラベルの位置
        let diffBS: [CGFloat] = [20,10]   //難易度変更ボタンのサイズ
        let diffBP: [CGFloat] = [35,92]   //難易度変更ボタンの位置
        let cathTS: [CGFloat] = [20,10]   //猫の手ラベルのサイズ
        let cathTP: [CGFloat] = [60,92]   //猫の手ラベルの位置
        let cathBS: [CGFloat] = [20,10]   //猫の手ボタンのサイズ
        let cathBP: [CGFloat] = [75,92]   //猫の手ボタンの位置
        let FontSize: CGFloat = 5
        let SMenuBS: [CGFloat] = [13,13]  //システムメニューを開くボタンのサイズ
        let SMenuBP: [CGFloat] = [95,92]  //システムメニューを開くボタンの位置
        
     //   let moneyBS: [CGFloat] = [10,12]  //課金ボタンのサイズ
     //   let moneyBP: [CGFloat] = [95,92]  //課金ボタンの位置
        
                                        //カ　　　　タ　　　　蔵　　　　ソ　　　　目　　　　扇　　　　テ
        let ButtonS: [CGFloat]   = [     12,     15,    10,     16,      7,     10,     15]
        let ButtonP: [[CGFloat]] = [[50, 8],[16,32],[67,28],[50,36],[23, 8],[32,23],[85, 37]]
        
        let diffLabel = UILabel()
        diffLabel.frame = CGRect(x: 0, y: 0, width: x1 * diffTS[0], height: y1 * diffTS[1])
        diffLabel.center = CGPoint(x: x1 * diffTP[0], y: h - y1 * diffTP[1])
        diffLabel.text = "難易度"
        diffLabel.textColor = .black
        diffLabel.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        titleView.addSubview(diffLabel)
        
        let diffButton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 * diffBS[0], height: y1 *  diffBS[1]))
        diffButton.center = CGPoint(x: x1 * diffBP[0], y: h - y1 * diffBP[1])
        if difficulty == 0{
            diffButton.backgroundColor = .green
            diffButton.setTitle("Normal", for: .normal)
        }else if difficulty == 1{
            diffButton.backgroundColor = .magenta
            diffButton.setTitle("Hard", for: .normal)
        }
        diffButton.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        diffButton.addTarget(self, action: #selector(firstVC.difficutyB(_:)), for: .touchUpInside)
        diffButton.setTitleColor(.white, for: .normal)
        diffButton.layer.borderColor = UIColor.cyan.cgColor
        diffButton.layer.borderWidth = x1 * 0.5
        diffButton.layer.cornerRadius = y1 * diffBS[1] / 2
        titleView.addSubview(diffButton)
        
        let cathLabel = UILabel()
        cathLabel.frame = CGRect(x: 0, y: 0, width: x1 * cathTS[0], height: y1 * cathTS[1])
        cathLabel.center = CGPoint(x: x1 * cathTP[0], y: h - y1 * cathTP[1])
        cathLabel.text = "猫の手"
        cathLabel.textColor = .black
        cathLabel.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        titleView.addSubview(cathLabel)
        
        let cathButton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 * cathBS[0], height: y1 *  cathBS[1]))
        cathButton.center = CGPoint(x: x1 * cathBP[0], y: h - y1 * cathBP[1])
        if Pointerflag{
            cathButton.backgroundColor = .red
            cathButton.setTitle("ON", for: .normal)
        }else{
            cathButton.backgroundColor = .blue
            cathButton.setTitle("OFF", for: .normal)
        }
        cathButton.titleLabel?.font = UIFont(name: "Ronde-B", size: x1 * FontSize)
        cathButton.addTarget(self, action: #selector(firstVC.cathandB(_:)), for: .touchUpInside)
        cathButton.setTitleColor(.white, for: .normal)
        cathButton.layer.borderColor = UIColor.cyan.cgColor
        cathButton.layer.borderWidth = x1 * 0.5
        cathButton.layer.cornerRadius = y1 * cathBS[1] / 2
        titleView.addSubview(cathButton)
        
        let SMenuButton = UIButton(frame: CGRect(x: 0, y: 0, width: y1 * SMenuBS[0], height: y1 * SMenuBS[1]))
        SMenuButton.center = CGPoint(x: x1 * SMenuBP[0], y: h - y1 * SMenuBP[1])
        SMenuButton.setBackgroundImage(UIImage(named: "MenuOpen"), for: .normal)
        SMenuButton.addTarget(self, action: #selector(firstVC.SMenuOpen(_:)), for: .touchUpInside)
        titleView.addSubview(SMenuButton)

        let startButton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 * StartBS, height: x1 * StartBS))
        startButton.center = CGPoint(x: StartBP[0] * x1, y: h - StartBP[1] * y1)
        startButton.backgroundColor = .clear
        startButton.addTarget(self, action: #selector(firstVC.StartGame(_:)), for: .touchUpInside)
        startButton.alpha = 0.1
        titleButton.append(startButton)
        titleView.addSubview(startButton)
        
        let bookButton = CustomButton(frame: CGRect(x: 0, y: 0, width: x1 * BookBS, height:x1 * BookBS))
        bookButton.center = CGPoint(x:x1 * BookBP[0], y: h - y1 * BookBP[1])
        bookButton.adjustsImageWhenHighlighted = false
        bookButton.firstImage(imageName: "book01")
        bookButton.changeImage(imageName: "book02")
        bookButton.addTarget(self, action: #selector(firstVC.Howtoplay(_:)), for: .touchUpInside)
        titleButton.append(bookButton)
        titleView.addSubview(bookButton)
        
        let helpButton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 *  helpBS, height: x1 *  helpBS))
        helpButton.center = CGPoint(x: helpBP[0] * x1, y: h - helpBP[1] * y1)
        helpButton.setBackgroundImage(UIImage(named: "help0"), for: .normal)
        helpButton.addTarget(self, action: #selector(firstVC.help(_:)), for: .touchUpInside)
        titleButton.append(helpButton)
        titleView.addSubview(helpButton)
        
        for n in 1...7{
            let Obutton = UIButton(frame: CGRect(x: 0, y: 0, width: x1 * ButtonS[n - 1], height: x1 * ButtonS[n - 1]))
            Obutton.center = CGPoint(x: ButtonP[n - 1][0] * x1, y: h - ButtonP[n - 1][1] * y1)
            Obutton.backgroundColor = .clear
            Obutton.accessibilityValue = String(n)
            Obutton.addTarget(self, action: #selector(firstVC.objectA(_:)), for: .touchUpInside)
            Obutton.alpha = 0.1
            Obutton.isEnabled = false
            titleButton.append(Obutton)
            titleView.addSubview(Obutton)
        }
        MaketitleScene()
        
        //ステージインターファイス
        //一時停止ボタンの作成と追加
        stopButton = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 2, height: h1))
        stageFrontView.addNotTransparentArea(Rect: stopButton.frame)
        stopButton.setImage(UIImage(named: "一時停止"), for: .normal)
        stopButton.addTarget(self, action: #selector(firstVC.stop(_:)), for: .touchUpInside)
        stageFrontView.addSubview(stopButton)
        
        HPgauge = UIProgressView(frame: CGRect(x: 0, y: h1 * 7.85, width: h1 * 2 , height: h1 * 0.25))
        HPgauge.setProgress(1.0, animated: false)
        HPgauge.transform = CGAffineTransform.init(scaleX: 1.0, y: 3.0 * h / 414)
        stageFrontView.addSubview(HPgauge)
        
        MPgauge = UIProgressView(frame: CGRect(x: 0, y: h1 * 8.0, width: h1 * 2 , height: h1 * 0.25))
        MPgauge.setProgress(1.0, animated: false)
        MPgauge.transform = CGAffineTransform.init(scaleX: 1.0, y: 3.0 * h / 414)
        MPgauge.progressTintColor = .green
        stageFrontView.addSubview(MPgauge)
        
        menuButton = UIButton(frame: CGRect(x: 0, y: h1 * 8, width: h1 * 2, height: h1 * 2))
        stageFrontView.addNotTransparentArea(Rect: menuButton.frame)
        menuButton.setImage(UIImage(named: "catS1"), for: .normal)
        menuButton.addTarget(self, action: #selector(firstVC.menuD(_:)), for: .touchUpInside)
        stageFrontView.addSubview(menuButton)
        
        //タイトル画面表示
        displaytitleView()

    }
    //ステージの一時停止
    @objc func stop(_ sender: UIButton){
        playScene[0].isPaused = true
        menuButton.isEnabled = false
        stopButton.isEnabled = false
        PlaySE(SEnumber: 11)
        displayStopView()
    }
    @objc func menuD(_ sender: UIButton){
        playScene[0].isPaused = true
        PlaySE(SEnumber: 11)
        displaymenuView()
    }
    @objc func difficutyB(_ sender: UIButton){
        PlaySE(SEnumber: 9)
        if difficulty == 0{
            difficulty = 1
            UserDefaults.standard.set(1, forKey: "difficulty")
            sender.backgroundColor = .magenta
            sender.setTitle("Hard", for: .normal)
        }else if difficulty == 1{
            difficulty = 0
            UserDefaults.standard.set(0, forKey: "difficulty")
            sender.backgroundColor = .green
            sender.setTitle("Normal", for: .normal)
        }
    }
    @objc func cathandB(_ sender: UIButton){
        PlaySE(SEnumber: 9)
        if Pointerflag{
            Pointerflag = false
            UserDefaults.standard.set(false, forKey: "Pointerflag")
            sender.backgroundColor = .blue
            sender.setTitle("OFF", for: .normal)
        }else{
            Pointerflag = true
            UserDefaults.standard.set(true, forKey: "Pointerflag")
            sender.backgroundColor = .red
            sender.setTitle("ON", for: .normal)
        }
    }
    
    @objc func SMenuOpen(_ sender: UIButton){
        PlaySE(SEnumber: 2)
        displaySystemMenuViwe()
    }

    //4¥タイトル画面のギミック
    @objc func objectA(_ sender: UIButton){
        //タイトルボタンの全ボタンの無効化
        for i in 0..<titleButton.count{
            titleButton[i].isEnabled = false
        }
        let Ftime = 1.0  //立ち姿勢の時間
        var Wtime = 5.0  //歩く時間
        var Atime = 0.0  //アクション時間
        let Ltime = 1.0  //立ち止まる時間
        var Dflag = true //歩く方向
        var zp:CGFloat = 0.0
        var pp:[CGFloat] = [0,0]

        //移動方向と移動時間の設定
        if let name = sender.accessibilityValue{
            if let n = Int(name){
                print(n)
                let BtitileStatas = titleStatas
                titleStatas = n
                if BtitileStatas == 0{ //初期
                    pp = [90,17]
                    zp = 2
                    if titleStatas == 1{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 2{ Wtime = 6.0 ;Dflag = false}
                    if titleStatas == 3{ Wtime = 2.0 ;Dflag = false}
                    if titleStatas == 4{ Wtime = 4.0 ;Dflag = false}
                    if titleStatas == 5{ Wtime = 5.0 ;Dflag = false;zp = 4}
                    if titleStatas == 6{ Wtime = 4.0 ;Dflag = false}
                    if titleStatas == 7{ Wtime = 1.0 ;Dflag = false}
                }
                if BtitileStatas == 1{ //カーペット
                    pp = [50,12]
                    if titleStatas == 2{ Wtime = 3.0 ;Dflag = false;zp = 4}
                    if titleStatas == 3{ Wtime = 3.0 ;Dflag = true;zp = 2}
                    if titleStatas == 4{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 5{ Wtime = 2.0 ;Dflag = false;zp = 4}
                    if titleStatas == 6{ Wtime = 1.0 ;Dflag = false}
                    if titleStatas == 7{ Wtime = 3.0 ;Dflag = true;zp = 2}
                }
                if BtitileStatas == 2{ //タワー
                    zp = 2
                    pp = [25,23]
                    if titleStatas == 1{ Wtime = 3.0 ;Dflag = true ;zp = 4}
                    if titleStatas == 3{ Wtime = 3.0 ;Dflag = true}
                    if titleStatas == 4{ Wtime = 5.0 ;Dflag = true}
                    if titleStatas == 5{ Wtime = 2.0 ;Dflag = true;zp = 4}
                    if titleStatas == 6{ Wtime = 1.0 ;Dflag = true}
                    if titleStatas == 7{ Wtime = 6.0 ;Dflag = true}
                }
                if BtitileStatas == 3{ //蔵
                    zp = 2
                    pp = [65,23]
                    if titleStatas == 1{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 2{ Wtime = 4.0 ;Dflag = false}
                    if titleStatas == 4{ Wtime = 2.0 ;Dflag = false}
                    if titleStatas == 5{ Wtime = 5.0 ;Dflag = false;zp = 4}
                    if titleStatas == 6{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 7{ Wtime = 1.0 ;Dflag = true}
                }
                if BtitileStatas == 4{ //ソファ
                    pp = [50,25]
                    if titleStatas == 1{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 2{ Wtime = 3.0 ;Dflag = false;zp = 2}
                    if titleStatas == 3{ Wtime = 2.0 ;Dflag = true;zp = 2}
                    if titleStatas == 5{ Wtime = 4.0 ;Dflag = false;zp = 4}
                    if titleStatas == 6{ Wtime = 2.0 ;Dflag = false}
                    if titleStatas == 7{ Wtime = 3.0 ;Dflag = true;zp = 2}
                }
                if BtitileStatas == 5{ //目
                    zp = 4
                    pp = [32,8]
                    if titleStatas == 1{ Wtime = 2.0 ;Dflag = true}
                    if titleStatas == 2{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 3{ Wtime = 5.0 ;Dflag = true}
                    if titleStatas == 4{ Wtime = 3.0 ;Dflag = true}
                    if titleStatas == 6{ Wtime = 1.0 ;Dflag = true}
                    if titleStatas == 7{ Wtime = 6.0 ;Dflag = true}
                }
                if BtitileStatas == 6{ //扇風機
                    pp = [43,21]
                    if titleStatas == 1{ Wtime = 1.0 ;Dflag = true}
                    if titleStatas == 2{ Wtime = 1.0 ;Dflag = false;zp = 2}
                    if titleStatas == 3{ Wtime = 3.0 ;Dflag = true;zp = 2}
                    if titleStatas == 4{ Wtime = 2.0 ;Dflag = true}
                    if titleStatas == 5{ Wtime = 1.0 ;Dflag = false;zp = 4}
                    if titleStatas == 7{ Wtime = 4.0 ;Dflag = true;zp = 2}
                }
                if BtitileStatas == 7{ //テレビ
                    zp = 2
                    pp = [82,20]
                    if titleStatas == 1{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 2{ Wtime = 6.0 ;Dflag = false}
                    if titleStatas == 3{ Wtime = 1.0 ;Dflag = false}
                    if titleStatas == 4{ Wtime = 3.0 ;Dflag = false}
                    if titleStatas == 5{ Wtime = 6.0 ;Dflag = false;zp = 4}
                    if titleStatas == 6{ Wtime = 4.0 ;Dflag = false}
                }
            }
        }
        //アクションの作成
        var catAction: SKAction!
        //共通アクション
        var FAction: SKAction!
        var walkAction: SKAction!
        let FwaitAction = SKAction.wait(forDuration: Ftime)
        if Dflag{
            FAction = SKAction.setTexture(titleCatT[2])
            walkAction = SKAction.repeatForever(SKAction.animate(with: titleCatAnime1, timePerFrame: 0.08))
        }else{
            FAction = SKAction.setTexture(titleCatT[3])
            walkAction = SKAction.repeatForever(SKAction.animate(with: titleCatAnime2, timePerFrame: 0.08))
        }
        FAction = SKAction.group([FAction,SKAction.move(to: CGPoint(x: pp[0] * x1, y: pp[1] * y1), duration: 0)])
        var moveAction:SKAction!
        var moveAction2: SKAction!
        let waitAction = SKAction.wait(forDuration: Ltime)
        let zreset = SKAction.run{ self.CatBO.zPosition = 0 }
        if titleStatas == 1{ //カーペット
            moveAction    = SKAction.move(to: CGPoint(x: 50 * x1, y: 12 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 50 * x1, y: 12 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[6])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x: 50 * x1, y: h - 12 * y1)
        }
        if titleStatas == 2{ //タワー
            moveAction    = SKAction.move(to: CGPoint(x: 25 * x1, y: 23 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 18 * x1, y: 48 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[5])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x: 18 * x1, y: h - 48 * y1)
        }
        if titleStatas == 3{ //ネコちぐら
            moveAction    = SKAction.move(to: CGPoint(x: 65 * x1, y: 23 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 65 * x1, y: 26 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[4])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x: 66 * x1, y: h - 26 * y1)
        }
        if titleStatas == 4{ //ソファ
            moveAction    = SKAction.move(to: CGPoint(x: 50 * x1, y: 25 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 50 * x1, y: 38 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[0])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x: 50 * x1, y: h - 36 * y1)
        }
        if titleStatas == 5{ //目覚し
            moveAction    = SKAction.move(to: CGPoint(x: 32 * x1, y: 8 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 32 * x1, y: 8 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[3])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x:32 * x1, y: h - 8 * y1)
        }
        if titleStatas == 6{ //扇風機
            moveAction    = SKAction.move(to: CGPoint(x: 43 * x1, y: 21 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 43 * x1, y: 21 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[3])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x: 43 * x1, y: h - 21 * y1)
        }
        if titleStatas == 7{ //テレビ
            moveAction    = SKAction.move(to: CGPoint(x: 82 * x1, y: 20 * y1), duration: Wtime)
            let mnAction2 = SKAction.move(to: CGPoint(x: 82 * x1, y: 20 * y1), duration: 0)
            let mnAction1 = SKAction.setTexture(titleCatT[7])
            moveAction2 = SKAction.group([mnAction1,mnAction2,zreset])
            titleButton[0].center = CGPoint(x: 82 * x1, y: h - 20 * y1)
        }
        let changeZP = SKAction.run {
            self.CatBO.zPosition = zp
        }
        let nextAction = SKAction.run {
            self.CatBO.removeAllActions()
            if self.titleStatas != 5{
                self.CatBO.run(SKAction.sequence([waitAction,moveAction2]))
            }else{
                self.PlaySE(SEnumber: 13)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ //攻撃開始
                    self.CatBO.run(SKAction.animate(with: self.titleCatAnime3, timePerFrame: 0.6 / 13.0))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){ //攻撃ヒット演出
                        self.playingBGM.stop()
                        self.PlaySE(SEnumber: 14)
                        if self.CFitemF[15]{ self.ClockBO.run(SKAction.setTexture(self.titleObjectT[22])) }
                        else               { self.ClockBO.run(SKAction.setTexture(self.titleObjectT[6])) }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){ //時計が飛んでいく演出
                            self.PlaySE(SEnumber: 15)
                            let CMAction = SKAction.moveBy(x: self.x1 * -100, y: self.y1 * 50, duration: 1.0)
                            let CRAction = SKAction.rotate(byAngle: 720.0 * .pi / 180.0, duration: 1.0)
                            self.ClockBO.run(SKAction.group([CMAction,CRAction]))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){ //の壊れる音
                                self.PlaySE(SEnumber: 16)
                                self.PlayBGM(BGM_Name: "BGM0_1", Volume: 1.0)
                            }
                        }
                    }
                }
            }
        }
        moveAction = SKAction.sequence([moveAction,nextAction])
        walkAction = SKAction.group([walkAction,moveAction])
        catAction = SKAction.sequence([changeZP,FAction,FwaitAction,walkAction])
        
        if titleStatas == 5{
            titleClockF = false
            Atime = 0.9
            PlayBGM(BGM_Name: "BGM0_3", Volume: 0.2)
            if CFitemF[15]{ ClockBO.run(SKAction.setTexture(titleObjectT[23])) }
            else          { ClockBO.run(SKAction.setTexture(titleObjectT[7])) }
        }
        var rn = 0
        if titleStatas == 7{
            rn = Int.random(in: 1...10)
            if rn == 1 || rn == 2{
                if CFitemF[17] { TVBO.run(SKAction.setTexture(titleObjectT[26])) } else { TVBO.run(SKAction.setTexture(titleObjectT[10])) }
                PlayBGM(BGM_Name: "BGM0_4", Volume: 0.2)
            }
            if rn == 3 || rn == 4{
                if CFitemF[17] { TVBO.run(SKAction.setTexture(titleObjectT[27])) } else { TVBO.run(SKAction.setTexture(titleObjectT[11])) }
                PlayBGM(BGM_Name: "BGM0_5", Volume: 0.2)
            }
            if rn == 5 || rn == 6{
                if CFitemF[17] { TVBO.run(SKAction.setTexture(titleObjectT[28])) } else { TVBO.run(SKAction.setTexture(titleObjectT[12])) }
                PlayBGM(BGM_Name: "BGM0_6", Volume: 0.2)
            }
            if rn == 7 || rn == 8{
                if CFitemF[17] { TVBO.run(SKAction.setTexture(titleObjectT[29])) } else { TVBO.run(SKAction.setTexture(titleObjectT[13])) }
                PlayBGM(BGM_Name: "BGM0_7", Volume: 0.2)
            }
            if rn == 9 || rn == 10{
                if CFitemF[17] { TVBO.run(SKAction.setTexture(titleObjectT[30])) } else { TVBO.run(SKAction.setTexture(titleObjectT[14])) }
                PlayBGM(BGM_Name: "BGM0_8", Volume: 0.2)
            }
        }
        CatBO.run(catAction)

        //タイトルボタンの有効化
        DispatchQueue.main.asyncAfter(deadline: .now() + Ftime + Wtime + Atime + Ltime){
            if rn <= 8{
                for i in 0..<self.titleButton.count{
                    if i <= 2{ self.titleButton[i].isEnabled = true }
                    else{
                        if self.CFitemF[i - 2]{
                            self.titleButton[i].isEnabled = true
                        }
                    }
                }
                self.titleButton[self.titleStatas + 2].isEnabled = false
                if self.titleClockF == false{
                    self.titleButton[7].isEnabled = false
                }
            }else{
                let tva = SKSpriteNode(texture: self.titleObjectT[16])
                tva.scale(to: CGSize(width: 20 * self.x1, height: 20 * self.x1))
                tva.position = CGPoint(x: 85 * self.x1, y: 37 * self.y1)
                tva.zPosition = 10
                self.titleButton[1].alpha = 0
                self.titleButton[2].alpha = 0
                self.playScene[0].addChild(tva)
                tva.run(SKAction.scale(to: 10, duration: 2.0))
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                    self.Movestage(MoveStageN: 104, MoveSceneN: 0)
                    self.titleButton[0].isEnabled = true
                    self.titleButton[1].alpha = 1
                    self.titleButton[2].alpha = 1
                }
            }
        }
    }
    
    @objc func help(_ sender: UIButton){
        sender.isEnabled = false
        displayhelp()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            sender.isEnabled = true
        }
    }
    func displayhelp(){
        let Size: CGFloat = 5
        let help1Offset: [CGFloat] = [-3,-3]
        let help2Offset: [CGFloat] = [6,0]
        let helptext1 = SKSpriteNode(imageNamed: "help1")
        helptext1.position = CGPoint(x: titleButton[0].center.x + help1Offset[0] * x1, y: h - titleButton[0].center.y + help1Offset[1] * y1)
        helptext1.scale(to: CGSize(width: w1 * Size, height: w1 * Size))
        helptext1.zPosition = 10
        playScene[0].addChild(helptext1)
        let helptext2 = SKSpriteNode(imageNamed: "help2")
        helptext2.position = CGPoint(x: titleButton[1].center.x + help2Offset[0] * x1, y: h - titleButton[1].center.y + help2Offset[1] * y1)
        helptext2.scale(to: CGSize(width: w1 * Size, height: w1 * Size))
        helptext2.zPosition = 10
        playScene[0].addChild(helptext2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
            helptext1.removeFromParent()
            helptext2.removeFromParent()
        }
    }
    //4¥ステージの変更や移動および作成
    func Movestage(MoveStageN:Int = 1000,MoveSceneN:Int = 1000,HP:Int = 1000,MP:Int = 1000){
        if MoveStageN >= 1 && MoveSceneN >= 0 && MoveStageN != 1000{  //ステージ開始時
            let Scene = StageSceneSave[MoveStageN]
            if (0 < Scene && Scene <= 10 && difficulty == 0) || (11 <= Scene && Scene <= 20 && difficulty == 1){//続きから
                playScene[0].isPaused = true
                stageN = MoveStageN
                displaystagePView()
                return
            }
        }
        let rn = Int.random(in: 1 ..< PictureCount )
        PictureFlag[rn] = true
        UserDefaults.standard.set(true, forKey: "PictureFlag\(rn)")
        LoadPicture.run(SKAction.setTexture(SKTexture(imageNamed: "P" + String(rn) )))
        let catanime = SKAction.animate(with: Loadcat, timePerFrame: 1.0 / 18.0)
        let textanime = SKAction.animate(with: Loadtext, timePerFrame: 0.05)
        LoadCatSprite.run(SKAction.repeatForever(catanime))
        LoadTextSprite.run(SKAction.repeatForever(textanime))
        view.bringSubviewToFront(LoadView)
        
        if MoveStageN >= 1 && MoveSceneN >= 1 && MoveStageN != 1000 && MoveSceneN != 1000{
            StageSceneSave[MoveStageN] = MoveSceneN
            UserDefaults.standard.set(MoveSceneN, forKey: "stageScene\(MoveStageN)")
        }
        //表示ステージ変更
        if MoveStageN == 1000{
            if playstage == false{
                if stageN >= 0{
                    stageN = SSSave
                }else{
                    stageN = 0
                }
            }
        }else{
            stageN = MoveStageN
            print("MoveStageN: " + String(MoveStageN))
            if MoveStageN <= -1{
                SSBSave = SSSave
                SSSave = MoveStageN
            }else if MoveStageN == 0{
                SSSave = -1
                SSBSave = 0
            }else{
                SSBSave = stageN
            }
        }
        //表示ステージシーン変更
        if MoveSceneN == 1000{
            if stageN <= 0{
                stagesceneN = SSBSave
            }
        }else{
            if (0 < MoveSceneN && MoveSceneN <= 10 && difficulty == 0) || (11 <= MoveSceneN && MoveSceneN <= 20 && difficulty == 1) || MoveSceneN <= -1{
                stagesceneN = MoveSceneN
            }else{
                stagesceneN = 0
            }
        }
        UserDefaults.standard.set(SSSave, forKey: "SSSave")
        UserDefaults.standard.set(SSBSave, forKey: "SSBSave")
        if HP != 1000         { PlayerHP = HP }                      //体力の維持
        if MP != 1000         { PlayerMP = MP }                      //魔力の維持
        deleteScene()                                                //表示中のシーンを消去
        var HPplus = 0;var MPplus = 0
        if PSOn[9]  { HPplus += 50 } ;if PSOn[10] { HPplus += 50 }
        if PSOn[11] { MPplus += 50 } ;if PSOn[12] { MPplus += 50 }
        PlayerMaxHP = 100 + HPplus ;PlayerMaxMP = 100 + MPplus
        if PSOn[13] { PlayerAttackP = 20 } else { PlayerAttackP = 10 }
        if HPMaxfalg{
            HPMaxfalg = false
            PlayerHP = PlayerMaxHP
            PlayerMP = PlayerMaxMP
        }
        HPgauge.setProgress(Float(PlayerHP) / Float(PlayerMaxHP), animated: false)
        MPgauge.setProgress(Float(PlayerMP) / Float(PlayerMaxMP), animated: false)
        
        if stageN == 0{ self.playstage = false;self.Movetitle(); return }
        
        
       //ステージを作成
        if stageN >= 1{ 
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.MakeStageScene()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.stageBGM()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        self.displayStageView()
                        self.LoadCatSprite.removeAllActions()
                        self.LoadTextSprite.removeAllActions()
                    }
                }
            }
 
        }else if stageN <= -1{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                self.MakeSSScene()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.stageBGM()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                        self.displayStageView()
                        self.LoadCatSprite.removeAllActions()
                        self.LoadTextSprite.removeAllActions()
                        
                        if self.ReviewFlag{
                            self.ReviewFlag = false
                            SKStoreReviewController.requestReview()
                        }
                    }
                }
            }
        }
    }
    
    //ステージセレクトステージの作成
    func MakeSSScene(){
        //ステージシーンの作成と追加
        let StageScene = SSStage(size: view.frame.size)  //ステージシーンの作成
        playScene.append(StageScene)                   //表示中のステージを格納
        (playScene[0] as! object).viewnode = self
        stageView.presentScene(playScene[0])
    }
    //通常ステージの作成
    func MakeStageScene(){
        //ステージシーンの作成と追加
        let StageScene = Stage(size: view.frame.size)  //ステージシーンの作成
        playScene.append(StageScene)                   //表示中のステージを格納
        (playScene[0] as! object).viewnode = self
        stageView.presentScene(playScene[0])
    }
    
    //4¥タイトル画面に移動および作成
    func Movetitle(){
        MaketitleScene()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
            self.displaytitleView()
        }
    }
    //タイトルの作成(アイテム取得による表示の違いを入れる)
    func MaketitleScene(){
        titleStatas = 0
        let titleScene = SKScene(size: view.frame.size)   //タイトルシーンを作成
        //背景画像の表示
        var background: SKSpriteNode!
        if CFitemF[9]{
            background = SKSpriteNode(imageNamed: "bg0_3")
        }else{
            background = SKSpriteNode(imageNamed: "bg0_2")
        }
        background.position = CGPoint(x: w / 2, y: h / 2)
        background.size = CGSize(width: w, height: h)
        background.zPosition = -100
        titleScene.addChild(background)
        let titlename = "ポン吉の大冒険"                                         //表示文字
        let titleSize:[CGFloat] = [1,1,1,0.8,1.2,1.2,1.2]                             //文字サイズ
        let titleP:[[CGFloat]] = [[1.4,7.5],[2.6,7.5],[3.8,7.5],[5,7.5],[6.2,7.5],[7.4,7.5],[8.6,7.5]]  //文字位置
        //タイトルの文字を使い
        var chara: [SKSpriteNode] = []
        for n in 0..<titlename.count{
            let startIndex = titlename.index(titlename.startIndex, offsetBy: n) //n番目の文字の前の位置
            let endIndex = titlename.index(startIndex, offsetBy: 1)             //n番目の文字の前の位置から１文字後ろの位置
            let Str = titlename[startIndex..<endIndex]                          //startIndexからendIndexの位置を読み込み
            let charaSprite = SKSpriteNode(imageNamed: "t" + Str)               //文字の画像の読み込み
            charaSprite.position = CGPoint(x: w1 * titleP[n][0], y: h1 * titleP[n][1])
            charaSprite.size = CGSize(width: w1 * titleSize[n], height: w1 * titleSize[n])
            chara.append(charaSprite)
            titleScene.addChild(charaSprite)
        }
        //タイトルのアクション
        let RTime = 1.0
        let WTime = 4.0
        let lagTime = 0.4
        let rotateAction = SKAction.rotate(byAngle: 360.0 * .pi / 180.0, duration: RTime)
        let waitAction = SKAction.wait(forDuration: WTime)
        let sAction = SKAction.sequence([rotateAction,waitAction])
        let playAction = SKAction.repeatForever(sAction)
        
        let lag1Action =  SKAction.wait(forDuration: lagTime)
        let lag2Action =  SKAction.wait(forDuration: lagTime * 2.0)
        let lag3Action =  SKAction.wait(forDuration: lagTime * 3.0)
        chara[4].run(SKAction.sequence([lag1Action,playAction]))
        chara[5].run(SKAction.sequence([lag2Action,playAction]))
        chara[6].run(SKAction.sequence([lag3Action,playAction]))
        
        //タイトルオブジェクトの作成          猫　　　　カ　　　　タ　　　　蔵　　　　ソ　　　　目　　　　扇　　　　テ
        let ButtonS: [CGFloat]   = [     20,     70,     40,     15,     18,      8,     12,     20]
        let ButtonP: [[CGFloat]] = [[90,17],[50,12],[18,48],[65,26],[50,36],[22, 8],[32,23],[85, 37]]
        
        let catO = SKSpriteNode(texture: titleCatT[0])
        catO.scale(to: CGSize(width: ButtonS[0] * x1, height: ButtonS[0] * x1))
        catO.position = CGPoint(x: ButtonP[0][0] * x1, y: ButtonP[0][1] * y1)
        CatBO = catO
        titleScene.addChild(catO)
        
        //カーペット
        if CFitemF[1] || CFitemF[11]{
            let to1 = SKSpriteNode(texture: titleObjectT[0])
            to1.scale(to: CGSize(width: ButtonS[1] * x1, height: ButtonS[1] * x1))
            to1.position = CGPoint(x: ButtonP[1][0] * x1, y: ButtonP[1][1] * y1)
            to1.zPosition = -2
            titleScene.addChild(to1)
            if CFitemF[11] { to1.run(SKAction.setTexture(titleObjectT[19])) }
            titleButton[3].isEnabled = true
        }
        //猫タワー
        if CFitemF[2] || CFitemF[12]{
            let to2 = SKSpriteNode(texture: titleObjectT[1])
            to2.scale(to: CGSize(width: ButtonS[2] * x1, height: ButtonS[2] * x1))
            to2.position = CGPoint(x: ButtonP[2][0] * x1, y: ButtonP[2][1] * y1)
            to2.zPosition = 1
            titleScene.addChild(to2)
            let to3 = SKSpriteNode(texture: titleObjectT[2])
            to3.scale(to: CGSize(width: ButtonS[2] * x1, height: ButtonS[2] * x1))
            to3.position = CGPoint(x: ButtonP[2][0] * x1, y: ButtonP[2][1] * y1)
            to3.zPosition = -1
            titleScene.addChild(to3)
            if CFitemF[12] { to2.run(SKAction.setTexture(titleObjectT[20])) }
            titleButton[4].isEnabled = true
        }
        
        //ネコちぐら
        if CFitemF[3] || CFitemF[13]{
            let to4 = SKSpriteNode(texture: titleObjectT[3])
            to4.scale(to: CGSize(width: ButtonS[3] * x1, height: ButtonS[3] * x1))
            to4.position = CGPoint(x: ButtonP[3][0] * x1, y: ButtonP[3][1] * y1)
            to4.zPosition = 1
            titleScene.addChild(to4)
            let to5 = SKSpriteNode(texture: titleObjectT[4])
            to5.scale(to: CGSize(width: ButtonS[3] * x1, height: ButtonS[3] * x1))
            to5.position = CGPoint(x: ButtonP[3][0] * x1, y: ButtonP[3][1] * y1)
            to5.zPosition = -1
            titleScene.addChild(to5)
            if CFitemF[13]{ to4.run(SKAction.setTexture(titleObjectT[21])) }
            titleButton[5].isEnabled = true
        }
        
        //ソファ
        if CFitemF[4] || CFitemF[8] || CFitemF[14] || CFitemF[18]{
            let to6 = SKSpriteNode(texture: titleObjectT[5])
            to6.scale(to: CGSize(width: ButtonS[4] * x1, height: ButtonS[4] * x1))
            to6.position = CGPoint(x: ButtonP[4][0] * x1, y: ButtonP[4][1] * y1)
            to6.zPosition = -1
            titleScene.addChild(to6)
            if CFitemF[18]{
                to6.run(SKAction.setTexture(titleObjectT[18]))
            }else if CFitemF[8]{
                to6.run(SKAction.setTexture(titleObjectT[17]))
            }else if CFitemF[14]{
                to6.run(SKAction.setTexture(titleObjectT[15]))
            }
            titleButton[6].isEnabled = true
        }
        //目覚し時計
        if CFitemF[5]{
            let to7 = SKSpriteNode(texture: titleObjectT[6])
            to7.scale(to: CGSize(width: ButtonS[5] * x1, height: ButtonS[5] * x1))
            to7.position = CGPoint(x: ButtonP[5][0] * x1, y: ButtonP[5][1] * y1)
            to7.zPosition = 5
            ClockBO = to7
            titleScene.addChild(to7)
            titleButton[7].isEnabled = true
            if CFitemF[15]{
                to7.run(SKAction.setTexture(titleObjectT[22]))
            }
        }
        //扇風機
        if CFitemF[6]{
            let to8 = SKSpriteNode(texture: titleObjectT[8])
            to8.scale(to: CGSize(width: ButtonS[6] * x1, height: ButtonS[6] * x1))
            to8.position = CGPoint(x: ButtonP[6][0] * x1, y: ButtonP[6][1] * y1)
            to8.zPosition = 3
            titleScene.addChild(to8)
            titleButton[8].isEnabled = true
            if CFitemF[16]{
                to8.run(SKAction.setTexture(titleObjectT[24]))
            }
        }
        //テレビ
        if CFitemF[7]{
            let to9 = SKSpriteNode(texture: titleObjectT[9])
            to9.scale(to: CGSize(width: ButtonS[7] * x1, height: ButtonS[7] * x1))
            to9.position = CGPoint(x: ButtonP[7][0] * x1, y: ButtonP[7][1] * y1)
            to9.zPosition = -1
            TVBO = to9
            titleScene.addChild(to9)
            titleButton[9].isEnabled = true
            if CFitemF[17]{
                to9.run(SKAction.setTexture(titleObjectT[25]))
            }
        }

        titleButton[0].center = CGPoint(x: 90 * x1, y: h - 15 * y1)
        titleView.presentScene(titleScene)                              //タイトルシーンをビューに追加
        playScene.append(titleScene)
        HPMaxfalg = true
    }
    //ステージに移動
    @objc func StartGame(_ sender: UIButton) {
        PlaySE(SEnumber: 0)
        if UpdateFirst{
            UserDefaults.standard.set(false, forKey: "UpdateFirst\(UpdateN)")
            UpdateFirst = false
            Movestage(MoveStageN: -1, MoveSceneN: 0)
        }else{
            Movestage()
        }
    }
    //操作説明画面に移動
    @objc func Howtoplay(_ sender: UIButton) {
        PlaySE(SEnumber: 0)
        displayHowToPlayView()
    }
    //4¥ステージの消去
    func deleteScene(){
        playScene[0].removeFromParent()
        playScene.removeAll()
    }
    //4¥ゲームオーバーorステージクリアの処理
    func GameOver(){
        InterType = 1
        playingBGM.stop()        //再生中のBGMをストップ
        PlaySE(SEnumber: 7)      //ゲームオーバー時のBGMを再生
        displayStageFinishView() //ゲームオーバーまたはゲームクリアアニメを表示するビューを表示
    }
    //ステージクリア時に呼び出される関数
    func GameClear(){
        InterType = 2
        playingBGM.stop()        //再生中のBGMをストップ
        PlaySE(SEnumber: 8)      //ゲームクリア時のBGMを再生
        
        if stageN == 6 || stageN == 13 || stageN == 20 || stageN == 27 || stageN == 34 || stageN == 41{
            ReviewFlag = true
        }
        
        if difficulty == 0{
            if StageCF[stageN] == 0{
                StageCF[stageN] = 1
                UserDefaults.standard.set(1, forKey: "stageclear\(stageN)")
            }
        }else if difficulty == 1{
            StageCF[stageN] = 2
            UserDefaults.standard.set(2, forKey: "stageclear\(stageN)")
        }
        displayStageFinishView() //ゲームオーバーまたはゲームクリアアニメを表示するビューを表示
    }
    func displayStageFinishView(){
        //ステージフィニッシュビューの作成
        if StageFinishView == nil {
            StageFinishView = SKView(frame: CGRect(x: 0, y: 0, width: w, height: h))
            view.addSubview(StageFinishView)
        }else{
            view.bringSubviewToFront(StageFinishView)
        }
        
        var StageFScean: SKScene!
        var displaytime: Double!
        //ゲームクリア　or ゲームオーバーの演出シーンを作成
        if InterType == 1{
            StageFScean = GameOverScean(size: StageFinishView.frame.size)
            displaytime = 5.0
        }else if InterType == 2 {
            StageFScean = StageClearScean(size: StageFinishView.frame.size)
            displaytime = 5.0
        }
        //ゲームクリア　or ゲームオーバー演出シーンを表示
        StageFinishView.presentScene(StageFScean)
        SceneF.append(StageFScean)
        
        //動画インタースティシャル広告の表示
        DispatchQueue.main.asyncAfter(deadline: .now() + displaytime){
            self.StageFinishInterD()
        }
    }
    //4¥ステージ終了後の動画インタースティシャル広告の表示設定
    func StageFinishInterD(){
        if MoneyFlag1{
            InterstitialFinish()
            return
        }
        if InterType == 1{//ゲームオーバー時
            InterCount += 2
            if InterCount >= InterFN{
                InterCount = 0
                UserDefaults.standard.set(InterCount, forKey: "InterCountI")
                InterstitialDisplay() //動画インタースティシャル広告の表示
            }else{
                UserDefaults.standard.set(InterCount, forKey: "InterCountI")
                InterstitialFinish()  //動画インタースティシャル広告を見終わった扱いにしてゲームオーバービューを表示
            }
        }
        if InterType == 2{//ステージクリア時
            InterCount += 1
            if InterCount >= InterFN{
                InterCount = 0
                UserDefaults.standard.set(InterCount, forKey: "InterCountI")
                InterstitialDisplay() //動画インタースティシャル広告の表示
            }else{
                UserDefaults.standard.set(InterCount, forKey: "InterCountI")
                InterstitialFinish()  //動画インタースティシャル広告を見終わった扱いにしてゲームクリアビューを表示
            }
        }
    }
    
    //4¥BGMの読み込み・再生
    func PlayBGM(BGM_Name: String, Volume:Float){
        do{
            if let BGMname = NSDataAsset(name: BGM_Name){
                let pBGM = try AVAudioPlayer(data: BGMname.data)    //BGMデータの読み込み
                pBGM.numberOfLoops = -1                             //BGMをループ再生させる
                pBGM.volume = Volume                                //BGMのボリュームを変更
                if playingBGM != nil{ //再生中のBGMがあるかの確認
                    playingBGM.stop()                               //再生中のBGMを停止
                    playingBGM.currentTime = 0                      //再生していたBGMを初期化
                }
                pBGM.play()                                         //次のBGMを再生する
                playingBGM = pBGM                                   //今再生したBGMを再生中BGM変数に格納
            }
        }catch{
            print("error")
        }
    }
    
    func StopBGN(){
        if playingBGM != nil{ //再生中のBGMがあるかの確認
            playingBGM.stop()                               //再生中のBGMを停止
            playingBGM.currentTime = 0                      //再生していたBGMを初期化
        }
    }
    
    //4¥ステージBGMの設定
    func stageBGM(){
        if stageN == -1    //最初のステージセレクト画面
        { PlayBGM(BGM_Name: "BGM0_2", Volume: 0.2) }
        //第１エリア草原
        if stageN == -2                     //ステージセレクト
        { PlayBGM(BGM_Name: "BGM1_1", Volume: 0.2) }
        if 1 <= stageN && stageN <= 5       //ステージ
        { PlayBGM(BGM_Name: "BGM1_2", Volume: 0.2) }
        if stageN == 6                      //ボス
        { PlayBGM(BGM_Name: "BGM1_3", Volume: 0.4) }
        
        //第２エリア森林
        if stageN == -3                     //ステージセレクト
        { PlayBGM(BGM_Name: "BGM2_1", Volume: 0.2) }
        if 7 <= stageN && stageN <= 12      //ステージ
        { PlayBGM(BGM_Name: "BGM2_2", Volume: 0.2) }
        if stageN == 13                     //ボス
        { PlayBGM(BGM_Name: "BGM2_3", Volume: 0.4) }
        
        //第３エリア洞窟
        if stageN == -4                     //ステージセレクト
        { PlayBGM(BGM_Name: "BGM3_1", Volume: 0.2) }
        if 14 <= stageN && stageN <= 19     //ステージ
        { PlayBGM(BGM_Name: "BGM3_2", Volume: 0.2) }
        if stageN == 20                     //ボス
        { PlayBGM(BGM_Name: "BGM3_3", Volume: 0.2) }
        
        //第４エリア火山
        if stageN == -5                     //ステージセレクト
        { PlayBGM(BGM_Name: "BGM4_1", Volume: 0.2) }
        if 21 <= stageN && stageN <= 25     //ステージ
        { PlayBGM(BGM_Name: "BGM4_2", Volume: 0.2) }
        if stageN == 26    //ステージ
        { PlayBGM(BGM_Name: "BGM4_4", Volume: 0.2) }
        if stageN == 27                     //ボス
        { PlayBGM(BGM_Name: "BGM4_3", Volume: 0.2) }
        
        //第５エリア氷雪
        if stageN == -6                     //ステージセレクト
        { PlayBGM(BGM_Name: "BGM5_1", Volume: 0.2) }
        if 28 <= stageN && stageN <= 32     //ステージ
        { PlayBGM(BGM_Name: "BGM5_2", Volume: 0.2) }
        if stageN == 34                     //ボス
        { PlayBGM(BGM_Name: "BGM5_3", Volume: 0.2) }
        if stageN == 33                     //ステージ
        { PlayBGM(BGM_Name: "BGM5_4", Volume: 0.2) }
        
        //第６エリア天空
        if stageN == -7                     //ステージセレクト
        { PlayBGM(BGM_Name: "BGM6_1", Volume: 0.4) }
        if 35 <= stageN && stageN <= 39     //ステージ
        { PlayBGM(BGM_Name: "BGM6_2", Volume: 0.2) }
        if stageN == 40                     //ステージ
        { PlayBGM(BGM_Name: "BGM6_3", Volume: 0.2) }
        if stageN == 41                     //ボス
        { PlayBGM(BGM_Name: "BGM6_4", Volume: 0.5) }
        
        //隠しステージ
        if stageN == 100 // 夜の草原
        { PlayBGM(BGM_Name: "BGM10_1", Volume: 0.4) }
        if stageN == 101{ // 鍾乳洞
            if stagesceneN == 0{
                PlayBGM(BGM_Name: "BGM3_2", Volume: 0.2)
            }else{
                PlayBGM(BGM_Name: "BGM10_2", Volume: 0.2)
            }
        }
        if stageN == 102 // 雪
        { PlayBGM(BGM_Name: "BGM10_3", Volume: 0.2) }
        
        if stageN == 103 // 雲
        { PlayBGM(BGM_Name: "BGM10_4", Volume: 0.2) }
        
        
        
        //練習ステージ
        if stageN == -12
        { PlayBGM(BGM_Name: "BGM11_1", Volume: 0.2) }
        if 70 <= stageN && stageN <= 99
        { PlayBGM(BGM_Name: "BGM11_2", Volume: 0.2) }
    }
    //4¥効果音の読み込み
    func SoundRead(){
        ReadSE(SEname: "システム効果音")               // 0
        ReadSE(SEname: "ステージ選択音")               // 1
        ReadSE(SEname: "Select1")                   // 2
        ReadSE(SEname: "pageC")                     // 3
        ReadSE(SEname: "discription2")              // 4
        ReadSE(SEname: "System")                    // 5
        ReadSE(SEname: "Picture")                   // 6
        ReadSE(SEname: "gemeover")                  // 7
        ReadSE(SEname: "stageclear")                // 8
        ReadSE(SEname: "cursor01", ofType: "wav")   // 9
        ReadSE(SEname: "cursor02", ofType: "wav")   // 10
        ReadSE(SEname: "cursor03", ofType: "wav")   // 11
        ReadSE(SEname: "cursor04", ofType: "wav")   // 12
        ReadSE(SEname: "TSE1")                      // 13
        ReadSE(SEname: "TSE2", ofType: "wav")       // 14
        ReadSE(SEname: "TSE3")                      // 15
        ReadSE(SEname: "TSE4", ofType: "wav")       // 16
        ReadSE(SEname: "TVSE1")                     // 17
        ReadSE(SEname: "TVSE2")                     // 18
        ReadSE(SEname: "TVSE3")                     // 19
        ReadSE(SEname: "TVmove")                    // 20
        ReadSE(SEname: "sendMail")                    // 21
    }
  
    //4¥ステージをどこから始めるかを確認するビューの作成
    func displaystagePView(){
        if stagePView == nil{
            stagePView = SKView(frame: CGRect(x: 0, y: 0, width: h1 * 12, height: h1 * 8))
            stagePView.center = view.center
            stagePView.backgroundColor = .clear
            view.addSubview(stagePView)
            let bgimage = SKSpriteNode(imageNamed: "pose")
            bgimage.position = CGPoint(x: h1 * 6, y: h1 * 4)
            bgimage.size = CGSize(width: h1 * 12, height: h1 * 8)
            let stagePSS = SKScene(size: stagePView.frame.size)
            stagePSS.addChild(bgimage)
            stagePSS.backgroundColor = .clear
            stagePView.presentScene(stagePSS)
            
            let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: h1 * 11, height: h1))
            label.text = "どのポイントから開始しますか？"
            label.font = UIFont(name: "Ronde-B", size: h1 * 0.7)
            label.textColor = .white
            label.center = CGPoint(x: h1 * 6, y: h1 * 2)
            label.textAlignment = NSTextAlignment.center
            stagePView.addSubview(label)
            
            let fB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            fB.center = CGPoint(x: h1 * 6, y: h1 * 4)
            fB.setTitle("最初から", for: .normal)
            fB.titleLabel?.font = UIFont(name: "Ronde-B", size: h1)
            fB.addTarget(self, action: #selector(firstVC.fstart(_:)), for: .touchUpInside)
            fB.setTitleColor(.white, for: .normal)
            stagePView.addSubview(fB)
            
            cB = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 5, height: h1 * 1.5))
            cB.center = CGPoint(x: h1 * 6, y: h1 * 6)
            cB.setTitle("セーブ地点", for: .normal)
            cB.titleLabel?.font = UIFont(name: "Ronde-B", size: h1)
            cB.addTarget(self, action: #selector(firstVC.cstart(_:)), for: .touchUpInside)
            cB.setTitleColor(.gray, for: .normal)
            cB.isEnabled = false
            stagePView.addSubview(cB)
        }else{
            self.view.bringSubviewToFront(stagePView)
        }
        if StageSceneSave[stageN] != 0{
            cB.isEnabled = true
            cB.setTitleColor(.white, for: .normal)
        }else{
            cB.isEnabled = false
            cB.setTitleColor(.gray, for: .normal)
        }
    }
    //ステージを最初から始める場合に使用
    @objc func fstart(_ sender: UIButton){
        self.view.sendSubviewToBack(stagePView)
        PlaySE(SEnumber: 1)
        StageSceneSave[stageN] = 0
        UserDefaults.standard.set(0, forKey: "stageScene\(stageN)")
        Movestage(MoveStageN: stageN, MoveSceneN: 0)
    }
    //ステージを続きから始める場合に使用
    @objc func cstart(_ sender: UIButton){
        self.view.sendSubviewToBack(stagePView)
        PlaySE(SEnumber: 1)
        InterType = 3
        stagesceneN = StageSceneSave[stageN]
        StageSceneSave[stageN] = 0
        
        if MoneyFlag1{ //広告を表示しない
            InterstitialFinish()
            return
        }
   
        InterCount += 2
        if InterCount >= InterFN{
            InterCount = 0
            UserDefaults.standard.set(InterCount, forKey: "InterCountI")
            InterstitialDisplay() //動画インタースティシャル広告の表示
        }else{
            UserDefaults.standard.set(InterCount, forKey: "InterCountI")
            InterstitialFinish()  //動画インタースティシャル広告を見終わった扱いにしてゲームオーバービューを表示
        }

    }
 
    //4¥ステージ作成時のデータ取得用関数
    func getStageN() -> Int{ return stageN }                //ステージナンバーの取得に使用
    func getStageSceneN() -> Int{ return stagesceneN }      //ステージシーンナンバーの取得に使用
    func getCFitemF() -> [Bool]{return CFitemF}
    func CFGet() -> [Int]{                                  //ステージクリア状況を取得
        var CF: [Int] = [0]
        for n in 1...StageCount{ CF.append(StageCF[n]) }
        return CF
    }
    func getDifficulty() -> Int{ return difficulty }
    func setSaveS(N:Int,SN:Int){ StageSceneSave[N] = SN }
    func setCFitemF(N:Int){ CFitemF[N] = true }
    
    func getplayerHP() -> Int{ return PlayerHP }            //プレイヤーHPの取得に使用
    func getplayerMP() -> Int{ return PlayerMP }            //プレイヤーMPの取得に使用
    func getplayerMaxHP() -> Int{ return PlayerMaxHP }      //プレイヤーHPの取得に使用
    func getplayerMaxMP() -> Int{ return PlayerMaxMP }      //プレイヤーMPの取得に使用
    func getAttack() -> Int{ return PlayerAttackP }         //プレイヤーMPの取得に使用
    
    func SetPraStatas(HP:Int,MP:Int,Attack:Int){
        PlayerHP = HP
        PlayerMaxHP = HP
        PlayerMP = MP
        PlayerMaxMP = MP
        PlayerAttackP = Attack
    }
    func SetHP(HP:Int){
        PlayerHP = HP
    }
    func SetMP(MP:Int){
        PlayerMP = MP
    }
    
    func getPointerFlag() -> Bool{ return Pointerflag } 
    
    func stopBvalid(){ stopButton.isEnabled = true }        //一時停止ボタン有効化
    
    func SaveScene(SceneNumber: Int){
        StageSceneSave[stageN] = SceneNumber
        UserDefaults.standard.set(SceneNumber, forKey: "stageScene\(stageN)")
    }
    
    //4¥説明用のビュー表示
    func displaydiscriptionView(){
        if discriptionView == nil {
            var movieS:[CGFloat] = [95,80]     //ムービーサイズ
            var movieP:[CGFloat] = [50,42]      //ムービー位置
            var text1S:[CGFloat] = [40,10]      //タイトルテキストサイズ
            var text1P:[CGFloat] = [20,90]      //タイトルテキスト位置
            var text1CS:CGFloat = 4             //タイトルテイストフォントサイズ
            var text2S:[CGFloat] = [58,20]      //説明文テキストサイズ
            var text2P:[CGFloat] = [65,90]      //説明文テキスト位置
            var text2CS:CGFloat = 3             //説明文テキストフォントサイズ
            
            movieS[0] = movieS[0] * x1  ;movieS[1] = movieS[1] * y1
            movieP[0] = movieP[0] * x1  ;movieP[1] = h - movieP[1] * y1
            text1S[0] = text1S[0] * x1  ;text1S[1] = text1S[1] * y1
            text1P[0] = text1P[0] * x1  ;text1P[1] = h - text1P[1] * y1
            text1CS = text1CS * x1
            text2S[0] = text2S[0] * x1  ;text2S[1] = text2S[1] * y1
            text2P[0] = text2P[0] * x1  ;text2P[1] = h - text2P[1] * y1
            text2CS = text2CS * x1

            discriptionView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            discriptionView.backgroundColor = .clear
            let disSS = SKScene(size: discriptionView.frame.size)
            disSS.backgroundColor = .clear
            discriptionView.presentScene(disSS)
            discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1)
            view.addSubview(discriptionView)
            
            let disButton = UIButton(frame: CGRect(x: 0, y: 0, width: w, height: h))
            disButton.center = discriptionView.center
            disButton.addTarget(self, action: #selector(firstVC.dislabel(_:)), for: .touchUpInside)
            disButton.setBackgroundImage(UIImage(named: "board2"), for: .normal)
            discriptionView.addSubview(disButton)
            
            let moviePath = Bundle.main.path(forResource: "movie/walk", ofType: "mp4")
            let url = URL(fileURLWithPath: moviePath!)
            let player = AVPlayer(url: url)
            playMovie = player
            MovieLayer = AVPlayerLayer(player: player)
            MovieLayer.frame = CGRect(x: 0, y: 0, width: movieS[0], height: movieS[1])
            MovieLayer.position = CGPoint(x: movieP[0], y: movieP[1])
            discriptionView.layer.addSublayer(MovieLayer)
            
            discriptionLabel1.frame = CGRect(x: 0, y: 0, width: text1S[0], height: text1S[1])
            discriptionLabel1.center = CGPoint(x: text1P[0], y: text1P[1])
            discriptionLabel1.font = UIFont(name: "Ronde-B", size: text1CS)
            discriptionLabel1.textColor = .brown
            discriptionLabel1.textAlignment = NSTextAlignment.center
            discriptionView.addSubview(discriptionLabel1)
            
            discriptionLabel2.frame = CGRect(x: 0, y: 0, width: text2S[0], height: text2S[1])
            discriptionLabel2.center = CGPoint(x: text2P[0], y: text2P[1])
            discriptionLabel2.font = UIFont(name: "Ronde-B", size: text2CS)
            discriptionLabel2.textColor = .brown
            discriptionLabel2.textAlignment = NSTextAlignment.left
            discriptionLabel2.numberOfLines = 0
            discriptionView.addSubview(discriptionLabel2)
        }else{
            discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1)
            view.bringSubviewToFront(discriptionView)
        }
        OpendiscriptionView()
    }
    
    
    //4¥ゲームオーバービューの表示
    func displayGameOverView(){
        Viewtype = 3
        if MoneyFlag1 == false { BannerStatasChange() }

        PlayBGM(BGM_Name: "BGM0_1", Volume: 0.5)
        HPMaxfalg = true
        if goC == 0{
            let reBS: [CGFloat] = [10,15]
            let reBP: [CGFloat] = [35,12]
            let reTS: [CGFloat] = [20,10]
            let reTP: [CGFloat] = [35,25]
            let reTFontSize: CGFloat = 4
            
            let ssBS: [CGFloat] = [10,15]
            let ssBP: [CGFloat] = [15,12]
            let ssTS: [CGFloat] = [20,10]
            let ssTP: [CGFloat] = [15,25]
            let ssTFontSize: CGFloat = 4
            
            let reBS2: [CGFloat] = [10,15]
            let reBP2: [CGFloat] = [75,12]
            let reTS2: [CGFloat] = [20,10]
            let reTP2: [CGFloat] = [75,25]
            let reTFontSize2: CGFloat = 4
            
            let ssBS2: [CGFloat] = [10,15]
            let ssBP2: [CGFloat] = [25,12]
            let ssTS2: [CGFloat] = [20,10]
            let ssTP2: [CGFloat] = [25,25]
            let ssTFontSize2: CGFloat = 4


            let gameoverView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(gameoverView)
            let gameoverss = SKScene(size:  gameoverView.frame.size)
            //背景画像の表示
            let background = SKSpriteNode(imageNamed: "bgO2")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            gameoverss.addChild(background)
            gameoverView.presentScene(gameoverss)
            
            let retrybutton = UIButton(frame: CGRect(x: 0,y: 0,width: reBS[0] * x1,height:reBS[1] * y1))
            retrybutton.center = CGPoint(x: reBP[0] * x1, y: h - reBP[1] * y1)
            retrybutton.setImage(UIImage.init(named: "リピートボタン"), for: .normal)
            retrybutton.addTarget(self, action: #selector(firstVC.retry01(_:)), for: .touchUpInside)
            gameoverView.addSubview(retrybutton)
            
            let relabel:UILabel = UILabel()
            relabel.text = "リトライ"
            relabel.font = UIFont(name: "Ronde-B", size: reTFontSize * x1)
            relabel.frame = CGRect(x: 0, y: 0, width: reTS[0] * x1, height: reTS[1] * y1)
            relabel.center = CGPoint(x: reTP[0] * x1, y: h - reTP[1] * y1)
            relabel.textAlignment = NSTextAlignment.center
            gameoverView.addSubview(relabel)
            
            let stageselect = UIButton(frame: CGRect(x: 0,y: 0,width: ssBS[0] * x1,height: ssBS[1] * y1))
            stageselect.center = CGPoint(x: ssBP[0] * x1, y: h - ssBP[1] * y1)
            stageselect.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
            stageselect.addTarget(self, action: #selector(firstVC.StartGame2(_:)), for: .touchUpInside)
            gameoverView.addSubview(stageselect)
            
            let sslabel:UILabel = UILabel()
            sslabel.text = "戻る"
            sslabel.font = UIFont(name: "Ronde-B", size: ssTFontSize * x1)
            sslabel.frame = CGRect(x: 0, y: 0, width: ssTS[0] * x1, height: ssTS[1] * y1)
            sslabel.center = CGPoint(x: ssTP[0] * x1, y: h - ssTP[1] * y1)
            sslabel.textAlignment = NSTextAlignment.center
            gameoverView.addSubview(sslabel)
            BannerView.append(gameoverView)
            goC = BannerView.count
            if MoneyFlag1 == false { addNendbanner(xp: 5.5, yp: 0, type: 3, Number: 1, Ycenter: true) }
            else{
                retrybutton.frame = CGRect(x: 0,y: 0,width: reBS2[0] * x1,height:reBS2[1] * y1)
                retrybutton.center = CGPoint(x: reBP2[0] * x1, y: h - reBP2[1] * y1)
                relabel.frame = CGRect(x: 0, y: 0, width: reTS2[0] * x1, height: reTS2[1] * y1)
                relabel.center = CGPoint(x: reTP2[0] * x1, y: h - reTP2[1] * y1)
                relabel.font = UIFont(name: "Ronde-B", size: reTFontSize2 * x1)
                stageselect.frame = CGRect(x: 0,y: 0,width: ssBS2[0] * x1,height: ssBS2[1] * y1)
                stageselect.center = CGPoint(x: ssBP2[0] * x1, y: h - ssBP2[1] * y1)
                sslabel.frame = CGRect(x: 0, y: 0, width: ssTS2[0] * x1, height: ssTS2[1] * y1)
                sslabel.center = CGPoint(x: ssTP2[0] * x1, y: h - ssTP2[1] * y1)
                sslabel.font = UIFont(name: "Ronde-B", size: ssTFontSize2 * x1)
                background.run(SKAction.setTexture(SKTexture(imageNamed: "bgO3")))
            }
        }else{
            self.view.bringSubviewToFront(BannerView[goC - 1])
            
        }
    }
    //ゲームオーバービューでもう一度そのステージをプレイするボタン
    @objc func retry01(_ sender: UIButton) {
        PlaySE(SEnumber: 1)
        self.view.sendSubviewToBack(BannerView[goC - 1])
        Movestage(MoveStageN: stageN, MoveSceneN: stagesceneN)
    }
    @objc func StartGame2(_ sender: UIButton) {
        PlaySE(SEnumber: 0)
        playstage = false
        Movestage()
    }
    
    //4¥ステージビュー表示
    func displayStageView(){
        view.bringSubviewToFront(stageView)
        view.bringSubviewToFront(stageFrontView)
        //ステージシーンの作成
        Viewtype = 0                //表示ビューステータスの変更（広告表示に使用）
        playstage = true
        stopButton.isEnabled = true
        if MoneyFlag1 == false {
            InterstitialLoad()   //インターステシャル広告のロード
            BannerStatasChange() //バナー広告のステータスを変更
        }
        if FirstPlay{
            FirstPlay = false
            UserDefaults.standard.set(false, forKey: "firstplay")
            discriptionChangeN(disN: 1, display: true)
        }
    }
    
    
    //4¥タイトル画面表示に使用
    func displaytitleView(){
        Viewtype = 1
        if MoneyFlag1 == false { BannerStatasChange() }
        PlayBGM(BGM_Name: "BGM0_1", Volume: 0.5)
        view.bringSubviewToFront(titleView)
        if FirstPlay{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                self.displayhelp()
            }
        }
    }

    //4¥ポーズ画面の表示
    func displayStopView(){
        Viewtype = 5
        if MoneyFlag1 == false { BannerStatasChange() }
        if stopC == 0{
            let stopView = SKView(frame: CGRect(x: 0, y: 0, width: h1 * 12, height: h1 * 8))
            stopView.center = view.center
            stopView.backgroundColor = .clear
            view.addSubview(stopView)
            let stopss = SKScene(size: stopView.frame.size)
            let bgimage = SKSpriteNode(imageNamed: "pose")
            bgimage.position = CGPoint(x: h1 * 6, y: h1 * 4)
            bgimage.size = CGSize(width: h1 * 12, height: h1 * 8)
            stopss.addChild(bgimage)
            stopss.backgroundColor = .clear
            stopView.presentScene(stopss)
            
            let startB = UIButton(frame: CGRect(x: h1 * 2, y: h1 * 1.0, width: h1 * 3, height: h1 * 1.5))
            startB.setTitle("再開", for: .normal)
            startB.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            startB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            startB.addTarget(self, action: #selector(firstVC.start(_:)), for: .touchUpInside)
            startB.setTitleColor(.white, for: .normal)
            stopView.addSubview(startB)
            
            let retryB = UIButton(frame: CGRect(x: h1 * 2, y: h1 * 3.3, width: h1 * 5, height: h1 * 1.5))
            retryB.setTitle("リトライ", for: .normal)
            retryB.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            retryB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            retryB.addTarget(self, action: #selector(firstVC.retry03(_:)), for: .touchUpInside)
            retryB.setTitleColor(.white, for: .normal)
            stopView.addSubview(retryB)
            
            retrunB = UIButton(frame: CGRect(x: h1 * 2, y: h1 * 5.6, width: h1 * 7, height: h1 * 1.5))
            retrunB.setTitle("ステージを出る", for: .normal)
            retrunB.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
            retrunB.titleLabel?.font = UIFont(name: "Ronde-B", size: h / 10)
            retrunB.addTarget(self, action: #selector(firstVC.return1(_:)), for: .touchUpInside)
            retrunB.setTitleColor(.white, for: .normal)
            stopView.addSubview(retrunB)
            BannerView.append(stopView)
            stopC = BannerView.count
            if MoneyFlag1 == false{ addNendbanner(xp: 1.1, yp: 8, type: 1) }
        }else{
            self.view.bringSubviewToFront(BannerView[stopC - 1])
        }
        
        if stageN >= 1{
            retrunB.setTitle("ステージを出る", for: .normal)
        }else  if stageN <= -1{
            retrunB.setTitle("ホームに戻る", for: .normal)
        }
    }
    //一時停止ビューのリトライボタン
    @objc func retry03(_ sender: UIButton){
        self.view.sendSubviewToBack(BannerView[stopC - 1])
        stopButton.isEnabled = true
        menuButton.isEnabled = true
        InterType = 3
        
        if MoneyFlag1{ //広告を表示しない
            InterstitialFinish()
            return
        }
        
        InterCount += 1
        if InterCount == InterFN{
            InterCount = 0
            UserDefaults.standard.set(InterCount, forKey: "InterCountI")
            InterstitialDisplay() //動画インタースティシャル広告の表示
        }else{
            UserDefaults.standard.set(InterCount, forKey: "InterCountI")
            InterstitialFinish()  //動画インタースティシャル広告を見終わった扱いにしてゲームオーバービューを表示
        }
    }
    //一時停止ビューのステージを出るボタン
    @objc func return1(_ sender: UIButton){
        self.view.sendSubviewToBack(BannerView[stopC - 1])
        stopButton.isEnabled = true
        menuButton.isEnabled = true
        playstage = false
        Movestage()
    }
    //一時停止ビューの一時停止を解除するボタン
    @objc func start(_ sender: UIButton){
        PlaySE(SEnumber: 0)
        Viewtype = 0
        if MoneyFlag1 == false { BannerStatasChange() }
        self.view.sendSubviewToBack(BannerView[stopC - 1])
        stopButton.isEnabled = true
        menuButton.isEnabled = true
        playScene[0].isPaused = false
    }
   
    //4¥メニュー画面の表示
    func displaymenuView(){
        let xn = 5  ;let yn = 3
        let dx:CGFloat = 1.95
        let dy:CGFloat = 0.95
        
        if menuView == nil{
            //メニュービューの作成
            menuView = SKView(frame: self.view.frame) ;view.addSubview(menuView)
            menuScene = SKScene(size: view.frame.size)
            let background = SKSpriteNode(imageNamed: "menu")
            background.position = CGPoint(x: w / 2, y: h / 2)
            background.size = CGSize(width: w, height: h)
            menuScene.addChild(background)
            menuView.presentScene(menuScene)
            
            //バックボタンの作成
            let backButton = UIButton(frame: CGRect(x: w - h1 * 2.2 ,y: h1 * 0.2,width: h1 * 1.5 ,height: h1 * 1.5))
            backButton.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
            backButton.addTarget(self, action: #selector(firstVC.menuBack(_:)), for: .touchUpInside)
            menuView.addSubview(backButton)
            
            //無変更部分の配置
            let catSprinte = SKSpriteNode(imageNamed: "catS2")
            catSprinte.scale(to: CGSize(width: h1 * 2.0 , height: h1 * 2.0))
            catSprinte.position = CGPoint(x: w1 * 1.2, y: h1 * 8.8)
            menuScene.addChild(catSprinte)
            
            let label1 = SKLabelNode(text: "Name:ポン吉")
            label1.fontName = "Ronde-B"
            label1.fontSize = h1 * 0.6
            label1.position = CGPoint(x: w1 * 2.2, y: h1 * 8.6)
            label1.fontColor = .white
            label1.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label1)
            let label2 = SKLabelNode(text: "状態:")
            label2.fontName = "Ronde-B"
            label2.fontSize = h1 * 0.6
            label2.position = CGPoint(x: w1 * 5.5, y: h1 * 8.6)
            label2.fontColor = .white
            label2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label2)
            menuLabel.append(label2)
            
            let label3 = SKLabelNode(text: "ステータス")
            label3.fontName = "Ronde-B"
            label3.fontSize = h1 * 0.6
            label3.position = CGPoint(x: w1 * 0.6, y: h1 * 7.4)
            label3.fontColor = .white
            label3.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label3)
            
            let label4 = SKLabelNode(text: "HP:")
            label4.fontName = "Ronde-B"
            label4.fontSize = h1 * 0.6
            label4.position = CGPoint(x: w1, y: h1 * 6.6)
            label4.fontColor = .white
            label4.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label4)
            menuLabel.append(label4)
            
            let label5 = SKLabelNode(text: "MP:")
            label5.fontName = "Ronde-B"
            label5.fontSize = h1 * 0.6
            label5.position = CGPoint(x: w1 * 4, y: h1 * 6.6)
            label5.fontColor = .white
            label5.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label5)
            menuLabel.append(label5)
            
            let label6 = SKLabelNode(text: "攻撃力:")
            label6.fontName = "Ronde-B"
            label6.fontSize = h1 * 0.6
            label6.position = CGPoint(x: w1 * 7, y: h1 * 6.6)
            label6.fontColor = .white
            label6.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label6)
            menuLabel.append(label6)
            
            let label7 = SKLabelNode(text: "スキル (タップでON、OFF切り替え可能)")
            label7.fontName = "Ronde-B"
            label7.fontSize = h1 * 0.6
            label7.position = CGPoint(x: w1 * 0.6, y: h1 * 5.5)
            label7.fontColor = .white
            label7.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label7)
            
            let label8 = SKLabelNode(text: "スペシャルスキル")
            label8.fontName = "Ronde-B"
            label8.fontSize = h1 * 0.6
            label8.position = CGPoint(x: w1 * 0.6, y: h1 * 1.7)
            label8.fontColor = .white
            label8.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
            menuScene.addChild(label8)
        
            let SkillName: [String] = ["","猫パンチ","連続パンチ","エアスピン","エアバーン","ドッチスピン","一閃","ウォールラン","テイルフック","HPアップ1","HPアップ2","MPアップ1","MPアップ2","攻撃力アップ"]
            for yi in 0..<yn{
                for xi in 0..<xn{
                    let n = (xi + 1) + xn * yi
                    if n <= 13{
                        let Button = UIButton(frame: CGRect(x: 0 , y: 0, width: h1 * 2.5, height: h1))
                        Button.center = CGPoint(x: w1 * 0.95 + w1 * dx * CGFloat(xi) , y: h1 * 5.0 + h1 * dy * CGFloat(yi)  )
                        Button.setTitle(SkillName[n], for: .normal)
                        Button.setTitleColor(.white, for: .normal)
                        Button.titleLabel?.font = UIFont(name: "Ronde-B", size: h1 * 0.4)
                        Button.accessibilityValue = "\(n)"
                        Button.addTarget(self, action: #selector(firstVC.menuB1(_:)), for: .touchUpInside)
                        Button.alpha = 0
                        Button.isEnabled = false
                        menuView.addSubview(Button)
                        MButton.append(Button)
                    }
                }
            }
            
            let Button1 = UIButton(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
            Button1.center = CGPoint(x: w1 * 1.8, y: h1 * 9.0)
            Button1.setTitle("ファイアボール  50", for: .normal)
            Button1.setTitleColor(.white, for: .normal)
            Button1.titleLabel?.font = UIFont(name: "Ronde-B", size: h1 * 0.4)
            Button1.accessibilityValue = "1"
            Button1.addTarget(self, action: #selector(firstVC.menuB2(_:)), for: .touchUpInside)
            Button1.alpha = 0
            Button1.isEnabled = false
            menuView.addSubview(Button1)
            MButton.append(Button1)
            
            let Button2 = UIButton(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
            Button2.center = CGPoint(x: w1 * 5, y: h1 * 9.0)
            Button2.setTitle("アイスブレイク  100", for: .normal)
            Button2.setTitleColor(.white, for: .normal)
            Button2.titleLabel?.font = UIFont(name: "Ronde-B", size: h1 * 0.4)
            Button2.accessibilityValue = "2"
            Button2.addTarget(self, action: #selector(firstVC.menuB2(_:)), for: .touchUpInside)
            Button2.alpha = 0
            Button2.isEnabled = false
            menuView.addSubview(Button2)
            MButton.append(Button2)
            
            let Button3 = UIButton(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
            Button3.center = CGPoint(x: w1 * 8.2, y: h1 * 9.0)
            Button3.setTitle("ウィンドオーラ  20", for: .normal)
            Button3.setTitleColor(.white, for: .normal)
            Button3.titleLabel?.font = UIFont(name: "Ronde-B", size: h1 * 0.4)
            Button3.accessibilityValue = "3"
            Button3.addTarget(self, action: #selector(firstVC.menuB2(_:)), for: .touchUpInside)
            Button3.alpha = 0
            Button3.isEnabled = false
            menuView.addSubview(Button3)
            MButton.append(Button3)
        }else{
            self.view.bringSubviewToFront(menuView)
        }
        
        let scene = playScene[0] as! GameController
        let PCondition = scene.PconAfter
        let NoWind = scene.NoWindFlag
        let NoMagic = scene.NoMagicFlag
        
        //プレイヤーステータスの変更部分
        //スキルの取得状況
        var SkillGetFlag = PSGet
        var SkillOnFlag = PSOn
        var HoldActionType = HAType
        if Practice{
            SkillGetFlag = PraPSGet
            SkillOnFlag = PraPSOn
            HoldActionType = PraHAType
        }
        
        //状態異常の設定
        var context: String = "正常"
        if PCondition == 1 { context = "軽化" }
        if PCondition == 2 {
            context = "重化"
            if SkillGetFlag[16]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 8.2, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
            if SkillGetFlag[7]{
                let BMark2 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 2.5, height: h1))
                BMark2.center = CGPoint(x: w1 * 0.95 + w1 * dx * 1 , y: h1 * 5.0 + h1 * dy * 1  )
                BMark2.image = UIImage(named: "batu")
                menuView.addSubview(BMark2)
                menuDViwe.append(BMark2)
            }
            if SkillGetFlag[8]{
                let BMark3 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 2.5, height: h1))
                BMark3.center = CGPoint(x: w1 * 0.95 + w1 * dx * 2 , y: h1 * 5.0 + h1 * dy * 1  )
                BMark3.image = UIImage(named: "batu")
                menuView.addSubview(BMark3)
                menuDViwe.append(BMark3)
            }
        }
        if PCondition == 3 {
            context = "魔法封印"
            if SkillGetFlag[14]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 1.8, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
            if SkillGetFlag[15]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 5, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
            if SkillGetFlag[16]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 8.2, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
        }
        
        if NoWind{
            context = context + "（風魔禁止）"
            if SkillGetFlag[16]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 8.2, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
        }
        
        if NoMagic{
            context = context + "（魔法禁止）"
            if SkillGetFlag[14]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 1.8, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
            if SkillGetFlag[15]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 5, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
            if SkillGetFlag[16]{
                let BMark1 = UIImageView(frame: CGRect(x: 0 , y: 0, width: h1 * 4.0, height: h1))
                BMark1.center = CGPoint(x: w1 * 8.2, y: h1 * 9.0)
                BMark1.image = UIImage(named: "batu")
                menuView.addSubview(BMark1)
                menuDViwe.append(BMark1)
            }
        }
        
        self.menuLabel[0].text = "状態:" + context
        //体力
        self.menuLabel[1].text = "HP:" + String(PlayerHP) + "/" + String(PlayerMaxHP)
        //魔力
        self.menuLabel[2].text = "MP:" + String(PlayerMP) + "/" + String(PlayerMaxMP)
        //攻撃力
        self.menuLabel[3].text = "攻撃力:" + String(PlayerAttackP)
        
        for n in 1...13{
            if SkillGetFlag[n]{
                MButton[n - 1].alpha = 1
                MButton[n - 1].isEnabled = true
            }else{
                MButton[n - 1].alpha = 0
                MButton[n - 1].isEnabled = false
            }
            if SkillOnFlag[n]{
                MButton[n - 1].setTitleColor(.white, for: .normal)
            }else{
                MButton[n - 1].setTitleColor(.gray, for: .normal)
            }
        }
        for n in 14...16{
            if SkillGetFlag[n]{
                MButton[n - 1].alpha = 1
                MButton[n - 1].isEnabled = true
            }else{
                MButton[n - 1].alpha = 0
                MButton[n - 1].isEnabled = false
            }
        }
        
        if HoldActionType == 0{
            MButton[13].setTitleColor(.gray, for: .normal)
            MButton[14].setTitleColor(.gray, for: .normal)
            MButton[15].setTitleColor(.gray, for: .normal)
        }
        if HoldActionType == 1{
            MButton[13].setTitleColor(.white, for: .normal)
            MButton[14].setTitleColor(.gray, for: .normal)
            MButton[15].setTitleColor(.gray, for: .normal)
        }
        if HoldActionType == 2{
            MButton[13].setTitleColor(.gray, for: .normal)
            MButton[14].setTitleColor(.white, for: .normal)
            MButton[15].setTitleColor(.gray, for: .normal)
        }
        if HoldActionType == 3{
            MButton[13].setTitleColor(.gray, for: .normal)
            MButton[14].setTitleColor(.gray, for: .normal)
            MButton[15].setTitleColor(.white, for: .normal)
        }
    }
    //習得スキルのON,OFF切り替えボタン
    @objc func menuB1(_ sender: UIButton){
        if let name = sender.accessibilityValue{
            if let n = Int(name){
                PlaySE(SEnumber: 9)
                SKillChange(Number: n)
            }
        }
    }
    //スキル変更によるステータスの変化
    func SKillChange(Number n: Int){
        if Practice == false{ //通常モード
            if PSOn[n]{
                PSOn[n] = false
                if menuView != nil{
                    MButton[n - 1].setTitleColor(.gray, for: .normal)
                }
                UserDefaults.standard.set(false, forKey: "SkillOn\(n)")
                
            }else{
                PSOn[n] = true
                if menuView != nil{
                    MButton[n - 1].setTitleColor(.white, for: .normal)
                }
                UserDefaults.standard.set(true, forKey: "SkillOn\(n)")
            }
            
            if n >= 9{
                var HPplus = 0;var MPplus = 0
                if PSOn[9]  { HPplus += 50 } ;if PSOn[10] { HPplus += 50 }
                if PSOn[11] { MPplus += 50 } ;if PSOn[12] { MPplus += 50 }
                PlayerMaxHP = 100 + HPplus ;PlayerMaxMP = 100 + MPplus
                if PSOn[13] { PlayerAttackP = 20 } else { PlayerAttackP = 10 }
                if PlayerHP >= PlayerMaxHP { PlayerHP = PlayerMaxHP }
                if PlayerMP >= PlayerMaxMP { PlayerMP = PlayerMaxMP }
                ChangeHPbar(pHP: PlayerHP)
                ChangeMPbar(pMP: PlayerMP)
                if menuView != nil{
                    menuLabel[1].text = "HP:" + String(PlayerHP) + "/" + String(PlayerMaxHP)
                    menuLabel[2].text = "MP:" + String(PlayerMP) + "/" + String(PlayerMaxMP)
                    menuLabel[3].text = "攻撃力:" + String(PlayerAttackP)
                }
            }
        }else{                //練習モード
            if PraPSOn[n]{
                PraPSOn[n] = false
                if menuView != nil{
                    MButton[n - 1].setTitleColor(.gray, for: .normal)
                }
            }else{
                PraPSOn[n] = true
                if menuView != nil{
                    MButton[n - 1].setTitleColor(.white, for: .normal)
                }
            }
            if n >= 9{
                var HPplus = 0;var MPplus = 0
                if PraPSOn[9]  { HPplus += 50 } ;if PraPSOn[10] { HPplus += 50 }
                if PraPSOn[11] { MPplus += 50 } ;if PraPSOn[12] { MPplus += 50 }
                PlayerMaxHP = 100 + HPplus ;PlayerMaxMP = 100 + MPplus
                if PraPSOn[13] { PlayerAttackP = 20 } else { PlayerAttackP = 10 }
                if PlayerHP >= PlayerMaxHP { PlayerHP = PlayerMaxHP }
                if PlayerMP >= PlayerMaxMP { PlayerMP = PlayerMaxMP }
                ChangeHPbar(pHP: PlayerHP)
                ChangeMPbar(pMP: PlayerMP)
                if menuView != nil{
                    menuLabel[1].text = "HP:" + String(PlayerHP) + "/" + String(PlayerMaxHP)
                    menuLabel[2].text = "MP:" + String(PlayerMP) + "/" + String(PlayerMaxMP)
                    menuLabel[3].text = "攻撃力:" + String(PlayerAttackP)
                }
            }
        }
    }
    //スペシャルスキルの切り替えボタン
    @objc func menuB2(_ sender: UIButton){
        if let name = sender.accessibilityValue{
            if let n = Int(name){
                if Practice == false{   //通常モード
                    if n == 1 && HAType != 1{
                        PlaySE(SEnumber: 10)
                        HAType = 1
                        MButton[13].setTitleColor(.white, for: .normal)
                        MButton[14].setTitleColor(.gray, for: .normal)
                        MButton[15].setTitleColor(.gray, for: .normal)
                        if Practice == false{ UserDefaults.standard.set(1, forKey: "HAType") }
                    }
                    if n == 2 && HAType != 2{
                        PlaySE(SEnumber: 10)
                        HAType = 2
                        MButton[13].setTitleColor(.gray, for: .normal)
                        MButton[14].setTitleColor(.white, for: .normal)
                        MButton[15].setTitleColor(.gray, for: .normal)
                        if Practice == false{ UserDefaults.standard.set(2, forKey: "HAType") }
                    }
                    if n == 3 && HAType != 3{
                        PlaySE(SEnumber: 10)
                        HAType = 3
                        MButton[13].setTitleColor(.gray, for: .normal)
                        MButton[14].setTitleColor(.gray, for: .normal)
                        MButton[15].setTitleColor(.white, for: .normal)
                        if Practice == false{ UserDefaults.standard.set(3, forKey: "HAType") }
                    }
                }else{                  //練習モード
                    if n == 1 && PraHAType != 1{
                        PlaySE(SEnumber: 10)
                        PraHAType = 1
                        MButton[13].setTitleColor(.white, for: .normal)
                        MButton[14].setTitleColor(.gray, for: .normal)
                        MButton[15].setTitleColor(.gray, for: .normal)
                    }
                    if n == 2 && PraHAType != 2{
                        PlaySE(SEnumber: 10)
                        PraHAType = 2
                        MButton[13].setTitleColor(.gray, for: .normal)
                        MButton[14].setTitleColor(.white, for: .normal)
                        MButton[15].setTitleColor(.gray, for: .normal)
                    }
                    if n == 3 && PraHAType != 3{
                        PlaySE(SEnumber: 10)
                        PraHAType = 3
                        MButton[13].setTitleColor(.gray, for: .normal)
                        MButton[14].setTitleColor(.gray, for: .normal)
                        MButton[15].setTitleColor(.white, for: .normal)
                    }
                }
            }
        }
    }
    //メニュー終了ボタン
    @objc func menuBack(_ sender: UIButton) {
        PlaySE(SEnumber: 12)
        Viewtype = 0
        if menuDViwe.isEmpty == false{
            for n in 0 ..< menuDViwe.count{ menuDViwe[n].removeFromSuperview() }
            menuDViwe.removeAll()
        }
        if MoneyFlag1 == false { BannerStatasChange() }
        self.view.sendSubviewToBack(menuView)
        playScene[0].isPaused = false
        let scene = playScene[0] as! GameController
        scene.skillRead()
    }
    
    //4¥スキル習得の処理
    func SkillLearning(N:Int){
        stopButton.isEnabled = false
        menuButton.isEnabled = false
        UserDefaults.standard.set(true, forKey:"SkillGet\(N)")
        PSGet[N] = true
        if N <= 13{
            UserDefaults.standard.set(true, forKey: "SkillOn\(N)")
            PSOn[N] = true
        }else if N == 14{
            UserDefaults.standard.set(1, forKey: "HAType")
            HAType = 1
        }
        //スキル取得音
        PlaySE(SEnumber: 11)  //よう変更
        let SkillName: [String] = ["","猫パンチ","連続パンチ","エアスピン","エアバーン","ドッチスピン","一閃","ウォールラン","テイルフック","HPアップ1","HPアップ2","MPアップ1","MPアップ2","攻撃力アップ","ファイアボール","アイスブレイク","ウィンドオーラ"]
        let skillButton = UIButton(frame: CGRect(x: 0, y: 0, width: h1 * 12, height: h1 * 2))
        skillButton.center = view.center
        skillButton.setBackgroundImage(UIImage(named: "pose"), for: .normal)
        skillButton.setTitle(SkillName[N] + "  を習得した。", for: .normal)
        skillButton.setTitleColor(.white, for: .normal)
        skillButton.titleLabel?.font = UIFont(name: "Ronde-B", size: h1 * 0.8)
        skillButton.accessibilityValue = String(N)
        skillButton.addTarget(self, action: #selector(firstVC.skillB(_:)), for: .touchUpInside)
        view.addSubview(skillButton)
    }
    
    @objc func skillB(_ sender: UIButton) {
        let nn: [Int] = [0,4,5,6,7,8,9,10,11,0,0,0,0,0,12,13,14]
        if let name = sender.accessibilityValue{
            if let n = Int(name){
                if n <= 8 || n >= 14{
                    discriptionChangeN(disN: nn[n], display: true)
                }else{
                    menuButton.isEnabled = true
                    stopButton.isEnabled = true
                    PlaySE(SEnumber: 12)
                    playScene[0].isPaused = false
                    let scene = playScene[0] as! GameController
                    scene.skillRead()
                }
            }
        }
        sender.removeFromSuperview()
    }
    
    //4¥テレビビューの表示
    func displayTVView(TVnumber: Int){
        let TVSize = CGSize(width: w * 0.9, height: w * 0.9 * 9.0 / 16.0)   //テレビに移す映像のサイズ
        let TVPosition = view.center                                        //テレビに移す映像の位置
        func ReadTVMovie(MovieNamad: String) -> AVPlayer{
            let moviePath = Bundle.main.path(forResource: "TV/" + MovieNamad, ofType: "mp4")
            let url = URL(fileURLWithPath: moviePath!)
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            return player
        }
        
        PlaySE(SEnumber: 17)
        if TVView == nil{
            //テレビムービービューの作成
            TVMovieView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            view.addSubview(TVMovieView)
            
            //テレビビューの作成
            TVView = SKView(frame: CGRect(x: 0 , y: 0 , width: w, height: h))
            TVView.backgroundColor = .clear
            view.addSubview(TVView)
            
            //テレビの静止画を表示するスクリーンの作成
            TVScene = SKScene(size: view.frame.size)
            TVScene.backgroundColor = .clear
            TVView.presentScene(TVScene)
            
            TVPictureScene = SKSpriteNode(imageNamed: "tv1_1")
            TVPictureScene.scale(to: TVSize)
            TVPictureScene.position = TVPosition
            TVPictureScene.alpha = 0
            TVScene.addChild(TVPictureScene)
            
            //テレビの動画を再生するスクリーンの作成
            let moviePath = Bundle.main.path(forResource: "TV/tv0", ofType: "mp4")
            let url = URL(fileURLWithPath: moviePath!)
            let player = AVPlayer(url: url)
            TVMovieScene = AVPlayerLayer(player: player)
            TVMovieScene.frame.size = TVSize
            TVMovieScene.position = TVPosition
            TVMovieView.layer.addSublayer(TVMovieScene)
            
            let TVMScene = SKScene(size: view.frame.size)
            TVMovieView.presentScene(TVMScene)
            let BGpicture = SKSpriteNode(imageNamed: "tv")
            BGpicture.position = self.view.center
            BGpicture.scale(to: CGSize(width: w, height: w))
            BGpicture.zPosition = -100
            TVMScene.addChild(BGpicture)
            
            let TVButton = UIButton(frame: CGRect(x: 0, y: 0, width: w * 0.9, height: w * 9.0 / 16.0 * 0.9))
            TVButton.center = view.center
            TVButton.backgroundColor = .clear
            TVButton.alpha = 0.1
            TVButton.addTarget(self, action: #selector(firstVC.TVNext), for: .touchUpInside)
            TVView.addSubview(TVButton)
        }else{
            let moviePath = Bundle.main.path(forResource: "TV/tv0", ofType: "mp4")
            let url = URL(fileURLWithPath: moviePath!)
            let player = AVPlayer(url: url)
            TVMovieScene.player = player
            view.bringSubviewToFront(TVMovieView)
            view.bringSubviewToFront(TVView)
        }
        
        TVCount = 0
        if TVPicture.isEmpty == false{
            TVPicture.removeAll()
        }
        if TVMovie.isEmpty == false{
            TVMovie.removeAll()
        }
        if       TVnumber == 1{
            TVPicture.append(SKTexture(imageNamed: "tv1_1"))
            TVPicture.append(SKTexture(imageNamed: "tv1_2"))
        }else if TVnumber >= 2{
            TVMovie.append( ReadTVMovie(MovieNamad: "tv\(TVnumber)_1")  )
        }
    }
    //テレビでc次の画面を表示
    @objc func TVNext(_ sender: UIButton){
        print("TVButton")
        if TVPicture.isEmpty == false{
            //静止画切り替え処理
            if TVCount == TVPicture.count{//最後
                PlaySE(SEnumber: 19)
                self.view.sendSubviewToBack(TVView)
                self.view.sendSubviewToBack(TVMovieView)
                TVPictureScene.alpha = 0
                menuButton.isEnabled = true
                stopButton.isEnabled = true
                playScene[0].isPaused = false
                let scene = self.playScene[0] as! GameController
                scene.skillRead()
            }else{
                PlaySE(SEnumber: 18)
                TVPictureScene.run(SKAction.setTexture(TVPicture[TVCount]))
                if TVCount == 0{//初回
                    TVPictureScene.alpha = 1.0
                }
            }
        }else if TVMovie.isEmpty == false{
            //動画切り替え処理
            if TVCount == TVMovie.count{//最後
                PlaySE(SEnumber: 19)
                self.view.sendSubviewToBack(TVView)
                self.view.sendSubviewToBack(TVMovieView)
                playMovie.pause()
                playMovie.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                
                menuButton.isEnabled = true
                stopButton.isEnabled = true
                playScene[0].isPaused = false
                let scene = self.playScene[0] as! GameController
                scene.skillRead()
            }else{
                PlaySE(SEnumber: 18)
                if TVCount != 0{//初回以外
                    playMovie.pause()
                    playMovie.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
                }
                playMovie = TVMovie[TVCount]
                TVMovieScene.player = playMovie
                playMovie.play()
            }
        }
        TVCount += 1
    }
    
    //4¥HPバーの変更に使用
    func ChangeHPbar(pHP: Int){
        var HP: Float!
        PlayerHP = pHP
        if pHP <= 0{ HP = 0.0 }else{HP = Float(pHP) / Float(PlayerMaxHP)}
        HPgauge.setProgress(HP, animated: false)
    }
    //4¥MPバーの変更に使用
    func ChangeMPbar(pMP: Int){
        var MP: Float!
        PlayerMP = pMP
        if pMP <= 0{ MP = 0.0 }else{MP = Float(pMP) / Float(PlayerMaxMP)}
        MPgauge.setProgress(MP, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    //4¥操作説明画面の表示
    func displayHowToPlayView(){
        if HowToPlayView == nil{
            HowToPlayView = SKView(frame: self.view.frame)
            view.addSubview(HowToPlayView)
            
            var FirstP: [CGFloat] = [25,90]    //左上のボタン位置
            var Size: [CGFloat] = [35,8]       //ボタンサイズ
            var Ndis:[CGFloat] = [50,13]       //隣のボタンの間隔
            var CharaSize:CGFloat = 4          //文字サイズ
            
            var gettextP1: CGFloat = 9.5
            var gettextP2: CGFloat = 12.5
            var gettextSize: [CGFloat] = [20,10]
            var gettextFSize: CGFloat = 3

            //変換
            FirstP[0] = FirstP[0] * x1
            FirstP[1] = h - FirstP[1] * y1
            Size[0] = Size[0] * x1
            Size[1] = Size[1] * y1
            Ndis[0] = Ndis[0] * x1
            Ndis[1] = Ndis[1] * y1
            CharaSize = CharaSize * x1
            gettextP1 = gettextP1 * x1
            gettextP2 = gettextP2 * x1
            gettextSize[0] = gettextSize[0] * x1
            gettextSize[1] = gettextSize[0] * y1
            gettextFSize = gettextFSize * x1

            let xx = w / 18 ;let yy = h / 10
            let backButton = UIButton(frame: CGRect(x: xx * 0.2 ,y: yy * 0.2,width: xx * 1.5 ,height:yy * 1.5))
            backButton.setImage(UIImage.init(named: "Uターン矢印"), for: .normal)
            backButton.addTarget(self, action: #selector(firstVC.displayFV(_:)), for: .touchUpInside)
            HowToPlayView.addSubview(backButton)
            
            let d1Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d1Button.center = CGPoint(x: FirstP[0], y: FirstP[1])
            d1Button.setTitle("歩く、走る", for: .normal)
            d1Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d1Button.setTitleColor(.black, for: .normal)
            d1Button.addTarget(self, action: #selector(firstVC.d1(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d1Button) //ボタンを表示
            
            let d2Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d2Button.center = CGPoint(x: FirstP[0], y: FirstP[1] + Ndis[1] * 1 )
            d2Button.setTitle("ジャンプ", for: .normal)
            d2Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d2Button.setTitleColor(.black, for: .normal)
            d2Button.addTarget(self, action: #selector(firstVC.d2(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d2Button) //ボタンを表示
            
            let d14Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d14Button.center = CGPoint(x: FirstP[0], y: FirstP[1] + Ndis[1] * 2 )
            d14Button.setTitle("画面説明", for: .normal)
            d14Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d14Button.setTitleColor(.black, for: .normal)
            d14Button.addTarget(self, action: #selector(firstVC.d14(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d14Button) //ボタンを表示
            
            let d3Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d3Button.center = CGPoint(x: FirstP[0], y: FirstP[1] + Ndis[1] * 3 )
            d3Button.setTitle("猫パンチ", for: .normal)
            d3Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d3Button.setTitleColor(.black, for: .normal)
            d3Button.addTarget(self, action: #selector(firstVC.d3(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext1 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext1.center = CGPoint(x: d3Button.center.x - gettextP1, y: d3Button.center.y)
            gettext1.text = "習得済"
            gettext1.textColor = .blue
            gettext1.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[1] == false{
                gettext1.text = "未習得"
                gettext1.textColor = .red
            }
            HowToPlayView.addSubview(gettext1)
            HowToPlayView.addSubview(d3Button) //ボタンを表示
            
            let d4Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d4Button.center = CGPoint(x: FirstP[0], y: FirstP[1] + Ndis[1] * 4 )
            d4Button.setTitle("連続パンチ", for: .normal)
            d4Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d4Button.setTitleColor(.black, for: .normal)
            d4Button.addTarget(self, action: #selector(firstVC.d4(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext2 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext2.center = CGPoint(x: d4Button.center.x - gettextP1, y: d4Button.center.y)
            gettext2.text = "習得済"
            gettext2.textColor = .blue
            gettext2.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[2] == false{
                gettext2.text = "未習得"
                gettext2.textColor = .red
            }
            HowToPlayView.addSubview(gettext2)
            HowToPlayView.addSubview(d4Button) //ボタンを表示
            
            
            let d5Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d5Button.center = CGPoint(x: FirstP[0], y: FirstP[1] + Ndis[1] * 5 )
            d5Button.setTitle("エアスピン", for: .normal)
            d5Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d5Button.setTitleColor(.black, for: .normal)
            d5Button.addTarget(self, action: #selector(firstVC.d5(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext3 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext3.center = CGPoint(x: d5Button.center.x - gettextP1, y: d5Button.center.y)
            gettext3.text = "習得済"
            gettext3.textColor = .blue
            gettext3.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[3] == false{
                gettext3.text = "未習得"
                gettext3.textColor = .red
            }
            HowToPlayView.addSubview(gettext3)
            HowToPlayView.addSubview(d5Button) //ボタンを表示
            
            let d6Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d6Button.center = CGPoint(x: FirstP[0], y: FirstP[1] + Ndis[1] * 6 )
            d6Button.setTitle("エアバーン", for: .normal)
            d6Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d6Button.setTitleColor(.black, for: .normal)
            d6Button.addTarget(self, action: #selector(firstVC.d6(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext4 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext4.center = CGPoint(x: d6Button.center.x - gettextP1, y: d6Button.center.y)
            gettext4.text = "習得済"
            gettext4.textColor = .blue
            gettext4.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[4] == false{
                gettext4.text = "未習得"
                gettext4.textColor = .red
            }
            HowToPlayView.addSubview(gettext4)
            HowToPlayView.addSubview(d6Button) //ボタンを表示
            
            let d7Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d7Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] )
            d7Button.setTitle("ドッチスピン", for: .normal)
            d7Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d7Button.setTitleColor(.black, for: .normal)
            d7Button.addTarget(self, action: #selector(firstVC.d7(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext5 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext5.center = CGPoint(x: d7Button.center.x - gettextP2, y: d7Button.center.y)
            gettext5.text = "習得済"
            gettext5.textColor = .blue
            gettext5.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[5] == false{
                gettext5.text = "未習得"
                gettext5.textColor = .red
            }
            HowToPlayView.addSubview(gettext5)
            HowToPlayView.addSubview(d7Button) //ボタンを表示
            
            let d8Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d8Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] + Ndis[1])
            d8Button.setTitle("一閃", for: .normal)
            d8Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d8Button.setTitleColor(.black, for: .normal)
            d8Button.addTarget(self, action: #selector(firstVC.d8(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext6 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext6.center = CGPoint(x: d8Button.center.x - gettextP2, y: d8Button.center.y)
            gettext6.text = "習得済"
            gettext6.textColor = .blue
            gettext6.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[6] == false{
                gettext6.text = "未習得"
                gettext6.textColor = .red
            }
            HowToPlayView.addSubview(gettext6)
            HowToPlayView.addSubview(d8Button) //ボタンを表示
            
            let d9Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d9Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] + Ndis[1] * 2 )
            d9Button.setTitle("ウォールラン", for: .normal)
            d9Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d9Button.setTitleColor(.black, for: .normal)
            d9Button.addTarget(self, action: #selector(firstVC.d9(_:)), for: .touchUpInside) //ボタンのアクションを設定
            
            let gettext7 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext7.center = CGPoint(x: d9Button.center.x - gettextP2, y: d9Button.center.y)
            gettext7.text = "習得済"
            gettext7.textColor = .blue
            gettext7.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[7] == false{
                gettext7.text = "未習得"
                gettext7.textColor = .red
            }
            HowToPlayView.addSubview(gettext7)
            HowToPlayView.addSubview(d9Button) //ボタンを表示
            
            let d10Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d10Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] + Ndis[1] * 3 )
            d10Button.setTitle("テイルフック", for: .normal)
            d10Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d10Button.setTitleColor(.black, for: .normal)
            
            let gettext8 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext8.center = CGPoint(x: d10Button.center.x - gettextP2, y: d10Button.center.y)
            gettext8.text = "習得済"
            gettext8.textColor = .blue
            gettext8.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[8] == false{
                gettext8.text = "未習得"
                gettext8.textColor = .red
            }
            HowToPlayView.addSubview(gettext8)
            d10Button.addTarget(self, action: #selector(firstVC.d10(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d10Button) //ボタンを表示
            
            let d11Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d11Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] + Ndis[1] * 4 )
            d11Button.setTitle("ファイアボール", for: .normal)
            d11Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d11Button.setTitleColor(.black, for: .normal)
            
            let gettext9 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext9.center = CGPoint(x: d11Button.center.x - gettextP2, y: d11Button.center.y)
            gettext9.text = "習得済"
            gettext9.textColor = .blue
            gettext9.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[14] == false{
                gettext9.text = "未習得"
                gettext9.textColor = .red
            }
            HowToPlayView.addSubview(gettext9)
            d11Button.addTarget(self, action: #selector(firstVC.d11(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d11Button) //ボタンを表示
            
            let d12Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d12Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] + Ndis[1] * 5 )
            d12Button.setTitle("アイスブレイク", for: .normal)
            d12Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d12Button.setTitleColor(.black, for: .normal)
            
            let gettext10 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext10.center = CGPoint(x: d12Button.center.x - gettextP2, y: d12Button.center.y)
            gettext10.text = "習得済"
            gettext10.textColor = .blue
            gettext10.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[15] == false{
                gettext10.text = "未習得"
                gettext10.textColor = .red
            }
            HowToPlayView.addSubview(gettext10)
            d12Button.addTarget(self, action: #selector(firstVC.d12(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d12Button) //ボタンを表示
            
            
            let d13Button = UIButton(frame: CGRect(x:0, y: 0, width: Size[0], height: Size[1]))
            d13Button.center = CGPoint(x: FirstP[0] + Ndis[0], y: FirstP[1] + Ndis[1] * 6 )
            d13Button.setTitle("ウィンドオーラ", for: .normal)
            d13Button.titleLabel?.font = UIFont(name: "Ronde-B", size: CharaSize)
            d13Button.setTitleColor(.black, for: .normal)
            
            let gettext11 = UILabel(frame: CGRect(x: 0, y: 0, width: gettextSize[0], height: gettextSize[1]))
            gettext11.center = CGPoint(x: d13Button.center.x - gettextP2, y: d13Button.center.y)
            gettext11.text = "習得済"
            gettext11.textColor = .blue
            gettext11.font = UIFont(name: "Ronde-B", size: gettextFSize)
            if PSGet[16] == false{
                gettext11.text = "未習得"
                gettext11.textColor = .red
            }
            HowToPlayView.addSubview(gettext11)
            d13Button.addTarget(self, action: #selector(firstVC.d13(_:)), for: .touchUpInside) //ボタンのアクションを設定
            HowToPlayView.addSubview(d13Button) //ボタンを表示
            
        }else{
            self.view.bringSubviewToFront(HowToPlayView)
        }
        let Scean = SKScene(size: HowToPlayView.frame.size)
        let background = SKSpriteNode(imageNamed: "bg0_2")
        background.position = CGPoint(x: w / 2, y: h / 2)
        background.size = CGSize(width: w, height: h)
        Scean.addChild(background)
        let book = SKSpriteNode(imageNamed: "book03")
        book.position = CGPoint(x: w / 2, y: h / 2)
        book.size = CGSize(width: w, height: h)
        Scean.addChild(book)
        HowToPlayView.presentScene(Scean)
    }
    //操作説明画面のボタン
    @objc func d1(_ sender: UIButton){ discriptionChangeN(disN: 1, display: true) }
    @objc func d2(_ sender: UIButton){ discriptionChangeN(disN: 2, display: true) }
    @objc func d3(_ sender: UIButton){ discriptionChangeN(disN: 4, display: true) }
    @objc func d4(_ sender: UIButton){ discriptionChangeN(disN: 5, display: true) }
    @objc func d5(_ sender: UIButton){ discriptionChangeN(disN: 6, display: true) }
    @objc func d6(_ sender: UIButton){ discriptionChangeN(disN: 7, display: true) }
    @objc func d7(_ sender: UIButton){ discriptionChangeN(disN: 8, display: true) }
    @objc func d8(_ sender: UIButton){ discriptionChangeN(disN: 9, display: true) }
    @objc func d9(_ sender: UIButton){ discriptionChangeN(disN: 10, display: true) }
    @objc func d10(_ sender: UIButton){ discriptionChangeN(disN: 11, display: true) }
    @objc func d11(_ sender: UIButton){ discriptionChangeN(disN: 12, display: true) }
    @objc func d12(_ sender: UIButton){ discriptionChangeN(disN: 13, display: true) }
    @objc func d13(_ sender: UIButton){ discriptionChangeN(disN: 14, display: true) }
    
    @objc func d14(_ sender: UIButton){ discriptionChangeN(disN: 3, display: true) }
    //タイトル画面表示のボタン
    @objc func displayFV(_ sender: UIButton) {
        PlaySE(SEnumber: 3)
        view.sendSubviewToBack(HowToPlayView)
    }
    
    //4¥操作説明画面で行う処理
    //どの説明ビューを表示するかを決める（displayがtrueならそのまま説明ビューを表示）
    func discriptionChangeN(disN: Int, display:Bool = false){
        discriptionN = disN   // 0なら何も表示しない　1以上で説明ビューを表示
        ReadMovie()
        if display{ displaydiscriptionView() }
    }
    //次の説明内容を表示する
    @objc func dislabel(_ sender: UIButton){
        NextdiscriptionView()
    }
    //説明ビューのアニメーション設定
    func OpendiscriptionView(){ //開くアニメ
        disLabeltext()
        PlaySE(SEnumber: 3)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear, animations: {
            self.discriptionView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (finished: Bool) in
            self.playMovie.play()
        }
    }
    func NextdiscriptionView(){//次の文章を表示するアニメ
        PlaySE(SEnumber: 4)
        playMovie.pause()                                                //再生しているムービーを停止
        playMovie.seek(to: CMTime(seconds: 0, preferredTimescale: 1))    //再生していたムービーの初期化
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
            self.discriptionView.transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
        }) { (finished: Bool) in
            self.discriptionPageN += 1
            self.disLabeltext()
        }
    }
    func finishdiscriptionView(){//閉じるアニメ
        PlaySE(SEnumber: 4)
        playMovie.pause()
        playMovie.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
        
        discriptionLabel1.text = ""
        discriptionLabel2.text = ""
        discriptionPageN = 1
        discriptionN = 0
            
        readMovie.removeAll()
        self.view.sendSubviewToBack(self.discriptionView)
        if playstage {
            menuButton.isEnabled = true
            stopButton.isEnabled = true
            playScene[0].isPaused = false
            let scene = self.playScene[0] as! GameController
            scene.skillRead()
        }
        
    }
    //4¥説明動画の読み込み
    func ReadMovie(){
        for n in 1...discriptionPageCount[discriptionN]{
            var url: URL!
            if discriptionN == 1{ //歩く、走る
                let moviePath = Bundle.main.path(forResource: "movie/walk", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 2{ //ジャンプ
                if n == 1{
                    let moviePath = Bundle.main.path(forResource: "movie/jump1", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else{
                    let moviePath = Bundle.main.path(forResource: "movie/jump2", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }
            }
            if discriptionN == 3{ //メニューの説明
                let moviePath = Bundle.main.path(forResource: "movie/menu", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 4{ //猫パンチ
                let moviePath = Bundle.main.path(forResource: "movie/attack1", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 5{ //連続パンチ
                let moviePath = Bundle.main.path(forResource: "movie/attack2", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 6{ //エアスピン
                let moviePath = Bundle.main.path(forResource: "movie/airattack1", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 7{ //エアバーン
                let moviePath = Bundle.main.path(forResource: "movie/airattack2", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 8{ //トッチロール
                let moviePath = Bundle.main.path(forResource: "movie/avoid", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 9{ //一閃
                if n == 1{
                    let moviePath = Bundle.main.path(forResource: "movie/avoidattack1", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else{
                    let moviePath = Bundle.main.path(forResource: "movie/avoidattack2", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }
            }
            if discriptionN == 10{ //ウォールラン
                if n == 1{
                    let moviePath = Bundle.main.path(forResource: "movie/wallrun1", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else{
                    let moviePath = Bundle.main.path(forResource: "movie/wallrun2", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }
            }
            if discriptionN == 11{ //テイルフック
                if n == 1{
                    let moviePath = Bundle.main.path(forResource: "movie/talehock1", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else if n == 2{
                    let moviePath = Bundle.main.path(forResource: "movie/talehock2", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else if n == 3{
                    let moviePath = Bundle.main.path(forResource: "movie/talehock3", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else{
                    let moviePath = Bundle.main.path(forResource: "movie/talehock4", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }
            }
            if discriptionN == 12{ //ファイヤボール
                let moviePath = Bundle.main.path(forResource: "movie/fireball", ofType: "mp4")
                url = URL(fileURLWithPath: moviePath!)
            }
            if discriptionN == 13{ //フリーズ
                if n == 1{
                    let moviePath = Bundle.main.path(forResource: "movie/ice1", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else{
                    let moviePath = Bundle.main.path(forResource: "movie/ice2", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }
            }
            if discriptionN == 14{ //ウインドオーラ
                if n == 1{
                    let moviePath = Bundle.main.path(forResource: "movie/wind1", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else if n == 2{
                    let moviePath = Bundle.main.path(forResource: "movie/wind2", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }else{
                    let moviePath = Bundle.main.path(forResource: "movie/wind3", ofType: "mp4")
                    url = URL(fileURLWithPath: moviePath!)
                }
            }
            
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            let player = AVPlayer(playerItem: playerItem)
            readMovie.append(player)
        }
    }
    //動画のリピート再生に使用
    @objc func endofMovie(){
        if let pp = playMovie{
            pp.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
            pp.play()
        }
    }
    //4¥説明ビューの文字を管理
    func disLabeltext(){
        if discriptionPageN <= discriptionPageCount[discriptionN]{
            playMovie = readMovie[discriptionPageN - 1]
            MovieLayer.player = playMovie
            if discriptionN == 1{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "歩く、走る"
                    discriptionLabel2.text = "左右にスワイプ"
                }
            }else if discriptionN == 2{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "ジャンプ"
                    discriptionLabel2.text = "上方向にフリック"
                }
                else{
                    discriptionLabel1.text = "空中移動"
                    discriptionLabel2.text = "空中状態中に左右にスワイプ"
                }
            }else if discriptionN == 3{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "画面説明"
                    discriptionLabel2.text = "メニュー画面ではステータスの確認やスキルのON、OFFの切り替えが可能"
                }
            }else if discriptionN == 4{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "猫パンチ"
                    discriptionLabel2.text = "地上状態中にタップ"
                }
            }else if discriptionN == 5{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "連続パンチ"
                    discriptionLabel2.text = "地上状態中に連続タップ\n猫パンチよりダメージ量が大きい"
                }
            }else if discriptionN == 6{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "エアスピン"
                    discriptionLabel2.text = "空中状態中にタップ"
                }
            }else if discriptionN == 7{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "エアバーン"
                    discriptionLabel2.text = "空中状態中に連続タップ\nエアスピンよりダメージ量が大きい"
                }
            }else if discriptionN == 8{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "ドッチスピン"
                    discriptionLabel2.text = "地上状態中に左右にスワイプ\n敵の攻撃や障害物の回避ができる"
                }
            }else if discriptionN == 9{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "一閃1"
                    discriptionLabel2.text = "ドッチスピン中にタップ"
                }else{
                    discriptionLabel1.text = "一閃2"
                    discriptionLabel2.text = "敵の攻撃や障害物の回避にも利用できる"
                }
            }else if discriptionN == 10{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "ウォールラン"
                    discriptionLabel2.text = "走る or 空中移動で壁に接触 "
                }else{
                    discriptionLabel1.text = "壁ジャンプ"
                    discriptionLabel2.text = "ウォールラン中にフリック"
                }
            }else if discriptionN == 11{
                if       discriptionPageN == 1{
                    discriptionLabel1.text = "テイルフック1"
                    discriptionLabel2.text = "バーにエアスピンを当てる"
                }else if discriptionPageN == 2{
                    discriptionLabel1.text = "テイルフック2"
                    discriptionLabel2.text = "テイルフック中はスワイプで移動が可能\n手を離すと跳ぶ"
                }else if discriptionPageN == 3{
                    discriptionLabel1.text = "テイルフック3"
                    discriptionLabel2.text = "テイルフックで跳んだ後はウォールランが使用できる"
                }else{
                    discriptionLabel1.text = "テイルフック4"
                    discriptionLabel2.text = "スワイプ移動は敵や障害物に回避にも利用できる"
                }
            }else if discriptionN == 12{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "ファイアボール"
                    discriptionLabel2.text = "地上状態中にホールド\nMP消費で前方に大ダメージ"
                }
            }else if discriptionN == 13{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "スペシャル変更"
                    discriptionLabel2.text = "メニュー画面を開いてスペシャル技を変更する"
                }else{
                    discriptionLabel1.text = "フリーズブレイク"
                    discriptionLabel2.text = "地上状態中にホールド\nMP消費量は非常は非常に大きい\n画面全体に超ダメージを与えれる"
                }
            }else if discriptionN == 14{
                if      discriptionPageN == 1{
                    discriptionLabel1.text = "スペシャル変更"
                    discriptionLabel2.text = "メニュー画面を開いてスペシャル技を変更する"
                }else if discriptionPageN == 2{
                    discriptionLabel1.text = "ウィンドオーラ１"
                    discriptionLabel2.text = "地上状態中にホールド\nスワイプで空中を自由に移動ができる\nタップ or 時間経過で解除される"
                }else{
                    discriptionLabel1.text = "ウィンドオーラ２"
                    discriptionLabel2.text = "敵の攻撃にも使用ができる\n威力は低いが特定の敵に大ダメージ"
                }
            }
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveLinear, animations: {
                self.discriptionView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }){ (finished: Bool) in
                self.playMovie.play()
            }
        }else{
            finishdiscriptionView()
        }
    }
    
    //4¥SE読み込みや再生に使う関数
    //SEの読み込み
    func ReadSE(SEname: String,ofType: String = "mp3",Volume: Float = 1.0){
        do{
            let SEPath = Bundle.main.path(forResource: "SE/" + SEname, ofType: ofType)
            let SEurl = URL(fileURLWithPath: SEPath!)
            let RSE = try AVAudioPlayer(contentsOf: SEurl)
            SE.append(RSE)
            RSE.volume = Volume
        }catch{
            print("error")
        }
    }
    //SEを再生
    func PlaySE(SEnumber n: Int){
        if SE[n].isPlaying{ SE[n].pause() }
        SE[n].currentTime = 0
        SE[n].play()
    }
    
    //4¥Nend広告表示に関する関数
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
                nadView.setNendID("38844342214a17f93d0e2ae20040db4f3a385b12", spotID: "963901")
            }
            if type == 2{
                nadView = NADView(frame: CGRect(x: w1 * xp, y: h1 * yp, width: 320, height: 100 ))
               nadView.setNendID("eb5ca11fa8e46315c2df1b8e283149049e8d235e", spotID: "70996")
            }
            if type == 3{
                nadView = NADView(frame: CGRect(x: w1 * xp, y: h1 * yp, width: 300, height: 250 ))
                nadView.setNendID("56c0c2dd82bdfd9a5f0f4f68c4705e32a2314fd6", spotID: "963902")
            }
            if Xcenter{ nadView.center.x = self.view.center.x  }
            if Ycenter{ nadView.center.y = self.view.center.y  }
            nadView.delegate = self
            nadView.load()
            BannerViwe.append(nadView)
            if Viewtype == 1{ titleView.addSubview(nadView) }
            if Viewtype == 3{ BannerView[goC - 1].addSubview(nadView) }
            if Viewtype == 4{ stageclearView.addSubview(nadView) }
            if Viewtype == 5{ BannerView[stopC - 1].addSubview(nadView) }
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
            if InterType == 1{ displayGameOverView() }  //ゲームオーバー時
            if InterType == 2{                          //ゲームクリア時
                StageSceneSave[stageN] = 0
                UserDefaults.standard.set(0, forKey: "stageScene\(stageN)")
                playstage = false
                Movestage()
            }
            view.sendSubviewToBack(StageFinishView)
            SceneF[0].removeFromParent()
            SceneF[0].removeAllChildren()
            SceneF.removeAll()
        }
        if InterType == 3{
            Movestage(MoveStageN: stageN, MoveSceneN: stagesceneN)
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
    
//4¥課金に関する処理の記述
    func iapManagerDidFinishPurchased() {
        //購入完了をユーザに知らせるアラートを表示
        //UserDefaultにBool値を保存する(例:isPurchased = true)
        //Indicatorを隠す処理
        
        if ProductID == "ponkiticminvalid"{ //広告非表示処理
            MoneyFlag1 = true //これがtrueだと広告が表示されない
            UserDefaults.standard.set(true, forKey: "MoneyF")
            
            if BannerView.isEmpty == false{
                for n in 0..<BannerView.count{
                    BannerView[n].removeFromSuperview()
                }
                BannerView.removeAll()
                goC = 0
                stopC = 0
            }
            self.view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "購入処理を完了しました", ButtonNumber: 100))
            
        }
    }
    //購入に失敗した時
    func iapManagerDidFailedPurchased() {
        //購入失敗をユーザに知らせるアラートなど
        self.view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "購入処理に失敗しました", ButtonNumber: 100))
        //Indicatorを隠す処理
    }
    //リストアが完了した時
    func iapManagerDidFinishRestore(_ productIdentifiers: [String]) {
        for identifier in productIdentifiers {
            if identifier == "ponkiticminvalid" {
                //リストア完了をユーザに知らせるアラートを表示
                MoneyFlag1 = true //これがtrueだと広告が表示されない
                UserDefaults.standard.set(true, forKey: "MoneyF")
                
                if BannerView.isEmpty == false{
                    for n in 0..<BannerView.count{
                        BannerView[n].removeFromSuperview()
                    }
                    BannerView.removeAll()
                    goC = 0
                    stopC = 0
                }
            }
            self.view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "復元処理を完了しました", ButtonNumber: 100))
        }
        //Indicatorを隠す処理
    }
    //1度もアイテム購入したことがなく、リストアを実行した時
    func iapManagerDidFailedRestoreNeverPurchase() {
        //先に購入をお願いするアラートを表示
        self.view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "購入履歴がありません", ButtonNumber: 100))
        //Indicatorを隠す処理
    }
    //リストアに失敗した時
    func iapManagerDidFailedRestore() {
        //リストア失敗をユーザに知らせるアラートを表示
        self.view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "復元処理に失敗しました", ButtonNumber: 100))
        //Indicatorを隠す処理
    }
    //特殊な購入時の延期の時
    func iapManagerDidDeferredPurchased() {
        //購入失敗をユーザに知らせるアラートを表示
        self.view.addSubview(CreateButton(Px: 0, Py: 0, width: 80, height: 30, FontSize: 5, text: "購入処理に失敗しました", ButtonNumber: 100))
        //Indicatorを隠す処理
    }
    
}

//4¥ゲームオーバー時に表示するシーン演出
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
//4¥ステージクリア時に表示するシーン演出
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

class SKAnimeScene: SKScene{
    func ReadTextureAnime(AtlasNamed:String,fileNamed:String ,Count:Int) -> [SKTexture]{
        var animeT: [SKTexture] = []
        let Atlas = SKTextureAtlas(named: AtlasNamed)
        for n in 1...Count{
            animeT.append(Atlas.textureNamed(fileNamed + String(n)))
        }
        return animeT
    }
}

//4¥タッチイベントを部分的に透過させるビュークラスの作成（ステージのインターフェイスに使用）
class TransparentView: SKView{
    var NotouchRect: [CGRect] = []
    func addNotTransparentArea(Rect:CGRect){
        NotouchRect.append(Rect)
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

//¥¥システムビューの透過設定
class SystemView: SKView{
    let NotouchRect: [CGRect] = [CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.15, height: UIScreen.main.bounds.size.height * 0.15)
                                ,CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.15, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.85)
                                ,CGRect(x: UIScreen.main.bounds.size.width * 0.85, y: 0, width: UIScreen.main.bounds.size.width * 0.15, height: UIScreen.main.bounds.size.height * 0.15)]
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

class SystemScrollView: UIScrollView{
    let NotouchRect: [CGRect] = [CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width * 0.15, height: UIScreen.main.bounds.size.height * 0.15)
                                ,CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.15, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.85)
                                ,CGRect(x: UIScreen.main.bounds.size.width * 0.85, y: 0, width: UIScreen.main.bounds.size.width * 0.15, height: UIScreen.main.bounds.size.height * 0.15)]
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

//4¥特殊演出を入れるボタン
class CustomButton: UIButton{
    var FirstImage: UIImage!
    var ChangeImage: UIImage!
    
    var SaveSize: CGSize = CGSize(width: 100, height: 100)
    var SaveSize2: CGSize = CGSize(width: 100, height: 100)
    var SavePoint: CGPoint = CGPoint(x: 0, y: 0)
    var SavePoint2: CGPoint = CGPoint(x: 0, y: 0)
    var SaveText: String = "no"
    var SaveText2: String = "no"
    var SaveNumber: Int = 0
    var SaveNumber2: Int = 0
    var SaveView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var SaveView2: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var OnFlag: Bool = false
    var firstFlag: Bool = true
    var SavetextView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    
    func firstImage(imageName: String){
        FirstImage = UIImage(named: imageName)
        self.setBackgroundImage(FirstImage, for: .normal)
    }
    func changeImage(imageName: String){ ChangeImage = UIImage(named: imageName) }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let Image = ChangeImage{
            self.setBackgroundImage(Image, for: .normal)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let Image = FirstImage{
            self.setBackgroundImage(Image, for: .normal)
        }
    }
}


class CustomtextView: UITextView,UITextViewDelegate{
    var SavetextView: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
}


extension SKView{
    func ClearView(){
        self.backgroundColor = .clear
        let ClearScene = SKScene(size: self.frame.size)
        ClearScene.backgroundColor = .clear
        self.presentScene(ClearScene)
    }
}


extension CGSize{
    func CGPointCalculation(OptionName:String) -> CGPoint{
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        let sx = self.width
        let sy = self.height
        var px:CGFloat = 0.0
        var py:CGFloat = 0.0
        if          OptionName == "upper"{
            px = w / 2
            py = sy / 2
        }else if    OptionName == "bottom"{
            px = w / 2
            py = h - sy / 2
        }else if    OptionName == "right"{
            px = w - sx / 2
            py = h / 2
        }else if    OptionName == "left"{
            px = sx / 2
            py = h / 2
        }else if    OptionName == "upper_right"{
            px = w - sx / 2
            py = sy / 2
        }else if    OptionName == "upper_left"{
            px = sx / 2
            py = sy / 2
        }else if    OptionName == "bottom_right"{
            px = w - sx / 2
            py = h - sy / 2
        }else if    OptionName == "bottom_left"{
            px = sx / 2
            py = h - sy / 2
        }
        return CGPoint(x: px, y: py)
    }
}

extension UIView{
    
    func MoveAnime(MoveX:CGFloat,MoveY:CGFloat,time:Double){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.center = CGPoint(x: self.center.x + MoveX * x1, y: self.center.y - MoveY * y1)
        }, completion: nil)
    }
    
    func MoveAnime(MoveX:CGFloat,MoveY:CGFloat,time:Double,
                   finish: @escaping () -> Void){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.center = CGPoint(x: self.center.x + MoveX * x1, y: self.center.y - MoveY * y1)
        }) { (finished: Bool) in
            finish()
        }
    }
    
    func TransformAnime(MovePX:CGFloat,MovePY:CGFloat,Width:CGFloat,Height:CGFloat,time:Double,Option:String = "no"){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        
        let Size = CGSize(width: Width * x1, height: Height * y1)
        var Point: CGPoint!
      
        if  Option != "no"{
            Point = Size.CGPointCalculation(OptionName: Option)
        }else{
            Point = CGPoint(x: x1 * (MovePX + 50), y: y1 * (50 - MovePY))
        }
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }, completion: nil)
    }
    
    func TransformAnime(MovePX:CGFloat,MovePY:CGFloat,Width:CGFloat,Height:CGFloat,time:Double,Option:String = "no",
                        finish: @escaping () -> Void){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        
        let Size = CGSize(width: Width * x1, height: Height * y1)
        var Point: CGPoint!
        
        if  Option != "no"{
            Point = Size.CGPointCalculation(OptionName: Option)
        }else{
            Point = CGPoint(x: x1 * (MovePX + 50), y: y1 * (50 - MovePY))
        }
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }){ (finished: Bool) in
            finish()
        }
    }
    
    func TransformAnime(Point:CGPoint,Size:CGSize,time:Double){
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }, completion: nil)
    }
    
    func TransformAnime(Point:CGPoint,Size:CGSize,time:Double,
                        finish: @escaping () -> Void){
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }) { (finished: Bool) in
            finish()
        }
    }
    
    func TransformAnime(MovePX:CGFloat,MovePY:CGFloat,Width:CGFloat,Yscale:CGFloat,time:Double,Option:String = "no"){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        
        let Size = CGSize(width: Width * x1, height: Width * x1 * Yscale)
        var Point: CGPoint!
        
        if  Option != "no"{
            Point = Size.CGPointCalculation(OptionName: Option)
        }else{
            Point = CGPoint(x: x1 * (MovePX + 50), y: y1 * (50 - MovePY))
        }
        
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }, completion: nil)
    }
    
    func TransformAnime(MovePX:CGFloat,MovePY:CGFloat,Width:CGFloat,Yscale:CGFloat,time:Double,Option:String = "no",
                        finish: @escaping () -> Void){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        
        let Size = CGSize(width: Width * x1, height: Width * x1 * Yscale)
        var Point: CGPoint!
        
        if  Option != "no"{
            Point = Size.CGPointCalculation(OptionName: Option)
        }else{
            Point = CGPoint(x: x1 * (MovePX + 50), y: y1 * (50 - MovePY))
        }
        
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }) { (finished: Bool) in
            finish()
        }
    }
    
    func TransformAnime(MovePX:CGFloat,MovePY:CGFloat,Height:CGFloat,Xscale:CGFloat,time:Double,Option:String = "no"){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        
        let Size = CGSize(width: Height * y1 * Xscale, height: Height * y1)
        var Point: CGPoint!
        
        if  Option != "no"{
            Point = Size.CGPointCalculation(OptionName: Option)
        }else{
            Point = CGPoint(x: x1 * (MovePX + 50), y: y1 * (50 - MovePY))
        }
        
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }, completion: nil)
    }
    
    func TransformAnime(MovePX:CGFloat,MovePY:CGFloat,Height:CGFloat,Xscale:CGFloat,time:Double,Option:String = "no",
                        finish: @escaping () -> Void){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        
        let Size = CGSize(width: Height * y1 * Xscale, height: Height * y1)
        var Point: CGPoint!
        
        if  Option != "no"{
            Point = Size.CGPointCalculation(OptionName: Option)
        }else{
            Point = CGPoint(x: x1 * (MovePX + 50), y: y1 * (50 - MovePY))
        }
        
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = Size
            self.center = Point
        }) { (finished: Bool) in
            finish()
        }
    }
    
    func ScaleAnime(Width:CGFloat,Height:CGFloat,time:Double){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = CGSize(width: Width * x1, height: Height * y1)
        }, completion: nil)
    }
    
    func ScaleAnime(Width:CGFloat,Height:CGFloat,time:Double,
                        finish: @escaping () -> Void){
        let x1 = UIScreen.main.bounds.size.width / 100
        let y1 = UIScreen.main.bounds.size.height / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = CGSize(width: Width * x1, height: Height * y1)
        }) { (finished: Bool) in
            finish()
        }
    }
    
    func ScaleAnime(Width:CGFloat,Yscale:CGFloat,time:Double){
        let x1 = UIScreen.main.bounds.size.width / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = CGSize(width: Width * x1, height: Width * x1 * Yscale)
        }, completion: nil)
    }
    
    func ScaleAnime(Width:CGFloat,Yscale:CGFloat,time:Double,
                        finish: @escaping () -> Void){
        let x1 = UIScreen.main.bounds.size.width / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = CGSize(width: Width * x1, height: Width * x1 * Yscale)
        }) { (finished: Bool) in
            finish()
        }
    }
    
    func ScaleAnime(Height:CGFloat,Xscale:CGFloat,time:Double){
        let y1 = UIScreen.main.bounds.size.height / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = CGSize(width: Height * y1 * Xscale, height: Height * y1)
        }, completion: nil)
    }
    
    func ScaleAnime(Height:CGFloat,Xscale:CGFloat,time:Double,
                        finish: @escaping () -> Void){
        let y1 = UIScreen.main.bounds.size.height / 100
        UIView.animate(withDuration: time, delay: 0.0, options: .curveLinear, animations: {
            self.frame.size = CGSize(width: Height * y1 * Xscale, height: Height * y1)
        }) { (finished: Bool) in
            finish()
        }
    }
   
    func CenterPosition(){
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        self.center = CGPoint(x: w / 2, y: h / 2)
    }
    
    func RightPosition(){
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        self.center = CGPoint(x: 1.5 * w, y: h / 2)
    }
    
    func LeftPosition(){
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        self.center = CGPoint(x: -w / 2, y: h / 2)
    }
    
    func UperPosition(){
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        self.center = CGPoint(x: w / 2, y: -h / 2)
    }
    
    func LowerPosition(){
        let w = UIScreen.main.bounds.size.width
        let h = UIScreen.main.bounds.size.height
        self.center = CGPoint(x: w / 2, y: 1.5 * h)
    }

}
//閉じるボタンの付いたキーボード
class DoneTextView: UITextView{
    /*
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
 */
 
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: nil)
        commonInit()
    }
    
    /*
    override init(frame: CGRect) {
        commonInit()
    }
 */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        let tools = UIToolbar()
        tools.frame = CGRect(x: 0, y: 0, width: frame.width, height: 40)
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.closeButtonTapped))
        tools.items = [spacer, closeButton]
        self.inputAccessoryView = tools
    }
    
    @objc func closeButtonTapped(){
        self.endEditing(true)
        self.resignFirstResponder()
    }
}

