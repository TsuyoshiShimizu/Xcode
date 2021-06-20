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
import AVFoundation

class Stage01: GameController{
    
    override func didMove(to view: SKView){
        contact()
        let stagen: Int = 1
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
        addball(xbp:3,ybp:34,balln:0)
        
        //ゴール作成
        addgoal(xp: 17, yp: 2 ,n:0)
        //トロフィ作成
        addcoin(xp:20, yp: 12,n:0)
        
        //オブジェクト作成
        addsquare(xp:1,yp:32,xs:14,ys:1,angle:-5.0,n:0)
        addsquare(xp:10,yp:28,xs:8,ys:1,angle:5.0,n:0)
        
        addsquare(xp:6,yp:24,xs:10,ys:1,angle:0.0,n:0)
        
        addsquare(xp:19,yp:16,xs:1,ys:11,angle:0.0,n:0)
        
        addsquare(xp:13,yp:13,xs:9,ys:1,angle:-45.0,n:0)
        
        addsquare(xp:10,yp:16,xs:4,ys:1,angle:0.0,n:1)
        addsquare(xp:10,yp:17,xs:1,ys:1,angle:0.0,n:6)
        
        
        addsquare(xp:1,yp:13,xs:1,ys:9,angle:0.0,n:0)
        addsquare(xp: 2, yp: 21, xs: 1, ys: 1, angle: 0, n: 0)
        
        addsquare(xp:1,yp:10,xs:3,ys:3,angle:0.0,n:2)
        addsquare(xp:4,yp:4,xs:3,ys:6,angle:0.0,n:3)
        addsquare(xp:7,yp:4,xs:6,ys:3,angle:0.0,n:4)
        addsquare(xp:13,yp:1,xs:3,ys:3,angle:0.0,n:5)
        
        addsquare(xp:16,yp:1,xs:3,ys:1,angle:0.0,n:0)
    
        //レッドオブジェクト作成
        addredsquare(xp:5, yp: 24 ,xs: 1, ys: 7 ,angle:0.0, n:0)
        
        addredsquare(xp:20, yp: 17 ,xs: 3, ys: 1 ,angle:0.0, n:0)
        addredsquare(xp:22, yp: 9 ,xs: 1, ys: 9 ,angle:0.0, n:0)
        
        addredsquare(xp:4, yp: 15 ,xs: 10, ys: 1 ,angle:0.0, n:0)
  
        //特殊オブジェクト作成
        //手裏剣の位置は２０以上離すこと
 //       addsyuriken(xp: 20, yp: 18)
        //オブジェクト動作追加
        addmAction(xmove: -8.0, ymove: 0.0, interval: 1.0,time: 4, n: 1)
        addmAction(xmove: -8.0, ymove: 0.0, interval: 1.0,time: 4, n: 6)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 2.0, n: 2)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 2.0, n: 3)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 2.0, n: 4)
        addrAction(dsita: 90.0, interval: 1.0, re: false, time: 2.0, n: 5)

        //カメラ作成
        cameraNode.position = ball.position
        
        cameraNode.xScale = 1
        cameraNode.yScale = 1
        addChild(cameraNode)
        camera = cameraNode
    }
}

