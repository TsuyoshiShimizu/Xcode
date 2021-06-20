//
//  Stage04.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/05.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage04: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag4")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 1
            bally = 3
            addmiddleflag1(xp: 11, yp: 21)
        }else if middleflagrevel == 1{
            ballx = 11
            bally = 21
            sita = 90
        }
        let stagen: Int = 4
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

        
        addball(xbp: ballx, ybp: bally, balln: 0)
        
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 1, yp: 34,n:0)
        }
        
        addgoal(xp: 38, yp: 16,n:0)
        
        //オブジェクト作成
        addsquare(xp: 0, yp: 1, xs: 3, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 0)
        
        addsquare(xp: 3, yp: 1, xs: 4, ys: 1, angle: 0.0, n: 1)
        addsquare(xp: 6, yp: 2, xs: 1, ys: 3, angle: 0.0, n: 2)
        
        addsquare(xp: 9, yp: 9, xs: 1, ys: 7, angle: 0.0, n: 3)
        addsquare(xp: 10, yp: 11, xs: 3, ys: 1, angle: 0.0, n: 4)
        
        addsquare(xp: 5, yp: 6, xs: 8, ys: 1, angle: 0.0, n: 5)
        addsquare(xp: 5, yp: 7, xs: 1, ys: 3, angle: 0.0, n: 6)
        
        addsquare(xp: 0, yp: 20, xs: 1, ys: 4, angle: 0.0, n: 7)
        addsquare(xp: 1, yp: 23, xs: 3, ys: 1, angle: 0.0, n: 8)
        
        addsquare(xp: 0, yp: 24, xs: 9, ys: 1, angle: 0.0, n: 9)
        addsquare(xp: 4, yp: 23, xs: 1, ys: 3, angle: 0.0, n: 10)
        
        addsquare(xp: 10, yp: 29, xs: 5, ys: 1, angle: 0.0, n: 11)
        addsquare(xp: 14, yp: 25, xs: 1, ys: 4, angle: 0.0, n: 12)
        
        addsquare(xp: 0, yp: 25, xs: 1, ys: 5, angle: 0.0, n: 13)
        addsquare(xp: 1, yp: 29, xs: 4, ys: 1, angle: 0.0, n: 14)
        
        addsquare(xp: 10, yp: 16, xs: 1, ys: 9, angle: 0.0, n: 0)
        addsquare(xp: 14, yp: 18, xs: 1, ys: 7, angle: 0.0, n: 0)
        
        addsquare(xp: 13, yp: 5, xs: 6, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 13, yp: 18, xs: 1, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 15, yp: 24, xs: 5, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 19, yp: 25, xs: 1, ys: 5, angle: 0.0, n: 0)
        
        addcircle(xp: 22, yp: 26, xs: 7, ys: 7, n: 0)
        addsquare(xp: 20, yp: 29, xs: 4, ys: 1, angle: 0.0, n: 16)
        addsquare(xp: 25, yp: 31, xs: 1, ys: 4, angle: 0.0, n: 17)
        
        addcircle(xp: 33, yp: 18, xs: 7, ys: 7, n: 18)
        
        addcircle(xp: 18, yp: 1, xs: 6, ys: 6, n: 0)
        addcircle(xp: 26, yp: 2, xs: 6, ys: 6, n: 0)
        addcircle(xp: 17, yp: 9, xs: 6, ys: 6, n: 0)
        addcircle(xp: 24, yp: 14, xs: 6, ys: 6, n: 0)
        addcircle(xp: 32, yp: 9, xs: 6, ys: 6, n: 0)
        
        addsquare(xp: 37, yp: 14, xs: 3, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 37, yp: 18, xs: 3, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 39, yp: 15, xs: 1, ys: 3, angle: 0.0, n: 0)
        
        
        //レッドオブジェクト作成
        addredsquare(xp: 0, yp: 0, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 10, yp: 0, xs: 3, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 0, yp: 5, xs: 9, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 13, yp: 0, xs: 1, ys: 5, angle: 0.0, n: 0)
        addredsquare(xp: 13, yp: 6, xs: 1, ys: 5, angle: 0.0, n: 15)
        
        addredsquare(xp: 4, yp: 10, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 5, yp: 10, xs: 4, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 5, yp: 19, xs: 4, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 9, yp: 16, xs: 1, ys: 9, angle: 0.0, n: 0)
        
        addredsquare(xp: 5, yp: 30, xs: 1, ys: 6, angle: 0.0, n: 0)
        addredsquare(xp: 6, yp: 30, xs: 8, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 14, yp: 30, xs: 1, ys: 6, angle: 0.0, n: 0)
        
        addredsquare(xp: 13, yp: 11, xs: 1, ys: 7, angle: 0.0, n: 0)
        
        addredsquare(xp: 15, yp: 21, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 25, yp: 21, xs: 5, ys: 1, angle: 0.0, n: 0)
    
        
        //オブジェクト動作追加
        addmAction(xmove: 6.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 1)
        addmAction(xmove: 6.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 2)
        
        addmAction(xmove: 0.0, ymove: -6.0, interval: 2.0, time: 4.0, n: 3)
        addmAction(xmove: 0.0, ymove: -6.0, interval: 2.0, time: 4.0, n: 4)
        
        addmAction(xmove: -5.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 5)
        addmAction(xmove: -5.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 6)
        
        addmAction(xmove: 0.0, ymove: -10.0, interval: 2.0, time: 4.0, n: 7)
        addmAction(xmove: 0.0, ymove: -10.0, interval: 2.0, time: 4.0, n: 8)
        
        addrAction(dsita: 90.0, interval: 2.0, re: false, time: 4.0, n: 9)
        addrAction(dsita: 90.0, interval: 2.0, re: false, time: 4.0, n: 10)
        
        addmAction(xmove: -5.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 11)
        addmAction(xmove: -5.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 12)
        
        addmAction(xmove: 0.0, ymove: 6.0, interval: 2.0, time: 4.0, n: 13)
        addmAction(xmove: 0.0, ymove: 6.0, interval: 2.0, time: 4.0, n: 14)
        
        addmAction(xmove: 0.0, ymove: -6.0, interval: 2.0, time: 4.0, n: 15)
        
        addmAction(xmove: 7.0, ymove: 0.0, interval: 2.0, time: 4.0, n: 16)
        addmAction2(xmove: 0.0, ymove: -7.0, interval: 2.0, time: 4.0, n: 17)
        
        addmAction(xmove: 0.0, ymove: 8.0, interval: 2.0, time: 4.0, n: 18)
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
