//
//  GamesScean.swift
//  testgame
//
//  Created by 清水健志 on 2018/07/26.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class Stage: GameController{
    override func didMove(to view: SKView){
        let stageNumber = viewnode.getSTageN()       //ステージナンバーを取得
        let sceanNumber = viewnode.getSTageSceanN()  //シーンナンバーを取得
        playerHP = viewnode.getplayerHP()            //プレイヤーHPを取得
        contact()                                    //ノッドの当たり判定の読み込み
        enemyTexterLoad()                            //敵のテクスチャーの読み込み
        impulseR = CGFloat(16.0 / 9.0) * (h / w)     //画面のアスペクト比の違いによる力積補正値の計算
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -gra)
        
        if stageNumber == 42{
            HowToClear = 3 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            BackGroundImage(imageName: "bg1")
            
            if sceanNumber == 1{
                ClearP(How: HowToClear)
                
                addplayer(px: 2, py: 3)
                addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
                addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
                addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
                addsquare(xp: 0, yp: 8, xs: 20, ys: 1)
                addsquare(xp: 20, yp: 8, xs: 20, ys: 1)
                addsquare(xp: 40, yp: 8, xs: 12, ys: 1)
                addsquare(xp: 0, yp: 22, xs: 20, ys: 1)
                addsquare(xp: 20, yp: 22, xs: 20, ys: 1)
                addsquare(xp: 40, yp: 22, xs: 12, ys: 1)
                addsquare(xp: 0, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 20, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 40, yp: 39, xs: 12, ys: 1)
                
                addsquare(xp: 0, yp: 1, xs: 1, ys: 7)
                addsquare(xp: 51, yp: 1, xs: 1, ys: 7)
                addsquare(xp: 0, yp: 9, xs: 1, ys: 13)
                addsquare(xp: 32, yp: 9, xs: 1, ys: 13)
                addsquare(xp: 51, yp: 9, xs: 1, ys: 13)
                addsquare(xp: 0, yp: 23, xs: 1, ys: 16)
                addsquare(xp: 12, yp: 23, xs: 1, ys: 16)
                addsquare(xp: 51, yp: 23, xs: 1, ys: 16)
                addsquare(xp: 1, yp: 30, xs: 11, ys: 1)
                addsquare(xp: 13, yp: 31, xs: 4, ys: 1)
                
                addsquare(xp: 40, yp: 14, xs: 11, ys: 3)
                
                addredsquare(xp: 6, yp: 1, xs: 9, ys: 4, Damage: 10, playerContact: false, BloclNumber: 1)
                addredsquare(xp: 15, yp: 3, xs: 2, ys: 2, Damage: 10, playerContact: false, BloclNumber: 2)
                addredsquare(xp: 17, yp: 1, xs: 10, ys: 4, Damage: 10, playerContact: false, BloclNumber: 3)
                addmoveAction(xmove: 0, ymove: 3, time: 6, BlockNumber: 1)
                addmoveAction(xmove: 0, ymove: 3, time: 6, BlockNumber: 2)
                addmoveAction(xmove: 0, ymove: 3, time: 6, BlockNumber: 3)
                
                addredsquare(xp: 30, yp: 1, xs: 2, ys: 2, Damage: 10, BloclNumber: 4)
                addredsquare(xp: 34, yp: 6, xs: 2, ys: 2, Damage: 10, BloclNumber: 5)
                addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 4, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: 0, ymove: -5, time: 3.0, BlockNumber: 5, interval: 0.0, firstinterval: 0.0)
                
                addredsquare(xp: 38, yp: 1, xs: 1, ys: 7, Damage: 10, playerContact: false, BloclNumber: 6)
                addmoveAction(xmove: 8, ymove: 0, time: 5.0, BlockNumber: 6, interval: 0.0, firstinterval: 0.0)
                
                addenemy(xp: 22, yp: 3, type: 2, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 33, yp: 3, type: 22, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 42, yp: 3, type: 22, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                
                adddoor(xp: 49, yp: 1, movepx: 49, movepy: 11)
                
                
                
                addredsquare(xp: 39, yp: 9, xs: 1, ys: 13, Damage: 10, playerContact: false, BloclNumber: 7)
                addrotateAction(dsita: 90, time: 5.0, BlockNumber: 7, interval: 0.0, firstinterval: 0.0)
                adddoor(xp: 49, yp: 17, movepx: 30, movepy: 11)
                
           
                addredsquare(xp: 4, yp: 9, xs: 20, ys: 13, Damage: 10, playerContact: false)
                addredsquare(xp: 24, yp: 9, xs: 5, ys: 13, Damage: 10, playerContact: false)
                addenemy(xp: 24, yp: 14, type: 41, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 24, yp: 18, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                
                addenemy(xp: 5, yp: 11, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 5, yp: 15, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 8, yp: 19, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 11, yp: 15, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 11, yp: 19, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 14, yp: 12, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 17, yp: 15, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 20, yp: 18, type: 42, HP: 1000, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                adddoor(xp: 1, yp: 10, movepx: 2, movepy: 25)
                
                
                addenemy(xp: 9, yp: 25, type: 15, HP: 50, Damage: 10, direction: false, maxn: 2, interval: 5.0, SwitchNumber: 1)
                adddoor(xp: 10, yp: 26, movepx: 2, movepy: 33, BloclNumber: 8)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 8, type: 3, SwitchNumbet: 1)
                
                
                addenemy(xp: 9, yp: 33, type: 26, HP: 50, Damage: 10, direction: false, maxn: 2, interval: 5.0, SwitchNumber: 2)
                adddoor(xp: 10, yp: 34, movepx: 14, movepy: 34, BloclNumber: 9)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 9, type: 3, SwitchNumbet: 2)
                
                
                addredsquare(xp: 13, yp: 23, xs: 20, ys: 3, Damage: 20)
                addredsquare(xp: 33, yp: 23, xs: 18, ys: 3, Damage: 20)
                addredsquare(xp: 27, yp: 36, xs: 2, ys: 3, Damage: 10)
                addredsquare(xp: 31, yp: 28, xs: 2, ys: 3, Damage: 10)
                addredsquare(xp: 37, yp: 32, xs: 2, ys: 3, Damage: 10)
                addredsquare(xp: 43, yp: 36, xs: 2, ys: 3, Damage: 10)
                addenemy(xp: 20, yp: 32, type: 41, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [3,4,5,6])
                addsquare(xp: 17, yp: 31, xs: 9, ys: 1, type: 2, BlockNumber: 10)
                addsquare(xp: 21, yp: 27, xs: 1, ys: 9, type: 2, BlockNumber: 11)
                addmoveAction(xmove: 26, ymove: 0, time: 40, BlockNumber: 10, interval: 5.0, firstinterval: 5.0, type: 3, SwitchNumber: 3)
                addmoveAction(xmove: 26, ymove: 0, time: 40, BlockNumber: 11, interval: 5.0, firstinterval: 5.0, type: 3, SwitchNumber: 4)
                addrotateAction(dsita: -90, time: 6.0, BlockNumber: 10, type: 1, interval: 0.0, firstinterval: 0.0, SwitchNumber: 5)
                addrotateAction(dsita: -90, time: 6.0, BlockNumber: 11, type: 1, interval: 0.0, firstinterval: 0.0, SwitchNumber: 6)
                adddoor(xp: 49, yp: 36)
            }
          
            if sceanNumber == 2{
                viewnode.stopBvalid()
                addplayer(px: 2, py: 3)
                addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
                addsquare(xp: 20, yp: 0, xs: 5, ys: 1)
                
                addsquare(xp: 10, yp: 1, xs: 1, ys: 20)
                addsquare(xp: 10, yp: 21, xs: 1, ys: 14)
                addsquare(xp: 1, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 21, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 41, yp: 39, xs: 11, ys: 1)
                addsquare(xp: 20, yp: 3, xs: 2, ys: 1)
                addsquare(xp: 20, yp: 4, xs: 1, ys: 20)
                addsquare(xp: 20, yp: 24, xs: 1, ys: 15)
                
                addsquare(xp: 21, yp: 12, xs: 20, ys: 1)
                addsquare(xp: 41, yp: 12, xs: 11, ys: 1)
                addsquare(xp: 51, yp: 13, xs: 1, ys: 20)
                addsquare(xp: 51, yp: 33, xs: 1, ys: 6)
                addsquare(xp: 47, yp: 25, xs: 4, ys: 1)
                addsquare(xp: 47, yp: 35, xs: 4, ys: 1)
                
                addweight(xp: 7, yp: 1, type: 3)
                addweight(xp: 20, yp: 1, type: 1)
                addredsquare(xp: 0, yp: 1, xs: 1, ys: 20, Damage: 20)
                addredsquare(xp: 0, yp: 21, xs: 1, ys: 19, Damage: 20)
                addredsquare(xp: 9, yp: 1, xs: 1, ys: 20, Damage: 20)
                addredsquare(xp: 9, yp: 21, xs: 1, ys: 14, Damage: 20)
                
                addredsquare(xp: 25, yp: 0, xs: 20, ys: 1, Damage: 50)
                addredsquare(xp: 45, yp: 0, xs: 7, ys: 1, Damage: 50)
                addredsquare(xp: 51, yp: 1, xs: 1, ys: 11, Damage: 50)
                
                addcircle(xp: 2, yp: 15, xs: 2, ys: 2, type: 2, BloclNumber: 1)
                addcircle(xp: 6, yp: 29, xs: 2, ys: 2, type: 2, BloclNumber: 2)
                addredcircle(xp: 11, yp: 33, xs: 2, ys: 2, Damage: 20, playerContact: false, BlockNumber: 3)
                addredcircle(xp: 18, yp: 26, xs: 2, ys: 2, Damage: 20, playerContact: false, BlockNumber: 4)
                addredcircle(xp: 11, yp: 20, xs: 2, ys: 2, Damage: 20, playerContact: false, BlockNumber: 5)
                addredcircle(xp: 18, yp: 15, xs: 2, ys: 2, Damage: 20, playerContact: false, BlockNumber: 6)
                addredcircle(xp: 11, yp: 9, xs: 2, ys: 2, Damage: 20, playerContact: false, BlockNumber: 7)
                addredcircle(xp: 18, yp: 4, xs: 2, ys: 2, Damage: 20, playerContact: false, BlockNumber: 8)
                addmoveAction(xmove: 4, ymove: 0, time: 5.0, BlockNumber: 1, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: -4, ymove: 0, time: 5.0, BlockNumber: 2, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: 7, ymove: 0, time: 5.0, BlockNumber: 3, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: -7, ymove: 0, time: 5.0, BlockNumber: 4, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: 7, ymove: 0, time: 5.0, BlockNumber: 5, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: -7, ymove: 0, time: 5.0, BlockNumber: 6, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: 7, ymove: 0, time: 5.0, BlockNumber: 7, interval: 0.0, firstinterval: 0.0)
                addmoveAction(xmove: -7, ymove: 0, time: 5.0, BlockNumber: 8, interval: 0.0, firstinterval: 0.0)
                
                addredsquare(xp: 25, yp: 13, xs: 3, ys: 1, Damage: 20)
                addredsquare(xp: 25, yp: 22, xs: 3, ys: 1, Damage: 20, playerContact: false)
                
                addBlock(xp: 25, yp: 1, xs: 4, ys: 1, type: 1, BlockNumber: 9)
                addBlock(xp: 27, yp: 2, xs: 4, ys: 1, type: 2, BlockNumber: 10)
                addBlock(xp: 29, yp: 3, xs: 4, ys: 1, type: 3, BlockNumber: 11)
                addBlock(xp: 31, yp: 4, xs: 4, ys: 1, type: 4, BlockNumber: 12)
                addBlock(xp: 33, yp: 5, xs: 4, ys: 1, type: 1, BlockNumber: 13)
                addBlock(xp: 35, yp: 6, xs: 4, ys: 1, type: 2, BlockNumber: 14)
                addBlock(xp: 37, yp: 7, xs: 4, ys: 1, type: 3, BlockNumber: 15)
                addBlock(xp: 39, yp: 8, xs: 4, ys: 1, type: 4, BlockNumber: 16)
                addBlock(xp: 43, yp: 7, xs: 4, ys: 1, type: 1, BlockNumber: 17)
                addBlock(xp: 47, yp: 5, xs: 4, ys: 1, type: 2, BlockNumber: 18)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 9, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 10, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 11, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 12, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 13, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 14, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 15, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 16, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 17, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 18, type: 2, outtime: 2.0, intime: 2.0)
                addsquare(xp: 49, yp: 1, xs: 2, ys: 1)
                adddoor(xp: 49, yp: 2, movepx: 49, movepy: 28)
                
                
                addsquare(xp: 26, yp: 19, xs: 23, ys: 1, angle: 30.0, type: 2)
                addsquare(xp: 26, yp: 29, xs: 23, ys: 1, angle: 30.0, type: 2)
                adddoor(xp: 21, yp: 16, movepx: 49, movepy: 37)
                adddoor(xp: 23, yp: 25)
            }
            
            if sceanNumber == 3{
                viewnode.PlayBGM(BGMnumber: 6)
                viewnode.stopBvalid()
                addplayer(px: 16, py: 11)
                
                addsquare(xp: 7, yp: 2, xs: 20, ys: 7)
                addsquare(xp: 27, yp: 2, xs: 22, ys: 7)
                addsquare(xp: 7, yp: 26 ,xs: 20, ys: 7)
                addsquare(xp: 27, yp: 26, xs: 22, ys: 7)
                addsquare(xp: 7, yp: 9, xs: 8, ys: 17)
                addsquare(xp: 42, yp: 9, xs: 8, ys: 17)
                
                addenemy(xp: 28, yp: 9.5, type: 58, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2,3,4,5])
                addsquare(xp: 18, yp: 11, xs: 7, ys: 4, BlockNumber: 1)
                addsquare(xp: 25, yp: 11, xs: 1, ys: 3, BlockNumber: 2)
                addsquare(xp: 32, yp: 20, xs: 7, ys: 4, BlockNumber: 3)
                addsquare(xp: 31, yp: 21, xs: 1, ys: 3, BlockNumber: 4)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 1, type: 3, intime: 4.0, SwitchNumbet: 1)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 2, type: 3, intime: 4.0, SwitchNumbet: 2)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 3, type: 3, intime: 4.0, SwitchNumbet: 3)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 4, type: 3, intime: 4.0, SwitchNumbet: 4)
                addenemyAction(xp: 28, yp: 17, type: 59, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 5, SwitchNumber: [6,7,8,9,10])
                
                addsquare(xp: 18, yp: 20, xs: 7, ys: 4, BlockNumber: 6)
                addsquare(xp: 25, yp: 21, xs: 1, ys: 3, BlockNumber: 7)
                addsquare(xp: 32, yp: 11, xs: 7, ys: 4, BlockNumber: 8)
                addsquare(xp: 31, yp: 11, xs: 1, ys: 3, BlockNumber: 9)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 6, type: 3, intime: 4.0, SwitchNumbet: 6)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 7, type: 3, intime: 4.0, SwitchNumbet: 7)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 8, type: 3, intime: 4.0, SwitchNumbet: 8)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 9, type: 3, intime: 4.0, SwitchNumbet: 9)
                addenemyAction(xp: 28, yp: 17, type: 60, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 10, SwitchNumber: [11,12])
                
                addsquare(xp: 27, yp: 16, xs: 3, ys: 3, BlockNumber: 11)
                addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 11, type: 3, intime: 4.0, SwitchNumbet: 11)
                addenemyAction(xp: 28, yp: 17, type: 56, HP: 100, Damage: 10, direction: true, maxn: 1, interval: 1.0, CFenemy: true, StartSwitchNumber: 12)
            }
        }
        
        if stageNumber == 41{
            BackGroundImage(imageName: "bg9")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            if sceanNumber == 1{
               
                ClearP(How: HowToClear)
                addplayer(px: 3, py: 9)
                addsquare(xp: 0, yp: 0, xs: 1, ys: 6)
                addsquare(xp: 0, yp: 6, xs: 6, ys: 1)
                addsquare(xp: 0, yp: 7, xs: 1, ys: 6)
                addsquare(xp: 1, yp: 12, xs: 5, ys: 1)
                addsquare(xp: 5, yp: 13, xs: 1, ys: 6)
                addsquare(xp: 6, yp: 18, xs: 18, ys: 1)
                addsquare(xp: 23, yp: 12, xs: 1, ys: 6)
                addsquare(xp: 23, yp: 6, xs: 10, ys: 1)
                
                addredsquare(xp: 1, yp: 0, xs: 20, ys: 1, Damage: 100)
                addredsquare(xp: 21, yp: 0, xs: 20, ys: 1, Damage: 100)
                addredsquare(xp: 41, yp: 0, xs: 9, ys: 1, Damage: 100)
                
                addBlock(xp: 6, yp: 12, xs: 17, ys: 1, type: 1, BlockNumber: 1)
                addBlock(xp: 6, yp: 6, xs: 17, ys: 1, type: 2, BlockNumber: 2)
                addBlock(xp: 17, yp: 1, xs: 1, ys: 17, type: 3, BlockNumber: 3)
                addBlock(xp: 11, yp: 1, xs: 1, ys: 17, type: 4, BlockNumber: 4)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 1, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 2, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 3, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 4, type: 1, outtime: 2.0, intime: 2.0)
                
                addvector(xp: 7, yp: 8, sita: 90)
                addvector(xp: 13, yp: 8, sita: 180)
                addvector(xp: 13, yp: 14, sita: 90)
                addvector(xp: 19, yp: 14, sita: 0)
                
                addvector(xp: 46, yp: 14, sita: 180)
                addvector(xp: 34, yp: 26, sita: -90)
                
                addBlock(xp: 38, yp: 1, xs: 1, ys: 20, type: 1, BlockNumber: 5)
                addBlock(xp: 38, yp: 21, xs: 1, ys: 9, type: 1, BlockNumber: 6)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 5, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 6, type: 2, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 33, yp: 12, xs: 17, ys: 1, type: 2, BlockNumber: 7)
                addBlock(xp: 44, yp: 19, xs: 1, ys: 11, type: 2, BlockNumber: 8)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 7, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 8, type: 2, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 33, yp: 6, xs: 17, ys: 1, type: 3, BlockNumber: 9)
                addBlock(xp: 33, yp: 24, xs: 17, ys: 1, type: 3, BlockNumber: 10)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 9, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 10, type: 1, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 44, yp: 1, xs: 1, ys: 17, type: 4, BlockNumber: 11)
                addBlock(xp: 33, yp: 18, xs: 17, ys: 1, type: 4, BlockNumber: 12)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 11, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 12, type: 1, outtime: 2.0, intime: 2.0)
                
                addsquare(xp: 50, yp: 0, xs: 1, ys: 20)
                addsquare(xp: 50, yp: 20, xs: 1, ys: 10)
                addsquare(xp: 24, yp: 30, xs: 20, ys: 1)
                addsquare(xp: 44, yp: 30, xs: 7, ys: 1)
                addsquare(xp: 24, yp: 24, xs: 1, ys: 6)
                addsquare(xp: 25, yp: 24, xs: 8, ys: 1)
                adddoor(xp: 25, yp: 25)
                
                addredsquare(xp: 24, yp: 12, xs: 9, ys: 12, Damage: 100)
            }
            if sceanNumber == 2{
                viewnode.stopBvalid()
                addplayer(px: 2, py: 37)
                addsquare(xp: 0, yp: 34, xs: 8, ys: 1)
                addsquare(xp: 0, yp: 35, xs: 1, ys: 5)
                addsquare(xp: 1, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 21, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 41, yp: 39, xs: 11, ys: 1)
                addsquare(xp: 44, yp: 23, xs: 8, ys: 1)
                addsquare(xp: 51, yp: 24, xs: 1, ys: 15)
                addsquare(xp: 44, yp: 34, xs: 4, ys: 1)
                addsquare(xp: 47, yp: 28, xs: 1, ys: 6)
                
                addsquare(xp: 4, yp: 37, xs: 2, ys: 2)
                
                addredsquare(xp: 0, yp: 33, xs: 20, ys: 1, Damage: 50)
                addredsquare(xp: 20, yp: 33, xs: 24, ys: 1, Damage: 50)
                
                addgoal(xp: 4, yp: 27)
                
                addweight(xp: 4, yp: 35, type: 1)
                addweight(xp: 12, yp: 22, type: 2)
                addvector(xp: 9, yp: 24, sita: -135)
                
                addBlock(xp: 14, yp: 34, xs: 3, ys: 1, type: 1, BlockNumber: 13)
                addBlock(xp: 20, yp: 34, xs: 3, ys: 1, type: 1, BlockNumber: 14)
                addBlock(xp: 35, yp: 34, xs: 3, ys: 1, type: 1, BlockNumber: 15)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 13, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 14, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 15, type: 2, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 11, yp: 34, xs: 3, ys: 1, type: 2, BlockNumber: 16)
                addBlock(xp: 26, yp: 34, xs: 3, ys: 1, type: 2, BlockNumber: 17)
                addBlock(xp: 38, yp: 34, xs: 3, ys: 1, type: 2, BlockNumber: 18)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 16, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 17, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 18, type: 2, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 17, yp: 34, xs: 3, ys: 1, type: 3, BlockNumber: 19)
                addBlock(xp: 32, yp: 34, xs: 3, ys: 1, type: 3, BlockNumber: 20)
                addBlock(xp: 41, yp: 34, xs: 3, ys: 1, type: 3, BlockNumber: 21)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 19, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 20, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 21, type: 1, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 8, yp: 34, xs: 3, ys: 1, type: 4, BlockNumber: 22)
                addBlock(xp: 23, yp: 34, xs: 3, ys: 1, type: 4, BlockNumber: 23)
                addBlock(xp: 29, yp: 34, xs: 3, ys: 1, type: 4, BlockNumber: 24)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 22, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 23, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 24, type: 1, outtime: 2.0, intime: 2.0)
                
                
                addBlock(xp: 37, yp: 23, xs: 5, ys: 1, type: 1, BlockNumber: 25)
                addBlock(xp: 28, yp: 17, xs: 5, ys: 1, type: 1, BlockNumber: 26)
                addBlock(xp: 28, yp: 7, xs: 5, ys: 1, type: 1, BlockNumber: 27)
                addBlock(xp: 3, yp: 8, xs: 5, ys: 1, type: 1, BlockNumber: 28)
                addBlock(xp: 3, yp: 12, xs: 5, ys: 1, type: 1, BlockNumber: 29)
                addBlock(xp: 3, yp: 16, xs: 5, ys: 1, type: 1, BlockNumber: 30)
                addBlock(xp: 3, yp: 20, xs: 5, ys: 1, type: 1, BlockNumber: 31)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 25, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 26, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 27, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 28, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 29, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 30, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 31, type: 2, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 30, yp: 24, xs: 5, ys: 1, type: 2, BlockNumber: 32)
                addBlock(xp: 34, yp: 15, xs: 5, ys: 1, type: 2, BlockNumber: 33)
                addBlock(xp: 21, yp: 4, xs: 5, ys: 1, type: 2, BlockNumber: 34)
                addBlock(xp: 10, yp: 9, xs: 5, ys: 1, type: 2, BlockNumber: 35)
                addBlock(xp: 10, yp: 13, xs: 5, ys: 1, type: 2, BlockNumber: 36)
                addBlock(xp: 10, yp: 17, xs: 5, ys: 1, type: 2, BlockNumber: 37)
                addBlock(xp: 10, yp: 21, xs: 5, ys: 1, type: 2, BlockNumber: 38)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 32, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 33, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 34, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 35, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 36, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 37, type: 2, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 38, type: 2, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 22, yp: 25, xs: 5, ys: 1, type: 3, BlockNumber: 39)
                addBlock(xp: 40, yp: 12, xs: 5, ys: 1, type: 3, BlockNumber: 40)
                addBlock(xp: 13, yp: 5, xs: 5, ys: 1, type: 3, BlockNumber: 41)
                addBlock(xp: 17, yp: 10, xs: 5, ys: 1, type: 3, BlockNumber: 42)
                addBlock(xp: 17, yp: 14, xs: 5, ys: 1, type: 3, BlockNumber: 43)
                addBlock(xp: 17, yp: 18, xs: 5, ys: 1, type: 3, BlockNumber: 44)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 39, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 40, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 41, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 42, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 43, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 2.0, BlockNumber: 44, type: 1, outtime: 2.0, intime: 2.0)
                
                addBlock(xp: 26, yp: 21, xs: 5, ys: 1, type: 4, BlockNumber: 45)
                addBlock(xp: 34, yp: 10, xs: 5, ys: 1, type: 4, BlockNumber: 46)
                addBlock(xp: 5, yp: 6, xs: 5, ys: 1, type: 4, BlockNumber: 47)
                addBlock(xp: 10, yp: 11, xs: 5, ys: 1, type: 4, BlockNumber: 48)
                addBlock(xp: 10, yp: 15, xs: 5, ys: 1, type: 4, BlockNumber: 49)
                addBlock(xp: 10, yp: 19, xs: 5, ys: 1, type: 4, BlockNumber: 50)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 45, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 46, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 47, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 48, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 49, type: 1, outtime: 2.0, intime: 2.0)
                addinoutAction(outinterval: 6.0, ininterval: 6.0, firstinterval: 6.0, BlockNumber: 50, type: 1, outtime: 2.0, intime: 2.0)
                
                addredsquare(xp: 0, yp: 0, xs: 20, ys: 1, Damage: 100)
                addredsquare(xp: 20, yp: 0, xs: 20, ys: 1, Damage: 100)
                addredsquare(xp: 40, yp: 0, xs: 12, ys: 1, Damage: 100)
                addredsquare(xp: 51, yp: 1, xs: 1, ys: 22, Damage: 100)
         
                addredsquare(xp: 19, yp: 24, xs: 2, ys: 8, Damage: 20)
            }
            
        }
        
        if stageNumber == 40{
            BackGroundImage(imageName: "bg9")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 3)
            addsquare(xp: 1, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 0, xs: 5, ys: 1)
            
            addsquare(xp: 1, yp: 18, xs: 13, ys: 1)
            addsquare(xp: 1, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 41, yp: 39, xs: 10, ys: 1)
            addsquare(xp: 31, yp: 36, xs: 2, ys: 3)
            addsquare(xp: 26, yp: 33, xs: 7, ys: 1)
            
            addsquare(xp: 31, yp: 27, xs: 20, ys: 1)
            addsquare(xp: 27, yp: 22, xs: 21, ys: 1)
            addsquare(xp: 47, yp: 4, xs: 1, ys: 18)
            addsquare(xp: 43, yp: 0, xs: 8, ys: 1)
            addsquare(xp: 27, yp: 1, xs: 5, ys: 1)
            addsquare(xp: 27, yp: 2, xs: 1, ys: 2)
            addsquare(xp: 27, yp: 10, xs: 3, ys: 1)
            addsquare(xp: 32, yp: 6, xs: 5, ys: 1)
            addsquare(xp: 39, yp: 14, xs: 4, ys: 1)
            
            addredsquare(xp: 0, yp: 0, xs: 1, ys: 20, Damage: 10)
            addredsquare(xp: 0, yp: 20, xs: 1, ys: 20, Damage: 10)
            
            addredsquare(xp: 51, yp: 0, xs: 1, ys: 20, Damage: 10)
            addredsquare(xp: 51, yp: 20, xs: 1, ys: 20, Damage: 10)
            
            addredsquare(xp: 26, yp: 0, xs: 17, ys: 1, Damage: 20)
            addredsquare(xp: 26, yp: 1, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 26, yp: 21, xs: 1, ys: 12, Damage: 20)
            addredsquare(xp: 27, yp: 32, xs: 21, ys: 1, Damage: 20)
            
            addredsquare(xp: 27, yp: 13, xs: 12, ys: 1, Damage: 20)
            addredsquare(xp: 35, yp: 18, xs: 1, ys: 4, Damage: 20)
            
            addgoal(xp: 28, yp: 18)
            addweight(xp: 31, yp: 34, type: 1)
            addweight(xp: 45, yp: 1, type: 3)
            
            addenemy(xp: 44, yp: 29, type: 11, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 38, yp: 29, type: 11, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 32, yp: 29, type: 11, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 46, yp: 24, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 40, yp: 24, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 34, yp: 24, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            
            addBlock(xp: 6, yp: 5, xs: 5, ys: 1, type: 3, BlockNumber: 1)
            addBlock(xp: 17, yp: 13, xs: 5, ys: 1, type: 3, BlockNumber: 2)
         
            addBlock(xp: 33, yp: 33, xs: 3, ys: 1, type: 3, BlockNumber: 4)
            addBlock(xp: 42, yp: 33, xs: 3, ys: 1, type: 3, BlockNumber: 5)
            addBlock(xp: 41, yp: 28, xs: 1, ys: 5, type: 3, BlockNumber: 6)
            addBlock(xp: 43, yp: 23, xs: 1, ys: 5, type: 3, BlockNumber: 7)
            
            addBlock(xp: 33, yp: 12, xs: 5, ys: 1, type: 3, BlockNumber: 8)
            addBlock(xp: 38, yp: 15, xs: 1, ys: 7, type: 3, BlockNumber: 9)
            
            
            addBlock(xp: 16, yp: 5, xs: 5, ys: 1, type: 1, BlockNumber: 10)
            addBlock(xp: 4, yp: 10, xs: 5, ys: 1, type: 1, BlockNumber: 11)
            
            addBlock(xp: 39, yp: 33, xs: 3, ys: 1, type: 1, BlockNumber: 13)
            addBlock(xp: 48, yp: 33, xs: 3, ys: 1, type: 1, BlockNumber: 14)
            addBlock(xp: 35, yp: 28, xs: 1, ys: 5, type: 1, BlockNumber: 15)
            addBlock(xp: 37, yp: 23, xs: 1, ys: 5, type: 1, BlockNumber: 16)
            
            addBlock(xp: 42, yp: 7, xs: 5, ys: 1, type: 1, BlockNumber: 17)
            addBlock(xp: 33, yp: 14, xs: 6, ys: 1, type: 1, BlockNumber: 18)
            
            
            addBlock(xp: 11, yp: 5, xs: 5, ys: 1, type: 2, BlockNumber: 19)
            addBlock(xp: 12, yp: 13, xs: 5, ys: 1, type: 2, BlockNumber: 20)
            
            addBlock(xp: 36, yp: 33, xs: 3, ys: 1, type: 2, BlockNumber: 22)
            addBlock(xp: 45, yp: 33, xs: 3, ys: 1, type: 2, BlockNumber: 23)
            addBlock(xp: 47, yp: 28, xs: 1, ys: 5, type: 2, BlockNumber: 24)
            addBlock(xp: 31, yp: 23, xs: 1, ys: 5, type: 2, BlockNumber: 25)
            
            addBlock(xp: 42, yp: 9, xs: 5, ys: 1, type: 2, BlockNumber: 26)
            addBlock(xp: 32, yp: 7, xs: 1, ys: 6, type: 2, BlockNumber: 27)
            
            addredsquare(xp: 42, yp: 8, xs: 5, ys: 1, Damage: 20)
            
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 1, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 2, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 4, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 5, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 6, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 7, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 8, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 9, type: 1, outtime: 0.0, intime: 0.0)
            
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 10, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 11, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 13, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 14, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 15, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 16, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 17, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 18, type: 1, outtime: 0.0, intime: 0.0)
            
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 19, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 20, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 22, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 23, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 24, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 25, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 26, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 27, type: 1, outtime: 0.0, intime: 0.0)
            
            addBlock(xp: 6, yp: 22, xs: 1, ys: 7, type: 3, BlockNumber: 28)
            addBlock(xp: 7, yp: 28, xs: 6, ys: 1, type: 3, BlockNumber: 29)
            addBlock(xp: 13, yp: 22, xs: 6, ys: 1, type: 3, BlockNumber: 30)
            addBlock(xp: 6, yp: 35, xs: 1, ys: 4, type: 3, BlockNumber: 31)
            addBlock(xp: 12, yp: 34, xs: 7, ys: 1, type: 3, BlockNumber: 32)
            addBlock(xp: 18, yp: 29, xs: 1, ys: 5, type: 3, BlockNumber: 33)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 28, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 29, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 30, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 31, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 32, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 0.0, BlockNumber: 33, type: 1, outtime: 0.0, intime: 0.0)

            addBlock(xp: 1, yp: 28, xs: 5, ys: 1, type: 1, BlockNumber: 34)
            addBlock(xp: 12, yp: 23, xs: 1, ys: 17, type: 1, BlockNumber: 35)
            addBlock(xp: 19, yp: 22, xs: 6, ys: 1, type: 1, BlockNumber: 36)
            addBlock(xp: 19, yp: 34, xs: 6, ys: 1, type: 1, BlockNumber: 37)
            addBlock(xp: 24, yp: 23, xs: 1, ys: 11, type: 1, BlockNumber: 38)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 34, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 35, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 36, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 37, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 4.0, BlockNumber: 38, type: 1, outtime: 0.0, intime: 0.0)
            
            addBlock(xp: 7, yp: 22, xs: 6, ys: 1, type: 2, BlockNumber: 39)
            addBlock(xp: 13, yp: 28, xs: 6, ys: 1, type: 2, BlockNumber: 40)
            addBlock(xp: 18, yp: 23, xs: 1, ys: 5, type: 2, BlockNumber: 41)
            addBlock(xp: 6, yp: 29, xs: 1, ys: 6, type: 2, BlockNumber: 42)
            addBlock(xp: 7, yp: 34, xs: 5, ys: 1, type: 2, BlockNumber: 43)
            addBlock(xp: 18, yp: 35, xs: 1, ys: 4, type: 2, BlockNumber: 44)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 39, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 40, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 41, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 42, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 43, type: 1, outtime: 0.0, intime: 0.0)
            addinoutAction(outinterval: 8.0, ininterval: 4.0, firstinterval: 8.0, BlockNumber: 44, type: 1, outtime: 0.0, intime: 0.0)
            
            addvector(xp: 2, yp: 24, sita: 90)
            addvector(xp: 20, yp: 24, sita: 180)
            addvector(xp: 2, yp: 30, sita: 180)
            addvector(xp: 8, yp: 35, sita: 90)
            addvector(xp: 14, yp: 30, sita: -90)
            
            addvector(xp: 41, yp: 2, sita: -90)
            addvector(xp: 27, yp: 4, sita: 180)
            addvector(xp: 38, yp: 8, sita: 135)
            addvector(xp: 44, yp: 13, sita: 180)
            
            addredsquare(xp: 6, yp: 4, xs: 15, ys: 1, Damage: 10)
            addredsquare(xp: 4, yp: 9, xs: 5, ys: 1, Damage: 10)
            addredsquare(xp: 12, yp: 12, xs: 10, ys: 1, Damage: 10)
            addredsquare(xp: 18, yp: 21, xs: 7, ys: 1, Damage: 10)
            addredsquare(xp: 1, yp: 27, xs: 17, ys: 1, Damage: 10)
            addredsquare(xp: 7, yp: 33, xs: 17, ys: 1, Damage: 10)
        }
        
        
        if stageNumber == 39{
            BackGroundImage(imageName: "bg2")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            if sceanNumber == 1{
                ClearP(How: HowToClear)
                addplayer(px: 3, py: 3)
                addweight(xp: 5, yp: 1, type: 3)
                addsquare(xp: 1, yp: 0, xs: 5, ys: 1)
                addredsquare(xp: 0, yp: 0, xs: 1, ys: 22, Damage: 20)
                addredsquare(xp: 6, yp: 0, xs: 1, ys: 18, Damage: 20)
                addsquare(xp: 0, yp: 22, xs: 6, ys: 1)
                addredsquare(xp: 6, yp: 18, xs: 1, ys: 5, Damage: 30, playerContact: false)
                
                addsquare(xp: 7, yp: 17, xs: 7, ys: 1)
                addsquare(xp: 13, yp: 18, xs: 1, ys: 5)
                
                addsquare(xp: 0, yp: 39, xs: 6, ys: 1)
                
                addenemy(xp: 2, yp: 20, type: 42, HP: 500, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 2, yp: 37, type: 42, HP: 500, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                
                addredsquare(xp: 6, yp: 34, xs: 1, ys: 6, Damage: 20, playerContact: false)
                addredsquare(xp: 0, yp: 23, xs: 6, ys: 2, Damage: 20)
                addredsquare(xp: 0, yp: 25, xs: 5, ys: 2, Damage: 20)
                addredsquare(xp: 0, yp: 27, xs: 4, ys: 2, Damage: 20)
                addredsquare(xp: 0, yp: 29, xs: 3, ys: 2, Damage: 20)
                addredsquare(xp: 0, yp: 31, xs: 2, ys: 2, Damage: 20)
                addredsquare(xp: 0, yp: 33, xs: 1, ys: 6, Damage: 20)
                
                addredsquare(xp: 12, yp: 23, xs: 2, ys: 2, Damage: 20)
                addredsquare(xp: 11, yp: 25, xs: 3, ys: 2, Damage: 20)
                addredsquare(xp: 10, yp: 27, xs: 4, ys: 2, Damage: 20)
                addredsquare(xp: 9, yp: 29, xs: 5, ys: 2, Damage: 20)
                addredsquare(xp: 8, yp: 31, xs: 6, ys: 2, Damage: 20)
                addredsquare(xp: 7, yp: 33, xs: 7, ys: 1, Damage: 20)
         
                addsquare(xp: 7, yp: 34, xs: 7, ys: 1)
                
                addsquare(xp: 7, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 27, yp: 39, xs: 20, ys: 1)
                addsquare(xp: 47, yp: 39, xs: 5, ys: 1)
                addsquare(xp: 51, yp: 0, xs: 1, ys: 20)
                addsquare(xp: 51, yp: 20, xs: 1, ys: 19)
                
                
                adddoor(xp: 49, yp: 17)
                addsquare(xp: 47, yp: 0, xs: 4, ys: 17)
                
                addsquare(xp: 19, yp: 0, xs: 8, ys: 1)
                addsquare(xp: 32, yp: 15, xs: 1, ys: 8)
                addsquare(xp: 32, yp: 34, xs: 7, ys: 1)
                addsquare(xp: 40, yp: 23, xs: 6, ys: 1)
                
                addsquare(xp: 21, yp: 26, xs: 1, ys: 6)
                addsquare(xp: 24, yp: 26, xs: 1, ys: 6)
                
                addredsquare(xp: 7, yp: 0, xs: 7, ys: 17, Damage: 20)
                addredsquare(xp: 32, yp: 0, xs: 15, ys: 17, Damage: 20)
                addredsquare(xp: 23, yp: 32, xs: 1, ys: 11, Damage: 20)
                addredsquare(xp: 41, yp: 24, xs: 10, ys: 1, Damage: 20)
                
                addredsquare(xp: 21, yp: 32, xs: 4, ys: 7, Damage: 20)
                addredsquare(xp: 22, yp: 26, xs: 2, ys: 6, Damage: 20)
                addredsquare(xp: 21, yp: 23, xs: 4, ys: 3, Damage: 20)
                addredsquare(xp: 22, yp: 11, xs: 2, ys: 12, Damage: 20)
                
                addredsquare(xp: 7, yp: 8, xs: 18, ys: 1, Damage: 20, angle: -70.0)
                addredsquare(xp: 21, yp: 8, xs: 18, ys: 1, Damage: 20, angle: 70.0)
                addredsquare(xp: 16, yp: 17, xs: 12, ys: 1, Damage: 20, angle: -85)
                addredsquare(xp: 18, yp: 17, xs: 12, ys: 1, Damage: 20, angle: 85)
                
                addredsquare(xp: 29, yp: 28, xs: 14, ys: 1, Damage: 20, angle: 60.0)
                addredsquare(xp: 36, yp: 31, xs: 17, ys: 1, Damage: 20, angle: 60.0)
            }
            
            if sceanNumber == 2{
                viewnode.stopBvalid()
                addplayer(px: 2, py: 36)
                addweight(xp: 5, yp: 34, type: 3)
                addsquare(xp: 0, yp: 33, xs: 6, ys: 1)
                addsquare(xp: 0, yp: 24, xs: 1, ys: 6)
                addsquare(xp: 1, yp: 39, xs: 5, ys: 1)
                
                addsquare(xp: 51, yp: 10, xs: 1, ys: 20)
                addsquare(xp: 51, yp: 30, xs: 1, ys: 9)
                
                addsquare(xp: 9, yp: 17, xs: 12, ys: 1)
                addsquare(xp: 9, yp: 13, xs: 8, ys: 1)
                
                addvector(xp: 7, yp: 34, sita: 0)
                addvector(xp: 48, yp: 22, sita: 0)
                addvector(xp: 31, yp: 11, sita: 0)
                addvector(xp: 17, yp: 3, sita: 180)
                addvector(xp: 3, yp: 10, sita: 90)
                addvector(xp: 11, yp: 9, sita: 0)
                addvector(xp: 11, yp: 4, sita: -90)
                
                addgoal(xp: 1, yp: 1)
                
                addredsquare(xp: 6, yp: 39, xs: 20, ys: 1, Damage: 40)
                addredsquare(xp: 26, yp: 39, xs: 20, ys: 1, Damage: 40)
                addredsquare(xp: 46, yp: 39, xs: 6, ys: 1, Damage: 40)
                
                addredsquare(xp: 0, yp: 0, xs: 20, ys: 1, Damage: 40)
                addredsquare(xp: 20, yp: 0, xs: 20, ys: 1, Damage: 40)
                addredsquare(xp: 40, yp: 0, xs: 12, ys: 1, Damage: 40)
                addredsquare(xp: 51, yp: 1, xs: 1, ys: 9, Damage: 40)
                
                addredsquare(xp: 0, yp: 1, xs: 1, ys: 20, Damage: 40)
                addredsquare(xp: 0, yp: 21, xs: 1, ys: 12, Damage: 40)
                addredsquare(xp: 1, yp: 18, xs: 20, ys: 1, Damage: 40)
                addredsquare(xp: 21, yp: 18, xs: 20, ys: 1, Damage: 40)
                addredsquare(xp: 41, yp: 18, xs: 6, ys: 1, Damage: 40)
                
                addredsquare(xp: 1, yp: 7, xs: 8, ys: 2, Damage: 40)
                addredsquare(xp: 8, yp: 1, xs: 9, ys: 2, Damage: 40)
                addredsquare(xp: 15, yp: 3, xs: 2, ys: 10, Damage: 40)
                
                addredsquare(xp: 11, yp: 29, xs: 3, ys: 10, Damage: 40, playerContact: false)
                addredsquare(xp: 21, yp: 19, xs: 3, ys: 10, Damage: 40, playerContact: false)
                addredsquare(xp: 30, yp: 29, xs: 3, ys: 10, Damage: 40, playerContact: false)
                addredsquare(xp: 38, yp: 19, xs: 3, ys: 10, Damage: 40, playerContact: false)
                addredsquare(xp: 45, yp: 29, xs: 3, ys: 10, Damage: 40, playerContact: false)
                
                addsquare(xp: 1, yp: 19, xs: 10, ys: 1, type: 2, BlockNumber: 1)
                addsquare(xp: 1, yp: 38, xs: 10, ys: 1, type: 2, BlockNumber: 2)
                addmoveAction(xmove: 36, ymove: 0, time: 40, BlockNumber: 1, interval: 5.0, firstinterval: 5.0, type: 3)
                addmoveAction(xmove: 36, ymove: 0, time: 40, BlockNumber: 2, interval: 5.0, firstinterval: 5.0, type: 3)
                
                addsquare(xp: 45, yp: 10, xs: 6, ys: 1, type: 2, BlockNumber: 3)
                addsquare(xp: 29, yp: 1, xs: 6, ys: 1, type: 2, BlockNumber: 4)
                addmoveAction(xmove: -11, ymove: 0, time: 10, BlockNumber:3, interval: 5.0, firstinterval: 1.0, type: 3, SwitchNumber: 1)
                addmoveAction(xmove: -12, ymove: 0, time: 10, BlockNumber:4, interval: 5.0, firstinterval: 1.0, type: 3, SwitchNumber: 2)
                
                addenemy(xp: 45, yp: 11, type: 42, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 1)
                addenemy(xp: 29, yp: 2, type: 42, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 2)
            }
        }
        
        if stageNumber == 38{
            BackGroundImage(imageName: "bg2")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 3)
            addweight(xp: 8, yp: 2, type: 3)
            addvector(xp: 8, yp: 6, sita: 180)
            
            addcircle(xp: 3, yp: 18, xs: 3, ys: 3, type: 2)
            
            addsquare(xp: 1, yp: 0, xs: 11, ys: 1)
            addredsquare(xp: 0, yp: 0, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 0, yp: 20, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 12, yp: 0, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 12, yp: 20, xs: 1, ys: 13, Damage: 20)
            
            addsquare(xp: 12, yp: 33, xs: 6, ys: 1)
            addsquare(xp: 26, yp: 33, xs: 6, ys: 1)
            addsquare(xp: 40, yp: 33, xs: 6, ys: 1)
            addredsquare(xp: 18, yp: 33, xs: 8, ys: 1, Damage: 20)
            addredsquare(xp: 32, yp: 33, xs: 8, ys: 1, Damage: 20)
            
            addsquare(xp: 1, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 41, yp: 39, xs: 10, ys: 1)
            
            addsquare(xp: 51, yp: 28, xs: 1, ys: 6)
            addredsquare(xp: 51, yp: 34, xs: 1, ys: 5, Damage: 20)
            
            addredsquare(xp: 17, yp: 27, xs: 2, ys: 1, Damage: 20)
            addsquare(xp: 19, yp: 27, xs: 6, ys: 1)
            addredsquare(xp: 25, yp: 27, xs: 8, ys: 1, Damage: 20)
            addsquare(xp: 33, yp: 27, xs: 6, ys: 1)
            addredsquare(xp: 39, yp: 27, xs: 13, ys: 1, Damage: 20)
            
            addsquare(xp: 13, yp: 20, xs: 6, ys: 1)
        
            addsquare(xp: 13, yp: 23, xs: 1, ys: 8)
            addsquare(xp: 30, yp: 21, xs: 2, ys: 6)
            
            addsquare(xp: 13, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 33, yp: 0, xs: 19, ys: 1)
            addgoal(xp: 49, yp: 1)
            
            addredsquare(xp: 13, yp: 1, xs: 7, ys: 2, Damage: 20)
            addredsquare(xp: 13, yp: 3, xs: 8, ys: 3, Damage: 20)
            addredsquare(xp: 13, yp: 6, xs: 9, ys: 3, Damage: 20)
            addredsquare(xp: 13, yp: 9, xs: 10, ys: 3, Damage: 20)
            addredsquare(xp: 13, yp: 12, xs: 11, ys: 3, Damage: 20)
            addredsquare(xp: 13, yp: 15, xs: 12, ys: 3, Damage: 20)
            addredsquare(xp: 13, yp: 18, xs: 13, ys: 2, Damage: 20)
            addredsquare(xp: 19, yp: 20, xs: 7, ys: 1, Damage: 20)
            
            addredsquare(xp: 30, yp: 1, xs: 19, ys: 2, Damage: 20)
            addredsquare(xp: 31, yp: 3, xs: 17, ys: 3, Damage: 20)
            addredsquare(xp: 32, yp: 6, xs: 15, ys: 3, Damage: 20)
            addredsquare(xp: 33, yp: 9, xs: 13, ys: 3, Damage: 20)
            addredsquare(xp: 34, yp: 12, xs: 11, ys: 3, Damage: 20)
            addredsquare(xp: 35, yp: 15, xs: 9, ys: 3, Damage: 20)
            addredsquare(xp: 36, yp: 18, xs: 7, ys: 3, Damage: 20)
            
            addredsquare(xp: 51, yp: 9, xs: 1, ys: 3, Damage: 20)
            addredsquare(xp: 50, yp: 12, xs: 2, ys: 3, Damage: 20)
            addredsquare(xp: 49, yp: 15, xs: 3, ys: 3, Damage: 20)
            addredsquare(xp: 48, yp: 18, xs: 4, ys: 9, Damage: 20)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 8)

        }
        
        if stageNumber == 37{
            BackGroundImage(imageName: "bg4")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 5, py: 4)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 2)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 2)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 2)
            addsquare(xp: 0, yp: 12, xs: 20, ys: 2)
            addsquare(xp: 20, yp: 12, xs: 20, ys: 2)
            addsquare(xp: 40, yp: 12, xs: 12, ys: 2)
            addsquare(xp: 0, yp: 24, xs: 20, ys: 2)
            addsquare(xp: 20, yp: 24, xs: 20, ys: 2)
            addsquare(xp: 40, yp: 24, xs: 12, ys: 2)
            addsquare(xp: 0, yp: 36, xs: 20, ys: 2)
            addsquare(xp: 20, yp: 36, xs: 20, ys: 2)
            addsquare(xp: 40, yp: 36, xs: 12, ys: 2)
            
            addsquare(xp: 2, yp: 2, xs: 1, ys: 10)
            addsquare(xp: 2, yp: 14, xs: 1, ys: 10)
            addsquare(xp: 2, yp: 26, xs: 1, ys: 10)
            addsquare(xp: 21, yp: 2, xs: 1, ys: 10)
            addsquare(xp: 21, yp: 14, xs: 1, ys: 10)
            addsquare(xp: 21, yp: 16, xs: 1, ys: 10)
            addsquare(xp: 30, yp: 2, xs: 1, ys: 10)
            addsquare(xp: 30, yp: 14, xs: 1, ys: 10)
            addsquare(xp: 49, yp: 2, xs: 1, ys: 10)
            addsquare(xp: 49, yp: 14, xs: 1, ys: 10)
            addsquare(xp: 51, yp: 26, xs: 1, ys: 10)
            
            addvector(xp: 29, yp: 26, sita: 90)
            addsquare(xp: 24, yp: 2, xs: 4, ys: 10)
            addsquare(xp: 24, yp: 14, xs: 4, ys: 10)
            addsquare(xp: 24, yp: 26, xs: 2, ys: 10)
            addgoal(xp: 49, yp: 30)
            
            addenemy(xp: 18, yp: 4, type: 1, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2,11])
            addenemy(xp: 18, yp: 16, type: 11, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [3,4,12])
            addenemy(xp: 18, yp: 28, type: 21, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [5,6,13])
            addenemy(xp: 45, yp: 5, type: 41, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [7,8,14])
            addenemy(xp: 43, yp: 18, type: 31, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [9,10,15])
            
            addredsquare(xp: 0, yp: 2, xs: 2, ys: 10, Damage: 100, BloclNumber: 1)
            addredsquare(xp: 22, yp: 2, xs: 2, ys: 10, Damage: 100, BloclNumber: 2)
            addredsquare(xp: 0, yp: 14, xs: 2, ys: 10, Damage: 100, BloclNumber: 3)
            addredsquare(xp: 22, yp: 14, xs: 2, ys: 10, Damage: 100, BloclNumber: 4)
            addredsquare(xp: 0, yp: 26, xs: 2, ys: 10, Damage: 100, BloclNumber: 5)
            addredsquare(xp: 22, yp: 26, xs: 2, ys: 10, Damage: 100, BloclNumber: 6)
            addredsquare(xp: 28, yp: 2, xs: 2, ys: 10, Damage: 100, BloclNumber: 7)
            addredsquare(xp: 50, yp: 2, xs: 2, ys: 10, Damage: 100, BloclNumber: 8)
            addredsquare(xp: 28, yp: 14, xs: 2, ys: 10, Damage: 100, BloclNumber: 9)
            addredsquare(xp: 50, yp: 14, xs: 2, ys: 10, Damage: 100, BloclNumber: 10)
            
            addmoveAction(xmove: 10, ymove: 0, time: 20.0, BlockNumber: 1, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 1)
            addmoveAction(xmove: -10, ymove: 0, time: 20.0, BlockNumber: 2, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 2)
            addmoveAction(xmove: 10, ymove: 0, time: 20.0, BlockNumber: 3, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 3)
            addmoveAction(xmove: -10, ymove: 0, time: 20.0, BlockNumber: 4, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 4)
            addmoveAction(xmove: 10, ymove: 0, time: 20.0, BlockNumber: 5, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 5)
            addmoveAction(xmove: -10, ymove: 0, time: 20.0, BlockNumber: 6, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 6)
            addmoveAction(xmove: 10, ymove: 0, time: 20.0, BlockNumber: 7, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 7)
            addmoveAction(xmove: -10, ymove: 0, time: 20.0, BlockNumber: 8, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 8)
            addmoveAction(xmove: 10, ymove: 0, time: 20.0, BlockNumber: 9, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 9)
            addmoveAction(xmove: -10, ymove: 0, time: 20.0, BlockNumber: 10, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 10)
            
            addenemyAction(xp: 11.5, yp: 6, type: 6, HP: 60, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 11, SwitchNumber: 16)
            addenemyAction(xp: 11.5, yp: 18, type: 15, HP: 60, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 12, SwitchNumber: 17)
            addenemyAction(xp: 11.5, yp: 30, type: 26, HP: 60, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 13, SwitchNumber: 18)
            addenemyAction(xp: 39.5, yp: 6, type: 46, HP: 60, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 14, SwitchNumber: 19)
            addenemyAction(xp: 39.5, yp: 18, type: 51, HP: 60, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 15, SwitchNumber: 20)
            
            adddoor(xp: 11, yp: 7, movepx: 5, movepy: 16, BloclNumber: 11)
            adddoor(xp: 11, yp: 19, movepx: 5, movepy: 28, BloclNumber: 12)
            adddoor(xp: 11, yp: 31, movepx: 33, movepy: 4, BloclNumber: 13)
            adddoor(xp: 39, yp: 7, movepx: 33, movepy: 16, BloclNumber: 14)
            adddoor(xp: 39, yp: 16, movepx: 27, movepy: 28, BloclNumber: 15)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 11, type: 3, SwitchNumbet: 16)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 12, type: 3, SwitchNumbet: 17)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 13, type: 3, SwitchNumbet: 18)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 14, type: 3, SwitchNumbet: 19)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 15, type: 3, SwitchNumbet: 20)
            
            addenemy(xp: 34, yp: 30, type: 56, HP: 100, Damage: 10, direction: false, maxn: 3, interval: 1.0)
        }
        
        
        if stageNumber == 36 {
            BackGroundImage(imageName: "bg2")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 2)
            addsquare(xp: 0, yp: 0, xs: 6, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 5)
            
            addsquare(xp: 17, yp: 31, xs: 17, ys: 2)
            addsquare(xp: 17, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 37, yp: 39, xs: 15, ys: 1)
            
            addredsquare(xp: 0, yp: 6, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 0, yp: 26, xs: 1, ys: 14, Damage: 20)
            addredsquare(xp: 1, yp: 39, xs: 16, ys: 1, Damage: 20)
            
            addredsquare(xp: 6, yp: 0, xs: 20, ys: 1, Damage: 20)
            addredsquare(xp: 26, yp: 0, xs: 20, ys: 1, Damage: 20)
            addredsquare(xp: 46, yp: 0, xs: 6, ys: 1, Damage: 20)
            
            addredsquare(xp: 16, yp: 1, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 16, yp: 21, xs: 1, ys: 12, Damage: 20)
            addredsquare(xp: 35, yp: 14, xs: 17, ys: 3, Damage: 20)
            addredsquare(xp: 51, yp: 17, xs: 1, ys: 22, Damage: 20)
            
            addgoal(xp: 49, yp: 1)
            
            addcircle(xp: 6, yp: 2, xs: 5, ys: 5, type: 2)
            addcircle(xp: 1, yp: 11, xs: 5, ys: 5, type: 2)
            
            addcircle(xp: 12, yp: 8, xs: 4, ys: 4, type: 2)
            
            addcircle(xp: 17, yp: 18, xs: 4, ys: 4, type: 2)
            addcircle(xp: 23, yp: 26, xs: 4, ys: 4, type: 2)
            addcircle(xp: 25, yp: 19, xs: 4, ys: 4, type: 2)
            addcircle(xp: 31, yp: 25, xs: 4, ys: 4, type: 2)
            addcircle(xp: 33, yp: 18, xs: 4, ys: 4, type: 2)
            addcircle(xp: 38, yp: 27, xs: 4, ys: 4, type: 2)
            addcircle(xp: 40, yp: 20, xs: 4, ys: 4, type: 2)
            addcircle(xp: 47, yp: 31, xs: 4, ys: 4, type: 2)
            addcircle(xp: 47, yp: 23, xs: 4, ys: 4, type: 2)
            addcircle(xp: 48, yp: 16, xs: 4, ys: 4, type: 2)
            
            addcircle(xp: 13, yp: 17, xs: 3, ys: 3, type: 2, BloclNumber: 1)
            addcircle(xp: 1, yp: 21, xs: 3, ys: 3, type: 2, BloclNumber: 2)
            addcircle(xp: 13, yp: 25, xs: 3, ys: 3, type: 2, BloclNumber: 3)
            addcircle(xp: 1, yp: 29, xs: 3, ys: 3, type: 2, BloclNumber: 4)
            addmoveAction(xmove: -12, ymove: 0, time: 10.0, BlockNumber: 1, interval: 0.0, firstinterval: 0.0)
            addmoveAction(xmove: 12, ymove: 0, time: 10.0, BlockNumber: 2, interval: 0.0, firstinterval: 0.0)
            addmoveAction(xmove: -12, ymove: 0, time: 10.0, BlockNumber: 3, interval: 0.0, firstinterval: 0.0)
            addmoveAction(xmove: 12, ymove: 0, time: 10.0, BlockNumber: 4, interval: 0.0, firstinterval: 0.0)
            
            addcircle(xp: 18, yp: 9, xs: 4, ys: 4, type: 2, BloclNumber: 5)
            addcircle(xp: 21, yp: 5, xs: 4, ys: 4, type: 2, BloclNumber: 6)
            addcircle(xp: 26, yp: 1, xs: 4, ys: 4, type: 2, BloclNumber: 7)
            addcircle(xp: 36, yp: 4, xs: 4, ys: 4, type: 2, BloclNumber: 8)
            addcircle(xp: 45, yp: 7, xs: 4, ys: 4, type: 2, BloclNumber: 9)
            addcircle(xp: 48, yp: 2, xs: 4, ys: 4, type: 2, BloclNumber: 10)
            addmoveAction(xmove: 6, ymove: 0, time: 5.0, BlockNumber: 5)
            addmoveAction(xmove: 0, ymove: -6, time: 5.0, BlockNumber: 6)
            addmoveAction(xmove: 4, ymove: 5, time: 5.0, BlockNumber: 7)
            addmoveAction(xmove: 0, ymove: 6, time: 5.0, BlockNumber: 8)
            addmoveAction(xmove: -4, ymove: -5, time: 5.0, BlockNumber: 9)
            addmoveAction(xmove: 0, ymove: 6, time: 5.0, BlockNumber: 10)
            
            addvector(xp: 40, yp: 33, sita: 0)
            addvector(xp: 43, yp: 24, sita: -90)
            addvector(xp: 21, yp: 23, sita: 0)
            addvector(xp: 26, yp: 6, sita: 90)
            addvector(xp: 40, yp: 9, sita: 45)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 13)
        }
        
        
        if stageNumber == 35 {
            BackGroundImage(imageName: "bg4")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 4, py: 5)
            
            addsquare(xp: 0, yp: 0, xs: 3, ys: 20)
            addsquare(xp: 0, yp: 20, xs: 3, ys: 20)
            addsquare(xp: 49, yp: 0, xs: 3, ys: 20)
            addsquare(xp: 49, yp: 20, xs: 3, ys: 20)
            
            addsquare(xp: 3, yp: 1, xs: 20, ys: 2)
            addsquare(xp: 23, yp: 1, xs: 20, ys: 2)
            addsquare(xp: 43, yp: 1, xs: 6, ys: 2)
            
            addsquare(xp: 3, yp: 7, xs: 12, ys: 1)
            addsquare(xp: 13, yp: 5, xs: 2, ys: 2)
            
            addsquare(xp: 15, yp: 8, xs: 4, ys: 1)
            addsquare(xp: 21, yp: 7, xs: 4, ys: 1)
            addsquare(xp: 27, yp: 6, xs: 5, ys: 1)
            addsquare(xp: 34, yp: 5, xs: 5, ys: 1)
            addsquare(xp: 41, yp: 4, xs: 5, ys: 1)
            
            addsquare(xp: 7, yp: 13, xs: 5, ys: 1)
            addsquare(xp: 16, yp: 13, xs: 5, ys: 1)
            addsquare(xp: 27, yp: 13, xs: 5, ys: 1)
            addsquare(xp: 36, yp: 13, xs: 5, ys: 1)
            addsquare(xp: 46, yp: 15, xs: 3, ys: 1)
            
            addsquare(xp: 3, yp: 19, xs: 20, ys: 2)
            addsquare(xp: 23, yp: 19, xs: 20, ys: 2)
            addsquare(xp: 42, yp: 19, xs: 5, ys: 2)
            
            addsquare(xp: 7, yp: 27, xs: 20, ys: 1)
            addsquare(xp: 27, yp: 27, xs: 22, ys: 1)
            addsquare(xp: 7, yp: 28, xs: 1, ys: 3)
            addsquare(xp: 8, yp: 30, xs: 4, ys: 1)
            
            addsquare(xp: 3, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 23, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 43, yp: 39, xs: 6, ys: 1)
            
            addgoal(xp: 47, yp: 36)
            
            addredsquare(xp: 7, yp: 12, xs: 9, ys: 1, Damage: 20)
            addredsquare(xp: 8, yp: 28, xs: 20, ys: 2, Damage: 50)
            addredsquare(xp: 28, yp: 28, xs: 21, ys: 2, Damage: 50)
            
            addredsquare(xp: 22, yp: 37, xs: 2, ys: 2, Damage: 20)
            addredsquare(xp: 32, yp: 37, xs: 2, ys: 2, Damage: 20)
            addredsquare(xp: 42, yp: 37, xs: 2, ys: 2, Damage: 20)
            
            addweight(xp: 14, yp: 3, type: 1)
            addweight(xp: 10, yp: 9, type: 2)
            
            addenemy(xp: 11, yp: 2, type: 1, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2,3])
            
            addsquare(xp: 13, yp: 3, xs: 1, ys: 2, BlockNumber: 1)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 1, type: 4, SwitchNumbet: 1)
            
            addredsquare(xp: 3, yp: 0, xs: 20, ys: 1, Damage: 100, BloclNumber: 2)
            addredsquare(xp: 23, yp: 0, xs: 26, ys: 1, Damage: 100, BloclNumber: 3)
            addmoveAction(xmove: 0, ymove: 40, time: 120.0, BlockNumber: 2, interval: 0.0, firstinterval: 20.0, type: 3, SwitchNumber: 2)
            addmoveAction(xmove: 0, ymove: 40, time: 120.0, BlockNumber: 3, interval: 0.0, firstinterval: 20.0, type: 3, SwitchNumber: 3)
            
            addsquare(xp: 7, yp: 21, xs: 2, ys: 3, BlockNumber: 4)
            addsquare(xp: 7, yp: 24, xs: 2, ys: 3, BlockNumber: 5)
            addmoveAction(xmove: 36, ymove: 0, time: 8.0, BlockNumber: 4, interval: 0.0, firstinterval: 0.0, type: 3)
            self.run(SKAction.wait(forDuration: 4.0)){
                self.addmoveAction(xmove: 36, ymove: 0, time: 8.0, BlockNumber: 5, interval: 0.0, firstinterval: 0.0, type: 3)
            }
            
            addenemy(xp: 10, yp: 34, type: 42, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [4,5,6,7])
            
            addsquare(xp: 9, yp: 33, xs: 5, ys: 1, type: 2, BlockNumber: 6)
            addsquare(xp: 11, yp: 31, xs: 1, ys: 5, type: 2, BlockNumber: 7)
            addmoveAction(xmove:34 , ymove: 0, time: 30, BlockNumber: 6, interval: 5.0, firstinterval: 0.0, type: 3, SwitchNumber: 4)
            addmoveAction(xmove:34 , ymove: 0, time: 30, BlockNumber: 7, interval: 5.0, firstinterval: 0.0, type: 3, SwitchNumber: 5)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 6, interval: 0.0, firstinterval: 0.0, SwitchNumber: 6)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 7, interval: 0.0, firstinterval: 0.0, SwitchNumber: 7)
        }
        
        if stageNumber == 34 {
            BackGroundImage(imageName: "bg4")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 4, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            
            addsquare(xp: 0, yp: 12, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 12, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 12 ,xs: 12, ys: 1)
            
            addsquare(xp: 0, yp: 29, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 29, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 29, xs: 12, ys: 1)
            
            addsquare(xp: 1, yp: 1, xs: 1, ys: 11)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 11)
            addsquare(xp: 0, yp: 13, xs: 1, ys: 16)
            addsquare(xp: 50, yp: 13, xs: 1, ys: 16)
            
            addsquare(xp: 10, yp: 1, xs: 2, ys: 5)
            addsquare(xp: 10, yp: 10, xs: 7, ys: 2)
            addsquare(xp: 15, yp: 4, xs: 2, ys: 6)
            addsquare(xp: 20, yp: 1, xs: 2, ys: 8)
            addsquare(xp: 22, yp: 8, xs: 7, ys: 1)
            addsquare(xp: 24, yp: 4, xs: 7, ys: 1)
            addsquare(xp: 31, yp: 3, xs: 2, ys: 9)
            addsquare(xp: 35, yp: 1, xs: 8, ys: 2)
            addsquare(xp: 37, yp: 3, xs: 6, ys: 2)
            addsquare(xp: 39, yp: 5, xs: 4, ys: 2)
            addsquare(xp: 41, yp: 7, xs: 2, ys: 2)
            addsquare(xp: 43, yp: 8, xs: 5, ys: 1)
            addsquare(xp: 48, yp: 4, xs: 3, ys: 2)
            
            addsquare(xp: 47, yp: 4, xs: 1, ys: 4, BlockNumber: 1)
            addmoveAction(xmove: 0, ymove: -3, time: 2.0, BlockNumber: 1)
            
            addweight(xp: 31, yp: 1, type: 1)
            addweight(xp: 46, yp: 15, type: 2)
            
            adddoor(xp: 49, yp: 1, movepx: 48, movepy: 15)
            
            addsquare(xp: 8, yp: 21, xs: 6, ys: 1)
            addsquare(xp: 13, yp: 16, xs: 1, ys: 5)
            addsquare(xp: 4, yp: 16, xs: 9, ys: 1)
            addsquare(xp: 4, yp: 17, xs: 1, ys: 9)
            addsquare(xp: 5, yp: 25, xs: 13, ys: 1)
            addsquare(xp: 17, yp: 13, xs: 1, ys: 12)
            
            addsquare(xp: 21, yp: 15, xs: 1, ys: 14)
            addsquare(xp: 22, yp: 20, xs: 9, ys: 1)
            addsquare(xp: 30, yp: 16, xs: 1, ys: 4)
            addsquare(xp: 25, yp: 13, xs: 2, ys: 5)
            addsquare(xp: 25, yp: 24, xs: 17, ys: 2)
            addsquare(xp: 34, yp: 21, xs: 8, ys: 3)
            addsquare(xp: 34, yp: 13, xs: 2, ys: 8)
            
            addsquare(xp: 38, yp: 16, xs: 8, ys: 2)
            addsquare(xp: 44, yp: 18, xs: 2, ys: 11)
            
            addgoal(xp: 10, yp: 18)
            
            addenemy(xp: 12, yp: 19, type: 36, HP: 100, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 32, yp: 22, type: 36, HP: 100, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            
            addenemy(xp: 7, yp: 1, type: 42, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2])
            addenemy(xp: 45, yp: 13, type: 42, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [3,4])
            
            addsquare(xp: 8, yp: 1, xs: 1, ys: 11, BlockNumber: 2)
            addredsquare(xp: 0, yp: 1, xs: 1, ys: 11, Damage: 100, BloclNumber: 3)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 2, type: 4, SwitchNumbet: 1)
            addmoveAction(xmove: 50, ymove: 0, time: 50.0, BlockNumber: 3, interval: 0.0, firstinterval: 5.0, type: 3, SwitchNumber: 2)
            
            addsquare(xp: 44, yp: 13, xs: 1, ys: 3, BlockNumber: 4)
            addredsquare(xp: 51, yp: 13, xs: 1, ys: 16, Damage: 100, BloclNumber: 5)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 4, type: 4, SwitchNumbet: 3)
            addmoveAction(xmove: -50, ymove: 0, time: 75.0, BlockNumber: 5, interval: 0.0, firstinterval: 10.0, type: 3, SwitchNumber: 4)
            
            addweight(xp: 49, yp: 28, type: 3)
            
            
        }
        if stageNumber == 33{
            BackGroundImage(imageName: "bg8")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 4, py: 8)
            addsquare(xp: 0, yp: 0, xs: 2, ys: 13)
            addsquare(xp: 50, yp: 0, xs: 2, ys: 13)
            addsquare(xp: 2, yp: 4, xs: 20, ys: 2)
            addsquare(xp: 22, yp: 4, xs: 20, ys: 2)
            addsquare(xp: 42, yp: 4, xs: 10, ys: 2)
            addsquare(xp: 2, yp: 15, xs: 20, ys: 2)
            addsquare(xp: 22, yp: 15, xs: 20, ys: 2)
            addsquare(xp: 42, yp: 15, xs: 10, ys: 2)
            
            addgoal(xp: 0, yp: 25)
            
            addsquare(xp: 0, yp: 22, xs: 2, ys: 3)
            addsquare(xp: 0, yp: 20, xs: 17, ys: 2)
            addsquare(xp: 15, yp: 22, xs: 2, ys: 6)
            addsquare(xp: 17, yp: 26, xs: 13, ys: 2)
            addsquare(xp: 30, yp: 22, xs: 2, ys: 6)
            addsquare(xp: 30, yp: 20, xs: 21, ys: 2)
            addsquare(xp: 49, yp: 22, xs: 2, ys: 8)
            addsquare(xp: 36, yp: 28, xs: 13, ys: 2)
            addsquare(xp: 36, yp: 30, xs: 2, ys: 4)
            addsquare(xp: 9, yp: 32, xs: 20, ys: 2)
            addsquare(xp: 29, yp: 32, xs: 7, ys: 2)
            addsquare(xp: 9, yp: 28, xs: 2, ys: 4)
            addsquare(xp: 0, yp: 28, xs: 9, ys: 2)
            
            addenemy(xp: 14, yp: 2, type: 34, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 26, yp: 7, type: 35, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 38, yp: 2, type: 34, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            
            addenemy(xp: 7, yp: 28, type: 32, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 18, yp:34, type: 32, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 19, yp:23, type: 33, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 23, yp: 24, type: 32, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 27, yp: 23, type: 33, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 28, yp: 34, type: 32, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 39, yp: 28, type: 32, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            
            adddoor(xp: 48, yp: 6, movepx: 47, movepy: 24, BloclNumber: 1)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 1, type: 3, SwitchNumbet: 1)
            addenemy(xp: 46, yp: 8, type: 25, HP: 50, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
        }
        
        if stageNumber == 32{
            BackGroundImage(imageName: "bg8")
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 7, py: 4)
            
            addsquare(xp: 0, yp: 0, xs: 5, ys: 17)
            addsquare(xp: 5, yp: 14, xs: 11, ys: 3)
            addsquare(xp: 5, yp: 6, xs: 19, ys: 2)
            addsquare(xp: 22, yp: 8, xs: 2, ys: 15)
            addsquare(xp: 5, yp: 23, xs: 19, ys: 2)
            
            addsquare(xp: 0, yp: 17, xs: 2, ys: 14)
            addsquare(xp: 2, yp: 29, xs: 20, ys: 2)
            addsquare(xp: 22, yp: 29, xs: 7, ys: 2)
            addsquare(xp: 27, yp: 0, xs: 2, ys: 20)
            addsquare(xp: 27, yp: 20, xs: 2, ys: 9)
            addsquare(xp: 5, yp: 0, xs: 20, ys: 2)
            addsquare(xp: 25, yp: 0, xs: 2, ys: 2)
            
            addenemy(xp: 13, yp: 8, type: 33, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 20, yp: 14, type: 32, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 15, yp: 21, type: 33, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
        }
        
        if stageNumber == 31{
            BackGroundImage(imageName: "bg8")
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 5, py: 7)
            
            addsquare(xp: 0, yp: 0, xs: 4, ys: 14)
            addsquare(xp: 4, yp: 0, xs: 9, ys: 5)
            addsquare(xp: 13, yp: 0, xs: 3, ys: 4)
            addsquare(xp: 16, yp: 0, xs: 6, ys: 1)
            addsquare(xp: 22, yp: 0, xs: 3, ys: 4)
            addsquare(xp: 25, yp: 0, xs: 2, ys: 5)
            addsquare(xp: 27, yp: 0, xs: 1, ys: 14)
            
            addsquare(xp: 4, yp: 9, xs: 9, ys: 5)
            addsquare(xp: 13, yp: 10, xs: 3, ys: 4)
            addsquare(xp: 16, yp: 13, xs: 6, ys: 1)
            addsquare(xp: 22, yp: 10, xs: 3, ys: 4)
            addsquare(xp: 25, yp: 9, xs: 2, ys: 5)
            
            addenemy(xp: 18.5, yp: 6.5, type: 31, HP: 80, Damage: 10, direction: false, maxn: 1, interval: 1.0)
        }
        
        if stageNumber == 30{
            BackGroundImage(imageName: "bg11")
            HowToClear = 3 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 8, py: 3)
            
            enemymax = 4
        
            addsquare(xp: 0, yp: 19, xs: 1, ys: 21)
            addsquare(xp: 16, yp: 19, xs: 1, ys: 21)
            addsquare(xp: 1, yp: 19, xs: 15, ys: 1)
            addsquare(xp: 1, yp: 29, xs: 15, ys: 1)
            addsquare(xp: 1, yp: 39, xs: 15, ys: 1)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 10, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 10, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 10, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 9)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 9)
            addsquare(xp: 17, yp: 1, xs: 2, ys: 9)
            addsquare(xp: 34, yp: 1, xs: 2, ys: 9)
            
            addsquare(xp: 18, yp: 14, xs: 20, ys: 1)
            addsquare(xp: 38, yp: 14, xs: 14, ys: 1)
            addsquare(xp: 18, yp: 24, xs: 20, ys: 1)
            addsquare(xp: 38, yp: 24, xs: 14, ys: 1)
            addsquare(xp: 18, yp: 15, xs: 1, ys: 9)
            addsquare(xp: 51, yp: 15, xs: 1, ys: 9)
            addsquare(xp: 34, yp: 15, xs: 2, ys: 9)
            
            addsquare(xp: 18, yp: 29, xs: 20, ys: 1)
            addsquare(xp: 38, yp: 29, xs: 14, ys: 1)
            addsquare(xp: 18, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 38, yp: 39, xs: 14, ys: 1)
            addsquare(xp: 18, yp: 30, xs: 1, ys: 9)
            addsquare(xp: 51, yp: 30, xs: 1, ys: 9)
            addsquare(xp: 34, yp: 30, xs: 2, ys: 9)
            
            addsquare(xp: 2, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 21, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 23, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 25, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 27, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 29, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 38, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 40, yp: 7, xs: 1, ys: 1)
            addsquare(xp: 38, yp: 21, xs: 1, ys: 1)
            addsquare(xp: 40, yp: 21, xs: 1, ys: 1)
            addsquare(xp: 42, yp: 21, xs: 1, ys: 1)
            addsquare(xp: 44, yp: 21, xs: 1, ys: 1)
            addsquare(xp: 21, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 23, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 25, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 38, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 40, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 42, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 44, yp: 36, xs: 1, ys: 1)
            addsquare(xp: 46, yp: 36, xs: 1, ys: 1)
            
            adddoor(xp: 1, yp: 20, movepx: 8, movepy: 3)
            adddoor(xp: 1, yp: 30, movepx: 8, movepy: 3)
            
            adddoor(xp: 1, yp: 4, movepx: 8, movepy: 32, BloclNumber: 1)
            adddoor(xp: 15, yp: 4, movepx: 43, movepy: 3, BloclNumber: 2)
            adddoor(xp: 19, yp: 4, movepx: 43, movepy: 32, BloclNumber: 3)
            adddoor(xp: 32, yp: 4, movepx: 8, movepy: 22, BloclNumber: 4)
            adddoor(xp: 36, yp: 4, movepx: 26, movepy: 32, BloclNumber: 5)
            adddoor(xp: 49, yp: 4, movepx: 8, movepy: 32, BloclNumber: 6)
            adddoor(xp: 36, yp: 18, movepx: 8, movepy: 32, BloclNumber: 7)
            adddoor(xp: 49, yp: 18, movepx: 26, movepy: 3, BloclNumber: 8)
            adddoor(xp: 19, yp: 33, movepx: 43, movepy: 17, BloclNumber: 9)
            adddoor(xp: 32, yp: 33, movepx: 8, movepy: 3, BloclNumber: 10)
            adddoor(xp: 36, yp: 33, movepx: 8, movepy: 22, BloclNumber: 11)
            adddoor(xp: 49, yp: 33, movepx: 21, movepy: 17, BloclNumber: 12)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 1, type: 3, SwitchNumbet: 1)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 2, type: 3, SwitchNumbet: 2)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 3, type: 3, SwitchNumbet: 3)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 4, type: 3, SwitchNumbet: 4)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 5, type: 3, SwitchNumbet: 5)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 6, type: 3, SwitchNumbet: 6)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 7, type: 3, SwitchNumbet: 7)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 8, type: 3, SwitchNumbet: 8)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 9, type: 3, SwitchNumbet: 9)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 10, type: 3, SwitchNumbet: 10)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 11, type: 3, SwitchNumbet: 11)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 12, type: 3, SwitchNumbet: 12)
            
            addenemy(xp: 3, yp: 22, type: 21, HP: 20, Damage: 10, direction: true, maxn: 100, interval: 5.0)
            addenemy(xp: 13, yp: 22, type: 11, HP: 20, Damage: 10, direction: false, maxn: 100, interval: 5.0)
            addenemy(xp: 3, yp: 32, type: 11, HP: 20, Damage: 10, direction: true, maxn: 100, interval: 5.0)
            addenemy(xp: 13, yp: 32, type: 1, HP: 20, Damage: 10, direction: false, maxn: 100, interval: 5.0)
           
            addenemy(xp: 2, yp: 2, type: 1, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 15, yp: 2, type: 5, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2])
            
            addenemy(xp: 32, yp: 2, type: 12, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 20, yp: 2, type: 23, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, SwitchNumber: [3,4])
            
            addenemy(xp: 49, yp: 2, type: 11, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 37, yp: 2, type: 13, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, SwitchNumber: [5,6])
            
            addenemy(xp: 39, yp: 19, type: 41, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 47, yp: 19, type: 44, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [7,8])
            
            addenemy(xp: 32, yp: 31, type: 21, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 20, yp: 31, type: 23, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, SwitchNumber: [9,10])
            
            addenemy(xp: 37, yp: 31, type: 21, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 49, yp: 31, type: 14, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [11,12])
            
            addenemy(xp: 30, yp: 16, type: 23, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0, CFenemy: true)
            addenemy(xp: 32, yp: 16, type: 25, HP: 80, Damage: 10, direction: false, maxn: 1, interval: 1.0, CFenemy: true)
            
        }
        
        if stageNumber == 29{
            BackGroundImage(imageName: "bg10")
            HowToClear = 3 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 10, xs: 20, ys: 2)
            addsquare(xp: 20, yp: 10, xs: 20, ys: 2)
            addsquare(xp: 40, yp: 10, xs: 12, ys: 2)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 9)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 9)
            
            addsquare(xp: 0, yp: 12, xs: 1, ys: 20)
            addsquare(xp: 0, yp: 32, xs: 1, ys: 8)
            addsquare(xp: 1, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 39, xs: 6, ys: 1)
            addsquare(xp: 26, yp: 12, xs: 1, ys: 20)
            addsquare(xp: 26, yp: 32, xs: 1, ys: 8)
            
            addsquare(xp: 27, yp: 20, xs: 20, ys: 1)
            addsquare(xp: 47, yp: 20, xs: 5, ys: 1)
            addsquare(xp: 51, yp: 12, xs: 1, ys: 8)
            
            addsquare(xp: 1, yp: 16, xs: 3, ys: 1)
            addsquare(xp: 1, yp: 24, xs: 3, ys: 1)
            addsquare(xp: 1, yp: 32, xs: 3, ys: 1)
            
            addsquare(xp: 23, yp: 20, xs: 3, ys: 1)
            addsquare(xp: 23, yp: 28, xs: 3, ys: 1)
            addredsquare(xp: 4, yp: 16, xs: 3, ys: 1, Damage: 15)
            addredsquare(xp: 4, yp: 24, xs: 3, ys: 1, Damage: 15)
            addredsquare(xp: 4, yp: 32, xs: 3, ys: 1, Damage: 15)
            addredsquare(xp: 20, yp: 20, xs: 3, ys: 1, Damage: 15)
            addredsquare(xp: 20, yp: 28, xs: 3, ys: 1, Damage: 15)
            
            addredsquare(xp: 6, yp: 7, xs: 20, ys: 3, Damage: 15, playerContact: false, BloclNumber: 1)
            addredsquare(xp: 26, yp: 7, xs: 21, ys: 3, Damage: 15, playerContact: false, BloclNumber: 2)
            
            addredsquare(xp: 6, yp: 4, xs: 3, ys: 3, Damage: 15,playerContact: false, BloclNumber: 3)
            addredsquare(xp: 12, yp: 4, xs: 2, ys: 3, Damage: 15,playerContact: false, BloclNumber: 4)
            addredsquare(xp: 17, yp: 4, xs: 2, ys: 3, Damage: 15,playerContact: false, BloclNumber: 5)
            addredsquare(xp: 22, yp: 4, xs: 2, ys: 3, Damage: 15,playerContact: false, BloclNumber: 6)
            addredsquare(xp: 27, yp: 4, xs: 3, ys: 3, Damage: 15,playerContact: false, BloclNumber: 7)
            addredsquare(xp: 33, yp: 4, xs: 4, ys: 3, Damage: 15,playerContact: false, BloclNumber: 8)
            addredsquare(xp: 40, yp: 4, xs: 5, ys: 3, Damage: 15,playerContact: false, BloclNumber: 9)
            
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 1, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 2, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 3, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 4, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 5, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 6, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 7, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 8, interval: 2.0)
            addmoveAction(xmove: 0, ymove: -3, time: 5.0, BlockNumber: 9, interval: 2.0)
            
            addenemy(xp: 15, yp: 1, type: 21, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 25, yp: 1, type: 21, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 35, yp: 1, type: 21, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 45, yp: 1, type: 21, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
            
            adddoor(xp: 49, yp: 1, movepx: 21, movepy: 14)
            
            addenemy(xp: 1, yp: 17, type: 22, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 1, yp: 25, type: 22, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 1, yp: 33, type: 22, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 25, yp: 21, type: 22, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp:25, yp: 29, type: 22, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
        
            adddoor(xp: 21, yp: 35, movepx: 29, movepy: 14)
            
            addsquare(xp: 4, yp: 18, xs: 9, ys: 1, type: 2, BlockNumber: 10)
            addsquare(xp: 8, yp: 14, xs: 1, ys: 9, type: 2, BlockNumber: 11)
            addsquare(xp: 5, yp: 28, xs: 7, ys: 1, type: 2, BlockNumber: 12)
            addsquare(xp: 8, yp: 25, xs: 1, ys: 7, type: 2, BlockNumber: 13)
            addsquare(xp: 13, yp: 23, xs: 9, ys: 1, type: 2, BlockNumber: 14)
            addsquare(xp: 17, yp: 19, xs: 1, ys: 9, type: 2, BlockNumber: 15)
            addsquare(xp: 14, yp: 32, xs: 7, ys: 1, type: 2, BlockNumber: 16)
            addsquare(xp: 17, yp: 29, xs: 1, ys: 7, type: 2, BlockNumber: 17)
            
            addrotateAction(dsita: 90, time: 8.0, BlockNumber: 10, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: 90, time: 8.0, BlockNumber: 11, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: 90, time: 8.0, BlockNumber: 12, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: 90, time: 8.0, BlockNumber: 13, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 14, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 15, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 16, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 17, type: 1, interval: 0.0, firstinterval: 0.0)
            
            addenemy(xp: 37, yp: 14, type: 22, HP: 40, Damage: 15, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 48, yp: 15, type: 23, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0, CFenemy: true)
        }
        
        if stageNumber == 28{
            BackGroundImage(imageName: "bg10")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 2, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 12, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 12, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 12, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 19, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 19, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 19, xs: 12, ys: 1)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 11)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 11)
            addsquare(xp: 51, yp: 13, xs: 1, ys: 6)
            addsquare(xp: 0, yp: 13, xs: 1, ys: 6)
            
            addgoal(xp: 1, yp: 13)
            addsquare(xp: 1, yp: 6, xs: 6, ys: 6)
            addsquare(xp: 4, yp: 3, xs: 3, ys: 3)
            
            adddoor(xp: 49, yp: 1, movepx: 48, movepy: 15)
            
            addredsquare(xp: 7, yp: 4, xs: 20, ys: 3, Damage: 40, playerContact: false, BloclNumber: 1)
            addredsquare(xp: 27, yp: 4, xs: 9, ys: 3, Damage: 40, playerContact: false, BloclNumber: 2)
            addredsquare(xp: 36, yp: 5, xs: 5, ys: 2, Damage: 40, playerContact: false, BloclNumber: 3)
            addredsquare(xp: 41, yp: 4, xs: 4, ys: 3, Damage: 40, playerContact: false, BloclNumber: 4)
            
            addredsquare(xp: 10, yp: 1, xs: 7, ys: 3, Damage: 40, playerContact: false, BloclNumber: 5)
            addredsquare(xp: 19, yp: 1, xs: 9, ys: 3, Damage: 40, playerContact: false, BloclNumber: 6)
            addredsquare(xp: 30, yp: 1, xs: 6, ys: 3, Damage: 40, playerContact: false, BloclNumber: 7)
            addredsquare(xp: 41, yp: 1, xs: 4, ys: 3, Damage: 40, playerContact: false, BloclNumber: 8)
            
            addredsquare(xp: 7, yp: 7, xs: 27, ys: 3, Damage: 40, playerContact: false, BloclNumber: 9)
            addredsquare(xp: 36, yp: 7, xs: 11, ys: 3, Damage: 40, playerContact: false, BloclNumber: 10)
        
            
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 1, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 2, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 3, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 4, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 5, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 6, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 7, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 8, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 9, interval: 0.0, firstinterval: 2.0, type: 2)
            addmoveAction(xmove: 0, ymove: 5, time: 3.0, BlockNumber: 10, interval: 0.0, firstinterval: 2.0, type: 2)
            
            addsquare(xp: 36, yp: 1, xs: 3, ys: 1)
            addsquare(xp: 45, yp: 1, xs: 1.5, ys: 2)
            
            addsquare(xp: 7, yp: 13, xs: 27, ys: 1)
            
            addweight(xp: 5, yp: 1, type: 1)
        
        
        }
        
        if stageNumber == 27{
            BackGroundImage(imageName: "bg10")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 2, py: 11)
            
            addsquare(xp: 0, yp: 0, xs: 1, ys: 20)
            addsquare(xp: 0, yp: 20, xs: 1, ys: 18)
            
            addsquare(xp: 1, yp: 8, xs: 10, ys: 1)
            addsquare(xp: 1, yp: 14, xs: 5, ys: 7)
            addsquare(xp: 4, yp: 11, xs: 2, ys: 3)
            
            addsquare(xp: 1, yp: 25, xs: 10, ys: 1)
            addsquare(xp: 10, yp: 14, xs: 1, ys: 11)
            addsquare(xp: 11, yp: 19, xs: 20, ys: 3)
            addsquare(xp: 31, yp: 19, xs: 15, ys: 3)
            addsquare(xp: 44, yp: 13, xs: 2, ys: 6)
            
            addsquare(xp: 1, yp: 37, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 37, xs: 20, ys: 1)
            addsquare(xp: 41, yp: 37, xs: 11, ys: 1)
            addsquare(xp: 49, yp: 12, xs: 3, ys: 20)
            addsquare(xp: 49, yp: 32, xs: 3, ys: 5)
            
            addsquare(xp: 44, yp: 8, xs: 8, ys: 1)
            addsquare(xp: 51, yp: 0, xs: 1, ys: 8)
            
            addredsquare(xp: 1, yp: 0, xs: 20, ys: 2, Damage: 50)
            addredsquare(xp: 21, yp: 0, xs: 20, ys: 2, Damage: 50)
            addredsquare(xp: 41, yp: 0, xs: 10, ys: 2, Damage: 50)
            
            addredsquare(xp: 20, yp: 15, xs: 2, ys: 4, Damage: 20)
            addredsquare(xp: 31, yp: 15, xs: 2, ys: 4, Damage: 20)
            
            addredsquare(xp: 11, yp: 22, xs: 20, ys: 2, Damage: 50)
            addredsquare(xp: 31, yp: 22, xs: 15, ys: 1, Damage: 50)
            
            addredsquare(xp: 5, yp: 26, xs: 1, ys: 2, Damage: 20)
            
            addredsquare(xp: 22, yp: 33, xs: 1, ys: 4, Damage: 20)
            addredsquare(xp: 30, yp: 24, xs: 1, ys: 6, Damage: 20)
            addredsquare(xp: 39, yp: 33, xs: 1, ys: 4, Damage: 20)
            
            addgoal(xp: 1, yp: 21)
            
            addsquare(xp: 12, yp: 8, xs: 9, ys: 1, type: 2, BlockNumber: 1)
            addsquare(xp: 16, yp: 4, xs: 1, ys: 9, type: 2, BlockNumber: 2)
            addsquare(xp: 22, yp: 8, xs: 9, ys: 1, type: 2, BlockNumber: 3)
            addsquare(xp: 26, yp: 4, xs: 1, ys: 9, type: 2, BlockNumber: 4)
            addsquare(xp: 33, yp: 8, xs: 9, ys: 1, type: 2, BlockNumber: 5)
            addsquare(xp: 37, yp: 4, xs: 1, ys: 9, type: 2, BlockNumber: 6)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 1, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 2, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 3, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 4, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 5, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: -90, time: 8.0, BlockNumber: 6, type: 1, interval: 0.0, firstinterval: 0.0)
            
            addsquare(xp: 49, yp: 9, xs: 3, ys: 3, BlockNumber: 7)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 7, type: 3, outtime: 0.0, intime: 1.0, SwitchNumbet: 1)
            adddoor(xp: 50, yp: 9, movepx: 2, movepy: 28, BloclNumber: 8)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 8, type: 4, outtime: 0.0, intime: 1.0, SwitchNumbet: 2)
            
            addsquare(xp: 11, yp: 29, xs: 9, ys: 1, type: 2, BlockNumber: 9)
            addsquare(xp: 15, yp: 25, xs: 1, ys: 9, type: 2, BlockNumber: 10)
            addmoveAction(xmove: 26, ymove: 0, time: 30.0, BlockNumber: 9, interval: 5.0, firstinterval: 2.0, type: 3, SwitchNumber: 3)
            addmoveAction(xmove: 26, ymove: 0, time: 30.0, BlockNumber: 10, interval: 5.0, firstinterval: 2.0, type: 3, SwitchNumber: 4)
            addrotateAction(dsita: -90.0, time: 8.0, BlockNumber: 9, interval: 0.0, firstinterval: 0.0, SwitchNumber: 5)
            addrotateAction(dsita: -90.0, time: 8.0, BlockNumber: 10, interval: 0.0, firstinterval: 0.0, SwitchNumber: 6)
            
            addenemy(xp: 14, yp: 30, type: 41, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2,3,4,5,6])
        
            addvector(xp: 6.5, yp: 13, sita: -180.0)
            addvector(xp: 46, yp: 28, sita: 0.0)
            addweight(xp: 4, yp: 9, type: 1)
            addweight(xp: 8, yp: 26, type: 2)
        }
        
        
        
        if stageNumber == 26{
            BackGroundImage(imageName: "bg10")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            addplayer(px: 2, py: 8)
            addsquare(xp: 0, yp: 0, xs: 1, ys: 12)
            addsquare(xp: 1, yp: 5, xs: 13, ys: 1)
            addsquare(xp: 1, yp: 11, xs: 3, ys: 1)
            addsquare(xp: 4, yp: 8, xs: 2, ys: 4)
            addsquare(xp: 5, yp: 12, xs: 1, ys: 13)
            addsquare(xp: 6, yp: 24, xs: 20, ys: 1)
            addsquare(xp: 26, yp: 24, xs: 18, ys: 1)
            
            addsquare(xp: 10, yp: 13, xs: 1, ys: 6)
            addsquare(xp: 11, yp: 18, xs: 20, ys: 1)
            addsquare(xp: 31, yp: 18, xs: 21, ys: 1)
            addsquare(xp: 51, yp: 0, xs: 1, ys: 19)
            addsquare(xp: 49, yp: 1, xs: 2, ys: 1)
            addsquare(xp: 44, yp: 19, xs: 1, ys: 5)
            
            addgoal(xp: 42, yp: 21)
            
            addredsquare(xp: 14, yp: 19, xs: 2, ys: 2, Damage: 20, BloclNumber: 2)
            addredsquare(xp: 38, yp: 22, xs: 2, ys: 2, Damage: 20, BloclNumber: 3)
            addmoveAction(xmove: 24, ymove: 0, time: 5.0, BlockNumber: 2, interval: 1.0, type: 1)
            addmoveAction(xmove: -24, ymove: 0, time: 5.0, BlockNumber: 3, interval: 1.0, type: 1)
            
            addsquare(xp: 15, yp: 5, xs: 5, ys: 1)
            addsquare(xp: 22, yp: 5, xs: 5, ys: 1)
            addsquare(xp: 29, yp: 5, xs: 5, ys: 1, type: 2, BlockNumber: 1)
            addmoveAction(xmove: 0, ymove: 7, time: 7.0, BlockNumber: 1)
            
            addsquare(xp: 37, yp: 5, xs: 4, ys: 1)
            addsquare(xp: 37, yp: 10, xs: 5, ys: 1)
            
            addsquare(xp: 43, yp: 8, xs: 6, ys: 1, angle: 30.0, type: 2)
            addsquare(xp: 41, yp: 2, xs: 6, ys: 1, angle: -30.0, type: 2)
            
            addredsquare(xp: 1, yp: 0, xs: 20, ys: 1, Damage: 50)
            addredsquare(xp: 21, yp: 0, xs: 20, ys: 1, Damage: 50)
            addredsquare(xp: 41, yp: 0, xs: 10, ys: 1, Damage: 50)
            addredsquare(xp: 34, yp: 1, xs: 3, ys: 10, Damage: 50)
            addredsquare(xp: 48, yp: 8, xs: 3, ys: 1, Damage: 50)
            
            addweight(xp: 4, yp: 6, type: 1)
            addweight(xp: 50, yp: 2, type: 2)
            
            addvector(xp: 6.5, yp: 9, sita: 180)
        }
        
        if stageNumber == 25{
            BackGroundImage(imageName: "bg10")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 7)
            addsquare(xp: 1, yp: 7, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 7, xs: 20, ys: 1)
            addsquare(xp: 41, yp: 7, xs: 4, ys: 1)
            
            addsquare(xp: 5, yp: 3, xs: 2, ys: 4)
            addredsquare(xp: 11, yp: 1, xs: 1, ys: 1, Damage: 10)
            addredsquare(xp: 15, yp: 1, xs: 1, ys: 1, Damage: 10)
            addredsquare(xp: 19, yp: 1, xs: 1, ys: 1, Damage: 10, BloclNumber: 1)
            addmoveAction(xmove: 8, ymove: 0, time: 5.0, BlockNumber: 1)
            
            addenemy(xp: 37, yp: 3, type: 21, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 50, yp: 3, type: 21, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 25, yp: 10, type: 21, HP: 40, Damage: 20, direction: true, maxn: 2, interval: 5.0)
            
            addweight(xp: 6, yp: 1, type: 1)
            addweight(xp: 40, yp: 1, type: 3)
            
            addredsquare(xp: 45, yp: 7, xs: 1, ys: 16, Damage: 10)
            addredsquare(xp: 46, yp: 9, xs: 2, ys: 1, Damage: 10)
            addredsquare(xp: 51, yp: 1, xs: 1, ys: 20, Damage: 10)
            addredsquare(xp: 51, yp: 21, xs: 1, ys: 7, Damage: 10)
            addredsquare(xp: 49, yp: 19, xs: 2, ys: 1, Damage: 10)
            addsquare(xp: 40, yp: 11, xs: 1, ys: 18)
            addsquare(xp: 41, yp: 28, xs: 11, ys: 1)
            
            addredsquare(xp: 33, yp: 8, xs: 1, ys: 15, Damage: 10)
            addredsquare(xp: 28, yp: 11, xs: 1, ys: 18, Damage: 10)
            addredsquare(xp: 39, yp: 11, xs: 1, ys: 18, Damage: 10)
            addredsquare(xp: 29, yp: 28, xs: 10, ys: 1, Damage: 10)
            
            addredsquare(xp: 22, yp: 8, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 22, yp: 28, xs: 1, ys: 8, Damage: 20)
            addsquare(xp: 23, yp: 35, xs: 20, ys: 1)
            addsquare(xp: 43, yp: 35, xs: 9, ys: 1)
            addsquare(xp: 51, yp: 30, xs: 1, ys: 5)
            addredsquare(xp: 28, yp: 29, xs: 24, ys: 1, Damage: 20)
            
            addgoal(xp: 49, yp: 30)
        }
        
        if stageNumber == 24{
            BackGroundImage(imageName: "bg10")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
                
            addplayer(px: 2, py: 37)
            addsquare(xp: 0, yp: 34, xs: 6, ys: 1)
            addsquare(xp: 0, yp: 35, xs: 1, ys: 5)
            addsquare(xp: 1, yp: 39, xs: 8, ys: 1)
            addsquare(xp: 8, yp: 37, xs: 1, ys: 2)
                
            addsquare(xp: 6, yp: 34, xs: 3, ys: 1, type: 2)
            addsquare(xp: 7, yp: 29, xs: 20, ys: 1, angle: -30.0, type: 2)
            addsquare(xp: 7, yp: 34, xs: 20, ys: 1, angle: -30.0, type: 2)
            addweight(xp: 8, yp: 35, type: 1)
                
            addsquare(xp: 27, yp: 24, xs: 20, ys: 1, angle: -30.0, type: 2)
            addsquare(xp: 27, yp: 19, xs: 20, ys: 1, angle: -30.0, type: 2)
                
            addsquare(xp: 14, yp: 36, xs: 3, ys: 1, type: 2)
                
            addsquare(xp: 45, yp: 14, xs: 7, ys: 1)
            addsquare(xp: 45, yp: 19, xs: 7, ys: 1)
            addsquare(xp: 51, yp: 15, xs: 1, ys: 10)
                
            adddoor(xp: 49, yp: 15, movepx: 15, movepy: 39)
            adddoor(xp: 49, yp: 23, movepx: 49, movepy: 3)
                
            addredsquare(xp: 25, yp: 24, xs: 4, ys: 1, Damage: 50)
            addredsquare(xp: 25, yp: 30, xs: 4, ys: 1, Damage: 50)
       
            addsquare(xp: 4, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 24, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 44, yp: 0, xs: 8, ys: 1)
            
            addredsquare(xp: 42, yp: 1, xs: 1, ys: 1, Damage: 20)
            addredsquare(xp: 34, yp: 1, xs: 1, ys: 1, Damage: 20)
            addredsquare(xp: 25, yp: 1, xs: 1, ys: 1, Damage: 20)
            
            addweight(xp: 11, yp: 1, type: 3)
            
            addredsquare(xp: 3, yp: 0, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 3, yp: 20, xs: 1, ys: 4, Damage: 20)
            addredsquare(xp: 8, yp: 6, xs: 1, ys: 23, Damage: 20)
            addredsquare(xp: 8, yp: 28, xs: 1, ys: 1, Damage: 20)
            addredsquare(xp: 9, yp: 6, xs: 20, ys: 1, Damage: 20)
            addredsquare(xp: 29, yp: 6, xs: 20, ys: 1, Damage: 20)
            addredsquare(xp: 49, yp: 6, xs: 2, ys: 1, Damage: 20)
            
            addsquare(xp: 51, yp: 1, xs: 1, ys: 5)
            addsquare(xp: 0, yp: 28, xs: 8, ys: 1)
            addsquare(xp: 0, yp: 24, xs: 1, ys: 4)
            
            addgoal(xp: 1, yp: 24)
        }
        
        if stageNumber == 23{
            BackGroundImage(imageName: "bg11")
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            addplayer(px: 2, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 4, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 18)
            addsquare(xp: 23, yp: 1, xs: 1, ys: 18)
            addsquare(xp: 0, yp: 19, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 19, xs: 4, ys: 1)
            
            addsquare(xp: 8, yp: 4, xs: 8, ys: 1)
            addsquare(xp: 1, yp: 8, xs: 7, ys: 1)
            addsquare(xp: 16, yp: 8, xs: 7, ys: 1)
            addsquare(xp: 4, yp: 12, xs: 6, ys: 1)
            addsquare(xp: 14, yp: 12, xs: 6, ys: 1)
            
            addenemy(xp: 9, yp: 1, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 14, yp: 1, type: 21, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 9, yp: 6, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 14, yp: 6, type: 21, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 2, yp: 10, type: 21, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            addenemy(xp: 21, yp: 10, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 8, yp: 15, type: 21, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 15, yp: 15, type: 21, HP: 40, Damage: 10, direction: true, maxn: 1, interval: 1.0)
        }
        
        if stageNumber == 1{
            BackGroundImage(imageName: "bg0")
            viewnode.discriptionChangeN(disN: 1)
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 2, py: 3)
            addsquare(xp: 0, yp: 0, xs: 25, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 11)
            addsquare(xp: 1, yp: 11, xs: 25, ys: 1)
            addsquare(xp: 25, yp: 0, xs: 1, ys: 12)
            
            addgoal(xp: 23, yp: 1)
        }
        if stageNumber == 2{
            BackGroundImage(imageName: "bg0")
            viewnode.discriptionChangeN(disN: 2)
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 12, yp: 0, xs: 6, ys: 5)
            addsquare(xp: 18, yp: 0, xs: 6, ys: 9)
            addsquare(xp: 24, yp: 0, xs: 7, ys: 13)
            
            addscroll(xp: 8, yp: 1, Number: 3)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 20)
            addsquare(xp: 0, yp: 21, xs: 1, ys: 3)
            addsquare(xp: 1, yp: 23, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 23, xs: 10, ys: 1)
            addsquare(xp: 30, yp: 13, xs: 1, ys: 10)
            
            addgoal(xp: 28, yp: 13)
        }
        if stageNumber == 3{
            BackGroundImage(imageName: "bg0")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 17, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 17)
            addsquare(xp: 1, yp: 17, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 17, xs: 16, ys: 1)
            addsquare(xp: 36, yp: 1, xs: 1, ys: 16)
            
            addredsquare(xp: 9, yp: 1, xs: 3, ys: 2, Damage: 30)
            addredsquare(xp: 18, yp: 1, xs: 3, ys: 3, Damage: 30)
            addredsquare(xp: 27, yp: 1, xs: 3, ys: 4, Damage: 20)
            
            addscroll(xp: 6, yp: 1, Number: 13)
            
            addgoal(xp: 34, yp: 1)
            
        }
        if stageNumber == 4{
            BackGroundImage(imageName: "bg0")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 8, ys: 1)
            
            addsquare(xp: 0, yp: 17, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 17, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 17, xs: 8, ys: 1)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 16)
            addsquare(xp: 47, yp: 1, xs: 1, ys: 16)
            
            addredsquare(xp: 11, yp: 1, xs: 20, ys: 2, Damage: 50, playerContact: false)
            addgoal(xp: 45, yp: 1)
            
            addscroll(xp: 7, yp: 1, Number: 12)
        }
        
        if stageNumber == 5{
            BackGroundImage(imageName: "bg0")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 9, ys: 1)
            
            addsquare(xp: 16, yp: 1, xs: 1, ys: 13)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 6)
            addsquare(xp: 1, yp: 6, xs: 11, ys: 1)
            addsquare(xp: 11, yp: 7, xs: 1, ys: 12)
            addsquare(xp: 12, yp: 18, xs: 20, ys: 1)
            addsquare(xp: 32, yp: 18, xs: 3, ys: 1)
            
            addsquare(xp: 23, yp: 6, xs: 1, ys: 12)
            
            addsquare(xp: 28, yp: 1, xs: 1, ys: 13)
            addsquare(xp: 29, yp: 13, xs: 6, ys: 1)
            
            
            addsquare(xp: 34, yp: 14, xs: 1, ys: 4)
            addgoal(xp: 32, yp: 14)
            
            addscroll(xp: 13, yp: 1, Number: 7)
        }
        
        if stageNumber == 6{
            BackGroundImage(imageName: "bg0")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 3, ys: 1)
            addsquare(xp: 0, yp: 11, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 11, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 11, xs: 4, ys: 1)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 10)
            addsquare(xp: 43, yp: 0, xs: 1, ys: 11)
            
            addredsquare(xp: 13, yp: 1, xs: 1, ys: 10, Damage: 50, playerContact: false)
            addredsquare(xp: 21, yp: 1, xs: 1, ys: 10, Damage: 50, playerContact: false)
            addredsquare(xp: 29, yp: 1, xs: 1.5, ys: 10, Damage: 50, playerContact: false)
            
            addgoal(xp: 41, yp: 1)
            addscroll(xp: 10, yp: 1, Number: 6)
        }
        
        if stageNumber == 7{
            BackGroundImage(imageName: "bg6")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 4, ys: 1)
            addsquare(xp: 43, yp: 1, xs: 1, ys: 20)
            addsquare(xp: 43, yp: 21, xs: 1, ys: 1)
            
            addsquare(xp: 9, yp: 22, xs: 20, ys: 1)
            addsquare(xp: 29, yp: 22, xs: 15, ys: 1)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 11)
            addsquare(xp: 1, yp: 11, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 11, xs: 18, ys: 1)
            addsquare(xp: 38, yp: 3, xs: 1, ys: 8)
            
            addsquare(xp: 9, yp: 12, xs: 1, ys: 10)
            
            addredsquare(xp: 9, yp: 1, xs: 1, ys: 10, Damage: 20, playerContact: false, BloclNumber: 1)
            addredsquare(xp: 25, yp: 1, xs: 1, ys: 10, Damage: 20, playerContact: false, BloclNumber: 2)
            addredsquare(xp: 35, yp: 12, xs: 1, ys: 10, Damage: 20, playerContact: false, BloclNumber: 3)
            
            addmoveAction(xmove: 11, ymove: 0, time: 5.0, BlockNumber: 1, interval: 2.0)
            addmoveAction(xmove: 11, ymove: 0, time: 5.0, BlockNumber: 2, interval: 2.0)
            addmoveAction(xmove: -23, ymove: 0, time: 2.0, BlockNumber: 3)
            
            addgoal(xp: 10, yp: 17)
        }
        
        if stageNumber == 8{
            BackGroundImage(imageName: "bg0")
            viewnode.discriptionChangeN(disN: 8)
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 6, ys: 1)
            addsquare(xp: 0, yp: 11, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 11, xs: 6, ys: 1)
            
            addsquare(xp: 0, yp: 1, xs: 1, ys: 10)
            addsquare(xp: 25, yp: 1, xs: 1, ys: 10)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 21, yp: 3, type: 1, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            }
        }
        if stageNumber == 9{
            BackGroundImage(imageName: "bg0")
            viewnode.discriptionChangeN(disN: 9)
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            enemymax = 2
            
            addplayer(px: 9, py: 3)
            addsquare(xp: 0, yp: 0, xs: 19, ys: 1)
            addsquare(xp: 0, yp: 11, xs: 19, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 10)
            addsquare(xp: 18, yp: 1, xs: 1, ys: 10)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 4, yp: 3, type: 1, HP: 50, Damage: 10, direction: true, maxn: 3, interval: 2.0)
                self.addenemy(xp: 14, yp: 3, type: 1, HP: 50, Damage: 10, direction: false, maxn: 3, interval: 2.0)
            }
        }
        if stageNumber == 10{
            BackGroundImage(imageName: "bg0")
            viewnode.discriptionChangeN(disN: 10)
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅
            ClearP(How: HowToClear)
            
            addplayer(px: 9, py: 3)
            addsquare(xp: 0, yp: 0, xs: 19, ys: 1)
            addsquare(xp: 0, yp: 11, xs: 19, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 10)
            addsquare(xp: 18, yp: 1, xs: 1, ys: 10)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 9, yp: 7, type: 41, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 2.0)
            }
        }
        if stageNumber == 11{
            BackGroundImage(imageName: "bg0")
            viewnode.discriptionChangeN(disN: 11)
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            enemymax = 2
            
            addplayer(px: 9, py: 3)
            addsquare(xp: 0, yp: 0, xs: 19, ys: 1)
            addsquare(xp: 0, yp: 11, xs: 19, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 10)
            addsquare(xp: 18, yp: 1, xs: 1, ys: 10)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 6, yp: 6, type: 41, HP: 50, Damage: 10, direction: true, maxn: 2, interval: 2.0)
                self.addenemy(xp: 12, yp: 6, type: 41, HP: 50, Damage: 10, direction: true, maxn: 2, interval: 2.0)
            }
        }
        if stageNumber == 12{
            BackGroundImage(imageName: "bg0")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 10)
            
            addsquare(xp: 0, yp: 11, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 11, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 11, xs: 12, ys: 1)
            
            addsquare(xp: 51, yp: 1, xs: 1, ys: 10)
            
            addsquare(xp: 13, yp: 4, xs: 1, ys: 7)
            
            addredsquare(xp: 18, yp: 1, xs: 1, ys: 5, Damage: 10)
            addredsquare(xp: 41, yp: 1, xs: 1, ys: 5, Damage: 10)
            addredsquare(xp: 18, yp: 6, xs: 1, ys: 5, Damage: 50 ,playerContact: false)
            addredsquare(xp: 41, yp: 6, xs: 1, ys: 5, Damage: 50 ,playerContact: false)
            
            addscroll(xp: 15, yp: 1, Number: 14)
            addscroll(xp: 38, yp: 1, Number: 14)
            
            addgoal(xp: 49, yp: 1)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 37, yp: 8, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
            }
        }
        if stageNumber == 13{
            BackGroundImage(imageName: "bg6")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 4)
            
            addsquare(xp: 0, yp: 1, xs: 15, ys: 1)
            addsquare(xp: 21, yp: 1, xs: 13, ys: 1)
            addsquare(xp: 40, yp: 1, xs: 12, ys: 1)
            addredsquare(xp: 14, yp: 0, xs: 8, ys: 1, Damage: 100)
            addredsquare(xp: 33, yp: 0, xs: 8, ys: 1, Damage: 100)
            
            addsquare(xp: 0, yp: 2, xs: 1, ys: 10)
            addsquare(xp: 51, yp: 2, xs: 1, ys: 10)
            
            addsquare(xp: 0, yp: 12, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 12, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 12, xs: 12, ys: 1)
            addgoal(xp: 49, yp: 2)
            
            addsquare(xp: 15, yp: 5, xs: 6, ys: 1)
            addsquare(xp: 34, yp: 5, xs: 6, ys: 1, BlockNumber: 1)
            addrotateAction(dsita: 180, time: 5.0, BlockNumber: 1, type: 1, interval: 3.0, firstinterval: 0.0)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 12, yp: 4, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 25, yp: 4, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 30, yp: 4, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 48, yp: 4, type: 2, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
            }
        }
        if stageNumber == 14{
            BackGroundImage(imageName: "bg7")
            HowToClear = 3 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 30)
            
            addsquare(xp: 0, yp: 16, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 16, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 16, xs: 12, ys: 1)
            
            addsquare(xp: 0, yp: 38, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 38, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 38, xs: 12, ys: 1)
            
            addsquare(xp: 0, yp: 17, xs: 1, ys: 10)
            addsquare(xp: 0, yp: 28, xs: 1, ys: 10)
            addsquare(xp: 51, yp: 17, xs: 1, ys: 21)
            
            addsquare(xp: 0, yp: 27, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 27, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 27, xs: 4, ys: 1)
            addsquare(xp: 41, yp: 28, xs: 1, ys: 1)
            
            addsquare(xp: 19, yp: 17, xs: 3, ys: 5)
            addredsquare(xp: 19, yp: 25, xs: 3, ys: 2, Damage: 10)
            
            addredsquare(xp: 10, yp: 28, xs: 2, ys: 2, Damage: 10, BloclNumber: 2)
            addredsquare(xp: 24, yp: 28, xs: 2, ys: 2, Damage: 10, BloclNumber: 3)
            addredsquare(xp: 31, yp: 36, xs: 2, ys: 2, Damage: 10, BloclNumber: 4)
            addmoveAction(xmove: 7, ymove: 0, time: 4.0, BlockNumber: 2)
            addmoveAction(xmove: 0, ymove: 8, time: 4.0, BlockNumber: 3)
            addmoveAction(xmove: 0, ymove: -8, time: 4.0, BlockNumber: 4)
            
            addredsquare(xp: 38, yp: 17, xs: 1, ys: 9, Damage: 10, playerContact: false, BloclNumber: 5)
            addredsquare(xp: 28, yp: 17, xs: 1, ys: 9, Damage: 10, playerContact: false, BloclNumber: 6)
            addrotateAction(dsita: -90, time: 4.0, BlockNumber: 5, type: 1, interval: 0.0, firstinterval: 0.0)
            addrotateAction(dsita: 90, time: 4.0, BlockNumber: 6, type: 1, interval: 0.0, firstinterval: 0.0)
            
            addsquare(xp: 44, yp: 27, xs: 7, ys: 1, type: 1, BlockNumber: 1)
            addinoutAction(outinterval: 0.0, ininterval: 0.0, firstinterval: 0.0, BlockNumber: 1, type: 4, outtime: 2.0, intime: 0.0, SwitchNumbet: 1)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 8, yp: 30, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 21, yp: 30, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 28, yp: 30, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 35, yp: 30, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                self.addenemy(xp: 31, yp: 19, type: 1, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                self.addenemy(xp: 43, yp: 19, type: 1, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                
                self.addenemy(xp: 49, yp: 30, type: 3, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                self.addenemy(xp: 3, yp: 19, type: 5, HP: 80, Damage: 10, direction: true, maxn: 1, interval: 1.0, CFenemy: true)
            }
        }
        if stageNumber == 15{
            BackGroundImage(imageName: "bg0")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 0, xs: 12, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 19)
            
            addsquare(xp: 0, yp: 20, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 20, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 20, xs: 12, ys: 1)
            
            addsquare(xp: 51, yp: 1, xs: 1, ys: 19)
            
            addredsquare(xp: 18, yp: 1, xs: 1, ys: 14, Damage: 10)
            addredsquare(xp: 41, yp: 1, xs: 1, ys: 14, Damage: 10)
            addredsquare(xp: 18, yp: 15, xs: 1, ys: 5, Damage: 50 ,playerContact: false)
            addredsquare(xp: 41, yp: 15, xs: 1, ys: 5, Damage: 50 ,playerContact: false)
            
            addscroll(xp: 15, yp: 1, Number: 15)
            addgoal(xp: 49, yp: 1)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 14, yp: 6, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 14, yp: 11, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 14, yp: 16, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 32, yp: 6, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 32, yp: 11, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 32, yp: 16, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 37, yp: 16, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 18, yp: 16, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
                self.addenemy(xp: 41, yp: 16, type: 42, HP: 1000, Damage: 10, direction: false, maxn: 1, interval: 2.0)
            }
        }
        if stageNumber == 16{
            BackGroundImage(imageName: "bg6")
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 5)
            
            addsquare(xp: 0, yp: 0, xs: 6, ys: 3)
            addsquare(xp: 6, yp: 0, xs: 5, ys: 2)
            addsquare(xp: 11, yp: 0, xs: 8, ys: 1)
            addsquare(xp: 19, yp: 0, xs: 5, ys: 2)
            addsquare(xp: 24, yp: 0, xs: 6, ys: 3)
            
            addsquare(xp: 0, yp: 3, xs: 1, ys: 10)
            addsquare(xp: 29, yp: 3, xs: 1, ys: 10)
            
            addsquare(xp: 0, yp: 13, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 13, xs: 10, ys: 1)
            
            addenemyAction(xp: 8, yp: 4, type: 12, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 1)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 21, yp: 4, type: 11, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
            }
        }
        if stageNumber == 17{
            BackGroundImage(imageName: "bg6")
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 14, py: 3)
            
            addsquare(xp: 5, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 5, yp: 1, xs: 6, ys: 1)
            addsquare(xp: 19, yp: 1, xs: 6, ys: 1)
            addsquare(xp: 5, yp: 2, xs: 1, ys: 11)
            addsquare(xp: 24, yp: 2, xs: 1, ys: 11)
            addsquare(xp: 5, yp: 13, xs: 12, ys: 1)
            
            addenemyAction(xp: 21, yp: 4, type: 12, HP: 50, Damage: 10, direction: false, maxn: 2, interval: 5.0, StartSwitchNumber: 2)
            addenemyAction(xp: 8, yp: 4, type: 11, HP: 50, Damage: 10, direction: true, maxn: 2, interval: 5.0, StartSwitchNumber: 1)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 21, yp: 4, type: 11, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                self.addenemy(xp: 8, yp: 4, type: 12, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 2)
            }
        }
        if stageNumber == 18{
            BackGroundImage(imageName: "bg6")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 3)
            addsquare(xp: 0, yp: 0, xs: 13, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 21)
            addsquare(xp: 1, yp: 21, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 21, xs: 13, ys: 1)
            addsquare(xp: 29, yp: 16, xs: 5, ys: 1)
            
            addgoal(xp: 31, yp: 17)
            
            addsquare(xp: 13, yp: 0, xs: 17, ys: 1, type: 2)
            addsquare(xp: 29, yp: 1, xs: 1, ys: 15, type: 2)
            
            addsquare(xp: 33, yp: 17, xs: 1, ys: 4)
            
            addcircle(xp: 3, yp: 8, xs: 4, ys: 4, type: 2)
            addcircle(xp: 8, yp: 14, xs: 4, ys: 4, type: 2)
            addcircle(xp: 9, yp: 4, xs: 4, ys: 4, type: 2)
            addcircle(xp: 14, yp: 10, xs: 4, ys: 4, type: 2)
            addcircle(xp: 20, yp: 4, xs: 4, ys: 4, type: 2)
            addcircle(xp: 21, yp: 14, xs: 4, ys: 4, type: 2)
            
            addredcircle(xp: 4, yp: 14, xs: 2, ys: 2)
            addredcircle(xp: 15, yp: 19, xs: 2, ys: 2)
            addredcircle(xp: 25, yp: 9, xs: 2, ys: 2)
            
            addscroll(xp: 6, yp: 1, Number: 16)
        }
        if stageNumber == 19{
            BackGroundImage(imageName: "bg7")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 23)
            
            addsquare(xp: 0, yp: 20, xs: 7, ys: 1)
            addsquare(xp: 0, yp: 21, xs: 1, ys: 8)
            
            addsquare(xp: 51, yp: 0, xs: 1, ys: 20)
            addsquare(xp: 51, yp: 20, xs: 1, ys: 19)
            
            addredsquare(xp: 0, yp: 29, xs: 1, ys: 9, Damage: 100)
            addredsquare(xp: 0, yp: 38, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 20, yp: 38, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 40, yp: 38, xs: 11, ys: 1, Damage: 100)
            
            addredsquare(xp: 7, yp: 20, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 27, yp: 20, xs: 19, ys: 1, Damage: 100)
            
            addredsquare(xp: 0, yp: 0, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 20, yp: 0, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 40, yp: 0, xs: 11, ys: 1, Damage: 100)
            
            addredsquare(xp: 0, yp: 1, xs: 1, ys: 19, Damage: 100)
            
            addsquare(xp: 7, yp: 24, xs: 10, ys: 1, type: 2, BlockNumber: 1)
            addsquare(xp: 7, yp: 25, xs: 1, ys: 4, type: 2, BlockNumber: 2)
            addsquare(xp: 16, yp: 25, xs: 1, ys: 4, type: 2, BlockNumber: 3)
            
            addmoveAction(xmove: 34, ymove: 0, time: 30.0, BlockNumber: 1, interval: 1.0, firstinterval: 0, type: 3, SwitchNumber: 1)
            addmoveAction(xmove: 34, ymove: 0, time: 30.0, BlockNumber: 2, interval: 1.0, firstinterval: 0, type: 3, SwitchNumber: 2)
            addmoveAction(xmove: 34, ymove: 0, time: 30.0, BlockNumber: 3, interval: 1.0, firstinterval: 0, type: 3, SwitchNumber: 3)
            
            addsquare(xp: 41, yp: 4, xs: 10, ys: 1, type: 2, BlockNumber: 4)
            addsquare(xp: 41, yp: 5, xs: 1, ys: 4, type: 2, BlockNumber: 5)
            addsquare(xp: 50, yp: 5, xs: 1, ys: 4, type: 2, BlockNumber: 6)
            addmoveAction(xmove: -38, ymove: 0, time: 30.0, BlockNumber: 4, interval: 1.0, firstinterval: 0, type: 3, SwitchNumber: 4)
            addmoveAction(xmove: -38, ymove: 0, time: 30.0, BlockNumber: 5, interval: 1.0, firstinterval: 0, type: 3, SwitchNumber: 5)
            addmoveAction(xmove: -38, ymove: 0, time: 30.0, BlockNumber: 6, interval: 1.0, firstinterval: 0, type: 3, SwitchNumber: 6)
            
            addredsquare(xp: 21, yp: 25, xs: 3, ys: 4, Damage: 20)
            addredsquare(xp: 35, yp: 25, xs: 2, ys: 2, Damage: 20, BloclNumber: 7)
            addredsquare(xp: 38, yp: 34, xs: 2, ys: 2, Damage: 20, BloclNumber: 8)
            addmoveAction(xmove: -7, ymove: 0, time: 5.0, BlockNumber: 7,interval: 0.0)
            addmoveAction(xmove: 0, ymove: -9, time: 5.0, BlockNumber: 8,interval: 0.0)
            
            addredsquare(xp: 43, yp: 27, xs: 2, ys: 11, Damage: 20)
            
            addredsquare(xp: 23, yp: 11, xs: 3, ys: 9, Damage: 20)
            addredsquare(xp: 11, yp: 1, xs: 2, ys: 7, Damage: 20)
            
            addgoal(xp: 4, yp: 1)
            
            self.run(SKAction.wait(forDuration: 2.0)){
                self.addenemy(xp: 14, yp: 26, type: 42, HP: 10, Damage: 1, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2,3])
                self.addenemy(xp: 43, yp: 6, type: 42, HP: 10, Damage: 1, direction: true, maxn: 1, interval: 1.0, SwitchNumber: [4,5,6])
                
                self.addenemy(xp: 34, yp: 8, type: 41, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                self.addenemy(xp: 29, yp: 12, type: 41, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                self.addenemy(xp: 24, yp: 5, type: 41, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                self.addenemy(xp: 19, yp: 12, type: 41, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                self.addenemy(xp: 15, yp: 8, type: 41, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
            }
        }
        if stageNumber == 20{
            BackGroundImage(imageName: "bg7")
            HowToClear = 1 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px:3,py:3)
            
            addsquare(xp: 0, yp: 0, xs: 15, ys: 1)
            addsquare(xp: 0, yp: 1, xs: 1, ys: 4)
            
            addredsquare(xp: 0, yp: 5, xs: 1, ys: 20, Damage: 20)
            addredsquare(xp: 0, yp: 25, xs: 1, ys: 15, Damage: 20)
            addredsquare(xp: 1, yp: 39, xs: 16, ys: 1, Damage: 20)
            addredsquare(xp: 16, yp: 23, xs: 1, ys: 16, Damage: 20)
            addredsquare(xp: 17, yp: 23, xs: 12, ys: 1, Damage: 20)
            addredsquare(xp: 28, yp: 9, xs: 1, ys: 14, Damage: 20)
            
            addredsquare(xp: 15, yp: 0, xs: 1, ys: 17, Damage: 20)
            addredsquare(xp: 16, yp: 3, xs: 12, ys: 1, Damage: 20)
            
            addredsquare(xp: 1, yp: 23, xs: 16, ys: 1, Damage: 20, playerContact: false)
            
            addsquare(xp: 28, yp: 0, xs: 1, ys: 4)
            addsquare(xp: 29, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 49, yp: 0, xs: 3, ys: 1)
            
            addsquare(xp: 5, yp: 1, xs: 10, ys: 1, type: 2, BlockNumber: 1)
            addsquare(xp: 5, yp: 2, xs: 1, ys: 1, type: 2, BlockNumber: 2)
            addsquare(xp: 14, yp: 2, xs: 1, ys: 1, type: 2, BlockNumber: 3)
            addmoveAction(xmove: 0, ymove: 23, time: 30.0, BlockNumber: 1, interval: 2.0, firstinterval: 5.0)
            addmoveAction(xmove: 0, ymove: 23, time: 30.0, BlockNumber: 2, interval: 2.0, firstinterval: 5.0)
            addmoveAction(xmove: 0, ymove: 23, time: 30.0, BlockNumber: 3, interval: 2.0, firstinterval: 5.0)
            
            addsquare(xp: 16, yp: 1, xs: 12, ys: 1, type: 2, BlockNumber: 4)
            addsquare(xp: 16, yp: 2, xs: 1, ys: 1, type: 2, BlockNumber: 5)
            addsquare(xp: 27, yp: 2, xs: 1, ys: 1, type: 2, BlockNumber: 6)
            addmoveAction(xmove: 0, ymove: 15, time: 30.0, BlockNumber: 4, interval: 2.0, firstinterval: 5.0)
            addmoveAction(xmove: 0, ymove: 15, time: 30.0, BlockNumber: 5, interval: 2.0, firstinterval: 5.0)
            addmoveAction(xmove: 0, ymove: 15, time: 30.0, BlockNumber: 6, interval: 2.0, firstinterval: 5.0)
            
            addredsquare(xp: 9, yp: 7, xs: 6, ys: 2, Damage: 20, playerContact: false)
            addredsquare(xp: 5, yp: 13, xs: 6, ys: 2, Damage: 20, playerContact: false)
            
            addredsquare(xp: 16, yp: 13, xs: 2, ys: 2, Damage: 20, playerContact: false, BloclNumber: 7)
            addredsquare(xp: 26, yp: 9, xs: 2, ys: 2, Damage: 20, playerContact: false, BloclNumber: 8)
            
            addmoveAction(xmove: 10, ymove: 0, time: 5.0, BlockNumber: 7)
            addmoveAction(xmove: -10, ymove: 0, time: 5.0, BlockNumber: 8)
            
            addenemy(xp: 36, yp: 4, type: 11, HP: 20, Damage: 20, direction: false, maxn: 3, interval: 2.0)
            addenemy(xp: 41, yp: 4, type: 11, HP: 20, Damage: 20, direction: false, maxn: 3, interval: 2.0)
            addenemy(xp: 46, yp: 4, type: 11, HP: 20, Damage: 20, direction: false, maxn: 3, interval: 2.0)
            
            addsquare(xp: 29, yp: 14, xs: 22, ys: 1)
            addsquare(xp: 51, yp: 1, xs: 1, ys: 13)
            
            addgoal(xp: 49, yp: 1)
        }
        if stageNumber == 21{
            BackGroundImage(imageName: "bg7")
            HowToClear = 3 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px:4,py:32)
            addsquare(xp: 2, yp: 30, xs: 6, ys: 1)
            addsquare(xp: 2, yp: 31, xs: 1, ys: 4)
            
            addsquare(xp: 0, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 20, yp: 39, xs: 20, ys: 1)
            addsquare(xp: 40, yp: 39, xs: 12, ys: 1)
            addsquare(xp: 51, yp: 16, xs: 1, ys: 20)
            addsquare(xp: 51, yp: 36, xs: 1, ys: 4)
            addsquare(xp: 46, yp: 16, xs: 5, ys: 1)
            
            addsquare(xp: 44, yp: 28, xs: 1, ys: 1)
            addsquare(xp: 0, yp: 26, xs: 20, ys: 2)
            addsquare(xp: 20, yp: 26, xs: 20, ys: 2)
            addsquare(xp: 40, yp: 26, xs: 5, ys: 2)
            
            addsquare(xp: 0, yp: 0, xs: 1, ys: 20)
            addsquare(xp: 0, yp: 20, xs: 1, ys: 6)
            addsquare(xp: 1, yp: 0, xs: 20, ys: 1)
            addsquare(xp: 21, yp: 0, xs: 5, ys: 1)
            addsquare(xp: 25, yp: 1, xs: 1, ys: 12)
            
            addsquare(xp: 6, yp: 15, xs: 1, ys: 1)
            addsquare(xp: 6, yp: 13, xs: 20, ys: 2)
            addsquare(xp: 26, yp: 13, xs: 20, ys: 2)
            addsquare(xp: 46, yp: 13, xs: 6, ys: 2)
            
            addredsquare(xp: 0, yp: 28, xs: 1, ys: 11, Damage: 100)
            addredsquare(xp: 1, yp: 28, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 21, yp: 28, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 41, yp: 28, xs: 3, ys: 1, Damage: 100)
            
            addredsquare(xp: 7, yp: 15, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 27, yp: 15, xs: 20, ys: 1, Damage: 100)
            addredsquare(xp: 47, yp: 15, xs: 5, ys: 1, Damage: 100)
            
            addsquare(xp: 10, yp: 32, xs: 5, ys: 1)
            addsquare(xp: 18, yp: 30, xs: 5, ys: 1)
            addsquare(xp: 24, yp: 33, xs: 5, ys: 1)
            addsquare(xp: 32, yp: 30, xs: 9, ys: 1)
            
            addsquare(xp: 38, yp: 18, xs: 5, ys: 1, type: 2)
            addsquare(xp: 16, yp: 17, xs: 13, ys: 1, type: 2)
            addsquare(xp: 31, yp: 20, xs: 5, ys: 1)
            addsquare(xp: 7, yp: 19, xs: 6, ys: 1)
            
            addenemy(xp: 40, yp: 32, type: 12, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 16, yp: 20, type: 11, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
            
            addenemy(xp: 9, yp: 4, type: 11, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 12, yp: 4, type: 12, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            addenemy(xp: 15, yp: 4, type: 11, HP: 40, Damage: 10, direction: false, maxn: 1, interval: 1.0)
            
            addenemy(xp: 22, yp: 4, type: 13, HP: 100, Damage: 20, direction: false, maxn: 1, interval: 1.0, CFenemy: true)
        }
        if stageNumber == 22{
            BackGroundImage(imageName: "bg11")
            HowToClear = 2 //1:特定エリアに到達 2:敵の全滅 3:特定の敵を撃破
            ClearP(How: HowToClear)
            
            addplayer(px: 3, py: 4)
            
            addsquare(xp: 0, yp: 0, xs: 7, ys: 3)
            addsquare(xp: 7, yp: 0, xs: 9, ys: 1)
            addsquare(xp: 16, yp: 0, xs: 7, ys: 3)
            addsquare(xp: 0, yp: 3, xs: 1, ys: 9)
            addsquare(xp: 22, yp: 3, xs: 1, ys: 9)
            addsquare(xp: 1, yp: 11, xs: 21, ys: 1)
            
            addenemy(xp: 20, yp: 3, type: 21, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: [1,2])
            addenemyAction(xp: 11, yp: 1, type: 21, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 1)
            addenemyAction(xp: 2, yp: 3, type: 21, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 2)
        }
        //カメラ作成
        cameraNode.position = body.position
        if cameraNode.position.x <= w / 2{ cameraNode.position.x = w / 2}
        if cameraNode.position.x >= w * 7 / 2 { cameraNode.position.x = w * 7 / 2  }
        if cameraNode.position.y <= h / 2{ cameraNode.position.y = h / 2}
        if cameraNode.position.y >= h * 7 / 2 { cameraNode.position.y = h * 7 / 2 }
        cameraNode.xScale = 1.0
        cameraNode.yScale = 1.0 / SceneR
        addChild(cameraNode)
        camera = cameraNode
    }
    
    func BackGroundImage(imageName: String){
        let backgroundimage = SKSpriteNode(imageNamed: imageName)
        backgroundimage.position = CGPoint(x: w * 2, y: h * 2)
        backgroundimage.size = CGSize(width: w * 4, height: h * 4)
        addChild(backgroundimage)
    }
    
}





