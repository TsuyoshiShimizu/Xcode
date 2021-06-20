//
//  StageS3.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/21.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class stageS3: GameController{
    let middleflagrevel = UserDefaults.standard.integer(forKey: "middleflag103")
    let coinflagrevel = UserDefaults.standard.bool(forKey: "coinflag")
    var ballx:Int!
    var bally:Int!
    override func didMove(to view: SKView){
        let ws = frame.size.width
        let hs2 = frame.size.height
        let ys = hs2 / h2
        let hs = h * ys
        let background = SKSpriteNode(imageNamed: "bg03")
        background.position = CGPoint(x: ws / 2, y: hs / 2)
        background.size = CGSize(width: ws, height: hs)
        addChild(background)
        contact()
        var bx: CGFloat = 0
        var by: CGFloat = 0
        var bx2: CGFloat = 0
        var by2: CGFloat = 0
        if middleflagrevel == 0{
            bx = 5
            by = 96
            bx2 = 20
            by2 = 10
            ballx = 1
            bally = 99
            addmiddleflag1(xp: 9, yp: 55)
            addmiddleflag2(xp: 17, yp: 2)
            addmiddleflag3(xp: 17, yp: 61)
        }else if middleflagrevel == 1{
            bx = 6
            by = 53
            bx2 = 20
            by2 = 10
            ballx = 9
            bally = 55
            addmiddleflag2(xp: 17, yp: 2)
            addmiddleflag3(xp: 17, yp: 61)
        }else if middleflagrevel == 2{
            bx = 5
            by = 96
            bx2 = 20
            by2 = 10
            ballx = 17
            bally = 2
            addmiddleflag3(xp: 17, yp: 61)
        }else if middleflagrevel == 3{
            bx = 5
            by = 96
            bx2 = 20
            by2 = 63
            ballx = 17
            bally = 61
        }
        let stagen: Int = 103
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
        addgoal(xp: 28, yp: 105,n:0)
        //トロフィ作成
        if coinflagrevel{
            coinflag = true
        }else{
            addcoin(xp: 1, yp: 2,n:0)
        }
        
        
        //オブジェクト作成
        addsquare2(xp: 0, yp: 97, xs: 1, ys: 1, angle: 0, n: 0)
        
        //気球っぽい物作成
        addbluesquare(xp: bx + 2, yp: by + 8, xs: 3, ys: 1, angle: 0, n: 1)
        addrinvalid(n: 1)
        addredsquare(xp: bx, yp: by + 7, xs: 7, ys: 1, angle: 0, n: 2)
        addredsquare(xp: bx + 1, yp: by + 8, xs: 1, ys: 1, angle: 0, n: 3)
        addredsquare(xp: bx + 5, yp: by + 8, xs: 1, ys: 1, angle: 0, n: 4)
        addredsquare(xp: bx + 2, yp: by + 9, xs: 3, ys: 1, angle: 0, n: 5)
        addredsquare(xp: bx + 3, yp: by + 10, xs: 1, ys: 1, angle: 0, n: 6)
        adddina(n: 2)
        adddina(n: 3)
        adddina(n: 4)
        adddina(n: 5)
        adddina(n: 6)
        addjointObject2(objectAn: 1, objectBn: 2)
        addjointObject2(objectAn: 1, objectBn: 3)
        addjointObject2(objectAn: 1, objectBn: 4)
        addjointObject2(objectAn: 1, objectBn: 5)
        addjointObject2(objectAn: 1, objectBn: 6)
        addchain2(xp: bx, yp: by + 2, tate: true, chaincount: 5, contactlevel: 0, n1: 7, n2: 8)
        addchain2(xp: bx + 6, yp: by + 2, tate: true, chaincount: 5, contactlevel: 0, n1: 9, n2: 10)
        
        addsquare(xp: bx, yp: by + 1, xs: 1, ys: 1, angle: 0, n: 11)
        addsquare(xp: bx + 6, yp: by + 1, xs: 1, ys: 1, angle: 0, n: 12)
        addsquare(xp: bx, yp: by, xs: 7, ys: 1, angle: 0, n: 13)
        addjointObject2(objectAn: 11, objectBn: 13)
        addjointObject2(objectAn: 12, objectBn: 13)
        adddina(n: 11)
        adddina(n: 12)
        adddina(n: 13)
        changeblueCategory(n: 11)
        changeblueCategory(n: 12)
        changeblueCategory(n: 13)
        
        addcahinjoint(chainpx: bx, chainpy: by + 6, jointpx: bx, jointpy: by + 7, chainn: 8, objectn: 2)
        addcahinjoint(chainpx: bx + 6, chainpy: by + 6, jointpx: bx + 6, jointpy: by + 7, chainn: 10, objectn: 2)
        addcahinjoint(chainpx: bx, chainpy: by + 2, jointpx: bx, jointpy: by + 1, chainn: 7, objectn: 11)
        addcahinjoint(chainpx: bx + 6, chainpy: by + 2, jointpx: bx + 6, jointpy: by + 1, chainn: 9, objectn: 12)
        //ここまで
        
        
        addredsquare(xp: 15, yp: 6, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 26, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 46, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 66, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 86, xs: 1, ys: 20, angle: 0, n: 0)
        addredsquare(xp: 15, yp: 106, xs: 1, ys: 1, angle: 0, n: 0)
        
        
        addredsquare2(xp: 4, yp: 89, xs: 11, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 0, yp: 84, xs: 11, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 0, yp: 79, xs: 3, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 8, yp: 79, xs: 7, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 1, yp: 74, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 6, yp: 74, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 3, yp: 68, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 8, yp: 66, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 1, yp: 63, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 12, yp: 72, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 10, yp: 60, xs: 2, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 13, yp: 65, xs: 2, ys: 2, angle: 0, n: 0)
        
        addredsquare2(xp: 0, yp: 56, xs: 7, ys: 1, angle: 0, n: 0)
        addredsquare2(xp: 12, yp: 56, xs: 3, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 0, yp: 48, xs: 7, ys: 1, angle: 0, n: 14)
        addredsquare2(xp: 8, yp: 48, xs: 7, ys: 1, angle: 0, n: 15)
        addrAction(dsita: -90, interval: 0, re: false, time: 10, n: 14)
        addrAction(dsita: 90, interval: 0, re: false, time: 10, n: 15)
        
        addredsquare2(xp: 4, yp: 39, xs: 2, ys: 2, angle: 0, n: 16)
        addredsquare2(xp: 12, yp: 34, xs: 2, ys: 2, angle: 0, n: 17)
        addrAction4(originx: 4.5, originy: 34.5, dsita: 90, interval: 0, re: false, time: 2, n: 16)
        addrAction4(originx: 8.5, originy: 34.5, dsita: -90, interval: 0, re: false, time: 2, n: 17)

        
        addredsquare(xp: 0, yp: 22, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 8, yp: 14, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare(xp: 0, yp: 6, xs: 7, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 13, yp: 18, xs: 2, ys: 2, angle: 0, n: 20)
        addredsquare2(xp: 0, yp: 10, xs: 2, ys: 2, angle: 0, n: 21)
        addmAction(xmove: -13, ymove: 0, interval: 0, time: 8, n: 20)
        addmAction(xmove: 13, ymove: 0, interval: 0, time: 8, n: 21)

        addsquare2(xp: 15, yp: 0, xs: 1, ys: 1, angle: 90, n: 0)
        addsquare(xp: 16, yp: 6, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 17, yp: 9, xs: 3, ys: 1, angle: 0, n: 0)
        
        //気球っぽい物作成
        addbluesquare(xp: bx2 + 3, yp: by2 - 8, xs: 1, ys: 1, angle: 0, n: 22)
        addredsquare(xp: bx2, yp: by2 - 7, xs: 7, ys: 1, angle: 0, n: 23)
        addredsquare(xp: bx2 + 1, yp: by2 - 8, xs: 2, ys: 1, angle: 0, n: 24)
        addredsquare(xp: bx2 + 4, yp: by2 - 8, xs: 2, ys: 1, angle: 0, n: 25)
        addredsquare(xp: bx2 + 2, yp: by2 - 9, xs: 3, ys: 1, angle: 0, n: 26)
        addjointObject2(objectAn: 22, objectBn: 23)
        addjointObject2(objectAn: 22, objectBn: 24)
        addjointObject2(objectAn: 22, objectBn: 25)
        addjointObject2(objectAn: 22, objectBn: 26)
        adddina(n: 23)
        adddina(n: 24)
        adddina(n: 25)
        adddina(n: 26)
        
        addchain2(xp: bx2, yp: by2 - 6, tate: true, chaincount: 5, contactlevel: 0, n1: 27, n2: 28)
        addchain2(xp: bx2 + 6, yp: by2 - 6, tate: true, chaincount: 5, contactlevel: 0, n1: 29, n2: 30)
        
        addsquare(xp: bx2, yp: by2 - 1, xs: 1, ys: 1, angle: 0, n: 31)
        addsquare(xp: bx2 + 6, yp: by2 - 1, xs: 1, ys: 1, angle: 0, n: 32)
        addsquare(xp: bx2, yp: by2, xs: 7, ys: 1, angle: 0, n: 33)
        addjointObject2(objectAn: 31, objectBn: 33)
        addjointObject2(objectAn: 32, objectBn: 33)
        adddina(n: 31)
        adddina(n: 32)
        adddina(n: 33)
        changeblueCategory(n: 31)
        changeblueCategory(n: 32)
        changeblueCategory(n: 33)
        addrinvalid(n: 22)
        
        addcahinjoint(chainpx: bx2, chainpy: by2 - 6, jointpx: bx2, jointpy: by2 - 7, chainn: 27, objectn: 23)
        addcahinjoint(chainpx: bx2 + 6, chainpy: by2 - 6, jointpx: bx2 + 6, jointpy: by2 - 7, chainn: 29, objectn: 23)
        addcahinjoint(chainpx: bx2, chainpy: by2 - 2, jointpx: bx2, jointpy: by2 - 1, chainn: 28, objectn: 31)
        addcahinjoint(chainpx: bx2 + 6, chainpy: by2 - 2, jointpx: bx2 + 6, jointpy: by2 - 1, chainn: 30, objectn: 32)
        //ここまで
        
        addredsquare(xp: 21, yp: 17, xs: 4, ys: 2, angle: 0, n: 33)
        addrAction(dsita: 90, interval: 0, re: false, time: 5, n: 33)
        
        addredsquare2(xp: 16, yp: 23, xs: 4, ys: 2, angle: 0, n: 0)
        addredsquare2(xp: 26, yp: 23, xs: 4, ys: 2, angle: 0, n: 0)
        
        addredsquare(xp: 16, yp: 28, xs: 7, ys: 2, angle: 0, n: 0)
        
        addredsquare2(xp: 16, yp: 34, xs: 10, ys: 1, angle: 0, n: 34)
        addredsquare2(xp: 20, yp: 42, xs: 10, ys: 1, angle: 0, n: 35)
        addredsquare2(xp: 16, yp: 49, xs: 10, ys: 1, angle: 0, n: 36)
        addrAction(dsita: 90, interval: 0, re: false, time: 7, n: 34)
        addrAction(dsita: -90, interval: 0, re: false, time: 7, n: 35)
        addrAction(dsita: 90, interval: 0, re: false, time: 7, n: 36)
        
        addredsquare2(xp: 16, yp: 57, xs: 3, ys: 2, angle: 0, n: 37)
        addredsquare2(xp: 27, yp: 57, xs: 3, ys: 2, angle: 0, n: 38)
        addmAction(xmove: 5, ymove: 0, interval: 0, time: 5, n: 37)
        addmAction(xmove: 5, ymove: 0, interval: 0, time: 5, n: 38)
        
        addsquare(xp: 16, yp: 59, xs: 1, ys: 4, angle: 0, n: 0)
        addsquare(xp: 17, yp: 59, xs: 3, ys: 1, angle: 0, n: 0)
        addsquare(xp: 17, yp: 62, xs: 3, ys: 1, angle: 0, n: 0)
        
        addredsquare2(xp: 16, yp: 67, xs: 3, ys: 2, angle: 0, n: 39)
        addredsquare2(xp: 16, yp: 69, xs: 3, ys: 2, angle: 0, n: 40)
        addredsquare2(xp: 16, yp: 71, xs: 3, ys: 2, angle: 0, n: 41)
        addredsquare2(xp: 16, yp: 73, xs: 3, ys: 2, angle: 0, n: 42)
        addredsquare2(xp: 16, yp: 75, xs: 3, ys: 2, angle: 0, n: 43)
        addmAction4(xmove: 4, ymove: 0, ininterval: 0, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 39)
        addmAction4(xmove: 4, ymove: 0, ininterval: 1, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 40)
        addmAction4(xmove: 4, ymove: 0, ininterval: 2, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 41)
        addmAction4(xmove: 4, ymove: 0, ininterval: 3, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 42)
        addmAction4(xmove: 4, ymove: 0, ininterval: 4, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 43)
        addredsquare2(xp: 16, yp: 77, xs: 3, ys: 2, angle: 0, n: 49)
        addredsquare2(xp: 16, yp: 79, xs: 3, ys: 2, angle: 0, n: 50)
        addredsquare2(xp: 16, yp: 81, xs: 3, ys: 2, angle: 0, n: 51)
        addredsquare2(xp: 16, yp: 83, xs: 3, ys: 2, angle: 0, n: 52)
        addredsquare2(xp: 16, yp: 85, xs: 3, ys: 2, angle: 0, n: 53)
        addmAction4(xmove: 4, ymove: 0, ininterval: 5, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 49)
        addmAction4(xmove: 4, ymove: 0, ininterval: 6, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 50)
        addmAction4(xmove: 4, ymove: 0, ininterval: 7, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 51)
        addmAction4(xmove: 4, ymove: 0, ininterval: 8, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 52)
        addmAction4(xmove: 4, ymove: 0, ininterval: 9, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 53)
        
        addredsquare2(xp: 27, yp: 67, xs: 3, ys: 2, angle: 0, n: 44)
        addredsquare2(xp: 27, yp: 69, xs: 3, ys: 2, angle: 0, n: 45)
        addredsquare2(xp: 27, yp: 71, xs: 3, ys: 2, angle: 0, n: 46)
        addredsquare2(xp: 27, yp: 73, xs: 3, ys: 2, angle: 0, n: 47)
        addredsquare2(xp: 27, yp: 75, xs: 3, ys: 2, angle: 0, n: 48)
        addmAction4(xmove: -4, ymove: 0, ininterval: 5, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 44)
        addmAction4(xmove: -4, ymove: 0, ininterval: 6, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 45)
        addmAction4(xmove: -4, ymove: 0, ininterval: 7, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 46)
        addmAction4(xmove: -4, ymove: 0, ininterval: 8, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 47)
        addmAction4(xmove: -4, ymove: 0, ininterval: 9, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 48)
        addredsquare2(xp: 27, yp: 77, xs: 3, ys: 2, angle: 0, n: 54)
        addredsquare2(xp: 27, yp: 79, xs: 3, ys: 2, angle: 0, n: 55)
        addredsquare2(xp: 27, yp: 81, xs: 3, ys: 2, angle: 0, n: 56)
        addredsquare2(xp: 27, yp: 83, xs: 3, ys: 2, angle: 0, n: 57)
        addredsquare2(xp: 27, yp: 85, xs: 3, ys: 2, angle: 0, n: 58)
        addmAction4(xmove: -4, ymove: 0, ininterval: 10, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 54)
        addmAction4(xmove: -4, ymove: 0, ininterval: 11, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 55)
        addmAction4(xmove: -4, ymove: 0, ininterval: 12, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 56)
        addmAction4(xmove: -4, ymove: 0, ininterval: 13, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 57)
        addmAction4(xmove: -4, ymove: 0, ininterval: 14, intime: 1, moveinterval: 0, mtime: 4, outinterval: 0, outtime: 0, nexttime: 5, n: 58)
        
        
        addredsquare2(xp: 16, yp: 103, xs: 1, ys: 1, angle: 0, n: 59)
        addredsquare2(xp: 17, yp: 103, xs: 1, ys: 1, angle: 0, n: 60)
        addredsquare2(xp: 18, yp: 103, xs: 1, ys: 1, angle: 0, n: 61)
        addredsquare2(xp: 19, yp: 103, xs: 1, ys: 1, angle: 0, n: 62)
        addredsquare2(xp: 20, yp: 103, xs: 1, ys: 1, angle: 0, n: 63)
        addredsquare2(xp: 21, yp: 103, xs: 1, ys: 1, angle: 0, n: 64)
        addredsquare2(xp: 22, yp: 103, xs: 1, ys: 1, angle: 0, n: 65)
        addredsquare2(xp: 23, yp: 103, xs: 1, ys: 1, angle: 0, n: 66)
        addredsquare2(xp: 24, yp: 103, xs: 1, ys: 1, angle: 0, n: 67)
        addredsquare2(xp: 25, yp: 103, xs: 1, ys: 1, angle: 0, n: 68)
        addmAction4(xmove: 0, ymove: -13, ininterval: 0, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 59)
        addmAction4(xmove: 0, ymove: -13, ininterval: 1, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 60)
        addmAction4(xmove: 0, ymove: -13, ininterval: 2, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 61)
        addmAction4(xmove: 0, ymove: -13, ininterval: 3, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 62)
        addmAction4(xmove: 0, ymove: -13, ininterval: 4, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 63)
        addmAction4(xmove: 0, ymove: -13, ininterval: 5, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 64)
        addmAction4(xmove: 0, ymove: -13, ininterval: 6, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 65)
        addmAction4(xmove: 0, ymove: -13, ininterval: 7, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 66)
        addmAction4(xmove: 0, ymove: -13, ininterval: 8, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 67)
        addmAction4(xmove: 0, ymove: -13, ininterval: 9, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 68)
        
        addredsquare2(xp: 29, yp: 103, xs: 1, ys: 1, angle: 0, n: 69)
        addredsquare2(xp: 28, yp: 103, xs: 1, ys: 1, angle: 0, n: 70)
        addredsquare2(xp: 27, yp: 103, xs: 1, ys: 1, angle: 0, n: 71)
        addredsquare2(xp: 26, yp: 103, xs: 1, ys: 1, angle: 0, n: 72)
        addredsquare2(xp: 25, yp: 103, xs: 1, ys: 1, angle: 0, n: 73)
        addredsquare2(xp: 24, yp: 103, xs: 1, ys: 1, angle: 0, n: 74)
        addredsquare2(xp: 23, yp: 103, xs: 1, ys: 1, angle: 0, n: 75)
        addredsquare2(xp: 22, yp: 103, xs: 1, ys: 1, angle: 0, n: 76)
        addredsquare2(xp: 21, yp: 103, xs: 1, ys: 1, angle: 0, n: 77)
        addredsquare2(xp: 20, yp: 103, xs: 1, ys: 1, angle: 0, n: 78)
        addmAction4(xmove: 0, ymove: -13, ininterval: 11, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 69)
        addmAction4(xmove: 0, ymove: -13, ininterval: 12, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 70)
        addmAction4(xmove: 0, ymove: -13, ininterval: 13, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 71)
        addmAction4(xmove: 0, ymove: -13, ininterval: 14, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 72)
        addmAction4(xmove: 0, ymove: -13, ininterval: 15, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 73)
        addmAction4(xmove: 0, ymove: -13, ininterval: 16, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 74)
        addmAction4(xmove: 0, ymove: -13, ininterval: 17, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 75)
        addmAction4(xmove: 0, ymove: -13, ininterval: 18, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 76)
        addmAction4(xmove: 0, ymove: -13, ininterval: 19, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 77)
        addmAction4(xmove: 0, ymove: -13, ininterval: 20, intime: 1, moveinterval: 0, mtime: 13, outinterval: 0, outtime: 0, nexttime: 8, n: 78)
        
        
        cameraNode.position = ball.position
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0
        addChild(cameraNode)
        camera = cameraNode
    }
}
