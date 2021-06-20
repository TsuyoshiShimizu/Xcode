//
//  Stage07.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/16.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage07: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag7")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        if middleflagrevel == 0{
            ballx = 1
            bally = 5
            addmiddleflag1(xp: 78, yp: 13)
        }else if middleflagrevel == 1{
            ballx = 78
            bally = 17
           
        }
        let stagen: Int = 7
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
        /*
        if middleflagrevel == 0{
            self.addmiddleflag1(xp: 78, yp:14)
            self.addball(xbp:77,ybp:16,balln:0)
        }else if middleflagrevel == 1{
            self.addball(xbp:76,ybp:14,balln:0)
            self.sita = 90.0
        }
 */
        addball(xbp: ballx, ybp: bally, balln: 0)
        addgoal(xp: 1, yp: 24, n: 0)
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 9, yp: 28, n: 0)
        }
        

        addsquare(xp: 0, yp: 4, xs: 1, ys: 5, angle: 0.0, n: 0)
        addsquare(xp: 1, yp: 4, xs: 4, ys: 1, angle: 0.0, n: 0)
        
        addredsquare(xp: 0, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 10, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 20, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 30, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 40, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 50, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 60, yp: 10, xs: 10, ys: 1, angle: 0.0, n: 0)
        addredsquare(xp: 70, yp: 10, xs: 6, ys: 1, angle: 0.0, n: 0)
        addsquare(xp: 5, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 1)
        addsquare(xp: 6, yp: 2, xs: 3, ys: 1, angle: 0.0, n: 2)
        addsquare(xp: 9, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 3)
        addmAction4(xmove: 70, ymove: 0, ininterval: 0.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 1)
        addmAction4(xmove: 70, ymove: 0, ininterval: 0.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 2)
        addmAction4(xmove: 70, ymove: 0, ininterval: 0.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 3)
        addsquare(xp: 5, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 4)
        addsquare(xp: 6, yp: 2, xs: 3, ys: 1, angle: 0.0, n: 5)
        addsquare(xp: 9, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 6)
        addmAction4(xmove: 70, ymove: 0, ininterval: 12.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 4)
        addmAction4(xmove: 70, ymove: 0, ininterval: 12.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 5)
        addmAction4(xmove: 70, ymove: 0, ininterval: 12.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 6)
        addsquare(xp: 5, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 7)
        addsquare(xp: 6, yp: 2, xs: 3, ys: 1, angle: 0.0, n: 8)
        addsquare(xp: 9, yp: 2, xs: 1, ys: 2, angle: 0.0, n: 9)
        addmAction4(xmove: 70, ymove: 0, ininterval: 24.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 7)
        addmAction4(xmove: 70, ymove: 0, ininterval: 24.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 8)
        addmAction4(xmove: 70, ymove: 0, ininterval: 24.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 9)
        
        addsquare(xp: 5, yp: 8, xs: 1, ys: 2, angle: 0.0, n: 10)
        addsquare(xp: 6, yp: 9, xs: 3, ys: 1, angle: 0.0, n: 11)
        addsquare(xp: 9, yp: 8, xs: 1, ys: 2, angle: 0.0, n: 12)
        addmAction4(xmove: 70, ymove: 0, ininterval: 0.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 10)
        addmAction4(xmove: 70, ymove: 0, ininterval: 0.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 11)
        addmAction4(xmove: 70, ymove: 0, ininterval: 0.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 12)
        addsquare(xp: 5, yp: 8, xs: 1, ys: 2, angle: 0.0, n: 13)
        addsquare(xp: 6, yp: 9, xs: 3, ys: 1, angle: 0.0, n: 14)
        addsquare(xp: 9, yp: 8, xs: 1, ys: 2, angle: 0.0, n: 15)
        addmAction4(xmove: 70, ymove: 0, ininterval: 12.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 13)
        addmAction4(xmove: 70, ymove: 0, ininterval: 12.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 14)
        addmAction4(xmove: 70, ymove: 0, ininterval: 12.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 15)
        addsquare(xp: 5, yp: 8, xs: 1, ys: 2, angle: 0.0, n: 16)
        addsquare(xp: 6, yp: 9, xs: 3, ys: 1, angle: 0.0, n: 17)
        addsquare(xp: 9, yp: 8, xs: 1, ys: 2, angle: 0.0, n: 18)
        addmAction4(xmove: 70, ymove: 0, ininterval: 24.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 16)
        addmAction4(xmove: 70, ymove: 0, ininterval: 24.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 17)
        addmAction4(xmove: 70, ymove: 0, ininterval: 24.0, intime: 1.0, moveinterval: 5.0, mtime: 36.0, outinterval: 1.0, outtime: 5.0, n: 18)
        
        addredsquare(xp: 16, yp: 0, xs: 4, ys: 5, angle: 0.0, n: 0)
        addredsquare(xp: 26, yp: 6, xs: 4, ys: 4, angle: 0.0, n: 0)
        
        addredsquare(xp: 38, yp: 0, xs: 2, ys: 4, angle: 0.0, n: 19)
        addredsquare(xp: 48, yp: 7, xs: 2, ys: 3, angle: 0.0, n: 20)
        addmAction(xmove: 10, ymove: 0, interval: 0, time: 5, n: 19)
        addmAction(xmove: -10, ymove: 0, interval: 0, time: 5, n: 20)
        
        addredsquare(xp: 55, yp: 7, xs: 3, ys: 3, angle: 0.0, n: 21)
        addredsquare(xp: 63, yp: 0, xs: 3, ys: 3, angle: 0.0, n: 22)
        addmAction(xmove: 0, ymove: -7, interval: 0, time: 5, n: 21)
        addmAction(xmove: 0, ymove: 7, interval: 0, time: 5, n: 22)
        
        addredsquare(xp: 71, yp: 6, xs: 4, ys: 4, angle: 0, n: 0)
        
        addsquare(xp: 75, yp: 15, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 79, yp: 12, xs: 1, ys: 7, angle: 0, n: 0)
     
        
        addsquare(xp: 67, yp: 11, xs: 1, ys: 2, angle: 0, n: 23)
        addsquare(xp: 68, yp: 11, xs: 3, ys: 1, angle: 0, n: 24)
        addoutinAction(firstinterval: 0, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 23)
        addoutinAction(firstinterval: 0, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 24)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 23)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 24)
        addsquare(xp: 74, yp: 11, xs: 1, ys: 2, angle: 0, n: 25)
        addsquare(xp: 71, yp: 11, xs: 3, ys: 1, angle: 0, n: 26)
        addoutinAction(firstinterval: 6, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 25)
        addoutinAction(firstinterval: 6, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 26)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 25)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 26)
        addsquare(xp: 67, yp: 18, xs: 1, ys: 2, angle: 0, n: 27)
        addsquare(xp: 68, yp: 19, xs: 3, ys: 1, angle: 0, n: 28)
        addoutinAction(firstinterval: 6, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 27)
        addoutinAction(firstinterval: 6, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 28)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 27)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 28)
        addsquare(xp: 74, yp: 18, xs: 1, ys: 2, angle: 0, n: 29)
        addsquare(xp: 71, yp: 19, xs: 3, ys: 1, angle: 0, n: 30)
        addoutinAction(firstinterval: 0, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 29)
        addoutinAction(firstinterval: 0, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 30)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 29)
        addmAction4(xmove: -67, ymove: 0, ininterval: 0, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 30)
        
        addsquare(xp: 67, yp: 11, xs: 1, ys: 2, angle: 0, n: 31)
        addsquare(xp: 68, yp: 11, xs: 3, ys: 1, angle: 0, n: 32)
        addoutinAction(firstinterval: 12, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 31)
        addoutinAction(firstinterval: 12, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 32)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 31)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 32)
        addsquare(xp: 74, yp: 11, xs: 1, ys: 2, angle: 0, n: 33)
        addsquare(xp: 71, yp: 11, xs: 3, ys: 1, angle: 0, n:34)
        addoutinAction(firstinterval: 18, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 33)
        addoutinAction(firstinterval: 18, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 34)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 33)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 34)
        addsquare(xp: 67, yp: 18, xs: 1, ys: 2, angle: 0, n: 35)
        addsquare(xp: 68, yp: 19, xs: 3, ys: 1, angle: 0, n: 36)
        addoutinAction(firstinterval: 18, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 35)
        addoutinAction(firstinterval: 18, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 36)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 35)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 36)
        addsquare(xp: 74, yp: 18, xs: 1, ys: 2, angle: 0, n: 37)
        addsquare(xp: 71, yp: 19, xs: 3, ys: 1, angle: 0, n: 38)
        addoutinAction(firstinterval: 12, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 37)
        addoutinAction(firstinterval: 12, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n:38)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 37)
        addmAction4(xmove: -67, ymove: 0, ininterval: 12, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 38)
        
        addsquare(xp: 67, yp: 11, xs: 1, ys: 2, angle: 0, n: 39)
        addsquare(xp: 68, yp: 11, xs: 3, ys: 1, angle: 0, n: 40)
        addoutinAction(firstinterval: 24, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 39)
        addoutinAction(firstinterval: 24, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 40)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 39)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 40)
        addsquare(xp: 74, yp: 11, xs: 1, ys: 2, angle: 0, n: 41)
        addsquare(xp: 71, yp: 11, xs: 3, ys: 1, angle: 0, n:42)
        addoutinAction(firstinterval: 30, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 41)
        addoutinAction(firstinterval: 30, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 42)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 41)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 42)
        addsquare(xp: 67, yp: 18, xs: 1, ys: 2, angle: 0, n: 43)
        addsquare(xp: 68, yp: 19, xs: 3, ys: 1, angle: 0, n: 44)
        addoutinAction(firstinterval: 30, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 43)
        addoutinAction(firstinterval: 30, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 44)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 43)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 44)
        addsquare(xp: 74, yp: 18, xs: 1, ys: 2, angle: 0, n: 45)
        addsquare(xp: 71, yp: 19, xs: 3, ys: 1, angle: 0, n: 46)
        addoutinAction(firstinterval: 24, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n: 45)
        addoutinAction(firstinterval: 24, outinterval: 6, ininterval: 2, time1: 2, time2: 2, n:46)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 45)
        addmAction4(xmove: -67, ymove: 0, ininterval: 24, intime: 1, moveinterval: 5, mtime: 36, outinterval: 1, outtime: 5, n: 46)
        
        addredsquare(xp: 60, yp: 11, xs: 2, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 53, yp: 16, xs: 2, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 46, yp: 11, xs: 2, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 32, yp: 16, xs: 10, ys: 4, angle: 0, n: 0)
        addredsquare(xp: 18, yp: 11, xs: 10, ys: 4, angle: 0, n: 0)
        
        addsquare(xp: 10, yp: 11, xs: 3, ys: 3, angle: 0, n: 0)
        addsquare(xp: 10, yp: 17, xs: 3, ys: 3, angle: 0, n: 0)
        
        addsquare(xp: 0, yp: 22, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 1, yp: 25, xs: 5, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 8, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 18, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 38, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 48, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 58, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 68, yp: 20, xs: 10, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 78, yp: 20, xs: 2, ys: 1, angle: 0, n: 0)
        
        addsquare2(xp: 6, yp: 25, xs: 1, ys: 1, angle: 180, n: 0)
        addredsquare(xp: 11, yp: 21, xs: 1, ys: 15, angle: 0, n: 0)
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
