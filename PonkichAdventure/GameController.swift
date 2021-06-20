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
    
    var savex: CGFloat = 0
    var savey: CGFloat = 0
    var zsita: CGFloat = 0
    var savep: CGPoint!
    
    var BFlg: Bool = true
    
    var gzerotimer = Timer()
    
    var dx: CGFloat = 0
    var dy: CGFloat = 0
    
    var last1:CFTimeInterval!
    var last2:CFTimeInterval!
    var last3:CFTimeInterval!
    var Sensortime:CFTimeInterval!
    var greenflag: Bool = true
    let SPositions: [SIMD2<Float>] = [SIMD2<Float>(0,0),SIMD2<Float>(0.5,0),SIMD2<Float>(1,0),SIMD2<Float>(0,0.5),SIMD2<Float>(0.5,0.5),SIMD2<Float>(1,0.5),SIMD2<Float>(0,1),SIMD2<Float>(0.5,1),SIMD2<Float>(1,1) ]
    
    var PBRotateFlag: Bool = true

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
 
//3¥センサ関係
        //格センサの挙動
        let pX = playerBlock.position.x
        let pY = playerBlock.position.y
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
            let pzR = playerBlock.zRotation
            let Sh:CGFloat = OUSensorD
            let Sw:CGFloat = RLSensorD
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
        if underdis1.abs() > SensorRunDis * SSize && Sensorlock == false{
            underSflag1 = true
        }else if underdis1.abs() <= SensorRunDis * SSize{
            underSflag1 = false
        }
        if underdis2.abs() > SensorRunDis * SSize && Sensorlock == false {
            underSflag2 = true
        }else if underdis1.abs() <= SensorRunDis * SSize{
            underSflag2 = false
        }
        if overdis1.abs() > SensorRunDis * SSize && Sensorlock == false{
            overSflag1 = true
        }else if overdis1.abs() <= SensorRunDis * SSize{
            overSflag1 = false
        }
        if overdis2.abs() > SensorRunDis * SSize && Sensorlock == false {
            overSflag2 = true
        }else if overdis1.abs() <= SensorRunDis * SSize{
            overSflag2 = false
        }
        if rightdis1.abs() > SensorRunDis * SSize && Sensorlock == false{
            rightSflag1 = true
        }else if rightdis1.abs() <= SensorRunDis * SSize{
            rightSflag1 = false
        }
        if rightdis2.abs() > SensorRunDis * SSize && Sensorlock == false {
            rightSflag2 = true
        }else if rightdis1.abs() <= SensorRunDis * SSize{
            rightSflag2 = false
        }
        if leftdis1.abs() > SensorRunDis * SSize && Sensorlock == false{
            leftSflag1 = true
        }else if leftdis1.abs() <= SensorRunDis * SSize{
            leftSflag1 = false
        }
        if leftdis2.abs() > SensorRunDis * SSize && Sensorlock == false{
            leftSflag2 = true
        }else if leftdis1.abs() <= SensorRunDis * SSize{
            leftSflag2 = false
        }
//3¥カメラ
        var Cpoint = CGPoint(x: body.position.x, y: body.position.y + BSize * 1)
        if Cpoint.x <= w / 2     { Cpoint.x = w / 2}
        if Cpoint.x >= BSize * StagedX - w / 2 { Cpoint.x = BSize * StagedX - w / 2 }
        if Cpoint.y <= h / 2     { Cpoint.y = h / 2}
        if Cpoint.y >= BSize * StagedY - h / 2 { Cpoint.y = BSize * StagedY - h / 2 }
        let moveAction = SKAction.move(to: Cpoint, duration: 0.5)
        cameraNode.run(moveAction)

        let PlayerSita = playerBlock.zRotation / psita  //プレイヤーの姿勢
        
        if Actionlock == false && (PlayerSita <= -50 || 50 <= PlayerSita) && PBRotateFlag && ClimFlag[ClimFN] == false{
            print("センサ姿勢初期化")
            PBRotateFlag = false
            playerBlock.run(SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true))
            self.run(SKAction.wait(forDuration: 0.2)){
                self.PBRotateFlag = true
            }
        }
        
//エフェクトスクリーンの動き
        PconEffect.position = body.position
        if BossEFlag{ BossEffect.position = BossO.position }
        
//ボスの方向矢印
        if BossViewFlag{
            let BossAngle = angle(p1: body.position, p2: BossO.position)
            
            //矢印の位置　計算
            let wh = (w - h) / 2
            let sita = 90 * psita
            let a = 1.0 - (sita - BossAngle.abs()).abs() / sita
            let Vdis = h / 2.5 + wh * a
            let BossP = CGPoint(x: sin(BossAngle) * Vdis, y: -cos(BossAngle) * Vdis)
            BossVector.position = BossP
            BossVector.zRotation = BossAngle
        }
 
//3¥下のセンサー稼働時
        if underSflag1 || underSflag2{
            //稼働開始時のみ動作
            if undreSfirst{
                print("下センサ起動")
                undreSfirst = false
            }
            //センサー稼働時常時動作
            //デバッグ用(センサ起動有無)
            if SensorView && underSflag1 { underSensor1.alpha = 0.5 }
            if SensorView && underSflag2 { underSensor2.alpha = 0.5 }
            //壁登りを使う条件
            if Rairmove && underSflag1 && skillOn[7] && WUnderSita[0][0] <= PlayerSita && PlayerSita <= WUnderSita[0][1] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    RwallclimFlag = true
                    WallClim()
                }
            }
            if Lairmove && underSflag1 && skillOn[7] && WUnderSita[1][0] <= PlayerSita && PlayerSita <= WUnderSita[1][1] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    LwallclimFlag = true
                    WallClim()
                }
            }
            //地上状態になる条件
            if playerstatas == 2 && (underSflag1 || underSflag2)
                && GUnderSita[0] < PlayerSita && PlayerSita < GUnderSita[1] {//地上状態への変化処理
                if Actionlock == false{
                    print("アクションロック（地上変化）")
                    Actionlock = true
                    print("PS変更（地上）")
                    playerstatas = 1
                    print("ストップアクション（地上）")
                    stopAction()                //アクション停止
                    playerBlockResetAction()    //姿勢のリセット　地上状態に移行
                }
            }
            
            //壁登りの解除条件
            if (RwallclimFlag || LwallclimFlag) && Actionlock == false && underSflag1 == false{
                print("アクションロック（壁解除2）")
                Actionlock = true
                ClimFlag[ClimFN] = false
                RwallclimFlag = false;LwallclimFlag = false
                print("ストップアクション（壁解除）")
                stopAction()
                var dx = BSize * 2;if playerdirection == false{ dx = -dx }
                let dy = BSize * 2.5
                let moveAction = SKAction.moveBy(x: dx, y: dy, duration: 0.1)
                let rotateAction = SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true)
                let bodyAction = SKAction.group([moveAction,rotateAction])
                let lastAction = SKAction.run {
                    print("アクションロック解除（壁解除2）")
                    self.Actionlock = false
                    self.Sensorlock = false
                    print("PS変更（空中）")
                    self.playerstatas = 2
                    self.landingfirst = true
                }
                let playAction = SKAction.sequence([bodyAction,lastAction])
                body.run(playAction)
            }
            
        }else{//下のセンサー停止
            if undreSfirst == false{
                print("下センサ解除")
                undreSfirst = true
            }
            //デバッグ用（センサの有無）
            if SensorView && underSflag1 == false { underSensor1.alpha = 0.1 }
            if SensorView && underSflag2 == false { underSensor2.alpha = 0.1 }
            
            //壁登りの解除条件
            if (RwallclimFlag || LwallclimFlag) && Actionlock == false{
                print("アクションロック（壁解除）")
                Actionlock = true
                ClimFlag[ClimFN] = false
                RwallclimFlag = false;LwallclimFlag = false
                print("ストップアクション（解除）")
                stopAction()
                var dx = BSize * 2;if playerdirection == false{ dx = -dx }
                let dy = BSize * 2.5
                let moveAction = SKAction.moveBy(x: dx, y: dy, duration: 0.1)
                let rotateAction = SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true)
                let bodyAction = SKAction.group([moveAction,rotateAction])
                let lastAction = SKAction.run {
                    print("アクションロック解除（壁解除）")
                    self.Actionlock = false
                    self.Sensorlock = false
                    print("PS変更（空中）")
                    self.playerstatas = 2
                    self.landingfirst = true
                }
                let playAction = SKAction.sequence([bodyAction,lastAction])
                body.run(playAction)
            }
        }
        
//3¥上のセンサー稼働時
        if overSflag1 || overSflag2{
            //稼働開始時のみ動作
            if overSfirst{
                print("上センサ起動")
                overSfirst = false
            }
            //センサー稼働時常時動作
            //デバッグ用（センサの有無）
            if SensorView && overSflag1 { overSensor1.alpha = 0.5 }
            if SensorView && overSflag2 { overSensor2.alpha = 0.5 }
            //壁登りを使う条件
            if Rairmove && overSflag1 && skillOn[7] && WUperSita[1][0] <= PlayerSita && PlayerSita <= WUperSita[1][1] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    RwallclimFlag = true
                    WallClim()
                }
            }
            if Lairmove && overSflag1 && skillOn[7] && WUperSita[0][0] <= PlayerSita && PlayerSita <= WUperSita[0][1] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("ストップアクション（壁）")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    LwallclimFlag = true
                    WallClim()
                }
            }
            //地上状態になる条件
            if  (overSflag1 || overSflag2) && (PlayerSita < GUperSita[0] || PlayerSita > GUperSita[1]) {
                if Actionlock == false{
                    print("アクションロック（地上変化）")
                    Actionlock = true
                    print("PS変更（地上）")
                    playerstatas = 1
                    print("ストップアクション（地上）")
                    stopAction()                //アクション停止
                    playerBlockResetAction()    //姿勢のリセット　地上状態に移行
                }
            }
            
        }else{//頭のセンサー停止
            if overSfirst == false{
                print("上センサ解除")
                overSfirst = true
            }
            if SensorView && overSflag1 == false { overSensor1.alpha = 0.1 }
            if SensorView && overSflag2 == false { overSensor2.alpha = 0.1 }
        }
        
//3¥右のセンサー稼働時
        if rightSflag1 || rightSflag2{
            //稼働開始時のみ動作
            if rightSfirst{
                print("右センサ起動")
                rightSfirst = false
            }
            //センサー稼働時常時動作
            //デバッグ用（センサの有無）
            if SensorView && rightSflag1 { rightSensor1.alpha = 0.5 }
            if SensorView && rightSflag2 { rightSensor2.alpha = 0.5 }
            //壁登りを使う条件
            if ( RrunFlag || (Rairmove && WRightSita[0][0] < PlayerSita && PlayerSita < WRightSita[0][1]) ) && rightSflag1 && skillOn[7] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    RwallclimFlag = true
                    WallClim()
                }
            }
            if Lairmove && (PlayerSita < WRightSita[1][0] || PlayerSita > WRightSita[1][1]) && rightSflag1  && skillOn[7] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    LwallclimFlag = true
                    WallClim()
                }
            }
            //地上状態になる条件
            if (rightSflag1 || rightSflag2 ) && GRightSita[0] <= PlayerSita && PlayerSita <= GRightSita[1]{
                if Actionlock == false{
                    print("アクションロック（地上変化）")
                    Actionlock = true
                    print("PS変更（地上）")
                    playerstatas = 1
                    print("ストップアクション（地上）")
                    stopAction()                //アクション停止
                    playerBlockResetAction()    //姿勢のリセット　地上状態に移行
                }
            }
        }else{//右手のセンサー停止
            if rightSfirst == false{
                print("右センサ解除")
                rightSfirst = true
            }
            //デバッグ用（センサの有無）
            if SensorView && rightSflag1 == false { rightSensor1.alpha = 0.1 }
            if SensorView && rightSflag2 == false { rightSensor2.alpha = 0.1 }
        }
        
        
//3¥左のセンサー稼働時
        if leftSflag1 || leftSflag2{
            //稼働開始時のみ動作
            if leftSfirst{
                print("左センサ起動")
                leftSfirst = false
            }
            //デバッグ用（センサの有無）
            if SensorView && leftSflag1 { leftSensor1.alpha = 0.5 }
            if SensorView && leftSflag2 { leftSensor2.alpha = 0.5 }
            //壁登りを使う条件
            if (LrunFlag || (Lairmove && WLeftSita[0][0] < PlayerSita && PlayerSita < WLeftSita[0][1]) ) && leftSflag1 && skillOn[7] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    LwallclimFlag = true
                    WallClim()
                }
            }
            if Rairmove && (PlayerSita < WLeftSita[1][0] || PlayerSita > WLeftSita[1][1]) && leftSflag1 && skillOn[7] && PconAfter != 2{
                if Actionlock == false && climLock == false{
                    print("アクションロック（壁）")
                    Actionlock = true
                    print("壁登りロック")
                    climLock = true
                    print("ストップアクション（壁）")
                    stopAction()
                    RwallclimFlag = true
                    WallClim()
                }
            }
            //地上状態になる条件
            if (leftSflag1 || leftSflag2) && GLeftSita[0] <= PlayerSita && PlayerSita <= -90 + GLeftSita[1]{
                if Actionlock == false{
                    print("アクションロック（地上変化）")
                    Actionlock = true
                    print("PS変更（地上）")
                    playerstatas = 1
                    print("ストップアクション（地上）")
                    stopAction()
                    playerBlockResetAction()    //姿勢のリセット　地上状態に移行
                }
            }
        }else{//左センサー停止
            if leftSfirst == false{
                print("左センサ解除")
                leftSfirst = true
            }
            //デバッグ用（センサの有無）
            if SensorView && leftSflag1 == false { leftSensor1.alpha = 0.1 }
            if SensorView && leftSflag2 == false { leftSensor2.alpha = 0.1 }
        }
//3¥着地状態時の処理
        if playerstatas == 1{
            if landingfirst {//変化時のみの処理
                print("地上状態")
                body.physicsBody?.allowsRotation = true
                playerBlock.physicsBody?.allowsRotation = true
                landingfirst = false
                airfirst = true
                jumpFlag = false
                if RwallclimFlag == false && LwallclimFlag == false{
                    print("PB重力ON(地上変化)")
                    playerBlock.physicsBody?.affectedByGravity = true
                    print("壁登りロック解除")
                    climLock = false
                }
            }
        //地上状態時常時
            if Actionlock == false{
                let BP = body.position
                let BDis = distance(p1: BP, p2: playerBlock.position)
                if BDis > fallD && ClimFlag[ClimFN] == false{
                    print("PS変更（空中）距離")
                    playerstatas = 2
                }
            }
        }
        
//3¥空中状態時の処理
        if playerstatas == 2{
            if airfirst{ //変化時のみ有効
                print("空中状態")
                print("PB重力OFF(空中変化)")
                body.physicsBody?.allowsRotation = false
                playerBlock.physicsBody?.allowsRotation = false
                playerBlock.physicsBody?.affectedByGravity = false
                airfirst = false
                landingfirst = true
                airMfalg = true
                if jumpFlag == false && Actionlock == false{
                    print("ストップアクション（空中変化）")
                    stopAction()
                }
                if RwallclimFlag{ RwallclimFlag = false }
                if LwallclimFlag{ LwallclimFlag = false }
                
                if windflag[windN] == false{
                    print("プレイヤー重力ON（空中変化）")
                    playerGravityON()
                }
                Airjointanglemovement()
                body.run(SKAction.rotate(toAngle: 0, duration: 0.5))
                playerBlock.run(SKAction.rotate(toAngle: 0, duration: 0.1, shortestUnitArc: true))
            }
            
            //空中状態時の移動処理
            if playerstatas == 2 && (Actionlock == false || windflag[windN] || BarJumpflag) {
                if airMfalg{
                    airMfalg = false
                    let BP = body.position
                    let MP = playerBlock.position
                    let Bdx = BP.x - MP.x
                    let Bdy = BP.y - MP.y
                    let PBAction = SKAction.moveBy(x: Bdx, y: Bdy, duration: 0.05)
                    playerBlock.run(PBAction)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.06){
                        self.airMfalg = true
                    }
                }
            }
        }
        
//3¥等間隔処理
        if last1 + 1.0 <= currentTime{
            //ここ1.0秒起きに行う処理を定義
            if MPRflag{
                var a: Int = 0
                if skillOn[11] && skillOn[12]{
                    a = 3
                }else if (skillOn[11] && skillOn[12] == false) || (skillOn[11] == false && skillOn[12]) {
                    a = 2
                }else{
                    a = 1
                }
                if PracticeFlag { a += 3 }
                catMP += a ;if catMP >= catMaxMP { catMP = catMaxMP }
                viewnode.ChangeMPbar(pMP: catMP)
            }
            
            if Actionlock == false && Sensorlock == false && playerstatas == 2{
                let bodyAngle = body.zRotation
                if bodyAngle <= -10 * psita || 10 * psita <= bodyAngle{
                    body.run(SKAction.rotate(toAngle: 0, duration: 0.5))
                }
            }
            
            if BossVFlag{
                let Bossdx = (BossO.position.x - body.position.x).abs()
                let Bossdy = (BossO.position.y - body.position.y).abs()
                
                if Bossdx >= w / 1.5 || Bossdy >= h / 1.2{
                    BossViewFlag = true
                }else{
                    BossViewFlag = false
                    BossVector.position = CGPoint(x: 2 * w , y: h)
                }
            }
            //ここまで
            last1 = currentTime
        }

        
        if last2 + 0.5 <= currentTime{
            //0.5秒起きに行う処理を定義
            
            //3¥敵の出現判定
            if epcount > 0{//敵を出現させるか
                for n in 0..<epcount{
                    let dxe = enemyp[n].x - playerBlock.position.x //敵のプレイヤーの距離（x）
                    let dye = enemyp[n].y - playerBlock.position.y //敵のプレイヤーの距離（y）
                    //プレイヤーが敵出現地点にどれくらい近づいたら出現させるかの定義
                    if dxe.abs() < BSize * 8 && dye.abs() < BSize * 6{
                        if enemyflag[n] && enemynmax[n] > enemynpre[n] && ecount < enemymax {//敵を出現させる条件
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
            
            //3¥落下物の落下判定
            if fallObject.isEmpty == false{
                for n in 0..<fallObject.count{
                    let fallO = fallObject[n]
                    let fallF = fallO.GetBool(name: "fallflag")
                    if fallF{ //落下フラグが有効なら
                        let type = fallO.GetInt(name: "type")
                        let Xp = fallO.GetCGFloat(name: "PX")
                        let Yp = fallO.GetCGFloat(name: "PY")
                        let PP = body.position
                        if type == 1{  //ツララなら
                            if Xp - 2 * BSize <= PP.x && PP.x <= Xp + 2 * BSize
                            && Yp - 10 * BSize <= PP.y && PP.y <= Yp{
                                fallO.SetBool(name: "fallflag", Bool: false)
                                fallO.physicsBody?.isDynamic = true
                                self.run(SKAction.wait(forDuration: 5.0)){
                                    fallO.physicsBody?.isDynamic = false
                                    fallO.position = CGPoint(x: Xp, y: Yp)
                                    fallO.zRotation = 0
                                    self.run(SKAction.wait(forDuration: 3.0)){
                                        fallO.SetBool(name: "fallflag", Bool: true)
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        
            //ここまで
            last2 = currentTime
        }
        if last3 + 3 <= currentTime{
            //ここに3秒起きに行う処理を定義
          
            //ここまで
            last3 = currentTime
        }
    }
    
    
//3¥衝突処理
    func didBegin(_ contact: SKPhysicsContact) {
        //プレイヤーがステージ移動オブジェクトと接触した時
        if (contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == moveCategory)
        || (contact.bodyA.categoryBitMask == moveCategory && contact.bodyB.categoryBitMask == playerCategory){
            if moveflag{
                moveflag = false
                var itemObject: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == moveCategory{itemObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == moveCategory{itemObject = contact.bodyB}
                if let objectNode = itemObject.node{
                     moveStage(object: objectNode)
                }
            }
        }//プレイヤーがダメージオブジェクトと接触した時
        else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == damageCategory)
            || (contact.bodyA.categoryBitMask == damageCategory && contact.bodyB.categoryBitMask == playerCategory){
            if playerDamageflag && playerDamageflag2{
                playerDamageflag2 = false
                var damageObject: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == damageCategory{damageObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == damageCategory{damageObject = contact.bodyB}
                if let damage = damageObject.node?.GetInt(name: "damage"){
                    playerDamageA(damage: damage)
                }
            }
        }//プレイヤーの足がダメージオブジェクトと接触した時
        else if(contact.bodyA.categoryBitMask == legCategory && contact.bodyB.categoryBitMask == damageCategory)
            || (contact.bodyA.categoryBitMask == damageCategory && contact.bodyB.categoryBitMask == legCategory){
            if playerDamageflag && playerDamageflag2{
                playerDamageflag2 = false
                var damageObject: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == damageCategory{damageObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == damageCategory{damageObject = contact.bodyB}
                if let damage = damageObject.node?.GetInt(name: "damage"){
                    playerDamageA(damage: damage)
                }
            }
        }//プレイヤーがダメージオブジェクトと接触した時
        else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == damage2Category)
            || (contact.bodyA.categoryBitMask == damage2Category && contact.bodyB.categoryBitMask == playerCategory){
            if playerDamageflag && playerDamageflag2{
                playerDamageflag2 = false
                var damageObject: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == damage2Category{damageObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == damage2Category{damageObject = contact.bodyB}
                if let damage = damageObject.node?.GetInt(name: "damage"){
                    playerDamageA(damage: damage)
                }
            }
        }//プレイヤーがアイテムと接触した時
        else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == itemCategory)
            || (contact.bodyA.categoryBitMask == itemCategory && contact.bodyB.categoryBitMask == playerCategory){
            if itemflag == true{
                itemflag = false
                var itemObject: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == itemCategory{itemObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == itemCategory{itemObject = contact.bodyB}
                if let itemnode = itemObject.node{
                    itemAction(object: itemnode)
                }
            }
        }//プレイヤーがスイッチを攻撃した時
        else if(contact.bodyA.categoryBitMask == attackCategory && contact.bodyB.categoryBitMask == SwitchCategory)
            || (contact.bodyA.categoryBitMask == SwitchCategory && contact.bodyB.categoryBitMask == attackCategory){
            if switchflag == true{
                switchflag = false
                var switchObject: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == SwitchCategory{switchObject = contact.bodyA}
                if contact.bodyB.categoryBitMask == SwitchCategory{switchObject = contact.bodyB}
                if let switchnode = switchObject.node{
                    switchAction(object: switchnode)
                }
            }
        }//ぶら下がりバーに空中弱攻撃を当てた時
        else if(contact.bodyA.categoryBitMask == attackCategory && contact.bodyB.categoryBitMask == BarCategory)
            || (contact.bodyA.categoryBitMask == BarCategory && contact.bodyB.categoryBitMask == attackCategory){
            //バーアクション
            if Barflag == false && airAfalg == true{
                print("ぶら下がりフラグON")
                Barflag = true
                if contact.bodyA.categoryBitMask == BarCategory{
                    BarObject = contact.bodyA.node
                }
                if contact.bodyB.categoryBitMask == BarCategory{
                    BarObject = contact.bodyB.node
                }
            }
        }//プレイヤーが敵と接触した時
        else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == enemyCategory)
            || (contact.bodyA.categoryBitMask == enemyCategory && contact.bodyB.categoryBitMask == playerCategory){
            if playerDamageflag && playerDamageflag2{
                var enemybody: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == enemyCategory{enemybody = contact.bodyA}
                if contact.bodyB.categoryBitMask == enemyCategory{enemybody = contact.bodyB}
                if let enemynode = enemybody.node{
                    if enemynode.GetBool(name: "damageflag"){
                        playerDamageflag2 = false
                        playerDamageA(damage: enemynode.GetInt(name: "damage"))
                    }
                }
            }
        }//プレイヤーが敵と接触した時
        else if(contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == enemy2Category)
            || (contact.bodyA.categoryBitMask == enemy2Category && contact.bodyB.categoryBitMask == playerCategory){
            if playerDamageflag && playerDamageflag2{
                var enemybody: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == enemy2Category{enemybody = contact.bodyA}
                if contact.bodyB.categoryBitMask == enemy2Category{enemybody = contact.bodyB}
                if let enemynode = enemybody.node{
                    if enemynode.GetBool(name: "damageflag"){
                        playerDamageflag2 = false
                        playerDamageA(damage: enemynode.GetInt(name: "damage"))
                    }
                }
            }
        }//敵に攻撃をヒットさせた時
        else if(contact.bodyA.categoryBitMask == attackCategory && contact.bodyB.categoryBitMask == enemyCategory)
            || (contact.bodyA.categoryBitMask == enemyCategory && contact.bodyB.categoryBitMask == attackCategory){
            var enemybody: SKPhysicsBody!
            var damagebody: SKPhysicsBody!
            if contact.bodyA.categoryBitMask == enemyCategory{
                enemybody = contact.bodyA
                damagebody = contact.bodyB
            }
            if contact.bodyB.categoryBitMask == enemyCategory{
                enemybody = contact.bodyB
                damagebody = contact.bodyA
            }
            if let damagenode = damagebody.node{
                if let enemynode = enemybody.node{
                    if enemynode.GetBool(name: "damageflag"){
                        enemynode.SetBool(name: "damageflag", Bool: false)
                        enemyDamageA(Eobject: enemynode, Dobject: damagenode)
                    }
                }
            }
            
    
        }else if(contact.bodyA.categoryBitMask == attackCategory && contact.bodyB.categoryBitMask == enemy2Category)
            || (contact.bodyA.categoryBitMask == enemy2Category && contact.bodyB.categoryBitMask == attackCategory){
            //敵にダメージを与える処理
            var enemybody: SKPhysicsBody!
            var damagebody: SKPhysicsBody!
            if contact.bodyA.categoryBitMask == enemy2Category{
                enemybody = contact.bodyA
                damagebody = contact.bodyB
            }
            if contact.bodyB.categoryBitMask == enemy2Category{
                enemybody = contact.bodyB
                damagebody = contact.bodyA
            }
            if let damagenode = damagebody.node{
                if let enemynode = enemybody.node{
                    if enemynode.GetBool(name: "damageflag"){
                        enemynode.SetBool(name: "damageflag", Bool: false)
                        enemyDamageA(Eobject: enemynode, Dobject: damagenode)
                    }
                }
            }
        }//アクションブロックにプレイヤーが接触した時
        else if(contact.bodyA.categoryBitMask == ActionBlockCategory && contact.bodyB.categoryBitMask == playerCategory)
            || (contact.bodyA.categoryBitMask == playerCategory && contact.bodyB.categoryBitMask == ActionBlockCategory){
            if ActionBlockflag {
                ActionBlockflag = false
                var ActionBlockBody: SKPhysicsBody!
                if contact.bodyA.categoryBitMask == ActionBlockCategory{ ActionBlockBody = contact.bodyA }
                if contact.bodyB.categoryBitMask == ActionBlockCategory{ ActionBlockBody = contact.bodyB }
                if let ActionBlocknode = ActionBlockBody.node{ playBlockAction(Object: ActionBlocknode) }
                self.run(SKAction.wait(forDuration: 0.1)){
                    self.ActionBlockflag = true
                }
            }
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }

    //ここから画面のタップに関する処理
    
//3¥タップ開始時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        savex = touchEvent.location(in: cameraNode).x // タップ開始位置の記憶
        savey = touchEvent.location(in: cameraNode).y // タップ開始位置の記憶
        savep = CGPoint(x: savex, y: savey)
        tap = true         //タップ
        flick = true       //フリック判定に使用
        HoldAccess[HoldAN] = false
        HoldAN += 1 ;if HoldAN == 20{ HoldAN = 0 }
        HoldAccess[HoldAN] = true
        let HA = HoldAN
    
        //ポインターの表示
        if Pointerflag{
            let touchSprite = SKSpriteNode(imageNamed: "Selecter")
            touchSprite.scale(to: CGSize(width: SelecterSize, height: SelecterSize))
            touchSprite.position = savep
            let nowrap = SKWarpGeometryGrid(columns: 2, rows: 2)
            touchSprite.warpGeometry = nowrap
            cameraNode.addChild(touchSprite)
            PointerSprite.append(touchSprite)
            
            let pointer = SKSpriteNode(imageNamed: "Pointer")
            pointer.scale(to: CGSize(width: 2.5 * BSize, height: 2.5 * BSize))
            pointer.position = savep
            cameraNode.addChild(pointer)
            PointerSprite.append(pointer)
        }
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1){
            self.tap = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
            self.flick = false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            if self.HoldAccess[HA] { //ここにホールド処理を記入
                self.Holdflag = true
                print("ホールド開始")
                let PlayerSita2 =  self.playerBlock.zRotation / self.psita
                if self.playerstatas == 1 && self.Actionlock == false && -20 <= PlayerSita2 && PlayerSita2 <= 20{
                    //スペシャル技の使用
                    if self.HoldAttackType == 1 && self.catMP >= 50 && self.PconAfter != 3 && self.NoMagicFlag == false{
                        self.HoldAction()
                    }
                    if self.HoldAttackType == 2 && self.catMP >= 100 && self.PconAfter != 3 && self.NoMagicFlag == false{
                        self.HoldAction()
                    }
                    if self.HoldAttackType == 3 && self.catMP >= 20 && self.PconAfter != 3 && self.PconAfter != 2 && self.NoWindFlag == false && self.NoMagicFlag == false{
                        self.HoldAction()
                    }
                }
            }
        }
    }
    
//3¥スワイプ時の処理
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let newxp = touchEvent.location(in: self.cameraNode).x //現在の画面に触れている位置の取得
        let newyp = touchEvent.location(in: self.cameraNode).y //現在の画面に触れている位置の取得
        let touchP = touchEvent.location(in: self)
        let pdx = newxp - savex
        let newp = CGPoint(x: newxp, y: newyp)
        let disr = distance(p1: savep, p2: newp)            //スワイプ量
        let Angle1 = angle(p1: savep, p2: newp)             //スワイプ角度(radian表記)
        let Angle2 = Angle1 / psita                         //スワイプ角度(degree表記)
        let PlayerSita =  playerBlock.zRotation / psita     //プレイヤー姿勢(degree表記)
        //ポインタ操作
        if Pointerflag{
            let aa = disr / SelecterSize - 0.5
            if aa > 0{
                PointerSprite[0].run(SKAction.rotate(toAngle: Angle1, duration: 0, shortestUnitArc: true))
                PointerSprite[1].run(SKAction.move(to: newp, duration: 0))
                let FPositions: [SIMD2<Float>] = [SIMD2<Float>(0,0),SIMD2<Float>(0.5,-Float(aa)),SIMD2<Float>(1,0),SIMD2<Float>(0,0.5),SIMD2<Float>(0.5,0.5),SIMD2<Float>(1,0.5),SIMD2<Float>(0,1),SIMD2<Float>(0.5,1),SIMD2<Float>(1,1) ]
                let warp = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: SPositions, destinationPositions: FPositions)
                let warpAction = SKAction.warp(to: warp, duration: 0.0)
                PointerSprite[0].run(warpAction!)
            }
        }
        
        if disr > 50 {
            HoldAccess[HoldAN] = false
            Holdflag = false
            if HoldActionflag{
                HoldActionflag = false
                if Cat01SE.isPlaying{ Cat01SE.stop() }
                Effect[0].removeFromParent()
                Effect.removeAll()
            }
        }
        
        if disr >= 100{
            if windmoveflag && windflag[windN]{
                windmoveflag = false
                windmoveAction(Angle: angle(p1: savep, p2: newp))
            }
        }
   
        if flick == false && BarMoveflag{ // アクションロック時でも動作可能なスワイプ処理を記入
            BarMoveflag = false
            BarMove(P: touchP)
        }
        if flick == false && Actionlock == false{ //スワイプ判定
            if playerstatas == 1{                 //地上状態
                if runAngle[0] <= PlayerSita && PlayerSita <= runAngle[1]{            //プレイヤー姿勢が立ち(多少の傾きもOK)
//3¥歩く、走るの実行
                    if pdx > walkS1 && pdx < walkS2 && runSAngle[0][0] <= Angle2 && Angle2 <= runSAngle[0][1]{   //右に歩く(遅い)動作を実行する範囲の定義
                        if playerdirection{
                            if RwalkFlag[0] == false{
                                print("ストップアクション（歩く1開始）")
                                stopAction()
                                RwalkFlag[0] = true
                                walkAction(Speed: 5)
                            }
                        }else{
                            trunAction()
                        }
                    }
                    if pdx >= walkS2 && pdx < runS && runSAngle[0][0] <= Angle2 && Angle2 <= runSAngle[0][1]{ //右に歩く(速い)動作を実行する範囲をて定義
                        if playerdirection{
                            if RwalkFlag[1] == false{
                                print("ストップアクション（歩く2開始）")
                                stopAction()
                                RwalkFlag[1] = true
                                walkAction(Speed: 10)
                            }
                        }else{
                            trunAction()
                        }
                    }
                    if pdx > runS && runSAngle[0][0] <= Angle2 && Angle2 <= runSAngle[0][1]{               //右に走る動作を実行する範囲をて定義
                        if playerdirection{
                            if RrunFlag == false{
                                print("ストップアクション（走る開始）")
                                stopAction()
                                RrunFlag = true
                                runAction(Speed: 50)
                            }
                        }else{
                            trunAction()
                        }
                    }
                    if pdx < -walkS1 && pdx > -walkS2 && runSAngle[1][0] <= Angle2 && Angle2 <= runSAngle[1][1]{ //左に歩く(遅い)動作を実行する範囲の定義
                        if playerdirection{
                            trunAction()
                        }else{
                            if LwalkFlag[0] == false{
                                print("ストップアクション（歩く1開始）")
                                stopAction()
                                LwalkFlag[0] = true
                                walkAction(Speed: 5)
                            }
                        }
                    }
                    if pdx < -walkS2 && pdx > -runS && runSAngle[1][0] <= Angle2 && Angle2 <= runSAngle[1][1]{//左に歩く(速い)動作を実行する範囲をて定義
                        if playerdirection{
                            trunAction()
                        }else{
                        if LwalkFlag[1] == false{
                                print("ストップアクション（歩く2開始）")
                                stopAction()
                                LwalkFlag[1] = true
                                walkAction(Speed: 10)
                            }
                        }
                    }
                    if pdx < -runS && runSAngle[1][0] <= Angle2 && Angle2 <= runSAngle[1][1]{              //左に走る動作を実行する範囲をて定義
                        if playerdirection{
                            trunAction()
                        }else{
                            if LrunFlag == false{
                                print("ストップアクション（走る開始）")
                                stopAction()
                                LrunFlag = true
                                runAction(Speed: 50)
                            }
                        }
                    }
                }//プレイヤー姿勢が立ち(多少の傾きもOK)
            }//地上状態
            
            if playerstatas == 2{
//3¥空中移動実行
                if pdx >= airMS && airMSAngle[0][0] <= Angle2 && Angle2 <= airMSAngle[0][1]{
                    if Lairmove{ print("ストップアクション（空中移動開始）") ;stopAction() }
                    if Rairmove == false{
                        Rairmove = true
                        airmoveAction()
                    }
                }else if pdx <= -airMS && airMSAngle[1][0] <= Angle2 && Angle2 <= airMSAngle[1][1]{
                    if Rairmove{ print("ストップアクション（空中移動開始）") ;stopAction() }
                    if Lairmove == false{
                        Lairmove = true
                        airmoveAction()
                    }
                }else{
                    if Lairmove || Rairmove{ print("ストップアクション（空中移動終了）") ;stopAction() }
                }
            }
        }//スワイプ判定
    }
 
//3¥タップ終了時の処理
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!
        let newxp = touchEvent.location(in: self.cameraNode).x  //現在の画面に触れている位置の取得
        let newyp = touchEvent.location(in: self.cameraNode).y  //現在の画面に触れている位置の取得
        let newp = CGPoint(x: newxp, y: newyp)                  //画面タッチアウトポイント
        let Angle1 = angle(p1: savep, p2: newp)                 //フリック角度(radian表記)
        let Angle2 = Angle1 / psita                             //フリック角度(degree表記)
        let PlayerSita =  playerBlock.zRotation / psita         //プレイヤーの姿勢(degree表記)
        let disr = distance(p1: savep, p2: newp)                //フリック量
        let tdx = newxp - savex                                 //フリックx変位量
        let tdy = newyp - savey                                 //フリックy変位量
        
      //  var avoideD  = false
      //  if Angle1 >= 0{ avoideD  = true }
        //ポインター消去
        if Pointerflag{
            for n in 0 ..< PointerSprite.count{ PointerSprite[n].removeFromParent() }
            PointerSprite.removeAll()
        }

        HoldAccess[HoldAN] = false
        Holdflag = false
        if HoldActionflag{
            HoldActionflag = false
            print("アクションロック(必殺技)")
            Actionlock = true
            if HoldAttackType == 1 { HoldAttack01() }
            if HoldAttackType == 2 { HoldAttack02() }
            if HoldAttackType == 3 {
                print("センサロック(風技)")
                Sensorlock = true
                HoldAttack03()
            }
        }
        //アクションロック時でも動作可能
        if tap && tdx.abs() < 45 && tdy.abs() < 45{ //タップ時の実行処理を記入
            if Pointerflag{
                let Tapcat = SKSpriteNode(imageNamed: "Tap")
                Tapcat.scale(to: CGSize(width: 2 * BSize, height: 2 * BSize))
                Tapcat.position = newp
                cameraNode.addChild(Tapcat)
                self.run(SKAction.wait(forDuration: 0.2)){
                    Tapcat.removeFromParent()
                }
            }
        
            //地上強攻撃実行フラグ
            if AttackComboAccess[1]{AttackCombofalg[1] = true}
            //空中強攻撃実行フラグ
            if AttackComboAccess[3]{AttackCombofalg[3] = true}
            //回避攻撃実行フラグ
            if AttackComboAccess[4]{AttackCombofalg[4] = true }
            
            if windflag[windN]{
                print("風アクションフラグOFF")
                MPRflag = true
                windflag[windN] = false
                Effect[0].removeFromParent()
                Effect.removeAll()
                if HoldAttack03SE.isPlaying { HoldAttack03SE.stop() }
                playerGravityON()
                print("アクションロック解除(風技時間経過)")
                Actionlock = false
                print("センサロック解除(風技時間経過)")
                Sensorlock = false
                return
            }
        }else if flick || tap{//フリックの実行処理
           
        }else{//スワイプ
            if BarJumpflag { BarJump() }
            if ClimFlag[ClimFN] { ClimEE = false }
        }
        //アクションロック時でも動作可能はここまで
        
        
        if Actionlock == false{//アクションロック有効時は動作しない
        if tap && tdx.abs() < 45 && tdy.abs() < 45{ //タップ時の実行処理を記入
          
            //地上弱攻撃アクションの実行
            if playerstatas == 1 && -35 <= PlayerSita && PlayerSita <= 35 && AttackComboAccess[0] && skillOn[1]{ // 地上
                print("アクションロック(地上弱攻撃)")
                Actionlock = true
                AttackComboAccess[0] = false
                attack01Action()
                DispatchQueue.main.asyncAfter(deadline: .now() + AttackIntervalTime[0]){
                    self.AttackComboAccess[0] = true
                }
            }
            //空中弱攻撃アクションの実行
            if playerstatas == 2 && AttackComboAccess[2] && skillOn[3]{
                print("アクションロック(空中弱攻撃)")
                Actionlock = true
                AttackComboAccess[2] = false
                airAttackAction01()
                DispatchQueue.main.asyncAfter(deadline: .now() + AttackIntervalTime[1]){
                    self.AttackComboAccess[2] = true
                }
            }
        }else if flick || tap{//フリックの実行処理
            //3¥ジャンプ実行
            if playerstatas == 1 && jumpAngle[0] <= PlayerSita && PlayerSita <= jumpAngle[1]{//地上かつ立ち姿勢
                if (Angle2 <= jumpFAngle[0] || jumpFAngle[1] <= Angle2) && disr >= jumpF1{ // ジャンプアクションの実行
                    jumpAction(Dis: disr, Angle: Angle1)
                }
            }
            if (RwallclimFlag && -180 <= Angle2 && Angle2 <= 0) || (LwallclimFlag && 0 <= Angle2 && Angle2 <= 180) {
                if disr >= jumpF1{ // ジャンプアクションの実行
                    ClimFlag[ClimFN] = false
                    RwallclimFlag = false
                    LwallclimFlag = false
                    print("ストップアクション（壁ジャンプ開始）")
                    stopAction()
                    jumpAction2(Dis: disr, Angle: Angle1)
                    return
                }
            }
            //回避アクション
            if playerstatas == 1 && RwallclimFlag == false && LwallclimFlag == false && skillOn[5]
            && avoidAngle[0] <= PlayerSita && PlayerSita <= avoidAngle[1]{
                if disr >= avoidF{
                    if avoidFAngle[0][0] <= Angle2 && Angle2 <= avoidFAngle[0][1]{
                        Actionlock = true
                        avoidAction(avoideD: true)
                    }
                    if avoidFAngle[1][0] <= Angle2 && Angle2 <= avoidFAngle[1][1]{
                        Actionlock = true
                        avoidAction(avoideD: false)
                    }
                }
            }
        }else{//スワイプの実行処理後
            //歩く、走る動作を行った後の処理
            if RwalkFlag[0] || RwalkFlag[1] || RrunFlag || LwalkFlag[0] || LwalkFlag[1] || LrunFlag{
                print("ストップアクション（歩く、走る終了）")
                stopAction()
                standardAction()
            }
            
            if ClimFlag[ClimFN]{
                print("ストップアクション（壁走り終了）")
                stopAction()
                ClimEndAction()
            }

            //空中移動を行った後の処理
            if playerstatas == 2{
                if Rairmove || Lairmove{
                    print("ストップアクション（空中移動終了）")
                    stopAction()
                }
            }//ここまで
        }//スワイプ後
        }//アクションロック
    }
    
//3¥スクロールの処理
    func ScrollView(body:SKPhysicsBody){
        let textN = Int(body.mass)
        body.node?.removeFromParent()
      //  scrollContactflag = true
        viewnode.discriptionChangeN(disN: textN, display: true)
        self.isPaused = true
    }
    
    
    func Ptake() -> CGPoint {
        return body.position
    }

}
