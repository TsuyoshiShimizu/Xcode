//
//  Action.swift
//  gravity
//
//  Created by 清水健志 on 2018/08/27.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import GameplayKit

class Action:object{
    //2¥プレイヤーダメージ
    func playerDamageA(damage: Int){
        if SEfirst[1]{ ReadBodySE(Number: 1, named: "pdame", type: "wav") }
        catHP -= damage
        viewnode.ChangeHPbar(pHP: catHP)
        body.PlaySE(number: SENumber[1])
        playerInvincible(time: 2.0)
   
        if catHP <= 0 && PracticeFlag == false{
            gameover()
        }else if catHP <= 0{
            if BarJumpflag == true || BarMoveflag == true{
                stopAction()
                BarJumpflag = false
                BarMoveflag = false
                physicsWorld.remove(self.BarJoint[0])
                BarJoint.removeAll()
            }
            WarpAction(P: PraRPoint, type: 2)
            catHP = catMaxHP
            catMP = catMaxMP
            viewnode.ChangeHPbar(pHP: catHP)
            viewnode.ChangeMPbar(pMP: catMP)
            Actionlock = false
            Sensorlock = false
        }
    }

    //2¥敵ダメージ
    func enemyDamageA(Eobject: SKNode,Dobject:SKNode){
//ダメージ量の計算
        //1:打 2:火 3:氷 4:風
        let Dtype = Dobject.GetInt(name: "Dtype")                           //ダメージエフェクトのタイプ
        var Damage = Dobject.GetInt(name: "damage")                         //ダメージエフェクトのダメージ量
        let damagetype = Eobject.GetInt(name: "dtype")
        let Etype = Eobject.GetInt(name: "type")
        //1:通常 2:弱点 3:耐性 4:無効
        var damageE = 1
        
        if       damagetype == 2{
            damageE = 4
        }else if damagetype == 3{
            damageE = 3
        }else if damagetype == 4{
            if Dtype == 4{ damageE = 2 }
            if Dtype == 3{ damageE = 3 }
        }else if damagetype == 5{
            if Dtype == 2{ damageE = 2 }
            if Dtype == 4{ damageE = 3 }
        }else if damagetype == 6{
            if Dtype == 3{ damageE = 2 }
            if Dtype == 2{ damageE = 3 }
        }else if damagetype == 7{
            if Dtype == 1{ damageE = 3 }
        }else if damagetype == 8{
            if Dtype == 4{ damageE = 2 }
            if Dtype == 2 && Dtype == 3{ damageE = 3 }
            if Dtype == 1{ damageE = 4 }
        }else if damagetype == 9{
            if Dtype == 2{ damageE = 3 }
            if Dtype == 3{ damageE = 4 }
        }else if damagetype == 10{
            if Dtype == 3{ damageE = 3 }
            if Dtype == 4{ damageE = 4 }
        }else if damagetype == 11{
            if Dtype == 4{ damageE = 3 }
            if Dtype == 2{ damageE = 4 }
        }else if damagetype == 12{
            if Dtype != 1{ damageE = 3 }
        }else if damagetype == 13{
            if Dtype != 1{ damageE = 4 }
        }else if damagetype == 14{
            if Dtype != 2{ damageE = 4 }
            else         { damageE = 2 }
        }else if damagetype == 15{
            if Dtype != 3{ damageE = 4 }
            else         { damageE = 2 }
        }else if damagetype == 16{
            if Dtype != 4{ damageE = 4 }
            else         { damageE = 2 }
        }else if damagetype == 17{
            if Dtype != 1{ damageE = 4 }
            else         { damageE = 2 }
        }else if damagetype == 18{
            if Dtype != 1{ damageE = 4 }
        }
        
        if damageE == 2{ Damage = Damage + 30 }
        if damageE == 3{ Damage = Damage / 2 }
        if damageE == 4{ Damage = 0}
        
        let enemyHP = Eobject.GetInt(name: "HP")  - Damage  //敵HPの計算
        Eobject.SetInt(name: "HP", Int: enemyHP)
        //プレイヤー位置
        let pp = playerBlock.position
        let ep = Eobject.position
        
        //MP回復処理
        if MPAttack{
            var a: Int = 0
            if skillOn[11] && skillOn[12]{
                a = 15
            }else if (skillOn[11] && skillOn[12] == false) || (skillOn[11] == false && skillOn[12]) {
                a = 10
            }else{
                a = 5
            }
            if PracticeFlag{ a = a * 3 }
            catMP += a ;if catMP >= catMaxMP { catMP = catMaxMP }
            viewnode.ChangeMPbar(pMP: catMP)
        }
        
        if enemyHP <= 0{          //敵HPがゼロになった時の処理
            BGMplay(BGM: Hit3BGM)                           //敵の消去音を再生
            let APSize = Eobject.GetCGFloat(name: "APSize") //敵の消失エフェクトざサイズを取得
            enemydelete(kill: true, object: Eobject)        //敵を消去する関数の呼び出し
            
            if Etype == 10 || Etype == 20 || Etype == 30 || (41 <= Etype && Etype <= 46){
                BossVFlag = false
                BossViewFlag = false
                if BossVector != nil { BossVector.position = CGPoint(x: 2 * w , y: h) }
            }
            
            let enemyDE = SKSpriteNode(texture: enemyDe[0])
            enemyDE.position = ep
            enemyDE.scale(to: CGSize(width: BSize * APSize, height: BSize * APSize))
            enemyDE.zPosition = 1
            addChild(enemyDE)
            let enemyDEAnime = SKAction.animate(with: enemyDe, timePerFrame: 0.6 / 10.0)
            let deleteA = SKAction.removeFromParent()
            enemyDE.run(SKAction.sequence([enemyDEAnime,deleteA]))
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
         
            
            if damageE == 1{
                BGMplay(BGM: Hit1BGM)
                run(flashAction)
            }else if damageE == 2{
                BGMplay(BGM: Hit2BGM)
                run(flashAction)
                //弱点エフェクト
                let EE = SKSpriteNode(texture: enemyDE1[0])
                EE.scale(to: CGSize(width: Eobject.frame.size.width * 1.2, height: Eobject.frame.size.width * 1.2))
                EE.position = Eobject.position
                EE.zPosition = 10
                addChild(EE)
                let anime = SKAction.animate(with: enemyDE1, timePerFrame: 0.5 / Double(enemyDE1.count) )
                let remove = SKAction.removeFromParent()
                EE.run( SKAction.sequence([anime,remove]) )
            }else if damageE == 3{
                BGMplay(BGM: Hit4BGM)
                run(flashAction)
                //耐性エフェクト
                let EE = SKSpriteNode(texture: enemyDE2[0])
                EE.scale(to: CGSize(width: Eobject.frame.size.width * 1.2, height: Eobject.frame.size.width * 1.2))
                EE.position = Eobject.position
                EE.zPosition = 10
                addChild(EE)
                let anime = SKAction.animate(with: enemyDE2, timePerFrame: 0.5 / Double(enemyDE2.count) )
                let remove = SKAction.removeFromParent()
                EE.run( SKAction.sequence([anime,remove]) )
            }else if damageE == 4{
                BGMplay(BGM: Hit5BGM)
                //無効エフェクト
                let EE = SKSpriteNode(texture: enemyDE3[0])
                EE.scale(to: CGSize(width: Eobject.frame.size.width * 1.2, height: Eobject.frame.size.width * 1.2))
                EE.position = Eobject.position
                EE.zPosition = 10
                addChild(EE)
                let anime = SKAction.animate(with: enemyDE3, timePerFrame: 0.5 / Double(enemyDE3.count) )
                let remove = SKAction.removeFromParent()
                EE.run( SKAction.sequence([anime,remove]) )
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                Eobject.SetBool(name: "damageflag", Bool: true)
            }
            
            if 42 <= Etype && Etype <= 44{
                Eobject.SetInt(name: "dtype", Int: 2)
                BossEffectChange(type: 1)
            }
        }
    }
    
    //2¥プレイヤー無敵設定
    func playerInvincible(time: Double){
        let offAction = SKAction.run {
            for n in 0...2{
                self.LegFR[n].alpha = 0
                self.LegFL[n].alpha = 0
                self.LegBR[n].alpha = 0
                self.LegBL[n].alpha = 0
            }
            for n in 0...7{ self.taleS[n].alpha = 0 }
            if self.playerDflag == false{ self.body.alpha = 0 }
        }
        
        let onAction = SKAction.run {
            if self.playerDflag == false{
                if self.playerdirection{
                    for n in 0...3{ self.taleS[n].alpha = 1 }
                }else{
                    for n in 4...7{ self.taleS[n].alpha = 1 }
                }
                for n in 0...2{
                    self.LegFR[n].alpha = 1
                    self.LegFL[n].alpha = 1
                    self.LegBR[n].alpha = 1
                    self.LegBL[n].alpha = 1
                }
                self.body.alpha = 1
            }
        }
        let lastAction = SKAction.run {
            self.playerDamageflag2 = true
        }
        let waitAction = SKAction.wait(forDuration: 0.1)
        var flashingAction = SKAction.sequence([offAction,waitAction,onAction,waitAction])
        let flashiCount = Int(time / 0.2)
        flashingAction = SKAction.repeat(flashingAction, count: flashiCount)
        run(SKAction.sequence([flashingAction,lastAction]))
    }
    
//2¥地上弱攻撃
    func attack01Action(){
        print("地上弱攻撃開始")
        let Da = catAttack
        MPAttack = true
        MPRflag = false
        let time: [Double] = [0.2 ,0.1 ,0.1]
        let move:[[CGFloat]] = [[30,50] ,[50,40] ,[70,40]]
        let BRsita: [[CGFloat]] = [[90,60,0] ,[45,0,-45] ,[0,-0,-60]]
        let BLsita: [[CGFloat]] = [[90,60,0] ,[90,90,0] ,[90,45,0]]
        let FRsita: [[CGFloat]] = [[170,170,170] ,[90,90,90] ,[30,30,30]]
        let FLsita: [[CGFloat]] = [[80,0,0] ,[80,0,0] ,[80,0,0]]
        let bodysita: [CGFloat] = [70 ,35 ,0 ]
        let lastAction =  SKAction.run {
            self.AttackComboAccess[1] = false
            if self.AttackCombofalg[1] && self.skillOn[2]{
                self.AttackCombofalg[1] = false
                print("地上弱攻撃終了")
                self.attack02Action()
            }else{
                self.MPRflag = true
                self.AttackCombofalg[1] = false
                self.MPAttack = false
                print("地上弱攻撃終了")
                self.standardAction()
            }
        }
        //効果音設定
        let EffectP:[CGFloat] = [1.0 , 0.1]
        let EffectS:CGFloat = 1.5
        let EffectTime = 0.2
        if SEfirst[2]{ ReadBodySE(Number: 2, named: "Attack01", type: "wav") }  //SE読み込み
        AttackComboAccess[1] = true
        
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction)
        self.run(SKAction.wait(forDuration: 0.2)){
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 10, time: EffectTime, Number: 1, SObject: self.playerBlock,Damage: Da,DamageType: 1)
            self.body.PlaySE(number: self.SENumber[2])
        }
    }
    
    
    //2¥地上強攻撃
    func attack02Action(){
        print("地上強攻撃開始")
        let Da = catAttack + 10
        let time: [Double] = [0.2 ,0.1 ,0.1 ,0.1 ,0.1 ,0.1 ,0.1 ,0.1 ,0.1]
        let move:[[CGFloat]] = [[30,50],[30,50],[30,50],[30,50],[30,50],[30,50],[30,50] ,[50,40] ,[70,40]]
        let BRsita: [[CGFloat]] = [[90,60,0] ,[90,60,0] ,[90,60,0] ,[90,60,0] ,[90,60,0] ,[90,60,0] ,[90,60,0],[90,90,0] ,[90,45,0]]
        let BLsita: [[CGFloat]] = [[90,60,0] ,[90,90,0] ,[90,60,0] ,[90,60,0] ,[90,60,0] ,[90,60,0] ,[90,60,0],[45,0,-45] ,[0,-0,-60]]
        let FRsita: [[CGFloat]] = [[170,170,170] ,[90,90,90] ,[30,30,30] ,[170,170,30] ,[170,170,170],[90,90,90] ,[80,0,0] ,[80,0,0] ,[80,0,0]]
        let FLsita: [[CGFloat]] = [[30,30,30] ,[170,170,30] ,[170,170,170] ,[90,90,90] ,[30,30,30] ,[170,170,30] ,[170,170,170] ,[90,90,90] ,[30,30,30]]
        let bodysita: [CGFloat] = [70 ,70 ,70 ,70 ,70 ,70 ,70 ,35 ,0 ]
        
        let lastAction =  SKAction.run {
            self.MPRflag = true
            self.MPAttack = false
            print("地上強攻撃終了")
            self.standardAction()
        }
        let EffectP:[CGFloat] = [0.7 , 0.4]
        let EffectS:CGFloat = 5.0
        let EffectTime = 0.85
        
        if SEfirst[3]{ ReadBodySE(Number: 3, named: "Attack02", type: "wav") }  //SE読み込み
        
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction)
        self.run(SKAction.wait(forDuration: 0.2)){
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 10, time: EffectTime, Number: 2, SObject: self.playerBlock,Damage:Da,DamageType: 1)
            self.body.PlaySE(number: self.SENumber[3])
        }
    }
    
    //2¥空中弱攻撃
    func airAttackAction01(){
        print("空中弱攻撃開始")
        let Da = catAttack
        MPAttack = true
        MPRflag = false
        airAfalg = true
        let time: [Double] = [0.2 ,0.2 ,0.2 ,0.2 ,0.2]
        let move:[[CGFloat]] = [[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-90,-90],[-90,-90,-90]]
        let BLsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-90,-90],[-90,-90,-90]]
        let FRsita: [[CGFloat]] = [[90,90,90] ,[90,90,90] ,[90,90,90] ,[90,90,90],[90,90,90]]
        let FLsita: [[CGFloat]] = [[90,90,90] ,[90,90,90] ,[90,90,90] ,[90,90,90],[90,90,90]]
        let bodysita: [CGFloat] = [10 ,10 ,10 ,10 ,10 ]
        let lastAction =  SKAction.run {
            self.AttackComboAccess[3] = false
            self.airAfalg = false
            if self.AttackCombofalg[3] && self.skillOn[4]{
                self.AttackCombofalg[3] = false
                print("ブラ下がりフラグOFF")
                self.Barflag = false
                print("空中弱攻撃終了")
                self.airAttackAction02()
            }else if self.Barflag && self.skillOn[8] && self.PconAfter != 2{
                self.MPAttack = false
                self.MPRflag = true
                self.AttackCombofalg[3] = false
                print("ブラ下がりフラグOFF")
                print("センサロック(ぶら下がり開始)")
                self.Sensorlock = true
                self.BarAction()
            }else{
                self.MPRflag = true
                self.AttackCombofalg[3] = false
                self.MPAttack = false
                print("ブラ下がりフラグOFF")
                self.Barflag = false
                print("プレイヤ重力ON(空弱終了)")
                self.playerGravityON()
                print("アクションロック解除（空弱）")
                self.Actionlock = false
                self.body.run(SKAction.rotate(toAngle: 0, duration: 0.5))
                print("空中弱攻撃終了")
            }
        }
        AttackComboAccess[3] = true
        
        //プレイヤーブロックの動き
        var Rsita: CGFloat = 360 * psita; if playerdirection{ Rsita = -Rsita }
        let RAction = SKAction.rotate(byAngle: Rsita, duration: 0.8)
        let MAction = SKAction.move(to: playerBlock.position, duration: 0.8)
        playerBlock.run(SKAction.group([RAction,MAction]))
      
        let EffectP:[CGFloat] = [0 ,0]
        let EffectS:CGFloat = 5.5
        let EffectbodyS: [CGFloat] = [0.65,0.65]
        let EffectTime = 0.8
        
        if SEfirst[4]{ ReadBodySE(Number: 4, named: "AirAttack01", type: "wav") }  //SE読み込み
        
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction)
        self.run(SKAction.wait(forDuration: 0.2)){
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: -10, time: EffectTime, Number: 3, SObject: self.playerBlock, Damage: Da,DamageType: 1, EBodySize: EffectbodyS, EBodyType: 2)
            self.body.PlaySE(number: self.SENumber[4])
        }
    }
    
    //2¥空中強攻撃
    func airAttackAction02(){
        print("空中強攻撃開始")
        let Da = catAttack + 10
        let time: [Double] = [0.1 ,0.1 ,0.1 ,0.1 ,0.1]
        let move:[[CGFloat]] = [[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-90,-90],[-90,-90,-90]]
        let BLsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-90,-90],[-90,-90,-90]]
        let FRsita: [[CGFloat]] = [[90,90,90] ,[90,90,90] ,[90,90,90] ,[90,90,90],[90,90,90]]
        let FLsita: [[CGFloat]] = [[90,90,90] ,[90,90,90] ,[90,90,90] ,[90,90,90],[90,90,90]]
        let bodysita: [CGFloat] = [10 ,10 ,10 ,10 ,10 ]
        
        let lastAction =  SKAction.run {
            self.MPAttack = false
            print("プレイヤ重力ON(空強終了)")
            self.playerGravityON()
            print("アクションロック解除（空強）")
            self.Actionlock = false
            self.body.run(SKAction.rotate(toAngle: 0, duration: 0.5))
            print("空中弱攻撃終了")
        }

        var Rsita: CGFloat = 360 * psita; if playerdirection{ Rsita = -Rsita }
        let RAction = SKAction.rotate(byAngle: Rsita, duration: 0.4)
        let MAction = SKAction.move(to: playerBlock.position, duration: 0.4)
        playerBlock.run(SKAction.group([RAction,MAction]))
        
        let EffectP:[CGFloat] = [0 , 0]
        let EffectS:CGFloat = 9
        let EffectbodyS: [CGFloat] = [0.8 ,0.8]
        let EffectTime = 0.4
        
        if SEfirst[5]{ ReadBodySE(Number: 5, named: "AirAttack02", type: "wav") }  //SE読み込み

        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction)
        self.run(SKAction.wait(forDuration: 0.2)){
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: -10, time: EffectTime, Number: 4, SObject: self.playerBlock,Damage: Da,DamageType: 1, EBodySize: EffectbodyS,EBodyType: 2)
            self.body.PlaySE(number: self.SENumber[5])
        }
    }
    
    //2¥回避アクション
    func avoidAction(avoideD: Bool){
        print("回避開始")
        //全体の設定
        MPRflag = false
        let time = 0.8    //全体の時間
        let Acount = 4.0  //アクション数
        playerDamageflag = false
        
        let lagtime = time / (Acount + 1.0) //PBとプレイヤーの動きの誤差
        //PBの設定
        var PBrotate: [CGFloat] = [-90,180,90,0]
        var PBmove: [[CGFloat]] = [[1.0,1],[1.0,0],[1.0,0],[1.0,-1]]
    
        //プレイヤの設定
        let move:[[CGFloat]] = [[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[90,80,-60] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-90,-90],[-90,-90,-90]]
        let BLsita: [[CGFloat]] = [[90,80,-60] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-90,-90],[-90,-90,-90]]
        let FRsita: [[CGFloat]] = [[135,135,45] ,[90,90,90] ,[90,90,90] ,[90,90,90],[90,90,90]]
        let FLsita: [[CGFloat]] = [[135,135,45] ,[90,90,90] ,[90,90,90] ,[90,90,90],[90,90,90]]
        let bodysita: [CGFloat] = [45 ,10 ,10 ,10 ,10 ]
        let lastAction =  SKAction.run {
            self.AttackComboAccess[4] = false
            if self.AttackCombofalg[4] && self.skillOn[6]{
                self.AttackCombofalg[4] = false
                print("回避終了")
                self.attack03Action()
            }else{
                self.MPRflag = true
                self.AttackCombofalg[4] = false
                self.playerDamageflag = true
                print("回避終了")
                self.standardAction()
            }
        }
 
        //アクション時間の計算
        let Atime = time - lagtime
        let onetime = Atime / Acount
        var Ptime:[Double] = []
        for n in 0...Int(Acount){
            if n == 1 { Ptime.append(lagtime)}
            else      { Ptime.append(onetime) }
        }
        
        var MAction:SKAction!
        var RAction:SKAction!
        for n in 0..<Int(Acount){
            //角度の変換
            if n == 0 || n == 2{
                if avoideD{ PBrotate[n] =  PBrotate[n] * psita }
                else      { PBrotate[n] = -PBrotate[n] * psita }
            }else{ PBrotate[n] = PBrotate[n] * psita }
            
            //距離の変換
            if avoideD{ PBmove[n][0] =  PBmove[n][0] * PSize }
            else      { PBmove[n][0] = -PBmove[n][0] * PSize }
            PBmove[n][1] = PBmove[n][1] * PSize
            
            //実行アクションの作成
            if n == 0{
                MAction = SKAction.moveBy(x: PBmove[n][0], y: PBmove[n][1], duration: onetime)
                RAction = SKAction.rotate(toAngle: PBrotate[n], duration: onetime, shortestUnitArc: true)
            }else{
                let MAction2 = SKAction.moveBy(x: PBmove[n][0], y: PBmove[n][1], duration: onetime)
                let RAction2 = SKAction.rotate(toAngle: PBrotate[n], duration: onetime, shortestUnitArc: true)
                MAction = SKAction.sequence([MAction,MAction2])
                RAction = SKAction.sequence([RAction,RAction2])
            }
        }
        let PBAction = SKAction.group([RAction,MAction])
        AttackComboAccess[4] = true
        playerBlock.run(PBAction)
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: Ptime, lastAction: lastAction)
    }
    
    //2¥回避攻撃アクション
    func attack03Action(){
        print("回避攻撃開始")
        let Da = catAttack
        MPAttack = true
        //PBの設定
        let PBtime = 0.1
        var dx: CGFloat = 3
        
        //プレイヤーの設定
        let time = 0.3
        let BRsita: [CGFloat] = [90,60,-45]
        let BLsita: [CGFloat] = [90,60,-45]
        let FRsita: [CGFloat] = [80,80,80]
        let FLsita: [CGFloat] = [80,80,80]
        let bodysita: CGFloat = 20
        let move: [CGFloat] = [50,50]
        
        //エフェクトの設定
        let EffectP:[CGFloat] = [1.4 , 0.2]
        let EffectbodyS: [CGFloat] = [1 ,0.5]
        let EffectS:CGFloat = 5.0
        let Effecttime = 0.3
        
        //プレイヤアクション後に実行する操作
        let PlastAction = SKAction.run {
            self.MPRflag = true
            self.MPAttack = false
            self.playerDamageflag = true
            print("回避攻撃終了")
            self.standardAction()
        }
        
        //PBの移動アクションの作成
        if playerdirection { dx = dx * PSize } else { dx = -dx * PSize }
        let moveAction = SKAction.moveBy(x: dx, y: 0, duration: PBtime)
        
        if SEfirst[6]{ ReadBodySE(Number: 6, named: "AvoidAttack", type: "wav") }  //SE読み込み
        
        let PBlastActinn = SKAction.run {
            self.PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: PlastAction)
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 10, time: Effecttime, Number: 5,SObject: self.body,Damage: Da,DamageType: 1 , EBodySize: EffectbodyS)
            self.body.PlaySE(number: self.SENumber[6])        }
        let PBAction = SKAction.sequence([moveAction,PBlastActinn])
        playerBlock.run(PBAction)
    }
    
    //2¥溜め攻撃(必殺技)準備
    func HoldAction(){
        print("溜め開始")
        let EffectP:[CGFloat] = [0,0.4]
        let EffectS:CGFloat = 3
        let Effecttime = 0.7
        var Etype: Int = 0
        if HoldAttackType == 1{ Etype = 6 }
        if HoldAttackType == 2{ Etype = 9 }
        if HoldAttackType == 3{ Etype = 12 }
        
        CreateEffect(Position: EffectP, Size: EffectS, zPosition: 5, time: Effecttime, Number: Etype, SObject: playerBlock, Damage: 0)
        self.run(SKAction.wait(forDuration: Effecttime)){
            if self.Holdflag{
                self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 5, time: 0.8, Number: Etype + 1, SObject: self.playerBlock, Damage: 0, Repeat: true)
                self.HoldActionflag = true
                self.BGMplay(BGM: self.Cat01SE)
            }
        }
    }
    //2¥溜め攻撃(必殺技)1
    func HoldAttack01(){
        print("必殺技開始")
        playerDamageflag = false
        catMP -= 50
        let Da = catAttack * 3 + 20
        MPRflag = false
        viewnode.ChangeMPbar(pMP: catMP)
        
        let time = 0.5
        let BRsita: [CGFloat] = [80,0,0]
        let BLsita: [CGFloat] = [80,0,0]
        let FRsita: [CGFloat] = [80,0,0]
        let FLsita: [CGFloat] = [80,0,0]
        let bodysita: CGFloat = 5
        let move: [CGFloat] = [50,50]
        
        //エフェクトの設定
        let EffectP:[CGFloat] = [3.0 , 0.4]
        let EffectS:CGFloat = 9.0
        let Effecttime = 2.0
        
        //攻撃エフェクトの当たり判定の作成
        let EffectBodySize = EffectS * PSize
        var EffectBody: [SKPhysicsBody] = []
        let EffectStartN = [1,4,9,12]
        let EffectTimeN = [3,5,3,6]
        if playerdirection{
            EffectBody.append(CreateCircleBody(Size: 16, Position: [-24.5,0], StandardSize: EffectBodySize))
            EffectBody.append(CreateCircleBody(Size: 22, Position: [-2.6,0], StandardSize: EffectBodySize))
            EffectBody.append(CreateCircleBody(Size: 24, Position: [14,0], StandardSize: EffectBodySize))
            EffectBody.append(CreateCircleBody(Size: 30, Position: [31,0], StandardSize: EffectBodySize))
        }else{
            EffectBody.append(CreateCircleBody(Size: 16, Position: [24.5,0], StandardSize: EffectBodySize))
            EffectBody.append(CreateCircleBody(Size: 22, Position: [2.6,0], StandardSize: EffectBodySize))
            EffectBody.append(CreateCircleBody(Size: 24, Position: [-14,0], StandardSize: EffectBodySize))
            EffectBody.append(CreateCircleBody(Size: 30, Position: [-31,0], StandardSize: EffectBodySize))
        }
        if Cat01SE.isPlaying{ Cat01SE.stop() } //唸り声を止める
        
        if SEfirst[8]{ ReadBodySE(Number: 8, named: "Cat02", type: "mp3") }  //SE読み込み
        if SEfirst[9]{ ReadBodySE(Number: 9, named: "HoldAttack01", type: "wav") }  //SE読み込み
        let lastAction = SKAction.run {
            self.playerAttackEffect(SObject: self.body, EffectNumber: 8, EPosition: EffectP, ESize: EffectS, Etime: Effecttime, Abody: EffectBody, AStartCN: EffectStartN, AtimeCN: EffectTimeN, Damage: Da, DamageType: 2)
            
            self.body.PlaySE(number: self.SENumber[9])
            self.run(SKAction.wait(forDuration: Effecttime)){
                if self.Effect.isEmpty == false{
                    self.Effect[0].removeFromParent()
                    self.Effect.removeAll()
                }
                self.MPRflag = true
                self.playerDamageflag = true
                self.standardAction()
            }
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
        body.PlaySE(number: SENumber[8])
    }
    //2¥溜め攻撃(必殺技)2
    func HoldAttack02(){
        print("必殺技開始")
        playerDamageflag = false
        catMP -= 100
        let Da = catAttack * 3 + 20
        MPRflag = false
        viewnode.ChangeMPbar(pMP: catMP)
        
        let time = 0.5
        let BRsita: [CGFloat] = [90,60,0]
        let BLsita: [CGFloat] = [90,60,0]
        let FRsita: [CGFloat] = [170,170,170]
        let FLsita: [CGFloat] = [170,170,170]
        let bodysita: CGFloat = 70
        let move: [CGFloat] = [30,50]
        
        //エフェクトの設定
        let EffectP:[CGFloat] = [0 , 1.5]
        let EffectS:CGFloat = 20.0
        let EffectBS:[CGFloat] = [1.0,0.4]
        let Effecttime = 1.0
        
        if Cat01SE.isPlaying{ Cat01SE.stop() }
        if SEfirst[8]{ ReadBodySE(Number: 8, named: "Cat02", type: "mp3") }  //SE読み込み
        if SEfirst[10]{ ReadBodySE(Number: 10, named: "HoldAttack02", type: "wav") }  //SE読み込み
        
        let lastAction = SKAction.run {
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 10, time: Effecttime, Number: 11, SObject: self.playerBlock,Damage:Da ,DamageType: 3, EBodySize: EffectBS)
            self.body.PlaySE(number: self.SENumber[10])
            self.run(SKAction.wait(forDuration: Effecttime)){
                if self.Effect.isEmpty == false{
                    self.Effect[0].removeFromParent()
                    self.Effect.removeAll()
                }
                self.MPRflag = true
                self.playerDamageflag = true
                self.standardAction()
            }
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
        body.PlaySE(number: SENumber[8])
    }
    //2¥溜め攻撃(必殺技)3
    func HoldAttack03(){
        print("必殺技開始")
        playerDamageflag = false
        catMP -= 20
        let Da = catAttack / 2
        viewnode.ChangeMPbar(pMP: catMP)
        
        let time = 0.5
        let BRsita: [CGFloat] = [80,0,0]
        let BLsita: [CGFloat] = [80,0,0]
        let FRsita: [CGFloat] = [80,0,0]
        let FLsita: [CGFloat] = [80,0,0]
        let bodysita: CGFloat = 5
        let move: [CGFloat] = [50,50]
        
        //エフェクトの設定
        let EffectP:[CGFloat] = [0 , 0]
        let EffectS:CGFloat = 4.0
        let EffectBS:[CGFloat] = [1.0,1.0]
        let Effecttime = 1.0
        
        if Cat01SE.isPlaying{ Cat01SE.stop() }
        if SEfirst[8]{ ReadBodySE(Number: 8, named: "Cat02", type: "mp3") }  //SE読み込み
        let lastAction = SKAction.run {
            self.Effect[0].removeFromParent()
            self.Effect.removeAll()
            self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 10, time: Effecttime * 0.2, Number: 14, SObject: self.playerBlock,Damage: Da,DamageType: 4, EBodySize: EffectBS)
            self.run(SKAction.wait(forDuration: Effecttime / 5.0)){
                self.playerDamageflag = true
                self.BGMplay(BGM: self.HoldAttack03SE)
                self.CreateEffect(Position: EffectP, Size: EffectS, zPosition: 10, time: Effecttime * 0.8, Number: 15, SObject: self.body,Damage: Da ,DamageType: 4, EBodySize: EffectBS, EBodyType: 2, Repeat: true)
                let joint = SKPhysicsJointPin.joint(withBodyA: self.body.physicsBody!, bodyB: self.Effect[0].physicsBody!, anchor: self.body.position)
                self.physicsWorld.add(joint)
                print("風アクションフラグON")
                self.windN += 1 ;if self.windN == 5{ self.windN = 0 }
                let WN = self.windN
                self.windflag[WN] = true
                self.windmoveflag = true
                self.playerstatas = 2
                self.run(SKAction.wait(forDuration: 10.0)){
                    if self.windflag[WN]{
                        print("風アクションフラグOFF")
                        self.MPRflag = true
                        self.windflag[WN] = false
                        self.Effect[0].removeFromParent()
                        self.Effect.removeAll()
                        if self.HoldAttack03SE.isPlaying { self.HoldAttack03SE.stop() }
                        self.playerGravityON()
                        print("アクションロック解除(風技時間経過)")
                        self.Actionlock = false
                        print("センサロック解除(風技時間経過)")
                        self.Sensorlock = false
                    }
                }
            }
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
        body.PlaySE(number: SENumber[8])
    }
    
    //2¥ぶら下がりアクション
    func BarAction(){
        print("ブラ下がり開始")
        print("壁登りロック解除")
        climLock = false
        let Bar = BarObject!
        var Tale: SKSpriteNode!
        var BAngle: CGFloat!
        if playerdirection{
            Tale = Rtale
            BAngle = -90 * psita
        }
        else              {
            Tale = Ltale
            BAngle = 90 * psita
        }
        let moveAction = SKAction.move(to: Bar.position, duration: 0.1)
        let lastAction = SKAction.run {
            let Barj = SKPhysicsJointPin.joint(withBodyA: Bar.physicsBody!, bodyB: Tale.physicsBody!, anchor: Bar.position)
            self.physicsWorld.add(Barj)
            self.BarJoint.append(Barj)
            print("ブラ下がりジョイント完了")
            print("プレイヤ重力ON(ぶら下がり開始)")
            self.playerGravityON()
            print("PB物理影響無効化解除(ブラ下がり)")
            self.playerBlock.physicsBody?.isDynamic = true
            self.run(SKAction.wait(forDuration: 0.5)){
                self.BarMoveflag = true
            }
        }
        
        let BmoveAction = SKAction.move(to: CGPoint(x: BarObject.position.x, y: BarObject.position.y - PSize), duration: 0.1)
        let BrotateAction = SKAction.rotate(toAngle: BAngle, duration: 0.1, shortestUnitArc: true)
        let BodyAction = SKAction.group([BmoveAction,BrotateAction])
        let moveAction2 = SKAction.sequence([moveAction,lastAction])
        print("PB物理影響無効化(ブラ下がり)")
        playerBlock.physicsBody?.isDynamic = false
        playerBlock.run(moveAction)
        Tale.run(moveAction2)
        body.run(BodyAction)
    }
    
    func BarMove(P:CGPoint){
        print("ぶら下がりムーブ開始")
        if BarJumpflag == false{
            playerGravityOFF()
            Standerdanglemovement()
            BarJumpflag = true
        }
        var Dis: CGFloat = 2.5
        let lastAction = SKAction.run {
            self.BarMoveflag = true
        }
        let sita = angle(p1: BarObject.position, p2: P)
        
        var bodyAngle: CGFloat!
        if playerdirection{
            bodyAngle = sita - 90 * psita
        }else{
            bodyAngle = sita + 90 * psita
        }
        if      bodyAngle <= -180 * psita { bodyAngle += 360 * psita }
        else if bodyAngle >   180 * psita { bodyAngle -= 360 * psita }
        
        Dis = Dis * PSize
        let BarDis = distance(p1: P, p2: BarObject.position)
        var moveAction: SKAction!
        if BarDis <= Dis{
            moveAction = SKAction.move(to: P, duration: 0.1)
        }else{
            let dx = sin(sita) * Dis + BarObject.position.x
            let dy = -cos(sita) * Dis + BarObject.position.y
            moveAction = SKAction.move(to: CGPoint(x: dx, y: dy), duration: 0.1)
        }
        let rotateAction = SKAction.rotate(toAngle: bodyAngle, duration: 0.1, shortestUnitArc: true)
        let bodyAction = SKAction.group([moveAction,rotateAction])
        let playAction = SKAction.sequence([bodyAction,lastAction])
        body.run(playAction)
    }
    
    //2¥ぶら下がりジャンプ
    func BarJump(){
        print("ぶら下がりジャンプ開始")
        print("ストップアクション(Bジャンプ)")
        stopAction()
        Airjointanglemovement()
        let sita = angle(p1: body.position, p2: BarObject.position)
        let dis = distance(p1: body.position, p2: BarObject.position)
        let jumpF = 92.74 * dis
        //ジャンプ方向の計算(成分分解)
        let jumpX = sin(sita) * jumpF
        let jumpY = -cos(sita) * jumpF
        print("ぶら下がり解除")
        Barflag = false
        BarJumpflag = false
        BarMoveflag = false
        if SEfirst[11]{ ReadBodySE(Number: 11, named: "Bjump", type: "mp3") }  //SE読み込み
        physicsWorld.remove(self.BarJoint[0])
        BarJoint.removeAll()
        body.run(SKAction.applyImpulse(CGVector(dx: jumpX, dy: jumpY), duration: 0.2))
        body.PlaySE(number: SENumber[11])
        
        self.run(SKAction.wait(forDuration: 0.2)){
            print("アクションロック解除(ぶら下がり解除)")
            self.Actionlock = false
            print("プレイヤー重力ON")
            self.playerGravityON()
            self.run(SKAction.wait(forDuration: 0.3)){
                print("センサロック(ぶら下がり解除)")
                self.body.run(SKAction.rotate(toAngle: 0, duration: 0.5))
                self.Sensorlock = false
            }
        }
    }

    //2¥プレイヤーブロックリセット
    func playerBlockResetAction(){
        print("PBリセット開始")
        let PBP =  body.position
        print("PB物理影響無効")
        playerBlock.physicsBody?.isDynamic = false
        let PMAction = SKAction.move(to: PBP, duration: 0.05)
        let PRActlon = SKAction.rotate(toAngle: 0, duration: 0.05, shortestUnitArc: true)
        var PBAction = SKAction.group([PMAction,PRActlon])
        let lastAction = SKAction.run {
            print("PB物理影響無効解除")
            self.playerBlock.physicsBody?.isDynamic = true
            print("アクションロック解除（PBリセット）")
            self.Actionlock = false
            print("PBリセット終了")
            self.standardAction()
        }
        PBAction = SKAction.sequence([PBAction,lastAction])
        playerBlock.run(PBAction)
    }
    
  
    //2¥ジャンプアクション
    func jumpAction(Dis: CGFloat, Angle:CGFloat){
        print("ジャンプ開始")
        print("アクションロック(ジャンプ)")
        Actionlock = true
        print("センサロック(ジャンプ)")
        Sensorlock = true
        SensorOFF()
        jumpFlag = true
        
        let time = 0.3
        let BRsita: [CGFloat] = [90,80,-60]
        let BLsita: [CGFloat] = [90,80,-60]
        let FRsita: [CGFloat] = [135,135,45]
        let FLsita: [CGFloat] = [135,135,45]
        let bodysita: CGFloat = 45
        let move: [CGFloat] = [50,50]
        
        var jumpS:CGFloat = 1.0
        if Dis <= jumpF2{
            jumpS = 0.7
        }else if Dis <= jumpF3{
            jumpS = 0.85
        }
        let jumpF = 8500 * impulseR * jumpS
        //ジャンプ方向の計算(成分分解)
        let jumpX = sin(Angle) * jumpF
        let jumpY = -cos(Angle) * jumpF
  
        let lastAction = SKAction.run{
            self.body.run(SKAction.applyImpulse(CGVector(dx: jumpX, dy: jumpY), duration: 0.2))
            self.playerstatas = 2
            print("アクションロック解除(ジャンプ)")
            self.Actionlock = false
            print("ジャンプ終了")
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
        self.run(SKAction.wait(forDuration: 1.2)){
            print("センサロック解除(ジャンプ)")
            self.Sensorlock = false
        }
    }
    
    //2¥壁ジャンプアクション
    func jumpAction2(Dis: CGFloat, Angle:CGFloat){
        print("壁ジャンプ開始")
        print("アクションロック(壁ジャンプ)")
        Actionlock = true
        print("センサロック(壁ジャンプ)")
        Sensorlock = true
        SensorOFF()
        jumpFlag = true
        
        let time = 0.3
        let BRsita: [CGFloat] = [90,80,-60]
        let BLsita: [CGFloat] = [90,80,-60]
        let FRsita: [CGFloat] = [135,135,45]
        let FLsita: [CGFloat] = [135,135,45]
        let bodysita: CGFloat = 45
        let move: [CGFloat] = [50,50]
        
        var jumpS:CGFloat = 1.0
        if Dis <= jumpF2{
            jumpS = 0.7
        }else if Dis <= jumpF3{
            jumpS = 0.85
        }
        let jumpF = 9936 * impulseR * jumpS
        //ジャンプ方向の計算(成分分解)
        let jumpX = sin(Angle) * jumpF
        let jumpY = -cos(Angle) * jumpF
        
        let lastAction = SKAction.run{
            self.body.run(SKAction.applyImpulse(CGVector(dx: jumpX, dy: jumpY), duration: 0.2))
            self.playerstatas = 2
            print("アクションロック解除(壁ジャンプ)")
            self.Actionlock = false
            print("ジャンプ終了")
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
        
        self.run(SKAction.wait(forDuration: 1.2)){
            print("センサロック解除(壁ジャンプ)")
            self.Sensorlock = false
        }
    }

//2¥姿勢リセットアクション
    func standardAction(){
        print("姿勢リセット開始")
        Groundjointanglemovement()
        print("アクションロック（姿勢リセット）")
        Actionlock = true
        let time = 0.1
        print("胴体物理影響無効")
        body.physicsBody?.isDynamic = false
        let BRsita: [CGFloat] = [90,60,-45]
        let BLsita: [CGFloat] = [90,60,-45]
        let FRsita: [CGFloat] = [80,0,0]
        let FLsita: [CGFloat] = [80,0,0]
        let bodysita: CGFloat = 20
        let move: [CGFloat] = [50,50]
        let lastAction = SKAction.run {
            self.Standerdanglemovement()
            print("プレイヤー重力ON(姿勢リセット終)")
            self.playerGravityON()
            print("胴体物理影響無効解除")
            self.body.physicsBody?.isDynamic = true
            print("アクションロック解除（姿勢リセット）")
            self.Actionlock = false
            print("姿勢リセット終了")
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
    }
    
//2¥プレイヤー向き変更アクション
    func trunAction(){
        print("向き変更開始")
        print("アクションロック(向き変更)")
        Actionlock = true
        let Ftime: Double = 0.05
        let Atime: Double = 0.3
        let time: [Double] = [Ftime,Atime]
        let move:[[CGFloat]] = [[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[40,40,-30],[40,40,-30]]
        let BLsita: [[CGFloat]] = [[10,0,-45] ,[10,0,-45]]
        let FRsita: [[CGFloat]] = [[-30,-30,-30] ,[-30,-30,-30]]
        let FLsita: [[CGFloat]] = [[45,10,0] ,[45,10,0]]
        let bodysita: [CGFloat] = [5 ,5]
        //0.05でプレイヤーブロックを動かし、その後ターンアニメを開始(0,05)
        var moveX = BSize ;if playerdirection { moveX = -moveX }
        playerBlock.run(SKAction.moveBy(x: moveX, y: 0, duration: Ftime - 0.01))
        dChangeTexture(Ftime: Ftime, Atime: Atime)
        let lastAction = SKAction.run {
            print("プレイヤー重力ON(向き変更終)")
            self.playerGravityON()
            print("アクションロック解除(向き変更)")
            self.standardAction()
        }
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction)
    }
    
    
//2¥向き変更テクスチャーアニメ
    func dChangeTexture(Ftime:Double,Atime: Double){
        print("プレイヤアニメ開始")
        var Anime: SKAction! //テクスチャーアニメの作成
        if playerdirection{
            let changeAnime = SKAction.animate(with: self.Rbodyanime, timePerFrame: Atime / 16.0)
            let changeL = SKAction.run {
                self.playerDflag = false
                for n in 0...2{
                    self.LegBR[n].alpha = 1
                    self.LegFR[n].alpha = 1
                    self.LegBL[n].alpha = 1
                    self.LegFL[n].alpha = 1
                }
                for n in 0...3{
                    self.taleS[n + 4].alpha = 1
                }
            }
            let resetAnime = SKAction.setTexture(bodyT[1])
            let last = SKAction.run{ print("プレイヤアニメ終了") }
            Anime = SKAction.sequence([changeAnime,changeL,resetAnime,last])
        }else{
            let changeAnime = SKAction.animate(with: self.Lbodyanime, timePerFrame: Atime / 16.0)
            let changeR = SKAction.run {
                self.playerDflag = false
                for n in 0...2{
                    self.LegBR[n].alpha = 1
                    self.LegFR[n].alpha = 1
                    self.LegBL[n].alpha = 1
                    self.LegFL[n].alpha = 1
                }
                for n in 0...3{
                    self.taleS[n].alpha = 1
                }
            }
            let resetAnime = SKAction.setTexture(bodyT[0])
            let last = SKAction.run{ print("プレイヤアニメ終了") }
            Anime = SKAction.sequence([changeAnime,changeR,resetAnime,last])
        }
        //テクスチャーアニメの実行
        self.run(SKAction.wait(forDuration: Ftime - 0.02)){
            self.playerDflag = true
            self.body.alpha = 1
            self.body.run(Anime)
            if self.playerdirection{
                self.playerdirection = false
                for n in 0...2{
                    self.LegBR[n].run( SKAction.setTexture(self.LegBT[n + 3]) )
                    self.LegBL[n].run( SKAction.setTexture(self.LegBT[n + 3]) )
                    self.LegFR[n].run( SKAction.setTexture(self.LegFT[n + 3]) )
                    self.LegFL[n].run( SKAction.setTexture(self.LegFT[n + 3]) )
                }
                for n in 0...3{ self.taleS[n].alpha = 0 }
            }else{
                self.playerdirection = true
                for n in 0...2{
                    self.LegBR[n].run( SKAction.setTexture(self.LegBT[n]) )
                    self.LegBL[n].run( SKAction.setTexture(self.LegBT[n]) )
                    self.LegFR[n].run( SKAction.setTexture(self.LegFT[n]) )
                    self.LegFL[n].run( SKAction.setTexture(self.LegFT[n]) )
                }
                for n in 0...3{ self.taleS[n + 4].alpha = 0 }
            }
            for n in 0...2{
                self.LegBR[n].alpha = 0
                self.LegFR[n].alpha = 0
                self.LegBL[n].alpha = 0
                self.LegFL[n].alpha = 0
            }
        }
    }
    
//2¥歩くアクション
    func walkAction(Speed:CGFloat){
        print("歩く開始")
        Groundjointanglemovement()
        //プレイヤーブロックを動かすアクション
        var moveX: CGFloat = Speed / 10.0 * BSize
        if playerdirection == false{ moveX = -moveX }
        var moveAction = SKAction.moveBy(x: moveX, y: 0, duration: 1.0)
        moveAction = SKAction.repeatForever(moveAction)
        playerBlock.run(moveAction)
        var a: Double = 1.0
        if RwalkFlag[0] || LwalkFlag[0]{ a = 1.0 }
        if RwalkFlag[1] || LwalkFlag[1]{ a = 2.0 }
        
        let time: [Double] = [0.3 / a,0.3 / a ,0.3 / a ,0.3 / a ,0.3 / a ,0.3 / a]
        let move:[[CGFloat]] = [[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[-30,-30,-90] ,[5,5,-50] ,[80,50,0] ,[70,30,-30] ,[60,0,-50] ,[0,-10,-60]]
        let BLsita: [[CGFloat]] = [[70,30,-30] ,[60,0,-50] ,[0,-10,-60] ,[-30,-30,-90] ,[5,5,-50] ,[70,50,0]]
        let FRsita: [[CGFloat]] = [[70,-5,-6] ,[0,-45,-45] ,[-45,-45,-10] ,[30,30,30] ,[60,45,45] ,[70,5,0]]
        let FLsita: [[CGFloat]] = [[30,30,30] ,[60,45,45] ,[70,5,0] ,[70,-5,-6] ,[0,-45,-45] ,[-45,-45,-10]]
        let bodysita: [CGFloat] = [-4 ,-4 ,-4 ,-4 ,-4 ,-4]
        let lastAction = SKAction.run { }//使わない
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction,Repeat: true)
    }
    
    
//2¥走るアクション
    func runAction(Speed:CGFloat){
        print("走る開始")
        Groundjointanglemovement()
        //プレイヤーブロックを動かすアクション
        var moveX: CGFloat = Speed / 10.0 * BSize
        if playerdirection == false{ moveX = -moveX }
        
        var moveAction = SKAction.moveBy(x: moveX, y: 0, duration: 1.0)
        moveAction = SKAction.repeatForever(moveAction)
        playerBlock.run(moveAction)
        
        let time: [Double] = [0.1 ,0.1 ,0.1 ,0.1 ,0.1 ,0.1]
        let move:[[CGFloat]] = [[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-70,-90] ,[-5,50,-80] ,[30,45,-5]]
        let BLsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-70,-90] ,[-5,50,-80] ,[30,45,-5]]
        let FRsita: [[CGFloat]] = [[-100,-100,40] ,[-90,-45,90] ,[60,80,95] ,[60,80,95],[80,45,-15] ,[-70,-70,5]]
        let FLsita: [[CGFloat]] = [[-100,-100,40] ,[-90,-45,90] ,[60,80,95] ,[60,80,95],[10,80,20] ,[-5,-5,80]]
        let bodysita: [CGFloat] = [25 ,25 ,0 ,0,-10,-10]
        let lastAction = SKAction.run { }//使わない
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction,Repeat: true)
    }
    
//2¥テクスチャーリセット関数
    
    func RTexterReset(){
        for n in 0...2{
            LegBR[n].run( SKAction.setTexture(self.LegBT[n]) )
            LegBL[n].run( SKAction.setTexture(self.LegBT[n]) )
            LegFR[n].run( SKAction.setTexture(self.LegFT[n]) )
            LegFL[n].run( SKAction.setTexture(self.LegFT[n]) )
        }
        for n in 0...2{
            LegBR[n].alpha = 1
            LegFR[n].alpha = 1
            LegBL[n].alpha = 1
            LegFL[n].alpha = 1
        }
        for n in 0...3{
            taleS[n + 4].alpha = 0
            taleS[n].alpha = 1
        }
        body.run(SKAction.setTexture(bodyT[0]))
    }
    
    func LTexterReset(){
        for n in 0...2{
            LegBR[n].run( SKAction.setTexture(self.LegBT[n + 3]) )
            LegBL[n].run( SKAction.setTexture(self.LegBT[n + 3]) )
            LegFR[n].run( SKAction.setTexture(self.LegFT[n + 3]) )
            LegFL[n].run( SKAction.setTexture(self.LegFT[n + 3]) )
        }
        for n in 0...2{
            LegBR[n].alpha = 1
            LegFR[n].alpha = 1
            LegBL[n].alpha = 1
            LegFL[n].alpha = 1
        }
        for n in 0...3{
            taleS[n].alpha = 0
            taleS[n + 4].alpha = 1
        }
        body.run(SKAction.setTexture(bodyT[1]))
    }
    
//2¥空中移動
    func airmoveAction(){
        print("空中移動起動")
        var moved: CGFloat = 0
        let moveF: CGFloat = 8000
        if Rairmove { moved = 1 }
        if Lairmove { moved = -1 }
        moved = moved * impulseR * moveF
        let moveFAction = SKAction.applyForce(CGVector(dx: moved, dy: 0), duration: 0.5)
        let lastAction = SKAction.run { self.Rairmove = false ;self.Lairmove = false }
        let moveFAction2 = SKAction.sequence([moveFAction,lastAction])
        for n in 0...2{
            LegBR[n].run(moveFAction)
            LegBL[n].run(moveFAction)
            LegFR[n].run(moveFAction)
            LegFL[n].run(moveFAction)
        }
        body.run(moveFAction2)
    }
    
    //2¥風アクション移動
    func windmoveAction(Angle:CGFloat){
        print("風アクション移動起動")
        var movedx: CGFloat = 0 ; var movedy: CGFloat = 0
        let moveF: CGFloat = 4000
        movedx = impulseR * moveF * sin(Angle)
        movedy = impulseR * moveF * -cos(Angle)
        let moveFAction = SKAction.applyForce(CGVector(dx: movedx, dy: movedy), duration: 0.5)
        let lastAction = SKAction.run { self.windmoveflag = true }
        let moveFAction2 = SKAction.sequence([moveFAction,lastAction])
        for n in 0...2{
            LegBR[n].run(moveFAction)
            LegBL[n].run(moveFAction)
            LegFR[n].run(moveFAction)
            LegFL[n].run(moveFAction)
        }
        body.run(moveFAction2)
    }
    
//2¥壁走り開始
    func WallClim(){
        print("壁登り準備開始")
        ClimFN += 1 ; if ClimFN == 3 { ClimFN = 0 }
        ClimFlag[ClimFN] = true
        ClimEE = true
        print("PS変化(地上)")
        playerstatas = 1
        print("PB重力OFF")
        playerBlock.physicsBody?.affectedByGravity = false
        var Bsita:CGFloat = 90 * psita ; if LwallclimFlag { Bsita = -Bsita }
        var dx:CGFloat = PSize * 1.0 ; if LwallclimFlag { dx = -dx }
        let dy:CGFloat = PSize * 0.5
        
        let Ftime: Double = 0.05
        let Atime: Double = 0.3
        let time: [Double] = [Ftime,Atime + 0.1]
        let move:[[CGFloat]] = [[28,40] ,[28,40]]
        let BRsita: [[CGFloat]] = [[40,40,-30],[40,40,-30]]
        let BLsita: [[CGFloat]] = [[10,0,-45] ,[10,0,-45]]
        let FRsita: [[CGFloat]] = [[-30,-30,-30] ,[-30,-30,-30]]
        let FLsita: [[CGFloat]] = [[45,10,0] ,[45,10,0]]
        let bodysita: [CGFloat] = [5 ,5]
        
        let BMAction = SKAction.moveBy(x: dx, y: dy, duration: Ftime - 0.01)
        let BRAction = SKAction.rotate(toAngle: Bsita, duration: Ftime - 0.01, shortestUnitArc: true)
        let BAction = SKAction.group([BMAction,BRAction])
        playerBlock.run(BAction)
        
        if (playerdirection && LwallclimFlag) || (playerdirection == false && RwallclimFlag){
            dChangeTexture(Ftime: Ftime, Atime: Atime)
        }
        let lastAction = SKAction.run {
            print("アクションロック解除（壁）")
            self.Actionlock = false
            print("ストップアクション（壁２）")
            self.stopAction()
            if self.ClimEE{ self.Wallwalk() }
            else{
                print("PS変化（壁登り準備終了）")
                self.ClimFlag[self.ClimFN] = false
                self.playerstatas = 2
            }
        }
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction)
    }
    
//2¥壁走り
    func Wallwalk(){
        print("壁走り")
        let CN = ClimFN
        Groundjointanglemovement()
        ClimJBFlag = true
        let Speed:CGFloat = 50
        //プレイヤーブロックを動かすアクション
        var moveX: CGFloat = BSize * 0.5
        let moveY: CGFloat = Speed / 10.0 * BSize
        if LwallclimFlag{ moveX = -moveX }
        var moveAction = SKAction.moveBy(x: moveX, y: moveY, duration: 1.0)
        moveAction = SKAction.repeatForever(moveAction)
        playerBlock.run(moveAction)

        let time: [Double] = [0.1 ,0.1 ,0.1 ,0.1 ,0.1 ,0.1]
        let move:[[CGFloat]] = [[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50] ,[50,50]]
        let BRsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-70,-90] ,[-5,50,-80] ,[30,45,-5]]
        let BLsita: [[CGFloat]] = [[90,50,-5] ,[80,5,-60] ,[-90,-70,-90] ,[-90,-70,-90] ,[-5,50,-80] ,[30,45,-5]]
        let FRsita: [[CGFloat]] = [[-100,-100,40] ,[-90,-45,90] ,[60,80,95] ,[60,80,95],[80,45,-15] ,[-70,-70,5]]
        let FLsita: [[CGFloat]] = [[-100,-100,40] ,[-90,-45,90] ,[60,80,95] ,[60,80,95],[10,80,20] ,[-5,-5,80]]
        let bodysita: [CGFloat] = [10 ,10 ,-5 , -5,-10, -10]
        let lastAction = SKAction.run {  }//使わない
        PlayerAction(MoveP: move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, bodyS: bodysita, time: time, lastAction: lastAction,Repeat: true)
        self.run(SKAction.wait(forDuration: 1.2)){
            if self.ClimFlag[CN] && self.ClimJBFlag == true{
                self.ClimFlag[CN] = false
                print("PS変更空中(壁登り時間経過)")
                self.playerstatas = 2
            }
        }
        
    }
    
//2¥壁登り解除時のアクション
    func ClimEndAction(){
        print("壁ジャンプ受付開始")
        let cn = ClimFN
        ClimJBFlag = false
        let time = 1.0
        let BRsita: [CGFloat] = [90,70,-70]
        let BLsita: [CGFloat] = [90,70,-70]
        let FRsita: [CGFloat] = [80,80,80]
        let FLsita: [CGFloat] = [80,80,80]
        let bodysita: CGFloat = 0
        let move: [CGFloat] = [50,30]
        let lastAction = SKAction.run {
            if self.ClimFlag[cn]{
                self.ClimFlag[cn] = false
                self.RwallclimFlag = false
                self.LwallclimFlag = false
                if self.Actionlock == false{
                    self.Sensorlock = true
                    self.underSflag1 = false
                    self.underSflag2 = false
                    print("PS変更空中(壁ジャンプ受付終了)")
                    self.playerstatas = 2
                    self.run(SKAction.wait(forDuration: 1.0)){
                        self.Sensorlock = false
                    }
                }
                print("壁ジャンプ受付終了")
            }
        }
        PlayerAction(MoveP:move, BRleg: BRsita, BLleg: BLsita, FRleg: FRsita, FLleg: FLsita, BodyS: bodysita, time: time, lastAction: lastAction)
        
    }

//2¥敵追加アクション
    func addenemyAction(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,StartSwitchNumber n1:Int,SwitchNumber n2:Int = 0){
        let playAction = SKAction.run { self.addenemy(xp: xp, yp: yp, type: type, HP: HP, Damage: Damage, direction: direction, maxn: maxn, interval: interval, SwitchNumber: n2) }
        BlockAction.append(playAction)
        BlockActionNumber[n1] = BlockAction.count - 1
    }
    func addenemyAction(xp: CGFloat,yp:CGFloat,type:Int,HP:Int,Damage:Int,direction:Bool,maxn:Int,interval:Double ,StartSwitchNumber n1:Int,SwitchNumber n2:[Int]){
        let playAction = SKAction.run { self.addenemy(xp: xp, yp: yp, type: type, HP: HP, Damage: Damage, direction: direction, maxn: maxn, interval: interval, SwitchNumber: n2) }
        BlockAction.append(playAction)
        BlockActionNumber[n1] = BlockAction.count - 1
    }

    
//2¥ブロックの出現、消滅アクション
    func addinoutAction(outinterval: Double, ininterval: Double ,firstinterval:Double , BlockNumber n1:Int,type: Int = 1 ,Actiontype type2:Int = 1,outtime: Double = 1.0, intime: Double = 0.0, SwitchNumbet n2: Int = 0,outcontact: Bool = true,incontact: Bool = false){
        
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
        
        let playAction = SKAction.run {
            if type2 == 2{ inoutA.removeAllActions() }
            inoutA.run(inoutAction, withKey: "i\(n1)")
        }
        if n2 == 0{ run(playAction) }
        else {
            BlockAction.append(playAction)
            BlockActionNumber[n2] = BlockAction.count - 1
        }
        if type2 == 3 {
            inoutA.speed = 0
            inoutA.userData = ["statas":2]
            self.run(SKAction.wait(forDuration: 0.05)){
                if let BAction = inoutA.action(forKey: "i\(n1)"){
                    BAction.speed = 0
                    inoutA.speed = 1
                }
            }
        }
    }
    
//2¥ブロックの出現(1回)
    func addInAction(interval:Double ,intime: Double, BlockNumber n1:Int, SwitchNumbet n2: Int,incontact: Bool = false){
        let inA = Block[BlockNumber[n1] - 1]
        let categoryB = inA.physicsBody?.categoryBitMask
        let collisionB = inA.physicsBody?.collisionBitMask
        let contacttestB = inA.physicsBody?.contactTestBitMask
        
        let outbody = SKAction.run {
            inA.physicsBody?.categoryBitMask = 0
            inA.physicsBody?.collisionBitMask = 0
            inA.physicsBody?.contactTestBitMask = 0
        }
        let inbody = SKAction.run {
            inA.physicsBody?.categoryBitMask = categoryB!
            inA.physicsBody?.collisionBitMask = collisionB!
            inA.physicsBody?.contactTestBitMask = contacttestB!
        }
        var InBodyAction = SKAction.fadeIn(withDuration: intime)
        if incontact{ InBodyAction = SKAction.sequence([inbody,InBodyAction]) }
        else        { InBodyAction = SKAction.sequence([InBodyAction,inbody]) }
        let FwaitAction = SKAction.wait(forDuration: interval)
        
        var InAction: SKAction!
        run(outbody)
        inA.alpha = 0
        InAction = SKAction.sequence([FwaitAction,InBodyAction])
        
        let playAction = SKAction.run {
            inA.run(InAction)
        }
        BlockAction.append(playAction)
        BlockActionNumber[n2] = BlockAction.count - 1
    }
    
//2¥ブロックの消失(2回)
    func addOutAction(interval:Double ,outtime: Double , BlockNumber n1:Int, SwitchNumbet n2: Int,outcontact: Bool = true){
        let outA = Block[BlockNumber[n1] - 1]
        let outbody = SKAction.run {
            outA.physicsBody?.categoryBitMask = 0
            outA.physicsBody?.collisionBitMask = 0
            outA.physicsBody?.contactTestBitMask = 0
        }
        var OutBodyAction = SKAction.fadeOut(withDuration: outtime)
        if outcontact{ OutBodyAction = SKAction.sequence([OutBodyAction,outbody]) }
        else         { OutBodyAction = SKAction.sequence([outbody,OutBodyAction]) }
        let FwaitAction = SKAction.wait(forDuration: interval)
        
        var OutAction: SKAction!
        OutAction = SKAction.sequence([FwaitAction,OutBodyAction])
        let playAction = SKAction.run {
            outA.run(OutAction)
        }
        BlockAction.append(playAction)
        BlockActionNumber[n2] = BlockAction.count - 1
    }
    
//2¥ブロックの移動アクション
    func addmoveAction(xmove: CGFloat, ymove: CGFloat, time: Double ,BlockNumber n1:Int,interval time2: Double = 0.0,firstinterval time3:Double = 0.0,type:Int = 1,Actiontype type2:Int = 1,SwitchNumber n2:Int = 0){
        let mA = Block[BlockNumber[n1] - 1]      //動かすオブジェクト
        let obx = mA.position.x                  //オブジェクトのx座標
        let oby = mA.position.y                  //オブジェクトのy座標
        let mxp = obx + xmove * BSize
        let myp = oby + ymove * BSize
        
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: time)
        let moveAction2 = SKAction.moveBy(x: xmove * BSize, y: ymove * BSize, duration: time)
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
        }else if type == 4{
            mAction = SKAction.repeatForever(moveAction2)
            mAction = SKAction.sequence([firstwaitAction,mAction])
        }
        
        let playAction = SKAction.run {
            if type2 == 2{ mA.removeAllActions() }
            mA.run(mAction, withKey: "m\(n1)")
        }
        
        if n2 == 0{ run(playAction) }
        else {
            BlockAction.append(playAction)
            BlockActionNumber[n2] = BlockAction.count - 1
        }
        if type2 == 3 {
            mA.speed = 0
            mA.userData = ["statas":2]
            self.run(SKAction.wait(forDuration: 0.05)){
                if let BAction = mA.action(forKey: "m\(n1)"){
                    BAction.speed = 0
                    mA.speed = 1
                }
            }
        }
    }
    
//2¥ブロックの回転アクション
    func addrotateAction(dsita: CGFloat,time: Double,BlockNumber n1:Int, interval time2:Double = 0.0,firstinterval time3:Double = 0.0,type:Int = 1,Actiontype type2:Int = 1,SwitchNumber n2:Int = 0){
        let rA = Block[BlockNumber[n1] - 1]
        let angle = dsita * psita
        let Fsita = rA.zRotation
        
        let rotateAction = SKAction.rotate(byAngle: angle, duration: time)
        let RrotateAction = SKAction.rotate(byAngle: -angle, duration: time)
        let waitAction = SKAction.wait(forDuration: time2)
        let FwaitAciton = SKAction.wait(forDuration: time3)
        let repAction = SKAction.run { rA.zRotation = Fsita }
        

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

        let playAction = SKAction.run {
            if type2 == 2{ rA.removeAllActions() }
            rA.run(rAction, withKey: "r\(n1)")
        }
        
        if n2 == 0{ run(playAction) }
        else {
            BlockAction.append(playAction)
            BlockActionNumber[n2] = BlockAction.count - 1
        }
        if type2 == 3 {
            rA.speed = 0
            rA.userData = ["statas":2]
            self.run(SKAction.wait(forDuration: 0.05)){
                if let BAction = rA.action(forKey: "r\(n1)"){
                    BAction.speed = 0
                    rA.speed = 1
                }
            }
        }
    }
    //アクションのON、OFF切り替え
    func ONOFFAction(BlockNumber n1:Int,SwitchNumber n2:Int){
        let object = Block[BlockNumber[n1] - 1]
        let playAction = SKAction.run{
            let n = object.GetInt(name: "statas")
            if n == 1{
                object.SetInt(name: "statas", Int: 2)
                if let BAction = object.action(forKey: "m\(n1)"){
                    BAction.speed = 0
                }
                if let BAction = object.action(forKey: "i\(n1)"){
                    BAction.speed = 0
                }
                if let BAction = object.action(forKey: "r\(n1)"){
                    BAction.speed = 0
                }
            }else if n == 2 {
                object.SetInt(name: "statas", Int: 1)
                if let BAction = object.action(forKey: "m\(n1)"){
                    BAction.speed = 1
                }
                if let BAction = object.action(forKey: "i\(n1)"){
                    BAction.speed = 1
                }
                if let BAction = object.action(forKey: "r\(n1)"){
                    BAction.speed = 1
                }
            }
        }
        BlockAction.append(playAction)
        BlockActionNumber[n2] = BlockAction.count - 1
    }
    
    //2¥ゲームオーバー処理
    func gameover() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.viewnode.GameOver()
            self.isPaused = true
        }
    }
    
    //2¥ゲームクリア処理
    func gameclear(){
        viewnode.GameClear()
        self.isPaused = true
    }
    
    //2¥ステージ移動処理
    func moveStage(object: SKNode){
        let MStage = object.GetInt(name: "StageN")
        let MScene = object.GetInt(name: "SceneN")
        if MStage >= 1000{
            let CN = MStage - 1000
            if CN >= 1{
                UserDefaults.standard.set(true, forKey: "ClearItemn\(CN)")
                viewnode.setCFitemF(N: CN)
            }
            gameclear()
            return
        }
        if MStage >= 1 && MScene >= 1{
            viewnode.setSaveS(N: MStage, SN: 0)
        }
        viewnode.Movestage(MoveStageN: MStage, MoveSceneN: MScene, HP: catHP, MP: catMP)
    }

    //2¥アイテムアクション
    func itemAction(object:SKNode){
        let type = object.GetInt(name: "type")
        let number = object.GetInt(name: "number")
        if type == 1{ //スキル習得
            object.removeFromParent()
            viewnode.SkillLearning(N: number)
            self.isPaused = true
            return
        }
        if type == 2{ //体力回復
            object.removeFromParent()
            if SEfirst[12]{ ReadBodySE(Number: 12, named: "foodSE", type: "wav") }
            body.PlaySE(number: SENumber[12])
            var plusHP = 20
            if number == 2{ plusHP = 50 }
            if number == 3{ plusHP = 100 }
            if number == 4{ plusHP = 200 }
            catHP += plusHP
            if catHP >= catMaxHP{ catHP = catMaxHP }
            viewnode.ChangeHPbar(pHP: catHP)
        }
        if type == 3{ //セーブ
            object.removeFromParent()
            if SEfirst[13]{ ReadBodySE(Number: 13, named: "SaveSE", type: "mp3") }
            body.PlaySE(number: SENumber[13])
            viewnode.SaveScene(SceneNumber: number)
        }
        
        if type == 4{ //状態異常アイテム
            if number == 1{ ChangeCondition(PconN: 0) }
            if number == 2{ ChangeCondition(PconN: 1) }
            if number == 3{ ChangeCondition(PconN: 2) }
            object.removeFromParent()
        }
        
        //看板
        if type == 6 && boardflag{
            boardflag = false
            self.run(SKAction.wait(forDuration: 0.2)){
                self.viewnode.discriptionChangeN(disN: number, display: true)
                self.isPaused = true
                return
            }
        }
        
        if type == 8 && boardflag{
            boardflag = false
            self.run(SKAction.wait(forDuration: 0.2)){
                self.viewnode.displayTVView(TVnumber: number)
                self.isPaused = true
                return
            }
        }
        
        //扉 ワープホール
        if type == 7{
            var flag = true
            var PairO: SKNode!
            if number == 2 {
                let PN = object.GetInt(name: "PairN")
                PairO = warpObject[PN]
                flag = object.GetBool(name: "flag")
            }
            if flag && Barflag == false{
                var Pcx: CGFloat!
                var Pcy: CGFloat!
                if number == 1{
                    let mPx = object.GetCGFloat(name: "movePx")
                    let mPy = object.GetCGFloat(name: "movePy")
                    Pcx = mPx * BSize
                    Pcy = mPy * BSize
                }else if number == 2{
                    Pcx = PairO.position.x
                    Pcy = PairO.position.y
                    PairO.SetBool(name: "flag", Bool: false)
                    self.run(SKAction.wait(forDuration: 3.0)){
                        PairO.SetBool(name: "flag", Bool: true)
                    }
                }
                WarpAction(P: CGPoint(x: Pcx, y: Pcy), type: number)
                return
            }else{
                self.run(SKAction.wait(forDuration: 0.5)){
                    self.itemflag = true
                }
                return
            }
        }
        
        self.run(SKAction.wait(forDuration: 1.0)){
            self.itemflag = true
        }
    }
    
    //2¥ブロックアクション
    func playBlockAction(Object:SKNode){
        let type = Object.GetInt(name: "type")
        if 1 <= type && type <= 3{ //雲(通常バウンド)
            SEplay(SE: cloudSE)
            let PlayerPosition = body.position
            let CloudPosition = Object.position
            stopAction()
            playerGravityOFF()
            Actionlock = true
            Sensorlock = true
            SensorOFF()
            jumpFlag = true
            var jumpS:CGFloat = 1.0
            if type == 2{ jumpS = 1.5 }
            if type == 3{ jumpS = 2.0 }
            let jumpF = 7000 * impulseR * jumpS
            let Angle = angle(p1: CloudPosition, p2: PlayerPosition)
            //ジャンプ方向の計算(成分分解)
            let jumpX = sin(Angle) * jumpF
            let jumpY = -cos(Angle) * jumpF
            self.body.run(SKAction.applyImpulse(CGVector(dx: jumpX, dy: jumpY), duration: 0.2))
            let BigAction = SKAction.scale(by: 1.1, duration: 0.1)
            let SmallAction = SKAction.scale(by: 0.9, duration: 0.1)
            Object.run( SKAction.sequence([BigAction,SmallAction]) )
            self.playerstatas = 2
            self.run(SKAction.wait(forDuration: 0.5)){
                print("センサロック解除(ジャンプ)")
                self.body.physicsBody?.isDynamic = true
                self.playerGravityON()
                self.Actionlock = false
                self.Sensorlock = false
            }
        }else if type == 4{
           
            
        }
        
    }
    
    //2¥ワープアクション
    func WarpAction(P:CGPoint,type: Int){
        //移動地点の計算
        var legD: [CGFloat] = [0.20 ,0.24]         // 足の関節距離
        var taleD: [CGFloat] = [0.16 ,0.12 ,0.22]  // 尻尾
        var bodyD: CGFloat = 0.70                  // 前足、後足の距離
        var taleP: [CGFloat] = [0.3,0.2]           // 後ろ足の付け根から尻尾付け根の距離
        
        for n in 0 ..< 3{ taleD[n] = taleD[n] * PSize }
        for n in 0 ..< 2{
            legD[n] = legD[n] * PSize
            taleP[n] = taleP[n] * PSize
        }
        bodyD = bodyD * PSize
        
        var FLegPx: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var FLegPy: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var BLegPx: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var BLegPy: [CGFloat] = [0,0,0,0]     //最初の0は空打ち
        var bodyPx: CGFloat = 0             //最初の0は空打ち
        var bodyPy: CGFloat = 0             //最初の0は空打ち
        var talePx: [CGFloat] = [0,0,0,0,0,0,0,0,0] //最初の0は空打ち
        var talePy: [CGFloat] = [0,0,0,0,0,0,0,0,0] //最初の0は空打ち
        var SensorPx: [CGFloat] = [0,0,0,0,0]       //ムーブ,上,下,右,左
        var SensorPy: [CGFloat] = [0,0,0,0,0]       //ムーブ,上,下,右,左
        //胴体
        bodyPx = P.x
        bodyPy = P.y
        //足
        BLegPx[3] = bodyPx - bodyD / 2
        BLegPy[3] = bodyPy
        BLegPx[2] = BLegPx[3]
        BLegPy[2] = BLegPy[3] - legD[1]
        BLegPx[1] = BLegPx[2]
        BLegPy[1] = BLegPy[2] - legD[0]
        FLegPx[3] = bodyPx + bodyD / 2
        FLegPy[3] = bodyPy
        FLegPx[2] = FLegPx[3]
        FLegPy[2] = FLegPy[3] - legD[1]
        FLegPx[1] = FLegPx[2]
        FLegPy[1] = FLegPy[2] - legD[0]
        //尻尾
        talePx[1] = BLegPx[3] - taleP[0]
        talePy[1] = BLegPy[3] + taleP[1]
        talePx[2] = talePx[1] - taleD[0]
        talePy[2] = talePy[1]
        talePx[3] = talePx[2] - taleD[1]
        talePy[3] = talePy[2]
        talePx[4] = talePx[3] - taleD[2]
        talePy[4] = talePy[3]
        talePx[5] = FLegPx[3] + taleP[0]
        talePy[5] = FLegPy[3] + taleP[1]
        talePx[6] = talePx[5] + taleD[0]
        talePy[6] = talePy[5]
        talePx[7] = talePx[6] + taleD[1]
        talePy[7] = talePy[6]
        talePx[8] = talePx[7] + taleD[2]
        talePy[8] = talePy[7]
        //センサー
        SensorPx[0] = P.x
        SensorPy[0] = P.y + SensorSize[1] / 2
        SensorPx[1] = SensorPx[0]
        SensorPy[1] = SensorPy[0] + OUSensorD
        SensorPx[2] = SensorPx[0]
        SensorPy[2] = SensorPy[0] - OUSensorD
        SensorPx[3] = SensorPx[0] + RLSensorD
        SensorPy[3] = SensorPy[0]
        SensorPx[4] = SensorPx[0] - RLSensorD
        SensorPy[4] = SensorPy[0]
        
        if type == 1{ //扉
            if SEfirst[14]{ ReadBodySE(Number: 14, named: "door", type: "mp3") }
            body.PlaySE(number: SENumber[14])
            print("扉の開始処理")
            stopAction()
            Actionlock = true
            Sensorlock = true
            if playerdirection{ RTexterReset() } else { LTexterReset() }
            //プレイヤーの移動
            playerBlock.run(SKAction.move(to: CGPoint(x: SensorPx[0], y: SensorPy[0]), duration: 0))
            overSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[1] , y: SensorPy[1]), duration: 0))
            overSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[1] , y: SensorPy[1]), duration: 0))
            overSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[1] , y: SensorPy[1]), duration: 0))
            underSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[2] , y: SensorPy[2]), duration: 0))
            underSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[2] , y: SensorPy[2]), duration: 0))
            underSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[2] , y: SensorPy[2]), duration: 0))
            rightSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[3] , y: SensorPy[3]), duration: 0))
            rightSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[3] , y: SensorPy[3]), duration: 0))
            rightSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[3] , y: SensorPy[3]), duration: 0))
            leftSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[4] , y: SensorPy[4]), duration: 0))
            leftSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[4] , y: SensorPy[4]), duration: 0))
            leftSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[4] , y: SensorPy[4]), duration: 0))
            
            let Dmove = SKSpriteNode(imageNamed: "doormove")
            Dmove.position = CGPoint(x: 0, y: 0)
            Dmove.scale(to: CGSize(width: w, height: h))
            Dmove.zPosition = 100
            cameraNode.addChild(Dmove)
            
            Dmove.run(SKAction.scale(to: 1.5, duration: 0.5))
            
            body.physicsBody?.isDynamic = false
            body.run(SKAction.move(to: CGPoint(x: bodyPx, y: bodyPy), duration: 0))
            for n in 1...3{
                LegBR[n - 1].physicsBody?.isDynamic = false
                LegBL[n - 1].physicsBody?.isDynamic = false
                LegFR[n - 1].physicsBody?.isDynamic = false
                LegFR[n - 1].physicsBody?.isDynamic = false
                LegBR[n - 1].run(SKAction.move(to: CGPoint(x: BLegPx[n], y: BLegPy[n]), duration: 0))
                LegBL[n - 1].run(SKAction.move(to: CGPoint(x: BLegPx[n], y: BLegPy[n]), duration: 0))
                LegFR[n - 1].run(SKAction.move(to: CGPoint(x: FLegPx[n], y: FLegPy[n]), duration: 0))
                LegFL[n - 1].run(SKAction.move(to: CGPoint(x: FLegPx[n], y: FLegPy[n]), duration: 0))
            }
            for n in 1...8{
                taleS[n - 1].physicsBody?.isDynamic = false
                taleS[n - 1].run(SKAction.move(to: CGPoint(x: talePx[n], y: talePy[n]), duration: 0))
            }
            if bodyPx <= w / 2     { bodyPx = w / 2}
            if bodyPx >= BSize * StagedX - w / 2 { bodyPx = BSize * StagedX - w / 2 }
            if bodyPy <= h / 2     { bodyPy = h / 2}
            if bodyPy >= BSize * StagedY - h / 2 { bodyPy = BSize * StagedY - h / 2 }
            cameraNode.run(SKAction.move(to: CGPoint(x: bodyPx, y: bodyPy), duration: 0))
            //移動後の処理
            self.run(SKAction.wait(forDuration: 0.1)){
                self.body.physicsBody?.isDynamic = true
                for n in 1...3{
                    self.LegBR[n - 1].physicsBody?.isDynamic = true
                    self.LegBL[n - 1].physicsBody?.isDynamic = true
                    self.LegFR[n - 1].physicsBody?.isDynamic = true
                    self.LegFR[n - 1].physicsBody?.isDynamic = true
                }
                for n in 1...8{
                    self.taleS[n - 1].physicsBody?.isDynamic = true
                }
            }
            self.run(SKAction.wait(forDuration: 0.6)){
                Dmove.removeFromParent()
                self.Sensorlock = false
                self.Actionlock = false
                self.itemflag = true
                self.standardAction()
            }
        }else if type == 2{ //ワープ
            playerDamageflag = false
            
            if SEfirst[15]{ ReadBodySE(Number: 15, named: "warp", type: "mp3") }
            body.PlaySE(number: SENumber[15])
            playerBlock.run(SKAction.move(to: CGPoint(x: SensorPx[0], y: SensorPy[0]), duration: 0))
            overSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[1] , y: SensorPy[1]), duration: 0))
            overSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[1] , y: SensorPy[1]), duration: 0))
            overSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[1] , y: SensorPy[1]), duration: 0))
            underSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[2] , y: SensorPy[2]), duration: 0))
            underSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[2] , y: SensorPy[2]), duration: 0))
            underSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[2] , y: SensorPy[2]), duration: 0))
            rightSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[3] , y: SensorPy[3]), duration: 0))
            rightSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[3] , y: SensorPy[3]), duration: 0))
            rightSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[3] , y: SensorPy[3]), duration: 0))
            leftSensor1.run(SKAction.move(to: CGPoint(x:SensorPx[4] , y: SensorPy[4]), duration: 0))
            leftSensor2.run(SKAction.move(to: CGPoint(x:SensorPx[4] , y: SensorPy[4]), duration: 0))
            leftSensorS.run(SKAction.move(to: CGPoint(x:SensorPx[4] , y: SensorPy[4]), duration: 0))
            body.run(SKAction.move(to: CGPoint(x: bodyPx, y: bodyPy), duration: 0))
            for n in 1...3{
                LegBR[n - 1].run(SKAction.move(to: CGPoint(x: BLegPx[n], y: BLegPy[n]), duration: 0))
                LegBL[n - 1].run(SKAction.move(to: CGPoint(x: BLegPx[n], y: BLegPy[n]), duration: 0))
                LegFR[n - 1].run(SKAction.move(to: CGPoint(x: FLegPx[n], y: FLegPy[n]), duration: 0))
                LegFL[n - 1].run(SKAction.move(to: CGPoint(x: FLegPx[n], y: FLegPy[n]), duration: 0))
            }
            for n in 1...8{
                taleS[n - 1].run(SKAction.move(to: CGPoint(x: talePx[n], y: talePy[n]), duration: 0))
            }
            if bodyPx <= w / 2     { bodyPx = w / 2}
            if bodyPx >= BSize * StagedX - w / 2 { bodyPx = BSize * StagedX - w / 2 }
            if bodyPy <= h / 2     { bodyPy = h / 2}
            if bodyPy >= BSize * StagedY - h / 2 { bodyPy = BSize * StagedY - h / 2 }
            cameraNode.run(SKAction.move(to: CGPoint(x: bodyPx, y: bodyPy), duration: 0))
            self.run(SKAction.wait(forDuration: 0.5)){
                if self.playerdirection{ self.RTexterReset() } else { self.LTexterReset() }
                self.playerDamageflag = true
                self.Sensorlock = false
                self.Actionlock = false
            }
            self.run(SKAction.wait(forDuration: 0.5)){
                self.itemflag = true
            }
        }
    }
    
    //2¥スイッチアクション
    func switchAction(object:SKNode){
        let type = object.GetInt(name: "type")
        let number = object.GetInt(name: "number")
        //スイッチ操作
        if type == 1{
            //BGM
            if SEfirst[16]{ ReadBodySE(Number: 16, named: "switch", type: "wav") }
            body.PlaySE(number: SENumber[16])
            if       number == 1{ //一回だけ操作可能(単一アクション)
                object.physicsBody?.categoryBitMask = 0
                object.physicsBody?.contactTestBitMask = 0
                object.physicsBody?.collisionBitMask = 0
                self.run(SKAction.wait(forDuration: 0.1)){
                    object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch2")))
                }
                let n2 = object.GetInt(name: "switch")
                run(BlockAction[BlockActionNumber[n2]])
            }else if number == 2{ //一回だけ操作可能(複数アクション)
                object.physicsBody?.categoryBitMask = 0
                object.physicsBody?.contactTestBitMask = 0
                object.physicsBody?.collisionBitMask = 0
                self.run(SKAction.wait(forDuration: 0.1)){
                    object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch2")))
                }
                let n2 = object.GetInt2(name: "switch")
                for n in 0 ..< n2.count{
                    run(BlockAction[BlockActionNumber[n2[n]]])
                }
            }else if number == 3{ //繰り返し操作可能(A:単一　B:単一)
                let statas = object.GetInt(name: "statas")
                if statas == 1{
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch5")))
                    }
                    let n2 = object.GetInt(name: "switchB")
                    run(BlockAction[BlockActionNumber[n2]])
                }else if statas == 2{
                    object.SetInt(name: "statas", Int: 1)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch4")))
                    }
                    let n2 = object.GetInt(name: "switchA")
                    run(BlockAction[BlockActionNumber[n2]])
                }
            }else if number == 4{ //繰り返し操作可能(A:複数　B:複数)
                let statas = object.GetInt(name: "statas")
                if statas == 1{
                    object.SetInt(name: "statas", Int: 2)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch5")))
                    }
                    let n2 = object.GetInt2(name: "switchB")
                    for n in 0 ..< n2.count{
                        run(BlockAction[BlockActionNumber[n2[n]]])
                    }
                }else if statas == 2{
                    object.SetInt(name: "statas", Int: 1)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch4")))
                    }
                    let n2 = object.GetInt2(name: "switchA")
                    for n in 0 ..< n2.count{
                        run(BlockAction[BlockActionNumber[n2[n]]])
                    }
                }
            }else if number == 5{ //繰り返し操作可能(A:単一　B:複数)
                let statas = object.GetInt(name: "statas")
                if statas == 1{
                    object.SetInt(name: "statas", Int: 2)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch5")))
                    }
                    let n2 = object.GetInt(name: "switchB")
                    run(BlockAction[BlockActionNumber[n2]])
                }else if statas == 2{
                    object.SetInt(name: "statas", Int: 1)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch4")))
                    }
                    let n2 = object.GetInt2(name: "switchA")
                    for n in 0 ..< n2.count{
                        run(BlockAction[BlockActionNumber[n2[n]]])
                    }
                }
            }else if number == 6{ //繰り返し操作可能(A:複数　B:単一)
                let statas = object.GetInt(name: "statas")
                if statas == 1{
                    object.SetInt(name: "statas", Int: 2)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch5")))
                    }
                    let n2 = object.GetInt2(name: "switchB")
                    for n in 0 ..< n2.count{
                        run(BlockAction[BlockActionNumber[n2[n]]])
                    }
                }else if statas == 2{
                    object.SetInt(name: "statas", Int: 1)
                    self.run(SKAction.wait(forDuration: 0.1)){
                        object.run(SKAction.setTexture(SKTexture(imageNamed: "Switch4")))
                    }
                    let n2 = object.GetInt(name: "switchA")
                    run(BlockAction[BlockActionNumber[n2]])
                }
            }
        }
        
        if type == 2{ //ONOFFアクション
            if SEfirst[16]{ ReadBodySE(Number: 16, named: "switch", type: "wav") }
            body.PlaySE(number: SENumber[16])
            if number == 1{  //ONスイッチ
                ONAction()
            }else{           //OFFスイッチ
                OFFAction()
            }
        }
        
        self.run(SKAction.wait(forDuration: 1.0)){
            self.switchflag = true
        }
    }
    
    //ONアクション
    func ONAction(){
        if ONBlock.isEmpty == false{
            for n in 0 ..< ONBlock.count{
                ONBlock[n].alpha = 1.0
                ONBlock[n].physicsBody?.categoryBitMask = blockCategory
                ONBlock[n].physicsBody?.contactTestBitMask = blockCT
                ONBlock[n].physicsBody?.collisionBitMask = blockCo
            }
        }
        if OFFBlock.isEmpty == false{
            for n in 0 ..< OFFBlock.count{
                OFFBlock[n].alpha = 0.2
                OFFBlock[n].physicsBody?.categoryBitMask = 0
                OFFBlock[n].physicsBody?.contactTestBitMask = 0
                OFFBlock[n].physicsBody?.collisionBitMask = 0
            }
        }
        if ONOFFBlock.isEmpty == false{
            for n in 0 ..< ONOFFBlock.count{
                let ONf = ONOFFBlock[n].GetBool(name: "ONflag")
                if ONf{//ON⇨OFF
                    ONOFFBlock[n].SetBool(name: "ONflag", Bool: false)
                    ONOFFBlock[n].alpha = 0.2
                    ONOFFBlock[n].physicsBody?.categoryBitMask = 0
                    ONOFFBlock[n].physicsBody?.contactTestBitMask = 0
                    ONOFFBlock[n].physicsBody?.collisionBitMask = 0
                }else{//OFF⇨ON
                    ONOFFBlock[n].SetBool(name: "ONflag", Bool: true)
                    ONOFFBlock[n].alpha = 1.0
                    ONOFFBlock[n].physicsBody?.categoryBitMask = blockCategory
                    ONOFFBlock[n].physicsBody?.contactTestBitMask = blockCT
                    ONOFFBlock[n].physicsBody?.collisionBitMask = blockCo
                }
            }
        }
    }
    
    //OFFアクション
    func OFFAction(){
        if ONBlock.isEmpty == false{
            for n in 0 ..< ONBlock.count{
                ONBlock[n].alpha = 0.2
                ONBlock[n].physicsBody?.categoryBitMask = 0
                ONBlock[n].physicsBody?.contactTestBitMask = 0
                ONBlock[n].physicsBody?.collisionBitMask = 0
            }
        }
        if OFFBlock.isEmpty == false{
            for n in 0 ..< OFFBlock.count{
                OFFBlock[n].alpha = 1.0
                OFFBlock[n].physicsBody?.categoryBitMask = blockCategory
                OFFBlock[n].physicsBody?.contactTestBitMask = blockCT
                OFFBlock[n].physicsBody?.collisionBitMask = blockCo
            }
        }
        if ONOFFBlock.isEmpty == false{
            for n in 0 ..< ONOFFBlock.count{
                let ONf = ONOFFBlock[n].GetBool(name: "ONflag")
                if ONf{//ON⇨OFF
                    ONOFFBlock[n].SetBool(name: "ONflag", Bool: false)
                    ONOFFBlock[n].alpha = 0.2
                    ONOFFBlock[n].physicsBody?.categoryBitMask = 0
                    ONOFFBlock[n].physicsBody?.contactTestBitMask = 0
                    ONOFFBlock[n].physicsBody?.collisionBitMask = 0
                }else{//OFF⇨ON
                    ONOFFBlock[n].SetBool(name: "ONflag", Bool: true)
                    ONOFFBlock[n].alpha = 1.0
                    ONOFFBlock[n].physicsBody?.categoryBitMask = blockCategory
                    ONOFFBlock[n].physicsBody?.contactTestBitMask = blockCT
                    ONOFFBlock[n].physicsBody?.collisionBitMask = blockCo
                }
            }
        }
    }
    
    //2¥プレイヤーの質量を変更
    func ChangeMass(perMass:CGFloat){
        //各パーツの元々の質量
        let bodymass:CGFloat = 10
        let legmass:CGFloat = 1
        let talemass:CGFloat = 0.5
        //質量の変更
        self.body.physicsBody?.mass = bodymass * perMass / 100.0
        for n in 0 ... 2{
            self.LegBR[n].physicsBody?.mass = legmass * perMass / 100.0
            self.LegBL[n].physicsBody?.mass = legmass * perMass / 100.0
            self.LegFR[n].physicsBody?.mass = legmass * perMass / 100.0
            self.LegFL[n].physicsBody?.mass = legmass * perMass / 100.0
        }
        for n in 0 ... 7{ self.taleS[n].physicsBody?.mass = talemass * perMass / 100.0 }
    }
    
    func ChangeGracity(perG:CGFloat){
        physicsWorld.gravity = CGVector(dx: 0, dy: -CGFloat(self.gra) * perG / 100.0)
    }
    
    //2¥プレイヤーの状態変化
    func ChangeCondition(PconN:Int){
        PconAfter = PconN
        //プレイヤーの状態  0:正常 1:軽化 2:重化 3:魔力封印
        if PconAfter != PconBefore{//状態変化が起きた場合
            PconBefore = PconAfter
            if       PconAfter == 1{ //軽化
                if SEfirst[18] { ReadBodySE(Number: 18, named: "status2", type: "mp3") }
                body.PlaySE(number: SENumber[18])
                ChangeGracity(perG: 20)
                ChangeMass(perMass: 80)
                let PconT = readTextureAnime(AtlasNamed: "Pcon1", imageNamed: "light", Number: 30)
                PconEffect.run(SKAction.repeatForever(SKAction.animate(with: PconT, timePerFrame: 0.05)) )
                DelayRun(time: 0.1) { self.PconEffect.alpha = 1.0 }
            }else if PconAfter == 2{ //重化
                if SEfirst[19] { ReadBodySE(Number: 19, named: "status3", type: "mp3") }
                body.PlaySE(number: SENumber[19])
                ChangeGracity(perG: 200)
                ChangeMass(perMass: 120)
                let PconT = readTextureAnime(AtlasNamed: "Pcon2", imageNamed: "heavy", Number: 30)
                PconEffect.run(SKAction.repeatForever(SKAction.animate(with: PconT, timePerFrame: 0.05) ) )
                DelayRun(time: 0.1) { self.PconEffect.alpha = 1.0 }
            }else if PconAfter == 3{ //魔力封印
                if SEfirst[19] { ReadBodySE(Number: 19, named: "status3", type: "mp3") }
                ChangeGracity(perG: 100)
                ChangeMass(perMass: 100)
                let PconT = readTextureAnime(AtlasNamed: "Pcon3", imageNamed: "magic", Number: 30)
                PconEffect.run(SKAction.repeatForever(SKAction.animate(with: PconT, timePerFrame: 0.05)) )
                DelayRun(time: 0.1) { self.PconEffect.alpha = 1.0 }
            }else{                   //正常
                if SEfirst[17] { ReadBodySE(Number: 17, named: "status1" , type: "mp3") }
                body.PlaySE(number: SENumber[17])
                ChangeGracity(perG: 100)
                ChangeMass(perMass: 100)
                PconEffect.removeAllActions()
                PconEffect.alpha = 0
            }
        }
        
    }
    

}
