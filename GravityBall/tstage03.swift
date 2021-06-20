//
//  tstage03.swift
//  gravity
//
//  Created by 清水健志 on 2018/09/26.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class tstage03: GameController{
    override func didMove(to view: SKView){
        contact()
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
        addball(xbp:3,ybp:2,balln:0)
        //ゴール作成
        addgoal(xp: 35, yp: 1 ,n:0)
        
        addsquare(xp: 0, yp: 0, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 7, yp: 0, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 1, yp: 0, xs: 6, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 0, yp: 16, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 17, yp: 16, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 1, yp: 17, xs: 16, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 10, yp: 0, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 27, yp: 0, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 11, yp: 0, xs: 16, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 20, yp: 16, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 39, yp: 16, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 21, yp: 17, xs: 18, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 30, yp: 0, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 39, yp: 0, xs: 1, ys: 2, angle: 0, n: 0)
        addsquare(xp: 31, yp: 0, xs: 8, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 8, yp: 0, xs: 2, ys: 14, angle: 0, n: 0)
        addredsquare(xp: 18, yp: 4, xs: 2, ys: 14, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 0, xs: 2, ys: 14, angle: 0, n: 0)
        
        //カメラ作成
        cameraNode.position = ball.position
        cameraNode.xScale = 1
        cameraNode.yScale = 1
        addChild(cameraNode)
        camera = cameraNode
    }
    
    override func gameclear() {
        ball.physicsBody?.isDynamic = false
        clearbgm.run(playAction)
        if spaceplayer.isPlaying{
            spaceplayer.stop()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.isPaused = true
            UserDefaults.standard.set(true, forKey: "clear")
        }
    }
    
    override func gameover() {
        let xx = w / 10
        ball.physicsBody?.isDynamic = false
        let moveA = SKAction.move(to: CGPoint(x: xx * 4, y: xx * 2.5), duration: 0.9)
        ball.run(moveA)
        sita = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.ggflag = true
            self.ball.physicsBody?.isDynamic = true
        }
    }
}


