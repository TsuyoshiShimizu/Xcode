
//
//  Stage13.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage13: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag13")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 2
            bally = 5
            addmiddleflag1(xp: 28, yp: 103)
            addmiddleflag2(xp: 18, yp: 58)
        }else if middleflagrevel == 1{
            ballx = 28
            bally = 103
            addmiddleflag2(xp: 18, yp: 58)
        }else if middleflagrevel == 2{
            ballx = 18
            bally = 58
            sita = -90
        }
        let stagen: Int = 13
        UserDefaults.standard.set(stagen, forKey: "playstage")
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -gra)
        
        let ws = frame.size.width
        let hs2 = frame.size.height
        let ys = hs2 / h2
        let hs = h * ys
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
        addgoal(xp: 28, yp: 1,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 28, yp: 83,n:0)
        }
        
        
        //オブジェクト作成
        addsquare2(xp: 0, yp: 3, xs: 1, ys: 1, angle: 0, n: 3)
        addsquare(xp: 0, yp: 0, xs: 5, ys: 3, angle: 0, n: 0)
        addmAction(xmove: 0, ymove: 11, interval: 2, time: 2, n: 3)
        
        addredsquare(xp: 15, yp: 0, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 8, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 28, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 48, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 68, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 88, xs: 1, ys: 15, angle: 0, n: 0)
        addsquare(xp: 4, yp: 58, xs: 11, ys: 1, angle: 0, n: 0)
        addsquare(xp: 4, yp: 55, xs: 1, ys: 3, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 48, xs: 5, ys: 1, angle: 0, n: 0)

        
        addsquare2(xp: 0, yp: 49, xs: 1, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 103, xs: 4, ys: 4, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 19, xs: 5, ys: 20, angle: 0, n: 1)
        addredsquare(xp: 0, yp: 29, xs: 5, ys: 20, angle: 0, n: 2)
        addmAction2(xmove: 10, ymove: 0, interval: 2, time: 2, n: 1)
        addmAction2(xmove: 10, ymove: 0, interval: 2, time: 2, n: 2)
        
        addgreensquare(xp: 5, yp: 0, xs: 10, ys: 1, angle: 0, friction: 1.0,n: 0)
        
        
        
        addsquare2(xp: 0, yp: 59, xs: 1, ys: 1, angle: -90, n: 0)
        addsquare2(xp: 0, yp: 64, xs: 1, ys: 1, angle: 0, n: 4)
        addmAction(xmove: 0, ymove: 10, interval: 2, time: 2, n: 4)
        
        addredsquare(xp: 0, yp: 79, xs: 4, ys: 24, angle: 0, n: 5)
        addredsquare(xp: 12, yp: 79, xs: 4, ys: 24, angle: 0, n: 6)
        addmAction2(xmove: 4, ymove: 0, interval: 2, time: 2, n: 5)
        addmAction2(xmove: -4, ymove: 0, interval: 2, time: 2, n: 6)
        
        addredsquare(xp: 12, yp: 102, xs: 4, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 4, yp: 103, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 5, yp: 106, xs: 25, ys: 1, angle: 0, n: 0)
        addsquare2(xp: 25, yp: 102, xs: 1, ys: 1, angle: 90, n: 0)
        
        addgreensquare(xp: 4, yp: 59, xs: 11, ys: 1, angle: 0, friction: 1.0,n: 0)
    
        
        addredsquare(xp: 16, yp: 95, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 17, yp: 102, xs: 3, ys: 1, angle: 0, n: 0)
        
        addsquare2(xp: 20, yp: 98, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 24, yp: 96, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 29, yp: 96, xs: 1, ys: 6, angle: 0, n: 0)
        
        addgreensquare(xp: 16, yp: 0, xs: 1, ys: 20, angle: 0, friction: 1.0,n: 0)
        addgreensquare(xp: 16, yp: 20, xs: 1, ys: 20, angle: 0, friction: 1.0,n: 0)
        addgreensquare(xp: 16, yp: 40, xs: 1, ys: 20, angle: 0, friction: 1.0,n: 0)
        addgreensquare(xp: 16, yp: 60, xs: 1, ys: 20, angle: 0, friction: 1.0,n: 0)
        addgreensquare(xp: 16, yp: 80, xs: 1, ys: 15, angle: 0, friction: 1.0,n: 0)
        
        addredsquare(xp: 17, yp: 88, xs: 4, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 21, yp: 76, xs: 9, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 17, yp: 61, xs: 8, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 17, yp: 49, xs: 8, ys: 2, angle: 0, n: 7)
        addmAction(xmove: 0, ymove: -10, interval: 0, time: 5, n: 7)
        
        addsquare(xp: 17, yp: 55, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 18, yp: 59, xs: 1, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 25, yp: 92, xs: 5, ys: 1, angle: 0, n: 0)
        addsquare(xp: 28, yp: 96, xs: 1, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 27, yp: 81, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 27, yp: 85, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 29, yp: 82, xs: 1, ys: 3, angle: 0, n: 0)
        
        addgreensquare(xp: 29, yp: 5, xs: 1, ys: 20, angle: 0, friction: 1.0,n: 0)
        addgreensquare(xp: 29, yp: 25, xs: 1, ys: 14, angle: 0, friction: 1.0,n: 0)
        
        addredsquare(xp: 17, yp: 29, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 22, yp: 17, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 17, yp: 4, xs: 7, ys: 3, angle: 0, n: 0)
        
        addsquare2(xp: 25, yp: 0, xs: 1, ys: 1, angle: 90, n: 0)
        
        addsquare(xp: 17, yp: 68, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 18, yp: 71, xs: 1, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 17, yp: 35, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 18, yp: 38, xs: 1, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 27, yp: 26, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 28, yp: 23, xs: 1, ys: 4, angle: 0, n: 0)
        
        addsquare(xp: 17, yp: 11, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 18, yp: 14, xs: 1, ys: 1, angle: 0, n: 0)
        
        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

