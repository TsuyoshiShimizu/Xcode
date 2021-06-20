//
//  Stage11.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage11: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag11")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 3
            bally = 29
            addmiddleflag1(xp: 32, yp: 1)
            addmiddleflag2(xp: 57, yp: 33)
        }else if middleflagrevel == 1{
            addmiddleflag2(xp: 57, yp: 33)
            ballx = 32
            bally = 1
        }
        else if middleflagrevel == 2{
            ballx = 57
            bally = 33
            sita  = 180
        }
        let stagen: Int = 11
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
        addgoal(xp: 45, yp: 1,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 15, yp: 1,n:0)
        }

        //オブジェクト作成
        addsquare(xp: 0, yp: 28, xs: 1, ys: 3, angle: 0, n: 0)
        addsquare(xp: 1, yp: 28, xs: 5, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 30, yp: 6, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 30, yp: 16, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 30, yp: 26, xs: 1, ys: 9, angle: 0, n: 0)
        
        addbluesquare3(xp: 1, yp: 30, angle: 180, small: false, n: 1)
        addrinvalid(n: 1)
        addmAction5(xmove: 0, ymove: -2, time: 2, n: 1)
        
        addredsquare2(xp: 6, yp: 28, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 16, yp: 28, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 5, yp: 23, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 15, yp: 23, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 25, yp: 23, xs: 5, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 13, yp: 21, xs: 5, ys: 2, angle: 0, n: 2)
        addmAction(xmove: -13, ymove: 0, interval: 1, time: 5, n: 2)
        
        addredsquare2(xp: 0, yp: 16, xs: 5, ys: 2, angle: 0, n: 3)
        addmAction(xmove: 13, ymove: 0, interval: 1, time: 5, n: 3)
        
        addredsquare2(xp: 11, yp: 10, xs: 2, ys: 5, angle: 0, n: 4)
        addmAction(xmove: 0, ymove: -10, interval: 1, time: 5, n: 4)
        
        addredsquare2(xp: 17, yp: 0, xs: 2, ys: 5, angle: 0, n: 5)
        addmAction(xmove: 0, ymove: 10, interval: 1, time: 5, n: 5)
        
        addredsquare2(xp: 22, yp: 13, xs: 1, ys: 10, angle: 0, n: 6)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 6)
        
        addredsquare2(xp: 5, yp: 0, xs: 1, ys: 10, angle: 0, n: 7)
        addrAction(dsita: -90, interval: 0, re: false, time: 5, n: 7)
        
        
        addredsquare(xp: 41, yp: 0, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 41, yp: 10, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 41, yp: 20, xs: 1, ys: 6, angle: 0, n: 0)
        addredsquare(xp: 42, yp: 25, xs: 9, ys: 1, angle: 0, n: 0)
        
        addsquare2(xp: 30, yp: 0, xs: 1, ys: 1, angle: 90, n: 0)
        addsquare(xp: 24, yp: 0, xs: 2, ys: 3, angle: 0, n: 0)
        addsquare(xp: 34, yp: 6, xs: 2, ys: 1, angle: 0, n: 0)
        addsquare(xp: 34, yp: 5, xs: 1, ys: 1, angle: 0, n: 0)
        
        addbluesquare3(xp: 35, yp: 0, angle: 0, small: false, n: 8)
        addrinvalid(n: 8)
        addmAction5(xmove: 0, ymove: 1.5, time: 1, n: 8)
        addrepositionAction(distance: w, n: 8)
        
        addredsquare2(xp: 36, yp: 12, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 31, yp: 16, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 31, yp: 21, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 38, yp: 21, xs: 3, ys: 1, angle: 0, n: 0)
        
        
        addsquare(xp: 31, yp: 28, xs: 6, ys: 1, angle: 0, n: 0)
        addsquare(xp: 36, yp: 34, xs: 1, ys: 1, angle: 0, n: 0)
        
        addbluesquare3(xp: 31, yp: 30, angle: -90, small: false, n: 9)
        addrinvalid(n: 9)
        addmAction5(xmove: 2, ymove: 0, time: 1, n: 9)
        addrepositionAction(distance: w, n: 9)
        
        addredsquare2(xp: 39, yp: 34, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 39, yp: 29, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 42, yp: 35, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 42, yp: 30, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 45, yp: 34, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 45, yp: 29, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 48, yp: 33, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 48, yp: 28, xs: 1, ys: 1, angle: 0, n: 0)
        
        
        addsquare(xp: 53, yp: 30, xs: 1, ys: 6, angle: 0, n: 0)
        addsquare(xp: 59, yp: 29, xs: 1, ys: 1, angle: 0, n: 0)
        
        addbluesquare3(xp: 55, yp: 30, angle: 180, small: false, n: 10)
        addrinvalid(n: 10)
        addmAction5(xmove: 0, ymove: -1.5, time: 1, n: 10)
        addrepositionAction(distance: w, n: 10)

        addsquare2(xp: 42, yp: 0, xs: 1, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 51, yp: 25, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 42, yp: 21, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 21, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 57, yp: 21, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 42, yp: 17, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 17, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 42, yp: 12, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 12, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 49, yp: 5, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 57, yp: 5, xs: 3, ys: 1, angle: 0, n: 0)
        
        
        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

