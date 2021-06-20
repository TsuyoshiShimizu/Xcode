//
//  Stage16.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage16: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag16")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 1
            bally = 9
            addmiddleflag1(xp: 22, yp: 15)
            addmiddleflag2(xp: 44, yp: 43)
            addmiddleflag3(xp: 24, yp: 37)
        }else if middleflagrevel == 1{
            addmiddleflag2(xp: 44, yp: 43)
            addmiddleflag3(xp: 24, yp: 37)
            ballx = 22
            bally = 15
        }else if middleflagrevel == 2{
            addmiddleflag3(xp: 24, yp: 37)
            ballx = 44
            bally = 43
        }else if middleflagrevel == 3{
            ballx = 24
            bally = 37
        }
        let stagen: Int = 16
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
        addgoal(xp: 17, yp: 36,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 8, yp: 2,n:0)
        }
        
        //オブジェクト作成
        
        addsquare(xp: 0, yp: 0, xs: 3, ys: 8, angle: 0, n: 0)
        addsquare(xp: 0, yp: 8, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 0, yp: 10, xs: 3, ys: 12, angle: 0, n: 0)
        addgreensquare(xp: 3, yp: 0, xs: 2, ys: 1, angle: 0, friction: 1, n: 0)
        addsquare(xp: 5, yp: 0, xs: 1, ys: 22, angle: 0, n: 0)
        
        addsquare5(xp: 0, yp: 22, xs: 3, ys: 3, angle: -90, n: 0)
        addsquare5(xp: 12, yp: 22, xs: 3, ys: 3, angle: 180, n: 0)
        
        addgreentraiangr(xp: 12, yp: 25, xs: 4, ys: 3, mirror: false, angle: 180, friction: 0, n: 0)
        addredcircle3(xp: 5, yp: 22, xs: 1, ys: 4, mirror: false, angle: 0, n: 0)
        addredcircle3(xp: 5.5, yp: 25, xs: 6.5, ys: 3, mirror: false, angle: 0, n: 0)
        addredtraiangr(xp: 6, yp: 22, xs: 6, ys: 3, tate: false, angle: 180, n: 0)
        addredtraiangr(xp: 12, yp: 25, xs: 3, ys: 3, tate: false, angle: 180, n: 0)
  
        addgreentraiangr(xp: 18, yp: 20, xs: 3, ys: 2, mirror: false, angle: 0, friction: 0, n: 0)
        addgreentraiangr(xp: 18, yp: 18, xs: 3, ys: 2, mirror: true, angle: 180, friction: 0, n: 0)
        addgreentraiangr(xp: 18, yp: 13, xs: 3, ys: 2, mirror: false, angle: 0, friction: 0, n: 0)
        addgreentraiangr(xp: 18, yp: 11, xs: 3, ys: 2, mirror: true, angle: 180, friction: 0, n: 0)
        addgreencircle(xp: 6, yp: 10, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 6, yp: 14, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 10, yp: 8, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 10, yp: 12, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 10, yp: 16, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 14, yp: 10, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 14, yp: 14, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 17, yp: 17, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 19, yp: 8, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 6, yp: 4, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 19, yp: 4, xs: 2, ys: 2, friction: 0, n: 0)
        addgreentraiangr(xp: 6, yp: 0, xs: 6, ys: 2, mirror: true, angle: 0, friction: 0, n: 0)
        addgreentraiangr(xp: 15, yp: 0, xs: 6, ys: 2, mirror: false, angle: 0, friction: 0, n: 0)
        addgreensquare(xp: 10, yp: 3, xs: 7, ys: 1, angle: 0, friction: 0, n: 1)
        addrAction(dsita: 360, interval: 0, re: false, time: 3, n: 1)
        
        addgreensquare(xp: 11, yp: 20, xs: 3, ys: 3, angle: 0, friction: 0, n: 2)
        addgreensquare(xp: 11, yp: 20, xs: 3, ys: 3, angle: 45, friction: 0, n: 3)
        addrAction(dsita: 360, interval: 0, re: false, time: 3, n: 2)
        addrAction(dsita: 360, interval: 0, re: false, time: 3, n: 3)
    
        addsquare(xp: 21, yp: 0, xs: 3, ys: 14, angle: 0, n: 0)
        addsquare(xp: 21, yp: 14, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 22, yp: 17, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 23, yp: 16, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 21, yp: 18, xs: 3, ys: 4, angle: 0, n: 0)
        addgreensquare(xp: 24, yp: 0, xs: 2, ys: 1, angle: 0, friction: 1, n: 0)
        addsquare(xp: 26, yp: 0, xs: 1, ys: 22, angle: 0, n: 0)
        
        addsquare5(xp: 21, yp: 22, xs: 3, ys: 3, angle: -90, n: 0)
        addsquare5(xp: 33, yp: 22, xs: 3, ys: 3, angle: 180, n: 0)
        
        addredcircle3(xp: 26, yp: 22, xs: 1, ys: 4, mirror: false, angle: 0, n: 0)
        
        addgreentraiangr(xp: 39, yp: 20, xs: 3, ys: 2, mirror: false, angle: 0, friction: 0, n: 11)
        addgreentraiangr(xp: 39, yp: 18, xs: 3, ys: 2, mirror: true, angle: 180, friction: 0, n: 12)
        addmAction(xmove: 0, ymove: -3, interval: 5, time: 2, n: 11)
        addmAction(xmove: 0, ymove: -3, interval: 5, time: 2, n: 12)
        addgreentraiangr(xp: 39, yp: 7, xs: 3, ys: 2, mirror: false, angle: 0, friction: 0, n: 13)
        addgreentraiangr(xp: 39, yp: 5, xs: 3, ys: 2, mirror: true, angle: 180, friction: 0, n: 14)
        addmAction(xmove: 0, ymove: -3, interval: 5, time: 2, n: 13)
        addmAction(xmove: 0, ymove: -3, interval: 5, time: 2, n: 14)
        
        addgreensquare(xp: 32, yp: 24, xs: 1, ys: 6, angle: 0, friction: 0, n: 4)
        addrAction(dsita: -360, interval: 0, re: false, time: 3, n: 4)
        addgreensquare(xp: 31, yp: 19, xs: 4, ys: 1, angle: 0, friction: 0, n: 5)
        addrAction(dsita: -360, interval: 0, re: false, time: 3, n: 5)
        addgreensquare(xp: 28, yp: 15, xs: 4, ys: 1, angle: 0, friction: 0, n: 6)
        addrAction(dsita: 360, interval: 0, re: false, time: 3, n: 6)
        addgreensquare(xp: 38, yp: 13, xs: 4, ys: 1, angle: 0, friction: 0, n: 7)
        addrAction(dsita: 360, interval: 0, re: false, time: 3, n: 7)
        addgreensquare(xp: 29, yp: 5, xs: 4, ys: 1, angle: 0, friction: 0, n: 8)
        addrAction(dsita: 360, interval: 0, re: false, time: 3, n: 8)
        addgreensquare(xp: 36, yp: 6, xs: 4, ys: 1, angle: 0, friction: 0, n: 9)
        addrAction(dsita: -360, interval: 0, re: false, time: 3, n: 9)
    //    addgreensquare(xp: 35, yp: 2, xs: 4, ys: 1, angle: 0, friction: 0, n: 10)
   //     addrAction(dsita: -360, interval: 0, re: false, time: 3, n: 10)
        addgreentraiangr(xp: 27, yp: 0, xs: 6, ys: 2, mirror: true, angle: 0, friction: 0, n: 0)
        addgreentraiangr(xp: 36, yp: 0, xs: 6, ys: 2, mirror: false, angle: 0, friction: 0, n: 0)
        
        addgreencircle(xp: 32, yp: 10, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 35, yp: 14, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 38, yp: 23, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 27, yp: 8, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 33, yp: 21, xs: 2, ys: 2, friction: 0, n: 0)
        
        
        addsquare(xp: 42, yp: 0, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 42, yp: 1, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 43, yp: 4, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 44, yp: 3, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 42, yp: 5, xs: 3, ys: 17, angle: 0, n: 0)
        
        addgreensquare(xp: 45, yp: 0, xs: 4, ys: 1, angle: 0, friction: 1, n: 0 )
        addsquare(xp: 49, yp: 0, xs: 1, ys: 20, angle: 0, n: 0)
        addsquare(xp: 49, yp: 20, xs: 1, ys: 20, angle: 0, n: 0)
        addsquare(xp: 49, yp: 40, xs: 1, ys: 6, angle: 0, n: 0)
        addsquare(xp: 44, yp: 46, xs: 6, ys: 11, angle: 0, n: 0)
        addsquare(xp: 47, yp: 57, xs: 3, ys: 12, angle: 0, n: 0)
        addsquare(xp: 44, yp: 34, xs: 1, ys: 9, angle: 0, n: 0)
        addsquare(xp: 45, yp: 42, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 41, yp: 35, xs: 1, ys: 22, angle: 0, n: 0)
        addgreensquare(xp: 42, yp: 35, xs: 2, ys: 1, angle: 0, friction: 1, n: 0)
        
        addredcircle2(xp: 28, yp: 57, xs: 14, ys: 7, tate: false, angle: 0, n: 0)
        addredcircle2(xp: 28, yp: 50, xs: 13, ys: 7, tate: false, angle: 180, n: 0)
        addgreentraiangr(xp: 37, yp: 47, xs: 4, ys: 4, mirror: true, angle: 180, friction: 0, n: 0)
        addgreentraiangr(xp: 37, yp: 35, xs: 4, ys: 4, mirror: false, angle: 0, friction: 0, n: 0)
        addgreentraiangr(xp: 31, yp: 35, xs: 4, ys: 4, mirror: true, angle: 0, friction: 0, n: 0)
        addgreentraiangr(xp: 31, yp: 41, xs: 4, ys: 4, mirror: true, angle: 180, friction: 0, n: 0)
        addgreentraiangr(xp: 26, yp: 42, xs: 3, ys: 3, mirror: false, angle: 180, friction: 0, n: 0)
        addgreentraiangr(xp: 26, yp: 35, xs: 3, ys: 4, mirror: false, angle: 0, friction: 0, n: 0)
        addgreensquare(xp: 29, yp: 35, xs: 2, ys: 4, angle: 0, friction: 0, n: 0)
        
        addsquare5(xp: 23, yp: 57, xs: 3, ys: 3, angle: -90, n: 0)
        addsquare5(xp: 35, yp: 57, xs: 3, ys: 3, angle: 180, n: 0)
        addsquare5(xp: 23, yp: 45, xs: 3, ys: 3, angle: 0, n: 0)
        
        addgreencircle(xp: 35, yp: 42, xs: 2, ys: 2, friction: 0, n: 15)
        addgreencircle(xp: 29, yp: 39, xs: 2, ys: 2, friction: 0, n: 16)
        addmAction(xmove: 4, ymove: 0, interval: 0, time: 1, n: 15)
        addmAction(xmove: 0, ymove: 4, interval: 0, time: 1, n: 16)
        
        addgreentraiangr(xp: 8, yp: 61, xs: 3, ys: 3, mirror: false, angle: 180, friction: 0, n: 17)
        addrAction4(originx: 12, originy: 59, dsita: 360, interval: 0, re: false, time: 2, n: 17)
        addgreentraiangr(xp: 6, yp: 51, xs: 3, ys: 3, mirror: true, angle: 0, friction: 0, n: 18)
        addrAction4(originx: 10, originy: 55, dsita: -360, interval: 0, re: false, time: 2, n: 18)
        addgreentraiangr(xp: 16, yp: 57, xs: 3, ys: 3, mirror: true, angle: 180, friction: 0, n: 19)
        addrAction4(originx: 14, originy: 55, dsita: 360, interval: 0, re: false, time: 2, n: 19)
        
        addgreencircle(xp: 5, yp: 47, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 9, yp: 47, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 13, yp: 47, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 18, yp: 47, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 8, yp: 43, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 12, yp: 43, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 16, yp: 43, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 5, yp: 39, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 10, yp: 39, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 14, yp: 39, xs: 2, ys: 2, friction: 0, n: 0)
        addgreencircle(xp: 18, yp: 39, xs: 2, ys: 2, friction: 0, n: 0)
        
        addgreensquare(xp: 5, yp: 35, xs: 5, ys: 1, angle: 0, friction: 0, n: 20)
        
        addmAction(xmove: 4, ymove: 0, interval: 2, time: 0, n: 20)
        
        addcircle(xp: 5, yp: 36, xs: 2, ys: 2, n: 0)
        addcircle(xp: 9, yp: 36, xs: 2, ys: 2, n: 0)
        addcircle(xp: 14, yp: 36, xs: 2, ys: 2, n: 0)
        addcircle(xp: 18, yp: 36, xs: 2, ys: 2, n: 0)
        addsquare(xp: 5, yp: 36, xs: 2, ys: 1, angle: 0, n: 0)
        addsquare(xp: 9, yp: 36, xs: 2, ys: 1, angle: 0, n: 0)
        addsquare(xp: 14, yp: 36, xs: 2, ys: 1, angle: 0, n: 0)
        addsquare(xp: 18, yp: 36, xs: 2, ys: 1, angle: 0, n: 0)
        addsquare(xp: 14, yp: 35, xs: 6, ys: 1, angle: 0, n: 0)
        
        
        
        addsquare(xp: 23, yp: 35, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 25, yp: 36, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 23, yp: 38, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 24, yp: 39, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 23, yp: 40, xs: 3, ys: 17, angle: 0, n: 0)
        addsquare(xp: 20, yp: 35, xs: 1, ys: 22, angle: 0, n: 0)
        addgreensquare(xp: 21, yp: 35, xs: 2, ys: 1, angle: 0, friction: 1, n: 0)
        
        addsquare5(xp: 2, yp: 57, xs: 3, ys: 3, angle: -90, n: 0)
        addsquare5(xp: 14, yp: 57, xs: 3, ys: 3, angle: 180, n: 0)
        addsquare(xp: 2, yp: 35, xs: 3, ys: 22, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp:34, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 34, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 40, yp: 34, xs: 4, ys: 1, angle: 0, n: 0)
        

        
        
        //オブジェクト動作追加
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}

