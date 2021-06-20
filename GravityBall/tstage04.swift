//
//  tstage04.swift
//  gravity
//
//  Created by 清水健志 on 2018/09/26.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class tstage04: GameController{
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
        addball(xbp:2,ybp:2,balln:0)
        //ゴール作成
        addgoal(xp: 33, yp: 7 ,n:0)
        
        addsquare(xp: 0, yp: 0, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 1, yp: 0, xs: 9, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 30, yp: 0, xs: 10, ys: 1, angle: 0, n: 0)
        addsquare(xp: 39, yp: 1, xs: 1, ys: 9, angle: 0, n: 0)
        
        addsquare(xp: 39, yp: 26, xs: 1, ys: 10, angle: 0, n: 0)
        addsquare(xp: 30, yp: 35, xs: 9, ys: 1, angle: 0, n: 0)
        
        addsquare(xp: 0, yp: 35, xs: 10, ys: 1, angle: 0, n: 0)
        addsquare(xp: 0, yp: 26, xs: 1, ys: 9, angle: 0, n: 0)
        addsquare(xp: 0, yp: 5, xs: 8, ys: 1, angle: 0, n: 0)
        addsquare(xp: 0, yp: 6, xs: 1, ys: 7, angle: 0, n: 0)
        addsquare(xp: 31, yp: 5, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 31, yp: 9, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 34, yp: 6, xs: 1, ys: 3, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 4, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 4, xs: 16, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 35, yp: 5, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 35, yp: 25, xs: 1, ys: 7, angle: 0, n: 0)
        
        addredsquare(xp: 4, yp: 31, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 24, yp: 31, xs: 12, ys: 1, angle: 0, n: 0)
        
        addredsquare(xp: 4, yp: 9, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 4, yp: 29, xs: 1, ys: 3, angle: 0, n: 0)
        
        addredsquare(xp: 5, yp: 9, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 25, yp: 9, xs: 6, ys: 1, angle: 0, n: 0)
        
        
        
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
        let moveA = SKAction.move(to: CGPoint(x: xx * 2.5, y: xx * 2.5), duration: 0.9)
        ball.run(moveA)
        sita = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.ggflag = true
            self.ball.physicsBody?.isDynamic = true
        }
    }
}


