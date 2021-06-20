//
//  Stage12.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage12: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag12")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 2
            bally = 6
            addmiddleflag1(xp: 57, yp: 2)
            addmiddleflag2(xp: 2, yp: 11)
        }else if middleflagrevel == 1{
            ballx = 57
            bally = 2
            addmiddleflag2(xp: 2, yp: 11)
        }else if middleflagrevel == 2{
            ballx = 2
            bally = 11
        }
        let stagen: Int = 12
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
        addgoal(xp: 58, yp: 24,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 58, yp: 20,n:0)
        }
        
        
        //オブジェクト作成
        addsquare2(xp: 0, yp: 5, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 0, yp: 0, xs: 4, ys: 5, angle: 0, n: 0)
        
        addredsquare(xp: 1, yp: 9, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 11, yp: 9, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 21, yp: 9, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 31, yp: 9, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 41, yp: 9, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 51, yp: 9, xs: 4, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 23, yp: 6, xs: 2, ys: 3, angle: 0, n: 0)
        addredsquare(xp: 38, yp: 6, xs: 2, ys: 3, angle: 0, n: 0)
        
        addredsquare2(xp: 4, yp: 0, xs: 10, ys:3, angle: 0, n: 0)
        addredsquare2(xp: 14, yp: 0, xs: 10, ys:3, angle: 0, n: 0)
        addredsquare2(xp: 24, yp: 0, xs: 10, ys:3, angle: 0, n: 0)
        addredsquare2(xp: 34, yp: 0, xs: 10, ys:3, angle: 0, n: 0)
        addredsquare2(xp: 44, yp: 0, xs: 10, ys:3, angle: 0, n: 0)
        addredsquare2(xp: 54, yp: 0, xs: 1, ys:3, angle: 0, n: 0)
        
        
        addsquare(xp: 55, yp: 0, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 56, yp: 0, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 59, yp: 0, xs: 1, ys: 6, angle: 0, n: 0)
        addsquare2(xp: 55, yp: 10, xs: 1, ys: 1, angle: 180, n: 0)
        
        addbluesquare(xp: 5, yp: 3, xs: 5, ys: 2, angle: 0, n: 0)
        addbluesquare(xp: 11, yp: 3, xs: 2, ys: 3, angle: 0, n: 0)
        addbluesquare(xp: 14, yp: 3, xs: 4, ys: 2, angle: 0, n: 0)
        addbluesquare(xp: 19, yp: 3, xs: 11, ys: 2, angle: 0, n: 0)
        addbluesquare(xp: 31, yp: 3, xs: 2, ys: 3, angle: 0, n: 0)
        addbluesquare(xp: 34, yp: 3, xs: 7, ys: 2, angle: 0, n: 0)
        addbluesquare(xp: 42, yp: 3, xs: 2, ys: 3, angle: 0, n: 0)
        addbluesquare(xp: 45, yp: 3, xs: 10, ys: 2, angle: 0, n: 0)
        
        addsquare(xp: 57, yp: 21, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 59, yp: 19, xs: 1, ys: 2, angle: 0, n: 0)
        
        addsquare(xp: 0, yp: 10, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 0, yp: 11, xs: 1, ys: 10, angle: 0, n: 0)
        addsquare(xp: 0, yp: 21, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 1, yp: 25, xs: 4, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 4, yp: 15, xs: 1, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 5, yp: 18, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 18, xs: 9, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 24, yp: 15, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 25, yp: 22, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 22, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 45, yp: 22, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 55, yp: 22, xs: 5, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 14, yp: 10, xs: 1, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 40, yp: 10, xs: 1, ys: 7, angle: 0, n: 0)
        
        addbluesquare5(xp: 44, yp: 11, angle: 0, small: false, n: 1)
        addrinvalid(n: 1)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 1)
        
        addbluesquare5(xp: 29, yp: 11, angle: 0, small: false, n: 2)
        addrinvalid(n: 2)
        addrAction(dsita: -90, interval: 0, re: false, time: 5, n: 2)
        
        addbluesquare2(xp: 17, yp: 11, angle: 0, small: false, n: 3)
        addrinvalid(n: 3)
        addrAction(dsita: 90, interval: 0, re: false, time: 4, n: 3)
        
        addbluesquare2(xp: 7, yp: 11, angle: 0, small: false, n: 4)
        addrinvalid(n: 4)
        addrAction(dsita: -90, interval: 0, re: false, time: 4, n: 4)
        
        addbluesquare3(xp: 5, yp: 20, angle: 0, small: false, n: 5)
        addrinvalid(n: 5)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 5)
        
        addbluesquare3(xp: 13, yp: 30, angle: 180, small: false, n: 9)
        addrinvalid(n: 9)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 9)
        
        addbluesquare3(xp: 26, yp: 30, angle: 0, small: false, n: 6)
        addrinvalid(n: 6)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 6)
        
        addbluesquare3(xp: 37, yp: 24, angle: 0, small: false, n: 7)
        addrinvalid(n: 7)
        addrAction(dsita: -90, interval: 0, re: false, time: 5, n: 7)
        
        addredsquare(xp: 24, yp: 23, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 27, xs: 1, ys: 9, angle: 0, n: 0)
        
        addredsquare2(xp: 5, yp: 30, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 12, yp: 19, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 12, yp: 29, xs: 1, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 18, yp: 24, xs: 1, ys: 11, angle: 0, n: 0)
        addredsquare2(xp: 30, yp: 29, xs: 5, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 43, yp: 23, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare2(xp: 49, yp: 28, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare2(xp: 55, yp: 23, xs: 1, ys: 7, angle: 0, n: 0)
        
        addsquare(xp: 56, yp: 23, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 59, yp: 24, xs: 1, ys: 3, angle: 0, n: 0)
        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

