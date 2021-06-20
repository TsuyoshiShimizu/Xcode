//
//  StageS4.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stageS4: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag104")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        let ws = frame.size.width
        let hs2 = frame.size.height
        let ys = hs2 / h2
        let hs = h * ys
        let background = SKSpriteNode(imageNamed: "bg04")
        background.position = CGPoint(x: ws / 2, y: hs / 2)
        background.size = CGSize(width: ws, height: hs)
        addChild(background)
        var bx: CGFloat = 0
        var by: CGFloat = 0
        if middleflagrevel == 0{
            ballx = 1
            bally = 11
            bx = 28
            by = 57
            addmiddleflag1(xp: 19, yp: 31)
            addmiddleflag2(xp: 31, yp: 54)
            addmiddleflag3(xp: 1, yp: 54)
        }else if middleflagrevel == 1{
            ballx = 19
            bally = 31
            bx = 28
            by = 57
            addmiddleflag2(xp: 31, yp: 54)
            addmiddleflag3(xp: 1, yp: 54)
        }
        else if middleflagrevel == 2{
            ballx = 31
            bally = 54
            bx = 28
            by = 57
            addmiddleflag3(xp: 1, yp: 54)
        }
        else if middleflagrevel == 3{
            ballx = 1
            bally = 54
            bx = 0
            by = 56
        }
        
        let stagen: Int = 104
        UserDefaults.standard.set(stagen, forKey: "playstage")
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -gra)
        
        let fr = SKShapeNode(rectOf: CGSize(width: ws , height: hs ))
        fr.strokeColor = .red
        fr.lineWidth = w / 40
        fr.position = CGPoint(x: ws / 2 , y: hs / 2 )
        addChild(fr)
        physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x:0, y:0, width: ws, height: hs))
        physicsBody?.categoryBitMask = redblockCategory
        physicsBody?.contactTestBitMask = ballCategory
        physicsBody?.collisionBitMask = ballCategory
        
        //ボール作成
        addball(xbp: ballx, ybp: bally, balln: 0)
        //ゴール作成
        addgoal(xp: 2, yp: 86,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 1, yp: 20,n:0)
        }
   
        
        addsquare2(xp: 0, yp: 9, xs: 1, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 5, yp: 9, xs: 1, ys: 1, angle: 0, n: 1)
        addsquare(xp: 9, yp: 9, xs: 1, ys: 1, angle: 0, n: 2)
        addsquare(xp: 5, yp: 8, xs: 5, ys: 1, angle: 0, n: 3)
        addgreensquare(xp: 5, yp: 7, xs: 5, ys: 1, angle: 0, friction: 0, n: 4)
        adddina(n: 1)
        adddina(n: 2)
        adddina(n: 3)
        adddina(n: 4)
        addjointObject2(objectAn: 3, objectBn: 1)
        addjointObject2(objectAn: 3, objectBn: 2)
        addjointObject2(objectAn: 3, objectBn: 4)
        addrinvalid(n: 3)
        
        addredsquare(xp: 0, yp: 21, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 21, xs: 15, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 25, yp: 12, xs: 2, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 17, yp: 4, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 17, yp: 3, xs: 8, ys: 1, angle: 0, n: 5)
        addmAction(xmove: 16, ymove: 0, interval: 2, time: 10, n: 5)
        
        addredsquare2(xp: 15, yp: 0, xs: 2, ys: 14, angle: 0, n: 0)
        addredsquare2(xp: 17, yp: 0, xs: 23, ys: 3, angle: 0, n: 0)
        
        addsquare2(xp: 35, yp: 21, xs: 1, ys: 1, angle: 180, n: 0)
        
        addsquare(xp: 31, yp: 22, xs: 1, ys: 4, angle: 0, n: 6)
        addsquare(xp: 32, yp: 25, xs: 3, ys: 1, angle: 0, n: 7)
        addgreensquare(xp: 30, yp: 22, xs: 1, ys: 5, angle: 0, friction: 0, n: 8)
        addgreensquare(xp: 31, yp: 26, xs: 4, ys: 1, angle: 0, friction: 0, n: 9)
        adddina(n: 6)
        adddina(n: 7)
        adddina(n: 8)
        adddina(n: 9)
        addjointObject2(objectAn: 6, objectBn: 7)
        addjointObject2(objectAn: 6, objectBn: 8)
        addjointObject2(objectAn: 6, objectBn: 9)
        addrinvalid(n: 6)
        
        addredsquare(xp: 22, yp: 22, xs: 1, ys: 11, angle: 0, n: 0)
        addredsquare(xp: 23, yp: 32, xs: 9, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 11, yp: 34, xs: 1, ys: 6, angle: 0, n: 0)
        addredsquare(xp: 12, yp: 39, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 32, yp: 39, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 6, yp: 39, xs: 5, ys: 1, angle: 0, n: 0)
        
        
        addredsquare2(xp: 37, yp: 26, xs: 3, ys: 13, angle: 0, n: 0)
        addredsquare2(xp: 30, yp: 37, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 22, yp: 37, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 26, yp: 34, xs: 1, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 12, yp: 34, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 18, yp: 27, xs: 4, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 5, yp: 22, xs: 1, ys: 12, angle: 0, n: 0)
        
        addsquare(xp: 18, yp: 29, xs: 1, ys: 4, angle: 0, n: 11)
        addsquare(xp: 19, yp: 29, xs: 3, ys: 1, angle: 0, n: 12)
        addgreensquare(xp: 17, yp: 28, xs: 1, ys: 5, angle: 0, friction: 0, n: 13)
        addgreensquare(xp: 18, yp: 28, xs: 4, ys: 1, angle: 0, friction: 0, n: 14)
        addsquare(xp: 21, yp: 30, xs: 1, ys: 1, angle: 0, n: 15)
        addrinvalid(n: 11)
        adddina(n: 11)
        adddina(n: 12)
        adddina(n: 13)
        adddina(n: 14)
        adddina(n: 15)
        addjointObject2(objectAn: 11, objectBn: 12)
        addjointObject2(objectAn: 11, objectBn: 13)
        addjointObject2(objectAn: 11, objectBn: 14)
        addjointObject2(objectAn: 11, objectBn: 15)
        
        addredsquare(xp: 0, yp: 51, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 51, xs: 15, ys: 1, angle: 0, n: 0)

        
        addredsquare2(xp: 6, yp: 40, xs: 20, ys: 3, angle: 0, n: 0)
        addredsquare2(xp: 26, yp: 40, xs: 14, ys: 3, angle: 0, n: 0)
        
  //      addredsquare(xp: 10, yp: 49, xs: 2, ys: 2, angle: 0, n: 0)
   //     addredsquare(xp: 26, yp: 49, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 16, yp: 40, xs: 2, ys: 2, angle: 0, n: 16)
        addmAction4(xmove: 0, ymove: 4, ininterval: 0, intime: 0, moveinterval: 4, mtime: 2, outinterval: 0, outtime: 0, n: 16)
        addredsquare(xp: 38, yp: 40, xs: 2, ys: 2, angle: 0, n: 17)
        addmAction4(xmove: 0, ymove: 4, ininterval: 0, intime: 0, moveinterval: 4, mtime: 2, outinterval: 0, outtime: 0, n: 17)
        
        addredsquare(xp: 6, yp: 43, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 23, yp: 43, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 20, yp: 43, xs: 2, ys: 3, angle: 0, n: 0)
        
        
        addsquare2(xp: 35, yp: 51, xs: 1, ys: 1, angle: 180, n: 0)
        addsquare2(xp: 30, yp: 52, xs: 1, ys: 1, angle: 0, n: 0)
        

        addsquare2(xp: bx + 1, yp: by, xs: 1, ys: 1, angle: -90, n: 22)
        addsquare(xp: bx + 6, yp: by, xs: 1, ys: 5, angle: 0, n: 23)
        addgreensquare(xp: bx, yp: by, xs: 1, ys: 6, angle: 0, friction: 0, n: 24)
        addgreensquare(xp: bx + 7, yp: by, xs: 1, ys: 6, angle: 0, friction: 0, n: 25)
        addgreensquare(xp: bx + 1, yp: by + 5, xs: 6, ys: 1, angle: 0, friction: 0, n: 26)
        addsquare(xp: bx + 2, yp: by, xs: 1, ys: 1, angle: 0, n: 27)
        addsquare(xp: bx + 5, yp: by, xs: 1, ys: 1, angle: 0, n: 28)
        adddina(n: 22)
        adddina(n: 23)
        adddina(n: 24)
        adddina(n: 25)
        adddina(n: 26)
        adddina(n: 27)
        adddina(n: 28)
        addrinvalid(n: 22)
        addjointObject2(objectAn: 22, objectBn: 23)
        addjointObject2(objectAn: 22, objectBn: 24)
        addjointObject2(objectAn: 22, objectBn: 25)
        addjointObject2(objectAn: 22, objectBn: 26)
        addjointObject2(objectAn: 22, objectBn: 27)
        addjointObject2(objectAn: 22, objectBn: 28)
        changephysicalproperties(linearDamping: nil, angularDamping: nil, mass: 0.1, n: 23)
        changephysicalproperties(linearDamping: nil, angularDamping: nil, mass: 0.1, n: 24)
        changephysicalproperties(linearDamping: nil, angularDamping: nil, mass: 0.1, n: 25)
        changephysicalproperties(linearDamping: nil, angularDamping: nil, mass: 0.1, n: 26)
        changephysicalproperties(linearDamping: nil, angularDamping: nil, mass: 0.1, n: 27)
        changephysicalproperties(linearDamping: nil, angularDamping: nil, mass: 0.1, n: 28)

        addredsquare(xp: 25, yp: 52, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 25, yp: 72, xs: 1, ys: 11, angle: 0, n: 0)
        
        addredsquare(xp: 14, yp: 61, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 14, yp: 81, xs: 1, ys: 9, angle: 0, n: 0)
        
        addredsquare2(xp: 26, yp: 70, xs: 7, ys: 2, angle: 0, n: 29)
        addredsquare2(xp: 33, yp: 77, xs: 7, ys: 2, angle: 0, n: 30)
        addredsquare2(xp: 26, yp: 84, xs: 7, ys: 2, angle: 0, n: 31)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 29)
        addrAction(dsita: -90, interval: 0, re: false, time: 5, n: 30)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 31)
        
        addredsquare(xp: 15, yp: 52, xs: 1, ys: 1, angle: 0, n: 35)
        addredsquare(xp: 24, yp: 82, xs: 1, ys: 1, angle: 0, n: 36)
        addmAction(xmove: 0, ymove: 31, interval: 0, time: 10, n: 35)
        addmAction(xmove: 0, ymove: -31, interval: 0, time: 10, n: 36)

        addredsquare2(xp: 15, yp: 81, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 20, yp: 76, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 15, yp: 71, xs: 2, ys: 2, angle: 0, n: 32)
        addredsquare2(xp: 15, yp: 61, xs: 2, ys: 2, angle: 0, n: 34)
        addmAction(xmove: 8, ymove: 0, interval: 1, time: 5, n: 32)

        addmAction(xmove: 8, ymove: 0, interval: 1, time: 5, n: 34)
        
        addredsquare2(xp: 14, yp: 52, xs: 1, ys: 4, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 64, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 11, yp: 73, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 0, yp: 82, xs: 3, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 4, yp: 68, xs: 3, ys: 2, angle: 0, n: 35)
        addredsquare2(xp: 12, yp: 72, xs: 2, ys: 3, angle: 0, n: 36)
        addredsquare2(xp: 4, yp: 77, xs: 3, ys: 2, angle: 0, n: 37)
        addrAction4(originx: 5, originy: 64, dsita: 360, interval: 0, re: false, time: 10, n: 35)
        addrAction4(originx: 8, originy: 73, dsita: -360, interval: 0, re: false, time: 10, n: 36)
        addrAction4(originx: 5, originy: 82, dsita: 360, interval: 0, re: false, time: 10, n: 37)
 
        
        addsquare(xp: 0, yp: 52, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 1, yp: 52, xs: 4, ys: 1, angle: 0, n: 0)
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
