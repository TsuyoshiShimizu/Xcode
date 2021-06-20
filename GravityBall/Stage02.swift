//
//  GamesScean.swift
//  testgame
//
//  Created by 清水健志 on 2018/07/26.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class Stage02: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag2")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 11
            bally = 3
            addmiddleflag1(xp: 27, yp:  10)
        }else if middleflagrevel == 1{
            ballx = 27
            bally = 10
        }
        let stagen: Int = 2
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
            addcoin(xp: 1, yp: 1,n:0)
        }
        addgoal(xp: 36, yp: 33,n:0)
        
        //オブジェクト作成
        addsquare(xp:0,yp: 1,xs: 1,ys:1,angle:0.0, n: 0)
        addsquare(xp: 0, yp: 0, xs: 10, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 10, yp: 0, xs: 5, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 14, yp: 1, xs: 1, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 13, yp: 7, xs: 10, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 22, yp: 6, xs: 1, ys: 1, angle:0.0 , n: 0)
        
        addsquare(xp: 21, yp: 0, xs: 10, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 38, yp: 0, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 39, yp: 0, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        addsquare(xp: 30, yp: 22, xs: 10, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 39, yp: 21, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 29, yp: 17, xs: 1, ys: 6, angle: 0.0, n: 0)
        
        addsquare(xp: 34, yp: 14, xs: 1, ys: 5, angle: 0.0, n: 0)
        
        addsquare(xp: 25, yp: 9, xs: 10, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 34, yp: 10, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 30, yp: 17, xs: 2, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 1, yp: 14, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 1, yp: 33, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 14, xs: 1, ys: 10, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 24, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        addsquare(xp: 17, yp: 14, xs: 10, ys: 2, angle: 0.0, n: 2)
        
        addsquare(xp: 7, yp: 10, xs: 2, ys: 10, angle: 0.0, n: 3)
        
        addsquare(xp: 3, yp: 30, xs: 8, ys: 2, angle: 0, n: 4)
        addsquare(xp: 6, yp: 27, xs: 2, ys: 8, angle: 0.0, n: 5)
        
        addsquare(xp: 31, yp: 30, xs: 8, ys: 2, angle: 0.0, n: 6)
        addsquare(xp: 34, yp: 27, xs: 2, ys: 8, angle: 0.0, n: 7)
        
        
        //レッドオブジェクト作成
        addredsquare(xp: 17, yp: 0, xs: 2, ys: 5, angle: 0.0, n: 0)
        
        addredsquare(xp: 0, yp: 8, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 10, yp: 8, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 20, yp: 8, xs: 7, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 25, yp: 3, xs: 2, ys: 5, angle: 0.0, n: 0)
        
        addredsquare(xp: 27, yp: 4, xs: 9, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 35, yp: 5, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 35, yp: 15, xs: 1, ys: 4, angle: 0.0, n: 0)
        
        addredsquare(xp: 30, yp: 12, xs: 5, ys: 2, angle: 0.0, n: 1)
        addredsquare(xp: 29, yp: 12, xs: 1, ys: 5, angle: 0.0, n: 0)
        
        addredsquare(xp: 4, yp: 22, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 14, yp: 22, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 24, yp: 22, xs: 5, ys: 1, angle: 0.0, n: 0)
        
        
        addmAction(xmove: 5.0, ymove: 0.0, interval: 1.0, time: 4, n: 1)
        
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 5, n: 2)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 5, n: 3)
        
        
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 5.0, n: 4)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 5.0, n: 5)
        addmAction(xmove: 10.0, ymove: 0.0, interval: 1.0, time: 5.0, n: 4)
        addmAction(xmove: 10.0, ymove: 0.0, interval: 1.0, time: 5.0, n: 5)
        
        
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 5, n: 6)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 5, n: 7)
        addmAction(xmove: -10.0, ymove: 0.0, interval: 1.0, time: 5.0, n: 6)
        addmAction(xmove: -10.0, ymove: 0.0, interval: 1.0, time: 5.0, n: 7)
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
