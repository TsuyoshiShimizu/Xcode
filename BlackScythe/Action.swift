//
//  Action.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/27.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
class Action:object{
//    var rightlegAction: SKAction!
//    var leftlegAction: SKAction!
//    var allmoveAction: SKAction!
    
    func itemAction(Number n:Int){
        let type = itemtype[n]
        let item = itemSprite[n]
        if type == 1{
            if playerstatas == 2{ body.physicsBody?.mass = 0.1 }
            airmass = 0.08
            item.physicsBody?.categoryBitMask = 0
            item.physicsBody?.collisionBitMask = 0
            item.alpha = 0
            item1BGM.run(SKAction.play())
        }else if type == 2{
            if playerstatas == 2{ body.physicsBody?.mass = 0.03 }
            airmass = 0.03
            item.physicsBody?.categoryBitMask = 0
            item.physicsBody?.collisionBitMask = 0
            item.alpha = 0
            item2BGM.run(SKAction.play())
        }else if type == 3{
            if playerstatas == 2{ body.physicsBody?.mass = 0.001 }
            airmass = 0.004
            item.physicsBody?.categoryBitMask = 0
            item.physicsBody?.collisionBitMask = 0
            item.alpha = 0
            item3BGM.run(SKAction.play())
        }
        self.run(SKAction.wait(forDuration: 1.0)){ self.itemCflag = true }
    }
    
    func doorAction(Number n:Int){
        let mpx = doormoveP[n].x
        let mpy = doormoveP[n].y
        Actionlock = true
        Sensorlock = true
        if mpx == -1 && mpy == -1{ //面移動をする場合
            viewnode.blackout()
            viewnode.stageChange(HP: playerHP)
            return
        }
        viewnode.blackout()
        //プレイヤーを移動する
        playerDamageflag = false
        allChangeisDynamic(false)
        let movetime = 0.2
        let bodyP:[CGFloat] = [0,40]
        let leg1P:[CGFloat] = [-1,-43]
        let leg2P:[CGFloat] = [0,-20]
        let arm1P:[CGFloat] = [-1,35]
        let arm2P:[CGFloat] = [0,52]
        let SensorP:[CGFloat] = [20,95]
        
        let lastAction = SKAction.run {
            self.allChangeisDynamic(true)
            self.doorCflag = true
            self.Sensorlock = false
            self.walk01exflag = false
            self.walk02exflag = false
            self.runexflag = false
            self.standardAction()
            self.run(SKAction.wait(forDuration: 1.0)){ self.playerDamageflag = true }
        }
        let RotateAction = SKAction.rotate(toAngle: 0, duration: movetime)
        let NmoveAction = SKAction.move(to: CGPoint(x: mpx, y: mpy), duration: movetime)
        let bodymoveAction = SKAction.move(to: CGPoint(x: mpx + bodyP[0] * ww, y: mpy + bodyP[1] * ww), duration: movetime)
        let leg1moveAction = SKAction.move(to: CGPoint(x: mpx + leg1P[0] * ww, y: mpy + leg1P[1] * ww), duration: movetime)
        let leg2moveAction = SKAction.move(to: CGPoint(x: mpx + leg2P[0] * ww, y: mpy + leg2P[1] * ww), duration: movetime)
        let arm1moveAction = SKAction.move(to: CGPoint(x: mpx + arm1P[0] * ww, y: mpy + arm1P[1] * ww), duration: movetime)
        let arm2moveAction = SKAction.move(to: CGPoint(x: mpx + arm2P[0] * ww, y: mpy + arm2P[1] * ww), duration: movetime)
        let USmoveAction = SKAction.move(to: CGPoint(x: mpx , y: mpy - SensorP[1] * ww), duration: movetime)
        let OSmoveAction = SKAction.move(to: CGPoint(x: mpx , y: mpy + SensorP[1] * ww), duration: movetime)
        let RSmoveAction = SKAction.move(to: CGPoint(x: mpx + SensorP[0] * ww, y: mpy ), duration: movetime)
        let LSmoveAction = SKAction.move(to: CGPoint(x: mpx - SensorP[0] * ww, y: mpy ), duration: movetime)
        
        var bodyAction = SKAction.group([NmoveAction,RotateAction])
        bodyAction = SKAction.sequence([bodyAction,lastAction])
        let NAction = SKAction.group([NmoveAction,RotateAction])
        let PbodyAction = SKAction.group([bodymoveAction,RotateAction])
        let leg1Action = SKAction.group([leg1moveAction,RotateAction])
        let leg2Action = SKAction.group([leg2moveAction,RotateAction])
        let arm1Action = SKAction.group([arm1moveAction,RotateAction])
        let arm2Action = SKAction.group([arm2moveAction,RotateAction])
        
        playerblockSensor.run(NAction)
        playerMoveSensorBlock.run(NAction)
        underSensor1.run(USmoveAction)
        overSensor1.run(OSmoveAction)
        rightSensor1.run(RSmoveAction)
        leftSensor1.run(LSmoveAction)
        underSensor2.run(USmoveAction)
        overSensor2.run(OSmoveAction)
        rightSensor2.run(RSmoveAction)
        leftSensor2.run(LSmoveAction)
        underSensorS.run(USmoveAction)
        overSensorS.run(OSmoveAction)
        rightSensorS.run(RSmoveAction)
        leftSensorS.run(LSmoveAction)
        leg11.run(leg1Action)
        leg21.run(leg1Action)
        leg12.run(leg2Action)
        leg22.run(leg2Action)
        arm11.run(arm1Action)
        arm21.run(arm1Action)
        kamaL.run(arm1Action)
        kamaR.run(arm1Action)
        arm12.run(arm2Action)
        arm22.run(arm2Action)
        bodyPhysick.run(PbodyAction)
        body.run(bodyAction)
    }
    
    func allChangeisDynamic(_ valid: Bool){
        playerblockSensor.physicsBody?.isDynamic = valid
        playerMoveSensorBlock.physicsBody?.isDynamic = valid
        underSensor1.physicsBody?.isDynamic = valid
        overSensor1.physicsBody?.isDynamic = valid
        rightSensor1.physicsBody?.isDynamic = valid
        leftSensor1.physicsBody?.isDynamic = valid
        underSensor2.physicsBody?.isDynamic = valid
        overSensor2.physicsBody?.isDynamic = valid
        rightSensor2.physicsBody?.isDynamic = valid
        leftSensor2.physicsBody?.isDynamic = valid
        underSensorS.physicsBody?.isDynamic = valid
        overSensorS.physicsBody?.isDynamic = valid
        rightSensorS.physicsBody?.isDynamic = valid
        leftSensorS.physicsBody?.isDynamic = valid
        bodyPhysick.physicsBody?.isDynamic = valid
        body.physicsBody?.isDynamic = valid
        leg11.physicsBody?.isDynamic = valid
        leg12.physicsBody?.isDynamic = valid
        leg21.physicsBody?.isDynamic = valid
        leg22.physicsBody?.isDynamic = valid
        arm11.physicsBody?.isDynamic = valid
        arm12.physicsBody?.isDynamic = valid
        arm21.physicsBody?.isDynamic = valid
        arm22.physicsBody?.isDynamic = valid
        kamaR.physicsBody?.isDynamic = valid
        kamaL.physicsBody?.isDynamic = valid
    }
    
    func airAttackAction02(Angle: CGFloat){
        let alltime = AttackActionTime[3]
        let movedis: CGFloat = 500
        let count = 10
 
        playerDamageflag = false
        Actionlock = true
        Sensorlock = true
        airAN += 1
        if airAN > 2{airAN = 0}
        airAttackplay[airAN] = true
        AttackDamage = 20
        var bodyposition: [[CGFloat]] = [[0,30,-30],[0,30,-30],[0,30,-30],[0,30,-30],[0,30,-30],[0,30,-30]]
        
        let leg1sita:[[CGFloat]] = [[45,-45],[0,-45],[-10,-45],[-20,-45],[-30,-45],[-40,-45]]
        let leg2sita:[[CGFloat]] = [[20,-30],[0,-30],[-5,-30],[-10,-30],[-15,-30],[-20,-30]]
        let arm1sita:[[CGFloat]] = [[90,135],[95,95],[70,70],[45,45],[25,25],[5,5]]
        let arm2sita:[[CGFloat]] = [[90,90],[85,85],[60,60],[35,35],[15,15],[-5,-5]]
        var rotate: [CGFloat] = [-180,-360,-540,-720,-900,-1080]
        
        let lastAction =  SKAction.run {
            self.AttackDamage = 0
            self.airAttackplay[self.airAN] = false
            if self.AttackCombofalg[3]{
                self.AttackCombofalg[3] = false
                self.airAttackAction02(Angle: self.airAttackAngle)
            }else{
                self.Actionlock = false
                self.playerDamageflag = true
                self.run(SKAction.wait(forDuration: 0.3)){
                    self.Sensorlock = false
                }
            }
        }
        
        var leg1position = legposition(legangle: leg1sita, bodyposition: bodyposition)
        var leg2position = legposition(legangle: leg2sita, bodyposition: bodyposition)
        var arm1position = armposition(armangle: arm1sita, bodyposition: bodyposition)
        var arm2position = armposition(armangle: arm2sita, bodyposition: bodyposition)
        for n in 0..<bodyposition.count{
            if playerdirection == false{
                bodyposition[n][0] = -bodyposition[n][0]
                leg1position[n][0] = -leg1position[n][0]
                leg2position[n][0] = -leg2position[n][0]
                arm1position[n][0] = -arm1position[n][0]
                arm2position[n][0] = -arm2position[n][0]
                bodyposition[n][2] = -bodyposition[n][2]
                leg1position[n][2] = -leg1position[n][2]
                leg2position[n][2] = -leg2position[n][2]
                arm1position[n][2] = -arm1position[n][2]
                arm2position[n][2] = -arm2position[n][2]
                rotate[n] = -rotate[n]
            }
        }
        let dX = sin(Angle) * movedis * ww
        let dY = -cos(Angle) * movedis * ww
        //回転するアクションの移動距離を計算
        let bodymove = RotateMove(object: body, position: bodyposition, axismove: nil, count: count, RotatoTo: rotate)
        let leg1move = RotateMove(object: leg11, position: leg1position, axismove: nil, count: count, RotatoTo: rotate)
        let leg2move = RotateMove(object: leg21, position: leg2position, axismove: nil, count: count, RotatoTo: rotate)
        let arm1move = RotateMove(object: arm11, position: arm1position, axismove: nil, count: count, RotatoTo: rotate)
        let arm2move = RotateMove(object: arm21, position: arm2position, axismove: nil, count: count, RotatoTo: rotate)
        
        //アクションの実行時間を計算
        let ActionCount = count * bodyposition.count
        let time1 = alltime / Double(ActionCount)
        let time = [Double](repeating: time1, count: ActionCount)
        
        //アクションの実行
        playerMoveSensorBlock.run(SKAction.moveBy(x: dX, y: dY, duration: alltime))
        PlayToAction(move: leg1move, dischange: false, moveing: true, object: self.leg11, lastAction: nil, time: time)
        PlayToAction(move: leg2move, dischange: false, moveing: true, object: self.leg21, lastAction: nil, time: time)
        PlayToAction(move: arm1move, dischange: false, moveing: true, object: self.arm11, lastAction: nil, time: time)
        PlayToAction(move: arm2move, dischange: false, moveing: true, object: self.arm21, lastAction: nil, time: time)
        PlayToAction(move: bodymove, dischange: false, moveing: true, object: self.body, lastAction: lastAction, time: time)
        
        let BGMAction = SKAction.run { self.BGMplay(BGM: self.Attack2BGM) }
        let waiteAction = SKAction.wait(forDuration: time1 * Double(count) * 3.0)
        run(SKAction.sequence([BGMAction,waiteAction,BGMAction,waiteAction,BGMAction]))
        
    }
    
    func airAttackAction01(){
        let alltime = AttackActionTime[2]
        let count = 20
        let bodyp: [CGFloat] = [0,35,0]
        let leg1p: [CGFloat] = [0,-50,-40]
        let leg2p: [CGFloat] = [0,-50,-40]
        let arm1p: [CGFloat] = [10,100,30]
        let arm2p: [CGFloat] = [10,100,30]
        let rotato :CGFloat = -360
        
        let time1 = alltime / Double(count)
        let time = [Double](repeating: time1, count: count)
        
        let bodymove = RotateMove(position: bodyp, axismove: nil, count: count, RotatoBy:rotato)
        let leg1move = RotateMove(position: leg1p, axismove: nil, count: count, RotatoBy:rotato)
        let leg2move = RotateMove(position: leg2p, axismove: nil, count: count, RotatoBy:rotato)
        let arm1move = RotateMove(position: arm1p, axismove: nil, count: count, RotatoBy:rotato)
        let arm2move = RotateMove(position: arm2p, axismove: nil, count: count, RotatoBy:rotato)
        AttackDamage = 10
        Sensorlock = true
        
        let lastAction =  SKAction.run {
            self.AttackDamage = 0
            self.run(SKAction.wait(forDuration: 0.3)){
                self.Sensorlock = false
            }
        }
        playerGravityOFF()
        AttackDamage = 10
        PlayToAction(move: leg1move, dischange: true, moveing: true, object: leg11, lastAction: nil, time: time)
        PlayToAction(move: leg2move, dischange: true, moveing: true, object: leg21, lastAction: nil, time: time)
        PlayToAction(move: arm1move, dischange: true, moveing: true, object: arm11, lastAction: nil, time: time)
        PlayToAction(move: arm2move, dischange: true, moveing: true, object: arm21, lastAction: nil, time: time)
        PlayToAction(move: bodymove, dischange: true, moveing: true, object: body, lastAction: lastAction, time: time)
        BGMplay(BGM: Attack2BGM)
    }

    func avoidAction(avoideD: Bool){
        let alltime = AttackActionTime[4] //アクションの時間
        let count = 5//アクション補関数
        var dm: CGFloat = 300//移動距離
    
        var bodyposition: [[CGFloat]]!
        var leg1position: [[CGFloat]]!
        var leg2position: [[CGFloat]]!
        var arm1position: [[CGFloat]]!
        var arm2position: [[CGFloat]]!
        var rotate: [CGFloat]!
        
        if playerPosture <= 3{
            if avoideD{
                rotate = [-90,-180,-270,-360]
            }else{
                rotate = [90,180,270,360]
            }
            bodyposition = [[0,0,-30],[0,0,-30],[0,0,-30],[0,0,-30]]
            leg1position = [[0,-45,-60],[0,-45,-120],[0,-45,-60],[0,-40,-20]]
            leg2position = [[0,-45,-40],[0,-45,-70],[0,-45,-40],[0,-40,-20]]
            arm1position = [[40,70,160],[0,95,180],[40,70,160],[40,40,90]]
            arm2position = [[40,70,170],[0,95,190],[40,70,170],[40,40,100]]
        }else if playerPosture <= 6{
            if avoideD && playerSlope{
                rotate = [-180,-270,-360]
                bodyposition = [[0,-10,-30],[0,-10,-30],[0,-10,-30]]
                leg1position = [[0,-45,-120],[0,-45,-60],[0,-40,-20]]
                leg2position = [[0,-45,-70],[0,-45,-40],[0,-40,-20]]
                arm1position = [[0,95,180],[40,70,160],[40,40,90]]
                arm2position = [[0,95,190],[40,70,170],[40,40,100]]
            }else if avoideD && playerSlope == false{
                rotate = [0,-90,-180,-270,-360]
                bodyposition = [[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30]]
                leg1position = [[10,-40,-20],[0,-45,-60],[0,-45,-120],[0,-45,-60],[0,-40,-20]]
                leg2position = [[10,-40,-20],[0,-45,-40],[0,-45,-70],[0,-45,-40],[0,-40,-20]]
                arm1position = [[40,40,90],[40,70,160],[0,95,180],[40,70,160],[40,40,90]]
                arm2position = [[40,40,100],[40,70,170],[0,95,190],[40,70,170],[40,40,100]]
            }else if avoideD == false && playerSlope{
                rotate = [0,90,180,270,360]
                bodyposition = [[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30]]
                leg1position = [[10,-40,-20],[0,-45,-60],[0,-45,-120],[0,-45,-60],[0,-40,-20]]
                leg2position = [[10,-40,-20],[0,-45,-40],[0,-45,-70],[0,-45,-40],[0,-40,-20]]
                arm1position = [[40,40,90],[40,70,160],[0,95,180],[40,70,160],[40,40,90]]
                arm2position = [[40,40,100],[40,70,170],[0,95,190],[40,70,170],[40,40,100]]
            }else{
                rotate = [180,270,360]
                bodyposition = [[0,-10,-30],[0,-10,-30],[0,-10,-30]]
                leg1position = [[0,-45,-120],[0,-45,-60],[0,-40,-20]]
                leg2position = [[0,-45,-70],[0,-45,-40],[0,-40,-20]]
                arm1position = [[0,95,180],[40,70,160],[40,40,90]]
                arm2position = [[0,95,190],[40,70,170],[40,40,100]]
            }
        }else{
            if avoideD{
                rotate = [90,0,-90,-180,-270,-360]
            }else{
                rotate = [-90,0,90,180,270,360]
            }
            bodyposition = [[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30],[0,-10,-30]]
            leg1position = [[0,-45,-60],[10,-40,-20],[0,-45,-60],[0,-45,-120],[0,-45,-60],[0,-40,-20]]
            leg2position = [[0,-45,-40],[10,-40,-20],[0,-45,-40],[0,-45,-70],[0,-45,-40],[0,-40,-20]]
            arm1position = [[40,70,160],[40,40,90],[40,70,160],[0,95,180],[40,70,160],[40,40,90]]
            arm2position = [[40,70,170],[40,40,100],[40,70,170],[0,95,190],[40,70,170],[40,40,100]]
        }
        //アクションの最初と最後に行う操作の定義
        playerDamageflag = false
        Sensorlock = true
        Groundjointanglemovement()
        let lastAction =  SKAction.run {
            self.Actionlock = false
            self.Sensorlock = false
            self.playerDamageflag = true
            if self.playerstatas == 1{
                self.standardAction()
            }else if self.playerstatas == 2{
                self.Airjointanglemovement()
            }
            
        }
        //向きやフリック方向によるアクションの変化を定義
        for n in 0..<bodyposition.count{
            if playerdirection == false{
                bodyposition[n][0] = -bodyposition[n][0]
                leg1position[n][0] = -leg1position[n][0]
                leg2position[n][0] = -leg2position[n][0]
                arm1position[n][0] = -arm1position[n][0]
                arm2position[n][0] = -arm2position[n][0]
                bodyposition[n][2] = -bodyposition[n][2]
                leg1position[n][2] = -leg1position[n][2]
                leg2position[n][2] = -leg2position[n][2]
                arm1position[n][2] = -arm1position[n][2]
                arm2position[n][2] = -arm2position[n][2]
            }
        }
        if avoideD == false{
            dm = -dm
        }
        //回転するアクションの移動距離を計算
        let bodymove = RotateMove(object: body, position: bodyposition, axismove: nil, count: count, RotatoTo: rotate)
        let leg1move = RotateMove(object: leg11, position: leg1position, axismove: nil, count: count, RotatoTo: rotate)
        let leg2move = RotateMove(object: leg21, position: leg2position, axismove: nil, count: count, RotatoTo: rotate)
        let arm1move = RotateMove(object: arm11, position: arm1position, axismove: nil, count: count, RotatoTo: rotate)
        let arm2move = RotateMove(object: arm21, position: arm2position, axismove: nil, count: count, RotatoTo: rotate)
        //アクションの実行時間を計算
        let ActionCount = count * bodyposition.count
        let time1 = alltime / Double(ActionCount)
        let time = [Double](repeating: time1, count: ActionCount)
        //アクションの実行
        avoidBGM.run(SKAction.play())
        playerMoveSensorBlock.run(SKAction.moveBy(x: ww * dm, y: 0, duration: alltime))
        PlayToAction(move: leg1move, dischange: false, moveing: true, object: self.leg11, lastAction: nil, time: time)
        PlayToAction(move: leg2move, dischange: false, moveing: true, object: self.leg21, lastAction: nil, time: time)
        PlayToAction(move: arm1move, dischange: false, moveing: true, object: self.arm11, lastAction: nil, time: time)
        PlayToAction(move: arm2move, dischange: false, moveing: true, object: self.arm21, lastAction: nil, time: time)
        PlayToAction(move: bodymove, dischange: false, moveing: true, object: self.body, lastAction: lastAction, time: time)
    }
    
    func playerDamageA(eN:Int){
        playerHP -= enemyDamage[eN]
        viewnode.Damage(pHP: playerHP)
        playerInvincible(time: 2.0)
        EE = true
        PdameageBGM.run(SKAction.play())
    }
    
    func playerDamageA(Damage:Int){
        playerHP -= Damage
        viewnode.Damage(pHP: playerHP)
        playerInvincible(time: 2.0)
        PdameageBGM.run(SKAction.play())
    }
    
    func enemyDamageA(eN:Int){
        let Eobject = enemy[eN]             //敵本体のノッド
        let Damage = AttackDamage           //プレイヤーの攻撃力
        enemyHP[eN] = enemyHP[eN] - Damage  //敵HPの計算
        let pp = body.position      //プレイヤー位置
        let ep = enemy[eN].position         //敵位置
        let an = airAN                      //空中強攻撃の発動フラグについて
        
        if playerstatas == 2{        //空中強攻撃の発動フラグについて
            DispatchQueue.main.asyncAfter(deadline: .now() + AttackComboTime[3][0]){
                self.airAttackHit[an] += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + AttackComboTime[3][1]){
                self.airAttackHit[an] -= 1
            }
        }
        
        if enemyHP[eN] <= 0{          //敵HPがゼロになった時の処理
            BGMplay(BGM: Hit3BGM)                                                          //敵の消去音を再生
            enemydelete(kill: true, number: eN)                                            //敵を消去する関数の呼び出し
            guard let enemyderi = SKEmitterNode(fileNamed: "enemyderi") else { return }    //敵の消去エフェクトの読み込み
            enemyderi.position = ep                                                        //敵の消去エフェクトの出現ポイントを定義
            addChild(enemyderi)                                                            //敵の消去エフェクトをステージに追加
            self.run(SKAction.wait(forDuration: 1.0)){ enemyderi.removeFromParent() }      //一秒後に敵の消去エフェクトを消去
            EE = true                                                                      //敵生成などの操作を再開
            return
        }else{
            //攻撃による敵の吹っ飛ばしの設定
            let vecter = angle(p1: pp, p2: ep)
            let pawar: CGFloat = CGFloat(20.0) * impulseR
            let Vx = sin(vecter) * pawar
            let Vy = -cos(vecter)  * pawar
            let Gon = Eobject.physicsBody?.affectedByGravity
            if Gon!{
                Eobject.run(SKAction.applyImpulse(CGVector(dx: Vx, dy: Vy), duration: 0.2))
            }
            
            //フラッシュアクションの生成
            let onAction = SKAction.run {Eobject.alpha = 1.0}
            let offAction = SKAction.run {Eobject.alpha = 0.2}
            let waitAction = SKAction.wait(forDuration: 0.1)
            var flashAction = SKAction.sequence([offAction,waitAction,onAction,waitAction])
            flashAction = SKAction.repeat(flashAction, count: 5)
            run(flashAction)
            
            if Damage > 15 { enemyDBGM[eN][1].run(SKAction.play())     }
            else           { enemyDBGM[eN][0].run(SKAction.play())     }
        
            EE = true //敵生成などの操作を再開
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                for n in 1...self.enemy.count - 1{
                    if Eobject == self.enemy[n]{self.enemyDamageflag[n] = true}
                }
            }
        }
        
    }
    
    func playerInvincible(time: Double){
        let offAction = SKAction.run {
            self.body.alpha = 0.2
            self.arm11.alpha = 0.2
            self.arm12.alpha = 0.2
            self.arm21.alpha = 0.2
            self.arm22.alpha = 0.2
            self.leg11.alpha = 0.2
            self.leg12.alpha = 0.2
            self.leg21.alpha = 0.2
            self.leg22.alpha = 0.2
        }
        let onAction = SKAction.run {
            self.body.alpha = 1.0
            self.arm11.alpha = 1.0
            self.arm12.alpha = 1.0
            self.arm21.alpha = 1.0
            self.arm22.alpha = 1.0
            self.leg11.alpha = 1.0
            self.leg12.alpha = 1.0
            self.leg21.alpha = 1.0
            self.leg22.alpha = 1.0
        }
        let lastAction = SKAction.run {self.playerDamageflag2 = true
        }
        let waitAction = SKAction.wait(forDuration: 0.1)
        var flashingAction = SKAction.sequence([offAction,waitAction,onAction,waitAction])
        let flashiCount = Int(time / 0.2)
        flashingAction = SKAction.repeat(flashingAction, count: flashiCount)
        run(SKAction.sequence([flashingAction,lastAction]))
    }
    
    
    func attack01Action(){
        let allteime = AttackActionTime[0]
        
        let bodymove: [[CGFloat]] = [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
        let leg1move: [[CGFloat]] = [[15,-45,10],[15,-45,10],[15,-45,10],[15,-45,10],[15,-45,10]]
        let leg2move: [[CGFloat]] = [[-10,-45,-20],[-10,-45,-20],[-10,-45,-20],[-10,-40,-20],[-10,-45,-20]]
        let arm1move: [[CGFloat]] = [[10,35,160],[10,35,90],[0,30,0],[-35,75,-90],[0,110,-180]]
        let arm2move: [[CGFloat]] = [[10,35,160],[10,30,90],[0,30,0],[-35,75,-90],[0,110,-180]]
        
        let time = [Double](repeating: allteime / Double(bodymove.count), count: bodymove.count)
        let lastAction =  SKAction.run {
            if self.AttackCombofalg[1]{
                self.AttackCombofalg[1] = false
                self.attack02Action()
            }else{
                self.standardAction()
                self.AttackDamage = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + AttackComboTime[0][0]){
            self.AttackComboAccess[1] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + AttackComboTime[0][1]){
            self.AttackComboAccess[1] = false
        }
        Groundjointanglemovement()
        playerGravityOFF()
        AttackDamage = 10
        PlayToAction(move: leg1move, dischange: true, moveing: true, object: leg11, lastAction: nil, time: time)
        PlayToAction(move: leg2move, dischange: true, moveing: true, object: leg21, lastAction: nil, time: time)
        PlayToAction(move: arm1move, dischange: true, moveing: true, object: arm11, lastAction: nil, time: time)
        PlayToAction(move: arm2move, dischange: true, moveing: true, object: arm21, lastAction: nil, time: time)
        PlayToAction(move: bodymove, dischange: true, moveing: true, object: body, lastAction: lastAction, time: time)
        BGMplay(BGM: Attack1BGM)
    }
    
    func attack02Action(){
        let alltime = AttackActionTime[1]
        let bodymove: [[CGFloat]] = [[0,0,0],[0,10,-45],[10,0,-30],[0,-5,-30],[0,0,0],[0,5,-25],[10,0,-40]]
        let leg1move: [[CGFloat]] = [[15,-45,10],[10,-20,-15],[-50,-5,-90],[-5,-30,20],[15,-45,10],[0,-45,0],[-40,-45,-60]]
        let leg2move: [[CGFloat]] = [[-10,-45,-20],[10,-20,-30],[15,-45,10],[0,-45,0],[-10,-45,-20],[10,-20,-30],[20,-45,30]]
        let arm1move: [[CGFloat]] = [[-10,105,-165],[10,35,90],[-10,30,15],[-35,80,-100],[-10,105,-165],[10,35,90],[-20,30,15]]
        let arm2move: [[CGFloat]] = [[0,105,-135],[10,30,90],[10,30,-15],[-35,70,-80],[0,105,-135],[10,30,90],[10,30,-15]]
        var dm: CGFloat = -300
        if playerdirection{dm = -dm}
        let onetime = alltime / Double(bodymove.count)
        let time = [Double](repeating: onetime, count: bodymove.count)

        let lastAction =  SKAction.run {
            self.AttackDamage = 0
            if self.AttackCombofalg[4] && self.AttackCombofalg[5] == false{
                self.AttackCombofalg[4] = false
                self.avoidAction(avoideD: true)
            }else if self.AttackCombofalg[4] == false && self.AttackCombofalg[5]{
                self.AttackCombofalg[5] = false
                self.avoidAction(avoideD: false)
            }else{
                self.AttackCombofalg[4] = false
                self.AttackCombofalg[5] = false
                self.standardAction()
                self.playerDamageflag = true
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + AttackComboTime[1][0]){
            self.AttackComboAccess[5] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + AttackComboTime[1][1]){
            self.AttackComboAccess[5] = false
        }
        
        AttackDamage = 20
        playerDamageflag = false
        if playerdirection{
            bodyLeftChangeAction(time: onetime * 2.0, interval: onetime * 3.0)
            bodyRightChangeAction(time: onetime * 2.0, interval: onetime * 5.0)
            Leg1ChangeLAction(time: onetime * 2.0, interval: onetime * 3.0)
            Leg1ChangeRAction(time: onetime * 2.0, interval: onetime * 5.0)
            Leg2ChangeLAction(time: onetime * 2.0, interval: onetime * 3.0)
            Leg2ChangeRAction(time: onetime * 2.0, interval: onetime * 5.0)
        }else{
            bodyRightChangeAction(time: onetime * 2.0, interval: onetime * 3.0)
            bodyLeftChangeAction(time: onetime * 2.0, interval: onetime * 5.0)
            Leg1ChangeRAction(time: onetime * 2.0, interval: onetime * 3.0)
            Leg1ChangeLAction(time: onetime * 2.0, interval: onetime * 5.0)
            Leg2ChangeRAction(time: onetime * 2.0, interval: onetime * 3.0)
            Leg2ChangeLAction(time: onetime * 2.0, interval: onetime * 5.0)
        }
        
        playerMoveSensorBlock.run(SKAction.moveBy(x: ww * dm, y: 0, duration: onetime * Double(time.count)))
        PlayToAction(move: leg1move, dischange: true, moveing: true, object: leg11, lastAction: nil, time: time)
        PlayToAction(move: leg2move, dischange: true, moveing: true, object: leg21, lastAction: nil, time: time)
        PlayToAction(move: arm1move, dischange: true, moveing: true, object: arm11, lastAction: nil, time: time)
        PlayToAction(move: arm2move, dischange: true, moveing: true, object: arm21, lastAction: nil, time: time)
        PlayToAction(move: bodymove, dischange: true, moveing: true, object: body, lastAction: lastAction, time: time)
        BGMplay(BGM: Attack1BGM)
        self.run(SKAction.wait(forDuration: onetime * 4.0)){
            self.BGMplay(BGM: self.Attack1BGM)
        }
    }
    
    func wallAction(Dis:CGFloat , Angle:CGFloat , flag:[Bool]){
        //radian表記
        let Frad = Angle //フリック角度
        let Prad = body.zRotation //プレイヤーの角度
        //degree表記
        let Fdeg = Frad / psita //フリック角度
        let Pdeg = Prad / psita //プレイヤーの角度
        
        let US = flag[1]
        let RS = flag[2]
        let LS = flag[3]
        let HS = flag[4]
 
        //空中状態時のxウォールキック使用条件
        if US && ((Pdeg - 315 < Fdeg && Fdeg < Pdeg - 45) || (Pdeg + 45 < Fdeg && Fdeg < Pdeg + 315)){
            wallkickAction(Dis: Dis, Angle: Angle,sn:1)
            return
        }
        
        if RS && ((Pdeg - 225 < Fdeg && Fdeg < Pdeg + 45) || Pdeg + 135 < Fdeg || Fdeg < Pdeg - 315){
            wallkickAction(Dis: Dis, Angle: Angle,sn:2)
            return
        }
        
        if LS && (Pdeg + 315 < Fdeg || Fdeg < Pdeg - 135 || (Pdeg - 45 < Fdeg && Fdeg < Pdeg + 225)){
            wallkickAction(Dis: Dis, Angle: Angle,sn:3)
            return
        }
        
        if HS && ((Pdeg - 135 < Fdeg && Fdeg < Pdeg + 135) || Pdeg + 225 < Fdeg || Fdeg < Pdeg - 225){
            wallkickAction(Dis: Dis, Angle: Angle,sn:4)
            return
        }
    }
 
    
    func wallkickAction(Dis: CGFloat, Angle:CGFloat, sn:Int){
        //ウォールキック基本アクション
        var bodymove:[CGFloat] = [0,-30,-20]//胴体
        var leg1move:[CGFloat] = [20,-65,-45] //右足
        var leg2move:[CGFloat] = [20,-65,-45]//左足
        var arm1move:[CGFloat] = [15,15,120]//右手
        var arm2move:[CGFloat] = [10,-10,-40]//左手
        let time = 0.2
        
        Sensorlock = true
        Actionlock = true
        underSflag1 = false
        rightSflag1 = false
        leftSflag1 = false
        overSflag1 = false
        DispatchQueue.main.asyncAfter(deadline: .now() + time + 0.1){
            self.Actionlock = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + time + 0.5){
            if self.AttackDamage != 20{
                self.Sensorlock = false
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + time + AttackComboTime[2][0]){
            self.AttackComboAccess[3] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + time + AttackComboTime[2][1]){
            self.AttackComboAccess[3] = false
        }
        var PStandard: [CGFloat] = wallp
        
        var jumpS:CGFloat!
        //ジャンプの強弱の係数計算
        if Dis <= h * 3 / 10{
            jumpS = 1.0
        }else if Dis < h * 4 / 10{
            jumpS = 1.1
        }else if Dis < h * 5 / 10{
            jumpS = 1.2
        }else if Dis < h * 6 / 10{
            jumpS = 1.3
        }else if Dis < h * 7 / 10{
            jumpS = 1.5
        }else if Dis < h * 8 / 10{
            jumpS = 1.6
        }else if Dis < h * 9 / 10{
            jumpS = 1.7
        }else{
            jumpS = 1.8
        }
        //ジャンプ力の計算
        let jumpPower = jumpF * jumpS * impulseR
        //ジャンプ方向の計算(成分分解)
        let jumpX = sin(Angle) * jumpPower
        let jumpY = -cos(Angle) * jumpPower
        
        let firstAction = SKAction.run {
            self.playerGravityOFF()
        }
        let lastAction = SKAction.run{
            self.body.run(SKAction.applyImpulse(CGVector(dx: jumpX, dy: jumpY), duration: 0.1))
            self.jumpBGM.run(SKAction.play())
        }
        
        if sn == 0{//地上アクション
            for n in 0...2{
                if n <= 1{
                    bodymove[n] = bodymove[n] * ww + PStandard[n]
                    leg1move[n] = leg1move[n] * ww + PStandard[n]
                    leg2move[n] = leg2move[n] * ww + PStandard[n]
                    arm1move[n] = arm1move[n] * ww + PStandard[n]
                    arm2move[n] = arm2move[n] * ww + PStandard[n]
                }else{
                    bodymove[n] = bodymove[n] * psita
                    leg1move[n] = leg1move[n] * psita
                    leg2move[n] = leg2move[n] * psita
                    arm1move[n] = arm1move[n] * psita
                    arm2move[n] = arm2move[n] * psita
                }
            }
        }
        var sita: CGFloat!
        if sn >= 1{
            if sn == 1{sita = 0}//アンダーセンサ
            else if sn == 2{sita = 90}//ライトセンサ
            else if sn == 3{sita = -90}//レフトセンサ
            else{sita = 180}//ヘッドセンサ
            bodymove = rotateCalculation(object: bodymove, Standared: PStandard, sita: sita)
            leg1move = rotateCalculation(object: leg1move, Standared: PStandard, sita: sita)
            leg2move = rotateCalculation(object: leg2move, Standared: PStandard, sita: sita)
            arm1move = rotateCalculation(object: arm1move, Standared: PStandard, sita: sita)
            arm2move = rotateCalculation(object: arm2move, Standared: PStandard, sita: sita)
        }
        let bodyA = SKAction.group([SKAction.move(to: CGPoint(x: bodymove[0], y: bodymove[1]), duration: time)
            ,SKAction.rotate(toAngle: bodymove[2], duration: time, shortestUnitArc: true)])
        let leg1Action = SKAction.group([SKAction.move(to: CGPoint(x: leg1move[0], y: leg1move[1]), duration: time)
            ,SKAction.rotate(toAngle: leg1move[2], duration: time, shortestUnitArc: true)])
        let leg2Action = SKAction.group([SKAction.move(to: CGPoint(x: leg2move[0], y: leg2move[1]), duration: time)
            ,SKAction.rotate(toAngle: leg2move[2], duration: time, shortestUnitArc: true)])
        let arm1Action = SKAction.group([SKAction.move(to: CGPoint(x: arm1move[0], y: arm1move[1]), duration: time)
            ,SKAction.rotate(toAngle: arm1move[2], duration: time, shortestUnitArc: true)])
        let arm2Action = SKAction.group([SKAction.move(to: CGPoint(x: arm2move[0], y: arm2move[1]), duration: time)
            ,SKAction.rotate(toAngle: arm2move[2], duration: time, shortestUnitArc: true)])
       
        var bodyAction:SKAction!
        bodyAction = SKAction.sequence([firstAction,bodyA,lastAction])
        
        let exAction = SKAction.run {
            self.body.run(bodyAction, withKey: "bodyAction")
            self.leg11.run(leg1Action, withKey: "leg1Action")
            self.leg21.run(leg2Action, withKey: "leg2Action")
            self.arm11.run(arm1Action, withKey: "arm1Action")
            self.arm21.run(arm2Action, withKey: "arm2Action")
        }
        run(exAction)
    }
    
    func playerBSpositionreset(){
        let firstAction = SKAction.run {
            self.playerblockSensor.physicsBody?.isDynamic = false
            self.pmyflag = false
        }
        let pmAction = SKAction.move(to: playerMoveSensorBlock.position, duration: 0.1)
        let prAction = SKAction.rotate(toAngle: 0, duration: 0.1)
        let pAction = SKAction.group([pmAction,prAction])
        let lastAction = SKAction.run {
            self.playerblockSensor.physicsBody?.isDynamic = true
            self.pmyflag = true
            self.playerstatas = 1
            self.standardAction()
        }
        playerblockSensor.run(SKAction.sequence([firstAction,pAction,lastAction]))
    }
    
    func playerBSpositionreset2(){
        let firstAction = SKAction.run {
            self.playerblockSensor.physicsBody?.isDynamic = false
            self.pmyflag = false
        }
        let pmAction = SKAction.move(to: playerMoveSensorBlock.position, duration: 0.1)
        let prAction = SKAction.rotate(toAngle: 0, duration: 0.1)
        let pAction = SKAction.group([pmAction,prAction])
        let lastAction = SKAction.run {
            self.playerblockSensor.physicsBody?.isDynamic = true
            self.pmyflag = true
            self.playerstatas = 1
            self.playerGravityON()
            
        }
        playerblockSensor.run(SKAction.sequence([firstAction,pAction,lastAction]))
    }
    
    func Rairmove(){
        let moverange = CGFloat(20.0) * impulseR
        let time = 0.5
        let lastAction = SKAction.run {
            self.airrightposible = true
            self.airleftposible = true
        }
        var playerAction = SKAction.applyImpulse(CGVector(dx: moverange, dy: 0), duration: time)
        let allAction = SKAction.applyImpulse(CGVector(dx: moverange, dy: 0), duration: time)
        playerAction = SKAction.sequence([playerAction,lastAction])
        body.run(playerAction, withKey: "bodyAction")
        leg11.run(allAction, withKey: "leg1Action")
        leg21.run(allAction, withKey: "leg2Action")
        arm11.run(allAction, withKey: "arm1Action")
        arm21.run(allAction, withKey: "arm2Action")
    }
    
    func Lairmove(){
        let moverange = CGFloat(-20.0) * impulseR
        let time = 0.5
        let lastAction = SKAction.run {
            self.airrightposible = true
            self.airleftposible = true
        }
        var playerAction = SKAction.applyImpulse(CGVector(dx: moverange, dy: 0), duration: time)
        let allAction = SKAction.applyImpulse(CGVector(dx: moverange, dy: 0), duration: time)
        playerAction = SKAction.sequence([playerAction,lastAction])
        body.run(playerAction, withKey: "bodyAction")
        leg11.run(allAction, withKey: "leg1Action")
        leg21.run(allAction, withKey: "leg2Action")
        arm11.run(allAction, withKey: "arm1Action")
        arm21.run(allAction, withKey: "arm2Action")
    }
    
    func legstopAction(){
        if let playAction = leg11.action(forKey: "leg1Action"){
            playAction.speed = 0
        }
        if let playAction = leg21.action(forKey: "leg2Action"){
            playAction.speed = 0
        }
    }

    func jumpAction(Dis: CGFloat, Angle:CGFloat){
        let ww = h / 1000
        //[x,y,θ]
        let Atime:[Double] = [0.1,0.05] //アクション時間
        var allmove:[[CGFloat]] = [[0,0,0],[0,0,0]] //全体の動作
        var bodymove:[[CGFloat]] = [[0,-40,-20],[0,0,0]] //胴体の動作
        var leg1move:[[CGFloat]] = [[10,-70,-40],[0,-65,0]] //右足の動作
        var leg2move:[[CGFloat]] = [[10,-70,-40],[0,-65,0]] //左足の動作
        var arm1move:[[CGFloat]] = [[20,35,160],[20,100,160]] //右手の動作
        var arm2move:[[CGFloat]] = [[15,30,90],[0,5,0]] //左手の動作
        
        var jumpS:CGFloat!
        
        //ジャンプの強弱の係数計算
        if Dis <= h * 3 / 10{
            jumpS = 1.0
        }else if Dis < h * 4 / 10{
            jumpS = 1.1
        }else if Dis < h * 5 / 10{
            jumpS = 1.2
        }else if Dis < h * 6 / 10{
            jumpS = 1.3
        }else if Dis < h * 7 / 10{
            jumpS = 1.5
        }else if Dis < h * 8 / 10{
            jumpS = 1.6
        }else if Dis < h * 9 / 10{
            jumpS = 1.7
        }else{
            jumpS = 1.8
        }

        //ジャンプ力の計算
        let jumpPower = jumpF * jumpS * impulseR
        //ジャンプ方向の計算(成分分解)
        let jumpX = sin(Angle) * jumpPower
        let jumpY = -cos(Angle) * jumpPower
        
        //方向の決定
        let firstAction = SKAction.run {
            self.playerstatas = 2
            self.Actionlock = true
            self.playerGravityOFF()
        //    self.ChangeisDynamic(bodyd: true, leg11d: true, leg21d: true, arm11d: true, arm21d: true)
        }
        let endAction = SKAction.run{
            self.Actionlock = false
            self.body.run(SKAction.applyImpulse(CGVector(dx: jumpX, dy: jumpY), duration: 0.1))
            self.jumpBGM.run(SKAction.play())
        }
        
        if playerdirection == false{
            for m in 0...Atime.count - 1{
                for n in 0...2{
                    if n != 1{
                        allmove[m][n] = -allmove[m][n]
                        bodymove[m][n] = -bodymove[m][n]
                        leg1move[m][n] = -leg1move[m][n]
                        leg2move[m][n] = -leg2move[m][n]
                        arm1move[m][n] = -arm1move[m][n]
                        arm2move[m][n] = -arm2move[m][n]
                    }
                }
            }
        }
        
        var bodyAction:SKAction!
        var leg1Action:SKAction!
        var leg2Action:SKAction!
        var arm1Action:SKAction!
        var arm2Action:SKAction!
        
        for m in 0...Atime.count - 1{
            for n in 0...2{
                //各部分の移動距離の計算
                if m < Atime.count - 1 && n != 2{
                    allmove[m + 1][n] += allmove[m][n]
                }
                switch n{
                case 0:bodymove[m][0] = (bodymove[m][0] + allmove[m][0]) * ww + playerMoveSensorBlock.position.x
                leg1move[m][0] = (leg1move[m][0] + allmove[m][0]) * ww + playerMoveSensorBlock.position.x
                leg2move[m][0] = (leg2move[m][0] + allmove[m][0]) * ww + playerMoveSensorBlock.position.x
                arm1move[m][0] = (arm1move[m][0] + allmove[m][0]) * ww + playerMoveSensorBlock.position.x
                arm2move[m][0] = (arm2move[m][0] + allmove[m][0]) * ww + playerMoveSensorBlock.position.x
                case 1:bodymove[m][1] = (bodymove[m][1] + allmove[m][1]) * ww + playerMoveSensorBlock.position.y
                leg1move[m][1] = (leg1move[m][1] + allmove[m][1]) * ww + playerMoveSensorBlock.position.y
                leg2move[m][1] = (leg2move[m][1] + allmove[m][1]) * ww + playerMoveSensorBlock.position.y
                arm1move[m][1] = (arm1move[m][1] + allmove[m][1]) * ww + playerMoveSensorBlock.position.y
                arm2move[m][1] = (arm2move[m][1] + allmove[m][1]) * ww + playerMoveSensorBlock.position.y
                case 2:bodymove[m][2] = (bodymove[m][2] + allmove[m][2]) * psita
                leg1move[m][2] = (leg1move[m][2] + allmove[m][2]) * psita
                leg2move[m][2] = (leg2move[m][2] + allmove[m][2]) * psita
                arm1move[m][2] = (arm1move[m][2] + allmove[m][2]) * psita
                arm2move[m][2] = (arm2move[m][2] + allmove[m][2]) * psita
                default: break
                }
            }
            //アクションの作成
            let bodyA = SKAction.group([SKAction.move(to: CGPoint(x: bodymove[m][0], y: bodymove[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: bodymove[m][2], duration: Atime[m], shortestUnitArc: true)])
            let leg1A = SKAction.group([SKAction.move(to: CGPoint(x: leg1move[m][0], y: leg1move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: leg1move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let leg2A = SKAction.group([SKAction.move(to: CGPoint(x: leg2move[m][0], y: leg2move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: leg2move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let arm1A = SKAction.group([SKAction.move(to: CGPoint(x: arm1move[m][0], y: arm1move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: arm1move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let arm2A = SKAction.group([SKAction.move(to: CGPoint(x: arm2move[m][0], y: arm2move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: arm2move[m][2], duration: Atime[m], shortestUnitArc: true)])
            
            if m == 0{
                bodyAction = SKAction.sequence([firstAction,bodyA])
                leg1Action = leg1A
                leg2Action = leg2A
                arm1Action = arm1A
                arm2Action = arm2A
            }else{
                bodyAction = SKAction.sequence([bodyAction,bodyA])
                leg1Action = SKAction.sequence([leg1Action,leg1A])
                leg2Action = SKAction.sequence([leg2Action,leg2A])
                arm1Action = SKAction.sequence([arm1Action,arm1A])
                arm2Action = SKAction.sequence([arm2Action,arm2A])
            }
        }
        
        bodyAction = SKAction.sequence([bodyAction,endAction])
        let exAction = SKAction.run {
            self.body.run(bodyAction, withKey: "bodyAction")
            self.leg11.run(leg1Action, withKey: "leg1Action")
            self.leg21.run(leg2Action, withKey: "leg2Action")
            self.arm11.run(arm1Action, withKey: "arm1Action")
            self.arm21.run(arm2Action, withKey: "arm2Action")
        }
        run(exAction)
    }

    func standardAction(){
        let ww = h / 1000
        let Atime = 0.1
        //[x,y,sita]
        var bodyA:[CGFloat] = [0,0,0]
        var leg1A:[CGFloat] = [10,-45,10] //右足
        var leg2A:[CGFloat] = [-10,-45,-10] //左足
        var arm1A:[CGFloat] = [10,35,160] //右手
        var arm2A:[CGFloat] = [0,30,0] //左手
        
        Actionlock = true
        //プレイヤーが左方向のアクションに変換
        if playerdirection == false{
            for n in 0...2{
                if n != 1{
                    bodyA[n] = -bodyA[n]
                    leg1A[n] = -leg1A[n]
                    leg2A[n] = -leg2A[n]
                    arm1A[n] = -arm1A[n]
                    arm2A[n] = -arm2A[n]
                }
            }
        }
        let firstAction = SKAction.run {
            self.playerstatas = 1
            self.ChangeisDynamic(bodyd: false, leg11d: false, leg21d: false, arm11d: false, arm21d: false)
            self.standardPhysicsStatas()
        }
        let lastAction = SKAction.run {
            self.playerGravityON()
            self.Standerdanglemovement()
            self.ChangeisDynamic(bodyd: true, leg11d: true, leg21d: true, arm11d: true, arm21d: true)
            self.Actionlock = false
        }
        //値の変換
        for n in 0...2{
            switch n{
            case 0: bodyA[0] = playerMoveSensorBlock.position.x + ww * bodyA[0]
                leg1A[0] = playerMoveSensorBlock.position.x + ww * leg1A[0]
                leg2A[0] = playerMoveSensorBlock.position.x + ww * leg2A[0]
                arm1A[0] = playerMoveSensorBlock.position.x + ww * arm1A[0]
                arm2A[0] = playerMoveSensorBlock.position.x + ww * arm2A[0]
            case 1: bodyA[1] = playerMoveSensorBlock.position.y + ww * bodyA[1]
                leg1A[1] = playerMoveSensorBlock.position.y + ww * leg1A[1]
                leg2A[1] = playerMoveSensorBlock.position.y + ww * leg2A[1]
                arm1A[1] = playerMoveSensorBlock.position.y + ww * arm1A[1]
                arm2A[1] = playerMoveSensorBlock.position.y + ww * arm2A[1]
            case 2: bodyA[2] =  bodyA[2] * psita
                leg1A[2] = leg1A[2] * psita
                leg2A[2] = leg2A[2] * psita
                arm1A[2] = arm1A[2] * psita
                arm2A[2] = arm2A[2] * psita
            default: break
            }
        }
        //アクションの定義
        var bodyAction = SKAction.group([SKAction.move(to: CGPoint(x: bodyA[0], y: bodyA[1]), duration: Atime)
                                        ,SKAction.rotate(toAngle: bodyA[2], duration: Atime, shortestUnitArc: true)])
        let leg1Action = SKAction.group([SKAction.move(to: CGPoint(x:leg1A[0] ,y:leg1A[1]), duration: Atime)
                                        ,SKAction.rotate(toAngle: leg1A[2], duration: Atime, shortestUnitArc: true)])
        let leg2Action = SKAction.group([SKAction.move(to: CGPoint(x:leg2A[0] ,y:leg2A[1]), duration: Atime)
                                        ,SKAction.rotate(toAngle: leg2A[2], duration: Atime, shortestUnitArc: true)])
        let arm1Action = SKAction.group([SKAction.move(to: CGPoint(x:arm1A[0] ,y:arm1A[1]), duration: Atime)
                                        ,SKAction.rotate(toAngle: arm1A[2], duration: Atime, shortestUnitArc: true)])
        let arm2Action = SKAction.group([SKAction.move(to: CGPoint(x:arm2A[0] ,y:arm2A[1]), duration: Atime)
                                        ,SKAction.rotate(toAngle: arm2A[2], duration: Atime, shortestUnitArc: true)])
        bodyAction = SKAction.sequence([firstAction,bodyAction,lastAction])
        let standAction = SKAction.run {
            self.body.run(bodyAction, withKey: "bodyAction")
            self.leg11.run(leg1Action, withKey: "leg1Action")
            self.leg21.run(leg2Action, withKey: "leg2Action")
            self.arm11.run(arm1Action, withKey: "arm1Action")
            self.arm21.run(arm2Action, withKey: "arm2Action")
        }
        run(standAction)
    }
    
    func trunAction(){
        let Atime = 0.4
      //  ChangeisDynamic(bodyd: true, leg11d: true, leg21d: true, arm11d: true, arm21d: true)
        Groundjointanglemovement()
        if playerdirection{
            playerdirection = false
            Leg1ChangeLAction(time: Atime, interval: 0.0)
            Leg2ChangeLAction(time: Atime, interval: 0.0)
            bodyLeftChangeAction(time: Atime, interval: 0.0)
            kamaRLChange(time: Atime, interval: 0.0)
        }else{
            playerdirection = true
            Leg1ChangeRAction(time: Atime, interval: 0.0)
            Leg2ChangeRAction(time: Atime, interval: 0.0)
            bodyRightChangeAction(time: Atime, interval: 0.0)
            kamaRLChange(time: Atime, interval: 0.0)
        }
        walk01posible = true //歩く動作(遅い)の受け付けを可能にする
        walk02posible = true //歩く動作(速い)の受け付けを可能にする
        runposible = true
    }
    
    func walkAction(time:Double){
        let ww = h / 1000
        //[x,y,θ]
        let Atime:[Double] = [time,time,time,time] //アクション時間
        var allmove:[[CGFloat]] = [[20,0,0],[20,0,0],[20,0,0],[20,0,0]] //全体の動作
        var bodymove:[[CGFloat]] = [[0,0,0],[0,0,0],[0,0,0],[0,0,0]] //胴体の動作
        var leg1move:[[CGFloat]] = [[0,-50,0],[-15,-40,-20],[0,-30,-50],[15,-40,20]] //右足の動作
        var leg2move:[[CGFloat]] = [[0,-30,-50],[15,-40,20],[0,-50,0],[-15,-40,-20]] //左足の動作
        var arm1move:[[CGFloat]] = [[5,55,170],[10,50,160],[5,55,170],[10,50,160]] //右手の動作
        var arm2move:[[CGFloat]] = [[-10,15,-20],[0,10,0],[10,15,20],[0,10,0]] //左手の動作
        let BGMA = SKAction.run { self.walkBGM.run(SKAction.play()) }
        let px = playerMoveSensorBlock.position.x
        let py = playerMoveSensorBlock.position.y
        
        let firstAction = SKAction.run {
            self.defealtPhysicsStatas()
            self.Groundjointanglemovement()
            self.playerGravityOFF()
        }
        let endAction = SKAction.run {
            self.walk01posible = true
            self.walk02posible = true
            self.runposible = true
        }
        
        if playerdirection == false{
            for m in 0...Atime.count - 1{
                for n in 0...2{
                    if n != 1{
                        allmove[m][n] = -allmove[m][n]
                        bodymove[m][n] = -bodymove[m][n]
                        leg1move[m][n] = -leg1move[m][n]
                        leg2move[m][n] = -leg2move[m][n]
                        arm1move[m][n] = -arm1move[m][n]
                        arm2move[m][n] = -arm2move[m][n]
                    }
                }
            }
        }
        
        var bodyAction:SKAction!
        var leg1Action:SKAction!
        var leg2Action:SKAction!
        var arm1Action:SKAction!
        var arm2Action:SKAction!
        
        for m in 0...Atime.count - 1{
            for n in 0...2{
                //各部分の移動距離の計算
                if m < Atime.count - 1 && n != 2{
                    allmove[m + 1][n] += allmove[m][n]
                }
                switch n{
                case 0:bodymove[m][0] = (bodymove[m][0] + allmove[m][0]) * ww + px
                    leg1move[m][0] = (leg1move[m][0] + allmove[m][0]) * ww + px
                    leg2move[m][0] = (leg2move[m][0] + allmove[m][0]) * ww + px
                    arm1move[m][0] = (arm1move[m][0] + allmove[m][0]) * ww + px
                    arm2move[m][0] = (arm2move[m][0] + allmove[m][0]) * ww + px
                case 1:bodymove[m][1] = (bodymove[m][1] + allmove[m][1]) * ww + py
                    leg1move[m][1] = (leg1move[m][1] + allmove[m][1]) * ww + py
                    leg2move[m][1] = (leg2move[m][1] + allmove[m][1]) * ww + py
                    arm1move[m][1] = (arm1move[m][1] + allmove[m][1]) * ww + py
                    arm2move[m][1] = (arm2move[m][1] + allmove[m][1]) * ww + py
                case 2:bodymove[m][2] = (bodymove[m][2] + allmove[m][2]) * psita
                    leg1move[m][2] = (leg1move[m][2] + allmove[m][2]) * psita
                    leg2move[m][2] = (leg2move[m][2] + allmove[m][2]) * psita
                    arm1move[m][2] = (arm1move[m][2] + allmove[m][2]) * psita
                    arm2move[m][2] = (arm2move[m][2] + allmove[m][2]) * psita
                default: break
                }
            }
            //アクションの作成

            let bodyA = SKAction.group([SKAction.move(to: CGPoint(x: bodymove[m][0], y: bodymove[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: bodymove[m][2], duration: Atime[m], shortestUnitArc: true)])
            let leg1A = SKAction.group([SKAction.move(to: CGPoint(x: leg1move[m][0], y: leg1move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: leg1move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let leg2A = SKAction.group([SKAction.move(to: CGPoint(x: leg2move[m][0], y: leg2move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: leg2move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let arm1A = SKAction.group([SKAction.move(to: CGPoint(x: arm1move[m][0], y: arm1move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: arm1move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let arm2A = SKAction.group([SKAction.move(to: CGPoint(x: arm2move[m][0], y: arm2move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: arm2move[m][2], duration: Atime[m], shortestUnitArc: true)])
            if m == 0{
                bodyAction = SKAction.sequence([firstAction,bodyA])
                leg1Action = leg1A
                leg2Action = leg2A
                arm1Action = arm1A
                arm2Action = arm2A
            }else{
                if m == 1 || m == 3{ bodyAction = SKAction.sequence([bodyAction,bodyA,BGMA]) }
                else{ bodyAction = SKAction.sequence([bodyAction,bodyA]) }
                leg1Action = SKAction.sequence([leg1Action,leg1A])
                leg2Action = SKAction.sequence([leg2Action,leg2A])
                arm1Action = SKAction.sequence([arm1Action,arm1A])
                arm2Action = SKAction.sequence([arm2Action,arm2A])
            }
        }
        bodyAction = SKAction.sequence([bodyAction,endAction])
        let exAction = SKAction.run {
            self.body.run(bodyAction, withKey: "bodyAction")
            self.leg11.run(leg1Action, withKey: "leg1Action")
            self.leg21.run(leg2Action, withKey: "leg2Action")
            self.arm11.run(arm1Action, withKey: "arm1Action")
            self.arm21.run(arm2Action, withKey: "arm2Action")
        }
        run(exAction)
    }
    
    func runAction(time:Double){
        let ww = h / 1000
        //[x,y,θ]
        let Atime:[Double] = [time,time,time,time] //アクション時間
        var allmove:[[CGFloat]] = [[80,0,0],[80,0,0],[80,0,0],[80,0,0]] //全体の動作
        var bodymove:[[CGFloat]] = [[0,-10,-10],[0,-10,-10],[0,-10,-10],[0,-10,-10]] //胴体の動作
        var leg1move:[[CGFloat]] = [[20,-40,20],[-10,-45,-30],[-15,-10,-100],[5,-20,-90]] //右足の動作
        var leg2move:[[CGFloat]] = [[-15,-10,-100],[5,-20,-90],[20,-40,20],[-10,-45,-30]] //左足の動作
        var arm1move:[[CGFloat]] = [[10,35,160],[15,40,165],[20,45,160],[10,40,165]] //右手の動作
        var arm2move:[[CGFloat]] = [[10,40,90],[0,30,40],[-20,30,-10],[0,30,40]] //左手の動作
        let BGMA = SKAction.run { self.walkBGM.run(SKAction.play()) }
        let px = playerMoveSensorBlock.position.x
        let py = playerMoveSensorBlock.position.y
        
        let firstAction = SKAction.run {
            self.defealtPhysicsStatas()
            self.Groundjointanglemovement()
            self.playerGravityOFF()
        }
        let endAction = SKAction.run {
            self.runposible = true
            self.walk01posible = true
            self.walk02posible = true
        }
        
        if playerdirection == false{
            for m in 0...Atime.count - 1{
                for n in 0...2{
                    if n != 1{
                        allmove[m][n] = -allmove[m][n]
                        bodymove[m][n] = -bodymove[m][n]
                        leg1move[m][n] = -leg1move[m][n]
                        leg2move[m][n] = -leg2move[m][n]
                        arm1move[m][n] = -arm1move[m][n]
                        arm2move[m][n] = -arm2move[m][n]
                    }
                }
            }
        }
        var bodyAction:SKAction!
        var leg1Action:SKAction!
        var leg2Action:SKAction!
        var arm1Action:SKAction!
        var arm2Action:SKAction!
        
        for m in 0...Atime.count - 1{
            for n in 0...2{
                //各部分の移動距離の計算
                if m < Atime.count - 1 && n != 2{
                    allmove[m + 1][n] += allmove[m][n]
                }
                switch n{
                case 0:bodymove[m][0] = (bodymove[m][0] + allmove[m][0]) * ww + px
                leg1move[m][0] = (leg1move[m][0] + allmove[m][0]) * ww + px
                leg2move[m][0] = (leg2move[m][0] + allmove[m][0]) * ww + px
                arm1move[m][0] = (arm1move[m][0] + allmove[m][0]) * ww + px
                arm2move[m][0] = (arm2move[m][0] + allmove[m][0]) * ww + px
                case 1:bodymove[m][1] = (bodymove[m][1] + allmove[m][1]) * ww + py
                leg1move[m][1] = (leg1move[m][1] + allmove[m][1]) * ww + py
                leg2move[m][1] = (leg2move[m][1] + allmove[m][1]) * ww + py
                arm1move[m][1] = (arm1move[m][1] + allmove[m][1]) * ww + py
                arm2move[m][1] = (arm2move[m][1] + allmove[m][1]) * ww + py
                case 2:bodymove[m][2] = (bodymove[m][2] + allmove[m][2]) * psita
                leg1move[m][2] = (leg1move[m][2] + allmove[m][2]) * psita
                leg2move[m][2] = (leg2move[m][2] + allmove[m][2]) * psita
                arm1move[m][2] = (arm1move[m][2] + allmove[m][2]) * psita
                arm2move[m][2] = (arm2move[m][2] + allmove[m][2]) * psita
                default: break
                }
            }
            //アクションの作成
            let bodyA = SKAction.group([SKAction.move(to: CGPoint(x: bodymove[m][0], y: bodymove[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: bodymove[m][2], duration: Atime[m], shortestUnitArc: true)])
            let leg1A = SKAction.group([SKAction.move(to: CGPoint(x: leg1move[m][0], y: leg1move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: leg1move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let leg2A = SKAction.group([SKAction.move(to: CGPoint(x: leg2move[m][0], y: leg2move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: leg2move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let arm1A = SKAction.group([SKAction.move(to: CGPoint(x: arm1move[m][0], y: arm1move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: arm1move[m][2], duration: Atime[m], shortestUnitArc: true)])
            let arm2A = SKAction.group([SKAction.move(to: CGPoint(x: arm2move[m][0], y: arm2move[m][1]), duration: Atime[m])
                ,SKAction.rotate(toAngle: arm2move[m][2], duration: Atime[m], shortestUnitArc: true)])
            
            if m == 0{
                bodyAction = SKAction.sequence([firstAction,bodyA])
                leg1Action = leg1A
                leg2Action = leg2A
                arm1Action = arm1A
                arm2Action = arm2A
            }else{
                if m == 1 || m == 3{ bodyAction = SKAction.sequence([bodyAction,bodyA,BGMA]) }
                else{ bodyAction = SKAction.sequence([bodyAction,bodyA]) }
                leg1Action = SKAction.sequence([leg1Action,leg1A])
                leg2Action = SKAction.sequence([leg2Action,leg2A])
                arm1Action = SKAction.sequence([arm1Action,arm1A])
                arm2Action = SKAction.sequence([arm2Action,arm2A])
            }
        }
        
        bodyAction = SKAction.sequence([bodyAction,endAction])
        let exAction = SKAction.run {
            self.body.run(bodyAction, withKey: "bodyAction")
            self.leg11.run(leg1Action, withKey: "leg1Action")
            self.leg21.run(leg2Action, withKey: "leg2Action")
            self.arm11.run(arm1Action, withKey: "arm1Action")
            self.arm21.run(arm2Action, withKey: "arm2Action")
        }
        run(exAction)
    }
    func wakeupAction(){
        let time = 0.5
        var bodymove:[[CGFloat]]!
        var leg1move:[[CGFloat]]!
        var leg2move:[[CGFloat]]!
        var arm1move:[[CGFloat]]!
        var arm2move:[[CGFloat]]!
        let Atime:[Double] = [time,time] //アクション時間
        //[x,y,θ]
        //うつ伏せモーション
        if (rightSflag1 && playerdirection) || (leftSflag1 && playerdirection == false){
            bodymove = [[-30,-50,-90],[0,0,0]] //胴体の動作
            leg1move = [[0,-90,-90],[0,-50,0]] //右足の動作
            leg2move = [[0,-50,0],[0,-50,0]] //左足の動作
            arm1move = [[10,-50,10],[10,35,160]] //右手の動作
            arm2move = [[10,-50,10],[0,30,0]] //左手の動作
        }
        //仰向けモーション
        if (rightSflag1 && playerdirection == false) || (leftSflag1 && playerdirection){
            bodymove = [[-30,-40,-10],[0,0,0]] //胴体の動作
            leg1move = [[-10,-55,5],[0,-50,0]] //右足の動作
            leg2move = [[-10,-55,5],[0,-50,0]] //左足の動作
            arm1move = [[-25,-60,-10],[10,35,160]] //右手の動作
            arm2move = [[-25,-60,-10],[0,30,0]] //左手の動作
        }
        Actionlock = true
        playerGravityOFF()
        Sensorlock = true
        rightSflag1 = false
        leftSflag1 = false
        
        let lastAction = SKAction.run {
            self.Actionlock = false
            self.Sensorlock = false
            self.standardAction()
        }
        PlayToAction(move: leg1move, dischange: true, moveing: true, object: leg11, lastAction: nil, time: Atime)
        PlayToAction(move: leg2move, dischange: true, moveing: true, object: leg21, lastAction: nil, time: Atime)
        PlayToAction(move: arm1move, dischange: true, moveing: true, object: arm11, lastAction: nil, time: Atime)
        PlayToAction(move: arm2move, dischange: true, moveing: true, object: arm21, lastAction: nil, time: Atime)
        PlayToAction(move: bodymove, dischange: true, moveing: true, object: body, lastAction: lastAction, time: Atime)
    }
    
    func stopAction(){
        if let walkAction = body.action(forKey: "bodyAction"){
            walkAction.speed = 0
            body.run(SKAction.moveBy(x: 0, y: 0, duration: 0.01), withKey: "bodyAction")
        }
        if let walkAction = leg11.action(forKey: "leg1Action"){
            walkAction.speed = 0
            leg11.run(SKAction.moveBy(x: 0, y: 0, duration: 0.01), withKey: "leg1Action")
        }
        if let walkAction = leg21.action(forKey: "leg2Action"){
            walkAction.speed = 0
            leg21.run(SKAction.moveBy(x: 0, y: 0, duration: 0.01), withKey: "leg2Action")
        }
        if let walkAction = arm11.action(forKey: "arm1Action"){
            walkAction.speed = 0
            arm11.run(SKAction.moveBy(x: 0, y: 0, duration: 0.01), withKey: "arm1Action")
        }
        if let walkAction = arm21.action(forKey: "arm2Action"){
            walkAction.speed = 0
            arm21.run(SKAction.moveBy(x: 0, y: 0, duration: 0.01), withKey: "arm2Action")
        }
    }
    
    
    func stopAction2(){
        body.removeAllActions()
        leg11.removeAllActions()
        leg21.removeAllActions()
        arm11.removeAllActions()
        arm21.removeAllActions()
    }
    
    func speedup(){
        if let walkAction = body.action(forKey: "bodyAction"){
            walkAction.speed = 2.0
        }
        if let walkAction = leg11.action(forKey: "leg1Action"){
            walkAction.speed = 2.0
        }
        if let walkAction = leg21.action(forKey: "leg2Action"){
            walkAction.speed = 2.0
        }
        if let walkAction = arm11.action(forKey: "arm1Action"){
            walkAction.speed = 2.0
        }
        if let walkAction = arm21.action(forKey: "arm2Action"){
            walkAction.speed = 2.0
        }
    }
    
    func speeddown(){
        if let walkAction = body.action(forKey: "bodyAction"){
            walkAction.speed = 1
        }
        if let walkAction = leg11.action(forKey: "leg1Action"){
            walkAction.speed = 1
        }
        if let walkAction = leg21.action(forKey: "leg2Action"){
            walkAction.speed = 1
        }
        if let walkAction = arm11.action(forKey: "arm1armwalk"){
            walkAction.speed = 1
        }
        if let walkAction = arm21.action(forKey: "arm2Action"){
            walkAction.speed = 1
        }
    }
    
    func bodyLeftChangeAction(time: Double,interval:Double){
        let atime = time / 36.0
        let leftchangeAction = SKAction.animate(with: leftbody, timePerFrame: atime)
        let waitAction = SKAction.wait(forDuration: interval)
        let CPLAction = SKAction.sequence([waitAction,leftchangeAction])
        body.run(CPLAction)
    }
    
    func bodyRightChangeAction(time: Double,interval:Double){
        let atime = time / 36.0
        let rightchangeAction = SKAction.animate(with: rightbody, timePerFrame: atime)
        let waitAction = SKAction.wait(forDuration: interval)
        let CPLAction = SKAction.sequence([waitAction,rightchangeAction])
        body.run(CPLAction)
    }
    
    func kamaRLChange(time: Double,interval:Double){
        let atime = time / 32.0
        let abodytime = time / 2.0
        let waitAction = SKAction.wait(forDuration: interval)
        var kamaCA: SKAction!
        var ChangePhysics: SKAction!
        if playerdirection{
            kamaCA = SKAction.animate(with: kamaA1R, timePerFrame: atime)
            ChangePhysics = SKAction.run {
                self.kamaR.physicsBody?.categoryBitMask = self.weaponCategory
                self.kamaR.physicsBody?.contactTestBitMask = self.weaponCT
                self.kamaR.physicsBody?.collisionBitMask = self.weaponCo
                self.kamaL.physicsBody?.categoryBitMask = 0
                self.kamaL.physicsBody?.contactTestBitMask = 0
                self.kamaL.physicsBody?.collisionBitMask = 0
            }
        }
        else{
            kamaCA = SKAction.animate(with: kamaA1L, timePerFrame: atime)
            ChangePhysics = SKAction.run {
                self.kamaR.physicsBody?.categoryBitMask = 0
                self.kamaR.physicsBody?.contactTestBitMask = 0
                self.kamaR.physicsBody?.collisionBitMask = 0
                self.kamaL.physicsBody?.categoryBitMask = self.weaponCategory
                self.kamaL.physicsBody?.contactTestBitMask = self.weaponCT
                self.kamaL.physicsBody?.collisionBitMask = self.weaponCo
            }
        }
        
        let smallAction = SKAction.scaleX(to: self.kamaXscale * 0.1, duration: abodytime)
        let bigAction = SKAction.scaleX(to: self.kamaXscale, duration: abodytime)
        let kamabodyAction = SKAction.sequence([waitAction,smallAction,ChangePhysics,bigAction])
        let KamaAction = SKAction.sequence([waitAction,kamaCA])
        kamaR.run(kamabodyAction)
        kamaL.run(kamabodyAction)
        arm11.run(KamaAction)
    }
    
    func Leg1ChangeRAction(time:Double,interval:Double){
        let atime = time / 24.0
        let rightchangeAction = SKAction.animate(with: rightleg, timePerFrame: atime)
        let waitAction = SKAction.wait(forDuration: interval)
        let CPLAction = SKAction.sequence([waitAction,rightchangeAction])
        leg11.run(CPLAction)
    }
    
    func Leg1ChangeLAction(time:Double,interval:Double){
        let atime = time / 24.0
        let leftchangeAction = SKAction.animate(with: leftleg, timePerFrame: atime)
        let waitAction = SKAction.wait(forDuration: interval)
        let CPLAction = SKAction.sequence([waitAction,leftchangeAction])
        leg11.run(CPLAction)
    }
    
    func Leg2ChangeRAction(time:Double,interval:Double){
        let atime = time / 24.0
        let rightchangeAction = SKAction.animate(with: rightleg, timePerFrame: atime)
        let waitAction = SKAction.wait(forDuration: interval)
        let CPLAction = SKAction.sequence([waitAction,rightchangeAction])
        leg21.run(CPLAction)
    }
    
    func Leg2ChangeLAction(time:Double,interval:Double){
        let atime = time / 24.0
        let leftchangeAction = SKAction.animate(with: leftleg, timePerFrame: atime)
        let waitAction = SKAction.wait(forDuration: interval)
        let CPLAction = SKAction.sequence([waitAction,leftchangeAction])
        leg21.run(CPLAction)
    }
    
    func addenemyAction(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,CFenemy: Bool = false,StartSwitchNumber n1:Int,SwitchNumber n2:Int = 0){
        let playAction = SKAction.run { self.addenemy(xp: xp, yp: yp, type: type, HP: HP, Damage: Damage, direction: direction, maxn: maxn, interval: interval, CFenemy: CFenemy, SwitchNumber: n2 ,Actionflag: true) }
        if HowToClear == 2 || (HowToClear == 3 && CFenemy) {
            if enemyCC > 0     { enemyCC += maxn }
            if enemyCC == -100 { enemyCC = maxn }
        }
        BlockAction.append(playAction)
        BlockActionNumber[n1] = BlockAction.count - 1
    }
    
    func addenemyAction(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,CFenemy: Bool = false,StartSwitchNumber n1:Int,SwitchNumber n2:[Int]){
        let playAction = SKAction.run { self.addenemy(xp: xp, yp: yp, type: type, HP: HP, Damage: Damage, direction: direction, maxn: maxn, interval: interval, CFenemy: CFenemy, SwitchNumber: n2, Actionflag: true) }
        if HowToClear == 2 || (HowToClear == 3 && CFenemy) {
            if enemyCC > 0     { enemyCC += maxn }
            if enemyCC == -100 { enemyCC = maxn }
        }
        BlockAction.append(playAction)
        BlockActionNumber[n1] = BlockAction.count - 1
    }

    func addinoutAction(outinterval: Double, ininterval: Double ,firstinterval:Double , BlockNumber n1:Int,type: Int = 1 ,outtime: Double = 1.0, intime: Double = 0.0, SwitchNumbet n2: Int = 0,outcontact: Bool = true,incontact: Bool = false){
        let inoutA = Block[BlockNumber[n1] - 1]
        let categoryB = inoutA.physicsBody?.categoryBitMask
        let collisionB = inoutA.physicsBody?.collisionBitMask
        let contacttestB = inoutA.physicsBody?.contactTestBitMask
        
        let outbody = SKAction.run {
            inoutA.physicsBody?.categoryBitMask = 0
            inoutA.physicsBody?.collisionBitMask = 0
            inoutA.physicsBody?.contactTestBitMask = 0
        }
        let inbody = SKAction.run {
            inoutA.physicsBody?.categoryBitMask = categoryB!
            inoutA.physicsBody?.collisionBitMask = collisionB!
            inoutA.physicsBody?.contactTestBitMask = contacttestB!
        }
        var inAction = SKAction.fadeIn(withDuration: intime)
        var outAction = SKAction.fadeOut(withDuration: outtime)
        
        if incontact{ inAction = SKAction.sequence([inbody,inAction]) }
        else        { inAction = SKAction.sequence([inAction,inbody]) }
        
        if outcontact{ outAction = SKAction.sequence([outAction,outbody]) }
        else         { outAction = SKAction.sequence([outbody,outAction]) }
        
        let IwaitAction = SKAction.wait(forDuration: ininterval)
        let OwaitAction = SKAction.wait(forDuration: outinterval)
        let FwaitAction = SKAction.wait(forDuration: firstinterval)
        
        var inoutAction: SKAction!
        if type == 1{
            run(outbody)
            inoutA.alpha = 0
            inoutAction = SKAction.sequence([inAction,OwaitAction,outAction,IwaitAction])
            inoutAction = SKAction.repeatForever(inoutAction)
            inoutAction = SKAction.sequence([FwaitAction,inoutAction])
        }else if type == 2{
            inoutAction = SKAction.sequence([outAction,IwaitAction,inAction,OwaitAction])
            inoutAction = SKAction.repeatForever(inoutAction)
            inoutAction = SKAction.sequence([FwaitAction,inoutAction])
        }else if type == 3{
            run(outbody)
            inoutA.alpha = 0
            inoutAction = SKAction.sequence([FwaitAction,inAction])
        }else if type == 4{
            inoutAction = SKAction.sequence([FwaitAction,outAction])
        }
        
        let playAction = SKAction.run { inoutA.run(inoutAction) }
        if n2 == 0{ run(playAction) }
        else {
            BlockAction.append(playAction)
            BlockActionNumber[n2] = BlockAction.count - 1
        }
    }
  
    func addmoveAction(xmove: CGFloat, ymove: CGFloat, time: Double ,BlockNumber n1:Int,interval time2: Double = 0.0,firstinterval time3:Double = 0.0,type:Int = 1,SwitchNumber n2:Int = 0){
        let mA = Block[BlockNumber[n1] - 1]      //動かすオブジェクト
        let obx = mA.position.x                  //オブジェクトのx座標
        let oby = mA.position.y                  //オブジェクトのy座標
        let mxp = obx + CGFloat(xmove) * h / 10  //
        let myp = oby + CGFloat(ymove) * h / 10  //
        
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: time)
        let rmoveAction = SKAction.move(to: CGPoint(x: obx, y: oby), duration: time)
        let waitAction = SKAction.wait(forDuration: time2)
        let firstwaitAction = SKAction.wait(forDuration: time3)
        let repositionAction = SKAction.run { mA.position = CGPoint(x: obx, y: oby) }
        
        var mAction: SKAction!
        if type == 1{
            mAction = SKAction.sequence([moveAction,waitAction,rmoveAction,waitAction])
            mAction = SKAction.repeatForever(mAction)
            mAction = SKAction.sequence([firstwaitAction,mAction])
        }else if type == 2{
            mAction = SKAction.sequence([firstwaitAction,moveAction,waitAction,rmoveAction])
            mAction = SKAction.repeatForever(mAction)
        }else if type == 3{
            mAction = SKAction.sequence([firstwaitAction,moveAction,waitAction,repositionAction])
            mAction = SKAction.repeatForever(mAction)
        }
        
        let playAction = SKAction.run { mA.run(mAction) }
        
        if n2 == 0{ run(playAction) }
        else {
            BlockAction.append(playAction)
            BlockActionNumber[n2] = BlockAction.count - 1
        }
    }
    
    func addrotateAction(dsita: CGFloat,time: Double,BlockNumber n1:Int, type:Int = 1, interval time2:Double,firstinterval time3:Double,SwitchNumber n2:Int = 0,OriginxOffset Ox: CGFloat = 0,OriginyOffset Oy: CGFloat = 0){
        let rA = Block[BlockNumber[n1] - 1]
        let angle = dsita * psita
        let Fsita = rA.zRotation
        
        let rotateAction = SKAction.rotate(byAngle: angle, duration: time)
        let RrotateAction = SKAction.rotate(byAngle: -angle, duration: time)
        let waitAction = SKAction.wait(forDuration: time2)
        let FwaitAciton = SKAction.wait(forDuration: time3)
        let repAction = SKAction.run { rA.zRotation = Fsita }
        
        var OFflag = false
        if Ox != 0 || Oy != 0{
            OFflag = true
        }
        var rAction: SKAction!
        if type == 1{
            rAction = SKAction.sequence([rotateAction,waitAction])
            rAction = SKAction.repeatForever(rAction)
            rAction = SKAction.sequence([FwaitAciton,rAction])
        }else if type == 2{
            rAction = SKAction.sequence([rotateAction,waitAction,RrotateAction,waitAction])
            rAction = SKAction.repeatForever(rAction)
            rAction = SKAction.sequence([FwaitAciton,rAction])
        }else if type == 3{
            rAction = SKAction.sequence([FwaitAciton,rotateAction,waitAction,RrotateAction])
            rAction = SKAction.repeatForever(rAction)
        }else if type == 4{
            rAction = SKAction.sequence([FwaitAciton,rotateAction,waitAction,repAction])
            rAction = SKAction.repeatForever(rAction)
        }
        var playAction: SKAction!
        if OFflag{ //原点オフセットがある場合
            let f = SKShapeNode(circleOfRadius: 1)
            f.position = CGPoint(x: rA.position.x + Ox * h / 10, y: rA.position.y + Oy * h / 10)
            f.physicsBody = SKPhysicsBody(circleOfRadius: 1)
            f.physicsBody?.isDynamic = false
            f.physicsBody?.affectedByGravity = false
            f.physicsBody?.categoryBitMask = 0
            f.physicsBody?.collisionBitMask = 0
            f.physicsBody?.contactTestBitMask = 0
            addChild(f)
            rA.physicsBody?.affectedByGravity = true
            rA.physicsBody?.isDynamic = true
            let jointA = SKPhysicsJointPin.joint(withBodyA: rA.physicsBody!, bodyB: f.physicsBody!, anchor: rA.position)
            physicsWorld.add(jointA)
            let jointB = SKPhysicsJointPin.joint(withBodyA: rA.physicsBody!, bodyB: f.physicsBody!, anchor: f.position)
            physicsWorld.add(jointB)
            playAction = SKAction.run { f.run(rAction) }
        }else { playAction = SKAction.run { rA.run(rAction) } }  //原点オフセットがない場合
        
        if n2 == 0{ run(playAction) }
        else {
            BlockAction.append(playAction)
            BlockActionNumber[n2] = BlockAction.count - 1
        }
    }
    
}
