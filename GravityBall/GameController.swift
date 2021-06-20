//
//  GameController.swift
//  gravity
//
//  Created by 清水健志 on 2018/07/28.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation
import CoreMotion
extension Double{
    func cgf() -> CGFloat{
        return CGFloat(self)
    }
    func root() -> Double{
        return pow(self , 0.5)
    }
    func squ() -> Double{
        return self * self
    }
}
extension CGFloat{
    func dou() -> Double{
        return Double(self)
    }
    func root() -> CGFloat{
        return CGFloat(pow(Double(self),0.5))
    }
    func squ() -> CGFloat{
        return self * self
    }
}

extension Int{
    func dou() -> Double{
        return Double(self)
    }
    func cgf() -> CGFloat{
        return CGFloat(self)
    }
}


class GameController: Action,SKPhysicsContactDelegate{
//    let motionManager = CMMotionManager()
    let cameraNode = SKCameraNode()
    var savey: CGFloat = 0
    var zsita: CGFloat = 0
    
//    var gameVC: UIViewController!
    
    var touch: Bool = false
    var gzero: Bool = false
    
    let smoke = SKEmitterNode(fileNamed: "smoke")
    
    var BFlg: Bool = true
    
    var gzerotimer = Timer()
    
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    
    var moveActionx: SKAction!
    var moveActiony: SKAction!
    var rotatoAction: SKAction!
    
    var ggflag: Bool = true
    
    var last1:CFTimeInterval!
    var last2:CFTimeInterval!
    var last3:CFTimeInterval!
    var greenflag: Bool = true
    
//    let syurikenbgm = SKAudioNode.init(fileNamed: "斬撃音０２.mp3" )
//    var syuri2flag: Bool = false

/*
    func motion(){
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!) {(data, _) in
            guard let data = data else {return}
            let yaw =  data.attitude.yaw
            self.zsita = CGFloat(yaw * 180.0 / .pi)
        }
    }
 */
    func disr(objA:CGPoint , objB:CGPoint) -> CGFloat{
        let dx = objA.x - objB.x
        let dy = objA.y - objB.y
        return (dx.squ() + dy.squ()).root()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if last1 == nil{
            last1 = currentTime
        }
        if last2 == nil{
            last2 = currentTime
        }
        if last3 == nil{
            last3 = currentTime
        }
        
        if last1 + 1 <= currentTime{
            //ここに1秒起きに行う処理を定義
            /*
            if appearancecount != 0{
                for n in 1...appearancecount{
                    let r = disr(objA: ball.position, objB: CGPoint(x: appeax[n], y: appeay[n]))
                    if r < appeardis[n]{
                        let objectA: SKSpriteNode!
                        let objectB: SKSpriteNode!
                        if objectcount == 0{
                            objectA = appearanceActuon[n-1]
                            objectB = appearanceActuon[n-1]
                        }else{
                            objectA = appearobject[objectcount-1]
                            objectB = appearobject[objectcount-1]
                        }
                        appearobject.append(objectB)
                        objectB.position.x = appeax[n]
                        objectB.position.y = appeay[n]
                        addChild(objectA)
                        objectcount += 1
                    }
             
             }
        */
            //ここまで
            last1 = currentTime
        }

        
        if last2 + 2 <= currentTime{
            //ここに2秒起きに行う処理を定義
            //ballとの距離が一定以上になると元の位置に戻る
            if repcount != 0{
                for n in 1...repcount{
                    let balldx = abs(ball.position.x - repAction[n - 1].position.x)
                    let balldy = abs(ball.position.y - repAction[n - 1].position.y)
                    if balldx > dis[n] || balldy > dis[n]{
                        let returnpositionAction = SKAction.move(to: CGPoint(x: repx[n], y: repy[n]), duration: 0.0)
                        repAction[n-1].run(returnpositionAction)
                    }
                }
            }
            //ここまで
            last2 = currentTime
        }
        if last3 + 3 <= currentTime{
            //ここに3秒起きに行う処理を定義
            if syurin != 0{
                for n in 1...syurin{
                    let r = disr(objA: ball.position, objB: CGPoint(x: syuripx[n], y: syuripx[n]))
                    if r < w{
                        addsyurikens(n: n , r: r)
                    }
                }
            }
            //ここまで
            last3 = currentTime
        }
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == goalCategory)
        || (contact.bodyA.categoryBitMask == goalCategory && contact.bodyB.categoryBitMask == ballCategory){
                gameclear()
        }else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == redblockCategory)
            || (contact.bodyA.categoryBitMask == redblockCategory && contact.bodyB.categoryBitMask == ballCategory){
            if ggflag{
                ggflag = false
                gameover()
            }
        }else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == redblockCategory2)
            || (contact.bodyA.categoryBitMask == redblockCategory2 && contact.bodyB.categoryBitMask == ballCategory){
            if ggflag{
                ggflag = false
                gameover()
            }
        }else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == bulletCategory)
            || (contact.bodyA.categoryBitMask == bulletCategory && contact.bodyB.categoryBitMask == ballCategory){
            if ggflag{
                ggflag = false
                gameover()
            }
        }else if(contact.bodyA.categoryBitMask == blockCategory && contact.bodyB.categoryBitMask == bulletCategory)
            || (contact.bodyA.categoryBitMask == bulletCategory && contact.bodyB.categoryBitMask == blockCategory){
        }else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == coinCategory)
            || (contact.bodyA.categoryBitMask == coinCategory && contact.bodyB.categoryBitMask == ballCategory){
            if coinflag == false{
                coinflag = true
                coins()
            }
        }else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == middleflag1Category)
            || (contact.bodyA.categoryBitMask == middleflag1Category && contact.bodyB.categoryBitMask == ballCategory){
            if middleflag1flag == false{
                middleflag1flag = true
                middleflags1()
            }
        }
        else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == middleflag2Category)
            || (contact.bodyA.categoryBitMask == middleflag2Category && contact.bodyB.categoryBitMask == ballCategory){
            if middleflag2flag == false{
                middleflag2flag = true
                middleflags2()
            }
        }
        else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == middleflag3Category)
            || (contact.bodyA.categoryBitMask == middleflag3Category && contact.bodyB.categoryBitMask == ballCategory){
            if middleflag3flag == false{
                middleflag3flag = true
                middleflags3()
            }
        }else if(contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == greenblockCategory)
            || (contact.bodyA.categoryBitMask == greenblockCategory && contact.bodyB.categoryBitMask == ballCategory)
            || (contact.bodyA.categoryBitMask == greenblockCategory && contact.bodyB.categoryBitMask == blockCategory)
            || (contact.bodyA.categoryBitMask == blockCategory && contact.bodyB.categoryBitMask == greenblockCategory)
            || (contact.bodyA.categoryBitMask == greenblockCategory && contact.bodyB.categoryBitMask == redblockCategory)
            || (contact.bodyA.categoryBitMask == redblockCategory && contact.bodyB.categoryBitMask == greenblockCategory)
        {
            if greenflag{
                greenflag = false
                if greenbgm.isPlaying{
                    greenbgm.pause()
                    greenbgm.currentTime = 0
                }else{
                    greenbgm.currentTime = 0
                }
                greenbgm.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
                    self.greenflag = true
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
    }
    
    
    func gameover() {
        UserDefaults.standard.set(true, forKey: "gameover")
        let fire = SKEmitterNode(fileNamed: "fire")
        ball.physicsBody?.isDynamic = false
        fire?.position = ball.position
        addChild(fire!)
        ballbom.run(playAction)
        if spaceplayer.isPlaying{
            spaceplayer.stop()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.isPaused = true
        }
    }
    
    
    func gameclear(){
        let playstage = UserDefaults.standard.integer(forKey: "playstage")
        var stagestatas = UserDefaults.standard.integer(forKey: "stage\(playstage)statas")
        if stagestatas < 2{
            if coinflag{
                stagestatas = 2
            }else{
                stagestatas = 1
            }
            UserDefaults.standard.set(stagestatas, forKey: "stage\(playstage)statas")
        }
        ball.physicsBody?.isDynamic = false
        clearbgm.run(playAction)
        if spaceplayer.isPlaying{
            spaceplayer.stop()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
        UserDefaults.standard.set(0, forKey: "middleflag\(playstage)")
          UserDefaults.standard.set(true, forKey: "clear")
          self.isPaused = true
        }
    }
    
    private func coins(){
        coinbgm.run(playAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.coin.removeFromParent()
        }
    }
    
    private func middleflags1(){
        let playstage = UserDefaults.standard.integer(forKey: "playstage")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            UserDefaults.standard.set(1, forKey: "middleflag\(playstage)")
        }
        if coinflag{
            UserDefaults.standard.set(true, forKey: "coinflag")
        }
        middleflagbgm1.run(playAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.middleflag1.removeFromParent()
        }
    }
    private func middleflags2(){
        let playstage = UserDefaults.standard.integer(forKey: "playstage")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            UserDefaults.standard.set(2, forKey: "middleflag\(playstage)")
        }
        if coinflag{
            UserDefaults.standard.set(true, forKey: "coinflag")
        }
        middleflagbgm2.run(playAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.middleflag2.removeFromParent()
        }
    }
    private func middleflags3(){
        let playstage = UserDefaults.standard.integer(forKey: "playstage")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            UserDefaults.standard.set(3, forKey: "middleflag\(playstage)")
        }
        if coinflag{
            UserDefaults.standard.set(true, forKey: "coinflag")
        }
        middleflagbgm3.run(playAction)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.middleflag3.removeFromParent()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        savey = touchEvent.location(in: cameraNode).y
        touch = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.touch = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let newy = touchEvent.location(in: cameraNode).y
        if(newy - savey > h / 15){
            sita = sita - 3.0
        }else if(-newy + savey > h / 15){
            sita = sita + 3.0
        }
    }
    
    override func didSimulatePhysics() {
        dx = ball.position.x - cameraNode.position.x
        dy = ball.position.y - cameraNode.position.y
        smoke?.position = ball.position
       
        moveActionx = SKAction.moveTo(x: ball.position.x , duration: 0.5)
        cameraNode.run(moveActionx)
        moveActiony = SKAction.moveTo(y: ball.position.y , duration: 0.5)
        cameraNode.run(moveActiony)

        rotatoAction = SKAction.rotate(toAngle: CGFloat(sita * .pi / 180.0), duration: 0.5)
        cameraNode.run(rotatoAction)
        
        if(gzero == true){
            physicsWorld.gravity = CGVector(dx: 0.1 * sin(sita * .pi / 180.0), dy: -0.1 * cos(sita * .pi / 180.0))
        }else{
            physicsWorld.gravity = CGVector(dx: gra * sin(sita * .pi / 180.0), dy: -gra * cos(sita * .pi / 180.0))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(touch == true && gzero == false){
            gzero = true
            addChild(smoke!)
            spaceplayer.play()
            gzerotimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false){ _ in
                self.gzero = false
                self.smoke?.removeFromParent()
                self.spaceplayer.pause()
                self.spaceplayer.currentTime = 0
            }
        }else if(touch == true && gzero == true){
            gzero = false
            smoke?.removeFromParent()
            spaceplayer.pause()
            spaceplayer.currentTime = 0
            gzerotimer.invalidate()
        }
    }
}
