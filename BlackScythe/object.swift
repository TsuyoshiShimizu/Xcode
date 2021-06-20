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

class object: SKScene{
    let h = UIScreen.main.bounds.size.height
    let w = UIScreen.main.bounds.size.width
    let wh = UIScreen.main.bounds.size.width / UIScreen.main.bounds.size.height
    
    let psita = CGFloat(.pi / 180.0)
    let ww = UIScreen.main.bounds.size.height / 1000
    var tapEE: Bool = true
    var viewnode: firstVC!
    
    //BGMのロード
 //   let Attack1BGM = SKAudioNode(fileNamed: "BGM/Attack01.mp3")
 //   let Attack2BGM = SKAudioNode(fileNamed: "BGM/Attack02.mp3")
    
    var Attack1BGM: AVAudioPlayer!
    var Attack2BGM: AVAudioPlayer!
    var Hit3BGM: AVAudioPlayer!
    let item1BGM = SKAudioNode(fileNamed: "BGM/item1.wav")
    let item2BGM = SKAudioNode(fileNamed: "BGM/item2.wav")
    let item3BGM = SKAudioNode(fileNamed: "BGM/item3.wav")
    let avoidBGM = SKAudioNode(fileNamed: "BGM/avoid.mp3")
    let PdameageBGM = SKAudioNode(fileNamed: "BGM/playerD.mp3")
    let jumpBGM = SKAudioNode(fileNamed: "BGM/jump.mp3")
    let walkBGM = SKAudioNode(fileNamed: "BGM/walk.mp3")
    

    //プレイヤーのステータス
    var playerstatas = 2 //1：:地上(通常),2:空中
    var playerdirection: Bool = true//ture:右向き,false:左向き
    var playerPosture:Int = 0 //プレイヤーの姿勢　0:立ち,5:仰向け,うつ伏せ,10:逆立ち
    var wallflag: [Bool] = [false,false,false,false,false]
    var walltime = 0.2 //ウォールアクションのセンサ停止からの有効時間
    var wallp:[CGFloat] = [0,0,0]

    var ap: Int = 0 //デバック用
    var pstatas: Int = 0
    var goalflag: Bool = true
    var HowToClear: Int = 0
    var enemyCC: Int = -100
    var impulseR: CGFloat! //端末差異によるインパルスの違いの補正
    var SceneR: CGFloat = 4.0  //シーンの大きさによる補正値
    
    
    var airmass: CGFloat = 0.03
    let jumpF: CGFloat = 80
    //0.03
    var playerMoveSensorBlock:SKShapeNode!
    var pMSBmovefalg: Bool = true
    
    var fallfalg:Bool = false
    var scrollContactflag: Bool = true
    
    var enemy1R: [SKTexture] = []     ;var enemy1L: [SKTexture] = []
    var enemy2RUp: [SKTexture] = []   ;var enemy2LUp: [SKTexture] = []
    var enemy2RDown: [SKTexture] = [] ;var enemy2LDown: [SKTexture] = []
    var enemy3R: [SKTexture] = []     ;var enemy3L: [SKTexture] = []
    var enemy4R: [SKTexture] = []     ;var enemy4L: [SKTexture] = []
    var enemy4RE: [SKTexture] = []    ;var enemy4LE: [SKTexture] = []
    var enemy5: [SKTexture] = []
    
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
    var enemyClearflag = [Bool](repeating: false, count: 100)          //その敵を倒すことがステージクリアに必要かを管理
 //   var enemySwitchNumber = [Int](repeating: 0, count: 100)
    var enemySwitchNumber:[[Int]] = [[]]                               //敵撃破時にアクションを起こすかを管理
    var EE: Bool = true                                                //敵の同時出現によるエラーの回避用
    
    //敵に関する変数の定義
    var enemy:[SKSpriteNode] = [SKSpriteNode(imageNamed: "square")]    //敵のスプライトを管理
    var ecount:Int = 0                                                 //出現している敵の数を管理
    var enemyN:[Int] = [0]                                             //出現している敵の種類を管理
    var enemypnumber:[Int] = [0]                                       //どの出現ポイントから出できたかを管理
    var enemyHP:[Int] = [0]                                            //出現している敵のHPを管理
    var enemyDamage:[Int] = [0]                                        //出現している敵の攻撃力を管理
    var enemyDamageflag:[Bool] = [false]                               //敵が攻撃を受ける or 与えるかを管理
    var enemyActionflag:[Bool] = [false]                               //敵がアクションを行うかを管理
    var enemyDBGM:[[SKAudioNode]] = [[]]
  
    var playerHP:Int = 100                                             //プレイヤーのHPを管理
    var AttackDamage:Int = 0                                           //敵へ与えるダメージを管理
    var playerDamageflag:Bool = true                                   //プレイヤーが攻撃を受けるかを管理
    var playerDamageflag2:Bool = true                                  //プレイヤーが攻撃を受けるかを管理
    var AttackCombofalg:[Bool] = [false,false,false,false,false,false] //連続攻撃の発動を管理
    var AttackComboAccess:[Bool] = [true,false,true,false,false,false] //連続攻撃の受付が可能かを管理
    //                               [地弱,空弱,空強]
    var AttackIntervalTime:[Double] = [1.0,1.0,2.0]                    // 攻撃後使用禁止時間
    //                              [地弱,地強,空弱,空強,回避]
    var AttackActionTime:[Double] = [0.3,0.6,0.2,0.6,0.5]              //攻撃時間
    //                              [     地強  ,    回避 ,空強(初撃),空強(連弾)]
    var AttackComboTime:[[Double]] = [[0.0,0.3],[0.0,0.6],[0.0,0.6],[0.0,1.0]]  //コンボ受付時間
    
    var airAttackplay: [Bool] = [false,false,false]
    var airAttackHit: [Int] = [0,0,0]
    var airAttackAngle: CGFloat = 0
    var airAN: Int = 0
    
    var bodymass: CGFloat!

    var debugON: Bool = false
    
    var airleftposible: Bool = false
    var airrightposible: Bool = false
    var airleftflag: Bool = false
    var airrightflag: Bool = false
    
    var pmxflag: Bool = false
    var pmxflag2: Bool = false
    var pmyflag: Bool = false
    
    var headkamacount:Int = 0
    var kamapmflag: Bool = false
    
    var Rkamahooklegmove: Bool = false
    var Lkamahooklegmove: Bool = false
    var kamahooklegmoveposible: Bool = false
    
    var leg11joint: SKPhysicsJointPin!
    var leg12joint: SKPhysicsJointPin!
    var leg21joint: SKPhysicsJointPin!
    var leg22joint: SKPhysicsJointPin!
    var arm11joint: SKPhysicsJointPin!
    var arm12joint: SKPhysicsJointPin!
    var arm21joint: SKPhysicsJointPin!
    var arm22joint: SKPhysicsJointPin!

    var landingfirst = true //着地した時だけ実行させるために使用
    var airfirst = true//
    
    var playerSlope:Bool =  true //プレイヤーの傾き方向の検出

    var playerblockSensor:SKShapeNode!
    
    //詰み防止判定に使用
    var playerpy:CGFloat!
    var playerpx:CGFloat!
    
    var playeryysave: CGFloat!
    var playerxxsave: CGFloat!
    var walk01posible: Bool = false
    var walk02posible: Bool = false
    var walk01exflag: Bool = false
    var walk02exflag: Bool = false
    var runexflag: Bool = false
    var runposible: Bool = false
    var legsfinfirst: Bool = true
    
    var Actionlock: Bool = false
    var Sensorlock:Bool = false
    var rightmovelock:Bool = false
    var leftmovelock:Bool = false
    var Rsfalg: Bool = true
    var Lsfalg: Bool = true
    var PDfalg: Bool = true // 傾き判定テスト用
  
    let gra = 9.8
    var sita = 0.0
    let resize = 0.97
    
    var underSflag1: Bool = false
    var overSflag1: Bool = false
    var rightSflag1:Bool = false
    var leftSflag1:Bool = false
    var underSflag2: Bool = false
    var overSflag2: Bool = false
    var rightSflag2:Bool = false
    var leftSflag2:Bool = false
    var undreSfirst:Bool = true
    var overSfirst:Bool = true
    var rightSfirst:Bool = true
    var leftSfirst:Bool = true
    var flick: Bool = false
    
    var body: SKSpriteNode!
    var bodyPhysick: SKSpriteNode!
    var leftbody:[SKTexture] = []
    var rightbody:[SKTexture] = []
    var leftleg:[SKTexture] = []
    var rightleg:[SKTexture] = []
    var leg11: SKSpriteNode!
    var leg12: SKSpriteNode!
    var leg21: SKSpriteNode!
    var leg22: SKSpriteNode!
    var kamaA1R:[SKTexture] = []
    var kamaA1L:[SKTexture] = []

    var leg12text: SKTexture!
    var leg22text: SKTexture!
    var bodytext: SKTexture!
    /*
    var legs:SKShapeNode!
    var larms:SKShapeNode!
    var rarms:SKShapeNode!
    var heads:SKShapeNode!
 */
    var underSensorS:SKShapeNode!
    var overSensorS:SKShapeNode!
    var rightSensorS:SKShapeNode!
    var leftSensorS:SKShapeNode!
    var underSensor1:SKShapeNode!
    var overSensor1:SKShapeNode!
    var rightSensor1:SKShapeNode!
    var leftSensor1:SKShapeNode!
    var underSensor2:SKShapeNode!
    var overSensor2:SKShapeNode!
    var rightSensor2:SKShapeNode!
    var leftSensor2:SKShapeNode!
    
    var bodypc: SKShapeNode!
    var legpc: SKShapeNode!
    
    var arm11: SKSpriteNode!
    var arm12: SKSpriteNode!
    var arm21: SKSpriteNode!
    var arm22: SKSpriteNode!
    
    var armkjoint1: SKPhysicsJointPin!
    var armkjoint2: SKPhysicsJointPin!
    
 
    let xx = UIScreen.main.bounds.size.height / 10
    
    let playerCategory: UInt32 = 0b000000000000001  //プレイヤー 1
    let blockCategory: UInt32 = 0b000000000000010   //足場などのオブジェクト（プレイヤーが着地できる）2
    let block2Category: UInt32 = 0b100000000000000  //足場などのオブジェクト（プレイヤーが着地できない）15
    let damageCategory: UInt32 = 0b000000000000100  //プレイヤーにダメージを与えるオブジェクト（プレイヤーと接触する）3
    let damage2Category: UInt32 = 0b000000000010000 //プレイヤーにダメージを与えるオブジェクト（プレイヤーと接触しない）5
    let goalCategory: UInt32 = 0b000000000001000    //ゴールのオブジェクト 4
    let charaBCategory: UInt32 = 0b000000010000000  //落下などのセンサオブジェクト 8
    let weaponCategory: UInt32 = 0b000000100000000  //武器オブジェクト 9
    let enemyCategory: UInt32 = 0b000001000000000   //敵オブジェクト 10
    let enemy2Category: UInt32 = 0b000000001000000  //敵オブジェクト 7
    let Sensor1Category: UInt32 = 0b000010000000000 //接触センサオブジェクト（ブロック１と接触） 11
    let Sensor2Category: UInt32 = 0b000100000000000 //接触センサオブジェクト（ブロック２と接触） 12
    let ScrollCategory: UInt32 = 0b000000000100000  //スクロールの表示に使用 6
    let doorCategory: UInt32 = 0b001000000000000    //扉 13
    let itemCategory: UInt32 = 0b010000000000000    //アイテム 14

    var playerCT: UInt32!
    var blockCT: UInt32!
    var block2CT: UInt32!
    var damageCT: UInt32!
    var damage2CT: UInt32!
    var goalCT: UInt32!
    var charaBCT: UInt32!
    var weaponCT: UInt32!
    var enemyCT: UInt32!
    var enemy2CT: UInt32!
    var Sensor1CT: UInt32!
    var Sensor2CT: UInt32!
    
    var playerCo: UInt32!
    var blockCo: UInt32!
    var block2Co: UInt32!
    var damageCo: UInt32!
    var damage2Co: UInt32!
    var goalCo: UInt32!
    var charaBCo: UInt32!
    var weaponCo: UInt32!
    var enemyCo: UInt32!
    var enemy2Co: UInt32!
    var Sensor1Co: UInt32!
    var Sensor2Co: UInt32!
    
// 接触判定の設定
    func contact(){
        playerCT = enemyCategory + enemy2Category + damageCategory + damage2Category + goalCategory + ScrollCategory + doorCategory + itemCategory
        playerCo = blockCategory + block2Category + damageCategory + goalCategory
        blockCT = 0
        blockCo = playerCategory + charaBCategory + enemyCategory + Sensor1Category
        block2CT = 0
        block2Co = playerCategory + charaBCategory + enemyCategory + Sensor2Category
        damageCT = playerCategory
        damageCo = playerCategory + enemyCategory + Sensor1Category + charaBCategory
        damage2CT = playerCategory
        damage2Co = 0
        goalCT = playerCategory
        goalCo = playerCategory + enemyCategory
        charaBCT = 0
        charaBCo = blockCategory + block2Category + damageCategory
        weaponCT = enemyCategory + enemy2Category
        weaponCo = 0
        enemyCT = weaponCategory + playerCategory
        enemyCo = blockCategory + block2Category + damageCategory + goalCategory
        enemy2CT = weaponCategory + playerCategory
        enemy2Co = 0
        Sensor1CT = 0
        Sensor1Co = blockCategory + damageCategory
        Sensor2CT = 0
        Sensor2Co = block2Category
    }
    var sickle: SKSpriteNode!
    var sickletext: SKTexture!
//アクション
    var Block: [SKSpriteNode] = []
    var BlockNumber = [Int](repeating: 0, count: 200)
    var BlockAction: [SKAction] = []
    var BlockActionNumber = [Int](repeating: 0, count: 200)

    var repAction: [SKSpriteNode] = []
    var repcount = 0
    var repx = [CGFloat](repeating: 0, count: 100)
    var repy = [CGFloat](repeating: 0, count: 100)
    var dis = [CGFloat](repeating: 0, count: 100)
    let playAction = SKAction.play()
    
//効果音
    let clearbgm = SKAudioNode.init(fileNamed: "クリア音.mp3" )
    var kamaR:SKSpriteNode!
    var kamaL:SKSpriteNode!
    var kamaXscale: CGFloat!
    var kamaYscale: CGFloat!
    
    var playerXscale: CGFloat!
    var playerYsita: CGFloat = 0
    var playerYstatas: Int = 1
    var legXscale: CGFloat!
    
    var doorSprite: [SKSpriteNode] = []
    var doormoveP: [CGPoint] = []
    var doorCflag = true
    
    var itemSprite: [SKSpriteNode] = []
    var itemtype: [Int] = []
    var itemCflag = true
    
    func addweight(xp: CGFloat, yp:CGFloat , type:Int ,BloclNumber n: Int = 0){
        //type 1,2,3 大、中、小
        let h1 = h / 10
        var weight: SKSpriteNode!
             if type == 1{ weight = SKSpriteNode(imageNamed: "weight1") }
        else if type == 2{ weight = SKSpriteNode(imageNamed: "weight2") }
        else             { weight = SKSpriteNode(imageNamed: "weight3") }
        weight.size = CGSize(width: h1, height: h1)
        weight.position = CGPoint(x: h1 * xp + h1 / 2, y: h1 * yp + h1 / 2)
        weight.physicsBody = SKPhysicsBody(rectangleOf: weight.size)
        weight.physicsBody?.categoryBitMask = itemCategory
        weight.physicsBody?.contactTestBitMask = playerCategory
        weight.physicsBody?.collisionBitMask = 0
        weight.physicsBody?.isDynamic = false
        addChild(weight)
        itemSprite.append(weight)
        itemtype.append(type)
        if n != 0{
            Block.append(weight)
            BlockNumber[n] = Block.count
        }
    }

    func adddoor(xp: CGFloat, yp:CGFloat ,movepx: CGFloat = -1 ,movepy: CGFloat = -1,BloclNumber n: Int = 0){
        let h1 = h / 10
        if movepx == -1 && movepy == -1 { doormoveP.append(CGPoint(x: -1, y: -1)) }
        else                            { doormoveP.append(CGPoint(x: h1 * movepx, y: h1 * movepy)) }
        let door = SKSpriteNode(imageNamed: "door")
        door.size = CGSize(width: h1 * 2, height: h1 * 3)
        door.position = CGPoint(x: h1 * xp + h1 , y: h1 * yp + 3 / 2 * h1)
        door.physicsBody = SKPhysicsBody(rectangleOf: door.size)
        door.physicsBody?.categoryBitMask = doorCategory
        door.physicsBody?.contactTestBitMask = playerCategory
        door.physicsBody?.collisionBitMask = 0
        door.physicsBody?.isDynamic = false
        addChild(door)
        doorSprite.append(door)
        if n != 0{
            Block.append(door)
            BlockNumber[n] = Block.count
        }
    }
    
    func addvector(xp: CGFloat, yp:CGFloat , sita:CGFloat){
        let h1 = h / 10.0
        let vector = SKSpriteNode(imageNamed: "vector")
        vector.scale(to: CGSize(width: h1 * 3, height: h1 * 3))
        vector.position = CGPoint(x: xp * h1 + h1 * 3 / 2, y: yp * h1 + h1 * 3 / 2)
        vector.zRotation = sita * psita
        vector.alpha = 0.6
        addChild(vector)
    }
    
    func addscroll(xp:CGFloat,yp:CGFloat,Number:Int){
        let Scroll = SKSpriteNode(imageNamed: "scroll")
        Scroll.position = CGPoint(x: h / 20 + h / 10 * xp, y: h / 20 + h / 10 * yp)
        Scroll.scale(to: CGSize(width: h / 10, height: h / 10))
        Scroll.physicsBody = SKPhysicsBody(rectangleOf: Scroll.size)
        Scroll.physicsBody?.categoryBitMask = ScrollCategory
        Scroll.physicsBody?.contactTestBitMask = playerCategory
        Scroll.physicsBody?.collisionBitMask = 0
        Scroll.physicsBody?.affectedByGravity = false
        Scroll.physicsBody?.isDynamic = false
        Scroll.physicsBody?.mass = CGFloat(Number)
        addChild(Scroll)
    }
    
    func addenemy(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,CFenemy: Bool = false,SwitchNumber n:Int = 0,Actionflag: Bool = false){
        var CF = CFenemy
        if HowToClear == 2 { CF = true }
        enemyp[epcount] = CGPoint(x: xp * h / 10 + h / 20, y: yp * h / 10 + h / 20)
        enemyNumber[epcount] = type
        enemydirection[epcount] = direction
        enemynmax[epcount] = maxn
        enemyflag[epcount] = true
        enemypHP[epcount] = HP
        enemyInterval[epcount] = interval
        enemypDamage[epcount] = Damage
        enemyClearflag[epcount] = CF
        enemySwitchNumber.append([n])
        if Actionflag { CF = false }
        if CF{
            if enemyCC > 0     { enemyCC += maxn }
            if enemyCC == -100 { enemyCC = maxn }
        }
        epcount += 1
    }
    
    func addenemy(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,CFenemy: Bool = false,SwitchNumber n:[Int],Actionflag: Bool = false){
        var CF = CFenemy
        if HowToClear == 2 { CF = true }
        enemyp[epcount] = CGPoint(x: xp * h / 10 + h / 20, y: yp * h / 10 + h / 20)
        enemyNumber[epcount] = type
        enemydirection[epcount] = direction
        enemynmax[epcount] = maxn
        enemyflag[epcount] = true
        enemypHP[epcount] = HP
        enemyInterval[epcount] = interval
        enemypDamage[epcount] = Damage
        enemyClearflag[epcount] = CF
        enemySwitchNumber.append(n)
        if Actionflag { CF = false }
        if CF{
            if enemyCC > 0     { enemyCC += maxn }
            if enemyCC == -100 { enemyCC = maxn }
        }
        epcount += 1
    }
    
    func AppearEnemy(ep:CGPoint,etype:Int,edre:Bool,epnumber:Int,eHP:Int,eDame:Int){
        var size:[CGFloat] = [0,0]
        var enemymass: CGFloat = 0.05
        let enemyBGM = SKAudioNode(fileNamed: "BGM/enemyp")
        enemyBGM.autoplayLooped = false
        enemyN.append(etype)
        enemypnumber.append(epnumber)
        enemyHP.append(eHP)
        enemyDamage.append(eDame)
        enemyDamageflag.append(true)
        enemyActionflag.append(false)
        guard let enemyap = SKEmitterNode(fileNamed: "enemyAP") else { return }
        enemyap.position = ep
        addChild(enemyap)
        enemyap.addChild(enemyBGM)
        enemyBGM.run(SKAction.play())
        let EDBGM = [SKAudioNode(fileNamed: "BGM/hit01.mp3"),SKAudioNode(fileNamed: "BGM/hit02.mp3")]
        EDBGM[0].autoplayLooped = false
        EDBGM[1].autoplayLooped = false
        enemyDBGM.append(EDBGM)
        self.run(SKAction.wait(forDuration: 1.0)){
            enemyap.removeFromParent()
        }
        var etexter: SKTexture!
        var Gravity: Bool!
        if 1 <= etype && etype <= 10 {
            if      etype == 1 || etype == 2 { size = [100,100,40] ;enemymass = 0.05 }
            else if etype == 3 || etype == 4 { size = [150,150,60] ;enemymass = 0.10 }
            else if etype == 5 || etype == 6 { size = [200,200,80] ;enemymass = 0.15 }
            else{ size = [100,100,40] }
            Gravity = true
            if edre{etexter = enemy1R[0]}else{etexter = enemy1L[0]}
        }else if 11 <= etype && etype <= 20{
            if      etype == 11 || etype == 12 { size = [100,100,45] ;enemymass = 0.05 }
            else if etype == 13 || etype == 14 { size = [150,150,70] ;enemymass = 0.10 }
            else if etype == 15 || etype == 16 { size = [200,200,95] ;enemymass = 0.15 }
            else{ size = [100,100,45] }
            Gravity = true
            if edre{etexter = enemy2RDown[0]}else{etexter = enemy2LDown[0]}
        }else if 21 <= etype && etype <= 30{
            if      etype == 21 || etype == 22 { size = [160,160,45] ;enemymass = 0.05 }
            else if etype == 23 || etype == 24 { size = [200,200,70] ;enemymass = 0.10 }
            else if etype == 25 || etype == 26 { size = [240,240,95] ;enemymass = 0.15 }
            else{ size = [160,160,45] }
            Gravity = true
            if edre{etexter = enemy3R[0]}else{etexter = enemy3L[0]}
        }else if 31 <= etype && etype <= 40{
            size = [180,160,55]
            Gravity = false
            if edre{etexter = enemy4R[0]}else{etexter = enemy4L[0]}
        }else if 41 <= etype && etype <= 50{
            if      etype == 41 || etype == 42 || etype == 43 { size = [160,160,55] }
            else if etype == 44 || etype == 45 || etype == 46 { size = [320,320,110] }
            else{ size = [160,160,45] }
            Gravity = false
            if edre{etexter = enemy5[0]}else{etexter = enemy5[1]}
        }else if 51 <= etype && etype <= 60{
            size = [360,320,110]
            Gravity = false
            if edre{etexter = enemy4R[0]}else{etexter = enemy4L[0]}
        }
        let Ene = SKSpriteNode(texture: etexter)
        Ene.scale(to: CGSize(width: ww * size[0], height: ww * size[1]))
        Ene.position = ep
        Ene.physicsBody = SKPhysicsBody(circleOfRadius: size[2] * ww)
        Ene.physicsBody?.categoryBitMask = enemyCategory
        Ene.physicsBody?.contactTestBitMask = enemyCT
        Ene.physicsBody?.collisionBitMask = enemyCo
        Ene.physicsBody?.mass = enemymass
 
        if 31 <= etype && etype <= 60{
            Ene.physicsBody?.categoryBitMask = enemy2Category
            Ene.physicsBody?.contactTestBitMask = enemy2CT
            Ene.physicsBody?.collisionBitMask = enemy2Co
        }
        
        Ene.physicsBody?.isDynamic = false
        Ene.physicsBody?.allowsRotation = false
        Ene.physicsBody?.affectedByGravity = Gravity
        addChild(Ene)
        enemy.append(Ene)
        Ene.addChild(EDBGM[0])
        Ene.addChild(EDBGM[1])
        ecount += 1
        Ene.physicsBody?.isDynamic = true
        enemyActionflag[ecount] = true
        enemyAction(object: Ene, type: etype, enemyd: edre)
    }
    
    
    func enemyAction(object:SKSpriteNode, type:Int, enemyd:Bool){
        let Eobject = object
        var enemyDD = enemyd
        var epxx:CGFloat!
        if 1 <= type && type <= 10{
            var ddx:CGFloat = 50 //移動量の定義
            if type == 1 || type == 3 || type == 5
            { ddx = 50 }
            if type == 2 || type == 4 || type == 6
            { ddx = 100 }
            
            let walktime = 0.6
            let Atime = walktime / 8.0
            let LwalkAction = SKAction.repeatForever(SKAction.animate(with: enemy1L, timePerFrame: Atime))
            let RwalkAction = SKAction.repeatForever(SKAction.animate(with: enemy1R, timePerFrame: Atime))
            var RmoveAction = SKAction.moveBy(x: ddx * ww, y: 0, duration: 0.5)
            var LmoveAction = SKAction.moveBy(x: -ddx * ww, y: 0, duration: 0.5)
            let lastAction = SKAction.run { //動いた後に実行するコード
                if epxx == nil{// 初回のみ実行
                    epxx = Eobject.position.x //epxxの値を更新
                    if enemyDD{Eobject.run(RmoveAction)}else{Eobject.run(LmoveAction)} //動くアクションを実行
                }else{// 2回目以降
                    let edis = epxx - Eobject.position.x  //敵が動いた距離
                    if edis.abs() < self.ww * 5{ //敵が動いていなかった場合
                        Eobject.removeAllActions()
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
        }else if 11 <= type && type <= 20{
            var jumpx: CGFloat = 5 //縦移動距離
            var jumpy: CGFloat = 2   //横移動距離
            if type == 11 { jumpx = 3; jumpy = 2 }
            if type == 12 { jumpx = 2; jumpy = 3 }
            if type == 13 { jumpx = 4; jumpy = 3 }
            if type == 14 { jumpx = 3; jumpy = 4 }
            if type == 15 { jumpx = 5; jumpy = 3 }
            if type == 16 { jumpx = 3; jumpy = 5 }
            
            let enemyABGM = SKAudioNode(fileNamed: "BGM/ejump")
            enemyABGM.autoplayLooped = false
            Eobject.addChild(enemyABGM)
            let jumptime = 0.5
            let upanimetime = 0.1
            let downanimetime = 0.5
            let nextwaitTime = 1.0
            Eobject.physicsBody?.restitution = 0
            let Rupanime = SKAction.animate(with: enemy2RUp, timePerFrame: upanimetime / 14.0)
            let Lupanime = SKAction.animate(with: enemy2LUp, timePerFrame: upanimetime / 14.0)
            let Rdownanime = SKAction.animate(with: enemy2RDown, timePerFrame: downanimetime / 14.0)
            let Ldownanime = SKAction.animate(with: enemy2LDown, timePerFrame: downanimetime / 14.0)
            let playBGM = SKAction.run { enemyABGM.run(SKAction.play()) }
            let nextwait = SKAction.wait(forDuration: nextwaitTime)
            let R1 = SKAction.rotate(toAngle: 0, duration: jumptime / 4.0, shortestUnitArc: true)
            let R2 = SKAction.rotate(toAngle: 90 * psita, duration: jumptime / 4.0, shortestUnitArc: true)
            let R3 = SKAction.rotate(toAngle: 180 * psita, duration: jumptime / 4.0, shortestUnitArc: true)
            let R4 = SKAction.rotate(toAngle: -90 * psita, duration: jumptime / 4.0, shortestUnitArc: true)
            let RM = SKAction.moveBy(x: jumpx * h / 10, y: jumpy * h / 10, duration: jumptime)
            let LM = SKAction.moveBy(x: -jumpx * h / 10, y: jumpy * h / 10, duration: jumptime)
            let jumpF = SKAction.run { Eobject.physicsBody?.affectedByGravity = false }
            let jumpL = SKAction.run { Eobject.physicsBody?.affectedByGravity = true }
            let jumpRMr = SKAction.sequence([R4,R3,R2,R1])
            let jumpRM = SKAction.group([jumpRMr,RM,Rupanime,playBGM])
            var jumpRAction = SKAction.sequence([Rdownanime,jumpF,jumpRM,jumpL,nextwait])
            let jumpLMr = SKAction.sequence([R2,R3,R4,R1])
            let jumpLM = SKAction.group([jumpLMr,LM,Lupanime,playBGM])
            var jumpLAction = SKAction.sequence([Ldownanime,jumpF,jumpLM,jumpL,nextwait])
            let lastAction = SKAction.run { //動いた後に実行するコード
                if epxx == nil{// 初回のみ実行
                    epxx = Eobject.position.x //epxxの値を更新
                    if enemyDD{Eobject.run(jumpRAction)}else{Eobject.run(jumpLAction)} //動くアクションを実行
                }else{// 2回目以降
                    let edis = epxx - Eobject.position.x  //敵が動いた距離
                    if edis.abs() < self.ww * 5{ //敵が動いていなかった場合
                        Eobject.removeAllActions()
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
        }else if 21 <= type && type <= 30{
            var Ndx:CGFloat = 50             //通常時の移動スピード
            var Adx:CGFloat = 500            //攻撃アクションの移動距離
            var ActionDistance: CGFloat = 5  //攻撃アクションの使用範囲
            
            if type == 21 { Ndx = 50; Adx = 500; ActionDistance = 5 }
            if type == 22 { Ndx = 50; Adx = 800; ActionDistance = 8 }
            if type == 23 { Ndx = 75; Adx = 600; ActionDistance = 6 }
            if type == 24 { Ndx = 75; Adx = 900; ActionDistance = 9 }
            if type == 25 { Ndx = 100; Adx = 700; ActionDistance = 7 }
            if type == 26 { Ndx = 100; Adx = 1000; ActionDistance = 10 }
            
            let NRPS:Double = 1.0 //通常時の刃物の回転数
            let ARPS:Double = 10.0 //攻撃アクション時の刃物の回転数
            let AanimeTime = 3.0
            let ActionPtime = 2.0
            let ActionNtime = 2.0
            let ABGM = SKAudioNode(fileNamed: "BGM/enemy3.mp3")
            ABGM.autoplayLooped = false
            Eobject.addChild(ABGM)
            let BGMplay = SKAction.run { ABGM.run(SKAction.play()) }
            let onetime = 0.25 / 30.0 //一秒で一回転させるためのワンフレームの表示時間
            let NRtime = onetime / NRPS //通常回転アクションのワンフレームの表示時間
            let ARtime = onetime / ARPS //攻撃回転アクションのワンフレームの表示時間
            let ARonetime = ARtime * 30.0 //攻撃アクションの１アニメの時間
            let ARcount = Int(AanimeTime / ARonetime) //攻撃アクションのアニメ時間
            let RanimeAction = SKAction.repeatForever(SKAction.animate(with: enemy3R, timePerFrame: NRtime)) // 右に動く時のアニメ
            let LanimeAction = SKAction.repeatForever(SKAction.animate(with: enemy3L, timePerFrame: NRtime)) // 左に動く時のアニメ
            var RmoveAction = SKAction.moveBy(x: Ndx * ww, y: 0, duration: 0.5) // 右に動く
            var LmoveAction = SKAction.moveBy(x: -Ndx * ww, y: 0, duration: 0.5) //左に動く
            var RAanimeAction = SKAction.repeat(SKAction.animate(with: enemy3R, timePerFrame: ARtime), count: ARcount)
            var LAanimeAction = SKAction.repeat(SKAction.animate(with: enemy3L, timePerFrame: ARtime), count: ARcount)
            RAanimeAction = SKAction.sequence([RAanimeAction,RanimeAction])
            LAanimeAction = SKAction.sequence([LAanimeAction,LanimeAction])
            let FwaitAction = SKAction.wait(forDuration: ActionPtime)
            let EwaitAction = SKAction.wait(forDuration: ActionNtime)
            let RattackAction = SKAction.moveBy(x: Adx * ww, y: 0, duration: 0.2)
            let LattackAction = SKAction.moveBy(x: -Adx * ww, y: 0, duration: 0.2)
            var RAction = SKAction.sequence([BGMplay,FwaitAction,RattackAction,EwaitAction])
            var LAction = SKAction.sequence([BGMplay,FwaitAction,LattackAction,EwaitAction])
            let lastAction = SKAction.run { //動いた後に実行するコード
                if epxx == nil{// 初回のみ実行
                    epxx = Eobject.position.x //epxxの値を更新
                    if enemyDD{Eobject.run(RmoveAction)}else{Eobject.run(LmoveAction)} //動くアクションを実行
                }else{// 2回目以降
                    let edis = epxx - Eobject.position.x  //敵が動いた距離
                    let pdx = Eobject.position.x - self.playerMoveSensorBlock.position.x
                    let pdy = Eobject.position.y - self.playerMoveSensorBlock.position.y
                    if pdx.abs() < self.h / 10 * ActionDistance && pdy.abs() < self.h / 2{ //プレイヤーとの距離が一定以下の場合 加速アクション
                        Eobject.removeAllActions()
                        if pdx >= 0{
                            enemyDD = false
                            Eobject.run(LAction)
                            Eobject.run(LAanimeAction)
                        }else{
                            enemyDD = true
                            Eobject.run(RAction)
                            Eobject.run(RAanimeAction)
                        }
                    }else if edis.abs() < self.ww * 5{ //敵が動いていなかった場合　方向転換
                        Eobject.removeAllActions()  // アクション停止
                        if enemyDD{ enemyDD = false}else{ enemyDD = true }
                        if enemyDD{
                            Eobject.run(RmoveAction)
                            Eobject.run(RanimeAction)
                        }else{
                            Eobject.run(LmoveAction)
                            Eobject.run(LanimeAction)
                        }
                    }else{ if enemyDD{Eobject.run(RmoveAction)}else{Eobject.run(LmoveAction)} } //通常アクション
                    epxx = Eobject.position.x //epxxの値を更新
                }
            }
            //移動アクションの作成
            RmoveAction = SKAction.sequence([RmoveAction,lastAction])
            LmoveAction = SKAction.sequence([LmoveAction,lastAction])
            RAction = SKAction.sequence([RAction,lastAction])
            LAction = SKAction.sequence([LAction,lastAction])
            //アクションの実行
            if enemyDD{
                Eobject.run(RmoveAction)
                Eobject.run(RanimeAction)
            }else{
                Eobject.run(LmoveAction)
                Eobject.run(LanimeAction)
            }
        }else if 31 <= type && type <= 40{
            var movetype = 1         //移動タイプ (1:通常 2:縦 3:横 4:四角 5:ひし形)
            var Attackfrequency = 1  //攻撃頻度　（1:小   2:大）
            if type == 31{ movetype = 1; Attackfrequency = 1 }
            if type == 32{ movetype = 2; Attackfrequency = 1 }
            if type == 33{ movetype = 3; Attackfrequency = 1 }
            if type == 34{ movetype = 4; Attackfrequency = 1 }
            if type == 35{ movetype = 5; Attackfrequency = 1 }
            if type == 36{ movetype = 1; Attackfrequency = 2 }
            if type == 37{ movetype = 2; Attackfrequency = 2 }
            if type == 38{ movetype = 3; Attackfrequency = 2 }
            if type == 39{ movetype = 4; Attackfrequency = 2 }
            if type == 40{ movetype = 5; Attackfrequency = 2 }
            var movetime = 3.0                 //移動時間
            var fireballspeed: CGFloat = 250.0 //ファイアボールのスピード
            var firedeletetime = 4.0           //ファイアボールが発射されてから消滅するまでの時間
            var fireinterval = 4.0             //ファイアボールを生成したから次のアクション起こすまでの時間
            
            if Attackfrequency == 1{
                movetime = 3.0
                fireballspeed = 300.0
                firedeletetime = 4.0
                fireinterval = 4.0
            }else{
                movetime = 2.0
                fireballspeed = 400.0
                firedeletetime = 5.0
                fireinterval = 2.0
            }
            var moved: CGFloat = 5             //移動距離
            let ActionDistance: CGFloat = 8    //攻撃アクションの使用範囲
        
            
            moved = moved * h / 10
            let animetime = 0.5           //攻撃モーションの時間
            let fireballsize:CGFloat = 50 //ファイアボールの当たり判定の大きさ
            let firemovetime = 1.3        //ファイアボールを生成してから発射するまでの時間
            var fireflag: Bool = false    //攻撃可能かの判定
            let ep = Eobject.position     //初期の敵位置
            var movepoint: [CGPoint] = [] //移動ポイントの生成
            for ny in -1...1{
                for nx in -1...1{
                    movepoint.append(CGPoint(x: ep.x + CGFloat(nx) * moved, y: ep.y + CGFloat(ny) * moved))
                }
            } //移動ポイントの生成はここまで
            //次の移動地点
            var nextrandam: [[Int]] = [[1,3,4],[0,2,3,4,5],[1,4,5],[0,1,4,6,7],[0,1,2,3,5,6,7,8],[1,2,4,7,8],[3,4,7],[3,4,5,6,8],[4,5,7]]
            if movetype == 2{
                nextrandam[1] = [4,7]
                nextrandam[4] = [1,7]
                nextrandam[7] = [1,4]
            }
            if movetype == 3{
                nextrandam[3] = [4,5]
                nextrandam[4] = [3,5]
                nextrandam[5] = [3,4]
            }
            if movetype == 4{
                nextrandam[4] = [0,2,6,8]
                nextrandam[0] = [2,6]
                nextrandam[2] = [0,8]
                nextrandam[6] = [0,8]
                nextrandam[8] = [2,6]
            }
            if movetype == 5{
                nextrandam[4] = [1,3,5,7]
                nextrandam[1] = [3,5]
                nextrandam[3] = [1,7]
                nextrandam[5] = [1,7]
                nextrandam[7] = [3,5]
            }
            var point = 4                                                                    //現在いるポイント
            var moveAction: SKAction!                                                        //移動アクションを管理
            let RAanime = SKAction.animate(with: enemy4R, timePerFrame: animetime / 10.0)    //右向き攻撃前アニメ
            let LAanime = SKAction.animate(with: enemy4L, timePerFrame: animetime / 10.0)    //左向き攻撃前アニメ
            let REAanime = SKAction.animate(with: enemy4RE, timePerFrame: animetime / 10.0)  //右向き攻撃後アニメ
            let LEAanime = SKAction.animate(with: enemy4LE, timePerFrame: animetime / 10.0)  //左向き攻撃後アニメ
        //    let BGM = SKAction.playSoundFileNamed("BGM/enemy4.mp3", waitForCompletion: true) //攻撃BGMの読み込み
            
            let ABGM = SKAudioNode(fileNamed: "BGM/enemy4.mp3")
            ABGM.autoplayLooped = false
            Eobject.addChild(ABGM)
            let BGMplay = SKAction.run { ABGM.run(SKAction.play()) }                                   //攻撃BGMの再生
            
            //攻撃アクション（ファイアーボールを生成して発射する）
            let FireBall = SKAction.run {
                fireflag = false                                                           //攻撃アクション（ファイアボール作成）使用禁止
                guard let fireball = SKEmitterNode(fileNamed: "FireBall") else { return }  //炎のエフェクトの読み込み
                let ball = SKShapeNode(circleOfRadius: self.ww * fireballsize)             //炎の大きさの円を作成
                var firep:CGPoint!                                                         //炎の作成位置を管理
                if enemyDD { firep = CGPoint(x: Eobject.position.x + 120 * self.ww, y: Eobject.position.y - 20 * self.ww) } //右向きの場合の炎の作成位置
                else{firep = CGPoint(x: Eobject.position.x - 120 * self.ww, y: Eobject.position.y - 20 * self.ww)}          //左向きの場合の炎の作成位置
                fireball.position = firep                                                  //炎のエフェクト位置を定義
                ball.position = firep                                                      //炎の大きさの円の位置を定義
                ball.physicsBody = SKPhysicsBody(circleOfRadius: fireballsize * self.ww)   //炎の大きさの円に物理ボディを定義
                ball.physicsBody?.categoryBitMask = self.damage2Category                   //炎の物理ボディの当たり判定の定義
                ball.physicsBody?.contactTestBitMask = self.damage2CT                      //炎の物理ボディの当たり判定の定義
                ball.physicsBody?.collisionBitMask = self.damage2Co                        //炎の物理ボディの当たり判定の定義
                ball.physicsBody?.mass = 20                                                //炎の物理ボディの質量を定義（これがファイアーボールの攻撃力になる）
                ball.physicsBody?.isDynamic = false                                        //炎の物理ボディが他の力の影響を受けなくする
                ball.alpha = 0                                                             //炎の物理ボディを透明にする
                self.addChild(fireball)                                                    //炎のエフェクトをシーンに追加
                var Angle: CGFloat!
                self.run(SKAction.wait(forDuration: firemovetime - 0.3)){
                    self.addChild(ball)                                                        //炎の物理ボディをシーンに追加
                    Angle = self.angle(p1: ball.position , p2: self.playerMoveSensorBlock.position)  //炎の発射方向の計算
                }
                self.run(SKAction.wait(forDuration: firemovetime)){                                  //以下のプログラムを時間差で実行
                    let dx = fireballspeed * self.ww * sin(Angle)                                    //炎の発射方向の計算
                    let dy = fireballspeed * self.ww * -cos(Angle)                                   //炎の発射方向の計算
                    if enemyDD{ Eobject.run(REAanime)  }else{ Eobject.run(LEAanime)  }               //攻撃後アニメの実行（ファイアボールの発射アニメ）
                    let FMAction = SKAction.repeatForever(SKAction.moveBy(x: dx, y: dy, duration: 1.0)) //ファイアボールの発射するアクションを定義
                    ball.run(FMAction)                                                                  //ファイアボールのエフェクトに発射アクションを実行
                    fireball.run(FMAction)                                                              //ファイアボールの物理ボディに発射アクションを実行
                    self.run(SKAction.wait(forDuration: firedeletetime)){                            //以下のプログラムを時間差で実行
                        ball.removeFromParent()                                                        //ファイアボールの物理ボディを消去
                        fireball.removeFromParent()                                                    //ファイアボールのエフェクトを消去
                    }
                }
            }
            let FwaitAction = SKAction.wait(forDuration: fireinterval)                                   //攻撃後硬直アクションの定義
            var RAaction = SKAction.sequence([RAanime,BGMplay,FireBall,FwaitAction])                     //右攻撃アクションの定義
            var LAaction = SKAction.sequence([LAanime,BGMplay,FireBall,FwaitAction])                     //左攻撃アクションの定義
            //攻撃後実行するコードを定義
            let lastAction = SKAction.run {
                Eobject.removeAllActions()  //敵の実行中アクションを停止
                let pdis = self.distance(p1: self.playerMoveSensorBlock.position, p2: Eobject.position) //敵とプレイヤーの距離を計算
                let pdx = Eobject.position.x - self.playerMoveSensorBlock.position.x                    //敵がプレイヤーの右にいるかひ左いにいるかの判定
                if pdx <= 0{ enemyDD = true }else{ enemyDD = false }                                    //向きの判定
                if pdis.abs() < self.h / 10 * ActionDistance && fireflag{                               //攻撃アクションを行う場合
                    if enemyDD{ Eobject.run(RAaction) }else{ Eobject.run(LAaction) }                       //攻撃アクションを実行
                }else{                                                                                  //攻撃アクションを行わない場合
                    if enemyDD{ Eobject.run(SKAction.setTexture(self.enemy4R[0])) }                        //敵の向きを変更
                    else{ Eobject.run(SKAction.setTexture(self.enemy4L[0])) }                              //敵の向きを変更
                    Eobject.run(moveAction)                                                                //ムーブアクションを実行
                }
            }
            moveAction = SKAction.run{
                fireflag = true
                point = nextrandam[point].randomElement()!
                let dx = movepoint[point].x - Eobject.position.x
                let dy = movepoint[point].y - Eobject.position.y
                let move = SKAction.moveBy(x: dx, y: dy, duration: movetime)
                Eobject.run(move)
                self.run(SKAction.wait(forDuration: movetime)){ Eobject.run(lastAction) }
            }
            RAaction = SKAction.sequence([RAaction,lastAction])
            LAaction = SKAction.sequence([LAaction,lastAction])
            Eobject.run(lastAction)
        }else if 41 <= type && type <= 50{
            var movedistance: CGFloat = 4 //移動範囲　（１が横幅の1/10）
            var LinerSplit = 100 //直線動作の分割数
            var RotateSplit = 36 //回転動作の分割数
            if type == 41 || type == 44
            { movedistance = 4; LinerSplit = 100; RotateSplit = 36 }
            if type == 42 || type == 45
            { movedistance = 0; LinerSplit = 10; RotateSplit = 10 }
            if type == 43 || type == 46
            { movedistance = 4; LinerSplit = 10; RotateSplit = 30 }
            let onetime: Double = 0.1 //一こまの動作時間
            let FEpoint = Eobject.position
            var RotateN = Int.random(in: 1 ... RotateSplit)
            var LinerN = 1
            var LinerCange = true
            var lastAction:SKAction!
            let firstAction = SKAction.run {
                //敵の向きを変更
                let pdx = self.playerMoveSensorBlock.position.x - Eobject.position.x
                if enemyDD == false && pdx >= 0 { Eobject.run(SKAction.setTexture(self.enemy5[0])); enemyDD = true }
                if enemyDD && pdx < 0 { Eobject.run(SKAction.setTexture(self.enemy5[1])); enemyDD = false }
                self.run(lastAction)
            }
            
            lastAction = SKAction.run{
                let Epoint = Eobject.position //現在の敵の位置
                let Linerdis = CGFloat(LinerN) / CGFloat(LinerSplit) * movedistance * self.h / 10
                let Rsita = CGFloat(RotateN) / CGFloat(RotateSplit) * 360 * self.psita
                let Npoint = CGPoint(x: FEpoint.x + Linerdis * cos(Rsita), y: FEpoint.y + Linerdis * sin(Rsita)) //移動地点
                
                RotateN += 1 ;if RotateN > RotateSplit { RotateN = 1 }
                
                if LinerCange { LinerN += 1 } else { LinerN -= 1 }
                if LinerN == LinerSplit { LinerCange = false }
                if LinerN == 0 { LinerCange = true }
                
                var moveAction = SKAction.moveBy(x: Npoint.x - Epoint.x, y: Npoint.y - Epoint.y, duration: onetime)
                moveAction = SKAction.sequence([moveAction,firstAction])
                Eobject.run(moveAction)
            }
            run(firstAction)
        }else if 51 <= type && type <= 60{
            var movetype = 1         //移動タイプ (1:通常 2:縦 3:横 4:四角 5:ひし形)
            var Attackfrequency = 1  //攻撃頻度　（1:小   2:大）
            if type == 51{ movetype = 1; Attackfrequency = 1 }
            if type == 52{ movetype = 2; Attackfrequency = 1 }
            if type == 53{ movetype = 3; Attackfrequency = 1 }
            if type == 54{ movetype = 4; Attackfrequency = 1 }
            if type == 55{ movetype = 5; Attackfrequency = 1 }
            if type == 56{ movetype = 1; Attackfrequency = 2 }
            if type == 57{ movetype = 2; Attackfrequency = 2 }
            if type == 58{ movetype = 3; Attackfrequency = 2 }
            if type == 59{ movetype = 4; Attackfrequency = 2 }
            if type == 60{ movetype = 5; Attackfrequency = 2 }
            var movetime = 3.0                 //移動時間
            var fireballspeed: CGFloat = 250.0 //ファイアボールのスピード
            var firedeletetime = 4.0           //ファイアボールが発射されてから消滅するまでの時間
            var fireinterval = 4.0             //ファイアボールを生成したから次のアクション起こすまでの時間
            
            if Attackfrequency == 1{
                movetime = 3.0
                fireballspeed = 300.0
                firedeletetime = 4.0
                fireinterval = 4.0
            }else{
                movetime = 2.0
                fireballspeed = 400.0
                firedeletetime = 5.0
                fireinterval = 2.0
            }
            var moved: CGFloat = 5             //移動距離
            let ActionDistance: CGFloat = 12    //攻撃アクションの使用範囲
            
            
            moved = moved * h / 10
            let animetime = 0.5           //攻撃モーションの時間
            let fireballsize:CGFloat = 100 //ファイアボールの当たり判定の大きさ
            let firemovetime = 1.3        //ファイアボールを生成してから発射するまでの時間
            var fireflag: Bool = false    //攻撃可能かの判定
            let ep = Eobject.position     //初期の敵位置
            var movepoint: [CGPoint] = [] //移動ポイントの生成
            for ny in -1...1{
                for nx in -1...1{
                    movepoint.append(CGPoint(x: ep.x + CGFloat(nx) * moved, y: ep.y + CGFloat(ny) * moved))
                }
            } //移動ポイントの生成はここまで
            //次の移動地点
            var nextrandam: [[Int]] = [[1,3,4],[0,2,3,4,5],[1,4,5],[0,1,4,6,7],[0,1,2,3,5,6,7,8],[1,2,4,7,8],[3,4,7],[3,4,5,6,8],[4,5,7]]
            if movetype == 2{
                nextrandam[1] = [4,7]
                nextrandam[4] = [1,7]
                nextrandam[7] = [1,4]
            }
            if movetype == 3{
                nextrandam[3] = [4,5]
                nextrandam[4] = [3,5]
                nextrandam[5] = [3,4]
            }
            if movetype == 4{
                nextrandam[4] = [0,2,6,8]
                nextrandam[0] = [2,6]
                nextrandam[2] = [0,8]
                nextrandam[6] = [0,8]
                nextrandam[8] = [2,6]
            }
            if movetype == 5{
                nextrandam[4] = [1,3,5,7]
                nextrandam[1] = [3,5]
                nextrandam[3] = [1,7]
                nextrandam[5] = [1,7]
                nextrandam[7] = [3,5]
            }
            var point = 4                                                                    //現在いるポイント
            var moveAction: SKAction!                                                        //移動アクションを管理
            let RAanime = SKAction.animate(with: enemy4R, timePerFrame: animetime / 10.0)    //右向き攻撃前アニメ
            let LAanime = SKAction.animate(with: enemy4L, timePerFrame: animetime / 10.0)    //左向き攻撃前アニメ
            let REAanime = SKAction.animate(with: enemy4RE, timePerFrame: animetime / 10.0)  //右向き攻撃後アニメ
            let LEAanime = SKAction.animate(with: enemy4LE, timePerFrame: animetime / 10.0)  //左向き攻撃後アニメ
            let ABGM = SKAudioNode(fileNamed: "BGM/enemy4.mp3")
            ABGM.autoplayLooped = false
            Eobject.addChild(ABGM)
            let BGMplay = SKAction.run { ABGM.run(SKAction.play()) }                                   //攻撃BGMの再生                        //攻撃BGMの再生
            //攻撃アクション（ファイアーボールを生成して発射する）
            let FireBall = SKAction.run {
                fireflag = false                                                           //攻撃アクション（ファイアボール作成）使用禁止
                guard let fireball = SKEmitterNode(fileNamed: "FireBall2") else { return }  //炎のエフェクトの読み込み
                let ball = SKShapeNode(circleOfRadius: self.ww * fireballsize)             //炎の大きさの円を作成
                var firep:CGPoint!                                                         //炎の作成位置を管理
                if enemyDD { firep = CGPoint(x: Eobject.position.x + 140 * self.ww, y: Eobject.position.y - 20 * self.ww) } //右向きの場合の炎の作成位置
                else{firep = CGPoint(x: Eobject.position.x - 140 * self.ww, y: Eobject.position.y - 20 * self.ww)}          //左向きの場合の炎の作成位置
                fireball.position = firep                                                  //炎のエフェクト位置を定義
                ball.position = firep                                                      //炎の大きさの円の位置を定義
                ball.physicsBody = SKPhysicsBody(circleOfRadius: fireballsize * self.ww)   //炎の大きさの円に物理ボディを定義
                ball.physicsBody?.categoryBitMask = self.damage2Category                   //炎の物理ボディの当たり判定の定義
                ball.physicsBody?.contactTestBitMask = self.damage2CT                      //炎の物理ボディの当たり判定の定義
                ball.physicsBody?.collisionBitMask = self.damage2Co                        //炎の物理ボディの当たり判定の定義
                ball.physicsBody?.mass = 20                                                //炎の物理ボディの質量を定義（これがファイアーボールの攻撃力になる）
                ball.physicsBody?.isDynamic = false                                        //炎の物理ボディが他の力の影響を受けなくする
                ball.alpha = 0                                                             //炎の物理ボディを透明にする
                self.addChild(fireball)                                                    //炎のエフェクトをシーンに追加
                var Angle: CGFloat!
                self.run(SKAction.wait(forDuration: firemovetime - 0.3)){
                    self.addChild(ball)                                                        //炎の物理ボディをシーンに追加
                    Angle = self.angle(p1: ball.position , p2: self.playerMoveSensorBlock.position)  //炎の発射方向の計算
                }
                self.run(SKAction.wait(forDuration: firemovetime)){                                  //以下のプログラムを時間差で実行
                    let dx = fireballspeed * self.ww * sin(Angle)                                    //炎の発射方向の計算
                    let dy = fireballspeed * self.ww * -cos(Angle)                                   //炎の発射方向の計算
                    if enemyDD{ Eobject.run(REAanime)  }else{ Eobject.run(LEAanime)  }               //攻撃後アニメの実行（ファイアボールの発射アニメ）
                    let FMAction = SKAction.repeatForever(SKAction.moveBy(x: dx, y: dy, duration: 1.0)) //ファイアボールの発射するアクションを定義
                    ball.run(FMAction)                                                                  //ファイアボールのエフェクトに発射アクションを実行
                    fireball.run(FMAction)                                                              //ファイアボールの物理ボディに発射アクションを実行
                    self.run(SKAction.wait(forDuration: firedeletetime)){                            //以下のプログラムを時間差で実行
                        ball.removeFromParent()                                                        //ファイアボールの物理ボディを消去
                        fireball.removeFromParent()                                                    //ファイアボールのエフェクトを消去
                    }
                }
            }
            let FwaitAction = SKAction.wait(forDuration: fireinterval)                                   //攻撃後硬直アクションの定義
            var RAaction = SKAction.sequence([RAanime,BGMplay,FireBall,FwaitAction])                     //右攻撃アクションの定義
            var LAaction = SKAction.sequence([LAanime,BGMplay,FireBall,FwaitAction])                     //左攻撃アクションの定義
            //攻撃後実行するコードを定義
            let lastAction = SKAction.run {
                Eobject.removeAllActions()  //敵の実行中アクションを停止
                let pdis = self.distance(p1: self.playerMoveSensorBlock.position, p2: Eobject.position) //敵とプレイヤーの距離を計算
                let pdx = Eobject.position.x - self.playerMoveSensorBlock.position.x                    //敵がプレイヤーの右にいるかひ左いにいるかの判定
                if pdx <= 0{ enemyDD = true }else{ enemyDD = false }                                    //向きの判定
                if pdis.abs() < self.h / 10 * ActionDistance && fireflag{                               //攻撃アクションを行う場合
                    if enemyDD{ Eobject.run(RAaction) }else{ Eobject.run(LAaction) }                       //攻撃アクションを実行
                }else{                                                                                  //攻撃アクションを行わない場合
                    if enemyDD{ Eobject.run(SKAction.setTexture(self.enemy4R[0])) }                        //敵の向きを変更
                    else{ Eobject.run(SKAction.setTexture(self.enemy4L[0])) }                              //敵の向きを変更
                    Eobject.run(moveAction)                                                                //ムーブアクションを実行
                }
            }
            moveAction = SKAction.run{
                fireflag = true
                point = nextrandam[point].randomElement()!
                let dx = movepoint[point].x - Eobject.position.x
                let dy = movepoint[point].y - Eobject.position.y
                let move = SKAction.moveBy(x: dx, y: dy, duration: movetime)
                Eobject.run(move)
                self.run(SKAction.wait(forDuration: movetime)){ Eobject.run(lastAction) }
            }
            RAaction = SKAction.sequence([RAaction,lastAction])
            LAaction = SKAction.sequence([LAaction,lastAction])
            Eobject.run(lastAction)
        }
        EE = true
    }
    
    func enemyActionstop(number:Int){
        enemy[number].removeAllActions()
    }
    
    func enemydelete(kill:Bool,number:Int){
        let EnemyAppearancePoint = enemypnumber[number]  //敵の出現ポイント
        if kill{
            enemynmax[EnemyAppearancePoint] -= 1
            if enemyClearflag[EnemyAppearancePoint] { enemyCC -= 1  }
            if enemynmax[EnemyAppearancePoint] == 0 && enemySwitchNumber[EnemyAppearancePoint + 1][0] != 0{ //スイッチ関数起動の条件
                for n in 0..<enemySwitchNumber[EnemyAppearancePoint + 1].count{
                     run(BlockAction[BlockActionNumber[enemySwitchNumber[EnemyAppearancePoint + 1][n]]])
                }
            }
        }
        enemy[number].removeFromParent()
        enemynpre[enemypnumber[number]] -= 1
        enemy.remove(at: number)
        enemyN.remove(at: number)
        enemypnumber.remove(at: number)
        enemyHP.remove(at: number)
        enemyDamage.remove(at: number)
        enemyDamageflag.remove(at: number)
        enemyActionflag.remove(at: number)
        enemyDBGM.remove(at: number)
     //   enemypsave.remove(at: number)
        ecount -= 1
        EE = true
    }
    
    func addgoal(xp:CGFloat, yp:CGFloat,BlockNumber n:Int = 0){
        let h1 = h / 10
        let goal = SKSpriteNode(imageNamed: "goal")
        goal.scale(to: CGSize(width: h1 * 2, height: h1 * 3))
        goal.position = CGPoint(x: h1 * xp + h1 , y: h1 * yp + 3 / 2 * h1)
        goal.physicsBody = SKPhysicsBody(rectangleOf: goal.size)
        goal.physicsBody?.affectedByGravity = false
        goal.physicsBody?.isDynamic = false
        goal.physicsBody?.categoryBitMask = goalCategory
        goal.physicsBody?.contactTestBitMask = goalCT
        goal.physicsBody?.collisionBitMask = goalCo
        if n != 0{
            Block.append(goal)
            BlockNumber[n] = Block.count
        }
        addChild(goal)
    }
    
    
    func addBlock(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,angle:Double = 0.0,type:Int = 1 ,pattern:Int = 1 ,BlockNumber n: Int = 0){
        //type:     1,青    2,黄   3,茶   4,紫
        //pattern:  1,四角  2,L字  3,コの字
        let h1 = h / 10
        let xn = Int(xs)
        let yn = Int(ys)
        let Blockname: String = "block" + String(type)
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: h1 * xs, height: h1 * ys), false, 0.0)
        for yi in 0 ..< yn{
            for xi in 0 ..< xn{
                if pattern == 1{
                    if let block = UIImage(named: Blockname){
                        block.draw(in: CGRect(x:h1 * CGFloat(xi), y: h1 * CGFloat(yi), width: h1, height: h1))
                    }
                }else if pattern == 2{
                    if yi == yn - 1 || xi == 0{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:h1 * CGFloat(xi), y: h1 * CGFloat(yi), width: h1, height: h1))
                        }
                    }
                }else {
                    if yi == 0 || xi == xn - 1 || yi == yn - 1{
                        if let block = UIImage(named: Blockname){
                            block.draw(in: CGRect(x:h1 * CGFloat(xi), y: h1 * CGFloat(yi), width: h1, height: h1))
                        }
                    }
                }
            }
        }
        let Blockimage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let BlockTexter = SKTexture(image: Blockimage )
        let BlockSprite = SKSpriteNode(texture: BlockTexter)
        BlockSprite.scale(to: CGSize(width: h1 * xs, height: h1 *  ys))
        BlockSprite.position = CGPoint(x: h1 / 2 * xs + h1 * xp, y: h1 / 2 * ys + h1 * yp)
        BlockSprite.physicsBody = SKPhysicsBody(texture: BlockTexter, size: BlockSprite.size)
        if pattern == 1{ BlockSprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: h1 * xs, height: h1 * ys)) }
        BlockSprite.zRotation = CGFloat(angle * .pi / 180)
        BlockSprite.physicsBody?.restitution = 0.1
        BlockSprite.physicsBody?.affectedByGravity = false
        BlockSprite.physicsBody?.isDynamic = false
        BlockSprite.physicsBody?.categoryBitMask = blockCategory
        BlockSprite.physicsBody?.contactTestBitMask = blockCT
        BlockSprite.physicsBody?.collisionBitMask = blockCo
        if n != 0{
            Block.append(BlockSprite)
            BlockNumber[n] = Block.count
        }
        addChild(BlockSprite)
    }
    
    func addsquare(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,angle:Double = 0.0,type:Int = 1 ,BlockNumber n: Int = 0){
        
        let squaretext = SKTexture(imageNamed: "square")
        let square = SKSpriteNode(texture: squaretext)
        square.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        square.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        square.physicsBody = SKPhysicsBody(rectangleOf: square.size)
        square.zRotation = CGFloat(angle * .pi / 180)
        square.physicsBody?.restitution = 0
        square.physicsBody?.affectedByGravity = false
        square.physicsBody?.isDynamic = false
        square.physicsBody?.categoryBitMask = blockCategory
        square.physicsBody?.contactTestBitMask = blockCT
        square.physicsBody?.collisionBitMask = blockCo
        if type == 2{
            square.physicsBody?.categoryBitMask = block2Category
            square.physicsBody?.contactTestBitMask = block2CT
            square.physicsBody?.collisionBitMask = block2Co
            square.alpha = 0.5
        }
        if n != 0{
            Block.append(square)
            BlockNumber[n] = Block.count
        }
        addChild(square)
    }
  
    func addtraiangr(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,mirror:Bool, angle:Double = 0.0,type:Int = 1, n: Int = 0){
        var traiangrtext: SKTexture!
        if mirror{
            traiangrtext = SKTexture(imageNamed: "traiangr2")
        }else{
            traiangrtext = SKTexture(imageNamed: "traiangr")
        }
        let traiangr = SKSpriteNode(texture: traiangrtext)
        traiangr.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        traiangr.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        traiangr.physicsBody = SKPhysicsBody(texture: traiangrtext, size: traiangr.frame.size)
        traiangr.zRotation = CGFloat(angle * .pi / 180)
        traiangr.physicsBody?.restitution = 0.1
        traiangr.physicsBody?.affectedByGravity = false
        traiangr.physicsBody?.isDynamic = false
        traiangr.physicsBody?.categoryBitMask = blockCategory
        traiangr.physicsBody?.contactTestBitMask = blockCT
        traiangr.physicsBody?.collisionBitMask = blockCo
        if type == 2{
            traiangr.physicsBody?.categoryBitMask = block2Category
            traiangr.physicsBody?.contactTestBitMask = block2CT
            traiangr.physicsBody?.collisionBitMask = block2Co
            traiangr.alpha = 0.5
        }
        if n != 0{
            Block.append(traiangr)
            BlockNumber[n] = Block.count
        }
        addChild(traiangr)
    }
    
    func addcircle(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat,type:Int = 1 ,BloclNumber n: Int = 0){
        let circletext = SKTexture(imageNamed: "circle")
        let circle = SKSpriteNode(texture: circletext)
        circle.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        circle.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        circle.physicsBody = SKPhysicsBody(texture: circletext, size:circle.frame.size)
        circle.physicsBody?.restitution = 0.0
        circle.physicsBody?.affectedByGravity = false
        circle.physicsBody?.isDynamic = false
        circle.physicsBody?.categoryBitMask = blockCategory
        circle.physicsBody?.contactTestBitMask = blockCT
        circle.physicsBody?.collisionBitMask = blockCo
        if type == 2{
            circle.physicsBody?.categoryBitMask = block2Category
            circle.physicsBody?.contactTestBitMask = block2CT
            circle.physicsBody?.collisionBitMask = block2Co
            circle.alpha = 0.5
        }
        if n != 0{
            Block.append(circle)
            BlockNumber[n] = Block.count
        }
        addChild(circle)
    }
    
    func addcircle2(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,tate:Bool, angle:Double = 0.0 ,type:Int = 1 , n: Int = 0){
        var circle2text: SKTexture!
        if tate{
            circle2text = SKTexture(imageNamed: "circle2_2")
        }else{
            circle2text = SKTexture(imageNamed: "circle2")
        }
        let circle2 = SKSpriteNode(texture: circle2text)
        circle2.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        circle2.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        circle2.physicsBody = SKPhysicsBody(texture: circle2text, size: circle2.frame.size)
        circle2.zRotation = CGFloat(angle * .pi / 180)
        circle2.physicsBody?.restitution = 0.1
        circle2.physicsBody?.affectedByGravity = false
        circle2.physicsBody?.isDynamic = false
        circle2.physicsBody?.categoryBitMask = blockCategory
        circle2.physicsBody?.contactTestBitMask = blockCT
        circle2.physicsBody?.collisionBitMask = blockCo
        if type == 2{
            circle2.physicsBody?.categoryBitMask = block2Category
            circle2.physicsBody?.contactTestBitMask = block2CT
            circle2.physicsBody?.collisionBitMask = block2Co
            circle2.alpha = 0.5
        }
        if n != 0{
            Block.append(circle2)
            BlockNumber[n] = Block.count
        }
        addChild(circle2)
    }
    
    func addcircle3(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,mirror:Bool, angle:Double = 0.0 ,type:Int = 1, n: Int = 0){
        var circle3text: SKTexture!
        if mirror{
            circle3text = SKTexture(imageNamed: "circle3_2")
        }else{
            circle3text = SKTexture(imageNamed: "circle3")
        }
        let circle3 = SKSpriteNode(texture: circle3text)
        circle3.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        circle3.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        circle3.physicsBody = SKPhysicsBody(texture: circle3text, size: circle3.frame.size)
        circle3.zRotation = CGFloat(angle * .pi / 180)
        circle3.physicsBody?.restitution = 0.1
        circle3.physicsBody?.affectedByGravity = false
        circle3.physicsBody?.isDynamic = false
        circle3.physicsBody?.categoryBitMask = blockCategory
        circle3.physicsBody?.contactTestBitMask = blockCT
        circle3.physicsBody?.collisionBitMask = blockCo
        if type == 2{
            circle3.physicsBody?.categoryBitMask = block2Category
            circle3.physicsBody?.contactTestBitMask = block2CT
            circle3.physicsBody?.collisionBitMask = block2Co
            circle3.alpha = 0.5
        }
        if n != 0{
            Block.append(circle3)
            BlockNumber[n] = Block.count
        }
        addChild(circle3)
    }
    
    func addredcircle(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat, Damage: CGFloat = 10,playerContact:Bool = true ,BlockNumber n: Int = 0){
        let redcircletext = SKTexture(imageNamed: "redcircle")
        let redcircle = SKSpriteNode(texture: redcircletext)
        redcircle.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        redcircle.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        redcircle.physicsBody = SKPhysicsBody(texture: redcircletext, size: redcircle.frame.size)
        redcircle.physicsBody?.restitution = 0.0
        redcircle.physicsBody?.affectedByGravity = false
        redcircle.physicsBody?.isDynamic = false
        redcircle.physicsBody?.categoryBitMask = damageCategory
        redcircle.physicsBody?.contactTestBitMask = damageCT
        redcircle.physicsBody?.collisionBitMask = damageCo
        redcircle.physicsBody?.mass = Damage
        if playerContact == false{
            redcircle.physicsBody?.categoryBitMask = damage2Category
            redcircle.physicsBody?.contactTestBitMask = damage2CT
            redcircle.physicsBody?.collisionBitMask = damage2Co
            redcircle.alpha = 0.5
        }
        if n != 0{
            Block.append(redcircle)
            BlockNumber[n] = Block.count
        }
        addChild(redcircle)
    }
    
    func addredcircle2(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,tate:Bool ,angle: Double = 0.0, Damage: CGFloat = 10,playerContact:Bool = true,n: Int = 0){
        var redcircle2text: SKTexture!
        if tate{
            redcircle2text = SKTexture(imageNamed: "redcircle2_2")
        }else{
            redcircle2text = SKTexture(imageNamed: "redcircle2")
        }
        let redcircle2 = SKSpriteNode(texture: redcircle2text)
        redcircle2.scale(to: CGSize(width: h / 10 * xs, height: h / 10 * ys))
        redcircle2.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        redcircle2.physicsBody = SKPhysicsBody(texture: redcircle2text, size: redcircle2.frame.size)
        redcircle2.zRotation = CGFloat(angle * .pi / 180)
        redcircle2.physicsBody?.restitution = 0.0
        redcircle2.physicsBody?.affectedByGravity = false
        redcircle2.physicsBody?.isDynamic = false
        redcircle2.physicsBody?.categoryBitMask = damageCategory
        redcircle2.physicsBody?.contactTestBitMask = damageCT
        redcircle2.physicsBody?.collisionBitMask = damageCo
        redcircle2.physicsBody?.mass = Damage
        if playerContact == false{
            redcircle2.physicsBody?.categoryBitMask = damage2Category
            redcircle2.physicsBody?.contactTestBitMask = damage2CT
            redcircle2.physicsBody?.collisionBitMask = damage2Co
            redcircle2.alpha = 0.5
        }
        if n != 0{
            Block.append(redcircle2)
            BlockNumber[n] = Block.count
        }
        addChild(redcircle2)
    }
    
    func addredsquare(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat,Damage: CGFloat ,angle: Double = 0.0 ,playerContact:Bool = true,BloclNumber n: Int = 0){
        let redsquaretext = SKTexture(imageNamed: "redsquare")
        let redsquare = SKSpriteNode(texture: redsquaretext)
        redsquare.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        redsquare.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        redsquare.physicsBody = SKPhysicsBody(texture: redsquaretext, size: redsquare.frame.size)
        redsquare.zRotation = CGFloat(angle * .pi / 180)
        redsquare.physicsBody?.restitution = 0.0
        redsquare.physicsBody?.affectedByGravity = false
        redsquare.physicsBody?.isDynamic = false
        redsquare.physicsBody?.categoryBitMask = damageCategory
        redsquare.physicsBody?.contactTestBitMask = damageCT
        redsquare.physicsBody?.collisionBitMask = damageCo
        redsquare.physicsBody?.mass = Damage
        if playerContact == false{
            redsquare.physicsBody?.categoryBitMask = damage2Category
            redsquare.physicsBody?.contactTestBitMask = damage2CT
            redsquare.physicsBody?.collisionBitMask = damage2Co
            redsquare.alpha = 0.5
        }
        if n != 0{
            Block.append(redsquare)
            BlockNumber[n] = Block.count
        }
        addChild(redsquare)
    }
    
    func addredtraiangr(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,tate:Bool,angle: Double = 0.0, Damage: CGFloat = 10,playerContact:Bool = true,n: Int = 0){
        var redtraiangrtext: SKTexture
        if tate{
            redtraiangrtext = SKTexture(imageNamed: "redtraiangr2")
        }else{
            redtraiangrtext = SKTexture(imageNamed: "redtraiangr")
        }
        let redtraiangr = SKSpriteNode(texture: redtraiangrtext)
        redtraiangr.scale(to: CGSize(width: h / 10 * xs, height: h / 10 *  ys))
        redtraiangr.position = CGPoint(x: h / 20 * xs + h / 10 * xp, y: h / 20 * ys + h / 10 * yp)
        redtraiangr.physicsBody = SKPhysicsBody(texture: redtraiangrtext, size: redtraiangr.frame.size)
        redtraiangr.zRotation = CGFloat(angle * .pi / 180)
        redtraiangr.physicsBody?.restitution = 0.0
        redtraiangr.physicsBody?.affectedByGravity = false
        redtraiangr.physicsBody?.isDynamic = false
        redtraiangr.physicsBody?.categoryBitMask = damageCategory
        redtraiangr.physicsBody?.contactTestBitMask = damageCT
        redtraiangr.physicsBody?.collisionBitMask = damageCo
        redtraiangr.physicsBody?.mass = Damage
        if playerContact == false{
            redtraiangr.physicsBody?.categoryBitMask = damage2Category
            redtraiangr.physicsBody?.contactTestBitMask = damage2CT
            redtraiangr.physicsBody?.collisionBitMask = damage2Co
            redtraiangr.alpha = 0.5
        }
        if n != 0{
            Block.append(redtraiangr)
            BlockNumber[n] = Block.count
        }
        addChild(redtraiangr)
    }

    func addplayer(px:CGFloat ,py:CGFloat){
        //変換する係数の作成
        let ww = h / 1000
        let pxx = px * 100
        let pyy = py * 100
    
        //プレイヤー当たり判定のサイズ
        let players:[CGFloat] = [40,180]
        //胴体 テクスチャー
        let bodys:[CGFloat] = [58,200]  //サイズ
        //胴体　当たり判定
        let Pbodys:[CGFloat] = [58,120]  //サイズ
        let Pbodyp:[CGFloat] = [0,40]    //位置

        
        //足先
        let leg1s:[CGFloat] = [200,210] //サイズ
        let leg1p:[CGFloat] = [-1,-43]  //位置
        //足根元
        let leg2s:[CGFloat] = [25,60]   //サイズ
        let leg2p:[CGFloat] = [0,-20]   //位置
        //腕先
        let arm1s:[CGFloat] = [300,400] //サイズ
        let arm1p:[CGFloat] = [-1,35]   //位置
        //腕根元
        let arm2s:[CGFloat] = [11,45]   //サイズ
        let arm2p:[CGFloat] = [0,52]    //位置
  
        //ジョイント点
        let jleg2p:CGFloat = 20
        let jarm2p:CGFloat = 20
        
        //胴体アニメーション画像の読み込み
        let bodyanimeAtlas = SKTextureAtlas(named: "bodyanime")
        
        for i in 1...36{
            leftbody.append(bodyanimeAtlas.textureNamed("body" + String(i)))
        }
        for i in 1...36{
            rightbody.append(bodyanimeAtlas.textureNamed("body" + String(37 - i)))
        }
        
        let leganimeAtlas = SKTextureAtlas(named: "leganime")
        for i in 1...24{
            leftleg.append(leganimeAtlas.textureNamed("leganime" + String(i)))
        }
        for i in 1...24{
            rightleg.append(leganimeAtlas.textureNamed("leganime" + String(25 - i)))
        }
        let kamaanimeAtlas01 = SKTextureAtlas(named: "kamaanime1")
        for i in 1...32{
            kamaA1L.append(kamaanimeAtlas01.textureNamed("kamaanime" + String(i)))
        }
        for i in 1...32{
            kamaA1R.append(kamaanimeAtlas01.textureNamed("kamaanime" + String(33 - i)))
        }
    
        //センサ位置とサイズ [px,py,sx,sy]
        
        var undersensor:[CGFloat] = [0,-95,10,20]
        var oversensor:[CGFloat] = [0,95,15,40]
        var rightsensor:[CGFloat] = [20,0,40,100]
        var leftsensor:[CGFloat] = [-20,0,40,100]
        
        //スケールの変換
        //プレイヤー本体
        let psx = ww * players[0]
        let psy = ww * players[1]
        let ppx = ww * pxx
        let ppy = ww * pyy
        //胴体
        let bsx = ww * bodys[0]
        let bsy = ww * bodys[1]
        let Pbsx = ww * Pbodys[0]
        let Pbsy = ww * Pbodys[1]
        let Pbpx = ww * (pxx + Pbodyp[0])
        let Pbpy = ww * (pyy + Pbodyp[1])

        //足
        let leg1sx = ww * leg1s[0]
        let leg1sy = ww * leg1s[1]
        let leg1px = ww * (pxx + leg1p[0])
        let leg1py = ww * (pyy + leg1p[1])
        let leg2sx = ww * leg2s[0]
        let leg2sy = ww * leg2s[1]
        let leg2px = ww * (pxx + leg2p[0])
        let leg2py = ww * (pyy + leg2p[1])
        //手
        let arm1sx = ww * arm1s[0]
        let arm1sy = ww * arm1s[1]
        let arm1px = ww * (pxx + arm1p[0])
        let arm1py = ww * (pyy + arm1p[1])
        let arm2sx = ww * arm2s[0]
        let arm2sy = ww * arm2s[1]
        let arm2px = ww * (pxx + arm2p[0])
        let arm2py = ww * (pyy + arm2p[1])
     
        undersensor[0] = ww * (pxx + undersensor[0])
        undersensor[1] = ww * (pyy + undersensor[1])
        undersensor[2] = ww * undersensor[2]
        undersensor[3] = ww * undersensor[3]
        oversensor[0] = ww * (pxx + oversensor[0])
        oversensor[1] = ww * (pyy + oversensor[1])
        oversensor[2] = ww * oversensor[2]
        oversensor[3] = ww * oversensor[3]
        rightsensor[0] = ww * (pxx + rightsensor[0])
        rightsensor[1] = ww * (pyy + rightsensor[1])
        rightsensor[2] = ww * rightsensor[2]
        rightsensor[3] = ww * rightsensor[3]
        leftsensor[0] = ww * (pxx + leftsensor[0])
        leftsensor[1] = ww * (pyy + leftsensor[1])
        leftsensor[2] = ww * leftsensor[2]
        leftsensor[3] = ww * leftsensor[3]
        
        let bodyPtexture = SKTexture(imageNamed: "Pbody")
        bodyPhysick = SKSpriteNode(texture: bodyPtexture)
        bodyPhysick.position = CGPoint(x: Pbpx, y: Pbpy)
        bodyPhysick.scale(to: CGSize(width: Pbsx, height: Pbsy))
        bodyPhysick.physicsBody = SKPhysicsBody(texture: leftbody[0], size: bodyPhysick.size)
        bodyPhysick.physicsBody?.categoryBitMask = playerCategory
        bodyPhysick.physicsBody?.contactTestBitMask = playerCT
        bodyPhysick.physicsBody?.collisionBitMask = playerCo
        bodyPhysick.physicsBody?.affectedByGravity = false
        bodyPhysick.physicsBody?.isDynamic = false
        bodyPhysick.physicsBody?.mass = 0.001
        bodyPhysick.alpha = 0
        bodyPhysick.physicsBody?.restitution = 0
        addChild(bodyPhysick)
        
        playerblockSensor = SKShapeNode.init(rectOf: CGSize(width: psx, height: psy))
        playerblockSensor.position = CGPoint(x: ppx, y: ppy)
        playerblockSensor.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: psx, height: psy))
        playerblockSensor.physicsBody?.categoryBitMask = charaBCategory
        playerblockSensor.physicsBody?.contactTestBitMask = charaBCT
        playerblockSensor.physicsBody?.collisionBitMask = charaBCo
        playerblockSensor.physicsBody?.restitution = 0
        playerblockSensor.physicsBody?.isDynamic = false
        playerblockSensor.physicsBody?.affectedByGravity = true
        playerblockSensor.physicsBody?.allowsRotation = true
        playerblockSensor.physicsBody?.mass = 1
        playerblockSensor.fillColor = .gray
        playerblockSensor.alpha = 0.5
        addChild(playerblockSensor)
        
        playerMoveSensorBlock = SKShapeNode.init(rectOf: CGSize(width: psy, height: psy))
        playerMoveSensorBlock.position = CGPoint(x: ppx, y: ppy)
        playerMoveSensorBlock.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: psy, height: psy))
        playerMoveSensorBlock.physicsBody?.categoryBitMask = charaBCategory
        playerMoveSensorBlock.physicsBody?.contactTestBitMask = charaBCT
        playerMoveSensorBlock.physicsBody?.collisionBitMask = charaBCo
        playerMoveSensorBlock.physicsBody?.restitution = 0
        playerMoveSensorBlock.physicsBody?.isDynamic = false
        playerMoveSensorBlock.physicsBody?.affectedByGravity = false
        playerMoveSensorBlock.physicsBody?.allowsRotation = false
        playerMoveSensorBlock.fillColor = .cyan
        playerMoveSensorBlock.alpha = 0.0
        addChild(playerMoveSensorBlock)
        
        underSensor1 = SKShapeNode(rectOf: CGSize(width: undersensor[2], height: undersensor[3]))
        underSensor1.position = CGPoint(x:undersensor[0] , y: undersensor[1])
        underSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: undersensor[2], height: undersensor[3]))
        underSensor1.physicsBody?.categoryBitMask = Sensor1Category
        underSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        underSensor1.physicsBody?.collisionBitMask = Sensor1Co
        underSensor1.physicsBody?.isDynamic = false
        underSensor1.physicsBody?.affectedByGravity = false
        underSensor1.fillColor = .red
        underSensor1.physicsBody?.allowsRotation = false
        underSensor1.alpha = 0
        addChild(underSensor1)
        
        underSensor2 = SKShapeNode(rectOf: CGSize(width: undersensor[2], height: undersensor[3]))
        underSensor2.position = CGPoint(x:undersensor[0] , y: undersensor[1])
        underSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: undersensor[2], height: undersensor[3]))
        underSensor2.physicsBody?.categoryBitMask = Sensor2Category
        underSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        underSensor2.physicsBody?.collisionBitMask = Sensor2Co
        underSensor2.physicsBody?.isDynamic = false
        underSensor2.physicsBody?.affectedByGravity = false
        underSensor2.fillColor = .gray
        underSensor2.physicsBody?.allowsRotation = false
        underSensor2.alpha = 0
        addChild(underSensor2)
        
        overSensor1 = SKShapeNode(rectOf: CGSize(width: oversensor[2], height: oversensor[3]))
        overSensor1.position = CGPoint(x:oversensor[0] , y: oversensor[1])
        overSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: oversensor[2], height: oversensor[3]))
        overSensor1.physicsBody?.categoryBitMask = Sensor1Category
        overSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        overSensor1.physicsBody?.collisionBitMask = Sensor1Co
        overSensor1.physicsBody?.isDynamic = false
        overSensor1.physicsBody?.affectedByGravity = false
        overSensor1.fillColor = .red
        overSensor1.alpha = 0
        overSensor1.physicsBody?.allowsRotation = false
        addChild(overSensor1)
        
        overSensor2 = SKShapeNode(rectOf: CGSize(width: oversensor[2], height: oversensor[3]))
        overSensor2.position = CGPoint(x:oversensor[0] , y: oversensor[1])
        overSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: oversensor[2], height: oversensor[3]))
        overSensor2.physicsBody?.categoryBitMask = Sensor2Category
        overSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        overSensor2.physicsBody?.collisionBitMask = Sensor2Co
        overSensor2.physicsBody?.isDynamic = false
        overSensor2.physicsBody?.affectedByGravity = false
        overSensor2.fillColor = .gray
        overSensor2.physicsBody?.allowsRotation = false
        overSensor2.alpha = 0
        addChild(overSensor2)

        rightSensor1 = SKShapeNode(rectOf: CGSize(width: rightsensor[2], height: rightsensor[3]))
        rightSensor1.position = CGPoint(x:rightsensor[0] , y: rightsensor[1])
        rightSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightsensor[2], height: rightsensor[3]))
        rightSensor1.physicsBody?.categoryBitMask = Sensor1Category
        rightSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        rightSensor1.physicsBody?.collisionBitMask = Sensor1Co
        rightSensor1.physicsBody?.isDynamic = false
        rightSensor1.physicsBody?.affectedByGravity = false
        rightSensor1.fillColor = .red
        rightSensor1.physicsBody?.allowsRotation = false
        rightSensor1.alpha = 0
        addChild(rightSensor1)
        
        rightSensor2 = SKShapeNode(rectOf: CGSize(width: rightsensor[2], height: rightsensor[3]))
        rightSensor2.position = CGPoint(x:rightsensor[0] , y: rightsensor[1])
        rightSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightsensor[2], height: rightsensor[3]))
        rightSensor2.physicsBody?.categoryBitMask = Sensor2Category
        rightSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        rightSensor2.physicsBody?.collisionBitMask = Sensor2Co
        rightSensor2.physicsBody?.isDynamic = false
        rightSensor2.physicsBody?.affectedByGravity = false
        rightSensor2.fillColor = .gray
        rightSensor2.physicsBody?.allowsRotation = false
        rightSensor2.alpha = 0
        addChild(rightSensor2)
        
        leftSensor1 = SKShapeNode(rectOf: CGSize(width: leftsensor[2], height: leftsensor[3]))
        leftSensor1.position = CGPoint(x:leftsensor[0] , y: leftsensor[1])
        leftSensor1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftsensor[2], height: leftsensor[3]))
        leftSensor1.physicsBody?.categoryBitMask = Sensor1Category
        leftSensor1.physicsBody?.contactTestBitMask = Sensor1CT
        leftSensor1.physicsBody?.collisionBitMask = Sensor1Co
        leftSensor1.physicsBody?.isDynamic = false
        leftSensor1.physicsBody?.affectedByGravity = false
        leftSensor1.fillColor = .red
        leftSensor1.physicsBody?.allowsRotation = false
        leftSensor1.alpha = 0
        addChild(leftSensor1)
        
        leftSensor2 = SKShapeNode(rectOf: CGSize(width: leftsensor[2], height: leftsensor[3]))
        leftSensor2.position = CGPoint(x:leftsensor[0] , y: leftsensor[1])
        leftSensor2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftsensor[2], height: leftsensor[3]))
        leftSensor2.physicsBody?.categoryBitMask = Sensor2Category
        leftSensor2.physicsBody?.contactTestBitMask = Sensor2CT
        leftSensor2.physicsBody?.collisionBitMask = Sensor2Co
        leftSensor2.physicsBody?.isDynamic = false
        leftSensor2.physicsBody?.affectedByGravity = false
        leftSensor2.fillColor = .gray
        leftSensor2.physicsBody?.allowsRotation = false
        leftSensor2.alpha = 0
        addChild(leftSensor2)
        
        underSensorS = SKShapeNode(rectOf: CGSize(width: undersensor[2], height: undersensor[3]))
        underSensorS.position = CGPoint(x:undersensor[0] , y: undersensor[1])
        underSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: undersensor[2], height: undersensor[3]))
        underSensorS.physicsBody?.categoryBitMask = 0
        underSensorS.physicsBody?.contactTestBitMask = 0
        underSensorS.physicsBody?.collisionBitMask = 0
        underSensorS.physicsBody?.isDynamic = false
        underSensorS.physicsBody?.affectedByGravity = false
        underSensorS.fillColor = .blue
        underSensorS.physicsBody?.allowsRotation = false
        underSensorS.alpha = 0
        addChild(underSensorS)
        
        overSensorS = SKShapeNode(rectOf: CGSize(width: oversensor[2], height: oversensor[3]))
        overSensorS.position = CGPoint(x:oversensor[0] , y: oversensor[1])
        overSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: oversensor[2], height: oversensor[3]))
        overSensorS.physicsBody?.categoryBitMask = 0
        overSensorS.physicsBody?.contactTestBitMask = 0
        overSensorS.physicsBody?.collisionBitMask = 0
        overSensorS.physicsBody?.isDynamic = false
        overSensorS.physicsBody?.affectedByGravity = false
        overSensorS.fillColor = .blue
        overSensorS.physicsBody?.allowsRotation = false
        overSensorS.alpha = 0
        addChild(overSensorS)
        
        rightSensorS = SKShapeNode(rectOf: CGSize(width: rightsensor[2], height: rightsensor[3]))
        rightSensorS.position = CGPoint(x:rightsensor[0] , y: rightsensor[1])
        rightSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rightsensor[2], height: rightsensor[3]))
        rightSensorS.physicsBody?.categoryBitMask = 0
        rightSensorS.physicsBody?.contactTestBitMask = 0
        rightSensorS.physicsBody?.collisionBitMask = 0
        rightSensorS.physicsBody?.isDynamic = false
        rightSensorS.physicsBody?.affectedByGravity = false
        rightSensorS.fillColor = .blue
        rightSensorS.physicsBody?.allowsRotation = false
        rightSensorS.alpha = 0
        addChild(rightSensorS)
        
        leftSensorS = SKShapeNode(rectOf: CGSize(width: leftsensor[2], height: leftsensor[3]))
        leftSensorS.position = CGPoint(x:leftsensor[0] , y: leftsensor[1])
        leftSensorS.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: leftsensor[2], height: leftsensor[3]))
        leftSensorS.physicsBody?.categoryBitMask = 0
        leftSensorS.physicsBody?.contactTestBitMask = 0
        leftSensorS.physicsBody?.collisionBitMask = 0
        leftSensorS.physicsBody?.isDynamic = false
        leftSensorS.physicsBody?.affectedByGravity = false
        leftSensorS.fillColor = .blue
        leftSensorS.physicsBody?.allowsRotation = false
        leftSensorS.alpha = 0
        addChild(leftSensorS)
        
        //胴体作成
        body = SKSpriteNode(texture: leftbody[0])
        body.position = CGPoint(x: ppx, y: ppy)
        body.scale(to: CGSize(width: bsx, height: bsy))
        body.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: psx, height: psy))
        body.physicsBody?.categoryBitMask = charaBCategory
        body.physicsBody?.contactTestBitMask = charaBCT
        body.physicsBody?.collisionBitMask = charaBCo
        body.physicsBody?.affectedByGravity = true
        body.physicsBody?.isDynamic = false
        body.physicsBody?.mass = 0.1
        body.physicsBody?.angularDamping = 0.5
        body.physicsBody?.restitution = 0
        addChild(body)

        //右足先作成
        leg11 = SKSpriteNode(texture: leftleg[0])
        leg11.position = CGPoint(x: leg1px, y: leg1py)
        leg11.scale(to: CGSize(width: leg1sx, height: leg1sy))
        leg11.physicsBody = SKPhysicsBody(texture: leftleg[11], size: CGSize(width: leg11.size.width * 0.9, height: leg11.size.height * 0.9))
        leg11.physicsBody?.categoryBitMask = playerCategory
        leg11.physicsBody?.contactTestBitMask = playerCT
        leg11.physicsBody?.collisionBitMask = playerCo
        leg11.physicsBody?.affectedByGravity = false
        leg11.physicsBody?.isDynamic = false
        leg11.physicsBody?.mass = 0.05
        addChild(leg11)

        //右足根元作成
        leg12text = SKTexture(imageNamed: "leg2")
        leg12 = SKSpriteNode(texture: leg12text)
        leg12.position = CGPoint(x: leg2px, y: leg2py)
        leg12.scale(to: CGSize(width: leg2sx, height: leg2sy))
        leg12.physicsBody = SKPhysicsBody(texture: leg12text, size: leg12.size)
        leg12.physicsBody?.categoryBitMask = playerCategory
        leg12.physicsBody?.contactTestBitMask = playerCT
        leg12.physicsBody?.collisionBitMask = playerCo
        leg12.physicsBody?.affectedByGravity = false
        leg12.physicsBody?.isDynamic = false
        leg12.physicsBody?.mass = 0.05
        addChild(leg12)

        //左足先作成
        leg21 = SKSpriteNode(texture: leftleg[0])
        leg21.position = CGPoint(x: leg1px, y: leg1py)
        leg21.scale(to: CGSize(width: leg1sx, height: leg1sy))
        leg21.physicsBody = SKPhysicsBody(texture: leftleg[11], size: CGSize(width: leg21.size.width * 0.9, height: leg21.size.height * 0.9))
        leg21.physicsBody?.categoryBitMask = playerCategory
        leg21.physicsBody?.contactTestBitMask = playerCT
        leg21.physicsBody?.collisionBitMask = playerCo
        leg21.physicsBody?.affectedByGravity = false
        leg21.physicsBody?.isDynamic = false
        leg21.physicsBody?.mass = 0.05
  //      leg21.run(SKAction.setTexture(leftleg[0]))
        addChild(leg21)
        
        //左根元作成
        leg22text = SKTexture(imageNamed: "leg2")
        leg22 = SKSpriteNode(texture: leg22text)
        leg22.position = CGPoint(x: leg2px, y: leg2py)
        leg22.scale(to: CGSize(width: leg2sx, height: leg2sy))
        leg22.physicsBody = SKPhysicsBody(texture: leg22text, size: leg22.size)
        leg22.physicsBody?.categoryBitMask = playerCategory
        leg22.physicsBody?.contactTestBitMask = playerCT
        leg22.physicsBody?.collisionBitMask = playerCo
        leg22.physicsBody?.affectedByGravity = false
        leg22.physicsBody?.isDynamic = false
        leg22.physicsBody?.mass = 0.05
        addChild(leg22)
        
        //右腕先作成
        arm11 = SKSpriteNode(texture: kamaA1L[0])
        arm11.position = CGPoint(x: arm1px, y: arm1py)
        arm11.scale(to: CGSize(width: arm1sx, height: arm1sy))
        arm11.physicsBody = SKPhysicsBody(rectangleOf: arm11.size)
        arm11.physicsBody?.categoryBitMask = 0
        arm11.physicsBody?.contactTestBitMask = 0
        arm11.physicsBody?.collisionBitMask = 0
        arm11.physicsBody?.affectedByGravity = false
        arm11.physicsBody?.isDynamic = false
        arm11.physicsBody?.affectedByGravity = false
        arm11.physicsBody?.linearDamping = 0.01
        addChild(arm11)
        
        let kamaRtexture = SKTexture(imageNamed: "kamaR")
        kamaR = SKSpriteNode(texture: kamaRtexture)
        kamaR.position = CGPoint(x: arm1px, y: arm1py)
        kamaR.scale(to: CGSize(width: arm1sx, height: arm1sy))
        kamaR.physicsBody = SKPhysicsBody(texture: kamaRtexture, size: CGSize(width: arm1sx * 1.1, height: arm1sy * 1.1))
        kamaR.physicsBody?.categoryBitMask = weaponCategory
        kamaR.physicsBody?.contactTestBitMask = weaponCT
        kamaR.physicsBody?.collisionBitMask = weaponCo
        kamaR.physicsBody?.affectedByGravity = false
        kamaR.physicsBody?.isDynamic = false
        kamaR.physicsBody?.mass = 0.0001
        kamaR.alpha = 0
        kamaXscale = kamaR.xScale
        kamaYscale = kamaR.yScale
        addChild(kamaR)
        
        let kamaLtexture = SKTexture(imageNamed: "kamaL")
        kamaL = SKSpriteNode(texture: kamaLtexture)
        kamaL.position = CGPoint(x: arm1px, y: arm1py)
        kamaL.scale(to: CGSize(width: arm1sx, height: arm1sy))
        kamaL.physicsBody = SKPhysicsBody(texture: kamaLtexture, size: CGSize(width: arm1sx * 1.1, height: arm1sy * 1.1))
        kamaL.physicsBody?.categoryBitMask = weaponCategory
        kamaL.physicsBody?.contactTestBitMask = weaponCT
        kamaL.physicsBody?.collisionBitMask = weaponCo
        kamaL.physicsBody?.affectedByGravity = false
        kamaL.physicsBody?.isDynamic = false
        kamaL.physicsBody?.affectedByGravity = false
        kamaL.physicsBody?.mass = 0.0001
        kamaL.alpha = 0
        addChild(kamaL)
        
        //右腕根元作成
        arm12 = SKSpriteNode(imageNamed: "arm2")
        arm12.position = CGPoint(x: arm2px, y: arm2py)
        arm12.scale(to: CGSize(width: arm2sx, height: arm2sy))
        arm12.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: psx, height: psy))
        arm12.physicsBody?.categoryBitMask = 0
        arm12.physicsBody?.contactTestBitMask = 0
        arm12.physicsBody?.collisionBitMask = 0
        arm12.physicsBody?.affectedByGravity = false
        arm12.physicsBody?.isDynamic = false
        arm12.physicsBody?.mass = 0.01
        addChild(arm12)
        
        //左腕先作成
        arm21 = SKSpriteNode(imageNamed: "arm1")
        arm21.position = CGPoint(x: arm1px, y: arm1py)
        arm21.scale(to: CGSize(width: arm1sx, height: arm1sy))
        arm21.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: psx, height: psy))
        arm21.physicsBody?.categoryBitMask = 0
        arm21.physicsBody?.contactTestBitMask = 0
        arm21.physicsBody?.collisionBitMask = 0
        arm21.physicsBody?.affectedByGravity = false
        arm21.physicsBody?.isDynamic = false
        arm21.physicsBody?.linearDamping = 0.01
    //    arm21.physicsBody?.mass = 2
        addChild(arm21)
        
        //左腕根元作成
        arm22 = SKSpriteNode(imageNamed: "arm2")
        arm22.position = CGPoint(x: arm2px, y: arm2py)
        arm22.scale(to: CGSize(width: arm2sx, height: arm2sy))
        arm22.physicsBody = SKPhysicsBody.init(rectangleOf: CGSize(width: psx, height: psy))
        arm22.physicsBody?.categoryBitMask = 0
        arm22.physicsBody?.contactTestBitMask = 0
        arm22.physicsBody?.collisionBitMask = 0
        arm22.physicsBody?.affectedByGravity = false
        arm22.physicsBody?.isDynamic = false
        arm22.physicsBody?.mass = 0.01
        addChild(arm22)

        
        leg11joint = SKPhysicsJointPin.joint(withBodyA: leg11.physicsBody!, bodyB: leg12.physicsBody!, anchor: leg11.position)
        leg11joint.upperAngleLimit = 150.0 * psita
        leg11joint.lowerAngleLimit = 0
        leg11joint.shouldEnableLimits = true
        physicsWorld.add(leg11joint)
        leg12joint = SKPhysicsJointPin.joint(withBodyA: leg12.physicsBody!, bodyB: body.physicsBody!, anchor: CGPoint(x: leg12.position.x + sin(leg12.zRotation * psita) * ww * jleg2p, y: leg12.position.y + cos(leg12.zRotation * psita) * ww * jleg2p))
        leg12joint.upperAngleLimit = 100.0 * psita
        leg12joint.lowerAngleLimit = -120.0 * psita
        leg12joint.shouldEnableLimits = true
        physicsWorld.add(leg12joint)
        leg21joint = SKPhysicsJointPin.joint(withBodyA: leg21.physicsBody!, bodyB: leg22.physicsBody!, anchor: leg21.position)
        leg21joint.upperAngleLimit = 150.0 * psita
        leg21joint.lowerAngleLimit = 0
        leg21joint.shouldEnableLimits = true
        physicsWorld.add(leg21joint)
        leg22joint = SKPhysicsJointPin.joint(withBodyA: leg22.physicsBody!, bodyB: body.physicsBody!, anchor: CGPoint(x: leg22.position.x + sin(leg22.zRotation * psita) * ww * jleg2p, y: leg22.position.y + cos(leg22.zRotation * psita) * ww * jleg2p))
        leg22joint.upperAngleLimit = 100.0 * psita
        leg22joint.lowerAngleLimit = -120.0 * psita
        leg22joint.shouldEnableLimits = true
        physicsWorld.add(leg22joint)
        arm11joint = SKPhysicsJointPin.joint(withBodyA: arm11.physicsBody!, bodyB: arm12.physicsBody!, anchor: arm11.position)
        arm11joint.upperAngleLimit = 0
        arm11joint.lowerAngleLimit = -160.0 * psita
        arm11joint.shouldEnableLimits = true
        physicsWorld.add(arm11joint)
        arm12joint = SKPhysicsJointPin.joint(withBodyA: arm12.physicsBody!, bodyB: body.physicsBody!, anchor: CGPoint(x: arm12.position.x + sin(arm12.zRotation * psita) * ww * jarm2p, y: arm12.position.y + cos(arm12.zRotation * psita) * ww * jarm2p))
        arm12joint.upperAngleLimit = 200 * psita
        arm12joint.lowerAngleLimit = -200.0 * psita
        arm12joint.shouldEnableLimits = true
        physicsWorld.add(arm12joint)
        arm21joint = SKPhysicsJointPin.joint(withBodyA: arm21.physicsBody!, bodyB: arm22.physicsBody!, anchor:arm21.position)
        arm21joint.upperAngleLimit = 0
        arm21joint.lowerAngleLimit = -160.0 * psita
        arm21joint.shouldEnableLimits = true
        physicsWorld.add(arm21joint)
        arm22joint = SKPhysicsJointPin.joint(withBodyA: arm22.physicsBody!, bodyB: body.physicsBody!, anchor: CGPoint(x: arm22.position.x + sin(arm12.zRotation * psita) * ww * jarm2p, y: arm22.position.y + cos(arm22.zRotation * psita) * ww * jarm2p))
        arm22joint.upperAngleLimit = 200 * psita
        arm22joint.lowerAngleLimit = -200.0 * psita
        arm22joint.shouldEnableLimits = true
        physicsWorld.add(arm22joint)
        
        let kamaRjoint = SKPhysicsJointFixed.joint(withBodyA: kamaR.physicsBody!, bodyB: arm11.physicsBody!, anchor: kamaR.position)
        physicsWorld.add(kamaRjoint)
        let kamaLjoint = SKPhysicsJointFixed.joint(withBodyA: kamaL.physicsBody!, bodyB: arm11.physicsBody!, anchor: kamaL.position)
        physicsWorld.add(kamaLjoint)
 
        let bodyJoint1 = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!, bodyB: bodyPhysick.physicsBody!, anchor: body.position)
        physicsWorld.add(bodyJoint1)
        let bodyJoint2 = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!, bodyB: bodyPhysick.physicsBody!, anchor: bodyPhysick.position)
        physicsWorld.add(bodyJoint2)
    
        if debugON == false{
            playerblockSensor.alpha = 0
        }
        
        //BGMの設定
        item1BGM.autoplayLooped = false
        item2BGM.autoplayLooped = false
        item3BGM.autoplayLooped = false
     //   Attack1BGM.autoplayLooped = false
      //  Attack2BGM.autoplayLooped = false
        avoidBGM.autoplayLooped = false
        PdameageBGM.autoplayLooped = false
    //    Hit1BGM.autoplayLooped = false
    //    Hit2BGM.autoplayLooped = false
    //    Hit3BGM.autoplayLooped = false
        jumpBGM.autoplayLooped = false
        walkBGM.autoplayLooped = false
        
        body.addChild(item1BGM)
        body.addChild(item2BGM)
        body.addChild(item3BGM)
        body.addChild(avoidBGM)
        body.addChild(PdameageBGM)
        
      //  arm11.addChild(Attack1BGM)
     //   arm11.addChild(Attack2BGM)
    //    arm11.addChild(Hit1BGM)
    //    arm11.addChild(Hit2BGM)
     //   arm11.addChild(Hit3BGM)
        
        leg11.addChild(jumpBGM)
        leg11.addChild(walkBGM)
        
        do{
            let A1Path = Bundle.main.path(forResource: "BGM/Attack01", ofType: "mp3")
            let A1url = URL(fileURLWithPath: A1Path!)
            Attack1BGM = try AVAudioPlayer(contentsOf: A1url)
        }catch{
            print("error")
        }
        do{
            let A2Path = Bundle.main.path(forResource: "BGM/Attack02", ofType: "mp3")
            let A2url = URL(fileURLWithPath: A2Path!)
            Attack2BGM = try AVAudioPlayer(contentsOf: A2url)
        }catch{
            print("error")
        }
        
        do{
            let H3Path = Bundle.main.path(forResource: "BGM/hit03", ofType: "mp3")
            let H3url = URL(fileURLWithPath: H3Path!)
            Hit3BGM = try AVAudioPlayer(contentsOf: H3url)
        }catch{
            print("error")
        }
    
        self.listener = body
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.body.physicsBody?.isDynamic = true
            self.leg11.physicsBody?.isDynamic = true
            self.leg12.physicsBody?.isDynamic = true
            self.leg21.physicsBody?.isDynamic = true
            self.leg22.physicsBody?.isDynamic = true
            self.arm11.physicsBody?.isDynamic = true
            self.arm12.physicsBody?.isDynamic = true
            self.arm21.physicsBody?.isDynamic = true
            self.arm22.physicsBody?.isDynamic = true
            self.bodyPhysick.physicsBody?.isDynamic = true
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
            self.kamaL.physicsBody?.isDynamic = true
            self.kamaR.physicsBody?.isDynamic = true
            self.playerMoveSensorBlock.physicsBody?.isDynamic = true
            self.playerblockSensor.physicsBody?.isDynamic = true
        
            self.leg11.physicsBody?.allowsRotation = true
            self.leg21.physicsBody?.allowsRotation = true
            self.arm11.physicsBody?.allowsRotation = true
            self.arm21.physicsBody?.allowsRotation = true
            self.playerGravityON()
            
            let firsttime: [Double] = [0.5,0.5]
            let leg1m: [[CGFloat]] = [[0,10],[0,10]]
            let leg1r: [CGFloat] = [-25,-50]
            let leg2m: [[CGFloat]] = [[0,0],[0,0]]
            let leg2r: [CGFloat] = [0,0]
            
            let arm1m: [[CGFloat]] = [[0,100],[0,100]]
            let arm1r: [CGFloat] = [90,180]
            let arm2m: [[CGFloat]] = [[0,100],[0,100]]
            let arm2r: [CGFloat] = [90,180]
            
            let leg1mAction = SKAction.sequence([SKAction.moveBy(x: ww * leg1m[0][0], y: ww * leg1m[0][1], duration: firsttime[0])
                                                ,SKAction.moveBy(x: ww * leg1m[1][0], y: ww * leg1m[1][1], duration: firsttime[1])])
            let leg1rAction = SKAction.sequence([SKAction.rotate(toAngle: leg1r[0] * self.psita, duration: firsttime[0])
                                                ,SKAction.rotate(toAngle: leg1r[1] * self.psita, duration: firsttime[1])])
            let leg1Action = SKAction.group([leg1mAction,leg1rAction])
            
            let leg2mAction = SKAction.sequence([SKAction.moveBy(x: ww * leg2m[0][0], y: ww * leg2m[0][1], duration: firsttime[0])
                                                ,SKAction.moveBy(x: ww * leg2m[1][0], y: ww * leg2m[1][1], duration: firsttime[1])])
            let leg2rAction = SKAction.sequence([SKAction.rotate(toAngle: leg2r[0] * self.psita, duration: firsttime[0])
                                                ,SKAction.rotate(toAngle: leg2r[1] * self.psita, duration: firsttime[1])])
            let leg2Action = SKAction.group([leg2mAction,leg2rAction])
            
            let arm1mAction = SKAction.sequence([SKAction.moveBy(x: ww * arm1m[0][0], y: ww * arm1m[0][1], duration: firsttime[0])
                                                ,SKAction.moveBy(x: ww * arm1m[1][0], y: ww * arm1m[1][1], duration: firsttime[1])])
            let arm1rAction = SKAction.sequence([SKAction.rotate(toAngle: arm1r[0] * self.psita, duration: firsttime[0])
                                                ,SKAction.rotate(toAngle: arm1r[1] * self.psita, duration: firsttime[1])])
            let arm1Action = SKAction.group([arm1mAction,arm1rAction])
            
            let arm2mAction = SKAction.sequence([SKAction.moveBy(x: ww * arm2m[0][0], y: ww * arm2m[0][1], duration: firsttime[0])
                                                ,SKAction.moveBy(x: ww * arm2m[1][0], y: ww * arm2m[1][1], duration: firsttime[1])])
            let arm2rAction = SKAction.sequence([SKAction.rotate(toAngle: arm2r[0] * self.psita, duration: firsttime[0])
                                                ,SKAction.rotate(toAngle: arm2r[1] * self.psita, duration: firsttime[1])])
            let arm2Action = SKAction.group([arm2mAction,arm2rAction])
            
            self.leg11.run(leg1Action, withKey: "leg1Action")
            self.leg21.run(leg2Action, withKey: "leg2Action")
            self.arm11.run(arm1Action, withKey: "arm1Action")
            self.arm21.run(arm2Action, withKey: "arm2Action")
            
       //     self.playerMoveSensorBlock.alpha = 0.5
        }
    }
    
    func ChangeisDynamic(bodyd:Bool,leg11d:Bool,leg21d:Bool,arm11d:Bool,arm21d:Bool){
        body.physicsBody?.isDynamic = bodyd
        leg11.physicsBody?.isDynamic = leg11d
        leg21.physicsBody?.isDynamic = leg21d
        arm11.physicsBody?.isDynamic = arm11d
        arm21.physicsBody?.isDynamic = arm21d
    }
    
    func Changerotation(bodyd:Bool,leg11d:Bool,leg21d:Bool,arm11d:Bool,arm21d:Bool){
        body.physicsBody?.allowsRotation = bodyd
        leg11.physicsBody?.allowsRotation = leg11d
        leg21.physicsBody?.allowsRotation = leg21d
        arm11.physicsBody?.allowsRotation = arm11d
        arm21.physicsBody?.allowsRotation = arm21d
    }
    
    func playerGravityON(){
        leg11.physicsBody?.affectedByGravity = true
        leg12.physicsBody?.affectedByGravity = true
        leg21.physicsBody?.affectedByGravity = true
        leg22.physicsBody?.affectedByGravity = true
        arm11.physicsBody?.affectedByGravity = true
        arm12.physicsBody?.affectedByGravity = true
        arm21.physicsBody?.affectedByGravity = true
        arm22.physicsBody?.affectedByGravity = true
    }
    func playerGravityOFF(){
        leg11.physicsBody?.affectedByGravity = false
        leg12.physicsBody?.affectedByGravity = false
        leg21.physicsBody?.affectedByGravity = false
        leg22.physicsBody?.affectedByGravity = false
        arm11.physicsBody?.affectedByGravity = false
        arm12.physicsBody?.affectedByGravity = false
        arm21.physicsBody?.affectedByGravity = false
        arm22.physicsBody?.affectedByGravity = false
    }
    
    func legGravityON(){
    //    body.physicsBody?.affectedByGravity = false
        leg11.physicsBody?.affectedByGravity = true
        leg12.physicsBody?.affectedByGravity = false
        leg21.physicsBody?.affectedByGravity = true
        leg22.physicsBody?.affectedByGravity = false
        arm11.physicsBody?.affectedByGravity = false
        arm12.physicsBody?.affectedByGravity = false
        arm21.physicsBody?.affectedByGravity = false
        arm22.physicsBody?.affectedByGravity = false
    }
    
    func Groundjointanglemovement(){
        //[Up,Low] Up:反時計周りの制限　Low:時計周りの制限　(初期状態から反時計回りの角度を正、時計回りの角度を負で記入）
        let Rleg1:[CGFloat] = [0,-150] //右足膝
        let Rleg2:[CGFloat] = [120,-100] //右足もも
        let Lleg1:[CGFloat] = [0,-150] //左足膝
        let Lleg2:[CGFloat] = [120,-100] //左足もも
        let Rarm1:[CGFloat] = [200,0]//右肘
        let Rarm2:[CGFloat] = [200,-200]//右肩
        let Larm1:[CGFloat] = [150,0]//左肘
        let Larm2:[CGFloat] = [200,-200]//左肩
        //※右向き状態の記入
        
        angleinput(Rleg1: Rleg1, Rleg2: Rleg2, Lleg1: Lleg1, Lleg2: Lleg2, Rarm1: Rarm1, Rarm2:Rarm2, Larm1: Larm1, Larm2: Larm2)
    }
    
    func Airjointanglemovement(){
        //[Up,Low] Up:反時計周りの制限　Low:時計周りの制限　(初期状態から反時計回りの角度を正、時計回りの角度を負で記入）
        let Rleg1:[CGFloat] = [0,-110] //右足膝
        let Rleg2:[CGFloat] = [30,0] //右足もも
        let Lleg1:[CGFloat] = [0,-110] //左足膝
        let Lleg2:[CGFloat] = [30,0] //左足もも
        let Rarm1:[CGFloat] = [150,0]//右肘
        let Rarm2:[CGFloat] = [170,-170]//右肩
        let Larm1:[CGFloat] = [150,0]//左肘
        let Larm2:[CGFloat] = [170,-170]//左肩
        //※右向き状態の記入
        
        angleinput(Rleg1: Rleg1, Rleg2: Rleg2, Lleg1: Lleg1, Lleg2: Lleg2, Rarm1: Rarm1, Rarm2:Rarm2, Larm1: Larm1, Larm2: Larm2)
    }
    
    func Standerdanglemovement(){
        //[Up,Low] Up:反時計周りの制限　Low:時計周りの制限　(初期状態から反時計回りの角度を正、時計回りの角度を負で記入）
        let Rleg1:[CGFloat] = [-11,-12] //右足膝
        let Rleg2:[CGFloat] = [30,29] //右足もも
        let Lleg1:[CGFloat] = [-4,-9] //左足膝
        let Lleg2:[CGFloat] = [-1,-6] //左足もも
        let Rarm1:[CGFloat] = [161,160]//右肘
        let Rarm2:[CGFloat] = [16,15]//右肩
        let Larm1:[CGFloat] = [1,-1]//左肘
        let Larm2:[CGFloat] = [1,-1]//左肩
        //※右向き状態の記入
        
        angleinput(Rleg1: Rleg1, Rleg2: Rleg2, Lleg1: Lleg1, Lleg2: Lleg2, Rarm1: Rarm1, Rarm2:Rarm2, Larm1: Larm1, Larm2: Larm2)
    }
    
    func angleinput(Rleg1:[CGFloat],Rleg2:[CGFloat],Lleg1:[CGFloat],Lleg2:[CGFloat],Rarm1:[CGFloat],Rarm2:[CGFloat],Larm1:[CGFloat],Larm2:[CGFloat]){
        if playerdirection{
            leg11joint.upperAngleLimit = -Rleg1[1] * psita
            leg11joint.lowerAngleLimit = -Rleg1[0] * psita
            leg21joint.upperAngleLimit = -Lleg1[1] * psita
            leg21joint.lowerAngleLimit = -Lleg1[0] * psita
            leg12joint.upperAngleLimit = -Rleg2[1] * psita
            leg12joint.lowerAngleLimit = -Rleg2[0] * psita
            leg22joint.upperAngleLimit = -Lleg2[1] * psita
            leg22joint.lowerAngleLimit = -Lleg2[0] * psita
            arm11joint.upperAngleLimit = -Rarm1[1] * psita
            arm11joint.lowerAngleLimit = -Rarm1[0] * psita
            arm21joint.upperAngleLimit = -Larm1[1] * psita
            arm21joint.lowerAngleLimit = -Larm1[0] * psita
            arm12joint.upperAngleLimit = -Rarm2[1] * psita
            arm12joint.lowerAngleLimit = -Rarm2[0] * psita
            arm22joint.upperAngleLimit = -Larm2[1] * psita
            arm22joint.lowerAngleLimit = -Larm2[0] * psita
        }else{
            leg11joint.upperAngleLimit = Rleg1[0] * psita
            leg11joint.lowerAngleLimit = Rleg1[1] * psita
            leg21joint.upperAngleLimit = Lleg1[0] * psita
            leg21joint.lowerAngleLimit = Lleg1[1] * psita
            leg12joint.upperAngleLimit = Rleg2[0] * psita
            leg12joint.lowerAngleLimit = Rleg2[1] * psita
            leg22joint.upperAngleLimit = Lleg2[0] * psita
            leg22joint.lowerAngleLimit = Lleg2[1] * psita
            arm11joint.upperAngleLimit = Rarm1[0] * psita
            arm11joint.lowerAngleLimit = Rarm1[1] * psita
            arm21joint.upperAngleLimit = Larm1[0] * psita
            arm21joint.lowerAngleLimit = Larm1[1] * psita
            arm12joint.upperAngleLimit = Rarm2[0] * psita
            arm12joint.lowerAngleLimit = Rarm2[1] * psita
            arm22joint.upperAngleLimit = Larm2[0] * psita
            arm22joint.lowerAngleLimit = Larm2[1] * psita

        }
    }
    
    // 距離計算
    func distance(p1:CGPoint,p2:CGPoint) -> CGFloat{
        let a = Double(p2.x - p1.x)
        let b = Double(p2.y - p1.y)
        return CGFloat(sqrt(a * a + b * b))
    }
    
    //角度計算
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
    
    //角度による移動距離の変換
    func rotateCalculation(object:[CGFloat],Standared:[CGFloat],sita:CGFloat) -> [CGFloat]{
        var Sp = Standared
        var Mp = object
      
        let dx = object[0] * ww
        let dy = object[1] * ww
        let dsita = object[2] * psita
        let ssita = Standared[2]

        Sp[2] = ssita + sita * psita
        //移動地点の計算
        Mp[0] = Sp[0] + dx * cos(Sp[2]) - dy * sin(Sp[2])
        Mp[1] = Sp[1] + dx * sin(Sp[2]) + dy * cos(Sp[2])
        Mp[2] = Sp[2] + dsita
        return Mp
    }
    
    func rotateCalculation(move:[CGFloat],Standared:[CGFloat]) -> [CGFloat]{
        var Sp = Standared
        var Mp = move
        
        let dx = move[0] * ww
        let dy = move[1] * ww
        let dsita = move[2] * psita
        //移動地点の計算
        Mp[0] = Sp[0] + dx * cos(Sp[2]) - dy * sin(Sp[2])
        Mp[1] = Sp[1] + dx * sin(Sp[2]) + dy * cos(Sp[2])
        Mp[2] = Sp[2] + dsita
        return Mp
    }
    
    func creatAction(object: [CGFloat], time:Double) -> SKAction{
        let mAction = SKAction.move(to: CGPoint(x: object[0], y: object[1]), duration: time)
        let rAction = SKAction.rotate(toAngle: object[2], duration: time, shortestUnitArc: true)
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }
    
    func CreateToAction(move: [CGFloat], time:Double) -> SKAction{
        let xx = playerMoveSensorBlock.position.x
        let yy = playerMoveSensorBlock.position.y
        var moved = move
        if playerdirection == false{ for n in 0..<3{if n != 1{moved[n] = -move[n]}} }
        let mAction = SKAction.move(to: CGPoint(x: moved[0] * ww + xx, y: moved[1] * ww + yy), duration: time)
        let rAction = SKAction.rotate(toAngle: moved[2] * psita, duration: time, shortestUnitArc: true)
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }
    
    func CreateToAction(move: [CGFloat], dischange:Bool, time:Double) -> SKAction{
        let  xx = playerMoveSensorBlock.position.x
        let  yy = playerMoveSensorBlock.position.y
        var moved = move
        if playerdirection == false && dischange{    for n in 0..<3{ if n != 1{moved[n] = -move[n]}  }  }
        let mAction = SKAction.move(to: CGPoint(x: moved[0] * ww + xx, y: moved[1] * ww + yy), duration: time)
        let rAction = SKAction.rotate(toAngle: moved[2] * psita, duration: time, shortestUnitArc: true)
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }
    
    func CreateByAction(move: [CGFloat],object:SKSpriteNode ,time:Double) -> SKAction{
        let xx = playerMoveSensorBlock.position.x
        let yy = playerMoveSensorBlock.position.y
        let ox = object.position.x
        let oy = object.position.y
        let osita = object.zRotation
        var moved = move
        if playerdirection == false{ for n in 0..<3{if n != 1{moved[n] = -move[n]}} }
        let dx = moved[0] * ww - (ox - xx)
        let dy = moved[1] * ww - (oy - yy)
        let dsita = moved[2] * psita - osita
        let mAction = SKAction.moveBy(x: dx, y: dy, duration: time)
        let rAction = SKAction.rotate(byAngle: dsita, duration: time)
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }
    
    func PlayToAction(move: [[CGFloat]],dischange:Bool,moveing:Bool,object:SKSpriteNode,lastAction: SKAction!,time:[Double]){
        var playAction : [SKAction] = []
        let ActionN = move.count
        let px = playerMoveSensorBlock.position.x
        let py = playerMoveSensorBlock.position.y
        for n in 0..<ActionN{
            let Action = SKAction.run {
                var movex: CGFloat!
                var movey: CGFloat!
                let movesita: CGFloat!
                if moveing{
                    movex = self.playerMoveSensorBlock.position.x
                    movey = self.playerMoveSensorBlock.position.y
                }else{
                    movex = px
                    movey = py
                }
                if dischange && self.playerdirection == false{
                    movex -= move[n][0] * self.ww
                    movesita = -self.psita * move[n][2]
                }else{
                    movex += move[n][0] * self.ww
                    movesita = self.psita * move[n][2]
                }
                movey += move[n][1] * self.ww
                
                let mAction = SKAction.move(to: CGPoint(x: movex, y: movey), duration: time[n])
                let rAction = SKAction.rotate(toAngle: movesita, duration: time[n], shortestUnitArc: true)
                var mrAction  = SKAction.group([mAction,rAction])
                if n != ActionN - 1{
                    let nextAction = SKAction.run {
                        object.run(playAction[n + 1])
                    }
                    mrAction = SKAction.sequence([mrAction,nextAction])
                }else{
                    if lastAction != nil{
                        mrAction = SKAction.sequence([mrAction,lastAction])
                    }
                }
                object.run(mrAction)
            }
            playAction.append(Action)
        }
        run(playAction[0])
    }
    
    func PlayToAction(move: [[CGFloat]],dischange:Bool,moveing:Bool,object:SKShapeNode,lastAction: SKAction!,time:[Double]){
        var playAction : [SKAction] = []
        let ActionN = move.count
        let px = playerMoveSensorBlock.position.x
        let py = playerMoveSensorBlock.position.y
        for n in 0..<ActionN{
            let Action = SKAction.run {
                var movex: CGFloat!
                var movey: CGFloat!
                let movesita: CGFloat!
                if moveing{
                    movex = self.playerMoveSensorBlock.position.x
                    movey = self.playerMoveSensorBlock.position.y
                }else{
                    movex = px
                    movey = py
                }
                if dischange && self.playerdirection == false{
                    movex -= move[n][0] * self.ww
                    movesita = -self.psita * move[n][2]
                }else{
                    movex += move[n][0] * self.ww
                    movesita = self.psita * move[n][2]
                }
                movey += move[n][1] * self.ww
                
                let mAction = SKAction.move(to: CGPoint(x: movex, y: movey), duration: time[n])
                let rAction = SKAction.rotate(toAngle: movesita, duration: time[n], shortestUnitArc: true)
                var mrAction  = SKAction.group([mAction,rAction])
                if n != ActionN - 1{
                    let nextAction = SKAction.run {
                        object.run(playAction[n + 1])
                    }
                    mrAction = SKAction.sequence([mrAction,nextAction])
                }else{
                    if lastAction != nil{
                        mrAction = SKAction.sequence([mrAction,lastAction])
                    }
                }
                object.run(mrAction)
            }
            playAction.append(Action)
        }
        run(playAction[0])
    }
    
    func PlayToAction2(move2: [[CGFloat]],dischange:Bool,moveing:Bool,object:SKShapeNode,lastAction: SKAction!,time:[Double]){
        var playAction : [SKAction] = []
        let ActionN = move2.count
        let px = playerMoveSensorBlock.position.x
        let py = playerMoveSensorBlock.position.y
        for n in 0..<ActionN{
            let Action = SKAction.run {
                var movex: CGFloat!
                var movey: CGFloat!
                let movesita: CGFloat!
                if moveing{
                    movex = self.playerMoveSensorBlock.position.x
                    movey = self.playerMoveSensorBlock.position.y
                }else{
                    movex = px
                    movey = py
                }
                if dischange && self.playerdirection == false{
                    movex -= move2[n][0]
                    movesita = -move2[n][2]
                }else{
                    movex += move2[n][0]
                    movesita = move2[n][2]
                }
                movey += move2[n][1]
                
                let mAction = SKAction.move(to: CGPoint(x: movex, y: movey), duration: time[n])
                let rAction = SKAction.rotate(toAngle: movesita, duration: time[n], shortestUnitArc: true)
                var mrAction  = SKAction.group([mAction,rAction])
                if n != ActionN - 1{
                    let nextAction = SKAction.run {
                        object.run(playAction[n + 1])
                    }
                    mrAction = SKAction.sequence([mrAction,nextAction])
                }else{
                    if lastAction != nil{
                        mrAction = SKAction.sequence([mrAction,lastAction])
                    }
                }
                object.run(mrAction)
            }
            playAction.append(Action)
        }
        run(playAction[0])
    }
    

    
    func RotateMove(object:SKSpriteNode,position:[[CGFloat]],axismove:[[CGFloat]]!,count:Int,RotatoTo:[CGFloat]) -> [[CGFloat]]{
        let pzR = body.zRotation / psita //プレイヤーの姿勢
        let ozR = object.zRotation / psita
        // 動かすNodeの初期姿勢の計算
        let objextX = (object.position.x - body.position.x) / ww
        let objextY = (object.position.y - body.position.y) / ww
        let oP = rotateCalculation2(RC: [objextX,objextY,-pzR])
        let oX = oP[0] //動かす物体の初期姿勢
        let oY = oP[1] //動かす物体の初期姿勢
        
        //プレイヤーの中心を計算
        let pX = (body.position.x - playerMoveSensorBlock.position.x) / ww
        let pY = (body.position.y - playerMoveSensorBlock.position.y) / ww
        
        let splitN = CGFloat(count)
        //変化させる距離
        var dsita: CGFloat!
        var dx: CGFloat!
        var dy: CGFloat!
        var drotate: CGFloat!
        var axisdx : CGFloat!
        var axisdy : CGFloat!

        var RC:[CGFloat] = [0,0,0] //回転変換に送る変数
        var MoveC :[[CGFloat]]! //動かす位置を格納する箱(戻り値)
        
        var beforeX: CGFloat!
        var beforeY: CGFloat!
        var beforeSita: CGFloat!
        var beforeOSita: CGFloat!
        
        for m in 0..<RotatoTo.count{
            if m == 0{
                beforeX = oX
                beforeY = oY
                beforeSita = pzR
                beforeOSita = ozR
            }else{
                beforeX = position[m - 1][0]
                beforeY = position[m - 1][1]
                beforeSita = RotatoTo[m - 1]
                beforeOSita = RotatoTo[m - 1] + position[m - 1][2]
            }
            dsita = (RotatoTo[m] - beforeSita) / splitN
            dx = (position[m][0] - beforeX) / splitN
            dy = (position[m][1] - beforeY) / splitN
            drotate = (RotatoTo[m] + position[m][2] - beforeOSita) / splitN
            if axismove != nil{
                if axisdx == nil{axisdx = (axismove[m][0] - pX) / splitN}else{axisdx = (axismove[m][0] - axismove[m - 1][0]) / splitN}
                if axisdy == nil{axisdy = (axismove[m][1] - pY) / splitN}else{axisdy = (axismove[m][1] - axismove[m - 1][1]) / splitN}
            }else{
                if axisdx == nil{axisdx = pX / splitN}else{axisdx = 0}
                if axisdy == nil{axisdy = pY / splitN}else{axisdy = 0}
            }
            for n in 1...count{
                let nc = CGFloat(n)
                RC = [beforeX + nc * dx,beforeY + nc * dy,beforeSita + nc * dsita]
                var AR = rotateCalculation2(RC: RC)
                AR[2] = beforeOSita + drotate * nc 
                AR[2] = CGFloat(Int(AR[2]) % 360)
                if AR[2] > 180{AR[2] -= 360}
                if AR[2] < -180{AR[2] += 360}
                AR[0] += axisdx * nc
                AR[1] += axisdy * nc
                if MoveC == nil{MoveC = [AR]}
                else{MoveC.append(AR)}
            }
        }
        return MoveC
    }
    
    func RotateMove(position:[CGFloat],axismove:[CGFloat]!,count:Int,RotatoBy:CGFloat) -> [[CGFloat]]{
        let pzR = body.zRotation / psita
        let dsita1 = RotatoBy / CGFloat(count - 1)
        var RC: [CGFloat] = [position[0],position[1],0]
        var MoveC :[[CGFloat]]!
        for n in 0..<count{
            RC[2] = pzR + dsita1 * CGFloat(n)
            var AR = rotateCalculation2(RC: RC)
            AR[2] = RC[2] + position[2]
            AR[2] = CGFloat(Int(AR[2]) % 360)
            if AR[2] > 180{AR[2] -= 360}
            if AR[2] < -180{AR[2] += 360}
            if axismove != nil{
                AR[0] += axismove[0]
                AR[1] += axismove[1]
            }
            if MoveC == nil{MoveC = [AR]}
            else{MoveC.append(AR)}
        }
        return MoveC
    }

    func rotateCalculation2(RC:[CGFloat]) -> [CGFloat]{
        var Mp = RC
        let dx = RC[0]
        let dy = RC[1]
        let dsita = RC[2] * psita
        //移動地点の計算
        Mp[0] = dx * cos(dsita) - dy * sin(dsita)
        Mp[1] = dx * sin(dsita) + dy * cos(dsita)
        return Mp
    }
    
    func CreateByAction(move: [[CGFloat]] ,object:SKSpriteNode , time:[Double]) -> SKAction{
        let xx = body.position.x
        let yy = body.position.y
        let ox = object.position.x
        let oy = object.position.y
        let osita = object.zRotation
        var moved = move
        var mAction: SKAction!
        var rAction: SKAction!
        for n in 0..<move.count{
            if playerdirection == false{for m in 0..<3{if m != 1{moved[n][m] = -move[n][m]}}}
            if n == 0{
                let dx = moved[n][0] * ww - (ox - xx)
                let dy = moved[n][1] * ww - (oy - yy)
                let dsita = moved[n][2] * psita - osita
                mAction = SKAction.moveBy(x: dx, y: dy, duration: time[n])
                rAction = SKAction.rotate(byAngle: dsita, duration: time[n])
            }else{
                let dx = moved[n][0] * ww
                let dy = moved[n][1] * ww
                let dsita = moved[n][2] * psita
                let m2Action = SKAction.moveBy(x: dx, y: dy, duration: time[n])
                let r2Action = SKAction.rotate(byAngle: dsita, duration: time[n])
                mAction = SKAction.sequence([mAction,m2Action])
                rAction = SKAction.sequence([rAction,r2Action])
            }
        }
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }
    
    func CreateByAction2(move: [[CGFloat]] ,object:SKSpriteNode , time:[Double]) -> SKAction{
        var mAction: SKAction!
        var rAction: SKAction!
        for n in 0..<move.count{
            if n == 0{
                let dx = move[n][0] * ww
                let dy = move[n][1] * ww
                let dsita = move[n][2] * psita
                mAction = SKAction.moveBy(x: dx, y: dy, duration: time[n])
                rAction = SKAction.rotate(byAngle: dsita, duration: time[n])
            }else{
                let dx = move[n][0] * ww
                let dy = move[n][1] * ww
                let dsita = move[n][2] * psita
                let m2Action = SKAction.moveBy(x: dx, y: dy, duration: time[n])
                let r2Action = SKAction.rotate(byAngle: dsita, duration: time[n])
                mAction = SKAction.sequence([mAction,m2Action])
                rAction = SKAction.sequence([rAction,r2Action])
            }
        }
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }

    
    func CreateToAction(move: [[CGFloat]], Sposition:CGPoint, time:[Double]) -> SKAction{
        let xx = Sposition.x
        let yy = Sposition.y
        var mAction: SKAction!
        var rAction: SKAction!
        var moved = move
        for n in 0...move.count - 1{
            if playerdirection == false{for m in 0..<3{if n != 1{moved[n][m] = -move[n][m]}}}
            if n == 0{
                mAction = SKAction.move(to: CGPoint(x: moved[n][0] * ww + xx, y: moved[n][1] * ww + yy), duration: time[n])
                rAction = SKAction.rotate(toAngle: moved[n][2] * psita, duration: time[n], shortestUnitArc: true)
            }else{
                let m2Action = SKAction.move(to: CGPoint(x: moved[n][0] * ww + xx, y: moved[n][1] * ww + yy), duration: time[n])
                let r2Action = SKAction.rotate(toAngle: moved[n][2] * psita, duration: time[n], shortestUnitArc: true)
                mAction = SKAction.sequence([mAction,m2Action])
                rAction = SKAction.sequence([rAction,r2Action])
            }
        }
        let sAction = SKAction.group([mAction,rAction])
        return sAction
    }
    
    
    func legposition(legangle:[[CGFloat]],bodyposition:[[CGFloat]]) -> [[CGFloat]]{
        let bodyL: CGFloat = 40
        let legL: CGFloat = 40
        var legposition = bodyposition
        for n in 0..<legposition.count{
            legposition[n][0] += bodyL * sin(bodyposition[n][2] * psita) + legL * sin(legangle[n][0] * psita)
            legposition[n][1] += -bodyL * cos(bodyposition[n][2] * psita) - legL * cos(legangle[n][0] * psita)
            legposition[n][2] = legangle[n][1]
        }
        return legposition
    }
    
    func armposition(armangle:[[CGFloat]],bodyposition:[[CGFloat]]) -> [[CGFloat]]{
        let bodyL: CGFloat = 15
        let armL: CGFloat = 20
        var armposition = bodyposition
        for n in 0..<armposition.count{
            armposition[n][0] += -bodyL * sin(bodyposition[n][2] * psita) + armL * sin(armangle[n][0] * psita)
            armposition[n][1] += bodyL * cos(bodyposition[n][2] * psita) - armL * cos(armangle[n][0] * psita)
            armposition[n][2] = armangle[n][1]
        }
        return armposition
    }
    
    func defealtPhysicsStatas(){
        body.physicsBody?.mass = 0.1
        body.physicsBody?.linearDamping = 0.1
        body.physicsBody?.angularDamping = 0.5
        leg11.physicsBody?.mass = 0.05
        leg11.physicsBody?.linearDamping = 0.1
        leg11.physicsBody?.angularDamping = 0.1
        leg21.physicsBody?.mass = 0.05
        leg21.physicsBody?.linearDamping = 0.1
        leg21.physicsBody?.angularDamping = 0.1
        arm11.physicsBody?.mass = 0.01
        arm11.physicsBody?.linearDamping = 1.0
        arm11.physicsBody?.angularDamping = 0.1
        arm21.physicsBody?.mass = 0.01
        arm21.physicsBody?.linearDamping = 1.0
        arm21.physicsBody?.angularDamping = 0.1
    }
    
    func standardPhysicsStatas(){
        body.physicsBody?.mass = 0.05
        body.physicsBody?.linearDamping = 0.1
        body.physicsBody?.angularDamping = 0.1
        leg11.physicsBody?.mass = 1
        leg11.physicsBody?.linearDamping = 0.9
        leg11.physicsBody?.angularDamping = 0.1
        leg21.physicsBody?.mass = 1
        leg21.physicsBody?.linearDamping = 0.9
        leg21.physicsBody?.angularDamping = 0.1
        arm11.physicsBody?.mass = 0.01
        arm11.physicsBody?.linearDamping = 1.0
        arm11.physicsBody?.angularDamping = 0.1
        arm21.physicsBody?.mass = 0.01
        arm21.physicsBody?.linearDamping = 1.0
        arm21.physicsBody?.angularDamping = 0.1
    }
    
    func airPhysicsStatas(){
        body.physicsBody?.linearDamping = 0.2
        body.physicsBody?.angularDamping = 0.9
        leg11.physicsBody?.mass = 0.12
        leg11.physicsBody?.linearDamping = 0.1
        leg11.physicsBody?.angularDamping = 0.1
        leg21.physicsBody?.mass = 0.12
        leg21.physicsBody?.linearDamping = 0.1
        leg21.physicsBody?.angularDamping = 0.1
        arm11.physicsBody?.mass = 0.1
        arm11.physicsBody?.linearDamping = 0.1
        arm11.physicsBody?.angularDamping = 0.9
        arm21.physicsBody?.mass = 0.1
        arm21.physicsBody?.linearDamping = 0.1
        arm21.physicsBody?.angularDamping = 0.9
    }
    
    func enemyTexterLoad(){
        let enemy1Atlas = SKTextureAtlas(named: "e1anime")
        let enemy2Atlas = SKTextureAtlas(named: "e2anime")
        let enemy3Atlas = SKTextureAtlas(named: "e3anime")
        let enemy4Atlas = SKTextureAtlas(named: "e4anime")
        let enemy5Atlas = SKTextureAtlas(named: "e5anime")
        for n in 1...8{
            enemy1R.append(enemy1Atlas.textureNamed("e1anime" + String(n)))
            enemy1L.append(enemy1Atlas.textureNamed("e1anime" + String(n + 8)))
        }
        for n in 1...14{
            enemy2RUp.append(enemy2Atlas.textureNamed("e2anime" + String(15 - n)))
            enemy2RDown.append(enemy2Atlas.textureNamed("e2anime" + String(n)))
            enemy2LUp.append(enemy2Atlas.textureNamed("e2anime" + String(29 - n)))
            enemy2LDown.append(enemy2Atlas.textureNamed("e2anime" + String(14 + n)))
        }
        for n in 1...30{
            enemy3R.append(enemy3Atlas.textureNamed("e3anime" + String(n)))
            enemy3L.append(enemy3Atlas.textureNamed("e3anime" + String(n + 30)))
        }
        for n in 1...10{
            enemy4R.append(enemy4Atlas.textureNamed("e4anime" + String(n)))
            enemy4L.append(enemy4Atlas.textureNamed("e4anime" + String(n + 10)))
            enemy4RE.append(enemy4Atlas.textureNamed("e4anime" + String(11 - n)))
            enemy4LE.append(enemy4Atlas.textureNamed("e4anime" + String(21 - n)))
        }
        for n in 1...2{
            enemy5.append(enemy5Atlas.textureNamed("e5anime" + String(n)))
        }
    }
    
    func ClearP(How: Int = 1){
        viewnode.HTClear(CrearP: How)
    }
    
    func BGMplay(BGM: AVAudioPlayer){
        if BGM.isPlaying{ BGM.pause() }
        BGM.currentTime = 0
        BGM.play()
    }
}
