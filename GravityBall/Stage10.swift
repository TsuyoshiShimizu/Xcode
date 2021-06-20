//
//  Stage10.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage10: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag10")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 1
            bally = 32
            addmiddleflag1(xp: 27, yp: 2)
            addmiddleflag2(xp: 44, yp: 33)
        }else if middleflagrevel == 1{
            ballx = 27
            bally = 2
            addmiddleflag2(xp: 44, yp: 33)
        }else if middleflagrevel == 2{
            ballx = 44
            bally = 33
            sita = 180
        }
        let stagen: Int = 10
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
        addgoal(xp: 57, yp: 1,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 26 , yp: 18,n:0)
        }
        //オブジェクト作成
        
        addsquare2(xp: 0, yp: 30, xs: 1, ys: 1, angle: 0, n: 0)
        addbluesquare5(xp: 5, yp: 25, angle: 0, small: false, n: 10)
        addrinvalid(n: 10)
        
        addredsquare(xp: 24, yp: 9, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare(xp: 24, yp: 16, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 24, yp: 26, xs: 1, ys: 9, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 23, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 10, yp: 23, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 11, yp: 11, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 21, yp: 11, xs: 3, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 17, yp: 16, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 9, yp: 19, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 2, yp: 15, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 3, yp: 4, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 10, yp: 7, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 14, yp: 0, xs: 2, ys: 2, angle: 0, n: 0)
   //     addredsquare2(xp: 20, yp: 7, xs: 2, ys: 2, angle: 0, n: 0)
        
        addsquare2(xp: 25, yp: 0, xs: 1, ys: 1, angle: 90, n: 0)
        
        addbluesquare6(xp: 25, yp: 6, angle: 0, small: false, n: 11)
        addrinvalid(n: 11)
        addbluesquare6(xp: 30, yp: 0, angle: 180, small: false, n: 0)
        
        addredsquare(xp: 31, yp: 10, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare(xp: 31, yp: 10, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 42, yp: 0, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 42, yp: 10, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 42, yp: 20, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 42, yp: 30, xs: 1, ys: 2, angle: 0, n: 0)
        
        addsquare(xp: 37, yp: 22, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 35, yp: 23, xs: 2, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 37, yp: 28, xs: 1, ys: 8, angle: 0, n: 0)
        
        addredsquare2(xp: 25, yp: 16, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 35, yp: 16, xs: 1, ys: 1, angle: 0, n: 0)
        
//        addsquare(xp: 26, yp: 17, xs: 1, ys: 1, angle: 0, n: 0)
        addsquare(xp: 25, yp: 21, xs: 2, ys: 1, angle: 0, n: 0)
        addsquare(xp: 30, yp: 18, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 31, yp: 18, xs: 3, ys: 1, angle: 0, n: 0)
        
        addbluesquare3(xp: 30, yp: 22, angle: 180, small: false, n: 3)
        addrinvalid(n: 3)
        
        addredsquare2(xp: 26, yp: 25, xs: 1, ys: 10, angle: 0, n: 0)
        addredsquare2(xp: 27, yp: 34, xs: 10, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 31, yp: 27, xs: 3, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 35, yp: 33, xs: 2, ys: 1, angle: 0, n: 2)
        addmAction(xmove: 0, ymove: 4, interval:2, time: 5, n: 2)
        
        addredsquare2(xp: 34, yp: 12, xs: 2, ys: 2, angle: 0, n: 1)
        addmAction(xmove: 6, ymove: 0, interval: 2, time: 5, n: 1)

        addsquare(xp: 38, yp: 34, xs: 8, ys: 1, angle: 0, n: 0)
        addsquare(xp: 45, yp: 33, xs: 1, ys: 1, angle: 0, n: 0)
        
        addbluesquare3(xp: 43, yp: 27, angle: 0, small: false, n: 4)
        addrinvalid(n: 4)
        
        addredsquare2(xp: 43, yp: 25, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 53, yp: 25, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 43, yp: 21, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 45, yp: 14, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare2(xp: 50, yp: 14, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare2(xp: 50, yp: 21, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 43, yp: 9, xs: 9, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 55, yp: 9, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 43, yp: 4, xs: 4, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 50, yp: 4, xs: 10, ys: 1, angle: 0, n: 0)

        //オブジェクト動作追加
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
        
    }
}
