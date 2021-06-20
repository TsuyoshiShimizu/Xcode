//
//  object.swift
//  gravity
//
//  Created by 清水健志 on 2018/07/30.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//


import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

extension CGFloat{
    func S() -> String{
        return String(Double(self))
    }
    
    func Rsita() -> CGFloat{
        var sita = self
        if sita > .pi{ sita -= 2 * .pi  }
        if sita < -.pi{ sita += 2 * .pi  }
        return sita
    }
}

extension SKNode{
    func SetInt(name: String, Int:Int){
        self.userData?.setValue(Int, forKey: name)
    }
    func SetDouble(name: String, Double:CGFloat){
        self.userData?.setValue(Double, forKey: name)
    }
    func SetCGFloat(name: String, CGFloat:CGFloat){
        self.userData?.setValue(CGFloat, forKey: name)
    }
    func SetBool(name: String, Bool:Bool){
        self.userData?.setValue(Bool, forKey: name)
    }
    func GetInt(name: String) -> Int{
        var num: Int = 0
        if let N = userData?.value(forKey: name) as? Int{ num = N }
        return num
    }
    func GetInt2(name: String) -> [Int]{
        var num: [Int] = []
        if let N = userData?.value(forKey: name) as? [Int]{ num = N }
        return num
    }
    
    func GetDouble(name: String) -> Double{
        var num: Double = 0.0
        if let N = userData?.value(forKey: name) as? Double{ num = N }
        return num
    }
    func GetCGFloat(name: String) -> CGFloat{
        var num: CGFloat = 0
        if let N = userData?.value(forKey: name) as? CGFloat{ num = N }
        return num
    }
    func GetBool(name: String) -> Bool{
        var b: Bool = false
        if let N = userData?.value(forKey: name) as? Bool{ b = N }
        return b
    }
    
    func PlaySE(number: Int = 0){
        self.children[number].run(SKAction.play())
    }
}

class object: SKScene{
    let h = UIScreen.main.bounds.size.height //画面の縦を取得
    let w = UIScreen.main.bounds.size.width  //画面の横を取得
    let psita = CGFloat(.pi / 180.0)         //ラジアンの変換に使用
    var viewnode: firstVC!                   //firstVCの関数呼び出しに使用
    let gra = 1.5                            //重力の大きさ
    
    var tapEE: Bool = true                   //タップ時のエラー防止？
    let cameraNode = SKCameraNode()
    
//1¥サイズ基準
    var PSize: CGFloat! ;let playerSize: CGFloat = 180      //プレイヤーサイズ
    var SSize = UIScreen.main.bounds.size.width / 2400      //本ゲームの1（サイズ）の大きさ
    var BSize = UIScreen.main.bounds.size.width / 200 * 15  //ブロックサイズ（一マスのサイズ）

//1¥プレイヤーの部品位置とサイズ（プレイヤーサイズ基準）
    var SensorSize: [CGFloat] = [1.6 ,0.95]    // ムーブセンサなどのサイズ
    var OUSensorD: CGFloat = 0.9               // 上下センサーの設置位置（中心からの上下距離）
    var RLSensorD: CGFloat = 0.9               // 左右センサーの設置位置（中心からの左右距離）
    
    var SelecterSize: CGFloat = 1.5
    var PointerSprite: [SKSpriteNode] = []
    var Pointerflag: Bool = false
    
//1¥プレイヤーの部品とテクスチャーを管理
    var LegFR: [SKSpriteNode] = []
    var LegFL: [SKSpriteNode] = []
    var LegBR: [SKSpriteNode] = []
    var LegBL: [SKSpriteNode] = []
    var body: SKSpriteNode!
    var taleS: [SKSpriteNode] = []
    var LegJointFR: [SKPhysicsJointPin] = []
    var LegJointFL: [SKPhysicsJointPin] = []
    var LegJointBR: [SKPhysicsJointPin] = []
    var LegJointBL: [SKPhysicsJointPin] = []
    var bodyT: [SKTexture] = []
    var LegFT: [SKTexture] = []
    var LegBT: [SKTexture] = []
    var Rbodyanime:[SKTexture] = []
    var Lbodyanime:[SKTexture] = []
    
    var AttackRTexture:[[SKTexture]] = [[]]          //攻撃エフェクトテクスチャーを管理
    var AttackLTexture:[[SKTexture]] = [[]]          //攻撃エフェクトテクスチャーを管理
    let AttackTN: [Int] = [0,8,23,15,13,7,6,9,19,6,9,8,6,9,3,12]     //テクスチャーコマ数を管理
    var Effect: [SKSpriteNode] = []                  //ループエフェクトを管理

    
//1¥プレイヤーのステータス
    var playerstatas = 2                    //1：:地上(通常),2:空中
    var playerdirection: Bool = true        //ture:右向き,false:左向き
    var playerDflag: Bool = false           //向け変更操作中かを管理
    var PracticeFlag: Bool = false          //練習エリアかどうか
    var PraRPoint: CGPoint!                 //練習エリアのリスボーンポイント
    
    //プレイヤーの状態  0:正常 1:軽化 2:重化 3:魔力封印
    var PconBefore: Int = 0                 //プレイヤーの状態変化　前
    var PconAfter: Int = 0                  //プレイヤーの状態変化　後
    var PconEffect: SKSpriteNode!           //プレイヤーの状態異常エフェクト
    
    var NoWindFlag: Bool = false            //風のスペシャル禁止
    var NoMagicFlag: Bool = false           //全スペシャル禁止

//1¥プレイヤーアクションの制御に使用
    //センサを管理
    var playerBlock:SKShapeNode!
    var underSensorS:SKShapeNode! ;var underSensor1:SKShapeNode! ;var underSensor2:SKShapeNode!
    var overSensorS:SKShapeNode!  ;var overSensor1:SKShapeNode!  ;var overSensor2:SKShapeNode!
    var rightSensorS:SKShapeNode! ;var rightSensor1:SKShapeNode! ;var rightSensor2:SKShapeNode!
    var leftSensorS:SKShapeNode!  ;var leftSensor1:SKShapeNode!  ;var leftSensor2:SKShapeNode!
    var underSflag1: Bool = false ;var underSflag2: Bool = false ;var undreSfirst:Bool = true
    var overSflag1: Bool = false  ;var overSflag2: Bool = false  ;var overSfirst:Bool = true
    var rightSflag1:Bool = false  ;var rightSflag2:Bool = false  ;var rightSfirst:Bool = true
    var leftSflag1:Bool = false   ;var leftSflag2:Bool = false   ;var leftSfirst:Bool = true
    let SensorMoveInterval = 0.05
    let SensorRunDis:CGFloat = 10
    
    //操作パラメータ
    //壁登り有効角度範囲
    let WUnderSita:[[CGFloat]] = [[45,135],[-135,-45]]  //下センサ稼働時姿勢有効角度範囲
    let WUperSita:[[CGFloat]] = [[45,135],[-135,-45]]   //上センサ稼働時姿勢有効角度範囲
    let WRightSita:[[CGFloat]] = [[-60,60],[-120,120]]  //右センサ稼働時姿勢有効角度範囲
    let WLeftSita:[[CGFloat]] = [[-60,60],[-120,120]]   //左センサ稼働時姿勢有効角度範囲
    //着地有効角度範囲
    let GUnderSita:[CGFloat] = [-45,45]                 //下センサ稼働時姿勢有効角度範囲
    let GUperSita:[CGFloat] = [-135,135]                //上センサ稼働時姿勢有効角度範囲
    let GRightSita:[CGFloat] = [-140,-40]               //右センサ稼働時姿勢有効角度範囲
    let GLeftSita:[CGFloat] = [40,140]                  //左センサ稼働時姿勢有効角度範囲
    
    //アクションのフリック、スワイプ量の定義( 1 = 画面横サイズw/20 )
    var walkS1: CGFloat = 1                             //遅く歩くスワイプ量
    var walkS2: CGFloat = 2                             //速く歩くスワイプ量
    var runS: CGFloat = 3                               //走るスワイプ量
    let runAngle: [CGFloat] = [-40,40]                  //歩く、走る姿勢有効角度範囲
    let runSAngle: [[CGFloat]] = [[65,115],[-115,-65]]  //歩く、走るスワイプ有効角度範囲
    
    var jumpF1: CGFloat = 2                             //小ジャンプフリック量
    var jumpF2: CGFloat = 3                             //中ジャンプフリック量
    var jumpF3: CGFloat = 4                             //大ジャンプフリック量
    let jumpAngle: [CGFloat] = [-60,60]                 //ジャンプ姿勢有効角度範囲
    let jumpFAngle: [CGFloat] = [-115,115]              //ジャンプフリック有効角度範囲
    
    var airMS: CGFloat = 2                              //空中移動スワイプ量
    let airMSAngle: [[CGFloat]] = [[65,115],[-115,-65]] //空中移動スワイプ有効角度範囲
    
    var avoidF: CGFloat = 2                             //回避フリック量
    let avoidAngle: [CGFloat] = [-30,30]                //回避姿勢有効角度範囲
    let avoidFAngle:[[CGFloat]] = [[65,115],[-115,-65]] //回避フリック有効角度範囲
    
    //スキル関係
    var skillOn = [Bool](repeating: false, count: 21)
    var skillGet = [Bool](repeating: false, count: 21)
    var HoldAttackType: Int = 0
    
    //タッチイベントの制御
    var flick: Bool = false                //クリック判定に使用
    var tap: Bool = false                  //フリック判定に使用
    var Actionlock: Bool = false           //アクションをロック
    var Sensorlock:Bool = false            //センサをロック
    
    //地上状態のアクション
    var landingfirst = true                     // 地上状態になったのを管理
    var RwalkFlag: [Bool] = [false,false]       // 右に歩く状態
    var LwalkFlag: [Bool] = [false,false]       // 左に歩く状態
    var RrunFlag: Bool = false                  // 右に走る状態
    var LrunFlag: Bool = false                  // 左に走る状態
    var RwallclimFlag: Bool = false             // 右の壁登り状態
    var LwallclimFlag: Bool = false             // 左の壁登り状態
    var climLock: Bool = false                  // 壁登りのロック
    var ClimFlag:[Bool] = [false,false,false]   // 壁登り中かの判定
    var ClimFN: Int = 0                         // 壁登りフラグの番号を管理
    var ClimEE: Bool = false                    // 壁登りによるエラー防止
    var ClimJBFlag: Bool = false                // 壁登りジャンプ待機認識用
    
    var HoldAccess = [Bool](repeating: false, count: 20)
    var HoldAN: Int = 0
    var Holdflag: Bool = false                  // ホールドフラグ
    var HoldActionflag: Bool = false            // ホールドアクションフラグ
    
    var windflag = [Bool](repeating: false, count:5) // ウインドアクション使用中かを判断する
    var windN: Int = 0
    var windmoveflag = false

    //空中状態のアクション
    var airfirst = true                    // 空中状態になったのを管理
    var airP:[CGFloat] = [0.35,0.2]        // 空中時のプレイヤーブロックの位置
    var jumpFlag: Bool = false             // ジャンプを使用したかの判定
    var airMfalg: Bool = true              // 空中時のプレイヤーブロックの移動フラグ
    var fallD: CGFloat = 1.0               // 落下判定距離（ボディーとPBの距離この値より大きい場合は落下状態となる）
    var Rairmove: Bool = true              // 空中右移動状態
    var Lairmove: Bool = true              // 空中左移動状態
    var BarObject: SKNode!                 //ぶら下がるオブジェクトを管理
    var Rtale:SKSpriteNode!                //右向き時尻尾先
    var Ltale:SKSpriteNode!                //左向き時尻尾先
    var Barflag: Bool = false              //空中弱攻撃後にバラ下がりを行うかを管理
    var airAfalg: Bool = false             //空中弱攻撃中かを管理
    var BarMoveflag: Bool = false          //ぶら下がり状態後にBムーブアクションを行えるかを管理
    var BarJumpflag: Bool = false          //ぶら下がり状態後にBジャンプアクションを行えるかを管理
    var BarJoint: [SKPhysicsJointPin] = [] //ぶら下がりの尻尾のジョイント
    
    //攻撃、ダメージ関連
    var catHP:Int = 100                                                //プレイヤーのHPを管理
    var catMaxHP:Int = 100
    var catMP:Int = 100                                                //プレイヤーのHPを管理
    var catMaxMP:Int = 100
    var MPAttack: Bool = false                                         //MPを回復できる攻撃か
    var MPRflag: Bool = true                                           //MPの自然回復フラグ
    var catAttack: Int = 10                                            //プレイヤーの攻撃力
    var playerDamageflag:Bool = true                                   //プレイヤーが攻撃を受けるかを管理(ダメージ以外による無敵)
    var playerDamageflag2:Bool = true                                  //プレイヤーが攻撃を受けるかを管理(ダメージによる無敵)
                                //   無効    地強    無効    空強    回攻
    var AttackCombofalg:[Bool]   = [false ,false ,false ,false ,false ] //連続攻撃の発動を管理
                                //   地弱    地強    空弱    空強    回攻
    var AttackComboAccess:[Bool] = [true  ,false ,true  ,false ,false ] //連続攻撃の受付が可能かを管理
    
    //                               [地弱,空弱]
    var AttackIntervalTime:[Double] = [1.0,1.0]                    // 攻撃後使用禁止時間
    
    var airAttackplay: [Bool] = [false,false,false]
    var airAttackHit: [Int] = [0,0,0]
    var airAttackAngle: CGFloat = 0
    var airAN: Int = 0
    


//1¥背景表示に使用
    var moveBGimage: SKSpriteNode!
    var StageFrameFlag: Bool = true
    var StagedX: CGFloat = 10
    var StagedY: CGFloat = 10
    var impulseR: CGFloat!       //端末差異によるインパルスの違いの補正

//1¥敵関連
    var enemymax = 10 //敵の同時出現条件
    var enemyCC: Int = -100
    //敵のテクスチャーを管理
    var enemyRAnime: [[SKTexture]] = [[]]
    var enemyLAnime: [[SKTexture]] = [[]]
    var enemyAp:[SKTexture] = []
    var enemyDe:[SKTexture] = []
    var enemyREffect: [[SKTexture]] = [[]]
    var enemyLEffect: [[SKTexture]] = [[]]
    var enemyDE1: [SKTexture] = []
    var enemyDE2: [SKTexture] = []
    var enemyDE3: [SKTexture] = []
    
    var BossVFlag: Bool = false         //ボスの位置方向を示す矢印を表示するか
    var BossViewFlag: Bool = false      //ボスの位置方向を示す矢印が表示中か
    var BossO: SKSpriteNode!            //ボスのスプライトを格納
    var BossVector: SKSpriteNode!       //ボスの方向を示す矢印
    var BossEffect: SKSpriteNode!       //ボスのエフェクト(無敵エフェクトなど)
    var BossEFlag:Bool = false
    
    
    //                      1  2  3   4 5   6 7   8  9 10  11 12 13 14   15 16  17   18  19  20  21    22
    //                      ネ　亜 希  攻 ス　亜 希  暴 コ 亜  希 小竜 亜 雪出　消 出変　消変 天使　竜　首　　首　　掻き
    let enemyAN: [Int] = [0,16,16,16,10,12,12,12,12,10,10,10, 12,12, 5,  5 ,9   ,9 , 20, 10, 10 , 10 , 10]
    //                             1  2    3   4    5    6   7     8   9
    //                             音 火球 氷息　光魔  光1  光2  闇魔  闇1  闇2 竜魔　竜ブレ　火ひ　　火バ  氷ブ　氷ひ
    var enemyEffectN: [Int] = [0 , 14, -5, 13, -20, 10, -20, -20, -16, 19, -15, 19,   13  , -18 , 25 ,16 ]
    
    //敵の出現ポイントに関する変数の定義
    var enemyp = [CGPoint](repeating: CGPoint(x: 0, y: 0), count: 100) //敵を出現させる位置を管理
    var enemyNumber = [Int](repeating: 0, count: 100)                  //出現させる敵の種類を管理
    var enemydirection = [Bool](repeating: true, count: 100)           //出現させる敵の方向を管理
    var enemynmax = [Int](repeating: 0, count: 100)                    //その出現ポイントの最大出現数を管理
    var enemynpre = [Int](repeating: 0, count: 100)                    //その出現ポイントから出現している敵の数を管理
    var enemyflag = [Bool](repeating: false, count: 100)               //敵を出現させれるかを管理
    var enemypHP = [Int](repeating: 0, count: 100)                     //出現させる敵のHPを管理
    var enemypDamage = [Int](repeating: 0, count: 100)                 //出現させる敵の攻撃力を管理
    var enemyInterval = [Double](repeating: 0.0, count: 100)           //次の敵を出現させる時間の管理
    var epcount = 0                                                    //敵を出現させる場所の個数を管理
    var enemySwitchNumber:[[Int]] = [[]]                               //敵撃破時にアクションを起こすかを管理

    //敵に関する変数の定義
    var ecount:Int = 0
    
//1¥アイテム,ブロック関連
    var Block: [SKSpriteNode] = []                              //アクションさせるブロックを格納
    var BlockNumber = [Int](repeating: 0, count: 200)           //アクションブロックの識別番号を管理
    var BlockAction: [SKAction] = []                            //ブロックアクションを格納(スイッチで操作するのに使用)
    var BlockActionNumber = [Int](repeating: 0, count: 200)     //ブロックアクションの識別番号を管理
    var ONBlock: [SKSpriteNode] = []                            //ONブロック格納用
    var OFFBlock: [SKSpriteNode] = []                           //OFFブロック格納用
    var ONOFFBlock: [SKSpriteNode] = []                         //ONOFFブロック格納用
    var fallObject: [SKSpriteNode] = []                         //落下物格納用
    var warpObject: [SKSpriteNode] = []                         //ワープオブジェクトの管理
    var tornadoC = 0.0
    
    var ActionBlockflag: Bool = true                            //アクションブロックの連続使用の制限う用
    
    
    //衝突処理のダブり防止う用
    var moveflag: Bool = true
    var warpflag = true
    var itemflag = true
    var switchflag = true
    var boardflag = true
   
//1¥効果音
    //複数起動やループ再生が必要な場合はAvaudioPlayerを作成
    //一回鳴らすだけの単純な効果音はSKAudioNodeを使う
    var Hit1BGM: AVAudioPlayer!         //敵ダメージ
    var Hit2BGM: AVAudioPlayer!         //敵弱点ダメージ
    var Hit3BGM: AVAudioPlayer!         //敵撃破
    var Hit4BGM: AVAudioPlayer!         //敵耐性ダメージ
    var Hit5BGM: AVAudioPlayer!         //敵ダメージ無効
    var Cat01SE: AVAudioPlayer!         //スペシャル溜め時
    var HoldAttack03SE: AVAudioPlayer!  //風スペシャル使用時
    var cloudSE: AVAudioPlayer!         //雲ではねる時
    


    
    
    var SEfirst = [Bool](repeating: true, count: 50)  //そのSEを読み込んだかを管理
    var SENumber = [Int](repeating: 0, count: 50)     //bodyの子nodeの番号を管理
    
    
    func ReadBodySE(Number:Int,named:String,type:String){
        SEfirst[Number] = false
        SENumber[Number] = body.children.count
        let SE = SKAudioNode(fileNamed: "SE/" + named + "." + type)
        SE.autoplayLooped = false
        body.addChild(SE)
    }
    
    func ReadAudio(){
        do{
            let H3Path = Bundle.main.path(forResource: "SE/hit03", ofType: "mp3")
            let H3url = URL(fileURLWithPath: H3Path!)
            Hit3BGM = try AVAudioPlayer(contentsOf: H3url)
            
            let CatPath = Bundle.main.path(forResource: "SE/Cat01", ofType: "mp3")
            let Caturl = URL(fileURLWithPath: CatPath!)
            Cat01SE = try AVAudioPlayer(contentsOf: Caturl)
            Cat01SE.numberOfLoops = -1
            
            let H1Path = Bundle.main.path(forResource: "SE/hit01", ofType: "wav")
            let H1url = URL(fileURLWithPath: H1Path!)
            Hit1BGM = try AVAudioPlayer(contentsOf: H1url)
            
            let H2Path = Bundle.main.path(forResource: "SE/hit02", ofType: "wav")
            let H2url = URL(fileURLWithPath: H2Path!)
            Hit2BGM = try AVAudioPlayer(contentsOf: H2url)
            
            let HAPath = Bundle.main.path(forResource: "SE/HoldAttack03", ofType: "wav")
            let HAurl = URL(fileURLWithPath: HAPath!)
            HoldAttack03SE = try AVAudioPlayer(contentsOf: HAurl)
            HoldAttack03SE.numberOfLoops = -1
            
            let H4Path = Bundle.main.path(forResource: "SE/hit04", ofType: "mp3")
            let H4url = URL(fileURLWithPath: H4Path!)
            Hit4BGM = try AVAudioPlayer(contentsOf: H4url)
            
            let H5Path = Bundle.main.path(forResource: "SE/hit05", ofType: "mp3")
            let H5url = URL(fileURLWithPath: H5Path!)
            Hit5BGM = try AVAudioPlayer(contentsOf: H5url)
            
            let SEPath = Bundle.main.path(forResource: "SE/cloud", ofType: "mp3")
            let SEurl = URL(fileURLWithPath: SEPath!)
            cloudSE = try AVAudioPlayer(contentsOf: SEurl)
        }catch{
            print("error")
        }
    }

    let item1BGM = SKAudioNode(fileNamed: "SE/item1.wav")
    let item2BGM = SKAudioNode(fileNamed: "SE/item2.wav")
    let item3BGM = SKAudioNode(fileNamed: "SE/item3.wav")
    let avoidBGM = SKAudioNode(fileNamed: "SE/avoid.mp3")
    let clearbgm = SKAudioNode.init(fileNamed: "クリア音.mp3" )
    
    
//1¥接触判定関連
    let playerCategory:     UInt32 = 0b000000000000000000001 //プレイヤー  1
    let blockCategory:      UInt32 = 0b000000000000000000010 //足場などのオブジェクト 2
    let block2Category:     UInt32 = 0b000000000000000000100 //足場などのオブジェクト(壁登り使用不可) 3
    let damageCategory:     UInt32 = 0b000000000000000001000 //プレイヤーにダメージを与えるオブジェクト（プレイヤーと接触する） 4
    let damage2Category:    UInt32 = 0b000000000000000010000 //プレイヤーにダメージを与えるオブジェクト（プレイヤーと接触しない） 5
    let moveCategory:       UInt32 = 0b000000000000000100000 //エリア移動のオブジェクト  6
    let legCategory:        UInt32 = 0b000000000000001000000 //手足に使用 7
    let itemCategory:       UInt32 = 0b000000000000010000000 //アイテム  8
    let charaBCategory:     UInt32 = 0b000000000000100000000 //落下などのセンサオブジェクト 9
    let attackCategory:     UInt32 = 0b000000000001000000000 //攻撃判定　10
    let enemyCategory:      UInt32 = 0b000000000010000000000 //敵オブジェクト 11
    let enemy2Category:     UInt32 = 0b000000000100000000000 //敵オブジェクト 12
    let Sensor1Category:    UInt32 = 0b000000001000000000000 //接触センサオブジェクト（ブロック１と接触） 13
    let Sensor2Category:    UInt32 = 0b000000010000000000000 //接触センサオブジェクト（ブロック２と接触） 14
    let BarCategory:        UInt32 = 0b000000100000000000000 //バー（ブラ下がる） 15
    let block3Category:     UInt32 = 0b000001000000000000000 //足場などのオブジェクト(壁登り使用不可)     16
    let SwitchCategory:     UInt32 = 0b000010000000000000000 //スイッチに使用 17
    let ActionBlockCategory:UInt32 = 0b000100000000000000000 //スイッチに使用 18
    let block4Category:     UInt32 = 0b001000000000000000000 //足場などのブロック　プレイヤー以外透過する

    var playerCT: UInt32!  ;var playerCo: UInt32!
    var legCT: UInt32!  ;var legCo: UInt32!
    var blockCT: UInt32!   ;var blockCo: UInt32!
    var block2CT: UInt32!  ;var block2Co: UInt32!
    var damageCT: UInt32!  ;var damageCo: UInt32!
    var damage2CT: UInt32! ;var damage2Co: UInt32!
    var moveCT: UInt32!    ;var moveCo: UInt32!
    var itemCT: UInt32!    ;var itemCo: UInt32!
    var SwitchCT: UInt32!  ;var SwitchCo: UInt32!
    var charaBCT: UInt32!  ;var charaBCo: UInt32!
    var attackCT: UInt32!  ;var attackCo: UInt32!
    var enemyCT: UInt32!   ;var enemyCo: UInt32!
    var enemy2CT: UInt32!  ;var enemy2Co: UInt32!
    var Sensor1CT: UInt32! ;var Sensor1Co: UInt32!
    var Sensor2CT: UInt32! ;var Sensor2Co: UInt32!
    var BarCT: UInt32!     ;var BarCo: UInt32!
    var block3CT: UInt32!  ;var block3Co: UInt32!
    var ActionBCT: UInt32! ;var ActionBCo: UInt32!
    var block4CT: UInt32!  ;var block4Co: UInt32!
    //接触判定の設定
    func contact(){
        playerCT = enemyCategory + enemy2Category + damageCategory + damage2Category + moveCategory + itemCategory + ActionBlockCategory
        playerCo = blockCategory + block2Category + damageCategory + block3Category + ActionBlockCategory + block4Category
        legCT = 0
        legCo = blockCategory + block2Category + damageCategory + block3Category + block4Category
        blockCT = damageCategory
        blockCo = playerCategory + charaBCategory + enemyCategory + Sensor1Category + blockCategory + block2Category + damageCategory + block3Category + legCategory
        block2CT = 0
        block2Co = playerCategory + charaBCategory + enemyCategory + Sensor2Category + blockCategory + block2Category + damageCategory + block3Category + legCategory
        block3CT = 0
        block3Co = playerCategory + charaBCategory + blockCategory + block2Category + damageCategory + legCategory  + ActionBlockCategory
        block4CT = 0
        block4Co = playerCategory + charaBCategory + legCategory + Sensor1Category
        damageCT = playerCategory + legCategory
        damageCo = playerCategory + enemyCategory + Sensor1Category + charaBCategory + blockCategory + block2Category + block3Category + legCategory
        damage2CT = playerCategory
        damage2Co = 0
        moveCT = playerCategory
        moveCo = 0
        itemCT = playerCategory
        itemCo = 0
        SwitchCT = attackCategory
        SwitchCo = 0
        charaBCT = 0
        charaBCo = blockCategory + block2Category + damageCategory + block3Category + block4Category
        attackCT = enemyCategory + enemy2Category + BarCategory + SwitchCategory
        attackCo = 0
        enemyCT = attackCategory + playerCategory
        enemyCo = blockCategory + block2Category + damageCategory + ActionBlockCategory
        enemy2CT = attackCategory + playerCategory
        enemy2Co = 0
        Sensor1CT = 0
        Sensor1Co = blockCategory + damageCategory + block4Category
        Sensor2CT = 0
        Sensor2Co = block2Category
        BarCT = attackCategory
        BarCo = 0
        ActionBCT = playerCategory
        ActionBCo = playerCategory + charaBCategory + enemyCategory
    }
    
//1¥デバッグ関連
    var SensorView: Bool = false
    var PDfalg: Bool = true // 傾き判定テスト用
    var ap: Int = 0 //デバック用
    var pstatas: Int = 0
 
//1¥ステージセットアップ
    func SetUpStage(){
        contact()                                    //ノッドの当たり判定の読み込み
        enemyTexterLoad()                            //敵のテクスチャーの読み込み
        impulseR = 1.7777777 * (h / w)               //画面のアスペクト比の違いによる力積補正値の計算
        print(w)
        print(h)
        SelecterSize = SelecterSize * BSize
        Pointerflag = viewnode.getPointerFlag()
        viewnode.SetPractice(PracticeFlag: PracticeFlag)
        
        ReadAudio()
        skillRead()
        let BGTexter = SKTexture(imageNamed: "forest01")
        moveBGimage = SKSpriteNode(texture: BGTexter)
        moveBGimage.size = CGSize(width: w * 1.1, height: w * 3 / 4 * 1.1)
        moveBGimage.position = CGPoint(x: 0, y: 0)
        moveBGimage.zPosition = -100
        moveBGimage.alpha = 0
        
        //各操作パラメータの変換
        walkS1 = w / 20 * walkS1
        walkS2 = w / 20 * walkS2
        runS = w / 20 * runS
        jumpF1 = w / 20 * jumpF1
        jumpF2 = w / 20 * jumpF2
        jumpF3 = w / 20 * jumpF3
        avoidF = w / 20 * avoidF
        airMS = w / 20 * airMS
    }
    
//1¥スキル状況の反映
    func skillRead(){
        if PracticeFlag == true{
            skillOn = viewnode.PraSkillTake()
            skillGet = viewnode.PraSkillGTake()
            HoldAttackType = viewnode.PraHSkillTake()
        }else{
            skillOn = viewnode.SkillTake()
            skillGet = viewnode.SkillGTake()
            HoldAttackType = viewnode.HSkillTake()
        }
        catHP = viewnode.getplayerHP()
        catMP = viewnode.getplayerMP()
        catMaxHP = viewnode.getplayerMaxHP()
        catMaxMP = viewnode.getplayerMaxMP()
        catAttack = viewnode.getAttack()
        
        if catHP > catMaxHP {
            catHP = catMaxHP
            viewnode.SetHP(HP: catHP)
        }
        if catMP > catMaxMP {
            catMP = catMaxMP
            viewnode.SetMP(MP: catMP)
        }
        
        itemflag = true
        self.boardflag = false
        self.run(SKAction.wait(forDuration: 5.0)){
            self.boardflag = true
        }
    }
    func SkillChange(SkillNumber:[Int]){
        //1:猫パンチ 2:連続パンチ 3:エアスピン 4:エアバーン 5:ドッチスピン 6:一閃 7:壁登り //8:テイルフック
        //9:HPアップ1 10:HPアップ2 11:MPアップ1 12:MPアップ2 13:攻撃力アップ
        //14:ファイアボール 15:アイスブラスト 16:ウインドオーラ
        
        //初期化
        for n in 1...13{
            skillGet[n] = false
            skillOn[n] = false
        }
        for n in 14...16{
            skillGet[n] = false
        }
        HoldAttackType = 0
        //スキルの変更
        for SKillN in SkillNumber{
            skillGet[SKillN] = true
            if SKillN <= 13{ skillOn[SKillN] = true }
            else           { HoldAttackType = SKillN - 13 }
        }
        
        var HP = 100;var MP = 100;var Attack = 10
        if skillOn[9]  { HP += 50 } ;if skillOn[10] { HP += 50 }
        if skillOn[11] { MP += 50 } ;if skillOn[12] { MP += 50 }
        if skillOn[13] { Attack = 20 }
        catHP = HP
        catMP = MP
        catMaxHP = HP
        catMaxMP = MP
        catAttack = Attack
        
        viewnode.SetPraStatas(HP: catMaxHP, MP: catMaxMP, Attack: catAttack)
        viewnode.SetPraSkillON(PraSkillOn: skillOn)
        viewnode.SetPraSkillGet(PraSkillGet: skillGet)
        viewnode.SetPraHoldA(PraHoldAType: HoldAttackType)
    }
    
//1¥バー追加
    func addBar(xp: CGFloat, yp:CGFloat , type:Int = 1 ,BloclNumber n: Int = 0,Angle:CGFloat = 0){
        var BarSprite: SKSpriteNode!
        var OSize: CGFloat!
        let B = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        if      type == 1 {
            BarSprite = SKSpriteNode(imageNamed: "bar1")
            OSize = BSize
        }
        else if type == 2 {
            BarSprite = SKSpriteNode(imageNamed: "bar2")
            OSize = 10 * BSize
        }
        else if type == 3 {
            BarSprite = SKSpriteNode(imageNamed: "bar3")
            OSize = 20 * BSize
        }
        else if type == 4 {
            BarSprite = SKSpriteNode(imageNamed: "bar4")
            OSize = 10 * BSize
        }
        else if type == 5 {
            BarSprite = SKSpriteNode(imageNamed: "bar4")
            OSize = 20 * BSize
        }
        BarSprite.position = B
        BarSprite.size = CGSize(width: OSize, height: OSize)
        BarSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OSize, height: OSize))
        BarSprite.physicsBody?.isDynamic = false
        if type == 1{
            BarSprite.physicsBody?.categoryBitMask = BarCategory
            BarSprite.physicsBody?.contactTestBitMask = BarCT
            BarSprite.physicsBody?.collisionBitMask = BarCo
            addChild(BarSprite)
        }else if 2 <= type && type <= 5{
            BarSprite.physicsBody?.categoryBitMask = 0
            BarSprite.physicsBody?.contactTestBitMask = 0
            BarSprite.physicsBody?.collisionBitMask = 0
            BarSprite.zPosition = -10
            addChild(BarSprite)
            if type == 2 || type == 3{
                var dd:CGFloat = 0.4 ;if type == 3 { dd = 0.45 }
                let Bar1 = SKSpriteNode(imageNamed: "bar0")
                Bar1.scale(to: CGSize(width: BSize, height: BSize))
                Bar1.position = CGPoint(x: B.x, y: dd * OSize + B.y)
                Bar1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize, height: BSize))
                Bar1.physicsBody?.categoryBitMask = BarCategory
                Bar1.physicsBody?.contactTestBitMask = BarCT
                Bar1.physicsBody?.collisionBitMask = BarCo
                Bar1.physicsBody?.affectedByGravity = false
                addChild(Bar1)
                let BJ1 = SKPhysicsJointPin.joint(withBodyA:BarSprite.physicsBody!, bodyB: Bar1.physicsBody!, anchor: Bar1.position)
                physicsWorld.add(BJ1)
                let Bar2 = SKSpriteNode(imageNamed: "bar0")
                Bar2.scale(to: CGSize(width: BSize, height: BSize))
                Bar2.position = CGPoint(x: B.x, y: -dd * OSize + B.y)
                Bar2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize, height: BSize))
                Bar2.physicsBody?.categoryBitMask = BarCategory
                Bar2.physicsBody?.contactTestBitMask = BarCT
                Bar2.physicsBody?.collisionBitMask = BarCo
                Bar2.physicsBody?.affectedByGravity = false
                addChild(Bar2)
                let BJ2 = SKPhysicsJointPin.joint(withBodyA:BarSprite.physicsBody! , bodyB: Bar2.physicsBody!, anchor: Bar2.position)
                physicsWorld.add(BJ2)
                
                BarSprite.zRotation = Angle * psita
            }
            
            if type == 4 || type == 5{
                let Bar1 = SKSpriteNode(imageNamed: "bar0")
                Bar1.scale(to: CGSize(width: BSize, height: BSize))
                Bar1.position = CGPoint(x: B.x, y: 0.45 * OSize + B.y)
                Bar1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize, height: BSize))
                Bar1.physicsBody?.categoryBitMask = BarCategory
                Bar1.physicsBody?.contactTestBitMask = BarCT
                Bar1.physicsBody?.collisionBitMask = BarCo
                Bar1.physicsBody?.affectedByGravity = false
                addChild(Bar1)
                let BJ1 = SKPhysicsJointPin.joint(withBodyA:BarSprite.physicsBody!, bodyB: Bar1.physicsBody!, anchor: Bar1.position)
                physicsWorld.add(BJ1)
                
                let Bar2 = SKSpriteNode(imageNamed: "bar0")
                Bar2.scale(to: CGSize(width: BSize, height: BSize))
                Bar2.position = CGPoint(x: B.x, y: -0.45 * OSize + B.y)
                Bar2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize, height: BSize))
                Bar2.physicsBody?.categoryBitMask = BarCategory
                Bar2.physicsBody?.contactTestBitMask = BarCT
                Bar2.physicsBody?.collisionBitMask = BarCo
                Bar2.physicsBody?.affectedByGravity = false
                addChild(Bar2)
                let BJ2 = SKPhysicsJointPin.joint(withBodyA:BarSprite.physicsBody! , bodyB: Bar2.physicsBody!, anchor: Bar2.position)
                physicsWorld.add(BJ2)
                
                let Bar3 = SKSpriteNode(imageNamed: "bar0")
                Bar3.scale(to: CGSize(width: BSize, height: BSize))
                Bar3.position = CGPoint(x: 0.45 * OSize + B.x, y: B.y)
                Bar3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize, height: BSize))
                Bar3.physicsBody?.categoryBitMask = BarCategory
                Bar3.physicsBody?.contactTestBitMask = BarCT
                Bar3.physicsBody?.collisionBitMask = BarCo
                Bar3.physicsBody?.affectedByGravity = false
                addChild(Bar3)
                let BJ3 = SKPhysicsJointPin.joint(withBodyA:BarSprite.physicsBody!, bodyB: Bar3.physicsBody!, anchor: Bar3.position)
                physicsWorld.add(BJ3)
            
                let Bar4 = SKSpriteNode(imageNamed: "bar0")
                Bar4.scale(to: CGSize(width: BSize, height: BSize))
                Bar4.position = CGPoint(x: -0.45 * OSize + B.x, y: B.y)
                Bar4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize, height: BSize))
                Bar4.physicsBody?.categoryBitMask = BarCategory
                Bar4.physicsBody?.contactTestBitMask = BarCT
                Bar4.physicsBody?.collisionBitMask = BarCo
                Bar4.physicsBody?.affectedByGravity = false
                addChild(Bar4)
                let BJ4 = SKPhysicsJointPin.joint(withBodyA:BarSprite.physicsBody!, bodyB: Bar4.physicsBody!, anchor: Bar4.position)
                physicsWorld.add(BJ4)
            }
        }
        
        if n != 0{
            Block.append(BarSprite)
            BlockNumber[n] = Block.count
        }
    }
    
//1¥アイテム追加
    func additem(xp: CGFloat, yp:CGFloat , type:Int,number: Int ,BloclNumber n: Int = 0){
        var item: SKSpriteNode! //スキルオーブ
        if type == 1{//スキルオーブ
            if 1 <= number && number <= 8 { item = SKSpriteNode(imageNamed: "orb1") }
            if 9 <= number && number <= 12{ item = SKSpriteNode(imageNamed: "orb5") }
            if number == 13{ item = SKSpriteNode(imageNamed: "orb6") }
            if number == 14{ item = SKSpriteNode(imageNamed: "orb2") }
            if number == 15{ item = SKSpriteNode(imageNamed: "orb3") }
            if number == 16{ item = SKSpriteNode(imageNamed: "orb4") }
        }
        if type == 2{ item = SKSpriteNode(imageNamed: "food" + String(number)) }  //回復アイテム
        if type == 3{ item = SKSpriteNode(imageNamed: "SaveO") }  //セーブアイテム
        if type == 4{
            item = SKSpriteNode(imageNamed: "status" + String(number))
            item.addChild(ReadAudioNode(named: "statas" + String(number), type: "mp3", Loop: false))
        }
        item.size = CGSize(width: BSize, height: BSize)
        item.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        item.physicsBody = SKPhysicsBody(rectangleOf: item.size)
        item.physicsBody?.categoryBitMask = itemCategory
        item.physicsBody?.contactTestBitMask = itemCT
        item.physicsBody?.collisionBitMask = itemCo
        item.physicsBody?.isDynamic = false
        item.userData = ["type":type,"number":number]
        addChild(item)
        if n != 0{
            Block.append(item)
            BlockNumber[n] = Block.count
        }
    }
    
    func addBoard(xp: CGFloat, yp:CGFloat , type:Int,number: Int){
        let Btype = 5 + type
        let board = SKSpriteNode(imageNamed: "board1")
        board.size = CGSize(width: 2 * BSize, height: 2 * BSize)
        board.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        board.physicsBody = SKPhysicsBody(rectangleOf: board.size)
        board.physicsBody?.categoryBitMask = itemCategory
        board.physicsBody?.contactTestBitMask = itemCT
        board.physicsBody?.collisionBitMask = itemCo
        board.physicsBody?.isDynamic = false
        board.zPosition = -20
        board.userData = ["type":Btype,"number":number]
        addChild(board)
    }
    
    func addTV(xp: CGFloat, yp:CGFloat ,Size:CGFloat,number: Int){
        let TVSprite = SKSpriteNode(imageNamed: "tv")
        let TVSize = Size * BSize
        TVSprite.scale(to: CGSize(width: TVSize, height: TVSize))
        TVSprite.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        TVSprite.physicsBody = CreateSquareBody(Size: [100,56], Position: [0,0], StandardSize: TVSize)
        TVSprite.physicsBody?.categoryBitMask = itemCategory
        TVSprite.physicsBody?.contactTestBitMask = itemCT
        TVSprite.physicsBody?.collisionBitMask = itemCo
        TVSprite.physicsBody?.isDynamic = false
        TVSprite.zPosition = -20
        TVSprite.userData = ["type":8,"number":number]
        addChild(TVSprite)
    }
    
//1¥ドアの追加
    func adddoor(xp: CGFloat, yp:CGFloat ,movepx: CGFloat ,movepy: CGFloat,BloclNumber n: Int = 0){
        let door = SKSpriteNode(imageNamed: "moveO40")
        door.size = CGSize(width: BSize * 2, height: BSize * 2)
        door.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        door.physicsBody = CreateSquareBody(Size: [55,95], Position: [0,0], StandardSize: BSize * 2)
        door.physicsBody?.categoryBitMask = itemCategory
        door.physicsBody?.contactTestBitMask = itemCT
        door.physicsBody?.collisionBitMask = itemCo
        door.physicsBody?.isDynamic = false
        door.userData = ["type":7,"number": 1 ,"movePx": movepx ,"movePy": movepy]
        addChild(door)
        if n != 0{
            Block.append(door)
            BlockNumber[n] = Block.count
        }
    }
    
//1¥ワープの追加
    func addwarp(xp: CGFloat, yp:CGFloat ,movepx: CGFloat ,movepy: CGFloat,BloclNumber1 n1: Int = 0,BloclNumber2 n2: Int = 0){
        let warpAtlas = SKTextureAtlas(named: "warp")
        var warpanime: [SKTexture] = []
        for n in 1...5{
            warpanime.append(warpAtlas.textureNamed("warp" + String(n)))
        }
        let OSize = BSize * 3

        let warp1 = SKSpriteNode(texture: warpanime[0])
        warp1.size = CGSize(width: OSize, height: OSize)
        warp1.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        warp1.physicsBody = CreateCircleBody(Size: 60, Position: [0,0], StandardSize: OSize)
        warp1.physicsBody?.categoryBitMask = itemCategory
        warp1.physicsBody?.contactTestBitMask = itemCT
        warp1.physicsBody?.collisionBitMask = itemCo
        warp1.physicsBody?.isDynamic = false
        addChild(warp1)
        warpObject.append(warp1)
        warp1.userData = ["type":7,"number": 2 ,"PairN": warpObject.count,"flag":true]
        
        let warp2 = SKSpriteNode(texture: warpanime[0])
        warp2.size = CGSize(width: OSize, height: OSize)
        warp2.position = CGPoint(x: BSize * movepx + BSize / 2, y: BSize * movepy + BSize / 2)
        warp2.physicsBody = CreateCircleBody(Size: 60, Position: [0,0], StandardSize: OSize)
        warp2.physicsBody?.categoryBitMask = itemCategory
        warp2.physicsBody?.contactTestBitMask = itemCT
        warp2.physicsBody?.collisionBitMask = itemCo
        warp2.physicsBody?.isDynamic = false
        addChild(warp2)
        warpObject.append(warp2)
        warp2.userData = ["type":7,"number": 2 ,"PairN": warpObject.count - 2,"flag":true]
        
        warp1.run(SKAction.repeatForever(SKAction.animate(with: warpanime, timePerFrame: 0.2)))
        warp2.run(SKAction.repeatForever(SKAction.animate(with: warpanime, timePerFrame: 0.2)))
        if n1 != 0{
            Block.append(warp1)
            BlockNumber[n1] = Block.count
        }
        if n2 != 0{
            Block.append(warp2)
            BlockNumber[n2] = Block.count
        }
        
    }
    
//1¥bボード追懐
    func addBoard(xp: CGFloat,yp: CGFloat,Size:CGFloat, Number: Int){
        let Board = SKSpriteNode(imageNamed: "Board\(Number)")
        Board.scale(to: CGSize(width: Size * BSize, height: Size * BSize))
        Board.position =  CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Board.zPosition = -20
        addChild(Board)
    }

//1¥敵出現地点追加
    func addenemy(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,SwitchNumber n:Int = 0){
        enemyp[epcount] = CGPoint(x: xp * BSize + BSize / 2, y: yp * BSize + BSize / 2)
        enemyNumber[epcount] = type
        enemydirection[epcount] = direction
        enemynmax[epcount] = maxn
        enemyflag[epcount] = true
        enemypHP[epcount] = HP
        enemyInterval[epcount] = interval
        enemypDamage[epcount] = Damage
        enemySwitchNumber.append([n])
        epcount += 1
    }
    func addenemy(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,SwitchNumber n:[Int]){
        enemyp[epcount] = CGPoint(x: xp * BSize + BSize / 2, y: yp * BSize + BSize / 2)
        enemyNumber[epcount] = type
        enemydirection[epcount] = direction
        enemynmax[epcount] = maxn
        enemyflag[epcount] = true
        enemypHP[epcount] = HP
        enemyInterval[epcount] = interval
        enemypDamage[epcount] = Damage
        enemySwitchNumber.append(n)
        epcount += 1
    }
    
//1¥敵を出現させる
    func AppearEnemy(ep:CGPoint,etype:Int,edre:Bool,epnumber:Int,eHP:Int,eDame:Int){
        var Size:CGFloat = 1        //敵サイズ
        var PBody: SKPhysicsBody!   //敵の物理ボディ
        var etexture: SKTexture!    //敵のテクスチャ
        var Gravity: Bool = true    //敵が重力の影響を受けるか
        var mass: CGFloat = 1       //敵の質量
        var APSize: CGFloat = 1     //敵の出現エフェクトのサイズ
        var Zpo: CGFloat = -0.5     //敵のZ位置
        var enedame: Int = 1        //敵のダメージタイプの設定

        if 1 <= etype && etype <= 10 { //ネズミ型
            Gravity = true
            if etype == 1 || etype == 4 || etype == 7
            { Size = 2.5 ;mass = 0.10 ;APSize = 2 }
            if etype == 2 || etype == 5 || etype == 8
            { Size = 4.0; mass = 0.15 ;APSize = 4 }
            if etype == 3 || etype == 6 || etype == 9
            { Size = 5.5; mass = 0.25 ;APSize = 6 }
            if etype == 10
            { Size = 6.0; mass = 0.30 ;APSize = 7 }
            PBody = CreateSquareBody(Size: [27.5,17], Position: [1.25,0], StandardSize: Size * BSize)
            if 1 <= etype && etype <= 3 {
                if edre{ etexture = enemyRAnime[1][0] }
                else   { etexture = enemyLAnime[1][0] }
            }
            if 4 <= etype && etype <= 6 {
                if edre{ etexture = enemyRAnime[2][0] }
                else   { etexture = enemyLAnime[2][0] }
            }
            if 7 <= etype && etype <= 10 {
                if edre{ etexture = enemyRAnime[3][0] }
                else   { etexture = enemyLAnime[3][0] }
            }
        }
        
        if 11 <= etype && etype <= 20 { //スライム型
            Gravity = true
            if etype == 11 || etype == 14 || etype == 17
            { Size = 1;mass = 0.15 ;APSize = 2 }
            if etype == 12 || etype == 15 || etype == 18
            { Size = 2;mass = 0.22 ;APSize = 4 }
            if etype == 13 || etype == 16 || etype == 19
            { Size = 3;mass = 0.30 ;APSize = 6 }
            if etype == 20
            { Size = 3.5;mass = 0.35 ;APSize = 7}
            PBody = CreateSquareBody(Size: [65,45], Position: [2.5,-2.5], StandardSize: Size * BSize)
            
            if 11 <= etype && etype <= 13 {
                if edre{ etexture = enemyRAnime[5][0] }
                else   { etexture = enemyLAnime[5][0] }
            }
            if 14 <= etype && etype <= 16 {
                if edre{ etexture = enemyRAnime[6][0] }
                else   { etexture = enemyLAnime[6][0] }
            }
            if 17 <= etype && etype <= 20 {
                if edre{ etexture = enemyRAnime[7][0] }
                else   { etexture = enemyLAnime[7][0] }
            }
        }
        
        if 21 <= etype && etype <= 30 { //コウモリ型
            Gravity = false
            Zpo = 1
            if 21 <= etype && etype <= 29
            { Size = 3;mass = 0.15 ;APSize = 2 }
            if etype == 30
            { Size = 4;mass = 0.22 ;APSize = 3 }
            
            PBody = CreateSquareBody(Size: [45,40], Position: [1.25,0], StandardSize: Size * BSize)
            if 21 <= etype && etype <= 26 {
                if edre{ etexture = enemyRAnime[9][0] }
                else   { etexture = enemyLAnime[9][0] }
            }
            if 27 <= etype && etype <= 28 {
                if edre{ etexture = enemyRAnime[10][0] }
                else   { etexture = enemyLAnime[10][0] }
            }
            if 29 <= etype && etype <= 30 {
                if edre{ etexture = enemyRAnime[11][0] }
                else   { etexture = enemyLAnime[11][0] }
            }
        }
        
        if etype == 31 || etype == 32 || etype == 47{ //小ドラゴン型
            Gravity = false
            Zpo = 1
            Size = 2
            mass = 0.15
            APSize = 2
            enedame = 4
            if etype == 47 { enedame = 14 }
            
            PBody = CreateSquareBody(Size: [40,75], Position: [0,-2.5], StandardSize: Size * BSize)
            if etype == 31 {
                if edre{ etexture = enemyRAnime[12][0] }
                else   { etexture = enemyLAnime[12][0] }
            }
            if etype == 32 || etype == 47 {
                if edre{ etexture = enemyRAnime[13][0] }
                else   { etexture = enemyLAnime[13][0] }
            }
        }
        
        if etype == 33 || etype == 34 || etype == 48{ //雪女型
            Gravity = false
            Zpo = 1
            Size = 2
            mass = 0.15
            APSize = 2
            enedame = 5
            if etype == 48 { enedame = 15 }
            
            PBody = CreateSquareBody(Size: [20,90], Position: [0,0], StandardSize: Size * BSize)
            if edre{ etexture = enemyRAnime[14][0] }
            else   { etexture = enemyLAnime[14][0] }
        }
        
        if etype == 35 || etype == 36 || etype == 49 { //天使型
            Gravity = false
            Zpo = 1
            Size = 2
            mass = 0.15
            APSize = 2
            enedame = 6
            if etype == 49 { enedame = 16 }
            
            PBody = CreateSquareBody(Size: [30,70], Position: [0,5], StandardSize: Size * BSize)
            if edre{ etexture = enemyRAnime[18][0] }
            else   { etexture = enemyLAnime[18][0] }
        }
        
        if etype == 37 || etype == 38 { //飛行ロボット
            Gravity = false
            Zpo = 1
            Size = 2
            mass = 0.15
            APSize = 2
            enedame = 7
            
            PBody = CreateSquareBody(Size: [27.5,17], Position: [1.25,0], StandardSize: Size * BSize)
            if etype == 37 {
              
            }
            if etype == 38 {
              
            }
        }
        
        if 39 <= etype && etype <= 41{ //地上ロボット
            
        }
        
        if 42 <= etype && etype <= 44{ //カラードラゴン
            Gravity = false
            Zpo = 1
            Size = 6
            mass = 1.0
            APSize = 6
            PBody =  CreateSquareBody(Size: [22.2,44,4], Position: [0,0], StandardSize:  Size * BSize)
            if etype == 42 { enedame = 9 }
            if etype == 43 { enedame = 10 }
            if etype == 44 { enedame = 11 }
            
            if edre{ etexture = enemyRAnime[19][0] }
            else   { etexture = enemyLAnime[19][0] }
        }
        
        if etype == 45 {// 魔王
            
        }
        
        if etype == 46 {// 宇宙生物
            
        }
        
        //敵出現演出
        let enemyBGM = SKAudioNode(fileNamed: "SE/enemyp")
        enemyBGM.autoplayLooped = false
        let enemyAP = SKSpriteNode(texture: enemyAp[0])
        enemyAP.position = ep
        enemyAP.scale(to: CGSize(width: BSize * APSize, height: BSize * APSize))
        enemyAP.zPosition = 1
        addChild(enemyAP)
        enemyAP.addChild(enemyBGM)
        enemyBGM.run(SKAction.play())
        let enemyAPAnime = SKAction.animate(with: enemyAp, timePerFrame: 1.0 / 16.0)
        let deleteA = SKAction.removeFromParent()
        enemyAP.run(SKAction.sequence([enemyAPAnime,deleteA]))
        
        let Ene = SKSpriteNode(texture: etexture)
        Ene.scale(to: CGSize(width: BSize * Size, height: BSize * Size))
        Ene.position = ep
        Ene.physicsBody = PBody
        //敵のパラメータの設定
        Ene.userData = ["type" :etype,"Pnumber":epnumber,"HP":eHP,"damage":eDame ,"damageflag":false,"APSize":APSize,"dtype":enedame]
        if Gravity{
            Ene.physicsBody?.categoryBitMask = enemyCategory
            Ene.physicsBody?.contactTestBitMask = enemyCT
            Ene.physicsBody?.collisionBitMask = enemyCo
        }else{
            Ene.physicsBody?.categoryBitMask = enemy2Category
            Ene.physicsBody?.contactTestBitMask = enemy2CT
            Ene.physicsBody?.collisionBitMask = enemy2Co
        }
        // 着色
        if etype == 34 { Ene.color = .green     ;Ene.colorBlendFactor = 0.3 }
        if etype == 36 { Ene.color = .purple    ;Ene.colorBlendFactor = 0.5 }
        if etype == 38 { Ene.color = .red       ;Ene.colorBlendFactor = 0.7 }
        if etype == 40 { Ene.color = .red       ;Ene.colorBlendFactor = 0.7 }
        if etype == 42 { Ene.color = .red       ;Ene.colorBlendFactor = 0.7 }
        if etype == 43 { Ene.color = .cyan      ;Ene.colorBlendFactor = 0.3 }
        if etype == 44 { Ene.color = .green     ;Ene.colorBlendFactor = 0.4 }
        if etype == 47 { Ene.color = .black     ;Ene.colorBlendFactor = 0.8 }
        if etype == 48 { Ene.color = .black     ;Ene.colorBlendFactor = 0.8 }
        if etype == 49 { Ene.color = .black     ;Ene.colorBlendFactor = 0.8 }
        
        Ene.physicsBody?.isDynamic = false
        Ene.physicsBody?.allowsRotation = false
        Ene.physicsBody?.affectedByGravity = Gravity
        Ene.physicsBody?.mass = mass
        Ene.zPosition = Zpo
        addChild(Ene)
        ecount += 1

        if etype == 10 || etype == 20 || etype == 30 || (41 <= etype && etype <= 46){
            print("センサ&アクションロック(ボス出現)")
            if etype == 10 {
                let eSE = SKAudioNode(fileNamed: "SE/e1_0.mp3")
                eSE.autoplayLooped = false
                Ene.addChild(eSE)
                eSE.run(SKAction.play())
            }
            if etype == 20 {
                let eSE = SKAudioNode(fileNamed: "SE/e2_0.mp3")
                eSE.autoplayLooped = false
                Ene.addChild(eSE)
                eSE.run(SKAction.play())
            }
            if etype == 30 {
                let eSE = SKAudioNode(fileNamed: "SE/e3_0.mp3")
                eSE.autoplayLooped = false
                Ene.addChild(eSE)
                eSE.run(SKAction.play())
            }
            if 42 <= etype && etype <= 44{
                let eSE = SKAudioNode(fileNamed: "SE/e7_0.mp3")
                eSE.autoplayLooped = false
                Ene.addChild(eSE)
                eSE.run(SKAction.play())
            }
            self.run(SKAction.wait(forDuration: 3.0)){
                Ene.physicsBody?.isDynamic = true
                Ene.SetBool(name: "damageflag", Bool: true)
                self.run(SKAction.wait(forDuration: 1.0)){
                    self.enemyAction(object: Ene, type: etype, enemyd: edre)
                }
            }
            addBossVector(Boss: Ene)
            
            //ボスエフェクトを使う場合
            if 41 <= etype && etype <= 46{
                BossEffect = SKSpriteNode(imageNamed: "block13")
                BossEffect.scale(to: CGSize(width: APSize * BSize, height: APSize * BSize))
                BossEffect.position = Ene.position
                BossEffect.zPosition = 10
                BossEffect.alpha = 0.0
                addChild(BossEffect)
                BossEFlag = true
            }
        }else{
            Ene.physicsBody?.isDynamic = true
            self.run(SKAction.wait(forDuration: 1.0)){
                Ene.SetBool(name: "damageflag", Bool: true)
                self.enemyAction(object: Ene, type: etype, enemyd: edre)
            }
        }
    }
    
//1¥敵のアクションを定義
    func enemyAction(object:SKSpriteNode, type:Int, enemyd:Bool){
        let Eobject = object
        var enemyDD = enemyd
        var epxx:CGFloat!
        //1_1_1ネズミ通常型,亜種
        if 1 <= type && type <= 6{
            var ddx:CGFloat = 1 //移動量の定義
            if 1 <= type && type <= 3 { ddx = 1.5 }
            if 4 <= type && type <= 6 { ddx = 3.0 }
            let walktime = 0.5
            let Atime = walktime / Double(enemyAN[1])
            var animeType = 1 ;if type >= 4 { animeType = 2}
            
            let LwalkAction = SKAction.repeatForever(SKAction.animate(with: enemyLAnime[animeType], timePerFrame: Atime))
            let RwalkAction = SKAction.repeatForever(SKAction.animate(with: enemyRAnime[animeType], timePerFrame: Atime))
            var RmoveAction = SKAction.moveBy(x: ddx * BSize, y: 0, duration: 1.0)
            var LmoveAction = SKAction.moveBy(x: -ddx * BSize, y: 0, duration: 1.0)
            let lastAction = SKAction.run { //動いた後に実行するコード
                if epxx == nil{// 初回のみ実行
                    epxx = Eobject.position.x //epxxの値を更新
                    if enemyDD{Eobject.run(RmoveAction)}else{Eobject.run(LmoveAction)} //動くアクションを実行
                }else{// 2回目以降
                    let edis = epxx - Eobject.position.x  //敵が動いた距離
                    if edis.abs() < self.SSize * 5{ //敵が動いていなかった場合
                   //     Eobject.removeAllActions()
                        if enemyDD{ enemyDD = false}else{ enemyDD = true }
                        if enemyDD{
                            Eobject.run(RmoveAction)
                            Eobject.run(RwalkAction)
                        }else{
                            Eobject.run(LmoveAction)
                            Eobject.run(LwalkAction)
                        }
                    }else{ if enemyDD{Eobject.run(RmoveAction)}else{Eobject.run(LmoveAction)} }
                    epxx = Eobject.position.x //epxxの値を更新
                }
            }
            //移動アクションの作成
            RmoveAction = SKAction.sequence([RmoveAction,lastAction])
            LmoveAction = SKAction.sequence([LmoveAction,lastAction])
            //アクションの実行
            if enemyDD{
                Eobject.run(RmoveAction)
                Eobject.run(RwalkAction)
            }else{
                Eobject.run(LmoveAction)
                Eobject.run(LwalkAction)
            }
        }
        //1_1_1ネズミ希少種、王種
        else if 7 <= type && type <= 10{
            //歩くパラメータ
            let ddx:CGFloat = 1.5       //歩く移動量の定義
            let walktime = 1.0          //歩く１サイクルの時間
            let WAnimeC = 2             //ワンサイクルでのループ回数
            //攻撃パラメータ
            let Addx:CGFloat = 4.0      //攻撃距離(タックル)
            let Attacktime = 1.0        //攻撃１サイクルの時間
            let AAnimeC = 1             //ワンサイクルでのループ回数
            let attackdis:CGFloat = 6.0   //攻撃使用範囲
            
            let wtime = walktime / Double(enemyAN[3]) / Double(WAnimeC)
            let Atime = Attacktime / Double(enemyAN[4]) / Double(AAnimeC)
            
            let E1_1 = SKAudioNode(fileNamed: "SE/e1_1.wav")
            let E1_2 = SKAudioNode(fileNamed: "SE/e1_2.wav")
            E1_1.autoplayLooped = false
            E1_2.autoplayLooped = false
            Eobject.addChild(E1_1)
            Eobject.addChild(E1_2)
            
            //歩くアニメ
            var RwalkAction = SKAction.repeat(SKAction.animate(with: enemyRAnime[3], timePerFrame: wtime), count: WAnimeC)
            var LwalkAction = SKAction.repeat(SKAction.animate(with: enemyLAnime[3], timePerFrame: wtime), count: WAnimeC)
            //攻撃アニメ
            var RAAction = SKAction.repeat(SKAction.animate(with: enemyRAnime[4], timePerFrame: Atime), count: AAnimeC)
            var LAAction = SKAction.repeat(SKAction.animate(with: enemyLAnime[4], timePerFrame: Atime), count: AAnimeC)
            //歩く時の移動
            var RmoveAction = SKAction.moveBy(x: ddx * BSize, y: 0, duration: walktime)
            var LmoveAction = SKAction.moveBy(x: -ddx * BSize, y: 0, duration: walktime)
            //攻撃時の移動
            var RAmoveAction = SKAction.moveBy(x: Addx * BSize, y: 0, duration: Atime * 6.0)
            var LAmoveAction = SKAction.moveBy(x: -Addx * BSize, y: 0, duration: Atime * 6.0)
            //攻撃溜め時間
            let waitAction = SKAction.wait(forDuration: Atime * 4.0)
            
            let nextAction = SKAction.run { //動いた後に実行するコード
                if epxx == nil{// 初回のみ実行
                    epxx = Eobject.position.x //epxxの値を更新 振り向き判定に使用
                    if enemyDD{ Eobject.run(RwalkAction) }else{ Eobject.run(LwalkAction) }
                }else{// 2回目以降
                    let edis = epxx - Eobject.position.x            //敵が動いた距離
                    let EPx = Eobject.position.x - self.body.position.x  //敵とプレイヤーの距離
                    if (0 < EPx && EPx <= attackdis * self.BSize) && enemyDD == false { //左に攻撃
                        Eobject.run(LAAction)
                        E1_1.run(SKAction.play())
                        self.run(SKAction.wait(forDuration: Atime * 4.0)){
                            E1_2.run(SKAction.play())
                        }
                    }else if (-attackdis * self.BSize <= EPx && EPx < 0) && enemyDD { //右に攻撃
                        Eobject.run(RAAction)
                        E1_1.run(SKAction.play())
                        self.run(SKAction.wait(forDuration: Atime * 4.0)){
                            E1_2.run(SKAction.play())
                        }
                    }else{                                                            //歩く
                        if edis.abs() < self.SSize * 5{ //敵が動いていなかった場合
                            if enemyDD{ enemyDD = false}else{ enemyDD = true }
                        }
                        if enemyDD{ Eobject.run(RwalkAction) }else{ Eobject.run(LwalkAction) }
                    }
                    epxx = Eobject.position.x //epxxの値を更新
                }
            }
            //アクションの合成
            RmoveAction = SKAction.sequence([RmoveAction,nextAction])
            LmoveAction = SKAction.sequence([LmoveAction,nextAction])
            RwalkAction = SKAction.group([RwalkAction,RmoveAction])
            LwalkAction = SKAction.group([LwalkAction,LmoveAction])
            
            RAmoveAction = SKAction.sequence([waitAction,RAmoveAction,nextAction])
            LAmoveAction = SKAction.sequence([waitAction,LAmoveAction,nextAction])
            RAAction = SKAction.group([RAAction,RAmoveAction])
            LAAction = SKAction.group([LAAction,LAmoveAction])
    
            //アクションの実行
            if enemyDD{ Eobject.run(RwalkAction) }else{ Eobject.run(LwalkAction) }
        }
        //1_1_2スライム通常型,亜種
        else if 11 <= type && type <= 16{
            let jumpx: CGFloat = 2 //縦移動距離
            let jumpy: CGFloat = 2   //横移動距離
            //次のジャンプまでの時間
            var nextwaitTime = 2.0 ;if 14 <= type && type <= 16{ nextwaitTime = 1.0 }
            let jumptime = 1.0      //ジャンプの時間
            let animetime = 0.8     //アニメの時間
            
            let enemyABGM = SKAudioNode(fileNamed: "SE/ejump")
            enemyABGM.autoplayLooped = false
            Eobject.addChild(enemyABGM)
            var animeType = 5 ;if type >= 14 { animeType = 6}
            //ジャンプのアニメ
            let RjumpAnime = SKAction.animate(with: enemyRAnime[animeType], timePerFrame: animetime / Double(enemyAN[animeType]))
            let LjumpAnime = SKAction.animate(with: enemyLAnime[animeType], timePerFrame: animetime / Double(enemyAN[animeType]))
            
            let jumpBwait = SKAction.wait(forDuration: animetime * 9.0 / 12.0)                  //ジャンプ前の構える時間
            
            let jumpF = SKAction.run { Eobject.physicsBody?.affectedByGravity = false }         //重力を無効化
            let playSE = SKAction.run { enemyABGM.run(SKAction.play()) }                        //ジャンプSE再生
            
            let RM = SKAction.moveBy(x: jumpx * BSize, y: jumpy * BSize, duration: jumptime)    //右にジャンプ移動
            let LM = SKAction.moveBy(x: -jumpx * BSize, y: jumpy * BSize, duration: jumptime)   //左にジャンプ移動
            
            let jumpL = SKAction.run { Eobject.physicsBody?.affectedByGravity = true }          //重力を有効化
            
            let nextwait = SKAction.wait(forDuration: nextwaitTime)                             //次のアクションを実行する時間
            
            let jumpRS = SKAction.sequence([jumpF,jumpBwait,playSE,RM,jumpL,nextwait])
            let jumpLS = SKAction.sequence([jumpF,jumpBwait,playSE,LM,jumpL,nextwait])
            
         
            var jumpRAction = SKAction.group([jumpRS,RjumpAnime])
            var jumpLAction = SKAction.group([jumpLS,LjumpAnime])
            let lastAction = SKAction.run { //動いた後に実行するコード
                if epxx == nil{// 初回のみ実行
                    epxx = Eobject.position.x //epxxの値を更新
                    if enemyDD{Eobject.run(jumpRAction)}else{Eobject.run(jumpLAction)} //動くアクションを実行
                }else{// 2回目以降
                    let edis = epxx - Eobject.position.x  //敵が動いた距離
                    if edis.abs() < self.SSize * 5{ //敵が動いていなかった場合
                        //        Eobject.removeAllActions()
                        if enemyDD{ enemyDD = false}else{ enemyDD = true }
                        if enemyDD{
                            Eobject.run(jumpRAction)
                        }else{
                            Eobject.run(jumpLAction)
                        }
                    }else{ if enemyDD{Eobject.run(jumpRAction)}else{Eobject.run(jumpLAction)} }
                    epxx = Eobject.position.x //epxxの値を更新
                }
            }
            jumpRAction = SKAction.sequence([jumpRAction,lastAction])
            jumpLAction = SKAction.sequence([jumpLAction,lastAction])
            //アクションの実行
            if enemyDD{
                Eobject.run(jumpRAction)
            }else{
                Eobject.run(jumpLAction)
            }
        }
        //1_1_2スライム希少種,王種
        else if 17 <= type && type <= 20{
            let jumptime = 1.0          //ジャンプの時間
            let animetime = 0.8         //アニメの時間
            let jumpD = 7               //ジャンプ距離
            let NNwaittime = 2.0        //通常時のジャンプ間隔
            let FNwaittime = 1.0        //発狂時のジャンプ間隔
            var enemyS: Bool = false    //発狂状態かの判定
            
            //効果音の読み込み
            let enemyABGM = SKAudioNode(fileNamed: "SE/ejump")
            enemyABGM.autoplayLooped = false
            Eobject.addChild(enemyABGM)
            let playSE = SKAction.run { enemyABGM.run(SKAction.play()) }
            
            //ジャンプアニメの読み込み
            let RjumpAnime1 = SKAction.animate(with: enemyRAnime[7], timePerFrame: animetime / Double(enemyAN[7]))
            let LjumpAnime1 = SKAction.animate(with: enemyLAnime[7], timePerFrame: animetime / Double(enemyAN[7]))
            let RjumpAnime2 = SKAction.animate(with: enemyRAnime[8], timePerFrame: animetime / Double(enemyAN[8]))
            let LjumpAnime2 = SKAction.animate(with: enemyLAnime[8], timePerFrame: animetime / Double(enemyAN[8]))
            
            //ジャンプ前の構える時間
            let jumpBwait = SKAction.wait(forDuration: animetime * 9.0 / 12.0)
            
            //次のアクションを実行するまでの待機あアクション
            let nextwait1 = SKAction.wait(forDuration: NNwaittime)
            let nextwait2 = SKAction.wait(forDuration: FNwaittime)
            
            //重力影響のステータスを変更するアクション
            let Goff = SKAction.run { Eobject.physicsBody?.affectedByGravity = false }         //重力を無効化
            let Gon = SKAction.run { Eobject.physicsBody?.affectedByGravity = true }
            
            var WaitAction: SKAction!
            let JumpAction = SKAction.run {
                //ジャンプ方向の決定
                let dd = self.body.position.x - Eobject.position.x
                var a:CGFloat = 1; if dd < 0 { a = -a }
                let Jx =  CGFloat( Int.random(in: 1 ..< jumpD) )
                let Jy = CGFloat(jumpD) - Jx
                
                let jump = SKAction.moveBy(x: Jx * self.BSize * a, y: Jy * self.BSize, duration: jumptime)
                var jumpA = SKAction.sequence([Goff,jumpBwait,playSE,jump,Gon,WaitAction])
                
                if dd >= 0{
                    if enemyS{ jumpA = SKAction.group([jumpA,RjumpAnime2]) }
                    else     { jumpA = SKAction.group([jumpA,RjumpAnime1]) }
                }else{
                    if enemyS{ jumpA = SKAction.group([jumpA,LjumpAnime2]) }
                    else     { jumpA = SKAction.group([jumpA,LjumpAnime1]) }
                }
                
                Eobject.run(jumpA)
            }
            WaitAction = SKAction.run {
                //発狂モードに変化さえるか
                if enemyS == false && type == 20{
                    if Eobject.GetInt(name: "HP") <= 50{
                        enemyS = true
                    }
                }

                //待機アクションの生成
                var WAction: SKAction!
                if enemyS{ //発狂モードなら
                    WAction = SKAction.sequence([nextwait2,JumpAction])
                }else{     //通常モードなら
                    WAction = SKAction.sequence([nextwait1,JumpAction])
                }
                Eobject.run(WAction)
            }
            
            Eobject.run(WaitAction)
        }
        //1_1_3コウモリ通常種
        else if 21 <= type && type <= 26{
            //移動タイプ (21:縦 22:横 23:四角 24:ひし形 25:円,26:ランダム)
            let moved: CGFloat = 4.0             //移動距離
            let time1: Double = 3.0            //移動時間
            let animetime: Double = 0.768
            let time2: Double = 10.0
            
            let dis = moved * BSize
            let Fep = Eobject.position     //初期の敵位置
            
            //共通アクション（羽ばたき音とアニメ）
            let SE = SKAudioNode(fileNamed: "SE/e3_1.mp3")
            Eobject.addChild(SE)
            let Ranime = SKAction.animate(with: enemyRAnime[9], timePerFrame: animetime / Double(enemyAN[9]))
            let Lanime = SKAction.animate(with: enemyLAnime[9], timePerFrame: animetime / Double(enemyAN[9]))
            if enemyDD{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
            
            let move1:[[CGFloat]] = [[0,0],[0,1],[0,-1]]            //縦
            var move1point: [CGPoint] = []
            for n in 0 ..< move1.count{ move1point.append(CGPoint(x: Fep.x + move1[n][0] * dis, y: Fep.y + move1[n][1] * dis)) }
            let move2:[[CGFloat]] = [[0,0],[1,0],[-1,0]]            //横
            var move2point: [CGPoint] = []
            for n in 0 ..< move2.count{ move2point.append(CGPoint(x: Fep.x + move2[n][0] * dis, y: Fep.y + move2[n][1] * dis)) }
            let move3:[[CGFloat]] = [[1,1],[1,-1],[-1,-1],[-1,1]]   //四角
            var move3point: [CGPoint] = []
            for n in 0 ..< move3.count{ move3point.append(CGPoint(x: Fep.x + move3[n][0] * dis, y: Fep.y + move3[n][1] * dis)) }
            let move4:[[CGFloat]] = [[0,1],[-1,0],[0,-1],[1,0]]     //菱形
            var move4point: [CGPoint] = []
            for n in 0 ..< move4.count{ move4point.append(CGPoint(x: Fep.x + move4[n][0] * dis, y: Fep.y + move4[n][1] * dis)) }
            var move5point: [CGPoint] = []                          //円
            for n in 0 ..< 36 {
                move5point.append(CGPoint(x: Fep.x + dis * cos(CGFloat(n) * psita * 10.0), y: Fep.y + dis * sin(CGFloat(n) * psita * 10.0)))
            }
            
            if type == 21 {
                let random = Int.random(in: 1...2)
                var trackN: [Int] = []
                if random == 1{ trackN = [1,0,2,0] }
                if random == 2{ trackN = [2,0,1,0] }
                var moveAction: SKAction!
                for n in 0..<trackN.count{
                    let mAction = SKAction.move(to: move1point[trackN[n]], duration: time1)
                    if n == 0{ moveAction = mAction }
                    else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                }
                Eobject.run(SKAction.repeatForever(moveAction))
            }else if type == 22{
                let random = Int.random(in: 1...2)
                var trackN: [Int] = []
                if random == 1{ trackN = [1,0,2,0] }
                if random == 2{ trackN = [2,0,1,0] }
                var moveAction: SKAction!
                for n in 0..<trackN.count{
                    let mAction = SKAction.move(to: move2point[trackN[n]], duration: time1)
                    if n == 0{ moveAction = mAction }
                    else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                }
                Eobject.run(SKAction.repeatForever(moveAction))
            }else if type == 23{
                let random = Int.random(in: 1...8)
                var trackN: [Int] = []
                for n in 0...3{
                    var a = 0
                    if random <= 4{ a = random + n ;if a >= 5 {a -= 4} }
                    if random >= 5{ a = random - 4 - n ;if a <= 0 {a += 4} }
                    trackN.append(a - 1)
                }
                var moveAction: SKAction!
                for n in 0..<trackN.count{
                    let mAction = SKAction.move(to: move3point[trackN[n]], duration: time1)
                    if n == 0{ moveAction = mAction }
                    else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                }
                Eobject.run(SKAction.repeatForever(moveAction))
            }else if type == 24{
                let random = Int.random(in: 1...8)
                var trackN: [Int] = []
                for n in 0...3{
                    var a = 0
                    if random <= 4{ a = random + n ;if a >= 5 {a -= 4} }
                    if random >= 5{ a = random - 4 - n ;if a <= 0 {a += 4} }
                    trackN.append(a - 1)
                }
                var moveAction: SKAction!
                for n in 0..<trackN.count{
                    let mAction = SKAction.move(to: move4point[trackN[n]], duration: time1)
                    if n == 0{ moveAction = mAction }
                    else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                }
                Eobject.run(SKAction.repeatForever(moveAction))
            }else if type == 25{
                let random = Int.random(in: 1...72)
                var trackN: [Int] = []
                for n in 0...35{
                    var a = 0
                    if random <= 36{ a = random + n ;if a >= 37 {a -= 36} }
                    if random >= 37{ a = random - 36 - n ;if a <= 0 {a += 36} }
                    trackN.append(a - 1)
                }
                var moveAction: SKAction!
                for n in 0..<trackN.count{
                    let mAction = SKAction.move(to: move5point[trackN[n]], duration: time2 / 36.0)
                    if n == 0{ moveAction = mAction }
                    else     {moveAction = SKAction.sequence([moveAction,mAction]) }
                }
                let FmoveAction = SKAction.move(to: move5point[trackN[0]], duration: time1)
                Eobject.run(SKAction.sequence([FmoveAction,SKAction.repeatForever(moveAction)]))
            }else if type == 26{
                var EAction: SKAction!
                EAction = SKAction.run {
                    let Rtype = Int.random(in: 1...5)
                    var moveAction: SKAction!
                    if          Rtype == 1{
                        let random = Int.random(in: 1...2)
                        var trackN: [Int] = []
                        if random == 1{ trackN = [1,0,2,0] }
                        if random == 2{ trackN = [2,0,1,0] }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move1point[trackN[n]], duration: time1)
                            if n == 0{ moveAction = mAction }
                            else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                        }
                    }else if    Rtype == 2{
                        let random = Int.random(in: 1...2)
                        var trackN: [Int] = []
                        if random == 1{ trackN = [1,0,2,0] }
                        if random == 2{ trackN = [2,0,1,0] }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move2point[trackN[n]], duration: time1)
                            if n == 0{ moveAction = mAction }
                            else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                        }
                    }else if    Rtype == 3{
                        let random = Int.random(in: 1...8)
                        var trackN: [Int] = []
                        for n in 0...3{
                            var a = 0
                            if random <= 4{ a = random + n ;if a >= 5 {a -= 4} }
                            if random >= 5{ a = random - 4 - n ;if a <= 0 {a += 4} }
                            trackN.append(a - 1)
                        }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move3point[trackN[n]], duration: time1)
                            if n == 0{ moveAction = mAction }
                            else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                        }
                    }else if    Rtype == 4{
                        let random = Int.random(in: 1...8)
                        var trackN: [Int] = []
                        for n in 0...3{
                            var a = 0
                            if random <= 4{ a = random + n ;if a >= 5 {a -= 4} }
                            if random >= 5{ a = random - 4 - n ;if a <= 0 {a += 4} }
                            trackN.append(a - 1)
                        }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move4point[trackN[n]], duration: time1)
                            if n == 0{ moveAction = mAction }
                            else     { moveAction = SKAction.sequence([moveAction,mAction])   }
                        }
                    }else if    Rtype == 5{
                        let random = Int.random(in: 1...72)
                        var trackN: [Int] = []
                        for n in 0...35{
                            var a = 0
                            if random <= 36{ a = random + n ;if a >= 37 {a -= 36} }
                            if random >= 37{ a = random - 36 - n ;if a <= 0 {a += 36} }
                            trackN.append(a - 1)
                        }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move5point[trackN[n]], duration: time2 / 36.0)
                            if n == 0{ moveAction = mAction }
                            else     {moveAction = SKAction.sequence([moveAction,mAction]) }
                        }
                        let FmoveAction = SKAction.move(to: move5point[trackN[0]], duration: time1)
                        moveAction = SKAction.sequence([FmoveAction,moveAction])
                    }
                    let playAction = SKAction.sequence([moveAction,EAction])
                    Eobject.run(playAction)
                }
                Eobject.run(EAction)
            }
        }
        //1_1_3コウモリ亜種、希少種、王種
        else if 27 <= type && type <= 30{
            var Waittime = 3.0
            let Speed:CGFloat = 5.0
            let dis: CGFloat = 6.0
            let animetime: Double = 0.768
            //共用アクション
            let SE = SKAudioNode(fileNamed: "SE/e3_1.mp3")
            Eobject.addChild(SE)

            let attackBSE = SKAudioNode(fileNamed: "SE/e3_2.mp3")
            attackBSE.autoplayLooped = false
            Eobject.addChild(attackBSE)
            let SEplay = SKAction.run{ attackBSE.run(SKAction.play()) }
            
            if type == 27 || type == 28{
                let Ranime = SKAction.animate(with: enemyRAnime[10], timePerFrame: animetime / Double(enemyAN[10]))
                let Lanime = SKAction.animate(with: enemyLAnime[10], timePerFrame: animetime / Double(enemyAN[10]))
                if enemyDD{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                if type == 28 { Waittime = 1.0 }
                var waitAction = SKAction.wait(forDuration: Waittime - 1.0)
                let waitAction2 = SKAction.wait(forDuration: 1.0)
                waitAction = SKAction.sequence([waitAction,SEplay,waitAction2])
                let EAction = SKAction.run {
                    let pp = self.body.position
                    let ep = Eobject.position
                    let Angle = self.angle(p1: ep, p2: pp)
                    let movePoint = CGPoint(x: pp.x + 20 * self.BSize * sin(Angle), y: pp.y + 20 * self.BSize * -cos(Angle))
                    let movetime = self.distance(p1: ep, p2: movePoint) / (Speed * self.BSize)
                    let moveAction = SKAction.move(to: movePoint, duration: Double(movetime))
                    if Angle >= 0{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                    Eobject.run(moveAction)
                }
                let playAction = SKAction.sequence([waitAction,EAction])
                Eobject.run(playAction)
            }
            if type == 29{
                let Ranime = SKAction.animate(with: enemyRAnime[11], timePerFrame: animetime / Double(enemyAN[11]))
                let Lanime = SKAction.animate(with: enemyLAnime[11], timePerFrame: animetime / Double(enemyAN[11]))
                if enemyDD{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                var playAction: SKAction!
                Waittime = 1.0 
                var waitAction = SKAction.wait(forDuration: Waittime - 1.0)
                let waitAction2 = SKAction.wait(forDuration: 1.0)
                waitAction = SKAction.sequence([waitAction,SEplay,waitAction2])
                playAction = SKAction.run{
                    // ここに変動するアクションを記入
                    let pp = self.body.position
                    let ep = Eobject.position
                    let Angle = self.angle(p1: ep, p2: pp)
                    let movePoint = CGPoint(x: pp.x + dis * self.BSize * sin(Angle), y: pp.y + dis * self.BSize * -cos(Angle))
                    let movetime = self.distance(p1: ep, p2: movePoint) / (Speed * self.BSize)
                    if Angle >= 0{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                    let moveAction = SKAction.move(to: movePoint, duration: Double(movetime))
                    // 変動するアクションを記入はここまで
                    let EAction = SKAction.sequence([waitAction,moveAction,playAction])
                    Eobject.run(EAction)
                }
                Eobject.run(playAction)
            }
            
            if type == 30 {
                let ASpeed:CGFloat = 7.0    //突進攻撃のスピード
                let Adis:CGFloat = 7.0      //突進攻撃後の切り返し距離
                let Adis2:CGFloat = 15.0    //突進攻撃終了地点の距離
                let Pdis: CGFloat = 10.0    //次の攻撃開始地点の間隔
                let NSpeed:CGFloat = 3.0    //次の攻撃開始地点までの移動スピード
                var Nexttime1: Double!      //次の攻撃開始までの待機時間(残りHPにより変動)
                var Nexttime2: Double!      //次の攻撃開始までの待機時間(残りHPにより変動)
                
                let squaretime: Double = 5.0
                let circletime: Double = 12.0
                
                let Ranime = SKAction.animate(with: enemyRAnime[11], timePerFrame: animetime / Double(enemyAN[11]))
                let Lanime = SKAction.animate(with: enemyLAnime[11], timePerFrame: animetime / Double(enemyAN[11]))
                if enemyDD{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                
                let Fep = Eobject.position     //初期の敵位置
                //次の攻撃開始地点の計算
                var nextPoint:[CGPoint] = []
                for yy in -1...1{
                    for xx in -1...1{
                        nextPoint.append(CGPoint(x: Fep.x + CGFloat(xx) * Pdis * BSize, y: Fep.y + CGFloat(yy) * Pdis * BSize))
                    }
                }
                
                //四角移動と円移動の移動地点の計算
                let move1:[[CGFloat]] = [[1,1],[1,-1],[-1,-1],[-1,1]]   //四角
                var move1point: [CGPoint] = []
                for n in 0 ..< move1.count{ move1point.append(CGPoint(x: Fep.x + move1[n][0] * Pdis * BSize, y: Fep.y + move1[n][1] * Pdis * BSize)) }
                var move2point: [CGPoint] = []                          //円
                for n in 0 ..< 36 {
                    move2point.append(CGPoint(x: Fep.x + Pdis * cos(CGFloat(n) * psita * 10.0) * BSize, y: Fep.y + Pdis * sin(CGFloat(n) * psita * 10.0) * BSize))
                }
                
                let attackSE = SKAudioNode(fileNamed: "SE/e3_3.wav")
                attackSE.autoplayLooped = false
                Eobject.addChild(attackSE)
                let SEplay2 = SKAction.run{ attackSE.run(SKAction.play()) }
                
                var REffectBody: [SKPhysicsBody] = []
                REffectBody.append(CreatePolygonBody(Position: [[-41.15,-1.04],[13.54,13.54],[13.54,-17.71]], StandardSize: Eobject.size.width))
                REffectBody.append(CreatePolygonBody(Position: [[-5.73,-8.85],[-5.73,6.25],[26.56,24.4],[26.56,-25]], StandardSize: Eobject.size.width))
                REffectBody.append(CreatePolygonBody(Position: [[23.96,-32.29],[6.77,-1.56],[22.92,27.08],[37.5,-1.56]], StandardSize: Eobject.size.width))
                
                var LEffectBody: [SKPhysicsBody] = []
                LEffectBody.append(CreatePolygonBody(Position: [[41.15,-1.04],[-13.54,13.54],[-13.54,-17.71]], StandardSize: Eobject.size.width))
                LEffectBody.append(CreatePolygonBody(Position: [[5.73,-8.85],[5.73,6.25],[-26.56,24.4],[-26.56,-25]], StandardSize: Eobject.size.width))
                LEffectBody.append(CreatePolygonBody(Position: [[-23.96,-32.29],[-6.77,-1.56],[-22.92,27.08],[-37.5,-1.56]], StandardSize: Eobject.size.width))
                
                var playAction: SKAction!
                playAction = SKAction.run{
                    // ここに変動するアクションの記述
                    //次の地点へ移動して、次のアクションを実行
                    let nextMoveAction = SKAction.run {
                        let EHP = Eobject.GetInt(name: "HP")
                        if      EHP >= 100{ Nexttime1 = 4.0; Nexttime2 = 1.0 }
                        else if EHP >= 50{ Nexttime1 = 2.0; Nexttime2 = 1.0 }
                        else              { Nexttime1 = 0.0; Nexttime2 = 1.0 }
                        let nextRandom = Int.random(in: 0...8)
                        let Pep = Eobject.position
                        let NP = nextPoint[nextRandom]
                        let movetime = self.distance(p1: Pep, p2: NP) / (NSpeed * self.BSize)
                        var MNAction = SKAction.move(to: NP, duration: Double(movetime))
                        let NwaitAction = SKAction.sequence([SKAction.wait(forDuration: Nexttime1)
                                                            ,SEplay
                                                            ,SKAction.wait(forDuration: Nexttime2)])
                        MNAction = SKAction.sequence([MNAction,NwaitAction,playAction])
                        Eobject.run(MNAction)
                    }
                    var RandomAction: SKAction!
                    let RandomA = Int.random(in: 1...6)
                    if RandomA == 1{        //四角移動
                        let random = Int.random(in: 1...8)
                        var trackN: [Int] = []
                        for n in 0...3{
                            var a = 0
                            if random <= 4{ a = random + n ;if a >= 5 {a -= 4} }
                            if random >= 5{ a = random - 4 - n ;if a <= 0 {a += 4} }
                            trackN.append(a - 1)
                        }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move1point[trackN[n]], duration: squaretime)
                            if n == 0{ RandomAction = mAction }
                            else     { RandomAction = SKAction.sequence([RandomAction,mAction])   }
                        }
                        let EAction = SKAction.sequence([RandomAction,nextMoveAction])    //変動アクションのループ化
                        Eobject.run(EAction)
                    }else if RandomA == 2{  //円移動
                        let random = Int.random(in: 1...72)
                        var trackN: [Int] = []
                        for n in 0...35{
                            var a = 0
                            if random <= 36{ a = random + n ;if a >= 37 {a -= 36} }
                            if random >= 37{ a = random - 36 - n ;if a <= 0 {a += 36} }
                            trackN.append(a - 1)
                        }
                        for n in 0..<trackN.count{
                            let mAction = SKAction.move(to: move2point[trackN[n]], duration: circletime / 36.0)
                            if n == 0{ RandomAction = mAction }
                            else     { RandomAction = SKAction.sequence([RandomAction,mAction]) }
                        }
                        let FmoveAction = SKAction.move(to: move2point[trackN[0]], duration: 4.0)
                        RandomAction = SKAction.sequence([FmoveAction,RandomAction])
                        let EAction = SKAction.sequence([RandomAction,nextMoveAction])    //変動アクションのループ化
                        Eobject.run(EAction)
                    }else if RandomA == 3{  //突進1回
                        let pp = self.body.position
                        let ep = Eobject.position
                        let Angle = self.angle(p1: ep, p2: pp)
                        let movePoint = CGPoint(x: pp.x + Adis * self.BSize * sin(Angle), y: pp.y + Adis * self.BSize * -cos(Angle))
                        let movetime = self.distance(p1: ep, p2: movePoint) / (ASpeed * self.BSize)
                        if Angle >= 0{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                        RandomAction = SKAction.move(to: movePoint, duration: Double(movetime))
                        let EAction = SKAction.sequence([RandomAction,nextMoveAction])    //変動アクションのループ化
                        Eobject.run(EAction)
                    }else if RandomA == 4{  //突進3連続
                        let Attack3 = SKAction.run{
                            self.run(SEplay)
                            let WAction = SKAction.wait(forDuration: 0.5)
                            let pp = self.body.position
                            let ep = Eobject.position
                            let Angle = self.angle(p1: ep, p2: pp)
                            let movePoint = CGPoint(x: pp.x + Adis * self.BSize * sin(Angle), y: pp.y + Adis * self.BSize * -cos(Angle))
                            let movetime = self.distance(p1: ep, p2: movePoint) / (ASpeed * self.BSize)
                            if Angle >= 0{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                            let AttackAction = SKAction.move(to: movePoint, duration: Double(movetime))
                            let EAction = SKAction.sequence([WAction,AttackAction,nextMoveAction])    //変動アクションのループ化
                            Eobject.run(EAction)
                        }
                        let Attack2 = SKAction.run{
                            self.run(SEplay)
                            let WAction = SKAction.wait(forDuration: 0.5)
                            let pp = self.body.position
                            let ep = Eobject.position
                            let Angle = self.angle(p1: ep, p2: pp)
                            let movePoint = CGPoint(x: pp.x + Adis * self.BSize * sin(Angle), y: pp.y + Adis * self.BSize * -cos(Angle))
                            let movetime = self.distance(p1: ep, p2: movePoint) / (ASpeed * self.BSize)
                            if Angle >= 0{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                            let AttackAction = SKAction.move(to: movePoint, duration: Double(movetime))
                            let EAction = SKAction.sequence([WAction,AttackAction,Attack3])    //変動アクションのループ化
                            Eobject.run(EAction)
                        }
                        let pp = self.body.position
                        let ep = Eobject.position
                        let Angle = self.angle(p1: ep, p2: pp)
                        let movePoint = CGPoint(x: pp.x + Adis2 * self.BSize * sin(Angle), y: pp.y + Adis2 * self.BSize * -cos(Angle))
                        let movetime = self.distance(p1: ep, p2: movePoint) / (ASpeed * self.BSize)
                        if Angle >= 0{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                        RandomAction = SKAction.move(to: movePoint, duration: Double(movetime))
                        let EAction = SKAction.sequence([RandomAction,Attack2])
                        Eobject.run(EAction)//変動アクションのループ化
                    }else{                  //超音波攻撃
                        let ed = self.body.position.x - Eobject.position.x
                        var attackP:CGPoint!
                        var Effect:[SKTexture] = []
                        var EffectP:[CGFloat] = []
                        let EffectS:CGFloat = 100
                        let Etime = 1.178
                        var Ebody:[SKPhysicsBody] = []
                        if ed >= 0 {
                            Eobject.run(SKAction.repeatForever(Ranime))
                            attackP = CGPoint(x: self.body.position.x - self.BSize * 4, y: self.body.position.y)
                            EffectP = [50,0]
                            Effect = self.enemyREffect[1]
                            Ebody = REffectBody
                        }
                        else {
                            Eobject.run(SKAction.repeatForever(Lanime))
                            attackP = CGPoint(x: self.body.position.x + self.BSize * 4, y: self.body.position.y)
                            EffectP = [-50,0]
                            Effect = self.enemyLEffect[1]
                            Ebody = LEffectBody
                        }
                        let mmtime = self.distance(p1: Eobject.position, p2: attackP) / (ASpeed * self.BSize)
                        let mbAction = SKAction.move(to: attackP, duration: Double(mmtime))
                        let AttackAction = SKAction.run {
                            self.run(SKAction.wait(forDuration: 0.6)){
                                self.run(SEplay2)
                                self.enemyAttackEffect(enemy: Eobject, Effect: Effect, EPosition: EffectP, ESize: EffectS, Etime: Etime, Abody: Ebody, AStartCN: [1,3,8], AtimeCN: [2,5,6])
                            }
                        }
                        let LwaitAction = SKAction.wait(forDuration: 2.5)
                        Eobject.run(SKAction.sequence([mbAction,AttackAction,LwaitAction,nextMoveAction]))
                    }
                }
                Eobject.run(playAction)
            }
        }
        //1_1_4小ドラゴン
        else if 31 <= type && type <= 32 || type == 47{
            //共通パラメータ
            let dx1: CGFloat = 2                //１アクションでのx方向への移動量
            let dy1: CGFloat = 2                //１アクションでのy方向への移動量
            let time1: Double = 2.0             //１アクションの移動時間
            let fireSize: CGFloat = 1.5           //火球のサイズ
            let fireP:[CGFloat] = [80,20]      //火球の生成地点
            let fireSpeed: CGFloat = 3          //火球のスピード
            let fireinterva: Double = 2.0       //火球の出現間隔
            let fireEndtime: Double = 1.5       //1つの火球の出現時間
            let fireanimetime: Double = 0.8     //火球のアニメの時間
            let animetime: Double = 0.768       //羽ばたくアニメの１サイクルの時間
            
            //各パラメータ
            var ddx: Int = 3                       //x方向の移動範囲( ±(ddx × dx1 × BSize) が移動範囲 )
            if type == 31{
                ddx = 3
            }
            if type == 32{
                ddx = 5
            }
            if type == 47{
                ddx = 9
            }
            
            //共通アクションの設定
            //羽ばたくSE コウモリと共通
            let SE = SKAudioNode(fileNamed: "SE/e3_1.mp3")  //羽ばたくBGM コウモリと共通
            Eobject.addChild(SE)
            
            let Fep = Eobject.position          //初期地点
            let Esize = Eobject.size.width      //敵サイズ
            let FBEffect = enemyREffect[2]      //ファイアボールのエフェクト
            
            //ファイアボール生成音
            let FBSE = SKAudioNode(fileNamed: "SE/e4_1.mp3")
            FBSE.autoplayLooped = false
            Eobject.addChild(FBSE)
            let SEplay = SKAction.run{ FBSE.run(SKAction.play()) }
            let FBs = fireSize * self.BSize
            let FBbody = CreateCircleBody(Size: 70, Position: [0,0], StandardSize: FBs)
            let damage = Eobject.GetInt(name: "damage")
            
            //火球生成
            let FireBall = SKAction.run {
                let ep = Eobject.position
                var FBdis: CGFloat!
                var FBp: CGPoint!
                if enemyDD{ //右向き
                    FBp = CGPoint(x: ep.x + fireP[0] * Esize / 100.0, y: ep.y + fireP[1] * Esize / 100.0)
                    FBdis = fireSpeed * self.BSize
                }else{      //左向き
                    FBp = CGPoint(x: ep.x - fireP[0] * Esize / 100.0, y: ep.y + fireP[1] * Esize / 100.0)
                    FBdis = -fireSpeed * self.BSize
                }
                let FB = self.EffectObject(P: FBp, Size: FBs, Effect: FBEffect, Ebody: FBbody, time: fireanimetime, Endtime: fireEndtime, damage: damage)
                self.run(SEplay)
                FB.run(SKAction.repeatForever(SKAction.moveBy(x: FBdis, y: 0, duration: 1.0)))
            }
            let FBwait = SKAction.wait(forDuration: fireinterva)
            let FireBallAction = SKAction.repeatForever(SKAction.sequence([FBwait,FireBall]))
            Eobject.run(FireBallAction)
            
            //各アクション設定
            if type == 31{
                //羽ばたくアニメ
                let Ranime = SKAction.animate(with: enemyRAnime[12], timePerFrame: animetime / Double(enemyAN[12]))
                let Lanime = SKAction.animate(with: enemyLAnime[12], timePerFrame: animetime / Double(enemyAN[12]))
                if enemyDD{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
                
                // 移動アクション
                var PP:[CGPoint] = []
                let Rn = ddx * 2
                var upF:Bool = true ;if ddx % 2 == 0{ upF = false }
                
                for n in -ddx...ddx{
                    let xi = CGFloat(n)
                    var yi: CGFloat!
                    if upF{ yi = 1 ;upF = false } else { yi = 0 ;upF = true }
                    PP.append(CGPoint(x: Fep.x + xi * dx1 * BSize , y: Fep.y + yi * dy1 * BSize))
                }
                
                var pn = ddx
                let pmax = ddx * 4
                var uperF: Bool = false ;if enemyDD{ uperF = true }
                
                var moveAction: SKAction!
                for n in 0..<pmax{
                    if pn == Rn {
                        uperF = false
                        let DAction = SKAction.run {
                            enemyDD = false
                            Eobject.run(SKAction.repeatForever(Lanime))
                        }
                        moveAction = SKAction.sequence([moveAction,DAction])
                    }
                    if pn == 0{
                        uperF = true
                        let DAction = SKAction.run {
                            enemyDD = true
                            Eobject.run(SKAction.repeatForever(Ranime))
                        }
                        moveAction = SKAction.sequence([moveAction,DAction])
                    }
                    if uperF { pn += 1 } else { pn -= 1 }
                    if n == 0{
                        moveAction = SKAction.move(to: PP[pn], duration: time1)
                    }else{
                        moveAction = SKAction.sequence([moveAction,SKAction.move(to: PP[pn], duration: time1)])
                    }
                }
                Eobject.run(SKAction.repeatForever(moveAction))
            }
            
            if type == 32 || type == 47{
                //羽ばたくアニメ
                let Ranime = SKAction.animate(with: enemyRAnime[13], timePerFrame: animetime / Double(enemyAN[13]))
                let Lanime = SKAction.animate(with: enemyLAnime[13], timePerFrame: animetime / Double(enemyAN[13]))
                if enemyDD{ Eobject.run(SKAction.repeatForever(Ranime)) } else { Eobject.run(SKAction.repeatForever(Lanime)) }
    
                var pn = ddx
                let Rn = ddx * 2
                var PPx: [CGFloat] = []
                
                for n in -ddx...ddx{
                    let xi = CGFloat(n)
                    PPx.append( Fep.x + xi * dx1 * BSize )
                }
                // 移動アクション
                var moveAction: SKAction!
                moveAction = SKAction.run {
                    if pn == Rn {
                        enemyDD = false
                        Eobject.run(SKAction.repeatForever(Lanime))
                    }
                    if pn == 0{
                        enemyDD = true
                        Eobject.run(SKAction.repeatForever(Ranime))
                    }
                    
                    let pey = self.body.position.y - Eobject.position.y
                    var upF = true  ;if pey <= 0 { upF = false }
                    if enemyDD { pn += 1 } else { pn -= 1 }
                    let moveX = PPx[pn]
                    
                    var ddy = dy1 * self.BSize ;if upF == false { ddy = -ddy }
                    let moveY = Eobject.position.y + ddy
                    let MAction = SKAction.move(to: CGPoint(x: moveX, y: moveY), duration: time1)
                    Eobject.run(SKAction.sequence([MAction,moveAction]))
                }
                
                Eobject.run(moveAction)
            }
        }
        //1_1_5雪女
        else if 33 <= type && type <= 34 || type == 48{
            var dx:CGFloat = 5                  //x方向の移動距離
            var dy:CGFloat = 5                  //y方向の移動距離
            let Ptime = 2.0                     //出現時間
            let Dtime = 2.0                     //消失時間
            let Mtime = 3.0                     //移動時間
            let Awtime = 1.0                    //攻撃待機時間
            let Atime = 3.0                     //攻撃時間
            let Ntime = 3.0                     //攻撃してから次の行動(消失)までの時間
            let ASize: CGFloat = 300            //氷の息のサイズ(敵サイズ基準 百分率）
            var APosition: [CGFloat] = [130,20] //氷の息の位置(敵サイズ基準 百分率)
            let EffectTN:[Int] = [3,4,4]
            let EffectWN:[Int] = [1,4,8]
            
            //亜種,カーズ種だけに使用
            let APdis: CGFloat = 2              //攻撃位置(プレイヤーからの距離)
            
            //カーズ種
            let Alenge: CGFloat  = 5            //攻撃位置に移動する距離
            let moveDis: CGFloat = 6            //移動する距離
         
            //移動距離の計算
            if type == 34 {
                dx = 8
                dy = 8
            }
            dx = dx * BSize ; dy = dy * BSize
            let FP = Eobject.position   //初期出現位置
            
            //敵の移動範囲の計算
            let Xrange:[CGFloat] = [FP.x - dx, FP.x + dx]
            let Yrange:[CGFloat] = [FP.y - dy, FP.y + dy]
            
            //攻撃エフェクトの計算
            let ESize = ASize * Eobject.size.width / 100.0
            var REffectBody: [SKPhysicsBody] = []
            REffectBody.append(CreateSquareBody(Size: [35,7.5], Position: [-17.5,3.75], StandardSize: ESize))
            REffectBody.append(CreateSquareBody(Size: [40,20], Position: [-10,5], StandardSize: ESize))
            REffectBody.append(CreateSquareBody(Size: [55,35], Position: [-7.5,2.5], StandardSize: ESize))
            var LEffectBody: [SKPhysicsBody] = []
            LEffectBody.append(CreateSquareBody(Size: [35,7.5], Position: [17.5,3.75], StandardSize: ESize))
            LEffectBody.append(CreateSquareBody(Size: [40,20], Position: [10,5], StandardSize: ESize))
            LEffectBody.append(CreateSquareBody(Size: [55,35], Position: [7.5,2.5], StandardSize: ESize))
 
            //アニメーションアクションの作成
            //移動時のアニメ(消失中)
            let MMAction = SKAction.repeatForever(SKAction.animate(with: enemyRAnime[15], timePerFrame: Ptime / 2.0 / Double(enemyAN[15]) ) )
            //攻撃時のアニメ
            let RAMAction = SKAction.repeatForever( SKAction.animate(with: enemyRAnime[14], timePerFrame: Ptime / 2.0 / Double(enemyAN[14]) ) )
            let LAMAction = SKAction.repeatForever( SKAction.animate(with: enemyLAnime[14], timePerFrame: Ptime / 2.0 / Double(enemyAN[14]) ) )
            //出現アニメ
            let RPMAction = SKAction.animate(with: enemyRAnime[16], timePerFrame: Ptime / Double(enemyAN[16]) )
            let LPMAction = SKAction.animate(with: enemyLAnime[16], timePerFrame: Ptime / Double(enemyAN[16]) )
            //消失アニメ
            let RDMAction = SKAction.animate(with: enemyRAnime[17], timePerFrame: Ptime / Double(enemyAN[17]) )
            let LDMAction = SKAction.animate(with: enemyLAnime[17], timePerFrame: Ptime / Double(enemyAN[17]) )
            
            //SEの読み込み (氷の息)
            let ASE = SKAudioNode(fileNamed: "SE/e5_1.mp3")
            ASE.autoplayLooped = false
            Eobject.addChild(ASE)
            let SEplay = SKAction.run{ ASE.run(SKAction.play()) }
            
            //敵の衝突処理判定を変更するアクション
            let DBodyAction = SKAction.run {
                Eobject.physicsBody?.categoryBitMask = 0
                Eobject.physicsBody?.contactTestBitMask = 0
                Eobject.physicsBody?.collisionBitMask = 0
            }
            let PBodyAction = SKAction.run {
                Eobject.physicsBody?.categoryBitMask = self.enemy2Category
                Eobject.physicsBody?.contactTestBitMask = self.enemy2CT
                Eobject.physicsBody?.collisionBitMask = self.enemy2Co
            }
            
            var attackAction:SKAction! //攻撃アクション(出現 攻撃 消失)
            var moveAction:SKAction!   //移動アクション(移動(消失状態))
            //消失アクションの作成
            let RDAction = SKAction.sequence([RDMAction,DBodyAction])
            let LDAction = SKAction.sequence([LDMAction,DBodyAction])
            //出現アクションの作成
            let RPAction = SKAction.sequence([RPMAction,PBodyAction])
            let LPAction = SKAction.sequence([LPMAction,PBodyAction])
            
            
            if type == 33{
                var PN = 2
                //移動アクションの生成
                moveAction = SKAction.run {
                    Eobject.run(MMAction)     //移動アニメの実行
                    
                    let PPosition = self.body.position
                    var a = 2
                    if      PPosition.x < Xrange[0]                            { a = 1 }
                    else if Xrange[0] <= PPosition.x && PPosition.x < FP.x     { a = 2 }
                    else if FP.x <= PPosition.x && PPosition.x < Xrange[1]     { a = 3 }
                    else                                                       { a = 4 }
            
                    if       PN == 1{
                        if a == 1 { PN = 1; enemyDD = false }
                        if a == 2 { PN = 2; enemyDD = false }
                        if a == 3 { PN = 2; enemyDD = true  }
                        if a == 4 { PN = 3; enemyDD = true  }
                    }else if PN == 2{
                        if a == 1 { PN = 1; enemyDD = false }
                        if a == 2 { PN = 1; enemyDD = true  }
                        if a == 3 { PN = 3; enemyDD = false }
                        if a == 4 { PN = 3; enemyDD = true  }
                    }else{
                        if a == 1 { PN = 1; enemyDD = false }
                        if a == 2 { PN = 2; enemyDD = false }
                        if a == 3 { PN = 2; enemyDD = true  }
                        if a == 4 { PN = 3; enemyDD = true  }
                    }
                    
                    var EPNext: [CGFloat] = [0,0]
                    if PN == 1 { EPNext[0] = Xrange[0] }
                    if PN == 2 { EPNext[0] = FP.x      }
                    if PN == 3 { EPNext[0] = Xrange[1] }
                    if      PPosition.y < Yrange[0]                                 { EPNext[1] = Yrange[0]   }
                    else if Yrange[0] <= PPosition.y && PPosition.y <= Yrange[1]    { EPNext[1] = PPosition.y }
                    else                                                            { EPNext[1] = Yrange[1]   }
 
                    let MAction = SKAction.move(to: CGPoint(x: EPNext[0], y: EPNext[1]), duration: Mtime)
                    Eobject.run(SKAction.sequence([MAction,attackAction]))
                }
            }
            
            if type == 34{
                let attackPD = APdis * BSize
                moveAction = SKAction.run {
                    Eobject.run(MMAction)     //移動アニメの実行
                    var EPNext: [CGFloat] = [0,0]
                    let PPosition = self.body.position
                    if PPosition.x <= Xrange[0]{
                        enemyDD = false
                        EPNext[0] = Xrange[0]
                    }else if Xrange[1] <= PPosition.x{
                        enemyDD = true
                        EPNext[0] = Xrange[1]
                    }else{
                        enemyDD = Bool.random()
                        if enemyDD{
                            EPNext[0] = PPosition.x - attackPD
                        }else{
                            EPNext[0] = PPosition.x + attackPD
                        }
                    }
                    if      PPosition.y < Yrange[0]                                 { EPNext[1] = Yrange[0]   }
                    else if Yrange[0] <= PPosition.y && PPosition.y <= Yrange[1]    { EPNext[1] = PPosition.y }
                    else                                                            { EPNext[1] = Yrange[1]   }
                    
                    let MAction = SKAction.move(to: CGPoint(x: EPNext[0], y: EPNext[1]), duration: Mtime)
                    Eobject.run(SKAction.sequence([MAction,attackAction]))
                }
            }
            
            if type == 48{
                let attackPD = APdis * BSize
                let attackMD = Alenge * BSize
                let moveMD = moveDis * BSize
                moveAction = SKAction.run {
                    Eobject.run(MMAction)     //移動アニメの実行
                    var EPNext: [CGFloat] = [0,0]
                    
                    let PPosition = self.body.position
                    let EPosition = Eobject.position
                    
                    let EPdis = self.distance(p1: PPosition, p2: EPosition)
                    
                    if EPdis <= attackMD{       //攻撃する時
                        enemyDD = Bool.random()
                        if enemyDD{
                            EPNext[0] = PPosition.x - attackPD
                        }else{
                            EPNext[0] = PPosition.x + attackPD
                        }
                        EPNext[1] = PPosition.y
                        
                        let MAction = SKAction.move(to: CGPoint(x: EPNext[0], y: EPNext[1]), duration: Mtime)
                        Eobject.run(SKAction.sequence([MAction,attackAction]))
                    }else{                      //移動だけする時
                        let MAngle = self.angle(p1: EPosition, p2: PPosition)
                        EPNext = [EPosition.x + moveMD * sin(MAngle) ,EPosition.y + moveMD * -cos(MAngle)]
                        let MAction = SKAction.move(to: CGPoint(x: EPNext[0], y: EPNext[1]), duration: Mtime)
                        Eobject.run(SKAction.sequence([MAction,moveAction]))
                    }
                }
            }
            
            //攻撃アクションの生成
            attackAction = SKAction.run {
                var EffectP: [CGFloat] = []
                var Effect: [SKTexture] = []
                var Ebody: [SKPhysicsBody] = []
                var playAction: SKAction!
                let WAction = SKAction.wait(forDuration: Ptime + Ntime)
                if enemyDD{
                    EffectP = APosition
                    Effect = self.enemyREffect[3]
                    Ebody = REffectBody
                    Eobject.run(SKAction.sequence([RPAction,RAMAction]))
                    playAction = SKAction.sequence([WAction,RDAction,moveAction])
                }else{
                    EffectP = [-APosition[0],APosition[1]]
                    Effect = self.enemyLEffect[3]
                    Ebody = LEffectBody
                    Eobject.run(SKAction.sequence([LPAction,LAMAction]))
                    playAction = SKAction.sequence([WAction,LDAction,moveAction])
                }
                Eobject.run(playAction)
                self.run(SKAction.wait(forDuration: Ptime + Awtime)){
                    self.run(SEplay)
                    self.enemyAttackEffect(enemy: Eobject, Effect: Effect, EPosition: EffectP, ESize: ASize, Etime: Atime, Abody: Ebody, AStartCN: EffectWN, AtimeCN: EffectTN)
                }
            }
            
            if enemyDD{ Eobject.run(SKAction.sequence([RDAction,moveAction])) }
            else      { Eobject.run(SKAction.sequence([LDAction,moveAction])) }
        }
        //1_1_6天使、堕天使
        else if 35 <= type && type <= 36 || type == 49{
            //各アクションの設定
            //通常移動
            let Move: CGFloat = 6               //移動距離
            let Mtime: Double = 4.0             //移動時間
            let MoveAdis: CGFloat = 10          //攻撃を実行する距離
            
            //羽ばたきアニメ
            let FFrameTime:Double = 1.5         //一回の羽ばたきの時間
            let FlappingRT = enemyRAnime[18]    //羽ばたきテクスチャ(右向き)
            let FlappingLT = enemyLAnime[18]    //羽ばたきテクスチャ(左向き)
            let FlappingFN = enemyAN[18]        //テクスチャーのコマ数
            
            //魔法陣の設定
            let MCtime = 2.0                    //魔法陣を出す時間
            var MCSzie: CGFloat                 //魔法陣のサイズ (敵サイズ基準)
            var MCPosition: [CGFloat]           //魔法陣の位置 (敵サイズ基準)
            var MCTexture: [SKTexture] = []     //魔法陣のテクスチャー
            if type == 35{                      //天使
                MCSzie = 400
                MCPosition = [0,100]
                MCTexture = enemyREffect[4]
            }else{                              //堕天使
                MCSzie = 300
                MCPosition = [0,0]
                MCTexture = enemyREffect[7]
            }
            
            //魔法攻撃の設定
            let AttackDis = 8                   //攻撃実行範囲
            var Atime1: Double!                 //攻撃時間(パターン1)
            var Atime2: Double!                 //攻撃時間(パターン2)
            var ANtime1: Double!                //次のアクションまでの時間(パターン1)
            var ANtime2: Double!                //次のアクションまでの時間(パターン2)
            var ASize1: CGFloat!                //攻撃エフェクトサイズ(パターン1)
            var APosition1: [CGFloat] = []      //攻撃エフェクト位置(パターン1)
            var APosition1L: [CGFloat] = []     //攻撃エフェクト位置(パターン1) 左側
            var ASize2: CGFloat!                //攻撃エフェクトサイズ(パターン2)
            var APosition2: [CGFloat] = []      //攻撃エフェクト位置(パターン2)
            var APosition2L: [CGFloat] = []     //攻撃エフェクト位置(パターン2) 左側
            var ATexture1R:[SKTexture] = []     //攻撃テクスチャ(パターン1右向き)
            var ATexture1L:[SKTexture] = []     //攻撃テクスチャ(パターン1左向き)
            var ATexture2R:[SKTexture] = []     //攻撃テクスチャ(パターン2右向き)
            var ATexture2L:[SKTexture] = []     //攻撃テクスチャ(パターン2左向き)
            var AFtime1:[Int] = []              //攻撃判定の継続コマ数(パターン1)
            var AFstart1:[Int] = []             //攻撃判定の開始コマ数(パターン1)
            var AFBody1:[SKPhysicsBody] = []    //攻撃判定のボディの作成(パターン1)
            var AFBody1L:[SKPhysicsBody] = []   //攻撃判定のボディの作成(パターン1)左側
            var AFtime2:[Int] = []              //攻撃判定の継続コマ数(パターン2)
            var AFstart2:[Int] = []             //攻撃判定の開始コマ数(パターン2)
            var AFBody2:[SKPhysicsBody] = []    //攻撃判定のボディの作成(パターン2)
            var AFBody2L:[SKPhysicsBody] = []   //攻撃判定のボディの作成(パターン2) 左側
            
            if type == 35{                      //天使
                //パターン１
                Atime1 = 2.0
                ANtime1 = 6.0
                ATexture1R = enemyREffect[5]
                ATexture1L = enemyLEffect[5]
                APosition1 = [110,0]
                APosition1L = [-APosition1[0],APosition1[1]]
                ASize1 = 400
                let EESize = Eobject.frame.width * ASize1 / 100
                AFtime1 = [2,2,3]
                AFstart1 = [1,3,5]
                AFBody1.append(CreateSquareBody(Size: [20,10], Position: [-22.5,2.5], StandardSize: EESize))
                AFBody1.append(CreateSquareBody(Size: [45,20], Position: [-7.5,0], StandardSize: EESize))
                AFBody1.append(CreateSquareBody(Size: [35,25], Position: [12.5,0], StandardSize: EESize))
                AFBody1L.append(CreateSquareBody(Size: [20,10], Position: [-22.5,2.5], StandardSize: EESize))
                AFBody1L.append(CreateSquareBody(Size: [45,20], Position: [-7.5,0], StandardSize: EESize))
                AFBody1L.append(CreateSquareBody(Size: [35,25], Position: [12.5,0], StandardSize: EESize))
                //パターン２
                Atime2 = 2.5
                ANtime2 = 6.0
                ATexture2R = enemyREffect[6]
                ATexture2L = enemyLEffect[6]
                APosition2 = [0,80]
                ASize2 = 400
                AFtime2 = [2,2,2]
                AFstart2 = [13,15,17]
                AFBody2.append(CreateSquareBody(Size: [15,20], Position: [-2.5,-15], StandardSize: EESize))
                AFBody2.append(CreateSquareBody(Size: [30,15], Position: [-2.5,-20], StandardSize: EESize))
                AFBody2.append(CreateSquareBody(Size: [42.5,17.5], Position: [-1.25,21.25], StandardSize: EESize))
            }else{                              //堕天使,カース種
                //パターン１
                Atime1 = 2.0
                ANtime1 = 6.0
                ATexture1R = enemyREffect[8]
                ATexture1L = enemyLEffect[8]
                APosition1 = [0,50]
                ASize1 = 300
                let EESize = Eobject.frame.width * ASize1 / 100
                AFtime1 = [3,3]
                AFstart1 = [11,14]
                AFBody1.append(CreatePolygonBody(Position: [[-25,-22.5],[2.5,2.5],[20,-22.5]], StandardSize: EESize))
                AFBody1.append(CreateSquareBody(Size: [50,40], Position: [0,0], StandardSize: EESize) )
                //パターン２(３倍)
                Atime2 = 1.5
                ANtime2 = 10.0
                ATexture2R = enemyREffect[9]
                ATexture2L = enemyLEffect[9]
                APosition2 = [-40,50]
                APosition2L = [-APosition2[0],APosition2[1]]
                ASize2 = 300
                AFtime2 = [3,3,4]
                AFstart2 = [5,8,11]
                AFBody2.append(CreateSquareBody(Size: [20,30], Position: [-20,12.5], StandardSize: EESize))
                AFBody2.append(CreateSquareBody(Size: [30,40], Position: [-20,7.5], StandardSize: EESize))
                AFBody2.append(CreateSquareBody(Size: [42.5,27.5], Position: [1.25,-13.75], StandardSize: EESize))
                AFBody2L.append(CreateSquareBody(Size: [20,30], Position: [20,12.5], StandardSize: EESize))
                AFBody2L.append(CreateSquareBody(Size: [30,40], Position: [20,7.5], StandardSize: EESize))
                AFBody2L.append(CreateSquareBody(Size: [42.5,27.5], Position: [-1.25,-13.75], StandardSize: EESize))
            }
            
            //効果音の設定
            Eobject.addChild(ReadAudioNode(named: "e7_3", type: "mp3", Loop: false))            //魔法陣の効果音を追加
            if type == 35{
                Eobject.addChild(ReadAudioNode(named: "LightMagic", type: "mp3", Loop: false))
                Eobject.addChild(ReadAudioNode(named: "LightMagic2", type: "mp3", Loop: false))
                Eobject.addChild(ReadAudioNode(named: "telepo", type: "mp3", Loop: false))
            }else{
                Eobject.addChild(ReadAudioNode(named: "DarkMagic1", type: "mp3", Loop: false))
                Eobject.addChild(ReadAudioNode(named: "DarkMagic2", type: "mp3", Loop: false))
                Eobject.addChild(ReadAudioNode(named: "DarkMagic3", type: "mp3", Loop: false))
                Eobject.addChild(ReadAudioNode(named: "girl", type: "mp3", Loop: false))
                
            }
            Eobject.zPosition = 5
            //各アクションの作成
            //羽ばたきアニメの作成と実行
            let FlappingR = SKAction.repeatForever(SKAction.animate(with: FlappingRT, timePerFrame: FFrameTime / Double(FlappingFN)))
            let FlappingL = SKAction.repeatForever(SKAction.animate(with: FlappingLT, timePerFrame: FFrameTime / Double(FlappingFN)))
            if enemyDD{ Eobject.run(FlappingR) } else { Eobject.run(FlappingL) }
            
            var moveActino:SKAction!        //移動アクション(攻撃判定含む)
            var AttackAction1: SKAction!    //第一攻撃アクション
            var AttackAction2: SKAction!    //第二攻撃アクション
            //移動アクションの　作成
            //共通アクション
            //攻撃を行うかの判定
            let AttackDoAction = SKAction.run{
                let DisP = self.distance(p1: Eobject.position, p2: self.body.position ) //敵とプレイヤーの距離
                if DisP <= MoveAdis * self.BSize{   //攻撃を実行
                    let RBool = Bool.random()
                    if RBool{ Eobject.run(AttackAction1) }else{ Eobject.run(AttackAction2) }
                }else{                              //移動を実行
                    Eobject.run(moveActino)
                }
            }
            if type == 35{                              //天使
                //移動アクション初期設定
                let FP = Eobject.position               //敵の初期地点
                var MoveP:[CGPoint] = []                //移動地点の地点の作成
                for n in -1 ... 1 { MoveP.append(CGPoint(x:FP.x + CGFloat(n) * Move * self.BSize , y: FP.y)) }
                var Pn = 2; if enemyDD { Pn = 0 }       //移動地点のナンバー
                
                //移動アクション
                moveActino = SKAction.run {
                    let EP = Eobject.position           //現在の敵の位置
                    let PP = self.body.position         //現在のプレイヤーの位置
                    //敵の向きの変更する判定と実行
                    if enemyDD == false && EP.x < PP.x{
                        enemyDD = true;Eobject.run(FlappingR)
                    }else if enemyDD && EP.x > PP.x{
                        enemyDD = false;Eobject.run(FlappingL)
                    }
                    //移動アクションの作成と実行
                    var MAction: SKAction!
                    if       Pn == 0{
                        Pn = 1
                        MAction = SKAction.move(to:MoveP[2] , duration: Mtime)
                    }else if Pn == 1{
                        Pn = 2
                        MAction = SKAction.move(to:MoveP[1] , duration: Mtime)
                    }else if Pn == 2{
                        Pn = 3
                        MAction = SKAction.move(to:MoveP[0] , duration: Mtime)
                    }else           {
                        Pn = 0
                        MAction = SKAction.move(to:MoveP[1] , duration: Mtime)
                    }
                    Eobject.run(SKAction.sequence([MAction,AttackDoAction]))
                }
            }else if type == 36{            //堕天使
                moveActino = SKAction.run {
                    let EP = Eobject.position           //現在の敵の位置
                    let PP = self.body.position         //現在のプレイヤーの位置
                    //敵の向きの変更する判定と実行
                    if enemyDD == false && EP.x < PP.x{
                        enemyDD = true;Eobject.run(FlappingR)
                    }else if enemyDD && EP.x > PP.x{
                        enemyDD = false;Eobject.run(FlappingL)
                    }
                    //移動アクションの作成と実行
                    var MAction: SKAction!
                    if EP.x <= PP.x{
                        MAction = SKAction.move(to: CGPoint(x: EP.x + Move * self.BSize, y: EP.y), duration: Mtime)
                    }else{
                        MAction = SKAction.move(to: CGPoint(x: EP.x - Move * self.BSize, y: EP.y), duration: Mtime)
                    }
                    Eobject.run(SKAction.sequence([MAction,AttackDoAction]))
                }
            }else{                          //カース種
                moveActino = SKAction.run {
                    let EP = Eobject.position           //現在の敵の位置
                    let PP = self.body.position         //現在のプレイヤーの位置
                    //敵の向きの変更する判定と実行
                    if enemyDD == false && EP.x < PP.x{
                        enemyDD = true;Eobject.run(FlappingR)
                    }else if enemyDD && EP.x > PP.x{
                        enemyDD = false;Eobject.run(FlappingL)
                    }
                    //移動アクションの作成と実行
                    var MAction: SKAction!
                    if EP.x <= PP.x && EP.y <= PP.y{
                        MAction = SKAction.move(to: CGPoint(x: EP.x + Move * self.BSize, y: EP.y + Move * self.BSize), duration: Mtime)
                    }else if EP.x > PP.x && EP.y <= PP.y{
                        MAction = SKAction.move(to: CGPoint(x: EP.x - Move * self.BSize, y: EP.y + Move * self.BSize), duration: Mtime)
                    }else if EP.x <= PP.x && EP.y > PP.y{
                        MAction = SKAction.move(to: CGPoint(x: EP.x + Move * self.BSize, y: EP.y - Move * self.BSize), duration: Mtime)
                    }else{
                        MAction = SKAction.move(to: CGPoint(x: EP.x - Move * self.BSize, y: EP.y - Move * self.BSize), duration: Mtime)
                    }
                    Eobject.run(SKAction.sequence([MAction,AttackDoAction]))
                }
            }
            
            //攻撃パターン１の作成
            if type == 35{ //天使
                let Adis: CGFloat = 2   // 攻撃位置
                AttackAction1 = SKAction.run{
                    let REP = Eobject.position
                    //敵の透明化および衝突判定の無効化
                    Eobject.alpha = 0
                    Eobject.physicsBody?.categoryBitMask = 0
                    Eobject.physicsBody?.contactTestBitMask = 0
                    
                    //攻撃位置に移動
                    let PP = self.body.position
                    Eobject.PlaySE(number: 3)
                    if enemyDD{ Eobject.position = CGPoint(x: PP.x - self.BSize * Adis, y: PP.y) }
                    else      { Eobject.position = CGPoint(x: PP.x + self.BSize * Adis, y: PP.y) }
                    
                    //魔法陣エフェクトの表示
                    self.enemyEffect(enemy: Eobject, Effect: MCTexture, EPosition: MCPosition, ESize: MCSzie, Etime: MCtime)
                    Eobject.PlaySE()
                    //出現アクション
                    let inAction = SKAction.fadeIn(withDuration: MCtime)
                    //出現後のアクション
                    let inNextAction = SKAction.run{
                        Eobject.physicsBody?.categoryBitMask = self.enemy2Category
                        Eobject.physicsBody?.contactTestBitMask = self.enemy2CT
                        Eobject.PlaySE(number: 2)
                        if enemyDD{
                            Eobject.run(FlappingR)
                            self.enemyAttackEffect(enemy: Eobject, Effect: ATexture1R, EPosition: APosition1, ESize: ASize1, Etime: Atime1, Abody: AFBody1, AStartCN: AFstart1, AtimeCN: AFtime1)
                        }else{
                            Eobject.run(FlappingL)
                            self.enemyAttackEffect(enemy: Eobject, Effect: ATexture1L, EPosition: APosition1L, ESize: ASize1, Etime: Atime1, Abody: AFBody1L, AStartCN: AFstart1, AtimeCN: AFtime1)
                        }
                    }
                    Eobject.run(SKAction.sequence([inAction,inNextAction]))
                    
                    self.DelayRun(time: ANtime1, run: {
                        Eobject.PlaySE(number: 3)
                        Eobject.position = REP
                        Eobject.run(moveActino)
                    })
                }

            }else{
                AttackAction1 = SKAction.run{
                    //魔法陣エフェクトの表示
                    self.enemyEffect(enemy: Eobject, Effect: MCTexture, EPosition: MCPosition, ESize: MCSzie, Etime: MCtime)
                    Eobject.PlaySE()
                    self.DelayRun(time: MCtime, run: {
                        //魔法攻撃
                        Eobject.PlaySE(number: 1)
                        self.enemyAttackEffect(enemy: Eobject, Effect: ATexture1R, EPosition: APosition1, ESize: ASize1, Etime: Atime1, Abody: AFBody1, AStartCN: AFstart1, AtimeCN: AFtime1,PSFlag: true)
                    })
                    self.DelayRun(time: ANtime1, run: {
                        Eobject.run(moveActino)
                    })
                }
            }
            
            //攻撃パターン２の作成
            if type == 35{ //天使
                AttackAction2 = SKAction.run{
                    //魔法陣エフェクトの表示
                    self.enemyEffect(enemy: Eobject, Effect: MCTexture, EPosition: MCPosition, ESize: MCSzie, Etime: MCtime)
                    Eobject.PlaySE()
                    self.DelayRun(time: MCtime, run: {
                        //魔法攻撃
                        self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2R, EPosition: APosition2, ESize: ASize2, Etime: Atime2, Abody: AFBody2, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                        Eobject.PlaySE(number: 1)
                    })
                    self.DelayRun(time: ANtime2, run: {
                        Eobject.run(moveActino)
                    })
                }
            }else{
                let delaytime = 0.5 //連続攻撃のラグ
                AttackAction2 = SKAction.run{
                    Eobject.PlaySE()
                    Eobject.PlaySE(number: 4)
                    self.enemyEffect(enemy: Eobject, Effect: MCTexture, EPosition: MCPosition, ESize: MCSzie, Etime: MCtime)
                   
                    
                    if enemyDD{
                        self.DelayRun(time: MCtime, run: {
                            //魔法攻撃１
                            Eobject.PlaySE(number: 2)
                            self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2R, EPosition: APosition2, ESize: ASize2, Etime: Atime2, Abody: AFBody2, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                            self.DelayRun(time: Atime2 + delaytime, run: {
                                Eobject.PlaySE(number: 3)
                                self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2L, EPosition: APosition2L, ESize: ASize2, Etime: Atime2, Abody: AFBody2L, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                                self.DelayRun(time: Atime2 + delaytime, run: {
                                    Eobject.PlaySE(number: 2)
                                    self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2R, EPosition: APosition2, ESize: ASize2, Etime: Atime2, Abody: AFBody2, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                                })
                            })
                        })
                    }else{
                        self.DelayRun(time: MCtime, run: {
                            //魔法攻撃１
                            self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2L, EPosition: APosition2L, ESize: ASize2, Etime: Atime2, Abody: AFBody2L, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                            self.DelayRun(time: Atime2 + delaytime, run: {
                                self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2R, EPosition: APosition2, ESize: ASize2, Etime: Atime2, Abody: AFBody2, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                                self.DelayRun(time: Atime2 + delaytime, run: {
                                    self.enemyAttackEffect(enemy: Eobject, Effect: ATexture2L, EPosition: APosition2L, ESize: ASize2, Etime: Atime2, Abody: AFBody2L, AStartCN: AFstart2, AtimeCN: AFtime2,PSFlag: true)
                                })
                            })
                        })
                    }
                    self.DelayRun(time: ANtime2, run: {
                        Eobject.run(moveActino)
                    })
                }
            }
            Eobject.run(moveActino)
        }
        //1_1_7空中ロボット
        else if 37 <= type && type <= 38{
            
        }
        //1_1_7地上ロボット(雑魚敵)
        else if 39 <= type && type <= 40{
            
        }
        //1_1_8地上ロボット(王種)
        else if type == 41{
            
        }
        //1_1_9カラードラゴン
        else if 42 <= type && type <= 44{
            //各種共通基本行動のパラメータ
            let wingtime = 1.123                        //一回羽ばたく時間
            var Dx: CGFloat!                            //基本ポジションの幅(X)
            var Dy: CGFloat!                            //基本ポジションの高さ(Y)
            var Xrange:[Int] = []                       //基本ポジションx方向の個数
            var Yrange:[Int] = []                       //基本ポジションy方向の個数
            var SUseNumber:[Int] = []                   //どの基本ポジションを使用するか
            let nextmoveSpeed: CGFloat = 2              //基本ポジションに向かうときのスピード
            var nextActiontime: Double!                 //基本位置に戻ってから次のアクションを行うまでの時間(残りHPにより変動)
            let Edame = Eobject.GetInt(name: "damage")  //ダメージ量の取得
            
            //突進攻撃パラメータ
            let TDid: CGFloat = 8                   //どこまで突進するか
            let TPtime = wingtime                   //突進準備時間
            var TSpeed: CGFloat!                    //突進スピード(ドラゴンの色により変動)
            
            //ひっかき攻撃パラメータ
            let Scratchtime = wingtime              //ひっかきモーションの時間
            let ScretchPtime = wingtime / 2.0       //ひっかきモーション開始からひっかきエフェクトを出すまでの時間
            let Scretchlagtime = 0.5                //移動してからひっかきを行うまでの時間
            let SMoveSpeed: CGFloat = 4             //ひっかきを行う地点までの移動スピード
            let ScretchP:[CGFloat] = [2,0]          //ひっかきを行う位置(プレイヤーから何ブロック離れているか)
            var ScretchREffect:[SKTexture] = []     //ひっかきエフェクト(右向き)
            var ScretchLEffect:[SKTexture] = []     //ひっかきエフェクト(左向き)
            var ScretchEP:[CGFloat] = []            //ひっかきエフェクト位置(敵サイズ基準)
            var ScretchSize:CGFloat!                //ひっかきエフェクトサイズ(敵サイズ基準)
            var ScretchEtime: Double!               //ひっかきエフェクトの時間
            var RScretchBody: [SKPhysicsBody] = []  //ひっかきエフェクトの攻撃範囲
            var LScretchBody: [SKPhysicsBody] = []  //ひっかきエフェクトの攻撃範囲
            var ScretchBStartN: [Int] = []          //ひっかきエフェクトの攻撃範囲の変化
            var ScretchBtimeN: [Int] = []           //ひっかきエフェクトの攻撃範囲の変化
            var SE5play: SKAction!                  //ひっかきSEの再生
      
            //放射ブレスパラメータ
            var BrePositon: [Int] = []              //ブレスを打つポイント
            let BMoveSpeed:CGFloat = 3              //攻撃位置までの移動スピード
            let Bwaittime  = wingtime * 2           //ブレスを吐くまでの待機時間
            let Btime = 2.9                         //ブレスを吐く時間
            let BNtime = wingtime * 3               //ブレスを攻撃を開始してから次の行動を起こすまでの時間
            let BreEP:[CGFloat] = [80,-70]         //ブレスエフェクト位置 (敵サイズ基準)
            let BreSize:CGFloat = 200               //ブレスエフェクトサイズ (敵サイズ基準)
            let BreBodySize = Eobject.frame.width * BreSize / 100
            let RBreBody: [SKPhysicsBody] = [CreatePolygonBody(Position: [[-30.2,-10.4],[26.6,37],[19.3,4.7]], StandardSize: BreBodySize)
                                            ,CreatePolygonBody(Position: [[-37,-37],[-28.7,34.4],[41.7,-6.3],[40.6,-38.5]], StandardSize: BreBodySize)]
            let LBreBody: [SKPhysicsBody] = [CreatePolygonBody(Position: [[30.2,-10.4],[-26.6,37],[-19.3,4.7]], StandardSize: BreBodySize)
                                            ,CreatePolygonBody(Position: [[37,-37],[28.7,34.4],[-41.7,-6.3],[-40.6,-38.5]], StandardSize: BreBodySize)]
                                                    //ブレスエフェクトの攻撃範囲
            let BreBStartN: [Int] = [3,6]           //ブレスエフェクトの攻撃範囲の変化
            let BreBtimeN: [Int] = [3,13]           //ブレスエフェクトの攻撃範囲の変化
            var BreColor: UIColor!                  //ブレスの色
            var BreColorR: CGFloat!                 //ブレスの色の濃さ
            
            //大技魔法陣
            let magictime = wingtime * 2            //魔法陣エフェクト時間
            let magicEP:[CGFloat] = [0,-30]         //魔法陣エフェクト位置 (敵サイズ基準)
            let magicSize:CGFloat = 100             //魔法陣エフェクトサイズ (敵サイズ基準)
            
            
            //タイプにより異なるパラメータの設定
            if type == 42{ //レッドドラゴン
                Dx = 10                             //基本ポジションの幅(X)
                Dy = 4                              //基本ポジションの高さ(Y)
                Xrange = [-1,1]                     //基本ポジションx方向の個数
                Yrange = [0,1]                      //基本ポジションy方向の個数
                SUseNumber = [1,3,4,6]              //どの基準位置を使用するか
                TSpeed = 7                          //突進スピード(ドラゴンの色により変動)
                ScretchEP = [50,0]                  //ひっかきエフェクト位置
                ScretchSize = 100                   //ひっかきエフェクトサイズ
                ScretchEtime = 1.8                  //ひっかきエフェクトの時間
                BrePositon = [5]                    //ブレスを打つポイント
                
                //引っ掻きエフェクト
                ScretchREffect = enemyREffect[12]
                ScretchLEffect = enemyLEffect[12]
                
                //引っ掻きの物理設定
                let ScretchBodySize = Eobject.frame.width * ScretchSize / 100
                RScretchBody.append(CreateSquareBody(Size: [15,48], Position: [-17.5,10.5], StandardSize: ScretchBodySize))
                RScretchBody.append(CreateCircleBody(Size: 73, Position: [-1.6,-2.1], StandardSize: ScretchBodySize))
                LScretchBody.append(CreateSquareBody(Size: [15,48], Position: [17.5,10.5], StandardSize: ScretchBodySize))
                LScretchBody.append(CreateCircleBody(Size: 73, Position: [1.6,-2.1], StandardSize: ScretchBodySize))
                ScretchBStartN = [2,6]
                ScretchBtimeN = [4,6]
                BreColor = .red                     //ブレスの色
                BreColorR = 0.8                     //ブレス色のブレンド係数
                
                //引っ掻いSEの読み込み
                let SE5 = SKAudioNode(fileNamed: "SE/e7_6.mp3")
                SE5.autoplayLooped = false
                Eobject.addChild(SE5)
                SE5play = SKAction.run{ SE5.run(SKAction.play()) }
                
            }
            if type == 43{ //ブルードラゴン
                Dx = 10                             //基本ポジションの間隔(X)
                Dy = 7                              //基本ポジションの間隔(Y)
                Xrange = [-1,1]                     //基本ポジションx方向の個数
                Yrange = [0,2]                      //基本ポジションy方向の個数
                SUseNumber = [1,3,4,6,7,9]          //どの基準位置を使用するか
                TSpeed = 9                          //突進スピード(ドラゴンの色により変動)
                ScretchEP = [50,0]                  //ひっかきエフェクト位置
                ScretchSize = 100                   //ひっかきエフェクトサイズ
                ScretchEtime = 2.0                  //ひっかきエフェクトの時間
                
                BrePositon = [5,8]                    //ブレスを打つポイント
                
                //引っ掻きエフェクト
                ScretchREffect = enemyREffect[15]
                ScretchLEffect = enemyLEffect[15]
                
                //引っ掻きの物理設定
                let ScretchBodySize = Eobject.frame.width * ScretchSize / 100
                RScretchBody.append(CreateSquareBody(Size: [17.5,45], Position: [-6.25,7.5], StandardSize: ScretchBodySize))
                RScretchBody.append(CreatePolygonBody(Position: [[-12.5,-17.5],[-2.5,35],[7.5,-17.5]], StandardSize: ScretchBodySize) )
                let R1Body = CreatePolygonBody(Position: [[-12.5,-17.5],[-2.5,40],[7.5,-17.5]], StandardSize: ScretchBodySize)
                let R2Body = CreatePolygonBody(Position: [[-45,-17.5],[-2.5,0],[37.5,-17.5],[-2.5,-35]], StandardSize: ScretchBodySize)
                RScretchBody.append(SKPhysicsBody(bodies: [R1Body,R2Body]))
                
                LScretchBody.append(CreateSquareBody(Size: [17.5,45], Position: [6.25,7.5], StandardSize: ScretchBodySize))
                LScretchBody.append(CreatePolygonBody(Position: [[12.5,-17.5],[2.5,35],[-7.5,-17.5]], StandardSize: ScretchBodySize) )
                let L1Body = CreatePolygonBody(Position: [[12.5,-17.5],[2.5,40],[-7.5,-17.5]], StandardSize: ScretchBodySize)
                let L2Body = CreatePolygonBody(Position: [[45,-17.5],[2.5,0],[-37.5,-17.5],[2.5,-35]], StandardSize: ScretchBodySize)
                LScretchBody.append(SKPhysicsBody(bodies: [L1Body,L2Body]))
                
                ScretchBStartN = [2,5,9]
                ScretchBtimeN = [3,4,6]
                
                //引っ掻いSEの読み込み
                let SE5 = SKAudioNode(fileNamed: "SE/e8_2.mp3")
                SE5.autoplayLooped = false
                Eobject.addChild(SE5)
                SE5play = SKAction.run{ SE5.run(SKAction.play()) }
                
                //ブレスの設定
                BreColor = .cyan                     //ブレスの色
                BreColorR = 0.8                      //ブレス色のブレンド係数
                
                
            }
            if type == 44{ //グリーンドラゴン
                Dx = 10                              //基本ポジションの幅(X)
                Dy = 8                              //基本ポジションの高さ(Y)
                Xrange = [-1,1]                     //基本ポジションx方向の個数
                Yrange = [-1,1]                     //基本ポジションy方向の個数
                SUseNumber = [1,2,3,4,5,6,7,8,9]    //どの基準位置を使用するか
                TSpeed = 11                         //突進スピード(ドラゴンの色により変動)
                
                BreColor = .green                   //ブレスの色
                BreColorR = 0.8                     //ブレス色のブレンド係数
                BrePositon = [2,5,8]                    //ブレスを打つポイント
            }
            
            //羽ばたきアクション
            //羽ばたき効果音
            let SE1 = SKAudioNode(fileNamed: "SE/e7_1.mp3")
            Eobject.addChild(SE1)
            //羽ばたきアニメ
            let RwingMotion = SKAction.repeatForever(SKAction.animate(with: enemyRAnime[19], timePerFrame: wingtime / Double(enemyAN[19])))
            let LwingMotion = SKAction.repeatForever(SKAction.animate(with: enemyLAnime[19], timePerFrame: wingtime / Double(enemyAN[19])))
            if enemyDD{ Eobject.run(RwingMotion) } else { Eobject.run(LwingMotion) }
            
            //共通モーションの作成
            //首上げ
            let RneckUpMotion = SKAction.animate(with: enemyRAnime[20], timePerFrame: wingtime / Double(enemyAN[20]))
            let LneckUpMotion = SKAction.animate(with: enemyLAnime[20], timePerFrame: wingtime / Double(enemyAN[20]))
            //首下げ
            var RNeckDownTexture: [SKTexture] = []
            var LNeckDownTexture: [SKTexture] = []
            for n in 1 ... enemyAN[20]{
                RNeckDownTexture.append(enemyRAnime[20][enemyAN[20] - n])
                LNeckDownTexture.append(enemyLAnime[20][enemyAN[20] - n])
            }
            let RneckDownMotion = SKAction.animate(with: RNeckDownTexture, timePerFrame: wingtime / Double(enemyAN[20]))
            let LneckDownMotion = SKAction.animate(with: LNeckDownTexture, timePerFrame: wingtime / Double(enemyAN[20]))
            //首上げキープ
            let RNwingMotion = SKAction.repeatForever(SKAction.animate(with: enemyRAnime[21], timePerFrame: wingtime / Double(enemyAN[21])))
            let LNwingMotion = SKAction.repeatForever(SKAction.animate(with: enemyLAnime[21], timePerFrame: wingtime / Double(enemyAN[21])))
            //ひっかき
            let RScretchMotion = SKAction.animate(with: enemyRAnime[22], timePerFrame: Scratchtime / Double(enemyAN[22]))
            let LScretchMotion = SKAction.animate(with: enemyLAnime[22], timePerFrame: Scratchtime / Double(enemyAN[22]))
            
            //各パラメータの取得および変換
            let Fep = Eobject.position                          //初期位置
            let dis1 = CGPoint(x: Dx * BSize, y: Dy * BSize)    //基本位置の間隔
            var StandardPoint: [CGPoint] = []                   //基本位置に使いそうな部分を全て取得
            var StandardP: [CGPoint] = []                       //基本位置
            for yi in Yrange[0] ... Yrange[1]{                  //基本位置の計算
                for xi in Xrange[0] ... Xrange[1]{
                     StandardPoint.append(CGPoint(x: Fep.x + CGFloat(xi) * dis1.x, y: Fep.y + CGFloat(yi) * dis1.y))
                }
            }
            for n in 1...StandardPoint.count{                   //基本位置に使用する場所を取得
                for i in SUseNumber{
                    if n == i{ StandardP.append(StandardPoint[i - 1]) }
                }
            }
            let MagicT = enemyREffect[10]
       
            //スピードの変換
            let NSpeed = nextmoveSpeed * BSize  //基本位置
            let SSpeed = SMoveSpeed * BSize     //ひっかき位置
            let BSpeed = BMoveSpeed * BSize     //ブレス位置
            TSpeed = TSpeed * BSize             //突進
            //スピード変換関数
            func SpeedCtime(Speed:CGFloat ,Distance:CGFloat) -> Double{
                 let movetime1 = Distance / Speed
                 return  Double(Int(Double(movetime1) / wingtime + 1.0)) * wingtime
            }
            
            //共通SEの読み込み
            //咆哮
            let SE2 = SKAudioNode(fileNamed: "SE/e7_2.mp3")
            SE2.autoplayLooped = false
            Eobject.addChild(SE2)
            let SE2play = SKAction.run{ SE2.run(SKAction.play()) }
            
            //魔法陣
            let SE3 = SKAudioNode(fileNamed: "SE/e7_3.mp3")
            SE3.autoplayLooped = false
            Eobject.addChild(SE3)
            let SE3play = SKAction.run{ SE3.run(SKAction.play()) }

            //ブレス
            let SE4 = SKAudioNode(fileNamed: "SE/e7_4.mp3")
            SE4.autoplayLooped = false
            Eobject.addChild(SE4)
            let SE4play = SKAction.run{ SE4.run(SKAction.play()) }
            
            var nextAction: SKAction!           //次に行うアクションの管理
            //共通アクションの作成
            //基本位置に移動
            let RePositionAction = SKAction.run {
                //無敵終了
                if type == 42 { Eobject.SetInt(name: "dtype", Int: 9)  }
                if type == 43 { Eobject.SetInt(name: "dtype", Int: 10)  }
                if type == 44 { Eobject.SetInt(name: "dtype", Int: 11)  }
                self.BossEffectChange(type: 0)
                //敵の現在の位置と次の移動位置を取得
                let EneP = Eobject.position
                let NextP = StandardP.randomElement()!
                //移動時間の計算
                let NDis = self.distance(p1: NextP, p2: EneP)
                let movetime = SpeedCtime(Speed: NSpeed, Distance: NDis)
                //向きの変更
                if NextP.x <= Fep.x{ enemyDD = true } else { enemyDD = false }
                if enemyDD{ Eobject.run(RwingMotion) } else { Eobject.run(LwingMotion) }
                //移動アクションの作成
                let NmoveAction = SKAction.move(to: NextP, duration: movetime)
                //待機アクションの作成
                let HP = Eobject.GetInt(name: "HP")
                if      HP >= 200{ nextActiontime = 6.0 * wingtime }
                else if HP >= 150{ nextActiontime = 5.0 * wingtime }
                else if HP >= 100{ nextActiontime = 4.0 * wingtime }
                else if HP >= 50 { nextActiontime = 3.0 * wingtime }
                else             { nextActiontime = 2.0 * wingtime }
                let NwaitAction = SKAction.wait(forDuration: nextActiontime)
                Eobject.run(SKAction.sequence([NmoveAction,NwaitAction,nextAction]))
            }
            
            //無敵アクションの作成
            var RmutekiAction = SKAction.sequence([RneckUpMotion,RneckDownMotion])
            var LmutekiAction = SKAction.sequence([LneckUpMotion,LneckDownMotion])
            let muteki = SKAction.run {
                Eobject.SetInt(name: "dtype", Int: 2)
                Eobject.run(SE2play)
                self.BossEffectChange(type: 1)
            }
            RmutekiAction = SKAction.sequence([muteki,RmutekiAction])
            LmutekiAction = SKAction.sequence([muteki,LmutekiAction])
            
            //突進攻撃
            let TackleAction = SKAction.run {
                let EneP = Eobject.position
                let PP = self.body.position
                let Angle = self.angle(p1: EneP, p2: PP)
                
                // 回転アクションの作成
                var Rsita:CGFloat!
                if Angle >= 0 { Rsita = -180 * self.psita + Angle }else { Rsita = 180 * self.psita + Angle }
                let RotateAction = SKAction.rotate(toAngle: Rsita, duration: wingtime, shortestUnitArc: true)
                let ReRotateAction = SKAction.rotate(toAngle: 0, duration: wingtime, shortestUnitArc: true)
                
                //突進アクションの作成
                let DisP = self.distance(p1: EneP, p2: PP) + TDid * self.BSize
                let Ttime = SpeedCtime(Speed: TSpeed, Distance: DisP)
                let moveP = CGPoint(x: EneP.x + DisP * sin(Angle), y:EneP.y + DisP * -cos(Angle) )
                let TmoveAction = SKAction.move(to: moveP, duration: Ttime)
  
                if enemyDD{
                    let lastAction = SKAction.group([RneckDownMotion,ReRotateAction])
                    let Tmotion = SKAction.sequence([RneckUpMotion,RNwingMotion])
                    let playAction = SKAction.sequence([RotateAction,TmoveAction,lastAction,RePositionAction])
                    Eobject.run(SKAction.group([playAction,Tmotion]))
                }else{
                    let lastAction = SKAction.group([LneckDownMotion,ReRotateAction])
                    let Tmotion = SKAction.sequence([LneckUpMotion,LNwingMotion])
                    let playAction = SKAction.sequence([RotateAction,TmoveAction,lastAction,RePositionAction])
                    Eobject.run(SKAction.group([playAction,Tmotion]))
                }
            }
            
            //ブレス攻撃
            let BreathAction = SKAction.run {
                //ブレス位置まで移動するアクションを作製
                let Ep = Eobject.position
                let Bp = StandardPoint[ BrePositon.randomElement()! - 1 ]
                let BDis = self.distance(p1: Ep, p2:Bp)
                let Bmovetime = SpeedCtime(Speed: BSpeed, Distance: BDis)
                let BmoveAction = SKAction.move(to: Bp, duration: Bmovetime)
                //咆哮をあげる
                //ブレス準備
                var BreBMotion: SKAction!
                var BreMotion: SKAction!
                var EffectT: [SKTexture] = []
                var EPosition: [CGFloat] = []
                var BEbody: [SKPhysicsBody] = []
                let Drandom = Int.random(in: 1...2)
                
                if Drandom == 1{
                    BreMotion = RwingMotion
                    BreBMotion = RmutekiAction
                    EffectT = self.enemyREffect[11]
                    EPosition = [BreEP[0],BreEP[1]]
                    BEbody = RBreBody
                }else{
                    BreMotion = LwingMotion
                    BreBMotion = LmutekiAction
                    EffectT = self.enemyLEffect[11]
                    EPosition = [-BreEP[0],BreEP[1]]
                    BEbody = LBreBody
                }
              
                //ブレス開始
                let BreAction = SKAction.run {
                    Eobject.run(BreMotion)
                    self.run(SE4play)
                    let ESp = self.enemyAttackEffect2(enemy: Eobject, Effect: EffectT, EPosition: EPosition, ESize: BreSize, Etime: Btime, Abody: BEbody, AStartCN: BreBStartN, AtimeCN: BreBtimeN)
                    ESp.color = BreColor
                    ESp.colorBlendFactor = BreColorR
                    self.run(SKAction.wait(forDuration: BNtime)){
                        Eobject.run(RePositionAction)
                    }
                }
                Eobject.run(SKAction.sequence([BmoveAction,BreBMotion,BreAction]))
            }
            
            //ひっかき攻撃
            var ScretchAction: SKAction!
            if type != 44{
                ScretchAction = SKAction.run {
                    //移動アクションの作成
                    let Ep = Eobject.position
                    let Pp = self.body.position
                    var dd = [ScretchP[0] * self.BSize ,ScretchP[1] * self.BSize] ;if enemyDD { dd[0] = -dd[0] }
                    let Mp = CGPoint(x: Pp.x + dd[0], y: Pp.y + dd[1])
                    let SDis = self.distance(p1: Mp, p2: Ep)
                    let Smovetime = SpeedCtime(Speed: SSpeed, Distance: SDis)
                    let SmoveAction = SKAction.move(to: Mp, duration: Smovetime)
                    
                    var SMotion: SKAction!
                    var EffectT: [SKTexture] = []
                    var EPosition: [CGFloat] = []
                    var BEbody: [SKPhysicsBody] = []
                    
                    if enemyDD{
                        SMotion = RScretchMotion
                        EffectT = ScretchREffect
                        EPosition = [ScretchEP[0],ScretchEP[1]]
                        BEbody = RScretchBody
                    
                    }else{
                        SMotion = LScretchMotion
                        EffectT = ScretchLEffect
                        EPosition = [-ScretchEP[0],ScretchEP[1]]
                        BEbody = LScretchBody
                    }
                    
                    let SAction = SKAction.run{
                        self.run(SKAction.wait(forDuration: Scretchlagtime)){
                            Eobject.run(SMotion)
                            self.run(SKAction.wait(forDuration: ScretchPtime)){
                                self.run(SE5play)
                                self.enemyAttackEffect(enemy: Eobject, Effect: EffectT, EPosition: EPosition, ESize: ScretchSize, Etime: ScretchEtime, Abody: BEbody, AStartCN: ScretchBStartN, AtimeCN: ScretchBtimeN)
                            }
                            self.run(SKAction.wait(forDuration: wingtime * 2.0)){
                                Eobject.run(RePositionAction)
                            }
                        }
                    }
                    
                    Eobject.run(SKAction.sequence([SmoveAction,SAction]))
                }
            }
       
            if type == 42{ //レッドドラゴン
                //固有技の設定
                let FireDis1: CGFloat = 3           //ファイアボール１連のプレイヤーからの距離
                let FireDis2: CGFloat = 2           //ファイアボール３連のプレイヤーからの距離
                let FireSize1: CGFloat = 8          //ファイアボール１連のサイズ
                let FireSize2: CGFloat = 5          //ファイアボール３連のサイズ
                let Fireinterval: Double = 2.0      //ファイアボールの出現に用する時間(１連、３連共通)
                let FireAtime: Double = 2.0         //ファイアボールの完成から発射するまでの時間(１連、３連共通)
                let FireDtime: Double = 5.0         //ファイアボールの発射から消失までの時間(１連、３連共通)
                let FireSpeed:[Int] = [2,6]         //ファイアボールのスピード幅
                let Firelag: Double = 1.0           //ファイアボールの出現ラグ
                let FNextActiontime: Double = 8.0   //次のアクションの開始時間
                
                let FlameSize: CGFloat = 460        //フレイムバーンのサイズ（敵サイズ基準）
                let FlameDamage:Int = 30 + Edame    //フレイムバーンのダメージ
                let FlameSpeed:CGFloat = 3          //フレイムバーン使用位置までの移動スピード
                let FlameP:[Int] = [1,2,3,4,5,6]    //フレイムバーンの使用位置
                let Flametime = 1.6                 //フレイムバーンのエフェクト時間
                let FlameStartN = [3,7]             //フレームバーンの当たり判定変更位置
                let FlameTimeN = [4,6]              //フレームバーンの当たり判定継続時間
                
                //ファイアボールアクションの準備
                //テクスチャーの読み込み
                let TAtlas = SKTextureAtlas(named: "damageO8" )
                var FireTexture: [SKTexture] = []
                for n in 1...5{ FireTexture.append( TAtlas.textureNamed("damageO8_" + String(n) ) ) }
                //サイズおよび物理ボディの計算
                let FireS1 = FireSize1 * self.BSize
                let Firebody1 = CreateCircleBody(Size:65, Position: [0,0], StandardSize: FireS1 )
                let FireS2 = FireSize2 * self.BSize
                let Firebody2_1 = CreateCircleBody(Size:65, Position: [0,0], StandardSize: FireS2 )
                let Firebody2_2 = CreateCircleBody(Size:65, Position: [0,0], StandardSize: FireS2 )
                let Firebody2_3 = CreateCircleBody(Size:65, Position: [0,0], StandardSize: FireS2 )
                let Firealltime = Fireinterval + FireAtime + FireDtime                  //全体の時間
                
                //ファイアボール出現アクションの作成
                let FireBAction1 = SKAction.fadeIn(withDuration: Fireinterval)
                let FireBAction2 = SKAction.wait(forDuration: FireAtime)
                let FireBAction = SKAction.sequence([FireBAction1,FireBAction2])
                
                //フレイムバーンの準備
                let FSpeed = FlameSpeed * BSize
                //テクスチャーの読み込み(フレイムバーン)
                let FlameT = enemyREffect[13]
        
                //SEの読み込み(フレイムバーン)
                let SE6 = SKAudioNode(fileNamed: "SE/e7_6.mp3")
                SE6.autoplayLooped = false
                Eobject.addChild(SE6)
                let SE6play = SKAction.run{ SE6.run(SKAction.play()) }

                //ブレイムバーンの物理ボディの設定
                var FlameBody:[SKPhysicsBody] = []
                let FlameBodySize = Eobject.frame.width * FlameSize / 100.0
                FlameBody.append(CreatePolygonBody(Position: [[-13.5,-20.3],[-24,-12.5],[-0.5,3.1],[22.9,-12.5],[17.7,-20.3]], StandardSize: FlameBodySize))
                FlameBody.append(CreatePolygonBody(Position: [[-16.2,-28.1],[-34.4,-9.9],[-1.0,16.7],[33.9,-8.3],[19.8,-20.3]], StandardSize: FlameBodySize))
                
                //ファイアボールアクション1
                let FireBallAction1 = SKAction.run {
                    print("AAAAA4")
                    let Ep = Eobject.position
                    var FireP:CGPoint!
                    if enemyDD{
                        FireP = CGPoint(x: Ep.x + FireDis1 * self.BSize, y: Ep.y)
                    }else{
                        FireP = CGPoint(x: Ep.x - FireDis1 * self.BSize, y: Ep.y)
                    }
                    let FireBall = self.EffectObject(P: FireP, Size: FireS1, Effect: FireTexture, Ebody: Firebody1, time: 1.0, Endtime: Firealltime , damage: Edame, alpha: 0)
                    let Firemove = SKAction.run {
                        print("AAAAA4_1")
                        let FBp = FireBall.position
                        let Pp = self.body.position
                        let FAngle = self.angle(p1: FBp, p2: Pp)
                        let FBSpped = Int.random(in: FireSpeed[0] ... FireSpeed[1])
                        let FBdx = CGFloat(FBSpped) * self.BSize * sin(FAngle)
                        let FBdy = CGFloat(FBSpped) * self.BSize * -cos(FAngle)
                        let FBmoveAction = SKAction.repeatForever(SKAction.moveBy(x: FBdx, y: FBdy, duration: 1.0))
                        FireBall.run(FBmoveAction)
                    }
                    FireBall.run(SKAction.sequence([FireBAction,Firemove]))
                    self.run(SKAction.wait(forDuration: FNextActiontime)){
                        Eobject.run(RePositionAction)
                    }
                }
                //ファイアボールアクション2
                let FireBallAction2 = SKAction.run {
                    let Ep = Eobject.position
                    let FireP1 = CGPoint(x: Ep.x, y: Ep.y + FireDis2 * self.BSize)
                    let FireP3 = CGPoint(x: Ep.x, y: Ep.y - FireDis2 * self.BSize)
                    var FireP2:CGPoint!
                    if enemyDD{
                        FireP2 = CGPoint(x: Ep.x + FireDis2 * self.BSize, y: Ep.y)
                    }else{
                        FireP2 = CGPoint(x: Ep.x - FireDis2 * self.BSize, y: Ep.y)
                    }
                    let FireBall1 = self.EffectObject(P: FireP1, Size: FireS2, Effect: FireTexture, Ebody: Firebody2_1, time: 1.0, Endtime: Firealltime , damage: Edame, alpha: 0)
                    let Firemove1 = SKAction.run {
                        let FBp1 = FireBall1.position
                        let Pp1 = self.body.position
                        let FAngle1 = self.angle(p1: FBp1, p2: Pp1)
                        let FBSpped1 = Int.random(in: FireSpeed[0] ... FireSpeed[1])
                        let FBdx1 = CGFloat(FBSpped1) * self.BSize * sin(FAngle1)
                        let FBdy1 = CGFloat(FBSpped1) * self.BSize * -cos(FAngle1)
                        let FBmoveAction1 = SKAction.repeatForever(SKAction.moveBy(x: FBdx1, y: FBdy1, duration: 1.0))
                        FireBall1.run(FBmoveAction1)
                    }
                    FireBall1.run(SKAction.sequence([FireBAction,Firemove1]))
                    self.run(SKAction.wait(forDuration: Firelag)){
                        let FireBall2 = self.EffectObject(P: FireP2, Size: FireS2, Effect: FireTexture, Ebody: Firebody2_2, time: 1.0, Endtime: Firealltime , damage: Edame, alpha: 0)
                        let Firemove2 = SKAction.run {
                            let FBp2 = FireBall2.position
                            let Pp2 = self.body.position
                            let FAngle2 = self.angle(p1: FBp2, p2: Pp2)
                            let FBSpped2 = Int.random(in: FireSpeed[0] ... FireSpeed[1])
                            let FBdx2 = CGFloat(FBSpped2) * self.BSize * sin(FAngle2)
                            let FBdy2 = CGFloat(FBSpped2) * self.BSize * -cos(FAngle2)
                            let FBmoveAction2 = SKAction.repeatForever(SKAction.moveBy(x: FBdx2,y: FBdy2, duration: 1.0))
                            FireBall2.run(FBmoveAction2)
                        }
                        FireBall2.run(SKAction.sequence([FireBAction,Firemove2]))
                        self.run(SKAction.wait(forDuration: Firelag)){
                            print("AAAAA5_7")
                            let FireBall3 = self.EffectObject(P: FireP3, Size: FireS2, Effect: FireTexture, Ebody: Firebody2_3, time: 1.0, Endtime: Firealltime , damage: Edame, alpha: 0)
                            let Firemove3 = SKAction.run {
                                print("AAAAA5_8")
                                let FBp3 = FireBall3.position
                                let Pp3 = self.body.position
                                let FAngle3 = self.angle(p1: FBp3, p2: Pp3)
                                let FBSpped3 = Int.random(in: FireSpeed[0] ... FireSpeed[1])
                                let FBdx3 = CGFloat(FBSpped3) * self.BSize * sin(FAngle3)
                                let FBdy3 = CGFloat(FBSpped3) * self.BSize * -cos(FAngle3)
                                let FBmoveAction3 = SKAction.repeatForever(SKAction.moveBy(x: FBdx3,y: FBdy3, duration: 1.0))
                                FireBall3.run(FBmoveAction3)
                            }
                            FireBall3.run(SKAction.sequence([FireBAction,Firemove3]))
                        }
                    }
                    self.run(SKAction.wait(forDuration: FNextActiontime)){
                        Eobject.run(RePositionAction)
                    }
                }
                
                //フレイムバーン
                let FlameAction = SKAction.run {
                    //無敵アクション→移動⇨魔法陣→必殺技
                    var BFlameAction:SKAction!
                    var FlameMotion: SKAction!
                    if enemyDD{
                        BFlameAction = RmutekiAction
                        FlameMotion = RwingMotion
                    }else{
                        BFlameAction = LmutekiAction
                        FlameMotion = LwingMotion
                    }
                    let mpN = FlameP.randomElement()!
                    let moveP = StandardPoint[mpN - 1]
                    let Ep = Eobject.position
                    let FDis = self.distance(p1: Ep, p2: moveP)
                    let Fmovetime = SpeedCtime(Speed: FSpeed, Distance: FDis)
                    
                    let FlameMotionAction = SKAction.run{ Eobject.run(FlameMotion) }
                    let FmoveAction = SKAction.move(to: moveP, duration: Fmovetime)
                    
                    let FlameBarnAction = SKAction.run{
                        //魔法陣作成
                        let magic = self.enemyEffect2(enemy: Eobject, Effect: MagicT, EPosition: magicEP, ESize: magicSize, Etime: magictime)
                        magic.color = .red
                        magic.colorBlendFactor = 0.7
                        self.run(SE3play)
                        //フレイムバーン作成
                        self.run(SKAction.wait(forDuration: wingtime * 2.0)){
                            self.run(SE6play)
                            self.enemyAttackEffect(enemy: Eobject, Effect: FlameT, EPosition: [0,0], ESize: FlameSize, Etime: Flametime, Abody: FlameBody, AStartCN: FlameStartN, AtimeCN: FlameTimeN,Dame: FlameDamage)
                        }
                        //次のアクション
                        self.run(SKAction.wait(forDuration: wingtime * 5.0)){
                            Eobject.run(RePositionAction)
                        }
                    }
                    Eobject.run(SKAction.sequence([BFlameAction,FlameMotionAction,FmoveAction,FlameBarnAction]))
                }
                
                nextAction = SKAction.run {
                    let random = Int.random(in: 1...6)
                    if random == 1{ Eobject.run(TackleAction) }
                    if random == 2{ Eobject.run(BreathAction) }
                    if random == 3{ Eobject.run(ScretchAction) }
                    if random == 4{ Eobject.run(FireBallAction1) }
                    if random == 5{ Eobject.run(FireBallAction2) }
                    if random == 6{ Eobject.run(FlameAction) }
                }
            }
            if type == 43{ //ブルードラゴン
                //ツララ生成のパラメータ
                let icefalltime = 2.0                                               //ツララ生成から落下するまでの時間
                let icedeletetime = 5.0                                             //ツララ生成から消失までの時間
                let iceFP = CGPoint(x: Fep.x - 12 * BSize, y: Fep.y + 1.5 * BSize)  //ツララ攻撃生成の左下のポイント
                let IceSize = CGSize(width: BSize * 1, height: BSize * 2)           //ツララのサイズ
                let Rbmotion = SKAction.sequence([RneckUpMotion,RneckDownMotion])   //攻撃モーション(右向き)
                let Lbmotion = SKAction.sequence([LneckUpMotion,LneckDownMotion])   //攻撃モーション(左向き)
                
                //アイスビームのパラメータ
                let BeemSize: CGFloat = 900                                         //アイスビームのサイズ（敵サイズ基準）
                let BeemPosition: [CGFloat] = [400,0]                               //アイスビームの位置（敵サイズ基準）
                let BeemDamage:Int = 30 + Edame                                     //アイスビームのダメージ
                let BeemSpeed:CGFloat = 3                                           //アイスビーム使用位置までの移動スピード
                let BeemP:[Int] = [1,3,4,6,7,9]                                     //アイスビームの使用位置
                let Beemtime = 6.0                                                  //アイスビームのエフェクト時間
                let BeemStartN = [2]                                                //アイスビームの当たり判定変更位置
                let BeemTimeN = [22]                                                //アイスビームの当たり判定継続時間
                
                //アイスビームの準備
                let BSpeed = BeemSpeed * BSize
                //アイスビームのテクスチャーの読み込み
                let RBeemT = enemyREffect[14]
                let LBeemT = enemyLEffect[14]
                
                //アイスビームのSEの読み込み
                let SE6 = SKAudioNode(fileNamed: "SE/e8_1.mp3")
                SE6.autoplayLooped = false
                Eobject.addChild(SE6)
                let SE6play = SKAction.run{ SE6.run(SKAction.play()) }
                
                //アイスビームの物理ボディの設定
                var BeemBody:[SKPhysicsBody] = []
                let BeemBodySize = Eobject.frame.width * BeemSize / 100.0
                BeemBody.append( CreateSquareBody(Size: [95,10], Position: [2.5,1.0], StandardSize: BeemBodySize) )
          
                
                let IcicleAction1 = SKAction.run {
                    //ツララ作成地点の計算
                    var iceP: [CGPoint] = []
                    for yi in 0 ... 2{
                        for xi in 0 ... 4{
                            let rdx = CGFloat( Int.random(in: 0...4) )
                            iceP.append( CGPoint(x: iceFP.x + ( CGFloat(xi) * 5 + rdx) * self.BSize, y: iceFP.y + CGFloat(yi) * 7 * self.BSize) )
                        }
                    }
                    var BAction: SKAction!
                    if  enemyDD{ BAction = Rbmotion }else{ BAction = Lbmotion }
                    
                    //ツララ生成アクション
                    let icicle = SKAction.run{
                        for n in 0 ..< iceP.count{
                            let ice = SKSpriteNode(imageNamed: "icicle")
                            ice.scale(to: IceSize)
                            ice.position = iceP[n]
                            ice.physicsBody = self.CreatePolygonBody(Position: [[-50,50],[0,-50],[50,50]], StandardSize: IceSize)
                            ice.physicsBody?.categoryBitMask = self.damage2Category
                            ice.physicsBody?.contactTestBitMask = self.damage2CT
                            ice.physicsBody?.collisionBitMask = self.damage2Co
                            ice.physicsBody?.isDynamic = false
                            ice.userData = ["damage":Edame]
                            ice.alpha = 0.6
                            self.addChild(ice)
                            self.run(SKAction.wait(forDuration: icefalltime)){
                                ice.physicsBody?.isDynamic = true
                            }
                            self.run(SKAction.wait(forDuration: icedeletetime)){
                                ice.removeFromParent()
                            }
                        }
                    }
                    Eobject.run(SKAction.sequence([BAction,icicle]))
                    self.run(SKAction.wait(forDuration: nextActiontime + 2.0)){
                        Eobject.run(RePositionAction)
                    }
                }
                
                let IcicleAction2 = SKAction.run {
                    //ツララ作成地点の計算
                    var iceP: [CGPoint] = []
                    for yi in 0 ... 2{
                        for xi in 0 ... 5{
                            let rdx = CGFloat( Int.random(in: 0...3) )
                            iceP.append( CGPoint(x: iceFP.x + ( CGFloat(xi) * 4 + rdx + 0.5) * self.BSize, y: iceFP.y + CGFloat(yi) * 7 * self.BSize) )
                        }
                    }
                    var BAction: SKAction!
                    if  enemyDD{ BAction = Rbmotion }else{ BAction = Lbmotion }
                    //ツララ生成アクション
                    let icicle = SKAction.run{
                        for n in 0 ..< iceP.count{
                            let ice = SKSpriteNode(imageNamed: "icicle")
                            ice.scale(to: IceSize)
                            ice.position = iceP[n]
                            ice.physicsBody = self.CreatePolygonBody(Position: [[-50,50],[0,-50],[50,50]], StandardSize: IceSize)
                            let icetype = Int.random(in: 1...3)
                            if icetype == 1{
                                ice.physicsBody?.categoryBitMask = self.damageCategory
                                ice.physicsBody?.contactTestBitMask = self.damageCT
                                ice.physicsBody?.collisionBitMask = self.damageCo
                            }else{
                                ice.physicsBody?.categoryBitMask = self.damage2Category
                                ice.physicsBody?.contactTestBitMask = self.damage2CT
                                ice.physicsBody?.collisionBitMask = self.damage2Co
                                if icetype == 2 { ice.alpha = 0.6 }
                                if icetype == 3 {
                                    ice.colorBlendFactor = 0.8
                                    ice.color = .cyan
                                }
                            }
                            ice.physicsBody?.isDynamic = false
                            ice.userData = ["damage":Edame]
                            self.addChild(ice)
                            
                            self.run(SKAction.wait(forDuration: icefalltime)){
                                if icetype != 3{
                                    ice.physicsBody?.isDynamic = true
                                }
                            }
                            self.run(SKAction.wait(forDuration: icedeletetime)){
                                ice.removeFromParent()
                            }
                        }
                    }
                    Eobject.run(SKAction.sequence([BAction,icicle]))
                    self.run(SKAction.wait(forDuration: nextActiontime + 2.0)){
                        Eobject.run(RePositionAction)
                    }
                }
                
                let Icebeem = SKAction.run {
                    //無敵アクション→移動⇨魔法陣→必殺技
                    var BBeemAction:SKAction!                                           //攻撃前アクション(無敵になる)
                    var BeemMotion: SKAction!                                           //攻撃時に行うアニメ(通常羽ばたき)
                    var BeemEffict:  [SKTexture] = []                                   //攻撃エフェクト
                    let mpN = BeemP.randomElement()!                                    //攻撃地点の決定
                    var IceBeemP: [CGFloat] = []                                        //攻撃エフェクト位置

                    //攻撃向きの変更
                    if mpN == 1 || mpN == 4 || mpN == 7{ enemyDD = true }else{ enemyDD = false }
                    //向きにより異なるものの定義
                    if enemyDD{
                        BBeemAction = RmutekiAction                                     //攻撃前アクションの読み込み
                        BeemMotion = RwingMotion                                        //攻撃時に行うアニメ(通常羽ばたき)の読み込み
                        BeemEffict = RBeemT                                             //攻撃エフェクトの読み込み
                        IceBeemP = BeemPosition
                    }else{
                        BBeemAction = LmutekiAction                                     //攻撃前アクションの読み込み
                        BeemMotion = LwingMotion                                        //攻撃時に行うアニメ(通常羽ばたき)の読み込み
                        BeemEffict = LBeemT                                             //攻撃エフェクトの読み込み
                        IceBeemP = [ -BeemPosition[0], BeemPosition[1] ]
                    }
                    
                    let moveP = StandardPoint[mpN - 1]                                  //攻撃位置の読み込み
                    let Ep = Eobject.position                                           //現在の敵の位置
                    let BDis = self.distance(p1: Ep, p2: moveP)                         //攻撃位置までの移動距離
                    let Bmovetime = SpeedCtime(Speed: BSpeed, Distance: BDis)           //移動時間の計算
                    let BeemMotionAction = SKAction.run{ Eobject.run(BeemMotion) }      //攻撃時に行うモーションを実行するアクションの作成
                    let BmoveAction = SKAction.move(to: moveP, duration: Bmovetime)     //攻撃位置に移動するアクションの作成
                    
                    let IceBeemAction = SKAction.run{
                        //魔法陣作成
                        let magic = self.enemyEffect2(enemy: Eobject, Effect: MagicT, EPosition: magicEP, ESize: magicSize, Etime: magictime)   //魔法陣エフェクトの作成
                        magic.color = .cyan                 //魔法陣の色
                        magic.colorBlendFactor = 0.7        //魔法陣色のブレンド係数
                        self.run(SE3play)                   //魔法陣SEの再生
                        //アイスビーム作成
                        self.run(SKAction.wait(forDuration: wingtime * 2.0)){
                            self.run(SE6play)
                            self.enemyAttackEffect(enemy: Eobject, Effect: BeemEffict, EPosition: IceBeemP, ESize: BeemSize, Etime: Beemtime, Abody: BeemBody, AStartCN: BeemStartN, AtimeCN: BeemTimeN,Dame: BeemDamage)
                        }
                        //次のアクション
                        self.run(SKAction.wait(forDuration: Beemtime + wingtime * 2.0)){
                            Eobject.run(RePositionAction)
                        }
                    }
                    Eobject.run(SKAction.sequence([BBeemAction,BeemMotionAction,BmoveAction,IceBeemAction]))
                }
                
                
                //次の行う行動を実行するアクション
                nextAction = SKAction.run {
                    let random = Int.random(in: 1...6)
                    if random == 1{ Eobject.run(TackleAction) }
                    if random == 2{ Eobject.run(BreathAction) }
                    if random == 3{ Eobject.run(ScretchAction) }
                    if random == 4{ Eobject.run(IcicleAction1) }
                    if random == 5{ Eobject.run(IcicleAction2) }
                    if random == 6{ Eobject.run(Icebeem) }
                }

            }
            if type == 44{ //グリーンドラゴン
                //小竜巻攻撃
                let Rbmotion = SKAction.sequence([RneckUpMotion,RneckDownMotion])   //攻撃モーション(右向き)
                let Lbmotion = SKAction.sequence([LneckUpMotion,LneckDownMotion])   //攻撃モーション(左向き)
                let nextAtime = 10.0                                                //小竜巻発生から次の行動を起こすまでの時間
                
                //スペシャル(大竜巻攻撃)
                let SpeFtime = 5.0                                                  //大竜巻生成時間
                let SpeMtime = 20.0                                                 //大竜巻移動時間(横移動)
                let SpeRtime = 20.0                                                 //大竜巻移動時間(回転)
                let SpeMoveD: CGFloat = 23.0                                        //大竜巻移動量
                let SpeRSita: CGFloat = 180.0                                       //大竜巻回転量
                let SpeMSize: [CGFloat] = [25,35]                                   //大竜巻サイズ(横移動)
                let SpeRSize: CGFloat = 35                                          //大竜巻サイズ(回転)
                let SpeP:[Int] = [4,5,6]                                            //大竜巻攻撃位置
                //大竜巻のアニメ用テクスチャーの読み込み
                let SpeMTexture1 = readTextureAnime(AtlasNamed: "WindDragon", imageNamed: "Ewind1_", Number: 20)
                let SpeMTexture2 = readTextureAnime(AtlasNamed: "WindDragon", imageNamed: "Ewind2_", Number: 10)
                let SpeRTexture1 = readTextureAnime(AtlasNamed: "WindDragon", imageNamed: "Ewind3_", Number: 20)
                let SpeRTexture2 = readTextureAnime(AtlasNamed: "WindDragon", imageNamed: "Ewind4_", Number: 10)
                let Spcialdama = Edame + 10                                         //大竜巻ダメージ量
                
                let torwaitAction = SKAction.wait(forDuration: nextAtime)
                let tornadoAction1 = SKAction.run {
                    var BAction: SKAction!
                    if  enemyDD{ BAction = Rbmotion }else{ BAction = Lbmotion }
                    let TAction = SKAction.run{
                        self.addtornado(xp: 4, yp: 31, damage: Edame, count: 3, Right: true, DelayTime: 0.0, Loop: false)
                        self.addtornado(xp: 34, yp: 31, damage: Edame, count: 3, Right: false, DelayTime: 0.0, Loop: false)
                        self.addtornado(xp: 4, yp: 15, damage: Edame, count: 3, Right: true, DelayTime: 0.0, Loop: false)
                        self.addtornado(xp: 34, yp: 15, damage: Edame, count: 3, Right: false, DelayTime: 0.0, Loop: false)
                    }
                    Eobject.run(SKAction.sequence([BAction,TAction,torwaitAction,RePositionAction]))
                }
                
                let tornadoAction2 = SKAction.run {
                    var BAction: SKAction!
                    if  enemyDD{ BAction = Rbmotion }else{ BAction = Lbmotion }
                    let TAction = SKAction.run{
                        self.addtornado(xp: 14, yp: 31, damage: Edame, count: 3, Right: false, DelayTime: 0.0, Loop: false)
                        self.addtornado(xp: 24, yp: 31, damage: Edame, count: 3, Right: true, DelayTime: 0.0, Loop: false)
                        self.addtornado(xp: 14, yp: 19, damage: Edame, count: 3, Right: false, DelayTime: 0.0, Loop: false)
                        self.addtornado(xp: 24, yp: 19, damage: Edame, count: 3, Right: true, DelayTime: 0.0, Loop: false)
                    }
                    Eobject.run(SKAction.sequence([BAction,TAction,torwaitAction,RePositionAction]))
                }
                
                let specialAction = SKAction.run {
                    //無敵アクション→移動⇨魔法陣→必殺技
                    var BSpeAction:SKAction!            //攻撃前アクション(無敵になる)
                    var SpeMotion: SKAction!            //攻撃時に行うアニメ(通常羽ばたき)
                    let mpN = SpeP.randomElement()!
                    var Tornadotime: Double!
                    //敵の向き
                    if mpN == 4 {
                        enemyDD = true
                        Tornadotime = SpeMtime
                        
                    } else if mpN == 6 {
                        enemyDD = false
                        Tornadotime = SpeMtime
                    }
                    else {
                        enemyDD = Bool.random()
                        Tornadotime = SpeRtime
                    }
                    if enemyDD{
                        BSpeAction = RmutekiAction                             //攻撃前アクションの読み込み
                        SpeMotion = RwingMotion                                //攻撃時に行うアニメ(通常羽ばたき)の読み込み
                    }else{
                        BSpeAction = LmutekiAction                             //攻撃前アクションの読み込み
                        SpeMotion = LwingMotion                                //攻撃時に行うアニメ(通常羽ばたき)の読み込み
                    }
                    
                    let moveP = StandardPoint[mpN - 1]                                  //攻撃位置の読み込み
                    let Ep = Eobject.position                                           //現在の敵の位置
                    let BDis = self.distance(p1: Ep, p2: moveP)                         //攻撃位置までの移動距離
                    let Bmovetime = SpeedCtime(Speed: BSpeed, Distance: BDis)           //移動時間の計算
                    let TMotionAction = SKAction.run{ Eobject.run(SpeMotion) }          //攻撃時に行うモーションを実行するアクションの作成
                    let TmoveAction = SKAction.move(to: moveP, duration: Bmovetime)     //攻撃位置に移動するアクションの作成
                    
                    let SpeAction = SKAction.run{
                        //魔法陣作成
                        let magic = self.enemyEffect2(enemy: Eobject, Effect: MagicT, EPosition: magicEP, ESize: magicSize, Etime: magictime)   //魔法陣エフェクトの作成
                        magic.color = .green                //魔法陣の色
                        magic.colorBlendFactor = 0.7        //魔法陣色のブレンド係数
                        self.run(SE3play)                   //魔法陣SEの再生
                        
                        //竜巻作成
                        self.run(SKAction.wait(forDuration: wingtime * 2.0)){
                            var FTexture:[SKTexture] = []           //竜巻発生時のアニメテクスチャ
                            var LTexture:[SKTexture] = []           //竜巻ループ時のアニメテクスチャ
                            var TornadoSize: CGSize!                //竜巻のサイズ
                            var TornadoP: CGPoint!                  //竜巻の生成位置
                            var TorMoveAction: SKAction!            //竜巻の移動アクション
                            var BodySize: [CGFloat] = []            //竜巻の物理ボディのサイズ
                            if mpN == 4 || mpN == 6{
                                FTexture = SpeMTexture1
                                LTexture = SpeMTexture2
                                TornadoSize = CGSize(width: SpeMSize[0] * self.BSize, height: SpeMSize[1] * self.BSize)
                                BodySize = [15,90]
                                if mpN == 4{
                                    TornadoP = CGPoint(x: 9.5 * self.BSize, y: 19.5 * self.BSize)
                                    TorMoveAction = SKAction.moveBy(x: SpeMoveD * self.BSize, y: 0, duration: SpeMtime)
                                }else{
                                    TornadoP = CGPoint(x: 29.5 * self.BSize, y: 19.5 * self.BSize)
                                    TorMoveAction = SKAction.moveBy(x: -SpeMoveD * self.BSize, y: 0, duration: SpeMtime)
                                }
                            }
                            if mpN == 5{
                                FTexture = SpeRTexture1
                                LTexture = SpeRTexture2
                                TornadoSize = CGSize(width: SpeRSize * self.BSize, height: SpeRSize * self.BSize)
                                BodySize = [8,90]
                                TornadoP = CGPoint(x: 19.5 * self.BSize, y: 19.5 * self.BSize)
                                if enemyDD{
                                    TorMoveAction = SKAction.rotate(byAngle: SpeRSita * self.psita, duration: SpeRtime)
                                }else{
                                    TorMoveAction = SKAction.rotate(byAngle: -SpeRSita * self.psita, duration: SpeRtime)
                                }
                            }
                            
                            //竜巻のスプライトの設定
                            let Dtornado = SKSpriteNode(texture: FTexture[0])
                            Dtornado.scale(to: TornadoSize)
                            Dtornado.position = TornadoP
                            Dtornado.userData = ["damage":Spcialdama]
                            self.addChild(Dtornado)
                            
                            //竜巻のSEの読み込み
                            Dtornado.addChild(self.ReadAudioNode(named: "Dtornad", type: "mp3", Loop: false))
                            Dtornado.PlaySE()
                            
                            //竜巻のアクションの設定
                            //移動して消去するアクション
                            let DeleteAction = SKAction.removeFromParent()
                            TorMoveAction = SKAction.sequence([TorMoveAction,DeleteAction])
                            //アニメ
                            let TorFAnime = SKAction.animate(with: FTexture, timePerFrame: SpeFtime / 20.0)
                            let TorAniem = SKAction.repeatForever(SKAction.animate(with: LTexture, timePerFrame: 0.1))
                            //物理ボディの作成
                            let CreateBodyAction = SKAction.run {
                                Dtornado.physicsBody = self.CreateSquareBody(Size: BodySize, Position: [0,0], StandardSize: TornadoSize)
                                Dtornado.physicsBody?.isDynamic = false
                                Dtornado.physicsBody?.categoryBitMask = self.damage2Category
                                Dtornado.physicsBody?.contactTestBitMask = self.damage2CT
                                Dtornado.physicsBody?.collisionBitMask = self.damage2Co
                            }
                            //アクションの合成
                            let TorEAction = SKAction.group([TorMoveAction,CreateBodyAction,TorAniem])
                            
                            //アクションを実行
                            Dtornado.run(SKAction.sequence([TorFAnime,TorEAction]))
                        }
                        
                        
                        
                        //次のアクション
                        self.run(SKAction.wait(forDuration: SpeFtime + Tornadotime)){
                            Eobject.run(RePositionAction)
                        }
                        
                    }
                    
                    Eobject.run(SKAction.sequence([BSpeAction,TMotionAction,TmoveAction,SpeAction]))
                }
                
                nextAction = SKAction.run {
                    let random = Int.random(in: 1...9)
                    if random == 1 || random == 2{ Eobject.run(TackleAction) }
                    if random == 3 || random == 4{ Eobject.run(BreathAction) }
                    if random == 5  { Eobject.run(tornadoAction1) }
                    if random == 6  { Eobject.run(tornadoAction2) }
                    if random == 7 || random == 8 || random == 9{ Eobject.run(specialAction) }
                }
            }

            Eobject.run(BreathAction)
        }
        //1_1_10魔王
        else if type == 45{
            
        }
        //1_1_10宇宙生物
        else if type == 46{
            
        }
        
    
        //1_1_0一定以上離れたら敵を消すアクションを実行
        if type != 10 && type != 20 && type != 30 && type <= 40{
            var deleteAction: SKAction!
            let Interval = SKAction.wait(forDuration: 1.0)
            let lastAction = SKAction.run {
                let ep = Eobject.position
                let pp = self.body.position
                let pdx = ep.x - pp.x
                let pdy = ep.y - pp.y
                if pdx.abs() > self.BSize * 15 || pdy.abs() > self.BSize * 10{
                    self.enemydelete(kill: false, object: Eobject)
                }else{
                    Eobject.run(deleteAction)
                }
            }
            deleteAction = SKAction.sequence([Interval,lastAction])
            Eobject.run(deleteAction)
            
        }
    }
    
    //1¥敵のエフェクト作成
    func enemyAttackEffect(enemy:SKSpriteNode, Effect:[SKTexture],EPosition:[CGFloat],ESize:CGFloat,Etime:Double,Abody:[SKPhysicsBody],AStartCN:[Int],AtimeCN:[Int],PSFlag:Bool = false,Dame:Int = 0){
        let Es = enemy.size.width
        let Ep = enemy.position
        let time1 = Etime / Double(Effect.count)
        var Damage = enemy.GetInt(name: "damage")
        if Dame != 0 { Damage = Dame }
        //攻撃エフェクト作成
        let ESprite = SKSpriteNode(texture: Effect[0])
        ESprite.scale(to: CGSize(width: ESize / 100.0 * Es, height: ESize / 100.0 * Es))
        if PSFlag{
            ESprite.position = CGPoint(x: body.position.x + EPosition[0] / 100.0 * Es, y: body.position.y + EPosition[1] / 100.0 * Es)
        }else{
            ESprite.position = CGPoint(x: Ep.x + EPosition[0] / 100.0 * Es, y: Ep.y + EPosition[1] / 100.0 * Es)
        }
        ESprite.zPosition = 1
        addChild(ESprite)
        
        //攻撃エフェクトのアニメ
        var EffectAnime = SKAction.animate(with: Effect, timePerFrame: time1)
        EffectAnime = SKAction.sequence([EffectAnime,SKAction.removeFromParent()])
        ESprite.run(EffectAnime)
        
        //ダメージオブジェクト(透明) の作成
        for n in 0 ..< AStartCN.count{
            let Aintarval = time1 * Double(AStartCN[n])
            let Atime = time1 * Double(AtimeCN[n])
            self.run(SKAction.wait(forDuration: Aintarval)){
                let deleteAction = SKAction.sequence([SKAction.wait(forDuration: Atime),SKAction.removeFromParent()])
                let EffectBody = SKShapeNode(circleOfRadius: 10)
                EffectBody.position = ESprite.position
                EffectBody.alpha = 0
                EffectBody.physicsBody = Abody[n]
                EffectBody.physicsBody?.categoryBitMask = self.damage2Category
                EffectBody.physicsBody?.contactTestBitMask = self.damageCT
                EffectBody.physicsBody?.collisionBitMask = self.damageCo
                EffectBody.userData = ["damage":Damage]
                EffectBody.physicsBody?.isDynamic = false
                self.addChild(EffectBody)
                EffectBody.run(deleteAction)
            }
        }
    }
    
    func enemyAttackEffect2(enemy:SKSpriteNode, Effect:[SKTexture],EPosition:[CGFloat],ESize:CGFloat,Etime:Double,Abody:[SKPhysicsBody],AStartCN:[Int],AtimeCN:[Int],PSFlag:Bool = false) -> SKSpriteNode{
        let Es = enemy.size.width
        let Ep = enemy.position
        let time1 = Etime / Double(Effect.count)
        let Damage = enemy.GetInt(name: "damage")
        
        //攻撃エフェクト作成
        let ESprite = SKSpriteNode(texture: Effect[0])
        ESprite.scale(to: CGSize(width: ESize / 100.0 * Es, height: ESize / 100.0 * Es))
        if PSFlag{
            ESprite.position = CGPoint(x: body.position.x + EPosition[0] / 100.0 * Es, y: body.position.y + EPosition[1] / 100.0 * Es)
        }else{
            ESprite.position = CGPoint(x: Ep.x + EPosition[0] / 100.0 * Es, y: Ep.y + EPosition[1] / 100.0 * Es)
        }
        ESprite.zPosition = 1
        addChild(ESprite)
        
        //攻撃エフェクトのアニメ
        var EffectAnime = SKAction.animate(with: Effect, timePerFrame: time1)
        EffectAnime = SKAction.sequence([EffectAnime,SKAction.removeFromParent()])
        ESprite.run(EffectAnime)
        
        //ダメージオブジェクト(透明) の作成
        for n in 0 ..< AStartCN.count{
            let Aintarval = time1 * Double(AStartCN[n])
            let Atime = time1 * Double(AtimeCN[n])
            self.run(SKAction.wait(forDuration: Aintarval)){
                let deleteAction = SKAction.sequence([SKAction.wait(forDuration: Atime),SKAction.removeFromParent()])
                let EffectBody = SKShapeNode(circleOfRadius: 10)
                EffectBody.position = ESprite.position
                EffectBody.alpha = 0
                EffectBody.physicsBody = Abody[n]
                EffectBody.physicsBody?.categoryBitMask = self.damage2Category
                EffectBody.physicsBody?.contactTestBitMask = self.damageCT
                EffectBody.physicsBody?.collisionBitMask = self.damageCo
                EffectBody.userData = ["damage":Damage]
                EffectBody.physicsBody?.isDynamic = false
                self.addChild(EffectBody)
                EffectBody.run(deleteAction)
            }
        }
        return ESprite
    }
    
    func enemyEffect(enemy:SKSpriteNode, Effect:[SKTexture], EPosition:[CGFloat],ESize:CGFloat,Etime:Double){
        let Es = enemy.size.width
        let Ep = enemy.position
        let time1 = Etime / Double(Effect.count)
        
        //エフェクト作成
        let ESprite = SKSpriteNode(texture: Effect[0])
        ESprite.scale(to: CGSize(width: ESize / 100.0 * Es, height: ESize / 100.0 * Es))
        ESprite.position = CGPoint(x: Ep.x + EPosition[0] / 100.0 * Es, y: Ep.y + EPosition[1] / 100.0 * Es)
        ESprite.zPosition = 1
        addChild(ESprite)
        
        //エフェクトのアニメ
        var EffectAnime = SKAction.animate(with: Effect, timePerFrame: time1)
        EffectAnime = SKAction.sequence([EffectAnime,SKAction.removeFromParent()])
        ESprite.run(EffectAnime)
    }
    
    func enemyEffect2(enemy:SKSpriteNode, Effect:[SKTexture], EPosition:[CGFloat],ESize:CGFloat,Etime:Double) -> SKSpriteNode{
        let Es = enemy.size.width
        let Ep = enemy.position
        let time1 = Etime / Double(Effect.count)
        
        //エフェクト作成
        let ESprite = SKSpriteNode(texture: Effect[0])
        ESprite.scale(to: CGSize(width: ESize / 100.0 * Es, height: ESize / 100.0 * Es))
        ESprite.position = CGPoint(x: Ep.x + EPosition[0] / 100.0 * Es, y: Ep.y + EPosition[1] / 100.0 * Es)
        ESprite.zPosition = 1
        addChild(ESprite)
        
        //エフェクトのアニメ
        var EffectAnime = SKAction.animate(with: Effect, timePerFrame: time1)
        EffectAnime = SKAction.sequence([EffectAnime,SKAction.removeFromParent()])
        ESprite.run(EffectAnime)
        
        return ESprite
    }
    
    func EffectObject(P:CGPoint, Size:CGFloat ,Effect:[SKTexture] ,Ebody: SKPhysicsBody,time:Double ,Endtime:Double,damage:Int,alpha:CGFloat = 1.0) -> SKSpriteNode{
        let En = Effect.count
        let EffectO = SKSpriteNode(texture: Effect[0])
        EffectO.scale(to: CGSize(width: Size, height: Size))
        EffectO.position = P
        EffectO.physicsBody = Ebody
        EffectO.physicsBody?.categoryBitMask = damage2Category
        EffectO.physicsBody?.contactTestBitMask = damage2CT
        EffectO.physicsBody?.collisionBitMask = damage2Co
        EffectO.physicsBody?.isDynamic = false
        EffectO.userData = ["damage" : damage]
        EffectO.alpha = alpha
        addChild(EffectO)
        let Eanime = SKAction.animate(with: Effect, timePerFrame: time / Double(En))
        EffectO.run(SKAction.repeatForever(Eanime))
        
        if Endtime != 0.0{
            self.run(SKAction.wait(forDuration: Endtime)){ EffectO.removeFromParent() }
        }
        return EffectO
    }
    
    //1¥敵の消去
    func enemydelete(kill:Bool,object:SKNode){
        let EnemyAppearancePoint = object.GetInt(name: "Pnumber")  //敵の出現ポイント
        if kill{
            enemynmax[EnemyAppearancePoint] -= 1
            if enemynmax[EnemyAppearancePoint] == 0 && enemySwitchNumber[EnemyAppearancePoint + 1][0] != 0{ //スイッチ関数起動の条件
                for n in 0..<enemySwitchNumber[EnemyAppearancePoint + 1].count{
                     run(BlockAction[BlockActionNumber[enemySwitchNumber[EnemyAppearancePoint + 1][n]]])
                }
            }
        }
        enemynpre[EnemyAppearancePoint] -= 1
        object.removeFromParent()
        ecount -= 1
    }
    
    //1¥ボスの出現方向表示矢印の追加
    func addBossVector(Boss:SKSpriteNode){
        BossO = Boss
        BossVector = SKSpriteNode(imageNamed: "Evector")
        BossVector.scale(to: CGSize(width: 3 * BSize, height: 3 * BSize))
        BossVector.position = CGPoint(x: 2 * w , y: h)
        cameraNode.addChild(BossVector)
        BossVFlag = true
    }
    
    func BossEffectChange(type:Int){
        if type == 1{           //無敵
            let BossAT = readTextureAnime(AtlasNamed: "BossEffect", imageNamed: "BossM", Number: 24)
            BossEffect.run( SKAction.repeatForever(SKAction.animate(with: BossAT, timePerFrame: 0.1))  )
            DelayRun(time: 0.1) {
                self.BossEffect.alpha = 1.0
            }
        }else if type == 2{     //
            
        }else{                  //解除
            BossEffect.alpha = 0
            BossEffect.removeAllActions()
        }
        
    }
    
    //1¥ゴール追加
    func addgoal(xp:CGFloat, yp:CGFloat,Goaltype: Int = 0,BlockNumber n:Int = 0){
        let goalTexture = SKTexture(imageNamed: "goalT\(Goaltype)")
        let goal = SKSpriteNode(imageNamed: "goal\(Goaltype)" )
        goal.scale(to: CGSize(width: BSize * 2, height: BSize * 2))
        goal.position = CGPoint(x: BSize * xp + BSize / 2 , y: BSize * yp + BSize / 2)
        goal.physicsBody = SKPhysicsBody(texture: goalTexture, size: goal.size)
        goal.physicsBody?.affectedByGravity = false
        goal.physicsBody?.isDynamic = false
        goal.physicsBody?.categoryBitMask = moveCategory
        goal.physicsBody?.contactTestBitMask = moveCT
        goal.physicsBody?.collisionBitMask = moveCo
        goal.userData = ["StageN":1000 + Goaltype,"SceneN":1000]
        if n != 0{
            Block.append(goal)
            BlockNumber[n] = Block.count
        }
        addChild(goal)
    }
    
    //1¥ブロック追加
    func addBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,type:Int,BlockNumber n: Int = 0,Pattern:Int = 0,Angle:Double = 0.0){
        //pattern:  0,四角  1,L字  2,コの字 3,ト方
        var xn = Int(xs)
        var yn = Int(ys)
        var BlockP = CGPoint(x: BSize / 2 * xs + BSize * xp, y: BSize / 2 * ys + BSize * yp)
        var BlockS = CGSize(width: BSize * xs, height: BSize *  ys)
        var BlockBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize * (xs - 0.05), height: BSize * (ys - 0.05)))
        let Blockname: String = "block" + String(type)
        
        if Pattern != 0 || (xn < 5 && yn < 5) || type > 30 || n != 0{ //別形状の使用 or ブロックサイズが小さい or 特殊ブロックを使用 or ブロックアクションを使用
            if Pattern == 1{ //逆L字
                xn = xn * 2 - 1
                yn = yn * 2 - 1
                BlockP = CGPoint(x: BSize * (xs - 0.5) + BSize * xp, y: BSize / 2 + BSize * yp)
                BlockS = CGSize(width: BSize * (xs * 2 - 1), height: BSize * (ys * 2 - 1) )
                let BlockBody1 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * (xs - 0.05), height: BSize * 0.95), center: CGPoint(x: -(xs - 1) * 0.5 * BSize, y: 0) )
                let BlockBody2 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * 0.95, height: BSize * (ys - 0.05) ), center: CGPoint(x: 0, y: (ys - 1) * 0.5 * BSize) )
                BlockBody = SKPhysicsBody(bodies: [BlockBody1,BlockBody2])
            }
            if Pattern == 2{
                let BlockBody1 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * (xs - 0.05), height: BSize * 0.95), center: CGPoint(x: 0, y: -(ys - 1) * 0.5 * BSize) )
                let BlockBody2 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * 0.95, height: BSize * (ys - 0.05) ), center: CGPoint(x: (xs - 1) * 0.5 * BSize, y: 0 ) )
                let BlockBody3 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * 0.95, height: BSize * (ys - 0.05) ), center: CGPoint(x: -(xs - 1) * 0.5 * BSize, y: 0 ) )
                BlockBody = SKPhysicsBody(bodies: [BlockBody1,BlockBody2,BlockBody3])
            }
            if Pattern == 3{ //逆L字
                xn = xn * 2 - 1
                yn = yn * 2 - 1
                BlockP = CGPoint(x: BSize * (xs - 0.5) + BSize * xp, y: BSize / 2 + BSize * yp)
                BlockS = CGSize(width: BSize * (xs * 2 - 1), height: BSize * (ys * 2 - 1) )
                let BlockBody1 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * (2 * xs - 1 - 0.05), height: BSize * 0.95), center: CGPoint(x: 0, y: 0) )
                let BlockBody2 = SKPhysicsBody(rectangleOf: CGSize(width: BSize * 0.95, height: BSize * (ys - 0.05) ), center: CGPoint(x: 0, y: (ys - 1) * 0.5 * BSize) )
                BlockBody = SKPhysicsBody(bodies: [BlockBody1,BlockBody2])
            }
            
            let xx = (xn - 1) / 2
            let yy = (yn - 1) / 2
            
            let emptyBlockname: String = "block0"
            UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * CGFloat(xn), height: BSize * CGFloat(yn)), false, 0.0)
            for yi in 0 ..< yn{
                for xi in 0 ..< xn{
                    if Pattern == 1{
                        if xi == xx || yi == yy {
                            if xi <= xx && yi <= yy{
                                if let block = UIImage(named: Blockname){
                                    block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                                }
                            }else{
                                if let block = UIImage(named: emptyBlockname){
                                    block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                                }
                            }
                        }
                    }else if Pattern == 2{
                        if xi == 0 || xi == xn - 1 || yi == yn - 1{
                            if let block = UIImage(named: Blockname){
                                block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                            }
                        }
                    }else if Pattern == 3{
                        if xi == xx || yi == yy {
                            if yi <= yy{
                                if let block = UIImage(named: Blockname){
                                    block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                                }
                            }else{
                                if let block = UIImage(named: emptyBlockname){
                                    block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                                }
                            }
                        }
                    }else{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
            }
            let Blockimage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            let BlockTexter = SKTexture(image: Blockimage )
            let BlockSprite = SKSpriteNode(texture: BlockTexter)
            BlockSprite.scale(to: BlockS)
            BlockSprite.position = BlockP
            BlockSprite.physicsBody = BlockBody
            BlockSprite.zRotation = CGFloat(Angle * .pi / 180)
            BlockSprite.physicsBody?.restitution = 0.1
            BlockSprite.physicsBody?.affectedByGravity = false
            BlockSprite.physicsBody?.isDynamic = false
            BlockSprite.physicsBody?.categoryBitMask = blockCategory
            BlockSprite.physicsBody?.contactTestBitMask = blockCT
            BlockSprite.physicsBody?.collisionBitMask = blockCo
            if type == 999{
                BlockSprite.physicsBody?.categoryBitMask = block2Category
                BlockSprite.physicsBody?.contactTestBitMask = block2CT
                BlockSprite.physicsBody?.collisionBitMask = block2Co
            }
            if type == 101{
                ONBlock.append(BlockSprite)
            }
            if type == 102{
                OFFBlock.append(BlockSprite)
                BlockSprite.physicsBody?.categoryBitMask = 0
                BlockSprite.physicsBody?.contactTestBitMask = 0
                BlockSprite.physicsBody?.collisionBitMask = 0
                BlockSprite.alpha = 0.2
            }
            if type == 103{
                ONOFFBlock.append(BlockSprite)
                BlockSprite.userData = ["ONflag":true]
            }
            if n != 0{
                Block.append(BlockSprite)
                BlockNumber[n] = Block.count
            }
            addChild(BlockSprite)
        }else{//ブロックアクションや特殊形状、特殊ブロックが未使用かつブロックサイズが大きい時
            let BlockSprite = SKSpriteNode(imageNamed: Blockname)
            BlockSprite.scale(to: BlockS)
            BlockSprite.position = BlockP
            BlockSprite.physicsBody = BlockBody
            BlockSprite.zRotation = CGFloat(Angle * .pi / 180)
            BlockSprite.physicsBody?.restitution = 0.1
            BlockSprite.physicsBody?.affectedByGravity = false
            BlockSprite.physicsBody?.isDynamic = false
            BlockSprite.physicsBody?.categoryBitMask = blockCategory
            BlockSprite.physicsBody?.contactTestBitMask = blockCT
            BlockSprite.physicsBody?.collisionBitMask = blockCo
            BlockSprite.alpha = 0
            addChild(BlockSprite)
            
            //ブロックテクスチャの作成
            let BlockPSize = 5
            let BPSize = CGFloat(BlockPSize)
            
            let xsn = xn / BlockPSize
            let ysn = yn / BlockPSize
            let xsfn = xn % BlockPSize
            let ysfn = yn % BlockPSize
            //x方向のブロック作成
            var BlockImage1: UIImage!
            var BlockImage2: UIImage!
            var BlockImage3: UIImage!
            var BlockImage4: UIImage!
            
            if xsn >= 1 && ysn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * BPSize, height: BSize * BPSize), false, 0.0)
                for yi in 0 ..< 5{
                    for xi in 0 ..< BlockPSize{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage1 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if ysn >= 1 && xsfn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * CGFloat(xsfn), height: BSize * BPSize), false, 0.0)
                for yi in 0 ..< BlockPSize{
                    for xi in 0 ..< xsfn{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage2 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if xsn >= 1 && ysfn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * BPSize, height: BSize * CGFloat(ysfn)), false, 0.0)
                for yi in 0 ..< ysfn{
                    for xi in 0 ..< BlockPSize{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage3 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if xsfn >= 1 && ysfn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * CGFloat(xsfn), height: BSize * CGFloat(ysfn)), false, 0.0)
                for yi in 0 ..< ysfn{
                    for xi in 0 ..< xsfn{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage4 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if ysn == 0{
                let BlockSize1 = CGSize(width: BPSize * BSize, height: CGFloat(ysfn) * BSize)
                for xn in 0 ..< xsn{
                    let BlockPosition1 = CGPoint(x: (xp + BPSize / 2 + CGFloat(xn) * BPSize) * BSize, y: (yp + CGFloat(ysfn) / 2) * BSize )
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage3))
                    BSprite.scale(to: BlockSize1)
                    BSprite.position = BlockPosition1
                    addChild(BSprite)
                }
                if xsfn != 0{
                    let BlockSize2 = CGSize(width: CGFloat(xsfn) * BSize, height: CGFloat(ysfn) * BSize)
                    let BlockPosition2 = CGPoint(x: (xp + BPSize * CGFloat(xsn) + CGFloat(xsfn) / 2 ) * BSize, y: (yp + CGFloat(ysfn) / 2) * BSize)
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage4))
                    BSprite.scale(to: BlockSize2)
                    BSprite.position = BlockPosition2
                    addChild(BSprite)
                }
            }
            
            if xsn == 0{
                let BlockSize1 = CGSize(width: CGFloat(xsfn) * BSize, height: BPSize * BSize)
                for yn in 0 ..< ysn{
                    let BlockPosition1 = CGPoint(x: (xp + CGFloat(xsfn) / 2) * BSize, y: (yp + BPSize / 2 + CGFloat(yn) * BPSize) * BSize )
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage2))
                    BSprite.scale(to: BlockSize1)
                    BSprite.position = BlockPosition1
                    addChild(BSprite)
                }
                if ysfn != 0{
                    let BlockSize2 = CGSize(width: CGFloat(xsfn) * BSize, height: CGFloat(ysfn) * BSize)
                    let BlockPosition2 = CGPoint(x: (xp + CGFloat(xsfn) / 2) * BSize, y: (yp + BPSize * CGFloat(ysn) + CGFloat(ysfn) / 2 ) * BSize)
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage4))
                    BSprite.scale(to: BlockSize2)
                    BSprite.position = BlockPosition2
                    addChild(BSprite)
                }
            }
            
            if xsn != 0 && ysn != 0{
                let BlockSize1 = CGSize(width: BPSize * BSize, height: BPSize * BSize)
                for yn in 0 ..< ysn{
                    for xn in 0 ..< xsn{
                        let BlockPosition1 = CGPoint(x: (xp + BPSize / 2 + CGFloat(xn) * BPSize) * BSize, y: (yp + BPSize / 2 + CGFloat(yn) * BPSize) * BSize )
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage1))
                        BSprite.scale(to: BlockSize1)
                        BSprite.position = BlockPosition1
                        addChild(BSprite)
                    }
                    if xsfn != 0{
                        let BlockSize2 = CGSize(width: CGFloat(xsfn) * BSize, height: BPSize * BSize)
                        let BlockPosition2 = CGPoint(x: (xp + BPSize * CGFloat(xsn) + CGFloat(xsfn) / 2 ) * BSize, y: (yp + BPSize / 2 + CGFloat(yn) * BPSize) * BSize)
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage2))
                        BSprite.scale(to: BlockSize2)
                        BSprite.position = BlockPosition2
                        addChild(BSprite)
                    }
                }
                
                if ysfn != 0{
                    let BlockSize3 = CGSize(width: BPSize * BSize, height: CGFloat(ysfn) * BSize)
                    for xn in 0 ..< xsn{
                        let BlockPosition3 = CGPoint(x: (xp + BPSize / 2 + CGFloat(xn) * BPSize) * BSize, y: (yp + BPSize * CGFloat(ysn) + CGFloat(ysfn) / 2 ) * BSize )
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage3))
                        BSprite.scale(to: BlockSize3)
                        BSprite.position = BlockPosition3
                        addChild(BSprite)
                    }
                    if xsfn != 0{
                        let BlockSize4 = CGSize(width: CGFloat(xsfn) * BSize, height: CGFloat(ysfn) * BSize)
                        let BlockPosition4 = CGPoint(x: (xp + BPSize * CGFloat(xsn) + CGFloat(xsfn) / 2 ) * BSize, y: (yp + BPSize * CGFloat(ysn) + CGFloat(ysfn) / 2 ) * BSize )
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage4))
                        BSprite.scale(to: BlockSize4)
                        BSprite.position = BlockPosition4
                        addChild(BSprite)
                    }
                }
            }
        }
    }
    
    //1¥ONブロック追加
    func addONBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,BlockNumber n: Int = 0,Pattern:Int = 0,Angle:Double = 0.0){
        addBlock(xp: xp, yp: yp, xs: xs, ys: ys, type: 101, BlockNumber: n, Pattern: Pattern, Angle: Angle)
    }
    //1¥OFFブロック追加
    func addOFFBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat,BlockNumber n: Int = 0,Pattern:Int = 0,Angle:Double = 0.0){
        addBlock(xp: xp, yp: yp, xs: xs, ys: ys, type: 102, BlockNumber: n, Pattern: Pattern, Angle: Angle)
    }
    //1¥ONOFFブロック追加
    func addONOFFBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat,BlockNumber n: Int = 0,Pattern:Int = 0,Angle:Double = 0.0){
        addBlock(xp: xp, yp: yp, xs: xs, ys: ys, type: 103, BlockNumber: n, Pattern: Pattern, Angle: Angle)
    }
   
    //1¥雲追加
    func addcloud(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat,type1:Int,type2:Int,BlockNumber n: Int = 0,Angle:CGFloat = 0.0){
        //type1 1:通常  type2 1:剛体  2:重い（回転無効）緑　　  3:軽い（回転無効）黄     4;重い（回転有効）赤
        //type1 2:弾性  type2 1:弾性力小 黄  2:弾性力中 緑   3:弾性力大 赤
        
        let OSize = CGSize(width: xs * BSize, height: ys * BSize)
        let cloud = SKSpriteNode(imageNamed: "cloud\(type1)")
        cloud.scale(to: OSize)
        cloud.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
        cloud.physicsBody = CreateSquareBody(Size: [70,60], Position: [0,0], StandardSize: OSize)
        if type1 == 1{
            cloud.physicsBody?.categoryBitMask = block4Category
            cloud.physicsBody?.contactTestBitMask = block4CT
            cloud.physicsBody?.collisionBitMask = block4Co
            if type2 == 1{
                cloud.physicsBody?.isDynamic = false
            }else if type2 == 2{
                cloud.physicsBody?.isDynamic = true
                cloud.physicsBody?.affectedByGravity = false
                cloud.physicsBody?.allowsRotation = false
                cloud.physicsBody?.linearDamping = 0.9
                cloud.physicsBody?.mass = 250.0
                cloud.colorBlendFactor = 0.2
                cloud.color = .green
            }else if type2 == 3{
                cloud.physicsBody?.isDynamic = true
                cloud.physicsBody?.affectedByGravity = false
                cloud.physicsBody?.allowsRotation = false
                cloud.physicsBody?.linearDamping = 0.5
                cloud.physicsBody?.mass = 80.0
                cloud.colorBlendFactor = 0.2
                cloud.color = .yellow
            }else{
                cloud.physicsBody?.isDynamic = true
                cloud.physicsBody?.affectedByGravity = false
                cloud.physicsBody?.linearDamping = 0.9
                cloud.physicsBody?.angularDamping = 1.0
                cloud.physicsBody?.mass = 250.0
                cloud.colorBlendFactor = 0.2
                cloud.color = .red
            }
        }
        if type1 == 2{
            cloud.physicsBody?.categoryBitMask = ActionBlockCategory
            cloud.physicsBody?.contactTestBitMask = ActionBCT
            cloud.physicsBody?.collisionBitMask = ActionBCo
            cloud.physicsBody?.isDynamic = false
            cloud.userData = ["type":type2]
            if type2 == 1{
                cloud.physicsBody?.restitution = 0.6
                cloud.colorBlendFactor = 0.1
                cloud.color = .yellow
            }
            if type2 == 2{
                cloud.physicsBody?.restitution = 0.8
                cloud.colorBlendFactor = 0.1
                cloud.color = .green
            }
            if type2 == 3{
                cloud.physicsBody?.restitution = 1.0
                cloud.colorBlendFactor = 0.1
                cloud.color = .red
            }
            
        }
        cloud.zRotation = Angle * psita
        if n != 0{
            Block.append(cloud)
            BlockNumber[n] = Block.count
        }
        addChild(cloud)
    }
    
    //1¥竜巻追加
    func addtornado(xp: CGFloat, yp:CGFloat,damage:Int,count:Int,Right:Bool,DelayTime:Double = 0.0,Loop:Bool = true){
        //トルネードのテクスチャーの読み込み
        let number = 6 //アニメのコマ数
        let tornadeTexture = readTextureAnime(AtlasNamed: "tornado", imageNamed: "tornado", Number: number)
        //トルネードのサイズ
        let OSize = BSize * 3.0
        //トルネードのスプライトの設定
        let tornado = SKSpriteNode(texture: tornadeTexture[0])
        tornado.scale(to: CGSize(width: OSize, height: OSize)  )
        tornado.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
        //トルネードの物理ボディの設定
        tornado.physicsBody = CreateSquareBody(Size: [55,70], Position: [-2.5,0], StandardSize: OSize)
        tornado.physicsBody?.categoryBitMask = damage2Category
        tornado.physicsBody?.contactTestBitMask = damage2CT
        tornado.physicsBody?.collisionBitMask = damage2Co
        tornado.physicsBody?.isDynamic = false
        tornado.userData = ["damage":damage]
        //トルネードをシーンに追加
        addChild(tornado)
        //トルネードのアニメ作成と実行
        let Looptime = 1.0
        let anime = SKAction.animate(with: tornadeTexture, timePerFrame: Looptime / Double(number))
        let animeLoop = SKAction.repeatForever(anime)
        tornado.run(animeLoop)
        //効果音の設定
        DelayRun(time: 2.0 + tornadoC) { tornado.addChild(self.ReadAudioNode(named: "tornado", type: "mp3", Loop: true)) }
        tornadoC += 0.1
        
        //トルネードの動作作成
        var DC:CGFloat = -1.0; if Right{ DC = 1.0 }                 //向き補正係数
        let FPoint = tornado.position                               //初期位置
        let dx: CGFloat = 15                                        //x方向の変動値
        var dy: CGFloat = 3                                         //y方向の変動値
        if Loop == false { dy = 4 }
        
        let frametime: Double = 5.0                                 //1コマのアクション時間
        let Fwaittime: Double = 2.0                                 //初期待機時間
        let waittime: Double = 1.0                                  //始点、終点での待機時間
    
        var MoveAction:SKAction!                                    //竜巻の動作
        MoveAction = SKAction.run {
            //竜巻の経路の演算(ベジェ胸腺パス)
            var StartP = FPoint
            var mAction:SKAction!
            for n in 1 ... count{
                var Point: CGPoint!                                 //通過経路
                var MPoint: CGPoint!                                //ベジェ曲線の制御点
                let Xrandom = CGFloat( Int.random(in: -1 ... 1) )   //通過経路のランダム補正値(X)
                let Yrandom = CGFloat( Int.random(in: -1 ... 1) )   //通過経路のランダム補正値(Y)
                let XMrandom = CGFloat( Int.random(in: 2 ... Int(dx - 2.0) ) )   //制御点のランダム補正値(X)
                let YMrandom = CGFloat( Int.random(in: 0 ... Int(dy + Yrandom) ) )  //制御点のランダム補正値(X)
                if n % 2 == 0{ //偶数
                    //通過経路の計算
                    let Xpoint = FPoint.x + Xrandom * self.BSize
                    let Ypoint = FPoint.y - ( CGFloat(n) * dy + Yrandom ) * self.BSize
                    Point = CGPoint(x: Xpoint, y: Ypoint)
                }else{         //奇数
                    //通過経路の計算
                    let Xpoint = FPoint.x + ( dx + Xrandom ) * self.BSize * DC
                    let Ypoint = FPoint.y - ( CGFloat(n) * dy + Yrandom ) * self.BSize
                    Point = CGPoint(x: Xpoint, y: Ypoint)
                }
                //補正値の計算
                let XMpoint = FPoint.x + self.BSize * XMrandom * DC
                let YMpoint = Point.y - self.BSize * YMrandom
                MPoint = CGPoint(x: XMpoint, y: YMpoint)
                let Path = UIBezierPath()                               //竜巻の軌跡(二次ベジェ曲線)
                Path.move(to: StartP)                                   //パスを初期位置に移動
                Path.addQuadCurve(to: Point, controlPoint: MPoint)      //ベジェ曲線を作成
                StartP = Point
                let mAction1 = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: false, duration: frametime)
                mAction1.timingMode = SKActionTimingMode.easeInEaseOut
                if n == 1{ mAction = mAction1 }else{ mAction = SKAction.sequence([mAction,mAction1]) }
            }
            //アクションを実行
            let waitAction = SKAction.wait(forDuration: waittime)                       //動作開始、終了待機時間
            if Loop{
                tornado.position = FPoint                                                   //竜巻を初期位置に移動
                tornado.run(SKAction.sequence([waitAction,mAction,waitAction,MoveAction]))
            }else{
                let EndAction = SKAction.removeFromParent()
                tornado.run(SKAction.sequence([waitAction,mAction,EndAction]))
            }
            
            
        }
        let FWaitAction = SKAction.wait(forDuration: Fwaittime + DelayTime)     //初期待機アクション
        tornado.run(SKAction.sequence([FWaitAction,MoveAction]))                //アクションを実行
    }
    
    func ReadAudioNode(named:String,type:String,Loop:Bool) -> SKAudioNode{
        let SE = SKAudioNode(fileNamed: "SE/" + named + "." + type)
        SE.autoplayLooped = Loop
        return SE
    }
    
    func readTextureAnime(AtlasNamed:String ,imageNamed:String ,Number:Int) -> [SKTexture]{
        let Atlas = SKTextureAtlas(named: AtlasNamed)
        var ETexture: [SKTexture] = []
        for n in 1...Number{ ETexture.append( Atlas.textureNamed( imageNamed + String(n) ) ) }
        return ETexture
    }
    
    func DelayRun(time:Double, run:@escaping () -> Void){
        DispatchQueue.main.asyncAfter(deadline: .now() + time){
            run()
        }
    }
    
    //1¥アイスブロック追加
    func addiceBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat,Shapetype:Int,type:Int,Angle:CGFloat = 0.0,BlockNumber n: Int = 0){
        //ShapeType 1:二等辺三角形　 2:直角三角形(右が直角)   3:直角三角形(左が直角)   4:正方形      5:円
        //type      1:固定         2:重い（回転無効）緑　　  3:軽い（回転無効）黄     4;重い（回転有効）赤
        
        var iceBody: SKPhysicsBody!
        let OSize = CGSize(width: xs * BSize, height: ys * BSize)
        if Shapetype == 1{
            iceBody = CreatePolygonBody(Position: [[-50,-50],[0,50],[50,-50]], StandardSize: OSize)
        }else if Shapetype == 2{
            iceBody = CreatePolygonBody(Position: [[-50,-50],[50,50],[50,-50]], StandardSize: OSize)
        }else if Shapetype == 3{
            iceBody = CreatePolygonBody(Position: [[-50,-50],[-50,50],[50,-50]], StandardSize: OSize)
        }else if Shapetype == 4{
            iceBody = SKPhysicsBody(rectangleOf: OSize)
        }else{
            iceBody = CreateCircleBody(Size: 100, Position: [0,0], StandardSize: xs * BSize)
        }

        let iceBlock = SKSpriteNode(imageNamed: "iceBlock" + String(Shapetype))
        iceBlock.scale(to: OSize)
        iceBlock.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
        iceBlock.physicsBody = iceBody
        iceBlock.physicsBody?.categoryBitMask = block2Category
        iceBlock.physicsBody?.contactTestBitMask = block2CT
        iceBlock.physicsBody?.collisionBitMask = block2Co
        iceBlock.alpha = 0.7
        if type == 1{
            iceBlock.physicsBody?.isDynamic = false
        }else if type == 2{
            iceBlock.physicsBody?.isDynamic = true
            iceBlock.physicsBody?.affectedByGravity = false
            iceBlock.physicsBody?.allowsRotation = false
            iceBlock.physicsBody?.linearDamping = 0.9
            iceBlock.physicsBody?.angularDamping = 1.0
            iceBlock.physicsBody?.mass = 250.0
            iceBlock.colorBlendFactor = 0.2
            iceBlock.color = .green
        }else if type == 3{
            iceBlock.physicsBody?.isDynamic = true
            iceBlock.physicsBody?.affectedByGravity = false
            iceBlock.physicsBody?.allowsRotation = false
            iceBlock.physicsBody?.linearDamping = 0.5
            iceBlock.physicsBody?.angularDamping = 0.5
            iceBlock.physicsBody?.mass = 80.0
            iceBlock.colorBlendFactor = 0.2
            iceBlock.color = .yellow
        }else{
            iceBlock.physicsBody?.isDynamic = true
            iceBlock.physicsBody?.affectedByGravity = false
            iceBlock.physicsBody?.linearDamping = 0.9
            iceBlock.physicsBody?.angularDamping = 1.0
            iceBlock.physicsBody?.mass = 250.0
            iceBlock.colorBlendFactor = 0.2
            iceBlock.color = .red
        }
        
        iceBlock.zRotation = Angle * psita
        if n != 0{
            Block.append(iceBlock)
            BlockNumber[n] = Block.count
        }
        addChild(iceBlock)
    }
    
    //1¥ツララ追加
    func addicicle(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,damage:Int,type:Int){
        let Icicle = SKSpriteNode(imageNamed: "icicle")
        let IceSize = CGSize(width: BSize * xs, height: BSize *  ys)
        let IcePosition: [CGFloat] = [BSize / 2 + BSize * xp ,BSize / 2 + BSize * yp]
        Icicle.scale(to: IceSize)
        Icicle.position =  CGPoint(x: IcePosition[0] , y:IcePosition[1] )
        Icicle.physicsBody = CreatePolygonBody(Position: [[-50,50],[0,-50],[50,50]], StandardSize: IceSize)
        Icicle.physicsBody?.categoryBitMask = damageCategory
        Icicle.physicsBody?.contactTestBitMask = damageCT
        Icicle.physicsBody?.collisionBitMask = damageCo
        if type == 2{
            Icicle.physicsBody?.categoryBitMask = damage2Category
            Icicle.physicsBody?.contactTestBitMask = damage2CT
            Icicle.physicsBody?.collisionBitMask = damage2Co
            Icicle.alpha = 0.6
        }
        if type == 3{
            Icicle.colorBlendFactor = 0.8
            Icicle.color = .cyan
        }
        
        Icicle.physicsBody?.isDynamic = false
        Icicle.userData = ["damage":damage ,"fallflag":true,"PX":IcePosition[0],"PY":IcePosition[1],"type":1]
        if type != 3 { fallObject.append(Icicle) }
        addChild(Icicle)
    }
    
    //1¥ダメージブロック追加
    
    func addDamageBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,type:Int ,damage:Int,BlockNumber n: Int = 0,Angle:CGFloat = 0.0){
        let xn = Int(xs)
        let yn = Int(ys)
    
        var Pcon = true
        if type == 2 { Pcon = false }
        let Blockname: String = "damageblock" + String(type)
        
        let BlockSprite = SKSpriteNode(imageNamed: Blockname)
        BlockSprite.scale(to: CGSize(width: BSize * xs, height: BSize *  ys))
        BlockSprite.position = CGPoint(x: BSize / 2 * xs + BSize * xp, y: BSize / 2 * ys + BSize * yp)
        BlockSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: BSize * xs - BSize * 0.05, height: BSize * ys - BSize * 0.05))
        BlockSprite.zRotation = Angle * psita
        BlockSprite.physicsBody?.restitution = 0.1
        BlockSprite.physicsBody?.affectedByGravity = false
        BlockSprite.physicsBody?.isDynamic = false
        BlockSprite.physicsBody?.categoryBitMask = damageCategory
        BlockSprite.physicsBody?.contactTestBitMask = damageCT
        BlockSprite.physicsBody?.collisionBitMask = damageCo
        if Pcon == false{
            BlockSprite.physicsBody?.categoryBitMask = damage2Category
            BlockSprite.physicsBody?.contactTestBitMask = damage2CT
            BlockSprite.physicsBody?.collisionBitMask = damage2Co
        }
        BlockSprite.userData = ["damage":damage]
        if n != 0{
            Block.append(BlockSprite)
            BlockNumber[n] = self.Block.count
        }
        addChild(BlockSprite)
        
        
        if n != 0 || (xn < 5 && yn < 5){ //ブロックが何らかのアクションをする場合、またはブロックが小さい場合
            UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * xs, height: BSize * ys), false, 0.0)
            for yi in 0 ..< yn{
                for xi in 0 ..< xn{
                    if let block = UIImage(named: Blockname){
                        block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                    }
                }
            }
            let BlockImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            let BlockTexter = SKTexture(image: BlockImage)
            BlockSprite.run(SKAction.setTexture(BlockTexter))
        }else{//ブロックがアクションせず大きい場合
            BlockSprite.alpha = 0
            //ブロックテクスチャの作成
            let BlockPSize = 5
            let BPSize = CGFloat(BlockPSize)
            
            let xsn = xn / BlockPSize
            let ysn = yn / BlockPSize
            let xsfn = xn % BlockPSize
            let ysfn = yn % BlockPSize
            //x方向のブロック作成
            var BlockImage1: UIImage!
            var BlockImage2: UIImage!
            var BlockImage3: UIImage!
            var BlockImage4: UIImage!
            
            if xsn >= 1 && ysn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * BPSize, height: BSize * BPSize), false, 0.0)
                for yi in 0 ..< 5{
                    for xi in 0 ..< BlockPSize{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage1 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if ysn >= 1 && xsfn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * CGFloat(xsfn), height: BSize * BPSize), false, 0.0)
                for yi in 0 ..< BlockPSize{
                    for xi in 0 ..< xsfn{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage2 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if xsn >= 1 && ysfn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * BPSize, height: BSize * CGFloat(ysfn)), false, 0.0)
                for yi in 0 ..< ysfn{
                    for xi in 0 ..< BlockPSize{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage3 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if xsfn >= 1 && ysfn >= 1{
                UIGraphicsBeginImageContextWithOptions(CGSize(width: BSize * CGFloat(xsfn), height: BSize * CGFloat(ysfn)), false, 0.0)
                for yi in 0 ..< ysfn{
                    for xi in 0 ..< xsfn{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:BSize * CGFloat(xi), y: BSize * CGFloat(yi), width: BSize, height: BSize))
                        }
                    }
                }
                BlockImage4 = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            }
            
            if ysn == 0{
                let BlockSize1 = CGSize(width: BPSize * BSize, height: CGFloat(ysfn) * BSize)
                for xn in 0 ..< xsn{
                    let BlockPosition1 = CGPoint(x: (xp + BPSize / 2 + CGFloat(xn) * BPSize) * BSize, y: (yp + CGFloat(ysfn) / 2) * BSize )
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage3))
                    BSprite.scale(to: BlockSize1)
                    BSprite.position = BlockPosition1
                    addChild(BSprite)
                }
                if xsfn != 0{
                    let BlockSize2 = CGSize(width: CGFloat(xsfn) * BSize, height: CGFloat(ysfn) * BSize)
                    let BlockPosition2 = CGPoint(x: (xp + BPSize * CGFloat(xsn) + CGFloat(xsfn) / 2 ) * BSize, y: (yp + CGFloat(ysfn) / 2) * BSize)
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage4))
                    BSprite.scale(to: BlockSize2)
                    BSprite.position = BlockPosition2
                    addChild(BSprite)
                }
            }
            
            if xsn == 0{
                let BlockSize1 = CGSize(width: CGFloat(xsfn) * BSize, height: BPSize * BSize)
                for yn in 0 ..< ysn{
                    let BlockPosition1 = CGPoint(x: (xp + CGFloat(xsfn) / 2) * BSize, y: (yp + BPSize / 2 + CGFloat(yn) * BPSize) * BSize )
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage2))
                    BSprite.scale(to: BlockSize1)
                    BSprite.position = BlockPosition1
                    addChild(BSprite)
                }
                if ysfn != 0{
                    let BlockSize2 = CGSize(width: CGFloat(xsfn) * BSize, height: CGFloat(ysfn) * BSize)
                    let BlockPosition2 = CGPoint(x: (xp + CGFloat(xsfn) / 2) * BSize, y: (yp + BPSize * CGFloat(ysn) + CGFloat(ysfn) / 2 ) * BSize)
                    let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage4))
                    BSprite.scale(to: BlockSize2)
                    BSprite.position = BlockPosition2
                    addChild(BSprite)
                }
            }
            
            if xsn != 0 && ysn != 0{
                let BlockSize1 = CGSize(width: BPSize * BSize, height: BPSize * BSize)
                for yn in 0 ..< ysn{
                    for xn in 0 ..< xsn{
                        let BlockPosition1 = CGPoint(x: (xp + BPSize / 2 + CGFloat(xn) * BPSize) * BSize, y: (yp + BPSize / 2 + CGFloat(yn) * BPSize) * BSize )
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage1))
                        BSprite.scale(to: BlockSize1)
                        BSprite.position = BlockPosition1
                        addChild(BSprite)
                    }
                    if xsfn != 0{
                        let BlockSize2 = CGSize(width: CGFloat(xsfn) * BSize, height: BPSize * BSize)
                        let BlockPosition2 = CGPoint(x: (xp + BPSize * CGFloat(xsn) + CGFloat(xsfn) / 2 ) * BSize, y: (yp + BPSize / 2 + CGFloat(yn) * BPSize) * BSize)
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage2))
                        BSprite.scale(to: BlockSize2)
                        BSprite.position = BlockPosition2
                        addChild(BSprite)
                    }
                }
                
                if ysfn != 0{
                    let BlockSize3 = CGSize(width: BPSize * BSize, height: CGFloat(ysfn) * BSize)
                    for xn in 0 ..< xsn{
                        let BlockPosition3 = CGPoint(x: (xp + BPSize / 2 + CGFloat(xn) * BPSize) * BSize, y: (yp + BPSize * CGFloat(ysn) + CGFloat(ysfn) / 2 ) * BSize )
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage3))
                        BSprite.scale(to: BlockSize3)
                        BSprite.position = BlockPosition3
                        addChild(BSprite)
                    }
                    if xsfn != 0{
                        let BlockSize4 = CGSize(width: CGFloat(xsfn) * BSize, height: CGFloat(ysfn) * BSize)
                        let BlockPosition4 = CGPoint(x: (xp + BPSize * CGFloat(xsn) + CGFloat(xsfn) / 2 ) * BSize, y: (yp + BPSize * CGFloat(ysn) + CGFloat(ysfn) / 2 ) * BSize )
                        let BSprite = SKSpriteNode(texture: SKTexture(image: BlockImage4))
                        BSprite.scale(to: BlockSize4)
                        BSprite.position = BlockPosition4
                        addChild(BSprite)
                    }
                }
            }
        }
    }
    
    //1¥ブロックオブジェクト追加
    func addBlockO(xp: CGFloat, yp:CGFloat ,Size:CGFloat,type:Int,BloclNumber n: Int = 0,Angle:CGFloat = 0.0){
        let BlockO = SKSpriteNode(imageNamed: "BlockO" + String(type))
        let OSize = BSize * Size
        BlockO.scale(to: CGSize(width: OSize, height: OSize))
        BlockO.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
        if       type == 1{
            BlockO.physicsBody = CreateSquareBody(Size: [84,25.4], Position: [0,-1.3], StandardSize: OSize)
            BlockO.physicsBody?.categoryBitMask = block2Category
            BlockO.physicsBody?.contactTestBitMask = block2CT
            BlockO.physicsBody?.collisionBitMask = block2Co
            BlockO.physicsBody?.affectedByGravity = false
            BlockO.physicsBody?.allowsRotation = false
            BlockO.physicsBody?.linearDamping = 0.9
            BlockO.physicsBody?.angularDamping = 1.0
            BlockO.physicsBody?.mass = 250.0
        }else if type == 2{
            BlockO.physicsBody = CreateSquareBody(Size: [8,85], Position: [0,-7.5], StandardSize: OSize)
            BlockO.physicsBody?.categoryBitMask = blockCategory
            BlockO.physicsBody?.contactTestBitMask = blockCT
            BlockO.physicsBody?.collisionBitMask = blockCo
            BlockO.physicsBody?.isDynamic = false
        }else if type == 3{
            let Bbody1 = CreateSquareBody(Size: [49.6,17.4], Position: [-14.1,-2.7], StandardSize: OSize)
            let Bbody2 = CreatePolygonBody(Position: [[-40.4,5],[-43.8,18.4],[-40.4,18.6],[-36.4,5.2]], StandardSize: OSize)
            let Bbody3 = CreatePolygonBody(Position: [[5.6,5.2],[13,22.6],[18.6,22.6],[12.2,4.8]], StandardSize: OSize)
            BlockO.physicsBody = SKPhysicsBody(bodies: [Bbody1,Bbody2,Bbody3])
            BlockO.physicsBody?.categoryBitMask = block2Category
            BlockO.physicsBody?.contactTestBitMask = block2CT
            BlockO.physicsBody?.collisionBitMask = block2Co
            BlockO.physicsBody?.affectedByGravity = false
            BlockO.physicsBody?.linearDamping = 0.5
            BlockO.physicsBody?.angularDamping = 1.0
            BlockO.physicsBody?.mass = 20.0
        }else if type == 4{
            let Bbody1 = CreateSquareBody(Size: [8,85] ,Position:[-22.8,-7.5], StandardSize:OSize )
            let Bbody2 = CreatePolygonBody(Position: [[-17.6,0],[-17.6,8.4],[33.6,15.6],[33.6,7]], StandardSize: OSize)
            BlockO.physicsBody = SKPhysicsBody(bodies: [Bbody1,Bbody2])
            BlockO.physicsBody?.categoryBitMask = blockCategory
            BlockO.physicsBody?.contactTestBitMask = blockCT
            BlockO.physicsBody?.collisionBitMask = blockCo
            BlockO.physicsBody?.isDynamic = false
        }else if type == 5{
            let Bbody1 = CreateSquareBody(Size: [8,85] ,Position:[22.8,-7.5], StandardSize:OSize )
            let Bbody2 = CreatePolygonBody(Position: [[17.6,0],[17.6,8.4],[-33.6,15.6],[-33.6,7]], StandardSize: OSize)
            BlockO.physicsBody = SKPhysicsBody(bodies: [Bbody1,Bbody2])
            BlockO.physicsBody?.categoryBitMask = blockCategory
            BlockO.physicsBody?.contactTestBitMask = blockCT
            BlockO.physicsBody?.collisionBitMask = blockCo
            BlockO.physicsBody?.isDynamic = false
        }else if type == 6{
            BlockO.physicsBody = CreateSquareBody(Size: [84,25.4], Position: [0,-1.3], StandardSize: OSize)
            BlockO.physicsBody?.categoryBitMask = block2Category
            BlockO.physicsBody?.contactTestBitMask = block2CT
            BlockO.physicsBody?.collisionBitMask = block2Co
            BlockO.physicsBody?.affectedByGravity = false
            BlockO.physicsBody?.linearDamping = 0.9
            BlockO.physicsBody?.angularDamping = 1.0
            BlockO.physicsBody?.mass = 250.0
        }else if type == 7{
            BlockO.physicsBody = CreateSquareBody(Size: [84,25.4], Position: [0,-1.3], StandardSize: OSize)
            BlockO.physicsBody?.categoryBitMask = block2Category
            BlockO.physicsBody?.contactTestBitMask = block2CT
            BlockO.physicsBody?.collisionBitMask = block2Co
            BlockO.physicsBody?.affectedByGravity = false
            BlockO.physicsBody?.allowsRotation = false
            BlockO.physicsBody?.linearDamping = 0.9
            BlockO.physicsBody?.angularDamping = 1.0
            BlockO.physicsBody?.mass = 100.0
        }else if type == 8{
            let Bbody1 = CreateSquareBody(Size: [49.6,17.4], Position: [14.1,-2.7], StandardSize: OSize)
            let Bbody2 = CreatePolygonBody(Position: [[40.4,5],[43.8,18.4],[40.4,18.6],[36.4,5.2]], StandardSize: OSize)
            let Bbody3 = CreatePolygonBody(Position: [[-5.6,5.2],[-13,22.6],[-18.6,22.6],[-12.2,4.8]], StandardSize: OSize)
            BlockO.physicsBody = SKPhysicsBody(bodies: [Bbody1,Bbody2,Bbody3])
            BlockO.physicsBody?.categoryBitMask = block2Category
            BlockO.physicsBody?.contactTestBitMask = block2CT
            BlockO.physicsBody?.collisionBitMask = block2Co
            BlockO.physicsBody?.affectedByGravity = false
            BlockO.physicsBody?.linearDamping = 0.5
            BlockO.physicsBody?.angularDamping = 0.5
            BlockO.physicsBody?.mass = 20.0
        }else if type == 9{
            BlockO.physicsBody = CreatePolygonBody(Position: [[-46,-6.2],[-45,15],[45.2,14.4],[45.4,6.2],[9.6,-23.6]], StandardSize: OSize)
            BlockO.physicsBody?.categoryBitMask = blockCategory
            BlockO.physicsBody?.contactTestBitMask = blockCT
            BlockO.physicsBody?.collisionBitMask = blockCo
            BlockO.physicsBody?.isDynamic = false
            BlockO.zPosition = -10
        }else if type == 10{
            let Bbody1 = CreateSquareBody(Size: [10,68], Position: [-42,-13], StandardSize: OSize)
            let Bbody2 = CreateSquareBody(Size: [10,68], Position: [42,-13], StandardSize: OSize)
            let Bbody3 = CreateSquareBody(Size: [94,21], Position: [0,-36.5], StandardSize: OSize)
            BlockO.physicsBody = SKPhysicsBody(bodies: [Bbody1,Bbody2,Bbody3])
            BlockO.physicsBody?.categoryBitMask = blockCategory
            BlockO.physicsBody?.contactTestBitMask = blockCT
            BlockO.physicsBody?.collisionBitMask = blockCo
            BlockO.physicsBody?.linearDamping = 0.9
            BlockO.physicsBody?.angularDamping = 1.0
            BlockO.physicsBody?.mass = 250.0
            BlockO.alpha = 0.9
        }else if type == 11{
            let Bbody1 = CreateSquareBody(Size: [78,12], Position: [0,-16], StandardSize: OSize)
            let Bbody2 = CreatePolygonBody(Position: [[-38,-18],[-47,22],[-37,22],[-28,-18]], StandardSize: OSize)
            let Bbody3 = CreatePolygonBody(Position: [[38,-18],[47,22],[37,22],[28,-18]], StandardSize: OSize)
            BlockO.physicsBody = SKPhysicsBody(bodies: [Bbody1,Bbody2,Bbody3])
            BlockO.physicsBody?.categoryBitMask = block2Category
            BlockO.physicsBody?.contactTestBitMask = block2CT
            BlockO.physicsBody?.collisionBitMask = block2Co
            BlockO.physicsBody?.affectedByGravity = false
            BlockO.physicsBody?.linearDamping = 0.5
            BlockO.physicsBody?.angularDamping = 0.5
            BlockO.physicsBody?.mass = 20.0
            BlockO.alpha = 0.9
        }else if type == 12{
            
        }else if type == 13{
            
        }else{
            BlockO.physicsBody = CreateSquareBody(Size: [84,25.4], Position: [0,-1.3], StandardSize: OSize)
            BlockO.physicsBody?.categoryBitMask = blockCategory
            BlockO.physicsBody?.contactTestBitMask = blockCT
            BlockO.physicsBody?.collisionBitMask = blockCo
            BlockO.physicsBody?.isDynamic = false
        }
        BlockO.zRotation = Angle * psita
        addChild(BlockO)
        if n != 0{
            Block.append(BlockO)
            BlockNumber[n] = Block.count
        }
    }

//1¥ブロックアクションオブジェクトの追加
    func addActionBlockO(xp: CGFloat, yp:CGFloat ,Size:CGFloat,type:Int,time:[Double],BlockNumber n1:Int = 0 ,Actiontype:Int = 1 ){
        let OSize = BSize * Size
        var playAction:SKAction!
        var Object: SKSpriteNode!
        if type == 1{
            let time1 = time[0] //岩が消失するまでの時間
            let time2 = time[1] //岩を出現させる間隔
            
            Object = SKSpriteNode(imageNamed: "block1")
            Object.scale(to: CGSize(width: BSize, height: BSize))
            Object.position = CGPoint(x: xp * self.BSize + self.BSize / 2 , y: yp * self.BSize + self.BSize / 2)
            Object.alpha = 0
            addChild(Object)
            
            let CreateAction = SKAction.run {
                let BlockO1 = SKSpriteNode(imageNamed: "ActionBlockO" + String(type))
                BlockO1.scale(to: CGSize(width: OSize, height: OSize))
                BlockO1.position = Object.position
                BlockO1.physicsBody = self.CreateCircleBody(Size: 83, Position: [0,2.3], StandardSize: OSize)
                BlockO1.physicsBody?.categoryBitMask = self.block3Category
                BlockO1.physicsBody?.contactTestBitMask = self.block3CT
                BlockO1.physicsBody?.collisionBitMask = self.block3Co
                BlockO1.physicsBody?.linearDamping = 0.9
                BlockO1.physicsBody?.angularDamping = 0.9
                BlockO1.physicsBody?.mass = 400.0
                self.addChild(BlockO1)
                self.run(SKAction.wait(forDuration: time1)){ BlockO1.removeFromParent() }
            }
            let waitAction = SKAction.wait(forDuration: time2)
            playAction = SKAction.repeatForever(SKAction.sequence([CreateAction,waitAction]))
        }
        if n1 != 0{
            Object.run(playAction, withKey: "i\(n1)")
            Block.append(Object)
            BlockNumber[n1] = Block.count
            Object.userData =  ["statas":Actiontype]
            if Actiontype == 2{
                self.run(SKAction.wait(forDuration: 0.5)){
                    if let Action = Object.action(forKey: "i\(n1)"){
                        Action.speed = 0
                    }
                }
            }
        }else{
            Object.run(playAction)
        }
    }
    
    //1¥ダメージオブジェクトの追加
    func addDamageO(xp: CGFloat, yp:CGFloat,Size:CGFloat,type:Int,damage:Int,BloclNumber n: Int = 0,Angle:CGFloat = 0.0){
        let OSize = Size * BSize
        var DamageO: SKSpriteNode!
        
        if 1 <= type && type <= 7{
            DamageO = SKSpriteNode(imageNamed: "damageO" + String(type))
            DamageO.scale(to: CGSize(width: OSize, height: OSize))
            DamageO.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
            if       type == 1{
                DamageO.physicsBody = CreateCircleBody(Size: 72, Position: [0,0], StandardSize: OSize)
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }else if type == 2{
                let Obody1 = CreateSquareBody(Size: [16,80], Position: [0,0], StandardSize: OSize)
                let Obody2 = CreateCircleBody(Size: 16, Position: [0,40], StandardSize: OSize)
                let Obody3 = CreateCircleBody(Size: 16, Position: [0,-40], StandardSize: OSize)
                DamageO.physicsBody = SKPhysicsBody(bodies: [Obody1,Obody2,Obody3])
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }else if type == 3{
                let Obody1 = CreateSquareBody(Size: [8,88], Position: [0,0], StandardSize: OSize)
                let Obody2 = CreateCircleBody(Size: 8, Position: [0,44], StandardSize: OSize)
                let Obody3 = CreateCircleBody(Size: 8, Position: [0,-44], StandardSize: OSize)
                DamageO.physicsBody = SKPhysicsBody(bodies: [Obody1,Obody2,Obody3])
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }else if type == 4{
                let Obody1 = CreateSquareBody(Size: [16,80], Position: [0,0], StandardSize: OSize)
                let Obody2 = CreateCircleBody(Size: 16, Position: [0,40], StandardSize: OSize)
                let Obody3 = CreateCircleBody(Size: 16, Position: [0,-40], StandardSize: OSize)
                DamageO.physicsBody = SKPhysicsBody(bodies: [Obody1,Obody2,Obody3])
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }else if type == 5{
                let Obody1 = CreateSquareBody(Size: [8,88], Position: [0,0], StandardSize: OSize)
                let Obody2 = CreateCircleBody(Size: 8, Position: [0,44], StandardSize: OSize)
                let Obody3 = CreateCircleBody(Size: 8, Position: [0,-44], StandardSize: OSize)
                DamageO.physicsBody = SKPhysicsBody(bodies: [Obody1,Obody2,Obody3])
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }else if type == 6{
                let Obody1 = CreateSquareBody(Size: [16,38], Position: [0,19], StandardSize: OSize)
                let Obody2 = CreateCircleBody(Size: 16, Position: [0,38], StandardSize: OSize)
                let Obody3 = CreateCircleBody(Size: 16, Position: [0,0], StandardSize: OSize)
                DamageO.physicsBody = SKPhysicsBody(bodies: [Obody1,Obody2,Obody3])
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }else if type == 7{
                let Obody1 = CreateSquareBody(Size: [8,44], Position: [0,22], StandardSize: OSize)
                let Obody2 = CreateCircleBody(Size: 8, Position: [0,44], StandardSize: OSize)
                let Obody3 = CreateCircleBody(Size: 8, Position: [0,0], StandardSize: OSize)
                DamageO.physicsBody = SKPhysicsBody(bodies: [Obody1,Obody2,Obody3])
                DamageO.physicsBody?.categoryBitMask = damageCategory
                DamageO.physicsBody?.contactTestBitMask = damageCT
                DamageO.physicsBody?.collisionBitMask = damageCo
                DamageO.physicsBody?.isDynamic = false
            }
            DamageO.zRotation = Angle * psita
            DamageO.userData = ["damage":damage]
            addChild(DamageO)
            
        }else if 8 <= type{
            let TAtlas = SKTextureAtlas(named: "damageO" + String(type))                    //テクスチャアトラスの作成
            let objectP = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
    
            var animetime: Double!                                                          //アニメの１サイクルの時間
            var Ecount: Int!                                                                //アニメのかコマ数
            var Bbody: SKPhysicsBody!                                                       //物理ボディ
            
            if type == 8 {
                animetime = 1.0
                Ecount = 5
                Bbody = CreateCircleBody(Size:65, Position: [0,0], StandardSize: OSize)
            }else if type == 9 {
                animetime = 1.0
                Ecount = 5
                Bbody = CreateCircleBody(Size:20, Position: [0,-40], StandardSize: OSize)
            }else{
                animetime = 1.0
                Ecount = 5
                Bbody = CreateCircleBody(Size:20, Position: [0,-40], StandardSize: OSize)
            }
            
            var Otexture: [SKTexture] = []
            for n in 1...Ecount{ Otexture.append( TAtlas.textureNamed("damageO" + String(type) + "_" + String(n) ) ) }
            DamageO = EffectObject(P: objectP, Size: OSize, Effect: Otexture, Ebody: Bbody, time: animetime, Endtime: 0.0, damage: damage)
            DamageO.zRotation = Angle * psita
    
        }
       
        if n != 0{
            Block.append(DamageO)
            BlockNumber[n] = Block.count
        }
        
    }
    

  
    //1¥スイッチ追加
    func addONSwitch(xp:CGFloat,yp:CGFloat,BloclNumber n: Int = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "ONSwitch")
        let OSize = BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = SKPhysicsBody(circleOfRadius: BSize / 2)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.userData = ["type":2,"number":1]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    func addOFFSwitch(xp:CGFloat,yp:CGFloat,BloclNumber n: Int = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "OFFSwitch")
        let OSize = BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = SKPhysicsBody(circleOfRadius: BSize / 2)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.userData = ["type":2,"number":2]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    
    func addSwitch(xp:CGFloat,yp:CGFloat,SwitchNumber:Int,BloclNumber n: Int = 0,Angle:CGFloat = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "Switch1")
        let OSize = 2 * BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = CreateSquareBody(Size: [80,85], Position: [0,-7.5], StandardSize: OSize)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.zRotation = Angle * psita
        Switch.userData = ["type":1,"number":1,"switch":SwitchNumber]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    
    
    func addSwitch(xp:CGFloat,yp:CGFloat,SwitchNumber:[Int],BloclNumber n: Int = 0,Angle:CGFloat = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "Switch1")
        let OSize = 2 * BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = CreateSquareBody(Size: [80,85], Position: [0,-7.5], StandardSize: OSize)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.zRotation = Angle * psita
        Switch.userData = ["type":1,"number":2,"switch":SwitchNumber]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    func addSwitch(xp:CGFloat,yp:CGFloat,SwitchNumberA:Int,SwitchNumberB:Int,BloclNumber n: Int = 0,Angle:CGFloat = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "Switch3")
        let OSize = 2 * BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = CreateSquareBody(Size: [80,85], Position: [0,-7.5], StandardSize: OSize)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.zRotation = Angle * psita
        Switch.userData = ["type":1,"number":3,"switchA":SwitchNumberA,"switchB":SwitchNumberB,"statas":2]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    func addSwitch(xp:CGFloat,yp:CGFloat,SwitchNumberA:[Int],SwitchNumberB:[Int],BloclNumber n: Int = 0,Angle:CGFloat = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "Switch3")
        let OSize = 2 * BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = CreateSquareBody(Size: [80,85], Position: [0,-7.5], StandardSize: OSize)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.zRotation = Angle * psita
        Switch.userData = ["type":1,"number":4,"switchA":SwitchNumberA,"switchB":SwitchNumberB,"statas":2]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    func addSwitch(xp:CGFloat,yp:CGFloat,SwitchNumberA:[Int],SwitchNumberB:Int,BloclNumber n: Int = 0,Angle:CGFloat = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "Switch3")
        let OSize = 2 * BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = CreateSquareBody(Size: [80,85], Position: [0,-7.5], StandardSize: OSize)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.zRotation = Angle * psita
        Switch.userData = ["type":1,"number":5,"switchA":SwitchNumberA,"switchB":SwitchNumberB,"statas":2]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    func addSwitch(xp:CGFloat,yp:CGFloat,SwitchNumberA:Int,SwitchNumberB:[Int],BloclNumber n: Int = 0,Angle:CGFloat = 0){
        let Switch: SKSpriteNode = SKSpriteNode(imageNamed: "Switch3")
        let OSize = 2 * BSize
        Switch.size = CGSize(width:  OSize, height: OSize)
        Switch.position = CGPoint(x: BSize * xp + BSize / 2, y: BSize * yp + BSize / 2)
        Switch.physicsBody = CreateSquareBody(Size: [80,85], Position: [0,-7.5], StandardSize: OSize)
        Switch.physicsBody?.categoryBitMask = SwitchCategory
        Switch.physicsBody?.contactTestBitMask = SwitchCT
        Switch.physicsBody?.collisionBitMask = SwitchCo
        Switch.physicsBody?.isDynamic = false
        Switch.zRotation = Angle * psita
        Switch.userData = ["type":1,"number":6,"switchA":SwitchNumberA,"switchB":SwitchNumberB,"statas":2]
        addChild(Switch)
        if n != 0{
            Block.append(Switch)
            BlockNumber[n] = Block.count
        }
    }
    //1¥物理ボディ作成用関数
    func CreateSquareBody(Size:[CGFloat],Position:[CGFloat],StandardSize SS:CGFloat) -> SKPhysicsBody {
        let SquareSize = CGSize(width: Size[0] / 100.0 * SS , height: Size[1] / 100.0 * SS)
        let SquarePosition = CGPoint(x: Position[0] / 100.0 * SS, y: Position[1] / 100.0 * SS)
        let SBody = SKPhysicsBody(rectangleOf: SquareSize, center: SquarePosition)
        return SBody
    }
    func CreateSquareBody(Size:[CGFloat],Position:[CGFloat],StandardSize SS: CGSize) -> SKPhysicsBody {
        let SquareSize = CGSize(width: Size[0] / 100.0 * SS.width , height: Size[1] / 100.0 * SS.height)
        let SquarePosition = CGPoint(x: Position[0] / 100.0 * SS.width, y: Position[1] / 100.0 * SS.height)
        let SBody = SKPhysicsBody(rectangleOf: SquareSize, center: SquarePosition)
        return SBody
    }
    func CreatePolygonBody(Position PP:[[CGFloat]],StandardSize SS:CGFloat) -> SKPhysicsBody {
        var Path: [CGPoint] = []
        for n in 0 ..< PP.count{ Path.append(CGPoint(x: SS * PP[n][0] / 100.0, y: SS * PP[n][1] / 100.0 ) ) }
        let MPath = CGMutablePath()
        MPath.addLines(between: Path)
        let Bbody = SKPhysicsBody(polygonFrom: MPath)
        return Bbody
    }
    
    func CreatePolygonBody(Position PP:[[CGFloat]],StandardSize SS:CGSize) -> SKPhysicsBody {
        var Path: [CGPoint] = []
        for n in 0 ..< PP.count{ Path.append(CGPoint(x: SS.width * PP[n][0] / 100.0, y: SS.height * PP[n][1] / 100.0 ) ) }
        let MPath = CGMutablePath()
        MPath.addLines(between: Path)
        let Bbody = SKPhysicsBody(polygonFrom: MPath)
        return Bbody
    }

    func CreateCircleBody(Size:CGFloat,Position:[CGFloat],StandardSize SS:CGFloat) -> SKPhysicsBody {
        let CircleSize: CGFloat = SS * Size / 200.0
        let CirclePosition = CGPoint(x: Position[0] / 100.0 * SS, y: Position[1] / 100.0 * SS)
        let CBody = SKPhysicsBody(circleOfRadius: CircleSize, center: CirclePosition)
        return CBody
    }
    
    //1¥川の作成
    func addWater(xp :CGFloat,yp :CGFloat,Size:Int,Pattern:Int,type:Int = 1){
        addDamageBlock(xp: xp, yp: yp, xs: 10 * CGFloat(Size), ys: 1, type: 1, damage: 1000)
        
     //   let DamageBlock = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
     //   DamageBlock.alpha = 0
     //   DamageBlock.position
        
        let Sx: CGFloat = BSize * 10
        let Sy: CGFloat = BSize * 6
        let Fdx: CGFloat = (5 + xp) * BSize
        let Fdy: CGFloat = (3 + yp) * BSize
        let dx: CGFloat = 10 * BSize
        let dy: CGFloat = 6 * BSize
        
        
        if Pattern == 2{
            for xn in 1...Size{
                let yc = Size + 2 - xn
                for yn in 1...yc{
                    var water: SKSpriteNode!
                    var Bbody:SKPhysicsBody!
                    if  yn == yc{ water = SKSpriteNode(imageNamed: "water" + String(type) + "_1") }
                    else{ water = SKSpriteNode(imageNamed: "water" + String(type) + "_2") }
                    water.scale(to: CGSize(width: Sx, height: Sy))
                    water.position = CGPoint(x: Fdx + dx * CGFloat(xn - 1), y: Fdy + dy * CGFloat(yn - 1))
                    if yn == 1 && xn == 1{
                        let x0 = -Sx / 2
                        let y0 = -Sy / 2
                        let xl = x0 + Sx * CGFloat(Size)
                        let yl = y0 + Sy * CGFloat(Size + 1)
                        let MPath = CGMutablePath()
                        MPath.addLines(between: [CGPoint(x: x0, y: y0)
                                                ,CGPoint(x: x0, y: yl)
                                                ,CGPoint(x: xl, y: y0 + Sy)
                                                ,CGPoint(x: xl, y: y0)])
                        Bbody = SKPhysicsBody(polygonFrom: MPath)
                        water.physicsBody = Bbody
                        water.physicsBody?.categoryBitMask = charaBCategory
                        water.physicsBody?.contactTestBitMask = charaBCT
                        water.physicsBody?.collisionBitMask = charaBCo
                        water.physicsBody?.isDynamic = false
                    }
                    water.zPosition = 1
                    addChild(water)
                }
            }
        }else if Pattern == 3{
            for xn in 1...Size{
                let yc = 1 + xn
                for yn in 1...yc{
                    var water: SKSpriteNode!
                    var Bbody:SKPhysicsBody!
                    if  yn == yc{ water = SKSpriteNode(imageNamed: "water" + String(type) + "_3") }
                    else{ water = SKSpriteNode(imageNamed: "water" + String(type) + "_4") }
                    water.scale(to: CGSize(width: Sx, height: Sy))
                    water.position = CGPoint(x: Fdx + dx * CGFloat(xn - 1), y: Fdy + dy * CGFloat(yn - 1))
                    if yn == 1 && xn == 1{
                        let x0 = -Sx / 2
                        let y0 = -Sy / 2
                        let xl = x0 + Sx * CGFloat(Size)
                        let yl = y0 + Sy * CGFloat(Size + 1)
                        let MPath = CGMutablePath()
                        MPath.addLines(between: [CGPoint(x: x0, y: y0)
                                                ,CGPoint(x: x0, y: y0 + Sy)
                                                ,CGPoint(x: xl, y: yl)
                                                ,CGPoint(x: xl, y: y0)])
                        Bbody = SKPhysicsBody(polygonFrom: MPath)
                        water.physicsBody = Bbody
                        water.physicsBody?.categoryBitMask = charaBCategory
                        water.physicsBody?.contactTestBitMask = charaBCT
                        water.physicsBody?.collisionBitMask = charaBCo
                        water.physicsBody?.isDynamic = false
                    }
                    water.zPosition = 1
                    addChild(water)
                }
            }
        }else{
            for n in 1...Size{
                let water = SKSpriteNode(imageNamed: "water" + String(type) + "_2")
                water.position = CGPoint(x: Fdx + dx * CGFloat(n - 1), y: Fdy)
                water.scale(to: CGSize(width: Sx, height: Sy))
                if n == 1{
                    let S = CGFloat(Size)
                    water.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: Sx * S, height: Sy), center: CGPoint(x: (S - 1) * Sx / 2, y: 0))
                    water.physicsBody?.categoryBitMask = charaBCategory
                    water.physicsBody?.contactTestBitMask = charaBCT
                    water.physicsBody?.collisionBitMask = charaBCo
                    water.physicsBody?.isDynamic = false
                }
                water.zPosition = 1
                addChild(water)
            }
        }
        
    }
    
    //1¥矢印追加
    func addvector(xp: CGFloat, yp:CGFloat , Angle:CGFloat ,Size:CGFloat){
        let vector = SKSpriteNode(imageNamed: "vector")
        vector.scale(to: CGSize(width: BSize * Size, height: BSize * Size))
        vector.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
        vector.zRotation = Angle * psita
        vector.zPosition = -20
        addChild(vector)
    }
    
    //1¥ステージ切り替えオブジェクトの追加
    func addmoveStageO(xp: CGFloat, yp:CGFloat ,Size:CGFloat ,moveStageN:Int,moveSceneN:Int ,type:Int,BloclNumber n: Int = 0,Angle:CGFloat = 0.0){
        let OSize = BSize * Size                                //オブジェクトのサイズ
        //読み込むテクスチャナンバー
        var typeN = type
        if type == 101 || type == 102 { typeN = type - 100 }
        if type == 41 { typeN = 40 }
        if type == 29 { typeN = 28 }
        
        //スプライトの作成
        let moveO = SKSpriteNode(imageNamed: "moveO" + String(typeN))
        moveO.scale(to: CGSize(width: OSize, height: OSize))
        moveO.position = CGPoint(x: xp * BSize + BSize / 2 , y: yp * BSize + BSize / 2)
        
        //物理ボディの設定
        var Bbody: SKPhysicsBody!
        if          (1 <= type && type <= 4) || typeN == 23 || typeN == 24 || (101 <= type && type <= 104) {  //看板　矢印
            let Bbody1 = CreateSquareBody(Size: [84,21], Position: [0,16.5], StandardSize: OSize)
            let Bbody2 = CreateSquareBody(Size: [14,96], Position: [-3,-2], StandardSize: OSize)
            Bbody = SKPhysicsBody(bodies: [Bbody1,Bbody2])
        }else if    type == 5 || type == 50{ //家
            Bbody = CreatePolygonBody(Position: [[-36,-50],[-36,10],[0,40],[36,10],[36,-50]], StandardSize: OSize)
        }else if    type == 6{ //草
            Bbody = CreateSquareBody(Size: [100,32], Position: [0,-34], StandardSize: OSize)
        }else if    7 <= type && type <= 20 || 51 <= type && type <= 56{ //ボス扉
            Bbody = CreateSquareBody(Size: [62,80], Position: [-1,-10], StandardSize: OSize)
        }else if    type == 21{ //木
            Bbody = CreateSquareBody(Size: [58,32], Position: [-11,-22], StandardSize: OSize)
        }else if    type == 22{ //洞窟
            Bbody = CreatePolygonBody(Position: [[-50,-50],[-30,12],[30,40],[50,-50]], StandardSize: OSize)
        }else if    type == 25{ //火山
            Bbody = CreatePolygonBody(Position: [[-50,-50],[12,12],[50,-50]], StandardSize: OSize)
        }else if    type == 26{ //雪山R
            Bbody = CreatePolygonBody(Position: [[-50,-50],[-50,28],[40,-34],[40,-50]], StandardSize: OSize)
        }else if    type == 27{ //雪山L
            Bbody = CreatePolygonBody(Position: [[50,-50],[50,28],[-40,-34],[-40,-50]], StandardSize: OSize)
        }else if    type == 28 || type == 29{ //ワープゲート
            Bbody = CreateCircleBody(Size: 100, Position: [0,0], StandardSize: OSize)
        }else if    type == 30{ //雲
            Bbody = CreatePolygonBody(Position: [[-39,-31],[-44,-14],[10,40],[44,-16]], StandardSize: OSize)
        }else if    type == 31{ //研究
            
        }else if    type == 32  || type == 41{ //扉
            Bbody = CreateSquareBody(Size: [55,95], Position: [0,0], StandardSize: OSize)
        }else{
            Bbody = SKPhysicsBody(rectangleOf: CGSize(width: OSize, height: OSize))
        }
        
        //物理ボディの作成
        moveO.physicsBody = Bbody
        moveO.zRotation = Angle * psita
        moveO.physicsBody?.categoryBitMask = moveCategory
        moveO.physicsBody?.contactTestBitMask = moveCT
        moveO.physicsBody?.collisionBitMask = moveCo
        moveO.physicsBody?.isDynamic = false
        
        //ステージステージの設定
        moveO.userData = ["StageN":moveStageN,"SceneN":moveSceneN]
        
        //オブジェクトの着色
        if type == 40 {
            moveO.colorBlendFactor = 0.3
            moveO.color = .red
        }
        if type == 101 || type == 102{
            moveO.color = .black
            moveO.colorBlendFactor = 0.7
        }
        if type == 29{
            moveO.color = .yellow
            moveO.colorBlendFactor = 1.0
        }
        
        //シーンにオブジェクトの追加
        addChild(moveO)
        
        //オブジェクトにアクションを設定するか
        if n != 0{
            Block.append(moveO)
            BlockNumber[n] = Block.count
        }
        
        //看板にステージ番号を表示
        if (1 <= type && type <= 4) || (101 <= type && type <= 104) && moveSceneN == 0 && moveStageN >= 1{
            let textFontSize: CGFloat = 21          //文字のサイズ(看板サイズ基準)100で看板サイズと同い
            let textPosition: [CGFloat] = [0,10.5]    //文字の位置(看板サイズ基準)100で看板サイズと同い
            
            //表示する文字の設定
            var StageNumberText:String!
            if moveStageN <= 70{            //通常ステージ
                if moveStageN <= 5{         //第一エリア
                    StageNumberText = "1-\(moveStageN)"
                }else{                      //それ以外
                    let ss = moveStageN - 6
                    let s1 = ss / 7 + 2
                    let s2 = ss % 7
                    StageNumberText = "\(s1)-\(s2)"
                }
            }else if moveStageN >= 100{     //隠しステージ
                let ss = moveStageN - 99
                StageNumberText = "S-\(ss)"
            }
            
            var textPx = textPosition[0]
            let textPy = textPosition[1]
            
            if type % 2 == 0{
                textPx = -textPx
            }
            
            let StageLabel = SKLabelNode(text: StageNumberText)
            StageLabel.position = CGPoint(x: moveO.position.x + OSize * textPx / 100, y: moveO.position.y + OSize * textPy / 100)
            StageLabel.fontSize = OSize / 100 * textFontSize
            StageLabel.fontName = "Ronde-B"
            StageLabel.color = .white
            StageLabel.verticalAlignmentMode = .center
            StageLabel.horizontalAlignmentMode = .center
            addChild(StageLabel)
        }
    }

    //1¥プレイヤー作成
    func addplayer(px:CGFloat ,py:CGFloat, DFlag: Bool = true){
        //変換する係数の作成
        PSize = playerSize * SSize                         //各部品のサイズ(胴体を除く)
        let bodysize: [CGFloat] = [PSize * 3, PSize * 1.4] //胴体のサイズ
        let Pcx = px * BSize  ;let Pcy = py * BSize        //プレイヤーの中心位置
        PraRPoint = CGPoint(x: Pcx, y: Pcy)
        var legD: [CGFloat] = [0.20 ,0.24]         // 足の関節距離
        var taleD: [CGFloat] = [0.16 ,0.12 ,0.22]  // 尻尾
        var bodyD: CGFloat = 0.70                  // 前足、後足の距離
        
        var OUSensorSize: [CGFloat] = [1.0 ,0.2]   // 上下センサーのサイズ
        var RLSensoSize: [CGFloat] = [0.2 ,0.6]    // 上下センサーのサイズ
        var taleP: [CGFloat] = [0.3,0.2]           // 後ろ足の付け根から尻尾付け根の距離
       
        //関節距離のなどの変換
        for n in 0 ..< 3{ taleD[n] = taleD[n] * PSize }
        for n in 0 ..< 2{
            legD[n] = legD[n] * PSize
            SensorSize[n] = SensorSize[n] * PSize
            OUSensorSize[n] = OUSensorSize[n] * PSize
            RLSensoSize[n] = RLSensoSize[n] * PSize
            taleP[n] = taleP[n] * PSize
            airP[n] = airP[n] * PSize
        }
        bodyD = bodyD * PSize
        OUSensorD = OUSensorD * PSize
        RLSensorD = RLSensorD * PSize
        fallD = fallD * PSize
       
        //各部品位置の計算
        var FLegPx: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var FLegPy: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var BLegPx: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var BLegPy: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var bodyPx: CGFloat = 0             //最初の0は空打ち
        var bodyPy: CGFloat = 0             //最初の0は空打ち
        var talePx: [CGFloat] = [0,0,0,0,0,0,0,0,0] //最初の0は空打ち
        var talePy: [CGFloat] = [0,0,0,0,0,0,0,0,0] //最初の0は空打ち
        var SensorPx: [CGFloat] = [0,0,0,0,0]       //ムーブ,上,下,右,左
        var SensorPy: [CGFloat] = [0,0,0,0,0]       //ムーブ,上,下,右,左
        
        //稼働角度を指定
        var BLegRRange:[[CGFloat]] = [[-1,1],[-2,2],[-2,2]]
        var FLegRRange:[[CGFloat]] = [[-1,1],[-2,2],[-2,2]]
        var taleRRange:[[CGFloat]] = [[-20,20],[-10,10],[-10,10],[-10,10]]
        //胴体
        bodyPx = Pcx
        bodyPy = Pcy
        //足
        BLegPx[3] = bodyPx - bodyD / 2
        BLegPy[3] = bodyPy
        BLegPx[2] = BLegPx[3]
        BLegPy[2] = BLegPy[3] - legD[1]
        BLegPx[1] = BLegPx[2]
        BLegPy[1] = BLegPy[2] - legD[0]
        FLegPx[3] = bodyPx + bodyD / 2
        FLegPy[3] = bodyPy
        FLegPx[2] = FLegPx[3]
        FLegPy[2] = FLegPy[3] - legD[1]
        FLegPx[1] = FLegPx[2]
        FLegPy[1] = FLegPy[2] - legD[0]
        //尻尾
        talePx[1] = BLegPx[3] - taleP[0]
        talePy[1] = BLegPy[3] + taleP[1]
        talePx[2] = talePx[1] - taleD[0]
        talePy[2] = talePy[1]
        talePx[3] = talePx[2] - taleD[1]
        talePy[3] = talePy[2]
        talePx[4] = talePx[3] - taleD[2]
        talePy[4] = talePy[3]
        talePx[5] = FLegPx[3] + taleP[0]
        talePy[5] = FLegPy[3] + taleP[1]
        talePx[6] = talePx[5] + taleD[0]
        talePy[6] = talePy[5]
        talePx[7] = talePx[6] + taleD[1]
        talePy[7] = talePy[6]
        talePx[8] = talePx[7] + taleD[2]
        talePy[8] = talePy[7]
        //センサー
        SensorPx[0] = Pcx
        SensorPy[0] = Pcy + SensorSize[1] / 2
        SensorPx[1] = SensorPx[0]
        SensorPy[1] = SensorPy[0] + OUSensorD
        SensorPx[2] = SensorPx[0]
        SensorPy[2] = SensorPy[0] - OUSensorD
        SensorPx[3] = SensorPx[0] + RLSensorD
        SensorPy[3] = SensorPy[0]
        SensorPx[4] = SensorPx[0] - RLSensorD
        SensorPy[4] = SensorPy[0]
        
      //稼働角度を変換
        for n in 0...3{
            if n != 3 {
                let UL = BLegRRange[n][0]
                let FL = FLegRRange[n][0]
                BLegRRange[n][0] = -BLegRRange[n][1] * psita
                FLegRRange[n][0] = -FLegRRange[n][1] * psita
                BLegRRange[n][1] = -UL * psita
                FLegRRange[n][1] = -FL * psita
            }
            let tale = taleRRange[n][0]
            taleRRange[n][0] = -taleRRange[n][1] * psita
            taleRRange[n][1] = -tale * psita
        }
        
      
        //胴体アニメの読み込み
        let bodyanimeAtlas = SKTextureAtlas(named: "bodyanime")
        for i in 1...16{
            Rbodyanime.append(bodyanimeAtlas.textureNamed("bodyanime" + String(i)))
            Lbodyanime.append(bodyanimeAtlas.textureNamed("bodyanime" + String(17 - i)))
        }
        //攻撃エフェクトアニメの読み込み
        for n in 1..<AttackTN.count{
            let AttackAtlas = SKTextureAtlas(named: "Attack" + String(n))
            var ARTexture: [SKTexture] = [] ;var ALTexture: [SKTexture] = []
            for i in 1...AttackTN[n]{
                ARTexture.append( AttackAtlas.textureNamed( "A" + String(n) + "_" + String(i) ) )
                ALTexture.append( AttackAtlas.textureNamed( "A" + String(n) + "_" + String(i + AttackTN[n]) ) )
            }
            AttackRTexture.append(ARTexture)
            AttackLTexture.append(ALTexture)
        }
        playerBlock = SKShapeNode.init(rectOf: CGSize(width: SensorSize[0], height: SensorSize[1]))
        playerBlock.position = CGPoint(x: SensorPx[0], y: SensorPy[0])
        playerBlock.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: SensorSize[0], height: SensorSize[1]))
        playerBlock.physicsBody?.categoryBitMask = charaBCategory
        playerBlock.physicsBody?.contactTestBitMask = charaBCT
        playerBlock.physicsBody?.collisionBitMask = charaBCo
        playerBlock.physicsBody?.restitution = 0
        playerBlock.physicsBody?.isDynamic = false
        playerBlock.physicsBody?.affectedByGravity = true
        playerBlock.physicsBody?.allowsRotation = false
        playerBlock.fillColor = .cyan
        playerBlock.alpha = 0.5
        addChild(playerBlock)
        
        underSensor1 = SKShapeNode(rectOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        underSensor1.position = CGPoint(x:SensorPx[2] , y: SensorPy[2])
        underSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        underSensor1.physicsBody?.categoryBitMask = Sensor1Category
        underSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        underSensor1.physicsBody?.collisionBitMask = Sensor1Co
        underSensor1.physicsBody?.isDynamic = false
        underSensor1.physicsBody?.affectedByGravity = false
        underSensor1.fillColor = .red
        underSensor1.alpha = 0.1
        addChild(underSensor1)
        
        underSensor2 = SKShapeNode(rectOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        underSensor2.position = CGPoint(x:SensorPx[2] , y: SensorPy[2])
        underSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        underSensor2.physicsBody?.categoryBitMask = Sensor2Category
        underSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        underSensor2.physicsBody?.collisionBitMask = Sensor2Co
        underSensor2.physicsBody?.isDynamic = false
        underSensor2.physicsBody?.affectedByGravity = false
        underSensor2.fillColor = .blue
        underSensor2.alpha = 0.1
        addChild(underSensor2)
        
        overSensor1 = SKShapeNode(rectOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        overSensor1.position = CGPoint(x:SensorPx[1] , y: SensorPy[1])
        overSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        overSensor1.physicsBody?.categoryBitMask = Sensor1Category
        overSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        overSensor1.physicsBody?.collisionBitMask = Sensor1Co
        overSensor1.physicsBody?.isDynamic = false
        overSensor1.physicsBody?.affectedByGravity = false
        overSensor1.fillColor = .red
        overSensor1.alpha = 0.1
   //     overSensor1.physicsBody?.allowsRotation = false
        addChild(overSensor1)
        
        overSensor2 = SKShapeNode(rectOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        overSensor2.position = CGPoint(x:SensorPx[1] , y: SensorPx[1])
        overSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        overSensor2.physicsBody?.categoryBitMask = Sensor2Category
        overSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        overSensor2.physicsBody?.collisionBitMask = Sensor2Co
        overSensor2.physicsBody?.isDynamic = false
        overSensor2.physicsBody?.affectedByGravity = false
        overSensor2.fillColor = .blue
   //     overSensor2.physicsBody?.allowsRotation = false
        overSensor2.alpha = 0.1
        addChild(overSensor2)

        rightSensor1 = SKShapeNode(rectOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        rightSensor1.position = CGPoint(x:SensorPx[3] , y: SensorPy[3])
        rightSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        rightSensor1.physicsBody?.categoryBitMask = Sensor1Category
        rightSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        rightSensor1.physicsBody?.collisionBitMask = Sensor1Co
        rightSensor1.physicsBody?.isDynamic = false
        rightSensor1.physicsBody?.affectedByGravity = false
        rightSensor1.fillColor = .red
   //     rightSensor1.physicsBody?.allowsRotation = false
        rightSensor1.alpha = 0.1
        addChild(rightSensor1)
        
        rightSensor2 = SKShapeNode(rectOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        rightSensor2.position = CGPoint(x:SensorPx[3] , y: SensorPy[3])
        rightSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        rightSensor2.physicsBody?.categoryBitMask = Sensor2Category
        rightSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        rightSensor2.physicsBody?.collisionBitMask = Sensor2Co
        rightSensor2.physicsBody?.isDynamic = false
        rightSensor2.physicsBody?.affectedByGravity = false
        rightSensor2.fillColor = .blue
   //     rightSensor2.physicsBody?.allowsRotation = false
        rightSensor2.alpha = 0.1
        addChild(rightSensor2)
        
        leftSensor1 = SKShapeNode(rectOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        leftSensor1.position = CGPoint(x:SensorPx[4] , y: SensorPy[4])
        leftSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        leftSensor1.physicsBody?.categoryBitMask = Sensor1Category
        leftSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        leftSensor1.physicsBody?.collisionBitMask = Sensor1Co
        leftSensor1.physicsBody?.isDynamic = false
        leftSensor1.physicsBody?.affectedByGravity = false
        leftSensor1.fillColor = .red
   //     leftSensor1.physicsBody?.allowsRotation = false
        leftSensor1.alpha = 0.1
        addChild(leftSensor1)
        
        leftSensor2 = SKShapeNode(rectOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        leftSensor2.position = CGPoint(x:SensorPx[4] , y: SensorPy[4])
        leftSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        leftSensor2.physicsBody?.categoryBitMask = Sensor2Category
        leftSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        leftSensor2.physicsBody?.collisionBitMask = Sensor2Co
        leftSensor2.physicsBody?.isDynamic = false
        leftSensor2.physicsBody?.affectedByGravity = false
        leftSensor2.fillColor = .blue
   //     leftSensor2.physicsBody?.allowsRotation = false
        leftSensor2.alpha = 0.1
        addChild(leftSensor2)
        
        underSensorS = SKShapeNode(rectOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        underSensorS.position = CGPoint(x:SensorPx[2] , y: SensorPy[2])
        underSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        underSensorS.physicsBody?.categoryBitMask = 0
        underSensorS.physicsBody?.contactTestBitMask = 0
        underSensorS.physicsBody?.collisionBitMask = 0
        underSensorS.physicsBody?.isDynamic = false
        underSensorS.physicsBody?.affectedByGravity = false
        underSensorS.fillColor = .green
   //     underSensorS.physicsBody?.allowsRotation = false
        underSensorS.alpha = 0
        if SensorView { underSensorS.alpha  = 0.2}
        addChild(underSensorS)
        
        overSensorS = SKShapeNode(rectOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        overSensorS.position = CGPoint(x:SensorPx[1] , y: SensorPy[1])
        overSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: OUSensorSize[0], height: OUSensorSize[1]))
        overSensorS.physicsBody?.categoryBitMask = 0
        overSensorS.physicsBody?.contactTestBitMask = 0
        overSensorS.physicsBody?.collisionBitMask = 0
        overSensorS.physicsBody?.isDynamic = false
        overSensorS.physicsBody?.affectedByGravity = false
        overSensorS.fillColor = .green
     //   overSensorS.physicsBody?.allowsRotation = false
        overSensorS.alpha = 0
        if SensorView { overSensorS.alpha  = 0.2}
        addChild(overSensorS)
        
        rightSensorS = SKShapeNode(rectOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        rightSensorS.position = CGPoint(x:SensorPx[3] , y: SensorPy[3])
        rightSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        rightSensorS.physicsBody?.categoryBitMask = 0
        rightSensorS.physicsBody?.contactTestBitMask = 0
        rightSensorS.physicsBody?.collisionBitMask = 0
        rightSensorS.physicsBody?.isDynamic = false
        rightSensorS.physicsBody?.affectedByGravity = false
        rightSensorS.fillColor = .green
   //     rightSensorS.physicsBody?.allowsRotation = false
        rightSensorS.alpha = 0
        if SensorView { rightSensorS.alpha  = 0.2}
        addChild(rightSensorS)
        
        leftSensorS = SKShapeNode(rectOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        leftSensorS.position = CGPoint(x:SensorPx[4] , y: SensorPy[4])
        leftSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: RLSensoSize[0], height: RLSensoSize[1]))
        leftSensorS.physicsBody?.categoryBitMask = 0
        leftSensorS.physicsBody?.contactTestBitMask = 0
        leftSensorS.physicsBody?.collisionBitMask = 0
        leftSensorS.physicsBody?.isDynamic = false
        leftSensorS.physicsBody?.affectedByGravity = false
        leftSensorS.fillColor = .green
   //     leftSensorS.physicsBody?.allowsRotation = false
        leftSensorS.alpha = 0
        if SensorView { leftSensorS.alpha  = 0.2}
        addChild(leftSensorS)
        
        //胴体作成
        bodyT.append( SKTexture(imageNamed: "body1") )
        bodyT.append( SKTexture(imageNamed: "body2") )
        if DFlag{
            body = SKSpriteNode(texture: bodyT[0])
        }else{
            body = SKSpriteNode(texture: bodyT[1])
        }
       
        body.position = CGPoint(x: bodyPx, y: bodyPy)
        body.scale(to: CGSize(width: bodysize[0], height: bodysize[1]))
        body.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bodysize[0] * 0.433, height: bodysize[0] * 0.1783), center: CGPoint(x: 0, y: bodysize[0] * 0.146))
        body.physicsBody?.categoryBitMask = playerCategory
        body.physicsBody?.contactTestBitMask = playerCT
        body.physicsBody?.collisionBitMask = playerCo
        body.physicsBody?.isDynamic = false
        body.physicsBody?.allowsRotation = false
        body.physicsBody?.mass = 10
        body.zPosition = -1
        addChild(body)
        
        //足作成
        for n in 1...3{
            LegBT.append(SKTexture(imageNamed: "legB\(n)"))
            LegFT.append(SKTexture(imageNamed: "legF\(n)"))
        }
        for n in 4...6{
            LegBT.append(SKTexture(imageNamed: "legF\(n)"))
            LegFT.append(SKTexture(imageNamed: "legB\(n)"))
        }
        for n in 1...3{
            let RBlegSprite = SKSpriteNode(texture: LegBT[n - 1])
            let LBlegSprite = SKSpriteNode(texture: LegBT[n - 1])
            let RFlegSprite = SKSpriteNode(texture: LegFT[n - 1])
            let LFlegSprite = SKSpriteNode(texture: LegFT[n - 1])
            
            RBlegSprite.scale(to: CGSize(width: PSize, height: PSize))
            LBlegSprite.scale(to: CGSize(width: PSize, height: PSize))
            RFlegSprite.scale(to: CGSize(width: PSize, height: PSize))
            LFlegSprite.scale(to: CGSize(width: PSize, height: PSize))
            
            RBlegSprite.position = CGPoint(x: BLegPx[n], y: BLegPy[n])
            LBlegSprite.position = CGPoint(x: BLegPx[n], y: BLegPy[n])
            RFlegSprite.position = CGPoint(x: FLegPx[n], y: FLegPy[n])
            LFlegSprite.position = CGPoint(x: FLegPx[n], y: FLegPy[n])
            
            RBlegSprite.zPosition = -1 - CGFloat(n)
            LBlegSprite.zPosition = -4 - CGFloat(n)
            RFlegSprite.zPosition = -1 - CGFloat(n)
            LFlegSprite.zPosition = -4 - CGFloat(n)
           
            if n == 1{
                RBlegSprite.physicsBody = CreateSquareBody(Size: [9,27.5], Position: [0.5,-8.75], StandardSize: PSize)
                LBlegSprite.physicsBody = CreateSquareBody(Size: [9,27.5], Position: [0.5,-8.75], StandardSize: PSize)
                RFlegSprite.physicsBody = CreateSquareBody(Size: [9,27.5], Position: [0.5,-8.75], StandardSize: PSize)
                LFlegSprite.physicsBody = CreateSquareBody(Size: [9,27.5], Position: [0.5,-8.75], StandardSize: PSize)
            }else if n == 2{
                RBlegSprite.physicsBody = CreateSquareBody(Size: [11,25.5], Position: [0.5,-5.75], StandardSize: PSize)
                LBlegSprite.physicsBody = CreateSquareBody(Size: [11,25.5], Position: [0.5,-5.75], StandardSize: PSize)
                RFlegSprite.physicsBody = CreateSquareBody(Size: [11,25.5], Position: [0.5,-5.75], StandardSize: PSize)
                LFlegSprite.physicsBody = CreateSquareBody(Size: [11,25.5], Position: [0.5,-5.75], StandardSize: PSize)
            }else{
                RBlegSprite.physicsBody = CreateSquareBody(Size: [14,32], Position: [0,-8], StandardSize: PSize)
                LBlegSprite.physicsBody = CreateSquareBody(Size: [14,32], Position: [0,-8], StandardSize: PSize)
                RFlegSprite.physicsBody = CreateSquareBody(Size: [14,32], Position: [0,-8], StandardSize: PSize)
                LFlegSprite.physicsBody = CreateSquareBody(Size: [14,32], Position: [0,-8], StandardSize: PSize)
            }
            
            RBlegSprite.physicsBody?.categoryBitMask = legCategory
            RBlegSprite.physicsBody?.contactTestBitMask = legCT
            RBlegSprite.physicsBody?.collisionBitMask = legCo
            RBlegSprite.physicsBody?.isDynamic = false
            RBlegSprite.physicsBody?.mass = 1
            
            LBlegSprite.physicsBody?.categoryBitMask = legCategory
            LBlegSprite.physicsBody?.contactTestBitMask = legCT
            LBlegSprite.physicsBody?.collisionBitMask = legCo
            LBlegSprite.physicsBody?.isDynamic = false
            LBlegSprite.physicsBody?.mass = 1
            
            RFlegSprite.physicsBody?.categoryBitMask = legCategory
            RFlegSprite.physicsBody?.contactTestBitMask = legCT
            RFlegSprite.physicsBody?.collisionBitMask = legCo
            RFlegSprite.physicsBody?.isDynamic = false
            RFlegSprite.physicsBody?.mass = 1
            
            LFlegSprite.physicsBody?.categoryBitMask = legCategory
            LFlegSprite.physicsBody?.contactTestBitMask = legCT
            LFlegSprite.physicsBody?.collisionBitMask = legCo
            LFlegSprite.physicsBody?.isDynamic = false
            LFlegSprite.physicsBody?.mass = 1
            
            addChild(RBlegSprite)
            addChild(LBlegSprite)
            addChild(RFlegSprite)
            addChild(LFlegSprite)
            LegBR.append(RBlegSprite)
            LegBL.append(LBlegSprite)
            LegFR.append(RFlegSprite)
            LegFL.append(LFlegSprite)
        }
        
        //尻尾作成
        for n in 1...8{
            let taleTexture = SKTexture(imageNamed: "tale\(n)")
            taleTexture.usesMipmaps = true
            let taleSprite = SKSpriteNode(texture: taleTexture)
            taleSprite.scale(to: CGSize(width: PSize, height: PSize))
            taleSprite.position = CGPoint(x: talePx[n], y: talePy[n])
            taleSprite.physicsBody = SKPhysicsBody(rectangleOf: taleSprite.size)
            taleSprite.physicsBody?.categoryBitMask = 0
            taleSprite.physicsBody?.contactTestBitMask = 0
            taleSprite.physicsBody?.collisionBitMask = 0
            taleSprite.physicsBody?.isDynamic = false
            taleSprite.physicsBody?.mass = 0.5
            taleSprite.zPosition = -1
            if n >= 5{
                taleSprite.alpha = 0
                taleSprite.physicsBody?.categoryBitMask = 0
                taleSprite.physicsBody?.contactTestBitMask = 0
                taleSprite.physicsBody?.collisionBitMask = 0
            }
            addChild(taleSprite)
            taleS.append(taleSprite)
            if n == 4{ Rtale = taleSprite }
            if n == 8{ Ltale = taleSprite }
        }
   
        //右向き時の足パーツのジョイント
        for n in 0...2{
            var BRobject: SKSpriteNode!
            var BLobject: SKSpriteNode!
            var FRobject: SKSpriteNode!
            var FLobject: SKSpriteNode!
            if n != 2{
                BRobject = LegBR[n + 1]
                BLobject = LegBL[n + 1]
                FRobject = LegFR[n + 1]
                FLobject = LegFL[n + 1]
            }else{
                BRobject = body
                BLobject = body
                FRobject = body
                FLobject = body
            }
            let U1joint = SKPhysicsJointPin.joint(withBodyA: LegBR[n].physicsBody!, bodyB: BRobject.physicsBody!, anchor: LegBR[n].position)
            U1joint.lowerAngleLimit = BLegRRange[n][0]
            U1joint.upperAngleLimit = BLegRRange[n][1]
            U1joint.shouldEnableLimits = true
            physicsWorld.add(U1joint)
            LegJointBR.append(U1joint)
            
            let U2joint = SKPhysicsJointPin.joint(withBodyA: LegBL[n].physicsBody!, bodyB: BLobject.physicsBody!, anchor: LegBL[n].position)
            U2joint.lowerAngleLimit = BLegRRange[n][0]
            U2joint.upperAngleLimit = BLegRRange[n][1]
            U2joint.shouldEnableLimits = true
            physicsWorld.add(U2joint)
            LegJointBL.append(U2joint)
            
            let U3joint = SKPhysicsJointPin.joint(withBodyA: LegFR[n].physicsBody!, bodyB: FRobject.physicsBody!, anchor: LegFR[n].position)
            U3joint.lowerAngleLimit = FLegRRange[n][0]
            U3joint.upperAngleLimit = FLegRRange[n][1]
            U3joint.shouldEnableLimits = true
            physicsWorld.add(U3joint)
            LegJointFR.append(U3joint)
            
            let U4joint = SKPhysicsJointPin.joint(withBodyA: LegFL[n].physicsBody!, bodyB: FLobject.physicsBody!, anchor: LegFL[n].position)
            U4joint.lowerAngleLimit = FLegRRange[n][0]
            U4joint.upperAngleLimit = FLegRRange[n][1]
            U4joint.shouldEnableLimits = true
            physicsWorld.add(U4joint)
            LegJointFL.append(U4joint)
        }

        //尻尾のジョイント
        let talejointR0 = SKPhysicsJointPin.joint(withBodyA: taleS[0].physicsBody!, bodyB: body.physicsBody!, anchor: taleS[0].position)
        talejointR0.lowerAngleLimit = taleRRange[0][0]
        talejointR0.upperAngleLimit = taleRRange[0][1]
        talejointR0.shouldEnableLimits = true
        physicsWorld.add(talejointR0)
        let talejointL0 = SKPhysicsJointPin.joint(withBodyA: taleS[4].physicsBody!, bodyB: body.physicsBody!, anchor: taleS[4].position)
        talejointL0.lowerAngleLimit = -taleRRange[0][1]
        talejointL0.upperAngleLimit = -taleRRange[0][0]
        talejointL0.shouldEnableLimits = true
        physicsWorld.add(talejointL0)

        for n in 1...3{
            let talejointR = SKPhysicsJointPin.joint(withBodyA: taleS[n].physicsBody!, bodyB: taleS[n - 1].physicsBody!, anchor: taleS[n].position)
            talejointR.lowerAngleLimit = taleRRange[n][0]
            talejointR.upperAngleLimit = taleRRange[n][1]
            talejointR.shouldEnableLimits = true
            physicsWorld.add(talejointR)
            let talejointL = SKPhysicsJointPin.joint(withBodyA: taleS[n + 4].physicsBody!, bodyB: taleS[n + 3].physicsBody!, anchor: taleS[n + 4].position)
            talejointL.lowerAngleLimit = -taleRRange[n][1]
            talejointL.upperAngleLimit = -taleRRange[n][0]
            talejointL.shouldEnableLimits = true
            physicsWorld.add(talejointL)
        }
        
        if DFlag == false{
            playerdirection = false
        //    body.run(SKAction.setTexture(bodyT[1]))
            for n in 0...2{
                LegBR[n].run( SKAction.setTexture(LegBT[n + 3]) )
                LegBL[n].run( SKAction.setTexture(LegBT[n + 3]) )
                LegFR[n].run( SKAction.setTexture(LegFT[n + 3]) )
                LegFL[n].run( SKAction.setTexture(LegFT[n + 3]) )
            }
            for n in 0...3{
                taleS[n].alpha = 0
                taleS[n + 4].alpha = 1
            }
        }
        
        //プレイヤーエフェクトを映し出すスクリーンの作成
        PconEffect = SKSpriteNode(imageNamed: "block13")
        PconEffect.scale(to: CGSize(width: PSize * 3.0, height: PSize * 3.0))
        PconEffect.position = body.position
        PconEffect.alpha = 0.0
        PconEffect.zPosition = 10
        addChild(PconEffect)
 
        if SensorView == false{
            playerBlock.alpha = 0
            overSensor1.alpha = 0
            overSensor2.alpha = 0
            underSensor1.alpha = 0
            underSensor2.alpha = 0
            rightSensor1.alpha = 0
            rightSensor2.alpha = 0
            leftSensor1.alpha = 0
            leftSensor2.alpha = 0
        }
        self.listener = body

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            for n in 0...2{
                self.LegBR[n].physicsBody?.isDynamic = true
                self.LegBL[n].physicsBody?.isDynamic = true
                self.LegFR[n].physicsBody?.isDynamic = true
                self.LegFL[n].physicsBody?.isDynamic = true
            }
            for n in 0...7{ self.taleS[n].physicsBody?.isDynamic = true }
            self.body.physicsBody?.isDynamic = true
            self.underSensor1.physicsBody?.isDynamic = true
            self.overSensor1.physicsBody?.isDynamic = true
            self.rightSensor1.physicsBody?.isDynamic = true
            self.leftSensor1.physicsBody?.isDynamic = true
            self.underSensor2.physicsBody?.isDynamic = true
            self.overSensor2.physicsBody?.isDynamic = true
            self.rightSensor2.physicsBody?.isDynamic = true
            self.leftSensor2.physicsBody?.isDynamic = true
            self.underSensorS.physicsBody?.isDynamic = true
            self.overSensorS.physicsBody?.isDynamic = true
            self.rightSensorS.physicsBody?.isDynamic = true
            self.leftSensorS.physicsBody?.isDynamic = true
            self.playerBlock.physicsBody?.isDynamic = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0){

        }
    }
    
    
//1¥プレイヤーの重力やセンサの状態を変更
    func playerGravityON(){
        for n in 0...2{
            LegFR[n].physicsBody?.affectedByGravity = true
            LegFL[n].physicsBody?.affectedByGravity = true
            LegBR[n].physicsBody?.affectedByGravity = true
            LegBL[n].physicsBody?.affectedByGravity = true
        }
        for n in 0...7{ taleS[n].physicsBody?.affectedByGravity = true  }
        body.physicsBody?.affectedByGravity = true
    }
    func playerGravityOFF(){
        for n in 0...2{
            LegFR[n].physicsBody?.affectedByGravity = false
            LegFL[n].physicsBody?.affectedByGravity = false
            LegBR[n].physicsBody?.affectedByGravity = false
            LegBL[n].physicsBody?.affectedByGravity = false
        }
        for n in 0...7{ taleS[n].physicsBody?.affectedByGravity = false }
        body.physicsBody?.affectedByGravity = false
    }
    
    func SensorOFF(){
        underSflag1 = false
        overSflag1 = false
        rightSflag1 = false
        leftSflag1 = false
        underSflag2 = false
        overSflag2 = false
        rightSflag2 = false
        leftSflag2 = false
    }
    
//1¥ジョイントの変更
    func Groundjointanglemovement(){
        //[Low,UP] :反時計周りの制限　Low:時計周りの制限　(初期状態から反時計回りの角度を正、時計回りの角度を負で記入）
        let BLegRRange:[[CGFloat]] = [[-20,60],[45,90],[-60,70]]
        let FLegRRange:[[CGFloat]] = [[-30,90],[-90,45],[-45,45]]
        //※右向き状態の記入
        angleinput(FLegR: FLegRRange, BLegR: BLegRRange)
    }
    
    func Airjointanglemovement(){
        //[Low,UP] Up:反時計周りの制限　Low:時計周りの制限　(初期状態から反時計回りの角度を正、時計回りの角度を負で記入）
        let BLegRRange:[[CGFloat]] = [[-20,45],[45,90],[-30,30]]
        let FLegRRange:[[CGFloat]] = [[-20,45],[-30,30],[-30,30]]
        //※右向き状態の記入
        angleinput(FLegR: FLegRRange, BLegR: BLegRRange)
    }

    func Standerdanglemovement(){
        //[Up,Low] Up:反時計周りの制限　Low:時計周りの制限　(初期状態から反時計回りの角度を正、時計回りの角度を負で記入）
        let BLegRRange:[[CGFloat]] = [[29,30],[105,104],[-65,-64]]
        let FLegRRange:[[CGFloat]] = [[79,80],[-1,0],[-20,-19]]
        //※右向き状態の記入
        angleinput(FLegR: FLegRRange, BLegR: BLegRRange)
    }
    
    func angleinput(FLegR:[[CGFloat]] , BLegR:[[CGFloat]]){
        var FR: [[CGFloat]] = [[0,0],[0,0],[0,0]]
        var BR: [[CGFloat]] = [[0,0],[0,0],[0,0]]
        //角度の変換
        for n in 0...2{
            FR[n][0] = -FLegR[n][1] * psita
            FR[n][1] = -FLegR[n][0] * psita
            BR[n][0] = -BLegR[n][1] * psita
            BR[n][1] = -BLegR[n][0] * psita
        }
        //角度範囲の変更
        for n in 0...2{
            if playerdirection{
                LegJointFR[n].lowerAngleLimit = FR[n][0]
                LegJointFR[n].upperAngleLimit = FR[n][1]
                LegJointFL[n].lowerAngleLimit = FR[n][0]
                LegJointFL[n].upperAngleLimit = FR[n][1]
                LegJointBR[n].lowerAngleLimit = BR[n][0]
                LegJointBR[n].upperAngleLimit = BR[n][1]
                LegJointBL[n].lowerAngleLimit = BR[n][0]
                LegJointBL[n].upperAngleLimit = BR[n][1]
            }else{
                LegJointFR[n].lowerAngleLimit = -BR[n][1]
                LegJointFR[n].upperAngleLimit = -BR[n][0]
                LegJointFL[n].lowerAngleLimit = -BR[n][1]
                LegJointFL[n].upperAngleLimit = -BR[n][0]
                LegJointBR[n].lowerAngleLimit = -FR[n][1]
                LegJointBR[n].upperAngleLimit = -FR[n][0]
                LegJointBL[n].lowerAngleLimit = -FR[n][1]
                LegJointBL[n].upperAngleLimit = -FR[n][0]
            }
        }
    }

//1¥敵のテクスチャーの読み込み
    func enemyTexterLoad(){
        //敵のアニメテクスチャーの読み込み
        for n in 1..<enemyAN.count{
            let enemyAtlas = SKTextureAtlas(named: "enemyanime" + String(n))
            var enemyRT: [SKTexture] = []
            var enemyLT: [SKTexture] = []
            for i in 1...enemyAN[n]{
                enemyRT.append(enemyAtlas.textureNamed("anime" + String(n) + "_"  + String(i)))
                enemyLT.append(enemyAtlas.textureNamed("anime" + String(n) + "_"  + String(i + enemyAN[n])))
            }
            enemyRAnime.append(enemyRT)
            enemyLAnime.append(enemyLT)
        }
        
        //敵の出現、消失テクスチャーの読み込み
        let enemyApAtlas = SKTextureAtlas(named: "enemyA")
        let enemyDeAtlas = SKTextureAtlas(named: "enemyD")
        for n in 1 ... 16{ enemyAp.append(enemyApAtlas.textureNamed("enemyA" + String(n))) }
        for n in 1 ... 10{ enemyDe.append(enemyDeAtlas.textureNamed("enemyD" + String(n))) }
        
        //敵のダメージエフェクトの読み込み
        let enemyDE1Atlas = SKTextureAtlas(named: "enemyDE1")
        let enemyDE2Atlas = SKTextureAtlas(named: "enemyDE2")
        let enemyDE3Atlas = SKTextureAtlas(named: "enemyDE3")
        for n in 1 ... 7 { enemyDE1.append(enemyDE1Atlas.textureNamed("enemyDE1_" + String(n)) ) }
        for n in 1 ... 5 { enemyDE2.append(enemyDE2Atlas.textureNamed("enemyDE2_" + String(n)) ) }
        for n in 1 ... 8 { enemyDE3.append(enemyDE3Atlas.textureNamed("enemyDE3_" + String(n)) ) }
        
        
        //敵の攻撃エフェクトの読み込み
        for n in 1..<enemyEffectN.count{
            let enemyEffectAtlas = SKTextureAtlas(named: "enemyeffect" + String(n))
            var enemyEffectRT: [SKTexture] = []
            var enemyEffectLT: [SKTexture] = []
            if enemyEffectN[n] >= 0{    //RLが存在する場合
                for i in 1...enemyEffectN[n]{
                    enemyEffectRT.append(enemyEffectAtlas.textureNamed("EE" + String(n) + "_"  + String(i)))
                    enemyEffectLT.append(enemyEffectAtlas.textureNamed("EE" + String(n) + "_"  + String(i + enemyEffectN[n])))
                }
            }else{                      //RLが存在しない場合
                enemyEffectN[n] = -enemyEffectN[n]
                for i in 1...enemyEffectN[n]{
                    enemyEffectRT.append(enemyEffectAtlas.textureNamed("EE" + String(n) + "_"  + String(i)))
                    enemyEffectLT.append(enemyEffectAtlas.textureNamed("EE" + String(n) + "_"  + String(i)))
                }
            }
            enemyREffect.append(enemyEffectRT)
            enemyLEffect.append(enemyEffectLT)
        }
    }
 
//1¥BGM再生
    func BGMplay(BGM: AVAudioPlayer){
        if BGM.isPlaying{ BGM.pause() }
        BGM.currentTime = 0
        BGM.play()
    }
    func SEplay(SE: AVAudioPlayer){
        if SE.isPlaying{ SE.pause() }
        SE.currentTime = 0
        SE.play()
    }
    
//1¥背景イメージを追加
    func BackGroundImage(imageName: String,FrameSize: [CGFloat],move: Bool = true,fileType:String! = nil){
        StagedX = FrameSize[0]; StagedY = FrameSize[1]
        if move{//背景を動かす時に使用（背景サイズは固定）
            StageFrameFlag = false
            var Texture:SKTexture
            if let imageType = fileType{
                Texture = SKTexture(imageNamed: "picture/" + imageName + "." + imageType)
            }else{
                Texture = SKTexture(imageNamed: imageName)
            }
            moveBGimage.run(SKAction.setTexture(Texture))
            moveBGimage.alpha = 1.0
        }else{
            var backgroundimage:SKSpriteNode!
            if let imageType = fileType{
                backgroundimage = SKSpriteNode(imageNamed: "picture/" + imageName + "." + imageType)
            }else{
                backgroundimage = SKSpriteNode(imageNamed: imageName)
            }
            backgroundimage.position = CGPoint(x: BSize * StagedX / 2.0, y: BSize * StagedY / 2.0)
            backgroundimage.size = CGSize(width: BSize * StagedX, height: BSize * StagedY)
            backgroundimage.zPosition = -100
            addChild(backgroundimage)
        }
    }
    
//1¥アクション停止
    func stopAction(){
        for n in 0...2{
            LegBR[n].removeAllActions()
            LegBL[n].removeAllActions()
            LegFR[n].removeAllActions()
            LegFL[n].removeAllActions()
        }
        body.removeAllActions()
        playerBlock.removeAllActions()
        if RwalkFlag[0]{ RwalkFlag[0] = false ;print("歩く終了") }
        if RwalkFlag[1]{ RwalkFlag[1] = false ;print("歩く終了") }
        if LwalkFlag[0]{ LwalkFlag[0] = false ;print("歩く終了") }
        if LwalkFlag[1]{ LwalkFlag[1] = false ;print("歩く終了") }
        if RrunFlag{ RrunFlag = false ;print("走る終了") }
        if LrunFlag{ LrunFlag = false ;print("走る終了") }
        if Rairmove{ Rairmove = false ;print("空中移動終了") }
        if Lairmove{ Lairmove = false ;print("空中移動終了") }
        if playerstatas == 2 { airMfalg = true }
        print("ストップアクション終了")
    }
    
//1¥プレイヤーアクション生成１
    func PlayerAction(MoveP:[CGFloat] ,BRleg:[CGFloat],BLleg:[CGFloat],FRleg:[CGFloat],FLleg:[CGFloat],BodyS:CGFloat,time:Double,lastAction:SKAction){
        print("プレイヤ重力OFF(アクション作成)")
        playerGravityOFF()   //プレイヤーの重力をOFF
        //移動角度の変換
        var BLsita: [CGFloat] = [];var BRsita: [CGFloat] = []
        var FLsita: [CGFloat] = [];var FRsita: [CGFloat] = []
        var Bodysita: CGFloat
        for n in 0...2{
            if playerdirection{
                BLsita.append(BLleg[n] * psita)
                BRsita.append(BRleg[n] * psita)
                FLsita.append(FLleg[n] * psita)
                FRsita.append(FRleg[n] * psita)
            }else{
                BLsita.append(-FLleg[n] * psita)
                BRsita.append(-FRleg[n] * psita)
                FLsita.append(-BLleg[n] * psita)
                FRsita.append(-BRleg[n] * psita)
            }
        }
        if playerdirection{
            Bodysita = BodyS * psita
        }else{
            Bodysita = -BodyS * psita
        }
    
        //プレイヤの移動地点の計算(body[d]の移動地点)
        var Sx: CGFloat = 0 ;var Sy: CGFloat = 0
        if playerdirection { Sx = (MoveP[0] - 50) / 100 *  SensorSize[0] }
        else               { Sx = (MoveP[0] - 50) / 100 * -SensorSize[0] }
        Sy = (MoveP[1] - 50) / 100 * SensorSize[1]
        
        //ムーブセンサの姿勢を考慮したアクションを作成
        let playerAction = SKAction.run {
            //ムーブセンサの姿勢を考慮
            let Msita: CGFloat = self.playerBlock.zRotation
            //移動地点の回転変換（ムーブセンサの姿勢）
            let P = self.MrotateCalculation(PX: Sx, PY: Sy)
            //各部位の移動角度の補正（ブーブセンサの角度を加算）
            
            for n in 0...2{
                BLsita[n] += Msita
                BRsita[n] += Msita
                FLsita[n] += Msita
                FRsita[n] += Msita
            }
            Bodysita += Msita
            
            //各部位を動かすアクション作成
            var BRlegAction: [SKAction] = []
            var BLlegAction: [SKAction] = []
            var FRlegAction: [SKAction] = []
            var FLlegAction: [SKAction] = []
            var bodyAction: SKAction!
            
            for n in 0...2{
                let BRRAction = SKAction.rotate(toAngle: BRsita[n], duration: time, shortestUnitArc: true)
                let BLRAction = SKAction.rotate(toAngle: BLsita[n], duration: time, shortestUnitArc: true)
                let FRRAction = SKAction.rotate(toAngle: FRsita[n], duration: time, shortestUnitArc: true)
                let FLRAction = SKAction.rotate(toAngle: FLsita[n], duration: time, shortestUnitArc: true)
                BRlegAction.append(BRRAction)
                BLlegAction.append(BLRAction)
                FRlegAction.append(FRRAction)
                FLlegAction.append(FLRAction)
            }
            let bodyMAction = SKAction.move(to: CGPoint(x: P[0], y: P[1]), duration: time)
            let bodyRAction = SKAction.rotate(toAngle: Bodysita, duration: time, shortestUnitArc: true)
            bodyAction = SKAction.group([bodyMAction,bodyRAction])
            bodyAction = SKAction.sequence([bodyAction,lastAction])

            //各部位を動かすアクションを実行
            for n in 0...2{
                self.LegBR[n].run(BRlegAction[n])
                self.LegBL[n].run(BLlegAction[n])
                self.LegFR[n].run(FRlegAction[n])
                self.LegFL[n].run(FLlegAction[n])
            }
            self.body.run(bodyAction)
        }
        run(playerAction)
    }
    
//1¥プレイヤーアクション生成２
    func PlayerAction(MoveP:[[CGFloat]],BRleg:[[CGFloat]],BLleg:[[CGFloat]],FRleg:[[CGFloat]],FLleg:[[CGFloat]],bodyS:[CGFloat],time:[Double],lastAction:SKAction,Repeat:Bool = false){
        print("プレイヤ重力OFF(アクション作成)")
        playerGravityOFF()    //プレイヤーの重力をOFF
        let mc = bodyS.count  //モーション数

        //移動角度の変換 (ラジアルの単位に変換)
        var BLsita: [[CGFloat]] = [[]];var BRsita: [[CGFloat]] = [[]]
        var FLsita: [[CGFloat]] = [[]];var FRsita: [[CGFloat]] = [[]]
        var Bodysita: [CGFloat] = []
        for m in 0..<mc{
            var BL: [CGFloat] = [] ;var BR: [CGFloat] = []
            var FL: [CGFloat] = [] ;var FR: [CGFloat] = []
            var Body: CGFloat!
            for n in 0...2{
                if playerdirection{
                    BL.append(BLleg[m][n] * psita)
                    BR.append(BRleg[m][n] * psita)
                    FL.append(FLleg[m][n] * psita)
                    FR.append(FRleg[m][n] * psita)
                }else{
                    BL.append(-FLleg[m][n] * psita)
                    BR.append(-FRleg[m][n] * psita)
                    FL.append(-BLleg[m][n] * psita)
                    FR.append(-BRleg[m][n] * psita)
                }
            }
            if playerdirection{
                Body = bodyS[m] * psita
            }else{
                Body = -bodyS[m] * psita
            }
            BLsita.append(BL) ;BRsita.append(BR)
            FLsita.append(FL) ;FRsita.append(FR)
            Bodysita.append(Body)
        }
        BLsita.remove(at: 0) ;BRsita.remove(at: 0)
        FLsita.remove(at: 0) ;FRsita.remove(at: 0)
        //移動角度の変換 (ラジアルの単位に変換)
    
        //プレイヤの移動地点の計算(body[d]の移動地点)
        var Sx: [CGFloat] = [] ;var Sy: [CGFloat] = []
        for m in 0..<mc{
            if playerdirection { Sx.append( (MoveP[m][0] - 50) / 100 *  SensorSize[0] ) }
            else               { Sx.append( (MoveP[m][0] - 50) / 100 * -SensorSize[0] ) }
            Sy.append( (MoveP[m][1] - 50) / 100 * SensorSize[1] )
        }
        //プレイヤの移動地点の計算(body[d]の移動地点)
        
        //ムーブセンサの姿勢を考慮したアクションを作成
        var playAction: [SKAction] = []
        for m in 0..<mc{
            let playerAction = SKAction.run{
                //ムーブセンサの姿勢を考慮
                let Msita: CGFloat = self.playerBlock.zRotation
        
                //移動地点の回転変換（ムーブセンサの姿勢）
                let P = self.MrotateCalculation(PX: Sx[m], PY: Sy[m])
                
                //各部位の移動角度の補正（ブーブセンサの角度を加算）
                var BLs:[CGFloat] = [] ;var BRs:[CGFloat] = []
                var FLs:[CGFloat] = [] ;var FRs:[CGFloat] = []
                var Bodys:CGFloat!
                for n in 0...2{
                    BLs.append( (BLsita[m][n] + Msita).Rsita()  )
                    BRs.append( (BRsita[m][n] + Msita).Rsita()  )
                    FLs.append( (FLsita[m][n] + Msita).Rsita()  )
                    FRs.append( (FRsita[m][n] + Msita).Rsita()  )
                }
                Bodys = (Bodysita[m] + Msita).Rsita()
                
                //各部位を動かすアクション作成
                var BRlegAction: [SKAction] = [] ;var BLlegAction: [SKAction] = []
                var FRlegAction: [SKAction] = [] ;var FLlegAction: [SKAction] = []
                var bodyAction: SKAction!
    
                for n in 0...2{
                    let BRRAction = SKAction.rotate(toAngle: BRs[n], duration: time[m], shortestUnitArc: true)
                    let BLRAction = SKAction.rotate(toAngle: BLs[n], duration: time[m], shortestUnitArc: true)
                    let FRRAction = SKAction.rotate(toAngle: FRs[n], duration: time[m], shortestUnitArc: true)
                    let FLRAction = SKAction.rotate(toAngle: FLs[n], duration: time[m], shortestUnitArc: true)
                    BRlegAction.append(BRRAction)
                    BLlegAction.append(BLRAction)
                    FRlegAction.append(FRRAction)
                    FLlegAction.append(FLRAction)
                }
                let bodyMAction = SKAction.move(to: CGPoint(x: P[0], y: P[1]), duration: time[m])
                let bodyRAction = SKAction.rotate(toAngle: Bodys, duration: time[m], shortestUnitArc: true)
                bodyAction = SKAction.group([bodyMAction,bodyRAction])
                
                if m == mc - 1{ //最後のアクション実行時
                    if Repeat{ bodyAction = SKAction.sequence([bodyAction,playAction[0]]) } //繰り返しあり
                    else     { bodyAction = SKAction.sequence([bodyAction,lastAction]) }       //繰り返しなし
                }else{          //途中のアクション実行時
                    bodyAction = SKAction.sequence([bodyAction,playAction[m + 1]])
                }
                
                //各部位を動かすアクションを実行
                for n in 0...2{
                    self.LegBR[n].run(BRlegAction[n])
                    self.LegBL[n].run(BLlegAction[n])
                    self.LegFR[n].run(FRlegAction[n])
                    self.LegFL[n].run(FLlegAction[n])
                }
                self.body.run(bodyAction)
            }
            playAction.append(playerAction)
        }
        run(playAction[0])
    }
    
    
//1¥プレイヤーのエフェクト生成
    func CreateEffect(Position:[CGFloat],Size: CGFloat,zPosition:CGFloat,time:Double,Number:Int,SObject:SKNode,Damage:Int,DamageType:Int = 1,EBodySize:[CGFloat] = [1,1],EBodyType: Int = 1,Repeat:Bool = false){
        var EffectSprinte:SKSpriteNode!
        var EffectAnime: SKAction!
        let EffectS = Size * PSize    //エフェクトのサイズを計算
        let EBodyS: [CGFloat] = [EffectS * EBodySize[0] , EffectS * EBodySize[1]] //エフェクトボディサイズを計算
        var EffectP: [CGFloat] = [0,0]
        
        //エフェクトアニメの作成位置mの計算
        EffectP[1] = Position[1] * PSize + SObject.position.y
        if playerdirection{
            EffectSprinte = SKSpriteNode(texture: AttackRTexture[Number][0])
            EffectP[0] = Position[0] * PSize + SObject.position.x
            EffectAnime = SKAction.animate(with: AttackRTexture[Number], timePerFrame: time / Double(AttackTN[Number]) )
        }
        else{
            EffectSprinte = SKSpriteNode(texture: AttackLTexture[Number][0])
            EffectP[0] = -Position[0] * PSize + SObject.position.x
            EffectAnime = SKAction.animate(with: AttackLTexture[Number], timePerFrame: time / Double(AttackTN[Number]) )
        }
        
        EffectSprinte.position = CGPoint(x: EffectP[0], y: EffectP[1])
        EffectSprinte.scale(to: CGSize(width: EffectS, height: EffectS))
        if EBodyType == 1{
            EffectSprinte.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: EBodyS[0], height: EBodyS[1]))
        }else if EBodyType == 2{
            EffectSprinte.physicsBody = SKPhysicsBody(circleOfRadius: EBodyS[0] * 0.5)
        }else{
            EffectSprinte.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: EBodyS[0], height: EBodyS[1]))
        }
        EffectSprinte.physicsBody?.isDynamic = true
        EffectSprinte.physicsBody?.affectedByGravity = false
        EffectSprinte.zPosition = zPosition
        if Damage == 0{
            EffectSprinte.physicsBody?.categoryBitMask = 0
            EffectSprinte.physicsBody?.contactTestBitMask = 0
            EffectSprinte.physicsBody?.collisionBitMask = 0
        }else {
            EffectSprinte.physicsBody?.categoryBitMask = attackCategory
            EffectSprinte.physicsBody?.contactTestBitMask = attackCT
            EffectSprinte.physicsBody?.collisionBitMask = attackCo
            EffectSprinte.userData = ["damage":Damage,"Dtype":DamageType]
        }
        addChild(EffectSprinte)
        
        if Repeat{
            EffectAnime = SKAction.repeatForever(EffectAnime)
            Effect.append(EffectSprinte)
        }
        else{
            let ElastAction = SKAction.run {
                EffectSprinte.removeFromParent()
            }
            EffectAnime = SKAction.sequence([EffectAnime,ElastAction])
        }
        
        EffectSprinte.run(EffectAnime)
    }
    
    func playerAttackEffect(SObject:SKNode,EffectNumber:Int,EPosition:[CGFloat],ESize:CGFloat,Etime:Double,Abody:[SKPhysicsBody],AStartCN:[Int],AtimeCN:[Int],Damage:Int = 0,DamageType:Int = 1){
        let pp = SObject.position
        var Effect: [SKTexture] = []
        var Ep:CGPoint!
        if playerdirection{
            Ep = CGPoint(x: EPosition[0] * PSize + pp.x, y: EPosition[1] * PSize + pp.y )
            Effect = AttackRTexture[EffectNumber]
        }else{
            Ep = CGPoint(x: -EPosition[0] * PSize + pp.x, y: EPosition[1] * PSize + pp.y )
            Effect = AttackLTexture[EffectNumber]
        }
        let time1 = Etime / Double(Effect.count)
        
        //攻撃エフェクト作成
        let ESprite = SKSpriteNode(texture: Effect[0])
        ESprite.scale(to: CGSize(width: ESize * PSize, height: ESize * PSize))
        ESprite.position = Ep
        ESprite.zPosition = 1
        addChild(ESprite)
        
        //攻撃エフェクトのアニメ
        var EffectAnime = SKAction.animate(with: Effect, timePerFrame: time1)
        EffectAnime = SKAction.sequence([EffectAnime,SKAction.removeFromParent()])
        ESprite.run(EffectAnime)
        
        //ダメージオブジェクト(透明) の作成
        for n in 0 ..< AStartCN.count{
            let Aintarval = time1 * Double(AStartCN[n])
            let Atime = time1 * Double(AtimeCN[n])
            self.run(SKAction.wait(forDuration: Aintarval)){
                let deleteAction = SKAction.sequence([SKAction.wait(forDuration: Atime),SKAction.removeFromParent()])
                let EffectBody = SKShapeNode(circleOfRadius: 10)
                EffectBody.position = ESprite.position
                EffectBody.alpha = 0
                EffectBody.physicsBody = Abody[n]
                EffectBody.physicsBody?.categoryBitMask = self.attackCategory
                EffectBody.physicsBody?.contactTestBitMask = self.attackCT
                EffectBody.physicsBody?.collisionBitMask = self.attackCo
                EffectBody.userData = ["damage":Damage,"Dtype":DamageType]
                EffectBody.physicsBody?.isDynamic = false
                self.addChild(EffectBody)
                EffectBody.run(deleteAction)
            }
        }
    }
    
    
    
//1¥ステージの境界ブロック追加
    func addBoundaryBlock(Size:[CGFloat] ,BoundryType: Int = 1){
        let SP: [[CGFloat]] =   [[Size[0] * BSize / 2     , (Size[1] + 0.5) * BSize]
                                ,[-BSize / 2              , Size[1] * BSize / 2    ]
                                ,[(Size[0] + 0.5) * BSize , Size[1] * BSize / 2    ]
                                ,[Size[0] * BSize / 2     , -2.5 * BSize           ]]
        
        let SS: [[CGFloat]] =   [[Size[0] * BSize         , BSize                  ]
                                ,[BSize                   , (Size[1] + 2) * BSize  ]
                                ,[BSize                   , (Size[1] + 2) * BSize  ]
                                ,[(Size[0] + 10) * BSize  , BSize                  ]]
        
        for n in 0 ... 3{
            let BBlock = SKShapeNode(circleOfRadius: 10)
            BBlock.position = CGPoint(x: SP[n][0] , y: SP[n][1])
            BBlock.alpha = 0
            BBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: SS[n][0], height: SS[n][1]))
            if n != 3{
                BBlock.physicsBody?.categoryBitMask = block2Category
                BBlock.physicsBody?.contactTestBitMask = block2CT
                BBlock.physicsBody?.collisionBitMask = block2Co
            }else{
                if BoundryType == 1{
                    BBlock.physicsBody?.categoryBitMask = damageCategory
                    BBlock.physicsBody?.contactTestBitMask = damageCT
                    BBlock.physicsBody?.collisionBitMask = damageCo
                }else{
                    BBlock.physicsBody?.categoryBitMask = damage2Category
                    BBlock.physicsBody?.contactTestBitMask = damage2CT
                    BBlock.physicsBody?.collisionBitMask = damage2Co
                }
                BBlock.userData = ["damage": 1000]
            }
            BBlock.physicsBody?.isDynamic = false
            addChild(BBlock)
        }
    }
    
//1¥距離や角度計算
    func distance(p1:CGPoint,p2:CGPoint) -> CGFloat{
        let a = Double(p2.x - p1.x)
        let b = Double(p2.y - p1.y)
        return CGFloat(sqrt(a * a + b * b))
    }
    //二点の角度計算
    func angle(p1:CGPoint,p2:CGPoint) -> CGFloat{
        let a = Double(p2.x - p1.x)
        let b = Double(p2.y - p1.y)
        var sita : CGFloat!
        if a == 0{
            if b >= 0{
                sita = 180 * psita
            }else{
                sita = 0
            }
        }else if a > 0{
            sita = CGFloat(atan(b / a)) + 90 * psita
        }else{
            sita = CGFloat(atan(b / a)) - 90 * psita
        }
        return sita //ラジアン表記
    }
    
    //プレイヤーアクション生成時の回転変換に使用
    func MrotateCalculation(PX:CGFloat,PY:CGFloat) -> [CGFloat]{
        let dx = PX
        let dy = PY
        let MP: [CGFloat] = [playerBlock.position.x,playerBlock.position.y,playerBlock.zRotation]
        var RP: [CGFloat] = [0,0]
        //移動地点の計算
        RP[0] = MP[0] + dx * cos(MP[2]) - dy * sin(MP[2])
        RP[1] = MP[1] + dx * sin(MP[2]) + dy * cos(MP[2])
        return RP
    }
/*
    //プレイヤーブロックを移動させるポイント計算に使用
    func RightBRCalculation() -> [CGFloat]{
        let dx = airP[0]
        let dy = airP[1]
        let MP: [CGFloat] = [body[0].position.x,body[0].position.y,body[0].zRotation]
        var RP: [CGFloat] = [0,0]
        //移動地点の計算
        RP[0] = MP[0] + dx * cos(MP[2]) - dy * sin(MP[2])
        RP[1] = MP[1] + dx * sin(MP[2]) + dy * cos(MP[2])
        return RP
    }
    
    func LeftBRCalculation() -> [CGFloat]{
        let dx = -airP[0]
        let dy = airP[1]
        let MP: [CGFloat] = [body[1].position.x,body[1].position.y,body[1].zRotation]
        var RP: [CGFloat] = [0,0]
        //移動地点の計算
        RP[0] = MP[0] + dx * cos(MP[2]) - dy * sin(MP[2])
        RP[1] = MP[1] + dx * sin(MP[2]) + dy * cos(MP[2])
        return RP
    }
 */
    
    
//1¥プリント関連（デバッグに使用）
    /*
    func printBodyP(){
        print("BodyPX: " + bodyP().x.S() + "BodyPY: " + bodyP().y.S() )
        print("PBPX: " + playerBlock.position.x.S() + "PBPY: " + playerBlock.position.y.S() )
        print("DX: " + (playerBlock.position.x - bodyP().x).S() + "DY: " + (playerBlock.position.y - bodyP().y).S() )
    }
 */

    func printM(){
        /*
        print("SSize: " + SSize.S() )
        print("BSize: " + BSize.S() )
        print("PSize: " + PSize.S() )
        print("MSx: " + playerMoveSensorBlock.position.x.S() )
        print("MSy: " + playerMoveSensorBlock.position.y.S() )
        print("RlegX1: " + LegBR[0].position.x.S() )
        print("RlegY1: " + LegBR[0].position.y.S() )
        print("RlegX2: " + LegBR[1].position.x.S() )
        print("RlegY2: " + LegBR[1].position.y.S() )
        print("RlegX3: " + LegBR[2].position.x.S() )
        print("RlegY3: " + LegBR[2].position.y.S() )
        print("BlegD1: " + BlegD[0].S() )
        print("BlegD2: " + BlegD[1].S() )
        print("Blegsita1: " + LegBR[0].zRotation.S() )
        print("Blegsita1: " + LegBR[1].zRotation.S() )
        print("Blegsita1: " + LegBR[2].zRotation.S() )
        print("LegMSX: " + LegMS[0].S() )
        print("LegMSY: " + LegMS[1].S() )
        print("LegSD: " + LegSD.S() )
 */
        
    }
    
    
    
    
}
