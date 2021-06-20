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
    let w = UIScreen.main.bounds.size.width
    let h = UIScreen.main.bounds.size.width * 9 / 5
    let h2 = UIScreen.main.bounds.size.height
    let gra = 9.8
    var sita = 0.0
    let resize = 0.97
    
    let ballCategory: UInt32 = 0b00000000000001
    let blockCategory: UInt32 = 0b00000000000010
    let redblockCategory: UInt32 = 0b00000000000100
    let goalCategory: UInt32 = 0b00000000001000
    let coinCategory: UInt32 = 0b00000000010000
    let bulletCategory: UInt32 = 0b00000000100000
    let middleflag1Category: UInt32 = 0b00000001000000
    let middleflag2Category: UInt32 = 0b00000010000000
    let middleflag3Category: UInt32 = 0b00000100000000
    let blueblockCategory: UInt32 = 0b00001000000000
    let redblockCategory2: UInt32 = 0b00010000000000
    let greenblockCategory: UInt32 = 0b00100000000000
    let chain1Category: UInt32 = 0b01000000000000
    
    var ballcontact: UInt32!
    var blockcontact: UInt32!
    var redblockcontact: UInt32!
    var blueblockcontact: UInt32!
    var greenblockcontact: UInt32!
    var bulletcontact: UInt32!
    var chain1contact: UInt32!
// 接触判定の設定
    func contact(){
        ballcontact = blockCategory + blueblockCategory + greenblockCategory
        blockcontact = ballCategory + blueblockCategory + bulletCategory + chain1Category + greenblockCategory
        greenblockcontact = ballCategory + bulletCategory + redblockCategory + blockCategory + blueblockCategory
        redblockcontact = blueblockCategory + greenblockCategory
        blueblockcontact = ballCategory + blueblockCategory + redblockCategory + bulletCategory + blockCategory + chain1Category + greenblockCategory
        bulletcontact = blockCategory + blueblockCategory
        chain1contact = chain1Category + blockCategory + blueblockCategory
    }

//ボール
    var ball: SKSpriteNode!
    var balltext: SKTexture!
    var ball2: SKSpriteNode!
    var ball2text: SKTexture!

//ゴール
    var goal: SKSpriteNode!
    var goaltext: SKTexture!
    
    var middleflag1: SKSpriteNode!
    var middleflagtext: SKTexture!
    var middleflag1flag: Bool = false
    var middleflag2: SKSpriteNode!
    var middleflag2flag: Bool = false
    var middleflag3: SKSpriteNode!
    var middleflag3flag: Bool = false
//    var goalflag: Bool = false
//隠しアイテム(未実装)
    var coin: SKSpriteNode!
    var cointext: SKTexture!
    var coinflag: Bool = false
    
//オブジェクト
    var usagi: SKSpriteNode!
    var usagitext: SKTexture!
    
    var square: SKSpriteNode!
    var squaretext: SKTexture!
    var square2: SKSpriteNode!
    var square2text: SKTexture!
    var square3: SKSpriteNode!
    var square3text: SKTexture!
    var square4: SKSpriteNode!
    var square4text: SKTexture!
    var square5: SKSpriteNode!
    var square5text: SKTexture!
    var traiangr: SKSpriteNode!
    var traiangrtext: SKTexture!
    
    var bluesquare: SKSpriteNode!
    var bluesquaretext: SKTexture!
    var bluesquare2: SKSpriteNode!
    var bluesquare2text: SKTexture!
    var bluesquare3: SKSpriteNode!
    var bluesquare3text: SKTexture!
    var bluesquare4: SKSpriteNode!
    var bluesquare4text: SKTexture!
    var bluesquare5: SKSpriteNode!
    var bluesquare5text: SKTexture!
    var bluesquare6: SKSpriteNode!
    var bluesquare6text: SKTexture!
    var bluecircle: SKSpriteNode!
    var bluecircletext: SKTexture!

    var greensquare: SKSpriteNode!
    var greensquaretext: SKTexture!
    var greencircle: SKSpriteNode!
    var greencircletext: SKTexture!
    var greencircle2: SKSpriteNode!
    var greencircle2text: SKTexture!
    var greencircle3: SKSpriteNode!
    var greencircle3text: SKTexture!
    var greentraiangr: SKSpriteNode!
    var greentraiangrtext: SKTexture!
    
    var circle: SKSpriteNode!
    var circletext: SKTexture!
    var circle2: SKSpriteNode!
    var circle2text: SKTexture!
    var circle3: SKSpriteNode!
    var circle3text: SKTexture!
    
    var black1: SKSpriteNode!
    var black1text: SKTexture!
    
    var blue1: SKSpriteNode!
    var blue1text: SKTexture!
    var blue2: SKSpriteNode!
    var blue2text: SKTexture!
    var blue3: SKSpriteNode!
    var blue3text: SKTexture!
    var blue4: SKSpriteNode!
    var blue4text: SKTexture!
    var blue5: SKSpriteNode!
    var blue5text: SKTexture!
    var blue6: SKSpriteNode!
    var blue6text: SKTexture!
    var blue7: SKSpriteNode!
    var blue7text: SKTexture!
    var blue8: SKSpriteNode!
    var blue8text: SKTexture!
    
    var red1: SKSpriteNode!
    var red1text: SKTexture!
    var red2: SKSpriteNode!
    var red2text: SKTexture!
    var red3: SKSpriteNode!
    var red3text: SKTexture!
    var red4: SKSpriteNode!
    var red4text: SKTexture!
    var red5: SKSpriteNode!
    var red5text: SKTexture!
    
//レッドオブジェクト
    var redsquare: SKSpriteNode!
    var redsquaretext: SKTexture!
    var redsquare2: SKSpriteNode!
    var redsquare2text: SKTexture!
    
    var redcircle: SKSpriteNode!
    var redcircletext: SKTexture!
    var redcircle2: SKSpriteNode!
    var redcircle2text: SKTexture!
    var redcircle3: SKSpriteNode!
    var redcircle3text: SKTexture!
    var redtraiangr: SKSpriteNode!
    var redtraiangrtext: SKTexture!
    
    
//特殊オブジェクト
//手裏剣
    var syurin: Int = 0
    var syuripx = [CGFloat](repeating: 0, count: 100)
    var syuripy = [CGFloat](repeating: 0, count: 100)
    var syuricount = [Int](repeating: 0, count: 100)
    var syuriv = [CGFloat](repeating: 0, count: 100)
    var syuriflag = [CGFloat](repeating: 0, count: 100)
    var syuriAction: [SKSpriteNode] = []

//アクション
    var Action: [SKSpriteNode] = []
    var na = [Int](repeating: 0, count: 200)
    
    
    var repAction: [SKSpriteNode] = []
    var repcount = 0
    var repx = [CGFloat](repeating: 0, count: 100)
    var repy = [CGFloat](repeating: 0, count: 100)
    var dis = [CGFloat](repeating: 0, count: 100)
  /*
    var appearancecount = 0
    var appearanceflag = [Bool](repeating: false, count: 100)
    var appeax = [CGFloat](repeating: 0, count: 100)
    var appeay = [CGFloat](repeating: 0, count: 100)
    var appeardis = [CGFloat](repeating: 0, count: 100)
    var appearanceActuon: [SKSpriteNode] = []
    var appearobject: [SKSpriteNode] = []
    var objectcount = 0
*/
    let playAction = SKAction.play()
    
//効果音
    let ballbom = SKAudioNode.init(fileNamed: "ポップな爆発.mp3" )
    let clearbgm = SKAudioNode.init(fileNamed: "クリア音.mp3" )
    let coinbgm = SKAudioNode.init(fileNamed: "コイン獲得.mp3" )
    let middleflagbgm1 = SKAudioNode.init(fileNamed: "コイン獲得.mp3" )
    let middleflagbgm2 = SKAudioNode.init(fileNamed: "コイン獲得.mp3" )
    let middleflagbgm3 = SKAudioNode.init(fileNamed: "コイン獲得.mp3" )

    var spaceplayer:AVAudioPlayer!
    var greenbgm:AVAudioPlayer!

//    var iamgeView: UIImageView!

    func addchain(xp: CGFloat, yp: CGFloat ,sita:Int,chaincount:Int,contactlevel:Int ,n1:Int){
        var chaina: [SKSpriteNode] = []
        let f = SKShapeNode(circleOfRadius: 1)
        f.position = CGPoint(x: w / 10 * xp + w / 20, y:  w / 10 * yp + w / 20)
        f.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        f.physicsBody?.isDynamic = false
        f.physicsBody?.affectedByGravity = false
        f.physicsBody?.categoryBitMask = 0
        f.physicsBody?.collisionBitMask = 0
        addChild(f)
        for n in 1...chaincount{
            let dd = (n.cgf() - 1) * (w / 10)
            let chaintext = SKTexture(imageNamed: "black3")
            let chain = SKSpriteNode(texture: chaintext)
            chain.scale(to: CGSize(width: w / 10  ,height: w / 10  ))
            if sita == 0{
                chain.position = CGPoint(x: w / 20 + w / 10 * xp + dd, y: w / 20 + w / 10 * yp)
            }else if sita == 90{
                chain.position = CGPoint(x: w / 20 + w / 10 * xp, y: w / 20 + w / 10 * yp + dd)
            }else if sita == 180{
                chain.position = CGPoint(x: w / 20 + w / 10 * xp - dd, y: w / 20 + w / 10 * yp)
            }else{
                chain.position = CGPoint(x: w / 20 + w / 10 * xp, y: w / 20 + w / 10 * yp - dd)
            }
            chain.physicsBody = SKPhysicsBody(texture: chaintext, size: chain.frame.size )
            chain.physicsBody?.restitution = 0.0
            chain.physicsBody?.affectedByGravity = false
            chain.physicsBody?.isDynamic = true
            if contactlevel == 0{
                chain.physicsBody?.categoryBitMask = 0
                chain.physicsBody?.collisionBitMask = 0
                chain.alpha = 0.2
            }else if contactlevel == 1{
                chain.physicsBody?.categoryBitMask = chain1Category
                chain.physicsBody?.collisionBitMask = chain1contact
                chain.alpha = 0.5
            }else{
                chain.physicsBody?.categoryBitMask = blueblockCategory
                chain.physicsBody?.collisionBitMask = blueblockcontact
            }
            chain.physicsBody?.contactTestBitMask = 0
            addChild(chain)
            chaina.append(chain)
            
            if n != 1{
                let jointB = SKPhysicsJointPin.joint(withBodyA: chaina[n-1].physicsBody!, bodyB: chaina[n-2].physicsBody!, anchor: CGPoint(x: (chaina[n-1].position.x + chaina[n-2].position.x) / 2, y: (chaina[n-1].position.y + chaina[n-2].position.y) / 2) )
                physicsWorld.add(jointB)
            }
        }
        let jointA = SKPhysicsJointPin.joint(withBodyA: f.physicsBody!, bodyB: chaina[0].physicsBody!, anchor: f.position)
        physicsWorld.add(jointA)
        
        if n1 != 0{
            Action.append(chaina[chaincount - 1])
            na[n1] = Action.count
        }
    }
    
    func addchain2(xp: CGFloat, yp: CGFloat ,tate:Bool,chaincount:Int,contactlevel:Int ,n1:Int , n2:Int){
        var chaina: [SKSpriteNode] = []
        for n in 1...chaincount{
            let yy = (n.cgf() - 1) * (w / 10)
            let chaintext = SKTexture(imageNamed: "black3")
            let chain = SKSpriteNode(texture: chaintext)
            chain.scale(to: CGSize(width: w / 10  ,height: w / 10  ))
            if tate{
                chain.position = CGPoint(x: w / 20 + w / 10 * xp, y: w / 20 + w / 10 * yp + yy)
            }else{
                chain.position = CGPoint(x: w / 20 + w / 10 * xp + yy, y: w / 20 + w / 10 * yp)
            }
            chain.physicsBody = SKPhysicsBody(texture: chaintext, size: chain.frame.size )
            chain.physicsBody?.restitution = 0.0
            chain.physicsBody?.affectedByGravity = false
            chain.physicsBody?.isDynamic = true
            if contactlevel == 0{
                chain.physicsBody?.categoryBitMask = 0
                chain.physicsBody?.collisionBitMask = 0
                chain.alpha = 0.2
            }else if contactlevel == 1{
                chain.physicsBody?.categoryBitMask = chain1Category
                chain.physicsBody?.collisionBitMask = chain1contact
                chain.alpha = 0.5
            }else{
                chain.physicsBody?.categoryBitMask = blueblockCategory
                chain.physicsBody?.collisionBitMask = blueblockcontact
            }
            chain.physicsBody?.contactTestBitMask = 0
            addChild(chain)
            chaina.append(chain)
            
            if n != 1{
                let jointB = SKPhysicsJointPin.joint(withBodyA: chaina[n-1].physicsBody!, bodyB: chaina[n-2].physicsBody!, anchor: CGPoint(x: (chaina[n-1].position.x + chaina[n-2].position.x) / 2, y: (chaina[n-1].position.y + chaina[n-2].position.y) / 2) )
                physicsWorld.add(jointB)
            }
        }
        if n1 != 0{
            Action.append(chaina[0])
            na[n1] = Action.count
        }
        if n2 != 0{
            Action.append(chaina[chaincount - 1])
            na[n2] = Action.count
        }
    }
    
    func addsyuriken(xp: CGFloat, yp: CGFloat  ,v:CGFloat){
        syurin = syurin + 1
        syuripx[syurin] = w / 10 + w / 10 * xp
        syuripy[syurin] = w / 10 + w / 10 * yp
        syuriv[syurin] = v
    }
    
    func addsyurikens(n: Int , r: CGFloat){
        let syurikentext = SKTexture(imageNamed: "syuriken")
        let syuriken = SKSpriteNode(texture: syurikentext)
        syuriken.scale(to: CGSize(width: w / 5  ,height: w / 5 ))
        syuriken.position = CGPoint(x: syuripx[n], y: syuripy[n])
        syuriken.physicsBody = SKPhysicsBody(texture: syurikentext, size: syuriken.frame.size )
        syuriken.physicsBody?.restitution = 0.0
        syuriken.physicsBody?.affectedByGravity = false
        syuriken.physicsBody?.isDynamic = true
        syuriken.physicsBody?.categoryBitMask = bulletCategory
        syuriken.physicsBody?.contactTestBitMask = ballCategory
        syuriken.physicsBody?.collisionBitMask = bulletcontact
        addChild(syuriken)
        
        let rotationAction = SKAction.rotate(byAngle: 360 / 180 * .pi, duration: 0.5)
        let waitAciton = SKAction.wait(forDuration: 1.0)
        let moveAction = SKAction.move(to: ball.position, duration: (r / (syuriv[n] * w)).dou())
        let dAction = SKAction.removeFromParent()
        syuriken.run(SKAction.repeatForever(rotationAction))
        syuriken.run(SKAction.sequence([waitAciton,moveAction,dAction]))
    }
    
    func addgoal(xp:CGFloat ,yp:CGFloat,n:Int){
        goaltext = SKTexture(imageNamed: "flag")
        goal = SKSpriteNode(texture: goaltext)
        goal.scale(to: CGSize(width: w / 8  ,height: w / 8 ))
        goal.position = CGPoint(x: w / 16 + w / 10 * xp, y: w / 16 + w / 10 * yp)
        goal.physicsBody = SKPhysicsBody(texture: goaltext, size: goal.frame.size )
        goal.physicsBody?.restitution = 0.0
        goal.physicsBody?.affectedByGravity = false
        goal.physicsBody?.isDynamic = false
        goal.physicsBody?.categoryBitMask = goalCategory
        goal.physicsBody?.contactTestBitMask = ballCategory
        goal.physicsBody?.collisionBitMask = 0
        clearbgm.autoplayLooped = false
        goal.addChild(clearbgm)
        if n != 0{
            Action.append(goal)
            na[n] = Action.count
        }
        addChild(goal)
    }
    
    func addmiddleflag1(xp:CGFloat ,yp:CGFloat){
        middleflagtext = SKTexture(imageNamed: "middleflag")
        middleflag1 = SKSpriteNode(texture: middleflagtext)
        middleflag1.scale(to: CGSize(width: w / 8  ,height: w / 8 ))
        middleflag1.position = CGPoint(x: w / 16 + w / 10 * xp, y: w / 16 + w / 10 * yp)
        middleflag1.physicsBody = SKPhysicsBody(texture: middleflagtext, size: middleflag1.frame.size )
        middleflag1.physicsBody?.restitution = 0.0
        middleflag1.physicsBody?.affectedByGravity = false
        middleflag1.physicsBody?.isDynamic = false
        middleflag1.physicsBody?.categoryBitMask = middleflag1Category
        middleflag1.physicsBody?.contactTestBitMask = ballCategory
        middleflag1.physicsBody?.collisionBitMask = 0
        middleflagbgm1.autoplayLooped = false
        middleflag1.addChild(middleflagbgm1)
        addChild(middleflag1)
    }
    
    func addmiddleflag2(xp:CGFloat ,yp:CGFloat){
        middleflagtext = SKTexture(imageNamed: "middleflag")
        middleflag2 = SKSpriteNode(texture: middleflagtext)
        middleflag2.scale(to: CGSize(width: w / 8  ,height: w / 8 ))
        middleflag2.position = CGPoint(x: w / 16 + w / 10 * xp, y: w / 16 + w / 10 * yp)
        middleflag2.physicsBody = SKPhysicsBody(texture: middleflagtext, size: middleflag2.frame.size )
        middleflag2.physicsBody?.restitution = 0.0
        middleflag2.physicsBody?.affectedByGravity = false
        middleflag2.physicsBody?.isDynamic = false
        middleflag2.physicsBody?.categoryBitMask = middleflag2Category
        middleflag2.physicsBody?.contactTestBitMask = ballCategory
        middleflag2.physicsBody?.collisionBitMask = 0
        middleflagbgm2.autoplayLooped = false
        middleflag2.addChild(middleflagbgm2)
        addChild(middleflag2)
    }
    
    func addmiddleflag3(xp:CGFloat ,yp:CGFloat){
        middleflagtext = SKTexture(imageNamed: "middleflag")
        middleflag3 = SKSpriteNode(texture: middleflagtext)
        middleflag3.scale(to: CGSize(width: w / 8  ,height: w / 8 ))
        middleflag3.position = CGPoint(x: w / 16 + w / 10 * xp, y: w / 16 + w / 10 * yp)
        middleflag3.physicsBody = SKPhysicsBody(texture: middleflagtext, size: middleflag3.frame.size )
        middleflag3.physicsBody?.restitution = 0.0
        middleflag3.physicsBody?.affectedByGravity = false
        middleflag3.physicsBody?.isDynamic = false
        middleflag3.physicsBody?.categoryBitMask = middleflag3Category
        middleflag3.physicsBody?.contactTestBitMask = ballCategory
        middleflag3.physicsBody?.collisionBitMask = 0
        middleflagbgm3.autoplayLooped = false
        middleflag3.addChild(middleflagbgm3)
        addChild(middleflag3)
    }
    
    func addcoin(xp:CGFloat ,yp:CGFloat,n:Int){
        cointext = SKTexture(imageNamed: "coin")
        coin = SKSpriteNode(texture: cointext)
        coin.scale(to: CGSize(width: w / 8  ,height: w / 8 ))
        coin.position = CGPoint(x: w / 16 + w / 10 * xp, y: w / 16 + w / 10 * yp)
        coin.physicsBody = SKPhysicsBody(texture: cointext, size: coin.frame.size )
        coin.physicsBody?.restitution = 0.0
        coin.physicsBody?.affectedByGravity = false
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.contactTestBitMask = ballCategory
        coin.physicsBody?.collisionBitMask = 0
        coinbgm.autoplayLooped = false
        coin.addChild(coinbgm)
        if n != 0{
            Action.append(coin)
            na[n] = Action.count
        }
        addChild(coin)
    }
    
    func addsquare(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        squaretext = SKTexture(imageNamed: "square")
        square = SKSpriteNode(texture: squaretext)
        square.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        square.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        square.physicsBody = SKPhysicsBody(texture: squaretext, size: square.frame.size)
        square.zRotation = CGFloat(angle * .pi / 180)
        square.physicsBody?.restitution = 0.1
        square.physicsBody?.affectedByGravity = false
        square.physicsBody?.isDynamic = false
        square.physicsBody?.categoryBitMask = blockCategory
        square.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        square.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(square)
            na[n] = Action.count
        }
        addChild(square)
    }
    
    func addsquare5(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        square5text = SKTexture(imageNamed: "square5")
        square5 = SKSpriteNode(texture: square5text)
        square5.scale(to: CGSize(width: w * 2 / 5 * xs , height: w * 2 / 5 *  ys))
        square5.position = CGPoint(x: w / 5 * xs + w / 10 * xp, y: w / 5 * ys + w / 10 * yp)
        square5.physicsBody = SKPhysicsBody(texture: square5text, size: square5.frame.size)
        square5.zRotation = CGFloat(angle * .pi / 180)
        square5.physicsBody?.restitution = 0.1
        square5.physicsBody?.affectedByGravity = false
        square5.physicsBody?.isDynamic = false
        square5.physicsBody?.categoryBitMask = blockCategory
        square5.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        square5.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(square5)
            na[n] = Action.count
        }
        addChild(square5)
    }
    
    func addtraiangr(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,mirror:Bool, angle:Double , n: Int){
        if mirror{
            traiangrtext = SKTexture(imageNamed: "traiangr2")
        }else{
            traiangrtext = SKTexture(imageNamed: "traiangr")
        }
        traiangr = SKSpriteNode(texture: traiangrtext)
        traiangr.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        traiangr.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        traiangr.physicsBody = SKPhysicsBody(texture: traiangrtext, size: traiangr.frame.size)
        traiangr.zRotation = CGFloat(angle * .pi / 180)
        traiangr.physicsBody?.restitution = 0.1
        traiangr.physicsBody?.affectedByGravity = false
        traiangr.physicsBody?.isDynamic = false
        traiangr.physicsBody?.categoryBitMask = blockCategory
        traiangr.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        traiangr.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(traiangr)
            na[n] = Action.count
        }
        addChild(traiangr)
    }
    
    func addball2(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,distance:CGFloat){
        ball2text = SKTexture(imageNamed: "ball2")
        ball2 = SKSpriteNode(texture: ball2text)
        ball2.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        ball2.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        ball2.physicsBody = SKPhysicsBody(texture: ball2text, size: ball2.frame.size)
        ball2.physicsBody?.restitution = 0.1
        ball2.physicsBody?.affectedByGravity = true
        ball2.physicsBody?.isDynamic = true
        ball2.physicsBody?.categoryBitMask = blueblockCategory
        ball2.physicsBody?.collisionBitMask = blueblockcontact
        repcount = repcount + 1
        repAction.append(ball2)
        repx[repcount] = ball2.position.x
        repy[repcount] = ball2.position.y
        dis[repcount] = distance
        addChild(ball2)
    }
    
    func addsquare2(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        square2text = SKTexture(imageNamed: "square2")
        square2 = SKSpriteNode(texture: square2text)
        square2.scale(to: CGSize(width: w  / 2 * xs , height: w / 2 *  ys))
        square2.position = CGPoint(x: w / 4 * xs + w / 10 * xp, y: w / 4 * ys + w / 10 * yp)
        square2.physicsBody = SKPhysicsBody(texture: square2text, size: square2.frame.size)
        square2.zRotation = CGFloat(angle * .pi / 180)
        square2.physicsBody?.restitution = 0.1
        square2.physicsBody?.affectedByGravity = false
        square2.physicsBody?.isDynamic = false
        square2.physicsBody?.categoryBitMask = blockCategory
        square2.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        square2.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(square2)
            na[n] = Action.count
        }
        addChild(square2)
    }
    
    func addsquare3(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        square3text = SKTexture(imageNamed: "square3")
        square3 = SKSpriteNode(texture: square3text)
        square3.scale(to: CGSize(width: w * xs, height: w * ys))
        square3.position = CGPoint(x: w / 2 * xs + w / 10 * xp, y: w / 2 * ys + w / 10 * yp)
        square3.physicsBody = SKPhysicsBody(texture: square3text, size: square3.frame.size)
        square3.zRotation = CGFloat(angle * .pi / 180)
        square3.physicsBody?.restitution = 0.1
        square3.physicsBody?.affectedByGravity = false
        square3.physicsBody?.isDynamic = false
        square3.physicsBody?.categoryBitMask = blockCategory
        square3.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        square3.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(square3)
            na[n] = Action.count
        }
        addChild(square3)
    }
    
    func addsquare4(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        square4text = SKTexture(imageNamed: "square4")
        square4 = SKSpriteNode(texture: square4text)
        square4.scale(to: CGSize(width: w  * xs, height: w  * ys))
        square4.position = CGPoint(x: w / 2 * xs + w / 10 * xp, y: w / 2 * ys + w / 10 * yp)
        square4.physicsBody = SKPhysicsBody(texture: square4text, size: square4.frame.size)
        square4.zRotation = CGFloat(angle * .pi / 180)
        square4.physicsBody?.restitution = 0.1
        square4.physicsBody?.affectedByGravity = false
        square4.physicsBody?.isDynamic = false
        square4.physicsBody?.categoryBitMask = blockCategory
        square4.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        square4.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(square4)
            na[n] = Action.count
        }
        addChild(square4)
    }
    
    func addbluesquare(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        bluesquaretext = SKTexture(imageNamed: "bluesquare")
        bluesquare = SKSpriteNode(texture: bluesquaretext)
        bluesquare.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        bluesquare.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        bluesquare.physicsBody = SKPhysicsBody(texture: bluesquaretext, size: bluesquare.frame.size)
        bluesquare.zRotation = CGFloat(angle * .pi / 180)
        bluesquare.physicsBody?.restitution = 0.0
        bluesquare.physicsBody?.linearDamping = 0.70
        bluesquare.physicsBody?.angularDamping = 0.80
        bluesquare.physicsBody?.mass = 2.0
        bluesquare.physicsBody?.affectedByGravity = false
        bluesquare.physicsBody?.isDynamic = true
        bluesquare.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare)
            na[n] = Action.count
        }
        addChild(bluesquare)
    }
    
    func addbluesquare7(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double , n: Int){
        bluesquaretext = SKTexture(imageNamed: "bluesquare")
        bluesquare = SKSpriteNode(texture: bluesquaretext)
        bluesquare.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        bluesquare.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        bluesquare.physicsBody = SKPhysicsBody(texture: bluesquaretext, size: bluesquare.frame.size)
        bluesquare.zRotation = CGFloat(angle * .pi / 180)
        bluesquare.physicsBody?.restitution = 0.0
        bluesquare.physicsBody?.affectedByGravity = false
        bluesquare.physicsBody?.isDynamic = false
        bluesquare.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare)
            na[n] = Action.count
        }
        addChild(bluesquare)
    }
    
    func addbluesquare2(xp:Int, yp:Int, angle:Double ,small:Bool, n: Int){
        bluesquare2text = SKTexture(imageNamed: "bluesquare2")
        bluesquare2 = SKSpriteNode(texture: bluesquare2text)
        if small{
            bluesquare2.scale(to: CGSize(width: w / 3 * CGFloat(resize), height: w / 3 * CGFloat(resize)))
            bluesquare2.position = CGPoint(x: w / 6  + w / 10 * CGFloat(xp), y: w / 6  + w / 10 * CGFloat(yp))
        }else{
            bluesquare2.scale(to: CGSize(width: w / 2 * CGFloat(resize), height: w / 2 * CGFloat(resize)))
            bluesquare2.position = CGPoint(x: w / 4  + w / 10 * CGFloat(xp), y: w / 4  + w / 10 * CGFloat(yp))
        }
        bluesquare2.physicsBody = SKPhysicsBody(texture: bluesquare2text, size: bluesquare2.frame.size)
        bluesquare2.zRotation = CGFloat(angle * .pi / 180)
        bluesquare2.physicsBody?.restitution = 0.0
        bluesquare2.physicsBody?.linearDamping = 0.70
        bluesquare2.physicsBody?.angularDamping = 0.80
        bluesquare2.physicsBody?.mass = 2.0
        bluesquare2.physicsBody?.affectedByGravity = false
        bluesquare2.physicsBody?.isDynamic = true
        bluesquare2.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare2.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare2)
            na[n] = Action.count
        }
        addChild(bluesquare2)
    }
    
    func addbluesquare3(xp:Int, yp:Int , angle:Double ,small:Bool, n: Int){
        bluesquare3text = SKTexture(imageNamed: "bluesquare3")
        bluesquare3 = SKSpriteNode(texture: bluesquare3text)
        if small{
            bluesquare3.scale(to: CGSize(width: w / 3 * CGFloat(resize), height: w / 3 * CGFloat(resize)))
            bluesquare3.position = CGPoint(x: w / 6  + w / 10 * CGFloat(xp), y: w / 6  + w / 10 * CGFloat(yp))
        }else{
            bluesquare3.scale(to: CGSize(width: w / 2 * CGFloat(resize), height: w / 2 * CGFloat(resize)))
            bluesquare3.position = CGPoint(x: w / 4  + w / 10 * CGFloat(xp), y: w / 4  + w / 10 * CGFloat(yp))
        }
        bluesquare3.physicsBody = SKPhysicsBody(texture: bluesquare3text, size: bluesquare3.frame.size)
        bluesquare3.zRotation = CGFloat(angle * .pi / 180)
        bluesquare3.physicsBody?.restitution = 0.0
        bluesquare3.physicsBody?.linearDamping = 0.70
        bluesquare3.physicsBody?.angularDamping = 0.80
        bluesquare3.physicsBody?.mass = 2.0
        bluesquare3.physicsBody?.affectedByGravity = false
        bluesquare3.physicsBody?.isDynamic = true
        bluesquare3.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare3.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare3)
            na[n] = Action.count
        }
        addChild(bluesquare3)
    }
    
    func addbluesquare4(xp:Int, yp:Int , angle:Double ,small:Bool, n: Int){
        bluesquare4text = SKTexture(imageNamed: "bluesquare4")
        bluesquare4 = SKSpriteNode(texture: bluesquare4text)
        if small{
            bluesquare4.scale(to: CGSize(width: w / 3 * 2 * CGFloat(resize), height: w / 3 * CGFloat(resize)))
            bluesquare4.position = CGPoint(x: w / 3 + w / 10 * CGFloat(xp), y: w / 6 + w / 10 * CGFloat(yp))
        }else{
            bluesquare4.scale(to: CGSize(width: w * CGFloat(resize), height: w / 2 * CGFloat(resize)))
            bluesquare4.position = CGPoint(x: w / 2 + w / 10 * CGFloat(xp), y: w / 4 + w / 10 * CGFloat(yp))
        }
        bluesquare4.physicsBody = SKPhysicsBody(texture: bluesquare4text, size: bluesquare4.frame.size)
        bluesquare4.zRotation = CGFloat(angle * .pi / 180)
        bluesquare4.physicsBody?.restitution = 0.0
        bluesquare4.physicsBody?.linearDamping = 0.70
        bluesquare4.physicsBody?.angularDamping = 0.80
        bluesquare4.physicsBody?.mass = 2.0
        bluesquare4.physicsBody?.affectedByGravity = false
        bluesquare4.physicsBody?.isDynamic = true
        bluesquare4.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare4.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare4)
            na[n] = Action.count
        }
        addChild(bluesquare4)
    }
    
    func addbluesquare6(xp:Int, yp:Int , angle:Double ,small:Bool, n: Int){
        bluesquare6text = SKTexture(imageNamed: "bluesquare6")
        bluesquare6 = SKSpriteNode(texture: bluesquare6text)
        if small{
            bluesquare6.scale(to: CGSize(width: w / 3 * CGFloat(resize), height: w / 3 * 2 * CGFloat(resize)))
            bluesquare6.position = CGPoint(x: w / 6 + w / 10 * CGFloat(xp), y: w / 3 + w / 10 * CGFloat(yp))
        }else{
            bluesquare6.scale(to: CGSize(width: w / 2 * CGFloat(resize), height: w * CGFloat(resize)))
            bluesquare6.position = CGPoint(x: w / 4 + w / 10 * CGFloat(xp), y: w / 2 + w / 10 * CGFloat(yp))
        }
        bluesquare6.physicsBody = SKPhysicsBody(texture: bluesquare6text, size: bluesquare6.frame.size)
        bluesquare6.zRotation = CGFloat(angle * .pi / 180)
        bluesquare6.physicsBody?.restitution = 0.0
        bluesquare6.physicsBody?.linearDamping = 0.70
        bluesquare6.physicsBody?.angularDamping = 0.80
        bluesquare6.physicsBody?.mass = 2.0
        bluesquare6.physicsBody?.affectedByGravity = false
        bluesquare6.physicsBody?.isDynamic = true
        bluesquare6.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare6.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare6)
            na[n] = Action.count
        }
        addChild(bluesquare6)
    }
    
    func addbluesquare5(xp:Int, yp:Int, angle:Double ,small:Bool, n: Int){
        bluesquare5text = SKTexture(imageNamed: "bluesquare5")
        bluesquare5 = SKSpriteNode(texture: bluesquare5text)
        if small{
            bluesquare5.scale(to: CGSize(width: w / 3 * 2 * CGFloat(resize), height: w / 3 * 2 * CGFloat(resize)))
            bluesquare5.position = CGPoint(x: w / 3 + w / 10 * CGFloat(xp), y: w / 3 + w / 10 * CGFloat(yp))
        }else{
            bluesquare5.scale(to: CGSize(width: w * CGFloat(resize), height: w * CGFloat(resize)))
            bluesquare5.position = CGPoint(x: w / 2 + w / 10 * CGFloat(xp), y: w / 2 + w / 10 * CGFloat(yp))
        }
        bluesquare5.physicsBody = SKPhysicsBody(texture: bluesquare5text, size: bluesquare5.frame.size)
        bluesquare5.zRotation = CGFloat(angle * .pi / 180)
        bluesquare5.physicsBody?.restitution = 0.0
        bluesquare5.physicsBody?.linearDamping = 0.70
        bluesquare5.physicsBody?.angularDamping = 0.80
        bluesquare5.physicsBody?.mass = 2.0
        bluesquare5.physicsBody?.affectedByGravity = false
        bluesquare5.physicsBody?.isDynamic = true
        bluesquare5.physicsBody?.categoryBitMask = blueblockCategory
        bluesquare5.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluesquare5)
            na[n] = Action.count
        }
        addChild(bluesquare5)
    }

    func addbluecircle(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        bluecircletext = SKTexture(imageNamed: "bluecircle")
        bluecircle = SKSpriteNode(texture: bluecircletext)
        bluecircle.scale(to: CGSize(width: w / 10 * CGFloat(xs), height: w / 10 *  CGFloat(ys)))
        bluecircle.position = CGPoint(x: w / 20 * CGFloat(xs) + w / 10 * CGFloat(xp), y: w / 20 * CGFloat(ys) + w / 10 * CGFloat(yp))
        bluecircle.physicsBody = SKPhysicsBody(texture: bluecircletext, size: bluecircle.frame.size)
        bluecircle.zRotation = CGFloat(angle * .pi / 180)
        bluecircle.physicsBody?.restitution = 0.1
        bluecircle.physicsBody?.affectedByGravity = true
        bluecircle.physicsBody?.isDynamic = true
        bluecircle.physicsBody?.categoryBitMask = blueblockCategory
        bluecircle.physicsBody?.collisionBitMask = blueblockcontact
        if n != 0{
            Action.append(bluecircle)
            na[n] = Action.count
        }
        addChild(bluecircle)
    }
    
    func addgreensquare(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , angle:Double ,friction: CGFloat ,n: Int){
        greensquaretext = SKTexture(imageNamed: "greensquare")
        greensquare = SKSpriteNode(texture: greensquaretext)
        greensquare.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        greensquare.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        greensquare.physicsBody = SKPhysicsBody(texture: greensquaretext, size: greensquare.frame.size)
        greensquare.zRotation = CGFloat(angle * .pi / 180)
        greensquare.physicsBody?.restitution = 1.0
        greensquare.physicsBody?.friction = friction
        greensquare.physicsBody?.affectedByGravity = false
        greensquare.physicsBody?.isDynamic = false
        greensquare.physicsBody?.categoryBitMask = greenblockCategory
        greensquare.physicsBody?.contactTestBitMask = greenblockcontact
        greensquare.physicsBody?.collisionBitMask = greenblockcontact
        if n != 0{
            Action.append(greensquare)
            na[n] = Action.count
        }
        addChild(greensquare)
    }
    
    func addgreencircle(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , friction:CGFloat , n: Int){
        greencircletext = SKTexture(imageNamed: "greencircle")
        greencircle = SKSpriteNode(texture: greencircletext)
        greencircle.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        greencircle.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        greencircle.physicsBody = SKPhysicsBody(texture: greencircletext, size: greencircle.frame.size)
        greencircle.physicsBody?.restitution = 1.0
        greencircle.physicsBody?.affectedByGravity = false
        greencircle.physicsBody?.isDynamic = false
        greencircle.physicsBody?.friction = friction
        greencircle.physicsBody?.categoryBitMask = greenblockCategory
        greencircle.physicsBody?.contactTestBitMask = ballCategory + bulletCategory + blueblockCategory
        greencircle.physicsBody?.collisionBitMask = greenblockcontact
        if n != 0{
            Action.append(greencircle)
            na[n] = Action.count
        }
        addChild(greencircle)
    }
    
    func addgreencircle3(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , mirror:Bool,angle:Double ,friction: CGFloat ,n: Int){
        if mirror{
            greencircle3text = SKTexture(imageNamed: "greencircle3_2")
        }else{
            greencircle3text = SKTexture(imageNamed: "greencircle3")
        }
        greencircle3 = SKSpriteNode(texture: greencircle3text)
        greencircle3.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        greencircle3.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        greencircle3.physicsBody = SKPhysicsBody(texture: greencircle3text, size: greencircle3.frame.size)
        greencircle3.zRotation = CGFloat(angle * .pi / 180)
        greencircle3.physicsBody?.restitution = 1.0
        greencircle3.physicsBody?.friction = friction
        greencircle3.physicsBody?.affectedByGravity = false
        greencircle3.physicsBody?.isDynamic = false
        greencircle3.physicsBody?.categoryBitMask = greenblockCategory
        greencircle3.physicsBody?.contactTestBitMask = ballCategory + bulletCategory + blueblockCategory
        greencircle3.physicsBody?.collisionBitMask = greenblockcontact
        if n != 0{
            Action.append(greencircle3)
            na[n] = Action.count
        }
        addChild(greencircle3)
    }
    
    func addgreencircle2(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , tate:Bool ,angle:Double , friction: CGFloat ,n: Int){
        if tate{
            greencircle2text = SKTexture(imageNamed: "greencircle2_2")
        }else{
            greencircle2text = SKTexture(imageNamed: "greencircle2")
        }
        greencircle2 = SKSpriteNode(texture: greencircle2text)
        greencircle2.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        greencircle2.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        greencircle2.physicsBody = SKPhysicsBody(texture: greencircle2text, size: greencircle2.frame.size)
        greencircle2.zRotation = CGFloat(angle * .pi / 180)
        greencircle2.physicsBody?.restitution = 1.0
        greencircle2.physicsBody?.friction = friction
        greencircle2.physicsBody?.affectedByGravity = false
        greencircle2.physicsBody?.isDynamic = false
        greencircle2.physicsBody?.categoryBitMask = greenblockCategory
        greencircle2.physicsBody?.contactTestBitMask = ballCategory + bulletCategory + blueblockCategory
        greencircle2.physicsBody?.collisionBitMask = greenblockcontact
        if n != 0{
            Action.append(greencircle2)
            na[n] = Action.count
        }
        addChild(greencircle2)
    }
    
    func addgreentraiangr(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat , mirror:Bool,angle:Double ,friction: CGFloat ,n: Int){
        if mirror{
            greentraiangrtext = SKTexture(imageNamed: "greentraiangr2")
        }else{
            greentraiangrtext = SKTexture(imageNamed: "greentraiangr")
        }
        greentraiangr = SKSpriteNode(texture: greentraiangrtext)
        greentraiangr.scale(to: CGSize(width: w / 10 * CGFloat(xs), height: w / 10 *  CGFloat(ys)))
        greentraiangr.position = CGPoint(x: w / 20 * CGFloat(xs) + w / 10 * CGFloat(xp), y: w / 20 * CGFloat(ys) + w / 10 * CGFloat(yp))
        greentraiangr.physicsBody = SKPhysicsBody(texture: greentraiangrtext, size: greentraiangr.frame.size)
        greentraiangr.zRotation = CGFloat(angle * .pi / 180)
        greentraiangr.physicsBody?.restitution = 1.0
        greentraiangr.physicsBody?.friction = friction
        greentraiangr.physicsBody?.affectedByGravity = false
        greentraiangr.physicsBody?.isDynamic = false
        greentraiangr.physicsBody?.categoryBitMask = greenblockCategory
        greentraiangr.physicsBody?.contactTestBitMask = ballCategory + bulletCategory + blueblockCategory
        greentraiangr.physicsBody?.collisionBitMask = greenblockcontact
        if n != 0{
            Action.append(greentraiangr)
            na[n] = Action.count
        }
        addChild(greentraiangr)
    }
    
    func addblue1(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue1text = SKTexture(imageNamed: "blue1")
        blue1 = SKSpriteNode(texture: blue1text)
        blue1.scale(to: CGSize(width: w / 2 * CGFloat(xs), height: w / 10 *  CGFloat(ys)))
        blue1.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue1.physicsBody = SKPhysicsBody(texture: blue1text, size: blue1.frame.size)
        blue1.zRotation = CGFloat(angle * .pi / 180)
        blue1.physicsBody?.restitution = 0.1
        blue1.physicsBody?.affectedByGravity = false
        blue1.physicsBody?.isDynamic = false
        blue1.physicsBody?.categoryBitMask = blockCategory
        blue1.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue1.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue1)
            na[n] = Action.count
        }
        addChild(blue1)
    }
    
    func addblue2(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue2text = SKTexture(imageNamed: "blue2")
        blue2 = SKSpriteNode(texture: blue2text)
        blue2.scale(to: CGSize(width: w / 3 * CGFloat(xs), height: w / 5 *  CGFloat(ys)))
        blue2.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue2.physicsBody = SKPhysicsBody(texture: blue2text, size: blue2.frame.size)
        blue2.zRotation = CGFloat(angle * .pi / 180)
        blue2.physicsBody?.restitution = 0.1
        blue2.physicsBody?.affectedByGravity = false
        blue2.physicsBody?.isDynamic = false
        blue2.physicsBody?.categoryBitMask = blockCategory
        blue2.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue2.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue2)
            na[n] = Action.count
        }
        addChild(blue2)
    }
    
    func addblue3(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue3text = SKTexture(imageNamed: "blue3")
        blue3 = SKSpriteNode(texture: blue3text)
        blue3.scale(to: CGSize(width: w / 10 * CGFloat(xs), height: w / 10 *  CGFloat(ys)))
        blue3.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue3.physicsBody = SKPhysicsBody(texture: blue3text, size: blue3.frame.size)
        blue3.zRotation = CGFloat(angle * .pi / 180)
        blue3.physicsBody?.restitution = 0.1
        blue3.physicsBody?.affectedByGravity = false
        blue3.physicsBody?.isDynamic = false
        blue3.physicsBody?.categoryBitMask = blockCategory
        blue3.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue3.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue3)
            na[n] = Action.count
        }
        addChild(blue3)
    }
    
    func addblue4(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue4text = SKTexture(imageNamed: "blue4")
        blue4 = SKSpriteNode(texture: blue4text)
        blue4.scale(to: CGSize(width: w / 5 * CGFloat(xs), height: w / 3 *  CGFloat(ys)))
        blue4.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue4.physicsBody = SKPhysicsBody(texture: blue4text, size: blue4.frame.size)
        blue4.zRotation = CGFloat(angle * .pi / 180)
        blue4.physicsBody?.restitution = 0.1
        blue4.physicsBody?.affectedByGravity = false
        blue4.physicsBody?.isDynamic = false
        blue4.physicsBody?.categoryBitMask = blockCategory
        blue4.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue4.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue4)
            na[n] = Action.count
        }
        addChild(blue4)
    }
    
    func addblue5(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue5text = SKTexture(imageNamed: "blue5")
        blue5 = SKSpriteNode(texture: blue5text)
        blue5.scale(to: CGSize(width: w / 10 * CGFloat(xs), height: w / 3 *  CGFloat(ys)))
        blue5.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue5.physicsBody = SKPhysicsBody(texture: blue5text, size: blue5.frame.size)
        blue5.zRotation = CGFloat(angle * .pi / 180)
        blue5.physicsBody?.restitution = 0.1
        blue5.physicsBody?.affectedByGravity = false
        blue5.physicsBody?.isDynamic = false
        blue5.physicsBody?.categoryBitMask = blockCategory
        blue5.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue5.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue5)
            na[n] = Action.count
        }
        addChild(blue5)
    }
    
    func addblue6(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue6text = SKTexture(imageNamed: "blue6")
        blue6 = SKSpriteNode(texture: blue6text)
        blue6.scale(to: CGSize(width: w / 2 * CGFloat(xs), height: w / 2 *  CGFloat(ys)))
        blue6.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue6.physicsBody = SKPhysicsBody(texture: blue6text, size: blue6.frame.size)
        blue6.zRotation = CGFloat(angle * .pi / 180)
        blue6.physicsBody?.restitution = 0.1
        blue6.physicsBody?.affectedByGravity = false
        blue6.physicsBody?.isDynamic = false
        blue6.physicsBody?.categoryBitMask = blockCategory
        blue6.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue6.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue6)
            na[n] = Action.count
        }
        addChild(blue6)
    }
    
    func addblue7(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue7text = SKTexture(imageNamed: "blue7")
        blue7 = SKSpriteNode(texture: blue7text)
        blue7.scale(to: CGSize(width: w / 2 * CGFloat(xs), height: w / 4 *  CGFloat(ys)))
        blue7.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue7.physicsBody = SKPhysicsBody(texture: blue7text, size: blue7.frame.size)
        blue7.zRotation = CGFloat(angle * .pi / 180)
        blue7.physicsBody?.restitution = 0.1
        blue7.physicsBody?.affectedByGravity = false
        blue7.physicsBody?.isDynamic = false
        blue7.physicsBody?.categoryBitMask = blockCategory
        blue7.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue7.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue7)
            na[n] = Action.count
        }
        addChild(blue7)
    }
    
    func addblue8(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        blue8text = SKTexture(imageNamed: "blue8")
        blue8 = SKSpriteNode(texture: blue8text)
        blue8.scale(to: CGSize(width: w / 2 * CGFloat(xs), height: w / 2 *  CGFloat(ys)))
        blue8.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        blue8.physicsBody = SKPhysicsBody(texture: blue8text, size: blue8.frame.size)
        blue8.zRotation = CGFloat(angle * .pi / 180)
        blue8.physicsBody?.restitution = 0.1
        blue8.physicsBody?.affectedByGravity = false
        blue8.physicsBody?.isDynamic = false
        blue8.physicsBody?.categoryBitMask = blockCategory
        blue8.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        blue8.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(blue8)
            na[n] = Action.count
        }
        addChild(blue8)
    }
    
    func addcircle(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat,n: Int){
        circletext = SKTexture(imageNamed: "circle")
        circle = SKSpriteNode(texture: circletext)
        circle.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        circle.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        circle.physicsBody = SKPhysicsBody(texture: circletext, size:circle.frame.size)
        circle.physicsBody?.restitution = 0.0
        circle.physicsBody?.affectedByGravity = false
        circle.physicsBody?.isDynamic = false
        circle.physicsBody?.categoryBitMask = blockCategory
        circle.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        circle.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(circle)
            na[n] = Action.count
        }
        addChild(circle)
    }
    
    func addcircle2(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,tate:Bool, angle:Double , n: Int){
        if tate{
            circle2text = SKTexture(imageNamed: "circle2_2")
        }else{
            circle2text = SKTexture(imageNamed: "circle2")
        }
        circle2 = SKSpriteNode(texture: circle2text)
        circle2.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        circle2.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        circle2.physicsBody = SKPhysicsBody(texture: circle2text, size: circle2.frame.size)
        circle2.zRotation = CGFloat(angle * .pi / 180)
        circle2.physicsBody?.restitution = 0.1
        circle2.physicsBody?.affectedByGravity = false
        circle2.physicsBody?.isDynamic = false
        circle2.physicsBody?.categoryBitMask = blockCategory
        circle2.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        circle2.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(circle2)
            na[n] = Action.count
        }
        addChild(circle2)
    }
    
    func addcircle3(xp:CGFloat, yp:CGFloat, xs:CGFloat ,ys:CGFloat ,mirror:Bool, angle:Double , n: Int){
        if mirror{
            circle3text = SKTexture(imageNamed: "circle3_2")
        }else{
            circle3text = SKTexture(imageNamed: "circle3")
        }
        circle3 = SKSpriteNode(texture: circle3text)
        circle3.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        circle3.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        circle3.physicsBody = SKPhysicsBody(texture: circle3text, size: circle3.frame.size)
        circle3.zRotation = CGFloat(angle * .pi / 180)
        circle3.physicsBody?.restitution = 0.1
        circle3.physicsBody?.affectedByGravity = false
        circle3.physicsBody?.isDynamic = false
        circle3.physicsBody?.categoryBitMask = blockCategory
        circle3.physicsBody?.contactTestBitMask = ballCategory + bulletCategory
        circle3.physicsBody?.collisionBitMask = blockcontact
        if n != 0{
            Action.append(circle3)
            na[n] = Action.count
        }
        addChild(circle3)
    }
    
    func addredcircle(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,n: Int){
        redcircletext = SKTexture(imageNamed: "redcircle")
        redcircle = SKSpriteNode(texture: redcircletext)
        redcircle.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        redcircle.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        redcircle.physicsBody = SKPhysicsBody(texture: redcircletext, size: redcircle.frame.size)
        redcircle.physicsBody?.restitution = 0.0
        redcircle.physicsBody?.affectedByGravity = false
        redcircle.physicsBody?.isDynamic = false
        redcircle.physicsBody?.categoryBitMask = redblockCategory
        redcircle.physicsBody?.contactTestBitMask = ballCategory
        redcircle.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(redcircle)
            na[n] = Action.count
        }
        addChild(redcircle)
    }
    
    func addredcircle2(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,tate:Bool ,angle: Double,n: Int){
        if tate{
            redcircle2text = SKTexture(imageNamed: "redcircle2_2")
        }else{
            redcircle2text = SKTexture(imageNamed: "redcircle2")
        }
        redcircle2 = SKSpriteNode(texture: redcircle2text)
        redcircle2.scale(to: CGSize(width: w / 10 * xs, height: w / 10 * ys))
        redcircle2.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        redcircle2.physicsBody = SKPhysicsBody(texture: redcircle2text, size: redcircle2.frame.size)
        redcircle2.zRotation = CGFloat(angle * .pi / 180)
        redcircle2.physicsBody?.restitution = 0.0
        redcircle2.physicsBody?.affectedByGravity = false
        redcircle2.physicsBody?.isDynamic = false
        redcircle2.physicsBody?.categoryBitMask = redblockCategory
        redcircle2.physicsBody?.contactTestBitMask = ballCategory
        redcircle2.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(redcircle2)
            na[n] = Action.count
        }
        addChild(redcircle2)
    }
    
    func addredsquare(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,angle: Double,n: Int){
        redsquaretext = SKTexture(imageNamed: "redsquare")
        redsquare = SKSpriteNode(texture: redsquaretext)
        redsquare.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        redsquare.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        redsquare.physicsBody = SKPhysicsBody(texture: redsquaretext, size: redsquare.frame.size)
        redsquare.zRotation = CGFloat(angle * .pi / 180)
        redsquare.physicsBody?.restitution = 0.0
        redsquare.physicsBody?.affectedByGravity = false
        redsquare.physicsBody?.isDynamic = false
        redsquare.physicsBody?.categoryBitMask = redblockCategory
        redsquare.physicsBody?.contactTestBitMask = ballCategory
        redsquare.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(redsquare)
            na[n] = Action.count
        }
        addChild(redsquare)
    }
    
    func addredtraiangr(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,tate:Bool,angle: Double,n: Int){
        if tate{
            redtraiangrtext = SKTexture(imageNamed: "redtraiangr2")
        }else{
            redtraiangrtext = SKTexture(imageNamed: "redtraiangr")
        }
        redtraiangr = SKSpriteNode(texture: redtraiangrtext)
        redtraiangr.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        redtraiangr.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        redtraiangr.physicsBody = SKPhysicsBody(texture: redtraiangrtext, size: redtraiangr.frame.size)
        redtraiangr.zRotation = CGFloat(angle * .pi / 180)
        redtraiangr.physicsBody?.restitution = 0.0
        redtraiangr.physicsBody?.affectedByGravity = false
        redtraiangr.physicsBody?.isDynamic = false
        redtraiangr.physicsBody?.categoryBitMask = redblockCategory
        redtraiangr.physicsBody?.contactTestBitMask = ballCategory
        redtraiangr.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(redtraiangr)
            na[n] = Action.count
        }
        addChild(redtraiangr)
    }
    
    func addredsquare2(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,angle: Double,n: Int){
        redsquare2text = SKTexture(imageNamed: "redsquare2")
        redsquare2 = SKSpriteNode(texture: redsquare2text)
        redsquare2.scale(to: CGSize(width: w / 10 * xs, height: w / 10 * ys))
        redsquare2.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        redsquare2.physicsBody = SKPhysicsBody(texture: redsquare2text, size: redsquare2.frame.size)
        redsquare2.zRotation = CGFloat(angle * .pi / 180)
        redsquare2.physicsBody?.restitution = 0.0
        redsquare2.physicsBody?.affectedByGravity = false
        redsquare2.physicsBody?.isDynamic = false
        redsquare2.physicsBody?.categoryBitMask = redblockCategory2
        redsquare2.physicsBody?.contactTestBitMask = ballCategory
        redsquare2.physicsBody?.collisionBitMask = 0
        if n != 0{
            Action.append(redsquare2)
            na[n] = Action.count
        }
        addChild(redsquare2)
    }
    
    func addredcircle3(xp:CGFloat, yp:CGFloat ,xs:CGFloat ,ys:CGFloat ,mirror:Bool,angle: Double,n: Int){
        if mirror{
            redcircle3text = SKTexture(imageNamed: "redcircle3_2")
        }else{
            redcircle3text = SKTexture(imageNamed: "redcircle3")
        }
        redcircle3 = SKSpriteNode(texture: redcircle3text)
        redcircle3.scale(to: CGSize(width: w / 10 * xs, height: w / 10 *  ys))
        redcircle3.position = CGPoint(x: w / 20 * xs + w / 10 * xp, y: w / 20 * ys + w / 10 * yp)
        redcircle3.physicsBody = SKPhysicsBody(texture: redcircle3text, size: redcircle3.frame.size)
        redcircle3.zRotation = CGFloat(angle * .pi / 180)
        redcircle3.physicsBody?.restitution = 0.0
        redcircle3.physicsBody?.affectedByGravity = false
        redcircle3.physicsBody?.isDynamic = false
        redcircle3.physicsBody?.categoryBitMask = redblockCategory
        redcircle3.physicsBody?.contactTestBitMask = ballCategory
        redcircle3.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(redcircle3)
            na[n] = Action.count
        }
        addChild(redcircle3)
    }
    
    func addred1(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        red1text = SKTexture(imageNamed: "red1")
        red1 = SKSpriteNode(texture: red1text)
        red1.scale(to: CGSize(width: w / 2 * CGFloat(xs), height: w / 10 *  CGFloat(ys)))
        red1.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        red1.physicsBody = SKPhysicsBody(texture: red1text, size: red1.frame.size)
        red1.zRotation = CGFloat(angle * .pi / 180)
        red1.physicsBody?.restitution = 0.1
        red1.physicsBody?.affectedByGravity = false
        red1.physicsBody?.isDynamic = false
        red1.physicsBody?.categoryBitMask = redblockCategory
        red1.physicsBody?.contactTestBitMask = ballCategory
        red1.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(red1)
            na[n] = Action.count
        }
        addChild(red1)
    }
    
    func addred2(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        red2text = SKTexture(imageNamed: "red2")
        red2 = SKSpriteNode(texture: red2text)
        red2.scale(to: CGSize(width: w / 3 * CGFloat(xs), height: w / 5 *  CGFloat(ys)))
        red2.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        red2.physicsBody = SKPhysicsBody(texture: red2text, size: red2.frame.size)
        red2.zRotation = CGFloat(angle * .pi / 180)
        red2.physicsBody?.restitution = 0.1
        red2.physicsBody?.affectedByGravity = false
        red2.physicsBody?.isDynamic = false
        red2.physicsBody?.categoryBitMask = redblockCategory
        red2.physicsBody?.contactTestBitMask = ballCategory
        red2.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(red2)
            na[n] = Action.count
        }
        addChild(red2)
    }
    func addred3(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        red3text = SKTexture(imageNamed: "red3")
        red3 = SKSpriteNode(texture: red3text)
        red3.scale(to: CGSize(width: w / 10 * CGFloat(xs), height: w / 10 *  CGFloat(ys)))
        red3.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        red3.physicsBody = SKPhysicsBody(texture: red3text, size: red3.frame.size)
        red3.zRotation = CGFloat(angle * .pi / 180)
        red3.physicsBody?.restitution = 0.1
        red3.physicsBody?.affectedByGravity = false
        red3.physicsBody?.isDynamic = false
        red3.physicsBody?.categoryBitMask = redblockCategory
        red3.physicsBody?.contactTestBitMask = ballCategory
        red3.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(red3)
            na[n] = Action.count
        }
        addChild(red3)
    }
    
    func addred4(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        red4text = SKTexture(imageNamed: "red4")
        red4 = SKSpriteNode(texture: red4text)
        red4.scale(to: CGSize(width: w / 5 * CGFloat(xs), height: w / 3 *  CGFloat(ys)))
        red4.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        red4.physicsBody = SKPhysicsBody(texture: red4text, size: red4.frame.size)
        red4.zRotation = CGFloat(angle * .pi / 180)
        red4.physicsBody?.restitution = 0.1
        red4.physicsBody?.affectedByGravity = false
        red4.physicsBody?.isDynamic = false
        red4.physicsBody?.categoryBitMask = redblockCategory
        red4.physicsBody?.contactTestBitMask = ballCategory
        red4.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(red4)
            na[n] = Action.count
        }
        addChild(red4)
    }
    
    func addred5(xp:Int, yp:Int, xs:Int ,ys:Int , angle:Double , n: Int){
        red5text = SKTexture(imageNamed: "red5")
        red5 = SKSpriteNode(texture: red5text)
        red5.scale(to: CGSize(width: w / 10 * CGFloat(xs), height: w / 3 *  CGFloat(ys)))
        red5.position = CGPoint(x: w / 10 * CGFloat(xp), y: w / 10 * CGFloat(yp))
        red5.physicsBody = SKPhysicsBody(texture: red5text, size: red5.frame.size)
        red5.zRotation = CGFloat(angle * .pi / 180)
        red5.physicsBody?.restitution = 0.1
        red5.physicsBody?.affectedByGravity = false
        red5.physicsBody?.isDynamic = false
        red5.physicsBody?.categoryBitMask = redblockCategory
        red5.physicsBody?.contactTestBitMask = ballCategory
        red5.physicsBody?.collisionBitMask = redblockcontact
        if n != 0{
            Action.append(red5)
            na[n] = Action.count
        }
        addChild(red5)
    }
    
    func addball(xbp:Int ,ybp:Int , balln:Int){
        if balln == 0{
            balltext = SKTexture(imageNamed: "circle")
        }else if balln == 1{
            balltext = SKTexture(imageNamed: "black3")
        }
        ball = SKSpriteNode(texture: balltext)
        ball.scale(to: CGSize(width: w / 10  ,height: w / 10 ))
        ball.position = CGPoint(x: w / 10 * CGFloat(xbp), y: w / 10 * CGFloat(ybp))
        ball.physicsBody = SKPhysicsBody(texture: balltext, size: CGSize(width: ball.frame.width / CGFloat(1.1) , height: ball.frame.height / CGFloat(1.1)))
        //ボールの反射率を設置
        ball.physicsBody?.restitution = 0.1
        //ボールの衝突カテゴリーを設定
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = blockCategory + redblockCategory + goalCategory + coinCategory + bulletCategory + redblockCategory2 + greenblockCategory
        ball.physicsBody?.collisionBitMask = ballcontact
        //ボールをリスナーに設定
        self.listener = ball
        //ボール爆発音の設定
        ballbom.autoplayLooped = false
        ball.addChild(ballbom)
        
      //  greenbgm.autoplayLooped = false
     //   ball.addChild(greenbgm)
        
        //ボールの無重力音設定
//       spacebgm.autoplayLooped = false
//       ball.addChild(spacebgm)
        do{
            let spacePath = Bundle.main.path(forResource: "異空間", ofType: "mp3")
            let spaceurl = URL(fileURLWithPath: spacePath!)
            spaceplayer = try AVAudioPlayer(contentsOf: spaceurl)
            spaceplayer.prepareToPlay()
        }catch{
            print("error")
        }
        do{
            let greenPath = Bundle.main.path(forResource: "ボヨン", ofType: "mp3")
            let greenurl = URL(fileURLWithPath: greenPath!)
            greenbgm = try AVAudioPlayer(contentsOf: greenurl)
            greenbgm.prepareToPlay()
        }catch{
            print("error")
        }
        addChild(ball)
      
    }
}

