//
//  Stage14.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage14: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag14")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 2
            bally = 2
            addmiddleflag1(xp: 16, yp: 28)
            addmiddleflag2(xp: 45, yp: 32)
        }else if middleflagrevel == 1{
            ballx = 16
            bally = 28
            addmiddleflag2(xp: 45, yp: 32)
        }else if middleflagrevel == 2{
            ballx = 45
            bally = 32
        }
        let stagen: Int = 14
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
        addgoal(xp: 30, yp: 33,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 2, yp: 7,n:0)
        }
        
        
        //オブジェクト作成
        addsquare(xp: 0, yp: 0, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 1, yp: 0, xs: 10, ys: 1, angle: 0, n: 0)
        addtraiangr(xp: 7, yp: 1, xs: 4, ys: 4,mirror: true,angle: 90, n: 0)
        
        addsquare(xp: 0, yp: 6, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 1, yp: 6, xs: 6, ys: 1, angle: 0, n: 0)
        addtraiangr(xp: 5, yp: 7, xs: 2, ys: 2, mirror: true,angle: 90, n: 0)
        
        addsquare(xp: 0, yp: 14, xs: 1, ys: 11, angle: 0, n: 0)
        addsquare(xp: 1, yp: 14, xs: 2, ys: 3, angle: 0, n: 0)
        addtraiangr(xp: 3, yp: 14, xs: 3, ys: 3,mirror: true, angle: 0, n: 0)
        
        addsquare2(xp: 0, yp: 30, xs: 1, ys: 1, angle: -90, n: 0)
        addtraiangr(xp: 3, yp: 32, xs: 2, ys: 2,mirror:true, angle: 180, n: 0)
        
        addsquare2(xp: 14, yp: 26, xs: 1, ys: 1, angle: 90, n: 0)
        
        addredsquare(xp: 0, yp: 5, xs: 7, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 0, yp: 12, xs: 6, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 10, yp: 5, xs: 10, ys: 1, angle: 45, n: 0)
        addredsquare(xp: 5, yp: 9, xs: 12, ys: 1, angle: 45, n: 0)
        addredsquare(xp: 5, yp: 17, xs: 12, ys: 1, angle: -45, n: 0)
        addredsquare(xp: 9, yp: 22, xs: 12, ys: 1, angle: -45, n: 0)
        
        addredsquare(xp: 7, yp: 32, xs: 1, ys: 3, angle: 0, n: 0)
        addredsquare(xp: 11, yp: 28, xs: 1, ys: 3, angle: 0, n: 0)
     
        addgreensquare(xp: 19, yp: 9, xs: 1, ys: 8, angle: 0, friction: 0,n: 0)
        addgreensquare(xp: 10, yp: 10, xs: 1, ys: 7, angle: 0, friction: 0,n: 0)
        addgreensquare(xp: 4, yp: 27, xs: 7, ys: 1, angle: 0, friction: 0,n: 0)
        addgreensquare(xp: 8, yp: 34, xs: 7, ys: 1, angle: 0, friction: 0,n: 0)
        
        addgreensquare(xp: 14, yp: 34, xs: 5, ys: 1, angle: 45, friction: 0,n: 0)
        addgreensquare(xp: 23, yp: 33, xs: 7, ys: 1, angle: -45, friction: 0,n: 0)
        addgreensquare(xp: 23, yp: 23, xs: 6, ys: 1, angle: 45, friction: 0,n: 0)
        addgreensquare(xp: 18, yp: 23, xs: 6, ys: 1, angle: 45, friction: 0,n: 0)
        addgreensquare(xp: 18, yp: 18, xs: 6, ys: 1, angle: -45, friction: 0,n: 0)
        addgreensquare(xp: 23, yp: 18, xs: 6, ys: 1, angle: -45, friction: 0,n: 0)
        
        addsquare(xp: 19, yp: 20, xs: 1, ys: 6, angle: 0, n: 0)
        addsquare(xp: 20, yp: 25, xs: 3, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 19, yp: 31, xs: 4, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 22, yp: 26, xs: 1, ys: 5, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 16, xs: 1, ys: 15, angle: 0, n: 0)
        
        addsquare2(xp: 23, yp: 4, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 28, yp: 4, xs: 1, ys: 5, angle: 0, n: 0)
        
        addredsquare(xp: 19, yp: 8, xs: 4, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 29, yp: 8, xs: 23, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 29, yp: 16, xs: 23, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 51, yp: 17, xs: 1, ys: 15, angle: 0, n: 0)
        
        addgreensquare(xp: 20, yp: 9, xs: 1, ys: 7, angle: 0, friction: 1.0,n: 0)
        
        addgreensquare(xp: 51, yp: 11, xs: 10, ys: 1, angle: 45,friction: 0, n: 0)
        
        addsquare(xp: 44, yp: 30, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 44, yp: 31, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 45, yp: 34, xs: 15, ys: 1, angle: 0, n: 0)
        addsquare(xp: 59, yp: 31, xs: 1, ys: 3, angle: 0, n: 0)
        
        addsquare(xp: 20, yp: 16, xs: 3, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 48, yp: 19, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 50, yp: 20, xs: 1, ys: 12, angle: 0, n: 0)
        
        addgreensquare(xp: 41, yp: 17, xs: 10, ys: 1, angle: 0, friction: 1.0, n: 1)
        addmAction(xmove: -12, ymove: 0, interval: 1, time: 10, n: 1)
        
        addredsquare(xp: 44, yp: 23, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 46, yp: 24, xs: 1, ys: 6, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 31, xs: 9, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 37, yp: 17, xs: 2, ys: 6, angle: 0, n: 0)
        
        addsquare(xp: 29, yp: 31, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 30, yp: 34, xs: 5, ys: 1, angle: 0, n: 0)
        

        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

