//
//  Stage09.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/16.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

import UIKit
import SpriteKit
import GameplayKit

class stage09: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag9")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 1
            bally = 32
            addmiddleflag1(xp: 2, yp: 7)
            addmiddleflag2(xp: 41, yp: 2)
        }else if middleflagrevel == 1{
            ballx = 2
            bally = 7
            addmiddleflag2(xp: 41, yp: 2)
        }else if middleflagrevel == 2{
            ballx = 41
            bally = 2
        }
        let stagen: Int = 9
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
        addgoal(xp: 57, yp: 27,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 32, yp: 7,n:0)
        }
        
        
        //オブジェクト作成
        addsquare2(xp: 0, yp: 30, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 5, yp: 30, xs: 10, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 24, yp: 30, xs: 6, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 15, yp: 28, xs: 1, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 16, yp: 28, xs: 7, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 23, yp: 28, xs: 1, ys: 2, angle: 0, n: 0)
        
        addbluesquare2(xp: 11, yp: 31, angle: 90, small: true, n: 0)
        addbluesquare2(xp: 30, yp: 30, angle: 90, small: false, n: 0)
        
        addredsquare(xp: 29, yp: 24, xs: 1, ys: 6, angle: 0, n: 0)
        
        addredsquare(xp: 35, yp: 5, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 15, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 25, xs: 1, ys: 10, angle: 0, n: 0)
        
        addredsquare2(xp: 29, yp: 18, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 6, yp: 5, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 16, yp: 5, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 26, yp: 5, xs: 9, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 5, yp: 5, xs: 1, ys: 5, angle: 0, n: 0)

        addredsquare(xp: 16, yp: 14, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 16, yp: 24, xs: 1, ys: 4, angle: 0, n: 0)
        addredsquare2(xp: 5, yp: 10, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 5, yp: 20, xs: 1, ys: 4, angle: 0, n: 0)
        
        addbluesquare(xp: 18, yp: 18, xs: 10, ys: 2, angle: -15, n: 0)
        addbluesquare(xp: 6, yp: 12, xs: 10, ys: 2, angle: 15, n: 0)
        
        addredsquare2(xp: 9, yp: 6, xs: 2, ys: 2, angle: 0, n: 1)
        addredsquare2(xp: 14, yp: 6, xs: 2, ys: 2, angle: 0, n: 2)
        addredsquare2(xp: 18, yp: 6, xs: 2, ys: 2, angle: 0, n: 3)
        
        addmAction(xmove: 0, ymove: -7, interval: 2, time: 5, n: 1)
        addmAction(xmove: 0, ymove: -7, interval: 2, time: 5, n: 2)
        addmAction(xmove: 0, ymove: -7, interval: 2, time: 5, n: 3)
        
        addsquare(xp: 30, yp: 6, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 33, yp: 7, xs: 1, ys: 3, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 29, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 10, yp: 29, xs: 5, ys: 1, angle: 0, n: 0)
        
        addbluesquare3(xp: 0, yp: 21, angle: 0, small: true, n: 0)
        addbluesquare2(xp: 0, yp: 5, angle: 90, small: false, n: 10)
        addrinvalid(n: 10)
        
        addredsquare2(xp: 0, yp: 20, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 4, yp: 17, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 0, yp: 14, xs: 1, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 24, yp: 3, xs: 5, ys: 1, angle: 0, n: 4)
        
        addsquare(xp: 0, yp: 27, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 1, yp: 28, xs: 5, ys: 1, angle: 0, n: 0)
        
        addrAction(dsita: 90, interval: 2, re: false, time: 5, n: 4)
        
        addredsquare2(xp: 36, yp: 7, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 37, yp: 8, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare2(xp: 38, yp: 15, xs: 7, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 44, yp: 16, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 44, yp: 26, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 44, yp: 6, xs: 8, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 0, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 10, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 20, xs: 1, ys: 6, angle: 0, n: 0)
        addredsquare2(xp: 53, yp: 25, xs: 7, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 52, yp: 31, xs: 1, ys: 3, angle: 0, n: 0)
        addsquare(xp: 54, yp: 26, xs: 6, ys: 1, angle: 0, n: 0)
        addsquare(xp: 59, yp: 27, xs: 1, ys: 5, angle: 0, n: 0)
        
        
        addbluesquare2(xp: 39, yp: 9, angle: -90, small: false, n: 0)
        addbluesquare2(xp: 46, yp: 8, angle: 90, small: false, n: 0)
        addbluesquare2(xp: 46, yp: 16, angle: 180, small: false, n: 11)
        addrinvalid(n: 11)
        
        addsquare(xp: 39, yp: 0, xs: 5, ys: 1, angle: 0, n: 0)
        addsquare(xp: 43, yp: 1, xs: 1, ys: 6, angle: 0, n: 0)

        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

