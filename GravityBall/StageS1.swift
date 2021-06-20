//
//  Stage05.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/05.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

class stageS1: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag101")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        contact()
        let ws = frame.size.width
        let hs2 = frame.size.height
        let ys = hs2 / h2
        let hs = h * ys
        let background = SKSpriteNode(imageNamed: "bg01")
        background.position = CGPoint(x: ws / 2, y: hs / 2)
        background.size = CGSize(width: ws, height: hs)
        addChild(background)
        if middleflagrevel == 0{
            ballx = 2
            bally = 5
            addmiddleflag1(xp: 1, yp: 43)
            addmiddleflag2(xp: 32, yp: 74)
        }else if middleflagrevel == 1{
            ballx = 1
            bally = 43
            addmiddleflag2(xp: 32, yp: 74)
        }else if middleflagrevel == 2{
            ballx = 32
            bally = 74
        }
        let stagen: Int = 101
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
        
        //ボール作成
        addball(xbp: ballx, ybp: bally, balln: 0)
        //ゴール作成
        addgoal(xp: 17, yp: 93, n: 0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 34, yp: 54,n:0)
        }
        
        addsquare2(xp: 0, yp: 3, xs: 1, ys: 1, angle: 0, n: 0)
        
        addchain2(xp: 5, yp: 4,tate: true, chaincount: 5, contactlevel: 0, n1: 2, n2: 1)
        addchain2(xp: 9, yp: 4,tate: true, chaincount: 5, contactlevel: 0, n1: 4, n2: 3)
        addsquare(xp: 5, yp: 9, xs: 5, ys: 1, angle: 0, n: 5)
        addsquare2(xp: 5, yp: 3, xs: 1, ys: 1, angle: 90, n: 6)
        adddina(n: 6)
        
        addcahinjoint(chainpx: 5, chainpy: 8, jointpx: 5, jointpy: 9, chainn: 1, objectn: 5)
        addcahinjoint(chainpx: 9, chainpy: 8, jointpx: 9, jointpy: 9, chainn: 3, objectn: 5)
        addcahinjoint(chainpx: 5, chainpy: 4, jointpx: 5, jointpy: 3, chainn: 2, objectn: 6)
        addcahinjoint(chainpx: 8, chainpy: 7, jointpx: 9, jointpy: 7, chainn: 4, objectn: 6)
        
        addredsquare(xp: 0, yp: 13, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 13, xs: 13, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 0, xs: 2, ys: 5, angle: 0, n: 0)
        addredsquare(xp: 30, yp: 9, xs: 2, ys: 5, angle: 0, n: 0)
        addredsquare(xp: 33, yp: 10, xs: 1, ys: 5, angle: 0, n: 0)
        addsquare(xp: 39, yp: 12, xs: 1, ys: 9, angle: 0, n: 0)
        addsquare(xp: 34, yp: 20, xs: 5, ys: 1, angle: 0, n: 0)
        addmAction(xmove: 25, ymove: 0, interval: 5, time: 10, n: 5)
        
        addredsquare(xp: 19, yp: 14, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 4, yp: 49, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 24, yp: 49, xs: 16, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 9, yp: 23, xs: 1, ys: 26, angle: 0, n: 0)
        
        addsquare2(xp: 29, yp: 17, xs: 1, ys: 1, angle: 0, n: 7)
        adddina(n: 7)
        addchain(xp: 31, yp: 24,sita: 270, chaincount: 8, contactlevel:0, n1: 8)
        addchain(xp: 31, yp: 24,sita: 270, chaincount: 8, contactlevel: 0, n1: 9)
        addcahinjoint(chainpx: 33, chainpy: 18, jointpx: 33, jointpy: 17, chainn: 8, objectn: 7)
        addcahinjoint(chainpx: 30, chainpy: 21, jointpx: 29, jointpy: 21, chainn: 9, objectn: 7)
        
        addchain(xp: 31, yp: 35,sita: 270, chaincount: 8, contactlevel: 0, n1: 10)
        addchain(xp: 31, yp: 35,sita: 270, chaincount: 8, contactlevel: 0, n1: 11)
        addsquare2(xp: 33, yp: 31, xs: 1, ys: 1, angle: 180, n: 12)
        addcahinjoint(chainpx: 36, chainpy: 31, jointpx: 37, jointpy: 31, chainn: 10, objectn: 12)
        addcahinjoint(chainpx: 33, chainpy: 34, jointpx: 33, jointpy: 35, chainn: 11, objectn: 12)
        adddina(n: 12)
        
        addchain(xp: 20, yp: 38,sita: 0, chaincount: 8, contactlevel: 0, n1: 13)
        addchain(xp: 20, yp: 38,sita: 0, chaincount: 8, contactlevel: 0, n1: 14)
        addsquare2(xp: 23, yp: 35, xs: 1, ys: 1, angle: 90, n: 15)
        addcahinjoint(chainpx: 23, chainpy: 36, jointpx: 23, jointpy: 35, chainn: 13, objectn: 15)
        addcahinjoint(chainpx: 26, chainpy: 39, jointpx: 27, jointpy: 39, chainn: 14, objectn: 15)
        adddina(n: 15)
        
        addchain(xp: 13, yp: 29,sita: 90, chaincount: 8, contactlevel: 0, n1: 16)
        addchain(xp: 13, yp: 29,sita: 90, chaincount: 8, contactlevel: 0, n1: 17)
        addsquare2(xp: 13, yp: 30, xs: 1, ys: 1, angle: 90, n: 18)
        addcahinjoint(chainpx: 13, chainpy: 31, jointpx: 13, jointpy: 30, chainn: 16, objectn: 18)
        addcahinjoint(chainpx: 16, chainpy: 34, jointpx: 17, jointpy: 34, chainn: 17, objectn: 18)
        adddina(n: 18)
        
        addchain(xp: 13, yp: 21,sita: 0, chaincount: 6, contactlevel: 0, n1: 19)
        addchain(xp: 13, yp: 21,sita: 0, chaincount: 6, contactlevel: 0, n1: 20)
        addsquare2(xp: 13, yp: 17, xs: 1, ys: 1, angle: 0, n: 21)
        addcahinjoint(chainpx: 14, chainpy: 21, jointpx: 13, jointpy: 21, chainn: 19, objectn: 21)
        addcahinjoint(chainpx: 17, chainpy: 18, jointpx: 17, jointpy: 17, chainn: 20, objectn: 21)
        adddina(n: 21)
        
        addchain(xp: 8, yp: 21,sita: 270, chaincount: 6, contactlevel: 0, n1: 22)
        addchain(xp: 8, yp: 21,sita: 270, chaincount: 6, contactlevel: 0, n1: 23)
        addsquare2(xp: 4, yp: 16, xs: 1, ys: 1, angle: 0, n: 24)
        addcahinjoint(chainpx: 5, chainpy: 20, jointpx: 4, jointpy: 20, chainn: 22, objectn: 24)
        addcahinjoint(chainpx: 8, chainpy: 17, jointpx: 8, jointpy: 16, chainn: 23, objectn: 24)
        adddina(n: 24)
        
        addchain(xp: 10, yp: 30,sita: 180, chaincount: 8, contactlevel: 0, n1: 25)
        addchain(xp: 10, yp: 30,sita: 180, chaincount: 8, contactlevel: 0, n1: 26)
        addsquare2(xp: 3, yp: 28, xs: 1, ys: 1, angle: -90, n: 27)
        addcahinjoint(chainpx: 4, chainpy: 28, jointpx: 3, jointpy: 28, chainn: 25, objectn: 27)
        addcahinjoint(chainpx: 7, chainpy: 31, jointpx: 7, jointpy: 32, chainn: 26, objectn: 27)
        adddina(n: 27)
    
     
        
        addsquare(xp: 0, yp: 37, xs: 1, ys: 17, angle: 0, n: 0)
        addsquare(xp: 1, yp: 42, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 5, yp: 47, xs: 4, ys: 1, angle: 0, n: 0)
        addsquare(xp: 8, yp: 44, xs: 1, ys: 3, angle: 0, n: 0)
        
        /*
        addsquare2(xp: 0, yp: 54, xs: 1, ys: 1, angle: -90, n: 28)
        adddina(n: 28)
        addjointPoint(jointxp: 8, jointyp: 58, n: 28)
    
        addsquare2(xp: 11, yp: 56, xs: 1, ys: 1, angle: 0, n: 29)
        adddina(n: 29)
        addjointPoint(jointxp: 16, jointyp: 57, n: 29)
        */


        addsquare2(xp: 0, yp: 54, xs: 1, ys: 1, angle: -90, n: 28)
        addsquare2(xp: 12, yp: 58, xs: 1, ys: 1, angle: 90, n: 30)
        addrAction4(originx: 8, originy: 58, dsita: -360, interval: 0, re: false, time: 10, n: 28)
        addrAction4(originx: 8, originy: 58, dsita: -360, interval: 0, re: false, time: 10, n: 30)
        
        addsquare2(xp: 13, yp: 61, xs: 1, ys: 1, angle: -90, n: 32)
        addsquare2(xp:19, yp: 51, xs: 1, ys: 1, angle: 90, n: 34)
        addrAction4(originx: 18, originy: 58, dsita: 360, interval: 0, re: false, time: 10, n: 32)
        addrAction4(originx: 18, originy: 58, dsita: 360, interval: 0, re: false, time: 10, n: 34)

        addsquare2(xp: 18, yp: 55, xs: 1, ys: 1, angle: -90, n: 37)
        addsquare2(xp: 34, yp: 63, xs: 1, ys: 1, angle: 90, n: 39)
        addrAction4(originx: 28, originy: 61, dsita: -360, interval: 0, re: false, time: 10, n: 37)
        addrAction4(originx: 28, originy: 61, dsita: -360, interval: 0, re: false, time: 10, n: 39)

        
        
        addredsquare(xp: 8, yp: 55, xs: 1, ys: 7, angle: 0, n: 0)
        addredsquare(xp: 28, yp: 56, xs: 1, ys: 11, angle: 0, n: 0)
   
        addsquare(xp: 36, yp: 76, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 39, yp: 63, xs: 1, ys: 14, angle: 0, n: 0)
        
        addredsquare(xp: 0, yp: 72, xs: 20, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 20, yp: 72, xs: 16, ys: 1, angle: 0, n: 0)

        addsquare(xp: 19, yp: 73, xs: 17, ys: 1, angle: 0, n: 0)
        addredsquare(xp: 24, yp: 77, xs: 12, ys: 1, angle: 0, n: 0)
        
        addsquare4(xp: 15, yp: 74, xs: 1, ys: 1, angle: 0, n: 40)
        addchain(xp: 19.5, yp: 93, sita: 270, chaincount: 15, contactlevel: 0, n1: 41)
        adddina(n: 40)
        addrinvalid(n: 40)
        addcahinjoint(chainpx: 19.5, chainpy: 79, jointpx: 19.5, jointpy: 78, chainn: 41, objectn: 40)

 
        addredsquare(xp: 16, yp: 83, xs: 8, ys: 6, angle: 0, n: 0)
        addredsquare(xp: 10, yp: 89, xs: 6, ys: 9, angle: 0, n: 0)
        addredsquare(xp: 16, yp: 98, xs: 8, ys: 6, angle: 0, n: 0)
        
        addredcircle3(xp: 10, yp: 98, xs: 6, ys: 6, mirror: false, angle: 0, n: 0)
        addredcircle3(xp: 24, yp: 98, xs: 6, ys: 6, mirror: true, angle: 0, n: 0)
        addredcircle3(xp: 10, yp: 83, xs: 6, ys: 6, mirror: true, angle: 180, n: 0)
        addredcircle3(xp: 24, yp: 83, xs: 6, ys: 6, mirror: false, angle: 180, n: 0)
        
        addbluesquare7(xp: 25, yp: 78, xs: 1, ys: 5, angle: 0, n: 0)

        addsquare(xp: 15, yp: 89, xs: 1, ys: 9, angle: 0, n: 0)

        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode

    }
}
