//
//  Stage15.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage15: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag15")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 2
            bally = 14
            addmiddleflag1(xp: 12, yp: 30)
            addmiddleflag2(xp: 30, yp: 35)
        }else if middleflagrevel == 1{
            addmiddleflag2(xp: 30, yp: 35)
            ballx = 12
            bally = 30
        }else if middleflagrevel == 2{
            ballx = 30
            bally = 35
        }
        let stagen: Int = 15
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
        addgoal(xp: 13, yp: 49,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 4, yp: 18,n:0)
        }
        
        //オブジェクト作成
        addsquare(xp: 0, yp: 12, xs: 1, ys: 6, angle: 0, n: 0)
        addsquare(xp: 1, yp: 12, xs: 6, ys: 1, angle: 0, n: 0)
        addsquare(xp: 1, yp: 17, xs: 9, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 7, yp: 11, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 9, yp: 4, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 18, yp: 4, xs: 1, ys: 6, angle: 0, n: 0)
        addredsquare(xp: 19, yp: 9, xs: 10, ys: 1, angle: 0, n: 0)
        
        addsquare5(xp: 10, yp: 0, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare5(xp: 14, yp: 0, xs: 1, ys: 1, angle: 90, n: 0)
        
        addredsquare(xp: 17, yp: 18, xs: 7, ys: 1, angle: 0, n: 0)
        addsquare(xp: 24, yp: 18, xs: 4, ys: 1, angle: 0, n: 0)
        
        addsquare5(xp: 24, yp: 10, xs: 1, ys: 1, angle: 90, n: 0)
        addsquare5(xp: 24, yp: 14, xs: 1, ys: 1, angle: 180, n: 0)
        
        addredsquare(xp: 10, yp: 17, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare5(xp: 10, yp: 22, xs: 1, ys: 1, angle: -90, n: 0)
        
        addsquare(xp: 14, yp: 25, xs: 4, ys: 1, angle: 0, n: 0)
        
        addsquare5(xp: 17, yp: 19, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare5(xp: 18, yp: 22, xs: 1, ys: 1, angle: 180, n: 0)
        
        addsquare(xp: 21, yp: 19, xs: 3, ys: 1, angle: 0, n: 0)
        
        addsquare5(xp: 24, yp: 19, xs: 1, ys: 1, angle: 90, n: 0)
        addsquare5(xp: 24, yp: 25, xs: 1, ys: 1, angle: 180, n: 0)
        
        addsquare(xp: 27, yp: 23, xs: 1, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 18, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 28, yp: 22, xs: 1, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 26, xs: 1, ys: 4, angle: 0, n: 0)
        
        addredsquare(xp: 16, yp: 21, xs: 1, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 22, yp: 22, xs: 2, ys: 4, angle: 0, n: 0)
        
        addsquare(xp: 10, yp: 28, xs: 4, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 14, yp: 28, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 18, yp: 28, xs: 6, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 10, yp: 15, xs: 5, ys: 1, angle: -45, n: 0)
        addredsquare(xp: 9, yp: 18, xs: 1, ys: 6, angle: 0, n: 0)
        addredsquare(xp: 6, yp: 29, xs: 4, ys: 1, angle: 0, n: 0)
        
        addgreensquare(xp: 9, yp: 13, xs: 10, ys: 2, angle: 45, friction: 0, n: 1)
        addrAction(dsita: -90, interval: 3, re: true, time: 2, n: 1)
        
        addgreensquare(xp: 0, yp: 28, xs: 10, ys: 2, angle: 0, friction: 1, n: 2)
        addrAction(dsita: -90, interval: 0, re: false, time: 7, n: 2)
        
        addsquare(xp: 10, yp: 29, xs: 11, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 21, yp: 29, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 24, yp: 29, xs: 4, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 35, xs: 15, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 35, xs: 14, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 33, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 29, yp: 34, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare5(xp: 29, yp: 30, xs: 1, ys: 1, angle: 180, n: 0)
        
        addredsquare(xp: 32, yp: 9, xs: 1, ys: 9, angle: 0, n: 0)
        addsquare(xp: 32, yp: 18, xs: 1, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 32, yp: 22, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 32, yp: 26, xs: 1, ys: 4, angle: 0, n: 0)
        
        addsquare(xp: 28, yp: 10, xs: 1, ys: 8, angle: 0, n: 0)
        addcircle3(xp: 28, yp: 8, xs: 1, ys: 1, mirror: false, angle: 180, n: 0)
        addsquare5(xp: 29, yp: 5, xs: 1, ys: 1, angle: 90, n: 0)
        addsquare(xp: 23, yp: 8, xs: 5, ys: 1, angle: 0, n: 0)
        addsquare(xp: 19, yp: 4, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 23, yp: 0, xs: 10, ys: 1, angle: 0, n: 0)
        addsquare5(xp: 19, yp: 5, xs: 1, ys: 1, angle: -90, n: 0)
        addsquare5(xp: 19, yp: 0, xs: 1, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 23, yp: 5, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 23, yp: 3, xs: 10, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 22, yp: 4, xs: 1, ys: 1, angle: 0, n: 0)
        addredcircle3(xp: 22, yp: 5, xs: 1, ys: 1,mirror: false, angle: 0, n: 0)
        addredcircle3(xp: 22, yp: 3, xs: 1, ys: 1,mirror: false, angle: 90, n: 0)
        
        addgreensquare(xp: 33, yp: 0, xs: 6, ys: 1, angle: 0, friction: 1, n: 0)
        addsquare(xp: 39, yp: 0, xs: 1, ys: 12, angle: 0, n: 0)
        addgreensquare(xp: 33, yp: 18, xs: 3, ys: 1, angle: 0, friction: 1, n: 0)
        addgreensquare(xp: 36, yp: 31, xs: 3, ys: 1, angle: 0, friction: 1, n: 0)
        
        addsquare(xp: 39, yp: 31, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 33, yp: 39, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare5(xp: 36, yp: 36, xs: 1, ys: 1, angle: 180, n: 0)
        
        addgreensquare(xp: 26, yp: 39, xs: 7, ys: 1, angle: 0, friction: 1, n: 3)
        addrAction(dsita: -90, interval: 0, re: false, time: 7, n: 3)
        addgreensquare(xp: 35, yp: 41, xs: 1, ys: 9, angle: 0, friction: 1, n: 4)
        addrAction(dsita: 90, interval: 0, re: false, time: 7, n: 4)
        addgreensquare(xp: 28, yp: 47, xs: 1, ys: 11, angle: 0, friction: 1, n: 5)
        addrAction(dsita: 90, interval: 0, re: false, time: 7, n: 5)
        addgreensquare(xp: 28, yp: 58, xs: 1, ys: 13, angle: 0, friction: 1, n: 6)
        addrAction(dsita: 90, interval: 0, re: false, time: 7, n: 6)
        addgreensquare(xp: 14, yp: 57, xs: 1, ys: 15, angle: 0, friction: 1, n: 7)
        addrAction(dsita: -90, interval: 0, re: false, time: 7, n: 7)
        addgreensquare(xp: -1, yp: 55, xs: 15, ys: 1, angle: 0, friction: 1, n: 8)
        addrAction(dsita: 90, interval: 0, re: false, time: 7, n: 8)
        
        addsquare(xp: 9, yp: 48, xs: 7, ys: 1, angle: 0, n: 0)
        addsquare(xp: 15, yp: 49, xs: 1, ys: 4, angle: 0, n: 0)
        
        addredsquare(xp: 24, yp: 36, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 21, yp: 44, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 21, yp: 45, xs: 1, ys: 17, angle: 0, n: 0)
        addredsquare(xp: 7, yp: 55, xs: 14, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 22, yp: 57, xs: 3, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 21, yp: 68, xs: 1, ys: 3, angle: 0, n: 0)
        addredsquare(xp: 32, yp: 57, xs: 3, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 52, xs: 1, ys: 19, angle: 0, n: 0)
        addredsquare(xp: 36, yp: 52, xs: 4, ys: 1, angle: 0, n: 0)
   
        
        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

