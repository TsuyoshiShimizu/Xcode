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
    func abs() -> CGFloat{
        return CGFloat(fabs(Double(self)))
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
    var savex: CGFloat = 0
    var savey: CGFloat = 0
    var zsita: CGFloat = 0
    var savep: CGPoint!
    
//    var gameVC: UIViewController!
    
    var tap: Bool = false
    
    var BFlg: Bool = true
    
    var gzerotimer = Timer()
    
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    var ggflag: Bool = true
    
    var last1:CFTimeInterval!
    var last2:CFTimeInterval!
    var last3:CFTimeInterval!
    var Sensortime:CFTimeInterval!
    var greenflag: Bool = true
    let SensorMoveInterval = 0.05
    let SensorRunDis:CGFloat = 10
    
    var enemymax = 10 //敵の同時出現条件

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
        if Sensortime == nil{
            Sensortime = currentTime
        }
        
        //敵の全滅によるスタージクリアの設定
        if HowToClear != 1 && -10 <= enemyCC && enemyCC <= 0 && goalflag{
            goalflag = false
            gameclear()
        }
        
        //ムーブセンサの基本動作の設定
        if Actionlock == false && pMSBmovefalg{
            let pmdx = body.position.x - playerMoveSensorBlock.position.x
            let pmdy = body.position.y - playerMoveSensorBlock.position.y
            if (pmdx.abs() > ww * 30 || pmdy.abs() > ww * 100) && playerstatas == 1{
              //  standardAction()
            }else if pmdx.abs() > ww * 5 || pmdy.abs() > ww * 5{
                pMSBmovefalg = false
                playerMoveSensorBlock.run(SKAction.moveBy(x: pmdx, y: pmdy, duration: 0.01))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02){
                    self.pMSBmovefalg = true
                }
            }
        }
        
        //格センサの挙動
        let pX = body.position.x
        let pY = body.position.y
        let UP1 = underSensor1.position
        let OP1 = overSensor1.position
        let RP1 = rightSensor1.position
        let LP1 = leftSensor1.position
        let UP2 = underSensor2.position
        let OP2 = overSensor2.position
        let RP2 = rightSensor2.position
        let LP2 = leftSensor2.position
        let UPS = underSensorS.position
        let OPS = overSensorS.position
        let RPS = rightSensorS.position
        let LPS = leftSensorS.position
        if Sensortime + SensorMoveInterval <= currentTime{
            let pzR = body.zRotation
            let Sh:CGFloat = 95 * ww
            let Sw:CGFloat = 20 * ww
            let USP: CGPoint = CGPoint(x:sin(pzR) * Sh + pX, y: -cos(pzR) * Sh + pY)
            let OSP: CGPoint = CGPoint(x:-sin(pzR) * Sh + pX, y: cos(pzR) * Sh + pY)
            let RSP: CGPoint = CGPoint(x:cos(pzR) * Sw + pX, y: sin(pzR) * Sw + pY)
            let LSP: CGPoint = CGPoint(x:-cos(pzR) * Sw + pX, y: -sin(pzR) * Sw + pY)
            let Ud1:CGPoint = CGPoint(x: USP.x - UP1.x, y: USP.y - UP1.y)
            let Od1:CGPoint = CGPoint(x: OSP.x - OP1.x, y: OSP.y - OP1.y)
            let Rd1:CGPoint = CGPoint(x: RSP.x - RP1.x, y: RSP.y - RP1.y)
            let Ld1:CGPoint = CGPoint(x: LSP.x - LP1.x, y: LSP.y - LP1.y)
            let Ud2:CGPoint = CGPoint(x: USP.x - UP2.x, y: USP.y - UP2.y)
            let Od2:CGPoint = CGPoint(x: OSP.x - OP2.x, y: OSP.y - OP2.y)
            let Rd2:CGPoint = CGPoint(x: RSP.x - RP2.x, y: RSP.y - RP2.y)
            let Ld2:CGPoint = CGPoint(x: LSP.x - LP2.x, y: LSP.y - LP2.y)
            let UdS:CGPoint = CGPoint(x: USP.x - UPS.x, y: USP.y - UPS.y)
            let OdS:CGPoint = CGPoint(x: OSP.x - OPS.x, y: OSP.y - OPS.y)
            let RdS:CGPoint = CGPoint(x: RSP.x - RPS.x, y: RSP.y - RPS.y)
            let LdS:CGPoint = CGPoint(x: LSP.x - LPS.x, y: LSP.y - LPS.y)
            underSensor1.run(SKAction.moveBy(x: Ud1.x, y: Ud1.y, duration: SensorMoveInterval))
            overSensor1.run(SKAction.moveBy(x: Od1.x, y: Od1.y, duration: SensorMoveInterval))
            rightSensor1.run(SKAction.moveBy(x: Rd1.x, y: Rd1.y, duration: SensorMoveInterval))
            leftSensor1.run(SKAction.moveBy(x: Ld1.x, y: Ld1.y, duration: SensorMoveInterval))
            underSensor1.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            overSensor1.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            rightSensor1.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            leftSensor1.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            underSensor2.run(SKAction.moveBy(x: Ud2.x, y: Ud2.y, duration: SensorMoveInterval))
            overSensor2.run(SKAction.moveBy(x: Od2.x, y: Od2.y, duration: SensorMoveInterval))
            rightSensor2.run(SKAction.moveBy(x: Rd2.x, y: Rd2.y, duration: SensorMoveInterval))
            leftSensor2.run(SKAction.moveBy(x: Ld2.x, y: Ld2.y, duration: SensorMoveInterval))
            underSensor2.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            overSensor2.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            rightSensor2.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            leftSensor2.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            underSensorS.run(SKAction.moveBy(x: UdS.x, y: UdS.y, duration: SensorMoveInterval))
            overSensorS.run(SKAction.moveBy(x: OdS.x, y: OdS.y, duration: SensorMoveInterval))
            rightSensorS.run(SKAction.moveBy(x: RdS.x, y: RdS.y, duration: SensorMoveInterval))
            leftSensorS.run(SKAction.moveBy(x: LdS.x, y: LdS.y, duration: SensorMoveInterval))
            underSensorS.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            overSensorS.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            rightSensorS.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            leftSensorS.run(SKAction.rotate(toAngle: pzR, duration: SensorMoveInterval))
            Sensortime = currentTime
        }
        //格センサの作動、停止の設定
        let underdis1 = distance(p1: UPS, p2: UP1)
        let overdis1 = distance(p1: OPS, p2: OP1)
        let rightdis1 = distance(p1: RPS, p2: RP1)
        let leftdis1 = distance(p1: LPS, p2: LP1)
        let underdis2 = distance(p1: UPS, p2: UP2)
        let overdis2 = distance(p1: OPS, p2: OP2)
        let rightdis2 = distance(p1: RPS, p2: RP2)
        let leftdis2 = distance(p1: LPS, p2: LP2)
        if underdis1.abs() > SensorRunDis * ww && Sensorlock == false{
            underSflag1 = true
        }else if underdis1.abs() <= SensorRunDis * ww{
            underSflag1 = false
        }
        if underdis2.abs() > SensorRunDis * ww {
            underSflag2 = true
        }else if underdis1.abs() <= SensorRunDis * ww{
            underSflag2 = false
        }
        if overdis1.abs() > SensorRunDis * ww && Sensorlock == false{
            overSflag1 = true
        }else if overdis1.abs() <= SensorRunDis * ww{
            overSflag1 = false
        }
        if overdis2.abs() > SensorRunDis * ww {
            overSflag2 = true
        }else if overdis1.abs() <= SensorRunDis * ww{
            overSflag2 = false
        }
        if rightdis1.abs() > SensorRunDis * ww && Sensorlock == false{
            rightSflag1 = true
        }else if rightdis1.abs() <= SensorRunDis * ww{
            rightSflag1 = false
        }
        if rightdis2.abs() > SensorRunDis * ww {
            rightSflag2 = true
        }else if rightdis1.abs() <= SensorRunDis * ww{
            rightSflag2 = false
        }
        if leftdis1.abs() > SensorRunDis * ww && Sensorlock == false{
            leftSflag1 = true
        }else if leftdis1.abs() <= SensorRunDis * ww{
            leftSflag1 = false
        }
        if leftdis2.abs() > SensorRunDis * ww{
            leftSflag2 = true
        }else if leftdis1.abs() <= SensorRunDis * ww{
            leftSflag2 = false
        }
        
        //姿勢の計算
        let pangle = (Int(abs(Double(body.zRotation / psita))) % 360) / 17
        if pangle <= 10{
            playerPosture = pangle
        }else{
            playerPosture = 21 - pangle
        }
        
        //プレイヤー傾き方向の計算
        if body.zRotation >= 0{
            playerSlope = false
        }else{
            playerSlope = true
        }
        //詰み防止用
        if playerpx == nil{
            playerpx = body.position.x
        }
        if playerpy == nil{
            playerpy = body.position.y
        }
        
        // デバック用
        if debugON{
            if playerPosture != ap{
                ap = playerPosture
                let anglelabel = SKLabelNode(text: String(playerPosture))
                anglelabel.fontSize = 50
                anglelabel.fontColor = .red
                anglelabel.position = CGPoint(x: body.position.x , y: body.position.y + ww * 100)
                addChild(anglelabel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    anglelabel.removeFromParent()
                }
            }
            if playerstatas != pstatas{
                pstatas = playerstatas
                let pslabel = SKLabelNode(text: String(playerstatas))
                pslabel.fontSize = 100
                pslabel.fontColor = .blue
                pslabel.position = CGPoint(x: body.position.x, y: body.position.y - ww * 200)
                addChild(pslabel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                    pslabel.removeFromParent()
                }
            }
            
            if playerPosture >= 4 && playerPosture <= 6{
                if PDfalg{
                    PDfalg = false
                    let PDlabel = SKLabelNode(text: String(playerSlope))
                    PDlabel.fontSize = 100
                    PDlabel.fontColor = .green
                    PDlabel.position = CGPoint(x: body.position.x + ww * 100, y: body.position.y)
                    addChild(PDlabel)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4){
                        PDlabel.removeFromParent()
                    }
                }
            }else{
                PDfalg = true
            }
        }
        // ここまで
        
        //敵の出現について
        if epcount > 0{//敵を出現させるか
            for n in 0..<epcount{
                let dxe = enemyp[n].x - body.position.x //敵のプレイヤーの距離（x）
                let dye = enemyp[n].y - body.position.y //敵のプレイヤーの距離（y）
                //プレイヤーが敵出現地点にどれくらい近づいたら出現させるかの定義
                if dxe.abs() < h / 10 * 8 && dye.abs() < h / 2{
                    if enemyflag[n] && enemynmax[n] > enemynpre[n] && EE && enemy.count <= enemymax {//敵を出現させる条件
                        EE = false
                        enemyflag[n] = false //これ以上敵出現を禁止
                        enemynpre[n] += 1
                        AppearEnemy(ep: enemyp[n], etype: enemyNumber[n], edre: enemydirection[n], epnumber: n, eHP: enemypHP[n], eDame: enemypDamage[n])
                        DispatchQueue.main.asyncAfter(deadline: .now() + enemyInterval[n]){
                            self.enemyflag[n] = true
                        }
                    }
                }
            }
        }
        
        //出現している敵について
        if ecount > 0{//敵が出現しているかの判定
            //プレイヤーが敵から一定距離離れたときの消去について
            for n in 1...ecount{
                let pedisx = enemy[n].position.x - body.position.x
                let pedisy = enemy[n].position.y - body.position.y
                if pedisx.abs() > h * 1.5 || pedisy.abs() > h * 1.5{
                    if EE == false || enemyActionflag[n] == false{break}
                    EE = false
                    enemydelete(kill: false, number: n)
                    break
                }
            }
        }
        
        
        //ゲームオーバー処理
        if playerHP <= 0 && ggflag{
            ggflag = false
            gameover()
        }

        //足のセンサー稼働時
        if underSflag1 || underSflag2{
            //稼働開始時のみ動作
            if undreSfirst{
                undreSfirst = false
                if playerstatas == 2 && playerPosture <= 1 && underSflag1 && underSflag2 == false{//地上状態への変化処理
                    if Actionlock == false{
                        stopAction() //アクション停止
                        playerBSpositionreset()
                    }
                }
            }
            //センサー稼働時常時動作
            wallflag[1] = true
            wallp = [playerMoveSensorBlock.position.x , playerMoveSensorBlock.position.y , body.zRotation]
            if underSflag2{
                if playerstatas == 1{
                    stopAction()
                    playerstatas = 2
                    playerGravityOFF()
                }
                if fallfalg{
                   stopAction()
                    fallfalg = false
                    playerGravityOFF()
                }
            }
        }else{//足のセンサー停止
            if undreSfirst == false{
                undreSfirst = true
                DispatchQueue.main.asyncAfter(deadline: .now() + walltime){
                    if self.underSflag1 == false{self.wallflag[1] = false}
                }
            }
        }
        //頭のセンサー稼働時
        if overSflag1 || overSflag2{
            //稼働開始時のみ動作
            if overSfirst{
                overSfirst = false
            }
            //センサー稼働時常時動作
            wallflag[4] = true
            wallp = [playerMoveSensorBlock.position.x , playerMoveSensorBlock.position.y , body.zRotation]
            if overSflag2{
                if playerstatas == 1{
                    stopAction()
                    playerstatas = 2
                    playerGravityOFF()
                }
                if fallfalg{
                    stopAction()
                    fallfalg = false
                    playerGravityOFF()
                }
            }
        }else{//頭のセンサー停止
            if overSfirst == false{
                overSfirst = true
                DispatchQueue.main.asyncAfter(deadline: .now() + walltime){
                    if self.overSflag1 == false{self.wallflag[4] = false}
                }
            }
        }
        //右手のセンサー稼働時
        if rightSflag1 || rightSflag2{
            //稼働開始時のみ動作
            if rightSfirst{
                rightSfirst = false
            }
            //センサー稼働時常時動作
            //転倒状態での着地処理
            if playerPosture >= 4 && playerPosture <= 6 && playerSlope && rightSflag1 && rightSflag2 == false{
                playerBSpositionreset2()
            }
            //壁衝突時に歩くのをストップする
            if playerstatas == 1 && playerPosture <= 1 && rightmovelock == false && Actionlock == false{
                rightmovelock = true
                stopAction()
            }
            wallflag[2] = true
            wallp = [playerMoveSensorBlock.position.x , playerMoveSensorBlock.position.y , body.zRotation]
            if rightSflag2{
                if playerstatas == 1{
                    stopAction()
                    playerstatas = 2
                    playerGravityOFF()
                }
                if fallfalg{
                    stopAction()
                    fallfalg = false
                    playerGravityOFF()
                }
            }
            
        }else{//右手のセンサー停止
            if rightSfirst == false{
                rightSfirst = true
                DispatchQueue.main.asyncAfter(deadline: .now() + walltime){
                    if self.rightSflag1 == false{self.wallflag[2] = false}
                }
            }
                Rsfalg = true
                rightmovelock = false
        }
        //左手のセンサー稼働時
        if leftSflag1 || leftSflag2{
            //稼働開始時のみ動作
            if leftSfirst{
                leftSfirst = false
            }
            //センサー稼働時常時動作
            if playerPosture >= 4 && playerPosture <= 6 && playerSlope == false && leftSflag1 && leftSflag2 == false{
                playerBSpositionreset2()
            }
            if playerstatas == 1 && playerPosture <= 1 && leftmovelock == false && Actionlock == false{
                leftmovelock = true
                stopAction()
            }
            wallflag[3] = true
            wallp = [playerMoveSensorBlock.position.x , playerMoveSensorBlock.position.y , body.zRotation]
            if leftSflag2{
                if playerstatas == 1{
                    stopAction()
                    playerstatas = 2
                    playerGravityOFF()
                }
                if fallfalg{
                    stopAction()
                    fallfalg = false
                    playerGravityOFF()
                }
            }
        }else{//左手のセンサー停止
            if leftSfirst == false{
                leftSfirst = true
                DispatchQueue.main.asyncAfter(deadline: .now() + walltime){
                    if self.leftSflag1 == false{self.wallflag[3] = false}
                }
            }
            Lsfalg = true
            leftmovelock = false
        }
        //着地状態時の処理
        if playerstatas == 1{
            if landingfirst {//変化時のみの処理
                landingfirst = false
                airfirst = true
                airrightposible = false
                airleftposible = false
                airrightflag = false
                airleftflag = false
        //        body.physicsBody?.mass = 0.005
                pmxflag = true
                if fallfalg{
                    fallfalg = false
                    standardAction()
                }
            }
            
            let pdx = body.position.x - playerblockSensor.position.x
            let pdy = body.position.y - playerblockSensor.position.y
            if pmxflag{ //センサーブロックの地上での動作
                pmxflag = false
                let pbAction = SKAction.moveBy(x: pdx, y: 0, duration: 0.05)
                let lastAction = SKAction.run {
                    self.pmxflag = true
                }
                playerblockSensor.run(SKAction.sequence([pbAction,lastAction]))
            }
            
            if Actionlock == false{
                if pmyflag{ // センサーブロックが落下した場合の動作
                    if pdy > ww * 20{
                        pmyflag = false
                        let psxAction = SKAction.move(to: playerblockSensor.position, duration: 0.1)
                        let psrAction = SKAction.rotate(toAngle: playerblockSensor.zPosition, duration: 0.1, shortestUnitArc: true)
                        body.run(SKAction.group([psxAction,psrAction]))
                        playerGravityON()
                        if Actionlock == false{
                            stopAction()
                        }
                        playerstatas = 2
                    }
                }
            }
        }
        
        // 空中状態時の処理
        if playerstatas == 2{
            if airfirst{ //変化時のみ有効
                airfirst = false
                landingfirst = true
                airrightposible = true
                airleftposible = true
                Airjointanglemovement()
                body.physicsBody?.mass = airmass
                airPhysicsStatas()
            }
        }
        
        //ヘッドセンサ稼働により、鎌フックアクションが使用可能な時
        /*
        if headkamahookfirst{
            headkamahookfirst = false
            playerxxsave = playerSensor.position.x
            playeryysave = playerSensor.position.y
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.headkamahookflag = false
            }
        }
 */
        
        if Actionlock == false{
        if airrightflag{
            if airrightposible{
                airrightposible = false
                Rairmove()
            }
        }
        if airleftflag{
            if airleftposible{
                airleftposible = false
                Lairmove()
            }
        }
            
        if walk01exflag{//歩く動作(遅い)の実行フラグ有効時の処理
            if walk01posible{
                walk01posible = false//歩く動作(遅い)の受け付けを無効にする
                if runposible == false{//走る動作が受付可能でない場合（実行中の場合）
                    stopAction()
                }
                if walk02posible{//歩く動作(速い)が受付可能の場合
                    walkAction(time: 0.3)//右に歩く動作(遅い)の実行
                }else{//歩く動作(速い)が受付可能でない場合（実行中の場合）
                    walk02posible = true //歩く動作(速い)の受け付けを有効にする
                    speeddown()
                }
            }
        }
        if walk02exflag{//歩く動作(速い)の実行フラグ有効時の処理
            if walk02posible{
                walk02posible = false//歩く動作(速い)の受け付けを無効にする
                if runposible == false{//走る動作が受付可能でない場合（実行中の場合）
                    stopAction()
                }
                if walk01posible{//歩く動作(遅い)が実行中ではない場合の処理
                    walkAction(time: 0.15)//右に歩く動作(速い)の実行
                }else{
                    walk01posible = true
                    speedup()
                }
            }
        }
        if runexflag{
            if runposible{
                runposible = false
                if walk01posible == false || walk02posible == false{
                    stopAction()
                }
                runAction(time: 0.2)
            }
        }
        }
    
        if last1 + 1.0 <= currentTime{
            //ここ1.0秒起きに行う処理を定義
            //詰み防止の為のセンサ処理
            let ppdx = body.position.x - playerpx
            let ppdy = body.position.y - playerpy
            if ppdx.abs() < ww * 1 && ppdy.abs() < ww * 1{
                if Sensorlock == false{
                    if playerPosture == 0{
                        underSflag1 = true
                    }
                    if playerPosture == 5 && playerSlope{
                        rightSflag1 = true
                    }
                    
                    if playerPosture == 5 && playerSlope == false{
                        leftSflag1 = true
                    }
                }
                if Actionlock == false{
                    if playerPosture != 0 && playerPosture != 5{
                        playerBSpositionreset()
                    }
                }
            }
            playerpx = body.position.x
            playerpy = body.position.y
            //詰み防止コードはここまで
            //ここまで
            last1 = currentTime
        }

        
        if last2 + 2 <= currentTime{
            //ここに2秒起きに行う処理を定義
        
            //ここまで
            last2 = currentTime
        }
        if last3 + 3 <= currentTime{
            //ここに3秒起きに行う処理を定義
          
            //ここまで
            last3 = currentTime
        }
    }
//衝突処理
    func didBegin(_ contact: SKPhysicsContact) {
        var enemybody: SKPhysicsBody!
        var damageObject: SKPhysicsBody!
        var itemObject: SKPhysicsBody!
        if (contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == goalCategory)
        || (contact.bodyA.categoryBitMask == goalCategory && contact.bodyB.categoryBitMask == playerCategory){
            if goalflag{
                goalflag = false
                gameclear()
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == damageCategory)
            || (contact.bodyA.categoryBitMask == damageCategory && contact.bodyB.categoryBitMask == playerCategory){
            if playerDamageflag && playerDamageflag2{
                playerDamageflag2 = false
                if contact.bodyA.categoryBitMask == damageCategory{damageObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == damageCategory{damageObject = contact.bodyB}
                let damage = Int(damageObject.mass)
                playerDamageA(Damage: damage)
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == damage2Category)
            || (contact.bodyA.categoryBitMask == damage2Category && contact.bodyB.categoryBitMask == playerCategory){
            if playerDamageflag && playerDamageflag2{
                playerDamageflag2 = false
                if contact.bodyA.categoryBitMask == damage2Category{damageObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == damage2Category{damageObject = contact.bodyB}
                let damage = Int(damageObject.mass)
                playerDamageA(Damage: damage)
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == doorCategory)
            || (contact.bodyA.categoryBitMask == doorCategory && contact.bodyB.categoryBitMask == playerCategory){
            if doorCflag == true{
                doorCflag = false
                if contact.bodyA.categoryBitMask == doorCategory{itemObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == doorCategory{itemObject = contact.bodyB}
                for n in 0 ..< doorSprite.count{ if doorSprite[n] == itemObject.node{ doorAction(Number: n) ;break } }
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == itemCategory)
            || (contact.bodyA.categoryBitMask == itemCategory && contact.bodyB.categoryBitMask == playerCategory){
            if itemCflag == true{
                itemCflag = false
                if contact.bodyA.categoryBitMask == itemCategory{itemObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == itemCategory{itemObject = contact.bodyB}
                for n in 0 ..< itemSprite.count{ if itemSprite[n] == itemObject.node{ itemAction(Number: n) ;break } }
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == ScrollCategory)
            || (contact.bodyA.categoryBitMask == ScrollCategory && contact.bodyB.categoryBitMask == playerCategory){
            if scrollContactflag == true{
                scrollContactflag = false
                if contact.bodyA.categoryBitMask == ScrollCategory{itemObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == ScrollCategory{itemObject = contact.bodyB}
                ScrollView(body: itemObject)
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == enemyCategory)
            || (contact.bodyA.categoryBitMask == enemyCategory && contact.bodyB.categoryBitMask == playerCategory){
            // プレイヤーがダメージを受ける処理
            if playerDamageflag && playerDamageflag2{
                if contact.bodyA.categoryBitMask == enemyCategory{enemybody = contact.bodyA}
                if contact.bodyB.categoryBitMask == enemyCategory{enemybody = contact.bodyB}
                guard let enemyNode = enemybody.node else {return}
                for n in 1..<ecount + 1{
                    if enemy[n] == enemyNode && EE && enemyDamageflag[n]{  //敵の識別　および　その敵がプレイヤーにダメージを与えるか
                        EE = false
                        playerDamageflag2 = false
                        playerDamageA(eN: n)
                        break
                    }
                }
            }
        }else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == enemy2Category)
            || (contact.bodyA.categoryBitMask == enemy2Category && contact.bodyB.categoryBitMask == playerCategory){
            // プレイヤーがダメージを受ける処理
            if playerDamageflag && playerDamageflag2{
                if contact.bodyA.categoryBitMask == enemy2Category{enemybody = contact.bodyA}
                if contact.bodyB.categoryBitMask == enemy2Category{enemybody = contact.bodyB}
                guard let enemyNode = enemybody.node else {return}
                for n in 1..<ecount + 1{
                    if enemy[n] == enemyNode && EE && enemyDamageflag[n]{  //敵の識別　および　その敵がプレイヤーにダメージを与えるか
                        EE = false
                        playerDamageflag2 = false
                        playerDamageA(eN: n)
                        break
                    }
                }
            }
        }else if(contact.bodyA.categoryBitMask == weaponCategory && contact.bodyB.categoryBitMask == enemyCategory)
            || (contact.bodyA.categoryBitMask == enemyCategory && contact.bodyB.categoryBitMask == weaponCategory){
            //敵にダメージを与える処理
            if AttackDamage > 0{
                if contact.bodyA.categoryBitMask == enemyCategory{enemybody = contact.bodyA}
                if contact.bodyB.categoryBitMask == enemyCategory{enemybody = contact.bodyB}
                guard let enemyNode = enemybody.node else {return}
                for n in 1..<ecount + 1{
                    if enemy[n] == enemyNode && EE && enemyDamageflag[n]{
                        EE = false
                        enemyDamageflag[n] = false
                        enemyDamageA(eN: n)
                        break
                    }
                }
            }
        }else if(contact.bodyA.categoryBitMask == weaponCategory && contact.bodyB.categoryBitMask == enemy2Category)
            || (contact.bodyA.categoryBitMask == enemy2Category && contact.bodyB.categoryBitMask == weaponCategory){
            //敵にダメージを与える処理
            if AttackDamage > 0{
                if contact.bodyA.categoryBitMask == enemy2Category{enemybody = contact.bodyA}
                if contact.bodyB.categoryBitMask == enemy2Category{enemybody = contact.bodyB}
                guard let enemyNode = enemybody.node else {return}
                for n in 1..<ecount + 1{
                    if enemy[n] == enemyNode && EE && enemyDamageflag[n]{
                        EE = false
                        enemyDamageflag[n] = false
                        enemyDamageA(eN: n)
                        break
                    }
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    //衝突処理　ここまで
    
    func gameover() {
        body.physicsBody?.isDynamic = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.isPaused = true
            self.viewnode.GameOver()
        }
    }
    func gameclear(){
        viewnode.GameClear()
        self.isPaused = true
    }

    //ここから画面のタップに関する処理
    //タップ開始時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        savex = touchEvent.location(in: cameraNode).x // タップ開始位置の記憶
        savey = touchEvent.location(in: cameraNode).y / SceneR // タップ開始位置の記憶
        savep = CGPoint(x: savex, y: savey)
        tap = true //タップ、ホールドの判定に使用
        flick = true //フリック判定に使用
        walk01posible = true //歩く動作(遅い)の受け付けを可能にする
        walk02posible = true //歩く動作(速い)の受け付けを可能にする
        runposible = true //走る動作の受け付けを可能にする
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.tap = false //タップフラグをfalseに変更
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.flick = false
        }
    }
    
    //スワイプ時の処理
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let newxp = touchEvent.location(in: self.cameraNode).x //現在の画面に触れている位置の取得
        let newyp = touchEvent.location(in: self.cameraNode).y / SceneR //現在の画面に触れている位置の取得
      //  let newp = CGPoint(x: newxp, y: newyp)
        let pdx = newxp - savex
        let pdy = newyp - savey
   //     let dis = distance(p1: savep, p2: newp)
   //     let Angle = angle(p1: savep, p2: newp)
        if flick == false{ // アクションロック時でも動作可能なスワイプ処理を記入
     
        }
        
        if playerstatas == 1 && Actionlock == false{ //地上動作受付に関する条件
        if flick == false{ //スワイプなら
        if playerPosture <= 3{//プレイヤー姿勢が立ち(多少の傾きもOK)
            if pdx > h / 6 && pdx < h / 6 * 2
                && pdy < w / 6 && pdy > w / -6{//右に歩く(遅い)動作を実行する範囲の定義
                runexflag = false
                walk02exflag = false//歩く動作(速い)の実行フラグを無効にする
                if playerdirection && rightmovelock == false{
                    walk01exflag = true//歩く動作(遅い)の実行フラグを有効にする
                }else if playerdirection == false{
                    trunAction()
                }
            }
            if pdx > h / 6 * 2 && pdx < h / 6 * 3 &&
                pdy < w / 6 && pdy > w / -6{//右に歩く(速い)動作を実行する範囲をて定義
                runexflag = false
                walk01exflag = false//歩く動作(遅い)の実行フラグを無効にする
                if playerdirection && rightmovelock == false{
                    walk02exflag = true//歩く動作(速い)の実行フラグを有効にする
                }else if playerdirection == false{
                    trunAction()
                }
            }
            if pdx > h / 6 * 3
            && pdy < w / 6 && pdy > self.w / -6{
                walk01exflag = false
                walk02exflag = false
                if playerdirection && rightmovelock == false{
                    runexflag = true
                }else if playerdirection == false{
                    trunAction()
                }
            }
            if pdx < h / -6 && pdx > h / -6 * 2
                && pdy < w / 6 && pdy > w / -6{//左に歩く(遅い)動作を実行する範囲の定義
                runexflag = false
                walk02exflag = false//歩く動作(速い)の実行フラグを無効にする
                if playerdirection{
                    trunAction()
                }else if leftmovelock == false{
                    walk01exflag = true//歩く動作(遅い)の実行フラグを有効にする
                }
            }
            if pdx < h / -6 * 2 && pdx > h / -6 * 3 &&
                pdy < w / 6 && pdy > w / -6{//左に歩く(速い)動作を実行する範囲をて定義
                runexflag = false
                walk01exflag = false//歩く動作(遅い)の実行フラグを無効にする
                if playerdirection{
                    trunAction()
                }else if leftmovelock == false{
                    walk02exflag = true//歩く動作(速い)の実行フラグを有効にする
                }
            }
            if pdx < h / -6 * 3 &&
                pdy < w / 6 && pdy > w / -6{//左に走る動作を実行する範囲をて定義
                walk02exflag = false
                walk01exflag = false
                if playerdirection{
                    trunAction()
                }else if leftmovelock == false{
                    runexflag = true
                }
            }
        }}}
        
       // ジャンプ中の横移動の定義
        if playerstatas == 2 && Actionlock == false && flick == false{
            if pdx > h / 6{
                if airleftflag{
                    airleftflag = false
                    stopAction()
                }
                airrightflag = true
            }else if pdx < -h / 6{
                if airrightflag{
                    airrightflag = false
                    stopAction()
                }
                airleftflag = true
            }else{
                stopAction()
                airrightflag = false
                airleftflag = false
                airrightposible = true
                airleftposible = true
            }
        }
    }
 
    //タップ終了時に実行
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let newxp = touchEvent.location(in: self.cameraNode).x //現在の画面に触れている位置の取得
        let newyp = touchEvent.location(in: self.cameraNode).y / SceneR //現在の画面に触れている位置の取得
        let newp = CGPoint(x: newxp, y: newyp)
        
        let disr = distance(p1: savep, p2: newp)
        let Angle = angle(p1: savep, p2: newp)
        let tdx = newxp - savex
        let tdy = newyp - savey
        var avoideD  = false
        var avoideD2 = false
        if Angle >= 0{ avoideD  = true }
        if newxp >= 0{ avoideD2 = true }
        //アクションロック時でも動作可能
        if tap && tdx.abs() < h / 10 && tdy.abs() < h / 10{ //タップ時の実行処理を記入
            //地上強攻撃実行フラグ
            if AttackComboAccess[1]{AttackCombofalg[1] = true}
            //地上強攻撃後の回避アクションフラグ
            if AttackComboAccess[5]{
                if avoideD2 {AttackCombofalg[4] = true} else {AttackCombofalg[5] = true}
            }
        }else if flick || tap{//フリックの実行処理
            //空中強攻撃アクションの実行
            if disr.abs() > h / 4  && (AttackComboAccess[3] == true || airAttackHit[airAN] > 0) && playerstatas == 2 &&
                underSflag1 == false && rightSflag1 == false && leftSflag1 == false && overSflag1 == false{
                if AttackComboAccess[3] == true{
                    AttackComboAccess[3] = false
                    airAttackAction02(Angle: Angle)
                }
                if AttackComboAccess[3] == false && airAttackHit[airAN] > 0{
                    if airAttackplay[airAN]{
                        airAttackAngle = Angle
                        AttackCombofalg[3] = true
                    }else{
                        airAttackAction02(Angle: Angle)
                    }
                }
            }
        }
        //アクションロック時でも動作可能はここまで
        
        
        if Actionlock == false{//アクションロック有効時は動作しない
        if tap && tdx.abs() < h / 10 && tdy.abs() < h / 10{ //タップ時の実行処理を記入
            //起きあがりアクション
            if playerPosture >= 4 && playerPosture <= 6 && playerstatas == 1 && (rightSflag1 || leftSflag1){ //転倒時の起き上がり処理
                 wakeupAction()
            }
            //地上弱攻撃アクションの実行
            if playerstatas == 1 && playerPosture <= 2 && AttackComboAccess[0]{ // 地上
                Actionlock = true
                AttackComboAccess[0] = false
                attack01Action()
                DispatchQueue.main.asyncAfter(deadline: .now() + AttackIntervalTime[0]){
                    self.AttackComboAccess[0] = true
                }
            }
            //空中弱攻撃アクションの実行
            if playerstatas == 2 && AttackComboAccess[2]{
                AttackComboAccess[2] = false
                Sensorlock = true
                airAttackAction01()
                DispatchQueue.main.asyncAfter(deadline: .now() + AttackIntervalTime[1]){
                    self.AttackComboAccess[2] = true
                }
            }
        }else if flick || tap{//フリックの実行処理
            if playerstatas == 1 && playerPosture <= 2{//地上かつ立ち姿勢
                if tdy > h / 3{ // ジャンプアクションの実行
                    jumpAction(Dis: distance(p1:savep , p2: newp), Angle: angle(p1: savep, p2: newp))
                }
            }
            //回避アクション
            if playerstatas == 1{
                if tdx.abs() > h / 4 && tdy.abs() < h / 3{
                    Actionlock = true
                    avoidAction(avoideD: avoideD)
                }
            }
            //ウォールアクションの使用
            if playerstatas == 2 && (wallflag[1] || wallflag[2] || wallflag[3] || wallflag[4]) && disr.abs() > w / 6 {
                wallAction(Dis: disr, Angle: angle(p1: savep, p2: newp), flag: wallflag)
            }
            //落下アクションの使用
            else if playerstatas == 2 && (Angle / psita).abs() < 15 && disr.abs() > w / 6 {
                let rotateA = SKAction.rotate(toAngle: 0, duration: 0.1)
                body.run(rotateA)
                playerGravityON()
                fallfalg = true
            }
        }else{//スワイプの実行処理
            //歩く、走る動作を行った後の処理
            walk01exflag = false // 歩く(遅い)動作のフラグを無効にする
            walk02exflag = false // 歩く(速い)動作のフラグを無効にする
            runexflag = false
            if playerstatas == 1{
                stopAction()//プレイヤーのステータスを地上(動作なし)に変更
                if playerPosture <= 3{
                   standardAction()
                }
            }//ここまで
          
            //空中移動を行った後の処理
            if playerstatas == 2{
                airrightflag = false
                airleftflag = false
                airleftposible = true
                airrightposible = true
            }//ここまで
        }
        }
    }
    
    override func didSimulatePhysics() {
        var Cpoint = body.position
        if Cpoint.x <= w / 2     { Cpoint.x = w / 2}
        if Cpoint.x >= w * 7 / 2 { Cpoint.x = w * 7 / 2  }
        if Cpoint.y <= h / 2     { Cpoint.y = h / 2}
        if Cpoint.y >= h * 7 / 2 { Cpoint.y = h * 7 / 2 }
        let moveAction = SKAction.move(to: Cpoint, duration: 0.5)
        cameraNode.run(moveAction)
    }
    
    func ScrollView(body:SKPhysicsBody){
        let textN = Int(body.mass)
        body.node?.removeFromParent()
        scrollContactflag = true
        viewnode.discriptionChangeN(disN: textN, display: true)
        self.isPaused = true
    }

}
