//
//  Stage03.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/05.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage03: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag3")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 1
            bally = 6
            addmiddleflag1(xp: 46, yp: 5)
        }else if middleflagrevel == 1{
            ballx = 46
            bally = 5
        }
        let stagen: Int = 3
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
        addgoal(xp: 78, yp: 11,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 18, yp: 2,n:0)
        }
  
        
        //オブジェクト作成
        addsquare(xp: 1, yp: 3, xs: 2, ys: 2, angle: 0.0, n: 0)
        addsquare(xp: 1, yp: 13, xs: 2, ys: 2, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 3, xs: 1, ys: 6, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 9, xs: 1, ys: 6, angle: 0.0, n: 0)
        
        addsquare(xp: 3, yp: 3, xs: 10, ys: 2, angle: 0.0, n: 1)
        addsquare(xp: 13, yp: 3, xs: 10, ys: 2, angle: 0.0, n: 2)
        addsquare(xp: 23, yp: 3, xs: 10, ys: 2, angle: 0.0, n: 3)
        addsquare(xp: 33, yp: 3, xs: 10, ys: 2, angle: 0.0, n: 4)
        
        addsquare(xp: 3, yp: 13, xs: 10, ys: 2, angle: 0.0, n: 5)
        addsquare(xp: 13, yp: 13, xs: 10, ys: 2, angle: 0.0, n: 6)
        addsquare(xp: 23, yp: 13, xs: 10, ys: 2, angle: 0.0, n: 7)
        addsquare(xp: 33, yp: 13, xs:10, ys: 2, angle: 0.0, n: 8)
        
        addsquare(xp: 43, yp: 4, xs: 6, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 48, yp: 5, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        addcircle(xp: 51, yp: 10, xs: 5, ys: 5, n: 0)
        addcircle(xp: 57, yp: 3, xs: 5, ys: 5, n: 0 )
        addcircle(xp: 63, yp: 10, xs: 5, ys: 5, n: 0)
        addcircle(xp: 69, yp: 3, xs: 5, ys: 5, n: 0)
        
        addsquare(xp: 53, yp: 8, xs: 1, ys: 9, angle: 0.0, n: 14)
        addsquare(xp: 59, yp: 1, xs: 1, ys: 9, angle: 90.0, n: 15)
        addsquare(xp: 65, yp: 8, xs: 1, ys: 9, angle: 0.0, n: 16)
        addsquare(xp: 71, yp: 1, xs: 1, ys: 9, angle: 90.0, n: 17)
        
        addsquare(xp: 74, yp: 12, xs: 6, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 79, yp: 11, xs: 1, ys: 1, angle: 0.0, n: 0)
        

        
        addsquare(xp: 9, yp: 5, xs: 1, ys: 1, angle: 0.0, n: 18)
        addsquare(xp: 17, yp: 12, xs: 1, ys: 1, angle: 0.0, n: 19)
        addsquare(xp: 23, yp: 5, xs: 1, ys: 1, angle: 0.0, n: 20)
        addsquare(xp: 30, yp: 12, xs: 1, ys: 1, angle: 0.0, n: 21)
        addsquare(xp: 38, yp: 5, xs: 1, ys: 1, angle: 0.0, n: 22)
        
        addsquare(xp: 16, yp: 2, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 20, yp: 2, xs: 1, ys: 1, angle: 0.0, n: 0)
        
        //レッドオブジェクト作成
        addredsquare(xp: 0, yp: 0, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 10, yp: 0, xs: 6, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 16, yp: 0, xs: 5, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 21, yp: 0, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 30, yp: 0, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 40, yp: 0, xs: 3, ys: 3, angle: 0.0, n: 0)
        
        addredsquare(xp: 16, yp: 1, xs: 5, ys: 2, angle: 0.0, n: 9)
        
        addredsquare(xp: 0, yp: 15, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 10, yp: 15, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 20, yp: 15, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 30, yp: 15, xs: 10, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 40, yp: 15, xs: 4, ys: 3, angle: 0.0, n: 0)
        
        
        addredsquare(xp: 10, yp: 3, xs: 2, ys: 7, angle: 0.0, n: 0)
        
        addredsquare(xp: 18, yp: 8, xs: 2, ys: 7, angle: 0.0, n: 0)
        
        addredsquare(xp: 24, yp: 0, xs: 3, ys: 8, angle: 0.0, n: 10)
        
        addredsquare(xp: 31, yp: 10, xs: 3, ys:8 , angle:0.0 , n: 11)
        
        addredsquare(xp: 39, yp: 2, xs: 4, ys: 2, angle: 0.0, n: 12)
        addredsquare(xp: 39, yp: 8, xs: 4, ys: 2, angle: 0.0, n: 13)
        
        addredsquare(xp: 52, yp: 0, xs: 3, ys: 6, angle: 0.0, n: 0)
        addredsquare(xp: 58, yp: 12, xs: 3, ys: 6, angle: 0.0, n: 0)
        addredsquare(xp: 64, yp: 0, xs: 3, ys: 6, angle: 0.0, n: 0)
        addredsquare(xp: 70, yp: 12, xs: 3, ys: 6, angle: 0.0, n: 0)
        addredsquare(xp: 76, yp: 4, xs: 4, ys: 3, angle: 0.0, n: 0)
        
        
        //オブジェクト動作追加
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 1)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 2)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 3)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 4)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 9)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 1)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 2)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 3)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 4)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 9)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 1)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 2)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 3)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 4)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 9)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 1)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 2)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 3)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 4)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 9)
        
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 18)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 18)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 18)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 18)
        
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 20)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 20)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 20)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 20)
        
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 2.0, interval2: 21.0, time: 3.0, n: 22)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 7.0, interval2: 16.0, time: 3.0, n: 22)
        addmAction3(xmove: 0.0, ymove: -3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 22)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 22)
        
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 10.0, interval2: 13.0, time: 3.0, n: 5)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 10.0, interval2: 13.0, time: 3.0, n: 6)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 10.0, interval2: 13.0, time: 3.0, n: 7)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 10.0, interval2: 13.0, time: 3.0, n: 8)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 15.0, interval2: 8.0, time: 3.0, n: 5)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 15.0, interval2: 8.0, time: 3.0, n: 6)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 15.0, interval2: 8.0, time: 3.0, n: 7)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 15.0, interval2: 8.0, time: 3.0, n: 8)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 5)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 6)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 7)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 8)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 5)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 6)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 7)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 8)
        
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 10.0, interval2: 13.0, time: 3.0, n: 19)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 15.0, interval2: 8.0, time: 3.0, n: 19)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 19)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 19)
        
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 10.0, interval2: 13.0, time: 3.0, n: 21)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 15.0, interval2: 8.0, time: 3.0, n: 21)
        addmAction3(xmove: 0.0, ymove: 3.0, interval1: 18.0, interval2: 5.0, time: 3.0, n: 21)
        addmAction3(xmove: 0.0, ymove: 0.0, interval1: 23.0, interval2: 0.0, time: 3.0, n: 21)
        
  
        addmAction(xmove: 0.0, ymove: 5.0, interval: 1.0, time: 3.0, n: 10)
        addmAction(xmove: 0.0, ymove: -5.0, interval: 1.0, time: 3.0, n: 11)
        addmAction(xmove: 0.0, ymove: 3.0, interval: 1.0, time: 3.0, n: 12)
        addmAction(xmove: 0.0, ymove: 3.0, interval: 1.0, time: 3.0, n: 13)

        addrAction(dsita: 180.0, interval: 0.0, re: false, time: 5.0, n: 14)
        addrAction(dsita: -180.0, interval: 0.0, re: false, time: 5.0, n: 15)
        addrAction(dsita: 180.0, interval: 0.0, re: false, time: 5.0, n: 16)
        addrAction(dsita: -180.0, interval: 0.0, re: false, time: 5.0, n: 17)
    
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
