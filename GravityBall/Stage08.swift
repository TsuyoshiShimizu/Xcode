//
//  Stage08.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/16.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stage08: GameController{
    override func didMove(to view: SKView){
        contact()
        let stagen: Int = 8
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
        
        addball(xbp:10,ybp:21,balln:0)
        addgoal(xp: 6, yp: 7, n: 12)
        addcoin(xp: 1, yp: 21, n: 0)
        
        addsquare(xp: 9, yp: 20, xs: 3, ys: 1, angle: 0, n: 3)
        addsquare(xp: 11, yp: 21, xs: 1, ys: 1, angle: 0, n: 4)
        
        addsquare3(xp: 6, yp: 19, xs: 1, ys: 1, angle: 0, n: 1)
        addsquare3(xp: 6, yp: 19, xs: 1, ys: 1, angle: 180, n: 2)
  
        addsquare2(xp: 0, yp: 20, xs: 1, ys: 1, angle: 0, n: 5)
        
        addoutAction(interval: 20, time: 0, n: 3)
        addoutAction(interval: 20, time: 0, n: 4)
        addoutAction(interval: 20, time: 0, n: 5)
        
        addmAction4(xmove: 0, ymove: 3, ininterval: 0, intime: 5, moveinterval: 0, mtime: 5, outinterval: 90, outtime: 5, n: 1)
        addmAction4(xmove: 0, ymove: 3, ininterval: 0, intime: 5, moveinterval: 0, mtime: 5, outinterval: 90, outtime: 5, n: 2)
        
        addmAction3(xmove: 16, ymove: 3, interval1: 10, interval2: 93, time: 2, n: 1)
        addmAction3(xmove: 16, ymove: 3, interval1: 10, interval2: 93, time: 2, n: 2)
        addmAction3(xmove: 16, ymove: -2, interval1: 12, interval2: 91, time: 5, n: 1)
        addmAction3(xmove: 16, ymove: -2, interval1: 12, interval2: 91, time: 5, n: 2)
        addmAction3(xmove: 20, ymove: -2, interval1: 17, interval2: 89, time: 2, n: 1)
        addmAction3(xmove: 20, ymove: -2, interval1: 17, interval2: 89, time: 2, n: 2)
        addmAction3(xmove: 20, ymove: 5, interval1: 19, interval2: 86, time: 3, n: 1)
        addmAction3(xmove: 20, ymove: 5, interval1: 19, interval2: 86, time: 3, n: 2)
        addmAction3(xmove: 20, ymove: -18, interval1: 24, interval2: 81, time: 3, n: 1)
        addmAction3(xmove: 20, ymove: -18, interval1: 24, interval2: 81, time: 3, n: 2)
        addmAction3(xmove: 24, ymove: -8, interval1: 28, interval2: 75, time: 5, n: 1)
        addmAction3(xmove: 24, ymove: -8, interval1: 28, interval2: 75, time: 5, n: 2)
        addrAction3(dsita: 180, interval1: 33, interval2: 70, time: 5, n: 1)
        addrAction3(dsita: 180, interval1: 33, interval2: 70, time: 5, n: 2)
        addmAction3(xmove: 24, ymove: -15, interval1: 38, interval2: 67, time: 3, n: 1)
        addmAction3(xmove: 24, ymove: -15, interval1: 38, interval2: 67, time: 3, n: 2)
        addrAction3(dsita: 135, interval1: 41, interval2: 62, time: 5, n: 1)
        addrAction3(dsita: 135, interval1: 41, interval2: 62, time: 5, n: 2)
        addmAction3(xmove: 12, ymove: -8, interval1: 41, interval2: 62, time: 5, n: 1)
        addmAction3(xmove: 12, ymove: -8, interval1: 41, interval2: 62, time: 5, n: 2)
        addrAction3(dsita: 180, interval1: 46, interval2: 57, time: 5, n: 1)
        addrAction3(dsita: 180, interval1: 46, interval2: 57, time: 5, n: 2)
        addmAction3(xmove: 0, ymove: -19, interval1: 46, interval2: 57, time: 5, n: 1)
        addmAction3(xmove: 0, ymove: -19, interval1: 46, interval2: 57, time: 5, n: 2)
        addmAction3(xmove: -3, ymove: -19, interval1: 51, interval2: 52, time: 5, n: 1)
        addmAction3(xmove: -3, ymove: -19, interval1: 51, interval2: 52, time: 5, n: 2)
        addmAction3(xmove: -3, ymove: 3, interval1: 56, interval2: 42, time: 10, n: 1)
        addmAction3(xmove: -3, ymove: 3, interval1: 56, interval2: 42, time: 10, n: 2)
        addmAction3(xmove: -3, ymove: 7, interval1: 67, interval2: 36, time: 5, n: 1)
        addmAction3(xmove: -3, ymove: 7, interval1: 67, interval2: 36, time: 5, n: 2)
        addmAction3(xmove: 17, ymove: 7, interval1: 72, interval2: 26, time: 10, n: 1)
        addmAction3(xmove: 17, ymove: 7, interval1: 72, interval2: 26, time: 10, n: 2)
        addmAction3(xmove: 17, ymove: -2, interval1: 82, interval2: 21, time: 5, n: 1)
        addmAction3(xmove: 17, ymove: -2, interval1: 82, interval2: 21, time: 5, n: 2)
        addmAction3(xmove: -3, ymove: -2, interval1: 87, interval2: 11, time: 10, n: 1)
        addmAction3(xmove: -3, ymove: -2, interval1: 87, interval2: 11, time: 10, n: 2)
        addmAction3(xmove: -3, ymove: -17, interval1: 97, interval2: 5, time: 6, n: 1)
        addmAction3(xmove: -3, ymove: -17, interval1: 97, interval2: 5, time: 6, n: 2)
        
        addredsquare(xp: 26, yp: 20, xs: 3, ys: 10, angle: 0, n: 0)
        addredsquare(xp: 26, yp: 30, xs: 3, ys: 4, angle: 0, n: 0)
        
        addredsquare(xp: 32, yp: 12, xs: 3, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 26, yp: 3, xs: 10, ys: 3, angle: 0, n: 0)
        addredsquare(xp: 18, yp: 7, xs: 3, ys: 3, angle: 0, n: 0)
        
        addredsquare(xp: 2, yp: 13, xs: 4, ys: 10, angle: 0, n: 6)
        addredsquare(xp: 2, yp: 23, xs: 4, ys: 2, angle: 0, n: 7)
        addredsquare(xp: 10, yp: 13, xs: 4, ys: 10, angle: 0, n: 8)
        addredsquare(xp: 10, yp: 23, xs: 4, ys: 2, angle: 0, n: 9)
        addredsquare(xp: 2, yp: 29, xs: 4, ys: 6, angle: 0, n: 10)
        addredsquare(xp: 10, yp: 29, xs: 4, ys: 6, angle: 0, n: 11)
        addinAction(interval: 20, time: 0, n: 6)
        addinAction(interval: 20, time: 0, n: 7)
        addinAction(interval: 20, time: 0, n: 8)
        addinAction(interval: 20, time: 0, n: 9)
        addinAction(interval: 20, time: 0, n: 10)
        addinAction(interval: 20, time: 0, n: 11)
        
        addinAction(interval: 80, time: 0, n: 12)

        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
