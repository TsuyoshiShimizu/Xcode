//
//  StageS2.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/16.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stageS2: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag102")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        let ws = frame.size.width
        let hs2 = frame.size.height
        let ys = hs2 / h2
        let hs = h * ys
        let background = SKSpriteNode(imageNamed: "bg02")
        background.position = CGPoint(x: ws / 2, y: hs / 2)
        background.size = CGSize(width: ws, height: hs)
        addChild(background)
        if middleflagrevel == 0{
            ballx = 1
            bally = 2
            addmiddleflag1(xp: 19, yp: 10)
            addmiddleflag2(xp: 32, yp: 38)
        }else if middleflagrevel == 1{
            ballx = 19
            bally = 10
            addmiddleflag2(xp: 32, yp: 38)
        }else if middleflagrevel == 2{
            ballx = 32
            bally = 38
        }
        
        let stagen: Int = 102
        UserDefaults.standard.set(stagen, forKey: "playstage")
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -gra)
        
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
        addgoal(xp: 38 , yp:88, n: 0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 1, yp: 88,n:0)
        }
        
        addsquare2(xp: 0, yp: 0, xs: 1, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 2, yp: 3, xs: 5, ys: 1, angle: 0, n: 1)
        addsquare(xp: 6, yp: 3, xs: 1, ys: 5, angle: 0, n: 2)
        addsquare(xp: 2, yp: 7, xs: 5, ys: 1, angle: 0, n: 3)
        addsquare(xp: 2, yp: 3, xs: 1, ys: 5, angle: 0, n: 4)
        addjointObject(jointpx: 2, jointpy: 3, objectAn: 1, objectBn: 4)
        addjointObject(jointpx: 6, jointpy: 3, objectAn: 1, objectBn: 2)
        addjointObject(jointpx: 6, jointpy: 7, objectAn: 2, objectBn: 3)
        addjointObject(jointpx: 2, jointpy: 7, objectAn: 3, objectBn: 4)
        adddina(n: 1)
        adddina(n: 2)
        adddina(n: 3)
        adddina(n: 4)
        changeblueCategory(n: 1)
        changeblueCategory(n: 2)
        changeblueCategory(n: 3)
        changeblueCategory(n: 4)
        addoutinAction2(firstinterval: 0, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 1)
        addoutinAction2(firstinterval: 5, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 2)
        addoutinAction2(firstinterval: 10, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 3)
        addoutinAction2(firstinterval: 15, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 4)
        
        addredsquare(xp: 8, yp: 8, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 8, yp: 28, xs: 1, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 6, yp: 21, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 0, yp: 26, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 4, yp: 30, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 0, yp: 36, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 36, xs: 15, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 16, yp: 30, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare2(xp: 3, yp: 11, xs: 5, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 0, yp: 16, xs: 5, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 16, yp: 16, xs: 1, ys: 14, angle: 0, n: 0)
        addredsquare(xp: 9, yp: 26, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 14, yp: 21, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 9, yp: 16, xs: 2, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 9, yp: 16, xs: 2, ys: 2, angle: 0, n: 5)
        addredsquare2(xp: 14, yp: 29, xs: 2, ys: 2, angle: 0, n: 6)
        addmAction(xmove: 0, ymove: 13, interval: 0, time: 5, n: 5)
        addmAction(xmove: 0, ymove: -13, interval: 0, time: 5, n: 6)
    
        addredsquare(xp: 9, yp: 8, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 29, yp: 8, xs: 6, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 30, yp: 4, xs: 2, ys: 4, angle: 0, n: 0)
        addredsquare2(xp: 9, yp: 3, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 20, yp: 0, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 20, yp: 6, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 36, yp: 0, xs: 4, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 38, yp: 2, xs: 2, ys: 2, angle: 0, n: 0)
        
        addredsquare(xp: 23, yp: 16, xs: 17, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 36, yp: 14, xs: 4, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 38, yp: 12, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 32, yp: 9, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 28, yp: 14, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 24, yp: 9, xs: 2, ys: 2, angle: 0, n: 0)
        
        addsquare(xp: 16, yp: 9, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 17, yp: 9, xs: 5, ys: 1, angle: 0, n: 0)
        addsquare(xp: 21, yp: 10, xs: 1, ys: 3, angle: 0, n: 0)
        
        addsquare(xp: 17, yp: 16, xs: 5, ys: 1, angle: 0, n: 7)
        addsquare(xp: 21, yp: 16, xs: 1, ys: 5, angle: 0, n: 8)
        addsquare(xp: 17, yp: 20, xs: 5, ys: 1, angle: 0, n: 9)
        addsquare(xp: 17, yp: 16, xs: 1, ys: 5, angle: 0, n: 10)
        addjointObject(jointpx: 21, jointpy: 16, objectAn: 7, objectBn: 8)
        addjointObject(jointpx: 21, jointpy: 20, objectAn: 8, objectBn: 9)
        addjointObject(jointpx: 17, jointpy: 20, objectAn: 9, objectBn: 10)
        addjointObject(jointpx: 17, jointpy: 16, objectAn: 7, objectBn: 10)
        adddina(n: 7)
        adddina(n: 8)
        adddina(n: 9)
        adddina(n: 10)
        changeblueCategory(n: 7)
        changeblueCategory(n: 8)
        changeblueCategory(n: 9)
        changeblueCategory(n: 10)
        addoutinAction2(firstinterval: 0, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 7)
        addoutinAction2(firstinterval: 5, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 8)
        addoutinAction2(firstinterval: 10, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 9)
        addoutinAction2(firstinterval: 15, outinterval: 14, ininterval: 4, time1: 1, time2: 1, n: 10)
        
        
        addredsquare2(xp: 17, yp: 28, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 20, yp: 23, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 19, yp: 34, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 22, yp: 30, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 25, yp: 26, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 26, yp: 17, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 29, yp: 22, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 30, yp: 34, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 31, yp: 27, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 34, yp: 17, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 38, yp: 26, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 35, yp: 22, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 35, yp: 31, xs: 2, ys: 2, angle: 0, n: 0)
        
        addredsquare(xp: 35, yp: 41, xs: 5, ys: 1, angle: 0, n: 0)
        addsquare2(xp: 30, yp: 37, xs: 1, ys: 1, angle: 0, n: 0)
        
        
        addsquare(xp: 26, yp: 42, xs: 9, ys: 1, angle: 0, n: 12)
        addsquare(xp: 34, yp: 42, xs: 1, ys: 9, angle: 0, n: 13)
        addsquare(xp: 26, yp: 50, xs: 9, ys: 1, angle: 0, n: 14)
        addsquare(xp: 26, yp: 42, xs: 1, ys: 9, angle: 0, n: 15)
        addsquare(xp: 30, yp: 42, xs: 1, ys: 9, angle: 0, n: 16)
        addsquare(xp: 26, yp: 46, xs: 9, ys: 1, angle: 0, n: 17)
        
        addjointObject(jointpx: 34, jointpy: 42, objectAn: 12, objectBn: 13)
        addjointObject(jointpx: 34, jointpy: 50, objectAn: 13, objectBn: 14)
        addjointObject(jointpx: 26, jointpy: 50, objectAn: 14, objectBn: 15)
        addjointObject(jointpx: 26, jointpy: 42, objectAn: 15, objectBn: 12)
        addjointObject(jointpx: 30, jointpy: 42, objectAn: 12, objectBn: 16)
        addjointObject(jointpx: 30, jointpy: 50, objectAn: 14, objectBn: 16)
        addjointObject(jointpx: 26, jointpy: 46, objectAn: 15, objectBn: 17)
        addjointObject(jointpx: 34, jointpy: 46, objectAn: 13, objectBn: 17)
        addjointObject(jointpx: 30, jointpy: 46, objectAn: 16, objectBn: 17)
        adddina(n: 12)
        adddina(n: 13)
        adddina(n: 14)
        adddina(n: 15)
        adddina(n: 16)
        adddina(n: 17)
        changeblueCategory(n: 12)
        changeblueCategory(n: 13)
        changeblueCategory(n: 14)
        changeblueCategory(n: 15)
        changeblueCategory(n: 16)
        changeblueCategory(n: 17)
        
        addoutinAction2(firstinterval: 0, outinterval: 9, ininterval: 4, time1: 1, time2: 1, n: 12)
        addoutinAction2(firstinterval: 0, outinterval: 9, ininterval: 4, time1: 1, time2: 1, n: 13)
        addoutinAction2(firstinterval: 0, outinterval: 9, ininterval: 4, time1: 1, time2: 1, n: 14)
        addoutinAction2(firstinterval: 0, outinterval: 9, ininterval: 4, time1: 1, time2: 1, n: 15)
        addoutinAction2(firstinterval: 5, outinterval: 4, ininterval: 9, time1: 1, time2: 1, n: 16)
        addoutinAction2(firstinterval: 5, outinterval: 4, ininterval: 9, time1: 1, time2: 1, n: 17)
        
        addredsquare(xp: 11, yp: 52, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 31, yp: 52, xs: 9, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 22, yp: 44, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare2(xp: 15, yp: 37, xs: 1, ys: 8, angle: 0, n: 0)
        addredsquare2(xp: 1, yp: 44, xs: 13, ys: 1, angle: 0, n: 18)
        addrAction(dsita: -90, interval: 0, re: false, time: 8, n: 18)
        
        addredsquare(xp: 20, yp: 53, xs: 1, ys: 7, angle: 0, n: 0)
        
        addredsquare2(xp: 4, yp: 63, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 11, yp: 56, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 14, yp: 66, xs: 2, ys: 2, angle: 0, n: 0)
        
        addredsquare2(xp: 24, yp: 53, xs: 2, ys: 2, angle: 0, n: 19)
        addredsquare2(xp: 33, yp: 70, xs: 2, ys: 2, angle: 0, n: 20)
        addredsquare2(xp: 38, yp: 62, xs: 2, ys: 2, angle: 0, n: 21)
        addmAction(xmove: 0, ymove: 9, interval: 1, time: 9, n: 19)
        addmAction(xmove: 0, ymove: -18, interval: 1, time: 19, n: 20)
        addmAction(xmove: -10, ymove: 0, interval: 1, time: 9, n: 21)
        
        addredsquare2(xp: 20, yp: 64, xs: 1, ys: 19, angle: 0, n: 22)
        addrAction(dsita: 90, interval: 0, re: false, time: 8, n: 22)
        
        addredsquare(xp: 33, yp: 72, xs: 7, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 28, yp: 81, xs: 2, ys: 2, angle: 0, n: 25)
        addmAction(xmove: 10, ymove: 0, interval: 1, time: 10, n: 25)

        
        addredsquare2(xp: 27, yp: 88, xs: 2, ys: 2, angle: 0, n: 23)
        addmAction(xmove: 0, ymove: -7, interval: 1, time: 7, n: 23)
        
        addredsquare2(xp: 14, yp: 80, xs: 2, ys: 3, angle: 0, n: 24)
        addrAction4(originx: 9, originy: 81, dsita: 90, interval: 0, re: false, time: 8, n: 24)
        
        addsquare2(xp: 0, yp: 85, xs: 1, ys: 1, angle: -90, n: 0)
        addredsquare(xp: 0, yp: 72, xs: 20, ys: 1, angle: 0, n: 0)
        
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
