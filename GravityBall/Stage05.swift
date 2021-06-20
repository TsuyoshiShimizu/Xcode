//
//  Stage06.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/05.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage05: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag5")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 2
            bally = 2
            addmiddleflag1(xp: 8, yp: 39)
            addmiddleflag2(xp: 6, yp: 66)
            addmiddleflag3(xp: 14, yp: 58)
        }else if middleflagrevel == 1{
            ballx = 8
            bally = 39
            addmiddleflag2(xp: 6, yp: 66)
            addmiddleflag3(xp: 14, yp: 58)
        }else if middleflagrevel == 2{
            addmiddleflag3(xp: 14, yp: 58)
            ballx = 6
            bally = 66
        }else if middleflagrevel == 3{
            ballx = 14
            bally = 58
            sita = -90
        }
        let stagen: Int = 5
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
        addgoal(xp: 34, yp: 40, n: 0)
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 12, yp: 60, n: 0)
        }
        
        addsquare(xp: 0, yp: 0, xs: 6, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 1, xs: 1, ys: 5, angle: 0.0, n: 0)
        
        addsquare(xp: 6, yp: 0, xs: 10, ys: 1, angle: 0.0, n: 1)
        addsquare(xp: 16, yp: 0, xs: 5, ys: 1, angle: 0.0, n: 2)
        
        addsquare(xp: 21, yp: 0, xs: 1, ys: 10, angle: 0.0, n: 0)
        addsquare(xp: 20, yp: 10, xs: 2, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 4, yp: 38, xs: 10, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 14, yp: 38, xs: 8, ys: 1, angle: 0.0, n: 0)

        
        addsquare(xp: 16, yp: 6, xs: 1, ys: 10, angle: 0.0, n: 0)
        addsquare(xp: 16, yp: 16, xs: 1, ys: 2, angle: 0.0, n: 0)
        addsquare(xp: 16, yp: 18, xs: 1, ys: 5, angle: 0.0, n: 3)
        addsquare(xp: 16, yp: 20, xs: 5, ys: 1, angle: 0.0, n: 32)
        addsquare(xp: 16, yp: 23, xs: 1, ys: 10, angle: 0.0, n: 0)
        addsquare(xp: 16, yp: 33, xs: 1, ys: 5, angle: 0.0, n: 4)
        
        
        addsquare(xp: 10, yp: 33, xs: 1, ys: 5, angle: 0.0, n: 0)
        addsquare(xp: 10, yp: 28, xs: 1, ys: 5, angle: 0.0, n: 5)
        addsquare(xp: 10, yp: 30, xs: 5, ys: 1, angle: 0.0, n: 33)
        addsquare(xp: 10, yp: 23, xs: 1, ys: 5, angle: 0.0, n: 0)
        addsquare(xp: 10, yp: 18, xs: 1, ys: 5, angle: 0.0, n: 6)
        addsquare(xp: 10, yp: 20, xs: 5, ys: 1, angle: 0.0, n: 34)
        addsquare(xp: 10, yp: 13, xs: 1, ys: 5, angle: 0.0, n: 0)
        addsquare(xp: 10, yp: 8, xs: 1, ys: 5, angle: 0.0, n: 7)
        
        addsquare(xp: 0, yp: 7, xs: 10, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 10, yp: 7, xs: 6, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 7, xs: 1, ys: 10, angle: 0.0, n: 0)
        addsquare(xp: 0, yp: 17, xs: 3, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 8, yp: 13, xs: 1, ys: 10, angle: 0.0, n: 8)
        addsquare(xp: 6, yp: 22, xs: 2, ys: 1, angle: 0.0, n: 9)
        
        addsquare(xp: 0, yp: 18, xs: 1, ys: 10, angle: 0.0, n: 10)
        addsquare(xp: 1, yp: 27, xs: 2, ys: 1, angle: 0.0, n: 11)
        
        addsquare(xp: 8, yp: 23, xs: 1, ys: 10, angle: 0.0, n: 12)
        addsquare(xp: 6, yp: 32, xs: 2, ys: 1, angle: 0.0, n: 13)
        
        addsquare(xp: 0, yp: 28, xs: 1, ys: 10, angle: 0.0, n: 14)
        addsquare(xp: 0, yp: 38, xs: 4, ys: 1, angle: 0.0, n: 15)
        
        addsquare(xp: 0, yp: 43, xs: 7, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 6, yp: 42, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 10, yp: 39, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        addsquare(xp: 9, yp: 48, xs: 1, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 4, yp: 45, xs: 1, ys: 9, angle: 0.0, n: 16)
        addsquare(xp: 4, yp: 54, xs: 1, ys: 9, angle: 0.0, n: 17)
        
        addsquare(xp: 0, yp: 48, xs: 9, ys: 1, angle: 0.0, n: 18)
        addsquare(xp: 0, yp: 53, xs: 9, ys: 1, angle: 0.0, n: 19)
        addsquare(xp: 0, yp: 58, xs: 9, ys: 1, angle: 0.0, n: 20)
        
        
        addsquare(xp: 2, yp: 70, xs: 7, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 8, yp: 68, xs: 1, ys: 3, angle: 0.0, n: 0)
        addsquare(xp: 9, yp: 68, xs: 4, ys: 1, angle: 0.0, n: 0)
        
        addsquare(xp: 4, yp: 63, xs: 1, ys: 5, angle: 0.0, n: 0)
        addsquare(xp: 5, yp: 64, xs: 8, ys: 2, angle: 0.0, n: 0)
        
        addsquare(xp: 12, yp: 63, xs: 9, ys: 3, angle: 0.0, n: 21)
        addsquare(xp: 21, yp: 63, xs: 9, ys: 3, angle: 0.0, n: 22)
        addsquare(xp: 30, yp: 63, xs: 9, ys: 3, angle: 0.0, n: 23)
        
        addsquare(xp: 16, yp: 60, xs: 1, ys: 9, angle: 0.0, n: 24)
        addsquare(xp: 25, yp: 60, xs: 1, ys: 9, angle: 0.0, n: 25)
        addsquare(xp: 34, yp: 60, xs: 1, ys: 9, angle: 0.0, n: 26)
        
        addsquare(xp: 12, yp: 62, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 11, yp: 44, xs: 1, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 39, yp: 54, xs: 1, ys: 2, angle: 0.0, n: 0)
        
        
        addcircle(xp: 14, yp: 62, xs: 5, ys: 5, n: 0)
        addcircle(xp: 23, yp: 62, xs: 5, ys: 5, n: 0)
        addcircle(xp: 32, yp: 62, xs: 5, ys: 5, n: 0)
        
        addsquare(xp: 13, yp: 53, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        addsquare(xp: 16, yp: 44, xs: 2, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 17, yp: 45, xs: 1, ys: 2, angle: 0.0, n: 0)
        
        addcircle(xp: 13, yp: 47, xs: 9, ys: 9, n: 27)
        addcircle(xp: 18, yp: 47, xs: 9, ys: 9, n: 28)
        addcircle(xp: 23, yp: 47, xs: 9, ys: 9, n: 29)
        addcircle(xp: 28, yp: 47, xs: 9, ys: 9, n: 30)
        
        addsquare(xp: 31, yp: 39, xs: 1, ys: 4, angle: 0.0, n: 0)
        addsquare(xp: 32, yp: 39, xs: 5, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 36, yp: 40, xs: 1, ys: 4, angle: 0.0, n: 0)
        addsquare(xp: 37, yp: 43, xs: 3, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 39, yp: 44, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        addsquare(xp: 39, yp: 60, xs: 1, ys: 10, angle: 0.0, n: 0)
        
        
        addredsquare(xp: 0, yp: 6, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 10, yp: 6, xs: 6, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 21, yp: 11, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 21, yp: 21, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 21, yp: 31, xs: 1, ys: 7, angle: 0.0, n: 0)
        
        addredsquare(xp: 15, yp: 8, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 15, yp: 18, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 15, yp: 28, xs: 1, ys: 5, angle: 0.0, n: 0)
        
        addredsquare(xp: 9, yp: 13, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 9, yp: 23, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 9, yp: 33, xs: 1, ys: 5, angle: 0.0, n: 0)
        addredsquare(xp: 4, yp: 37, xs: 5, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 0, yp: 44, xs: 7, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 9, yp: 49, xs: 1, ys: 10, angle: 0.0, n: 0)
        addredsquare(xp: 9, yp: 59, xs: 1, ys: 4, angle: 0.0, n: 0)
        addredsquare(xp: 5, yp: 63, xs: 8, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 5, yp: 52, xs: 4, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 0, yp: 57, xs: 4, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 13, yp: 64, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 23, yp: 64, xs: 10, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 16, yp: 69, xs: 1, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 25, yp: 69, xs: 1, ys: 3, angle: 0.0, n: 0)
        addredsquare(xp: 34, yp: 69, xs: 1, ys: 3, angle: 0.0, n: 0)
        
        addredsquare(xp: 17, yp: 59, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 27, yp: 59, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 37, yp: 59, xs: 3, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 11, yp: 43, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 21, yp: 43, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 31, yp: 43, xs: 1, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 32, yp: 43, xs: 4, ys: 1, angle: 0.0, n: 31)
        
        addredsquare(xp: 18, yp: 44, xs: 10, ys: 8, angle: 0.0, n: 0)
        addredsquare(xp: 28, yp: 44, xs: 4, ys: 8, angle: 0.0, n: 0)
        
        addredsquare(xp: 1, yp: 18, xs: 4, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 4, yp: 23, xs: 4, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 1, yp: 28, xs: 4, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 4, yp: 33, xs: 5, ys: 1, angle: 0.0, n: 0)
        
        
    
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 1)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 2)
        
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 3)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 4)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 5)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 6)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 7)
        addoutinAction(firstinterval: 3.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 32)
        addoutinAction(firstinterval: 3.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 33)
        addoutinAction(firstinterval: 3.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 34)
        
        addoutinAction(firstinterval: 0.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 8)
        addoutinAction(firstinterval: 0.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 9)
        
        addoutinAction(firstinterval: 4.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 10)
        addoutinAction(firstinterval: 4.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 11)
        
        addoutinAction(firstinterval: 8.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 12)
        addoutinAction(firstinterval: 8.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 13)
        
        addoutinAction(firstinterval: 12.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 14)
        addoutinAction(firstinterval: 12.0, outinterval: 5.0, ininterval: 5.0, time1: 1.0, time2: 1.0, n: 15)
        
        addoutinAction(firstinterval: 0.0, outinterval: 6.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 16)
        addoutinAction(firstinterval: 0.0, outinterval: 6.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 17)
        
        addoutinAction(firstinterval: 5.0, outinterval: 6.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 18)
        addoutinAction(firstinterval: 5.0, outinterval: 6.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 19)
        addoutinAction(firstinterval: 5.0, outinterval: 6.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 20)
        
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 21)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 22)
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 23)
        
        addoutinAction(firstinterval: 3.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 24)
        addoutinAction(firstinterval: 3.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 25)
        addoutinAction(firstinterval: 3.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 26)
        
        addoutinAction(firstinterval: 0.0, outinterval: 8.0, ininterval: 8.0, time1: 1.0, time2: 1.0, n: 27)
        addoutinAction(firstinterval: 4.0, outinterval: 8.0, ininterval: 8.0, time1: 1.0, time2: 1.0, n: 28)
        addoutinAction(firstinterval: 8.0, outinterval: 8.0, ininterval: 8.0, time1: 1.0, time2: 1.0, n: 29)
        addoutinAction(firstinterval: 12.0, outinterval: 8.0, ininterval: 8.0, time1: 1.0, time2: 1.0, n: 30)


        
        addoutinAction(firstinterval: 0.0, outinterval: 2.0, ininterval: 2.0, time1: 1.0, time2: 1.0, n: 31)
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
