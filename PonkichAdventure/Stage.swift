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
        let stageNumber = viewnode.getStageN()       //ステージナンバーを取得
        let sceneNumber = viewnode.getStageSceneN()  //シーンナンバーを取得
        let difficulty = viewnode.getDifficulty()    //ゲーム難易度取得
        
        if 70 <= stageNumber && stageNumber <= 99{
            PracticeFlag = true
        }
        SetUpStage()
        
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -gra * Double(impulseR) )
        
        //6¥第１エリア（草原）
        if stageNumber == 1{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [68,20]
                BackGroundImage(imageName: "bg1_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 4)
                
                if skillGet[1] == false{
                    additem(xp: 5, yp: 3, type: 1, number: 1)
                }
                addgoal(xp: 66, yp: 11)
                
                addBlock(xp: -1, yp: 0, xs: 1, ys: 20, type: 3)
                addBlock(xp: 69, yp: 0, xs: 1, ys: 20, type: 3)
                
                addBlock(xp: 0, yp: 0, xs: 42, ys: 3, type: 3)
                addBlock(xp: 13, yp: 3, xs: 4, ys: 1, type: 3)
                
                addBlock(xp: 47, yp: 0, xs: 21, ys: 4, type: 3)
                addBlock(xp: 52, yp: 4, xs: 16, ys: 1, type: 3)
                addBlock(xp: 54, yp: 5, xs: 14, ys: 1, type: 3)
                addBlock(xp: 56, yp: 6, xs: 12, ys: 1, type: 3)
                addBlock(xp: 58, yp: 7, xs: 10, ys: 1, type: 3)
                addBlock(xp: 60, yp: 8, xs: 8, ys: 1, type: 3)
                addBlock(xp: 62, yp: 9, xs: 6, ys: 1, type: 3)
                
                addBlock(xp: 21, yp: 5, xs: 15, ys: 1, type: 1)
                addBlock(xp: 26, yp: 8, xs: 5, ys: 1, type: 1)
                
                addenemy(xp: 15, yp: 5, type: 1, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                
                if difficulty == 0{
                    addBlock(xp: 40, yp: 3, xs: 4, ys: 1, type: 3)
                    addenemy(xp: 28, yp: 3, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 7, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 7, type: 1, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 10, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 56, yp: 8, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 63, yp: 11, type: 1, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addBlock(xp: 28, yp: 3, xs: 1, ys: 5, type: 1)
                    addenemy(xp: 25, yp: 3, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 31, yp: 3, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 7, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 7, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 10, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 56, yp: 8, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 63, yp: 11, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                }
            }
        }
        
        if stageNumber == 2{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [84,41]
                BackGroundImage(imageName: "bg1_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)

                if sceneNumber == 1 || sceneNumber == 11 {
                    addplayer(px: 63, py: 28)
                }else{
                    addplayer(px: 2, py: 4)
                    if difficulty == 0{ additem(xp: 63, yp: 28, type: 3, number: 1) }
                    if difficulty == 1{ additem(xp: 63, yp: 28, type: 3, number: 11) }
                }
                
                addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 3)
                addBlock(xp: 24, yp: 0, xs: 13, ys: 14, type: 3)
                
                addBlock(xp: 61, yp: 0, xs: 7, ys: 20, type: 3)
                addBlock(xp: 61, yp: 20, xs: 7, ys: 6, type: 3)
                
                addBlock(xp: 71, yp: 23, xs: 6, ys: 1, type: 1)
                addBlock(xp: 71, yp: 24, xs: 2, ys: 1, type: 1)
                addBlock(xp: 80, yp: 21, xs: 4, ys: 1, type: 1)
                addBlock(xp: 74, yp: 19, xs: 4, ys: 1, type: 1)
                addBlock(xp: 68, yp: 17, xs: 4, ys: 1, type: 1)
                addBlock(xp: 74, yp: 15, xs: 4, ys: 1, type: 1)
                addBlock(xp: 80, yp: 13, xs: 4, ys: 1, type: 1)
                addBlock(xp: 74, yp: 11, xs: 4, ys: 1, type: 1)
                addBlock(xp: 68, yp: 9, xs: 4, ys: 1, type: 1)
                
                addBlock(xp: 84, yp: 0, xs: 1, ys: 20, type: 3)
                addBlock(xp: 84, yp: 20, xs: 1, ys: 20, type: 3)
                addBlock(xp: 84, yp: 40, xs: 1, ys: 20, type: 3)
                addBlock(xp: 84, yp: 60, xs: 1, ys: 20, type: 3)
                
                addgoal(xp: 69, yp: 11)
                
                if difficulty == 0{
                    addBlock(xp: 15, yp: 4, xs: 5, ys: 1, type: 4, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 9, time: 5.0, BlockNumber: 1,interval: 3.0)
                    
                    addenemy(xp: 13, yp: 4, type: 1, HP: 10, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 16, type: 1, HP: 10, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addBlock(xp: 49, yp: 12, xs: 6, ys: 2, type: 4, BlockNumber: 2, Pattern: 2)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 2,interval: 3.0)
                    addBlock(xp: 55, yp: 12, xs: 6, ys: 2, type: 4, BlockNumber: 3, Pattern: 2)
                    addmoveAction(xmove: 0, ymove: 12, time: 6.0, BlockNumber: 3,interval: 3.0)
                    
                    addDamageO(xp: 70.5, yp: 22, Size: 10, type: 5, damage: 20, Angle: 90)
                    addDamageO(xp: 80.5, yp: 18, Size: 10, type: 5, damage: 20, Angle: 90)
                    addDamageO(xp: 70.5, yp: 14, Size: 10, type: 5, damage: 20, Angle: 90)
                }
                
                if difficulty == 1{
                    addBlock(xp: 17, yp: 4, xs: 2, ys: 1, type: 4, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 9, time: 5.0, BlockNumber: 1 ,interval: 2.0)
                    addenemy(xp: 13, yp: 4, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 36, yp: 15, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 51, yp: 12, xs: 3, ys: 1, type: 4, BlockNumber: 2)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 2,interval: 2.0)
                    addBlock(xp: 57, yp: 12, xs: 2, ys: 1, type: 4, BlockNumber: 3)
                    addmoveAction(xmove: 0, ymove: 12, time: 6.0, BlockNumber: 3,interval: 2.0)
                    
                    addDamageO(xp: 67.5, yp: 22, Size: 16, type: 5, damage: 200,BloclNumber: 4, Angle: 90)
                    addmoveAction(xmove: 8, ymove: 0, time: 4.0, BlockNumber: 4,interval: 1.0)
                    addDamageO(xp: 83.5, yp: 18, Size: 16, type: 5, damage: 200,BloclNumber: 5, Angle: 90)
                    addmoveAction(xmove: -8, ymove: 0, time: 4.0, BlockNumber: 5,interval: 1.0)
                    addDamageO(xp: 67.5, yp: 14, Size: 16, type: 5, damage: 200,BloclNumber: 6, Angle: 90)
                    addmoveAction(xmove: 8, ymove: 0, time: 4.0, BlockNumber: 6,interval: 1.0)
                }
            }
        }
        
        if stageNumber == 3{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [108,26]
                BackGroundImage(imageName: "bg1_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 81, py: 10)
                }else{
                    addplayer(px: 2, py: 4)
                    if difficulty == 0 { additem(xp: 81, yp: 10, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 81, yp: 10, type: 3, number: 11) }
                }
                
                if skillGet[3] == false{
                    additem(xp: 5, yp: 3, type: 1, number: 3)
                }
                addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 3)
                addBlock(xp: 20, yp: 0, xs: 19, ys: 3, type: 3)
                addBlock(xp: 30, yp: 3, xs: 9, ys: 1, type: 3)
                addBlock(xp: 33, yp: 4, xs: 6, ys: 2, type: 3)
                addBlock(xp: 36, yp: 6, xs: 3, ys: 2, type: 3)
                
                addBlock(xp: 15, yp: 4, xs: 3, ys: 1, type: 3)
                addBlock(xp: 20, yp: 5, xs: 3, ys: 1, type: 3)
                addBlock(xp: 25, yp: 4, xs: 3, ys: 1, type: 3)
                
                addBlock(xp: 41, yp: 6, xs: 5, ys: 2, type: 1)
                addBlock(xp: 49, yp: 6, xs: 5, ys: 2, type: 1)
                addBlock(xp: 57, yp: 7, xs: 5, ys: 2, type: 1)
                addBlock(xp: 67, yp: 6, xs: 6, ys: 2, type: 1)
                
                addBlock(xp: 76, yp: 0, xs: 20, ys: 8, type: 3)
                addBlock(xp: 96, yp: 0, xs: 12, ys: 8, type: 3)
                
                addgoal(xp: 106, yp: 9)
                
                if difficulty == 0{
                    addenemy(xp: 16, yp: 6, type: 11, HP: 10, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 7, type: 11, HP: 10, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 26, yp: 6, type: 11, HP: 10, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 53, yp: 9, type: 1, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 71, yp: 9, type: 1, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addDamageO(xp: 84.5, yp: 8.5, Size: 2, type: 1, damage: 25)
                    addDamageO(xp: 89.5, yp: 8.5, Size: 2, type: 1, damage: 25,BloclNumber: 1)
                    addDamageO(xp: 94.5, yp: 8.5, Size: 2, type: 1, damage: 25,BloclNumber: 2)
                    addDamageO(xp: 101.5, yp: 15.5, Size: 2, type: 1, damage: 25,BloclNumber: 3)
                    addmoveAction(xmove: 0, ymove: 7, time: 5, BlockNumber: 1,interval: 2.0)
                    addmoveAction(xmove: 7, ymove: 0, time: 5, BlockNumber: 2,interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -7, time: 5, BlockNumber: 3,interval: 2.0)
                }else{
                    addenemy(xp: 16, yp: 6, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 7, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 26, yp: 6, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 49, yp: 10, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 57, yp: 11, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 70, yp: 10, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 84, yp: 9, Size: 3, type: 1, damage: 100)
                    addDamageO(xp: 89.5, yp: 8.5, Size: 2, type: 1, damage: 100,BloclNumber: 1)
                    addmoveAction(xmove: 0, ymove: 7, time: 5, BlockNumber: 1,interval: 2.0)
                    addDamageO(xp: 89.5, yp: 15.5, Size: 2, type: 1, damage: 100,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: -7, time: 5, BlockNumber: 4,interval: 2.0)
                    
                    addDamageO(xp: 94.5, yp: 8.5, Size: 2, type: 1, damage: 100,BloclNumber: 2)
                    addmoveAction(xmove: 7, ymove: 0, time: 5, BlockNumber: 2,interval: 2.0)
                    addDamageO(xp: 101.5, yp: 8.5, Size: 2, type: 1, damage: 100,BloclNumber: 5)
                    addmoveAction(xmove: -7, ymove: 0, time: 5, BlockNumber: 5,interval: 2.0)
                    
                    addDamageO(xp: 101.5, yp: 15.5, Size: 2, type: 1, damage: 100,BloclNumber: 3)
                    addmoveAction(xmove: 0, ymove: -7, time: 5, BlockNumber: 3,interval: 2.0)
                    addDamageO(xp: 101.5, yp: 8.5, Size: 2, type: 1, damage: 100,BloclNumber: 6)
                    addmoveAction(xmove: 0, ymove: 7, time: 5, BlockNumber: 6,interval: 2.0)
                }
            }
        }
        
        if stageNumber == 4{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [32,39]
                BackGroundImage(imageName: "bg1_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 9, py: 27)
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0 { additem(xp: 9, yp: 27, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 9, yp: 27, type: 3, number: 11) }
                }
                addBlock(xp: 0, yp: 0, xs: 7, ys: 3, type: 3)

                addBlock(xp: 8, yp: 24, xs: 20, ys: 2, type: 3)
                addBlock(xp: 28, yp: 24, xs: 4, ys: 2, type: 3)
                addBlock(xp: 21, yp: 26, xs: 11, ys: 2, type: 3)
                addBlock(xp: 24, yp: 28, xs: 8, ys: 2, type: 3)
                addBlock(xp: 27, yp: 30, xs: 5, ys: 2, type: 3)
                addBlock(xp: 30, yp: 32, xs: 2, ys: 6, type: 3)
                addBlock(xp: 0, yp: 38, xs: 20, ys: 1, type: 3)
                addBlock(xp: 20, yp: 38, xs: 12, ys: 1, type: 3)
                addBlock(xp: 14, yp: 37, xs: 7, ys: 1, type: 3)
                addBlock(xp: 16, yp: 36, xs: 3, ys: 1, type: 3)
                
                addBlock(xp: 0, yp: 31, xs: 14, ys: 3, type: 1)
                addBlock(xp: 14, yp: 31, xs: 2, ys: 2, type: 1)
                addBlock(xp: 16, yp: 31, xs: 3, ys: 1, type: 1)
                addBlock(xp: 19, yp: 31, xs: 3, ys: 2, type: 1)
                addBlock(xp: 21, yp: 33, xs: 3, ys: 1, type: 1)
                
                if difficulty == 0{
                    addBlock(xp: 9, yp: 3, xs: 5, ys: 1, type: 1)
                    addBlock(xp: 17, yp: 4, xs: 5, ys: 1, type: 1)
                    addBlock(xp: 24, yp: 5, xs: 5, ys: 1, type: 4, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 9, time: 6.0, BlockNumber: 1 ,interval: 3.0)
                    addenemy(xp: 21, yp: 6, type: 11, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 9, yp: 17, type: 11, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 17, yp: 15, xs: 5, ys: 1, type: 1)
                    addBlock(xp: 9, yp: 15, xs: 5, ys: 1, type: 1)
                    addBlock(xp: 2, yp: 15, xs: 4, ys: 1, type: 4, BlockNumber: 2)
                    addmoveAction(xmove: 0, ymove: 9, time: 6.0, BlockNumber: 2,interval: 3.0)

                    addDamageO(xp: 17, yp: 30.5, Size: 10, type: 7, damage: 15, BloclNumber: 3)
                    addrotateAction(dsita: -180.0, time: 6.0, BlockNumber: 3)
                    addmoveStageO(xp: 0.5, yp: 34.5, Size: 2, moveStageN: 4, moveSceneN: 2, type: 2)
                }
                if difficulty == 1{
                    addBlock(xp: 10, yp: 3, xs: 3, ys: 1, type: 1)
                    addBlock(xp: 18, yp: 4, xs: 3, ys: 1, type: 1)
                    addBlock(xp: 25, yp: 5, xs: 3, ys: 1, type: 4, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 9, time: 6.0, BlockNumber: 1)
                    addenemy(xp: 20, yp: 6, type: 11, HP: 10, Damage: 50, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 10, yp: 17, type: 11, HP: 10, Damage: 50, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 18, yp: 17, type: 11, HP: 10, Damage: 50, direction: true, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 18, yp: 15, xs: 3, ys: 1, type: 1)
                    addBlock(xp: 10, yp: 15, xs: 3, ys: 1, type: 1)
                    addBlock(xp: 4, yp: 15, xs: 2, ys: 1, type: 4, BlockNumber: 2)
                    addmoveAction(xmove: 0, ymove: 9, time: 6.0, BlockNumber: 2,interval: 1.0)
                   
                    addDamageO(xp: 17, yp: 30.5, Size: 10, type: 3, damage: 200, BloclNumber: 3)
                    addrotateAction(dsita: -180.0, time: 12.0, BlockNumber: 3)
                    addmoveStageO(xp: 0.5, yp: 34.5, Size: 2, moveStageN: 4, moveSceneN: 12, type: 2)
                }
            }
            if (2 <= sceneNumber && sceneNumber <= 3) || (12 <= sceneNumber && sceneNumber <= 13){
                let StageDis:[CGFloat] = [37,61]
                BackGroundImage(imageName: "bg1_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 3 || sceneNumber == 13 {
                    addplayer(px: 14, py: 39)
                }else{
                    addplayer(px: 2, py: 55)
                    if difficulty == 0{ additem(xp: 14, yp: 39, type: 3, number: 3) }
                    if difficulty == 1{ additem(xp: 14, yp: 39, type: 3, number: 13) }
                }

                addBlock(xp: 0, yp: 51, xs: 5, ys: 3, type: 3)
                addBlock(xp: 5, yp: 51, xs: 5, ys: 2, type: 1)
                addBlock(xp: 0, yp: 46, xs: 5, ys: 2, type: 1)
                addBlock(xp: 3, yp: 40, xs: 10, ys: 4, type: 1)
                addBlock(xp: 8, yp: 44, xs: 5, ys: 4, type: 1)
                addBlock(xp: 13, yp: 44, xs: 20, ys: 7, type: 1)
                addBlock(xp: 33, yp: 44, xs: 4, ys: 7, type: 1)
                addBlock(xp: 29, yp: 36, xs: 8, ys: 3, type: 1)
                addBlock(xp: 35, yp: 39, xs: 2, ys: 5, type: 1)
                addBlock(xp: 0, yp: 36, xs: 17, ys: 2, type: 1)
                
                addBlock(xp: 20, yp: 38, xs: 4, ys: 1, type: 1)
                addBlock(xp: 20, yp: 27, xs: 13, ys: 2, type: 1)
                addBlock(xp: 20, yp: 29, xs: 2, ys: 4, type: 1)
                addBlock(xp: 31, yp: 29, xs: 2, ys: 4, type: 1)
                
                addgoal(xp: 29.5, yp: 29.5)
                
                addvector(xp: 26, yp: 40, Angle: 0, Size: 3)
  
                if difficulty == 0{
                    addDamageO(xp: 18.5, yp: 55.5, Size: 10, type: 5, damage: 50)
                    addDamageO(xp: 9.5, yp: 51.5, Size: 10, type: 3, damage: 30, BloclNumber: 1)
                    addDamageO(xp: 4, yp: 41.5, Size: 10, type: 3, damage: 30, BloclNumber: 2)
                    addDamageO(xp: 21.5, yp: 36.5, Size: 10, type: 3, damage: 30, BloclNumber: 3)
                    addDamageO(xp: 31.5, yp: 36.5, Size: 10, type: 3, damage: 30, BloclNumber: 4)
                    addrotateAction(dsita: -180, time: 8.0, BlockNumber: 1)
                    addrotateAction(dsita: 180, time: 8.0, BlockNumber: 2)
                    addrotateAction(dsita: -180, time: 6.0, BlockNumber: 3)
                    addrotateAction(dsita: 180, time: 6.0, BlockNumber: 4)
                }
                if difficulty == 1{
                    addDamageO(xp: 15.5, yp: 55.5, Size: 10, type: 5, damage: 200)
                    addDamageO(xp: 9.5, yp: 51.5, Size: 10, type: 3, damage: 200, BloclNumber: 1)
                    addDamageO(xp: 4, yp: 41.5, Size: 10, type: 3, damage: 200, BloclNumber: 2)
                    addDamageO(xp: 21.5, yp: 36.5, Size: 10, type: 3, damage: 200, BloclNumber: 3)
                    addDamageO(xp: 31.5, yp: 36.5, Size: 10, type: 3, damage: 200, BloclNumber: 4)
                    addrotateAction(dsita: -180, time: 5.0, BlockNumber: 1)
                    addrotateAction(dsita: 180, time: 5.0, BlockNumber: 2)
                    addrotateAction(dsita: -180, time: 4.0, BlockNumber: 3)
                    addrotateAction(dsita: 180, time: 4.0, BlockNumber: 4)
                    
                    addDamageO(xp: 0.5, yp: 48.5, Size: 2, type: 1, damage: 200)
                    addDamageO(xp: 17.5, yp: 42.5, Size: 2, type: 1, damage: 200,BloclNumber: 5)
                    addDamageO(xp: 17.5, yp: 33.5, Size: 2, type: 1, damage: 200,BloclNumber: 6)
                    addDamageO(xp: 22.5, yp: 36.5, Size: 2, type: 1, damage: 200,BloclNumber: 7)
                    addmoveAction(xmove: 0, ymove: -8, time: 4.0, BlockNumber: 5)
                    addmoveAction(xmove: 0, ymove: 8, time: 4.0, BlockNumber: 6)
                    addmoveAction(xmove: 7, ymove: 0, time: 4.0, BlockNumber: 7)
                }
            }
        }
        
        if stageNumber == 5{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [80,25]
                BackGroundImage(imageName: "bg1_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
      
                if skillGet[5] == false{
                    additem(xp: 5, yp: 3, type: 1, number: 5)
                }
           
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 41, py: 10)
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0 { additem(xp: 41, yp: 10, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 41, yp: 10, type: 3, number: 11) }
                }
                addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 3)
                addBlock(xp: 20, yp: 0, xs: 20, ys: 3, type: 3)
                addBlock(xp: 40, yp: 0, xs: 3, ys: 3, type: 3)
                addBlock(xp: 38, yp: 3, xs: 5, ys: 1, type: 3)
                
                addBlock(xp: 0, yp: 8, xs: 20, ys: 17, type: 3)
                addBlock(xp: 20, yp: 8, xs: 10, ys: 17, type: 3)
                addBlock(xp: 30, yp: 8, xs: 4, ys: 11, type: 3)
                addBlock(xp: 34, yp: 8, xs: 6, ys: 4, type: 3)
                addBlock(xp: 40, yp: 8, xs: 3, ys: 2, type: 3)
                addBlock(xp: 43, yp: 8, xs: 20, ys: 1, type: 3)
                addBlock(xp: 63, yp: 8, xs: 5, ys: 1, type: 3)
                addBlock(xp: 30, yp: 23, xs: 20, ys: 2, type: 3)
                addBlock(xp: 50, yp: 23, xs: 20, ys: 2, type: 3)
                addBlock(xp: 70, yp: 23, xs: 10, ys: 2, type: 3)
                
                addBlock(xp: 45, yp: 11, xs: 20, ys: 1, type: 3)
                addBlock(xp: 65, yp: 11, xs: 7, ys: 1, type: 3)
                
                addBlock(xp: 72, yp: 11, xs: 2, ys: 3, type: 3)
                addBlock(xp: 74, yp: 11, xs: 2, ys: 5, type: 3)
                addBlock(xp: 76, yp: 11, xs: 2, ys: 7, type: 3)
                addBlock(xp: 78, yp: 11, xs: 2, ys: 12, type: 3)
                
                addBlock(xp: 68, yp: 18, xs: 5, ys: 1, type: 3)
                
                addBlock(xp: 34, yp: 16, xs: 20, ys: 3, type: 1)
                addBlock(xp: 54, yp: 16, xs: 14, ys: 3, type: 1)
                
                addvector(xp: 66, yp: 9.5, Angle: -90, Size: 3)
                addvector(xp: 46, yp: 12.5, Angle: 90, Size: 3)
                
                addgoal(xp: 30.5, yp: 19.5)
                
                if difficulty == 0{
                    addDamageBlock(xp: 8, yp: 3, xs: 1, ys: 5, type: 2, damage: 10)
                    addDamageBlock(xp: 27, yp: 3, xs: 1, ys: 5, type: 2, damage: 10, BlockNumber: 1)
                    addmoveAction(xmove: 10, ymove: 0, time: 5.0, BlockNumber: 1)
                    addenemy(xp: 17, yp: 5, type: 4, HP: 10, Damage: 10, direction: false, maxn: 2, interval: 2.0)
                    addenemy(xp: 21, yp: 5, type: 4, HP: 10, Damage: 10, direction: false, maxn: 2, interval: 2.0)
                    addenemy(xp: 25, yp: 5, type: 4, HP: 10, Damage: 10, direction: false, maxn: 2, interval: 2.0)
                    
                    addBlock(xp: 43, yp: 0, xs: 5, ys: 1, type: 2, BlockNumber: 2)
                    addBlock(xp: 43, yp: 1, xs: 1, ys: 3, type: 2, BlockNumber: 3)
                    addmoveAction(xmove: 9, ymove: 3, time: 5.0, BlockNumber: 2,interval: 4.0)
                    addmoveAction(xmove: 9, ymove: 3, time: 5.0, BlockNumber: 3,interval: 4.0)
                    addBlock(xp: 66, yp: 2, xs: 5, ys: 1, type: 2, BlockNumber: 4)
                    addBlock(xp: 66, yp: 3, xs: 1, ys: 2, type: 2, BlockNumber: 5)
                    addmoveAction(xmove: -8, ymove: -2, time: 5.0, BlockNumber: 4,interval: 4.0)
                    addmoveAction(xmove: -8, ymove: -2, time: 5.0, BlockNumber: 5,interval: 4.0)
                    addBlock(xp: 72, yp: 0, xs: 4, ys: 1, type: 2, BlockNumber: 6)
                    addBlock(xp: 75, yp: 1, xs: 1, ys: 2, type: 2, BlockNumber: 7)
                    addmoveAction(xmove: -4, ymove: 7, time: 5.0, BlockNumber: 6,interval: 4.0)
                    addmoveAction(xmove: -4, ymove: 7, time: 5.0, BlockNumber: 7,interval: 4.0)
                    
                    addenemy(xp: 56, yp: 9, type: 4, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 50, yp: 9, type: 4, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 9, type: 4, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 34, yp: 17, xs: 11, ys: 1, type: 2, damage: 25, BlockNumber: 8)
                    addmoveAction(xmove: 23, ymove: 0, time: 10.0, BlockNumber: 8, firstinterval: 2.0, type: 3)
                    addrotateAction(dsita: 720, time: 10.0, BlockNumber: 8,interval: 2.0,firstinterval: 2.0)
                }
                if difficulty == 1{
                    addDamageBlock(xp: 8, yp: 3, xs: 1, ys: 5, type: 2, damage: 50)
                    addDamageBlock(xp: 17, yp: 3, xs: 1, ys: 5, type: 2, damage: 50, BlockNumber: 1)
                    addmoveAction(xmove: 20, ymove: 0, time: 7.0, BlockNumber: 1)
                    addenemy(xp: 17, yp: 5, type: 4, HP: 10, Damage: 50, direction: false, maxn: 2, interval: 2.0)
                    addenemy(xp: 21, yp: 5, type: 4, HP: 10, Damage: 50, direction: false, maxn: 2, interval: 2.0)
                    addenemy(xp: 25, yp: 5, type: 4, HP: 10, Damage: 50, direction: false, maxn: 1, interval: 2.0)
                    addenemy(xp: 29, yp: 5, type: 4, HP: 10, Damage: 50, direction: false, maxn: 1, interval: 2.0)
                    addBlock(xp: 43, yp: 0, xs: 5, ys: 1, type: 2, BlockNumber: 2)
                    addmoveAction(xmove: 9, ymove: 3, time: 5.0, BlockNumber: 2)
                    addBlock(xp: 66, yp: 2, xs: 5, ys: 1, type: 2, BlockNumber: 4)
                    addmoveAction(xmove: -8, ymove: -2, time: 5.0, BlockNumber: 4)
                    addBlock(xp: 72, yp: 0, xs: 4, ys: 1, type: 2, BlockNumber: 6)
                    addmoveAction(xmove: -4, ymove: 7, time: 5.0, BlockNumber: 6)
                    
                    addenemy(xp: 56, yp: 9, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 50, yp: 9, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 9, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 34, yp: 17, xs: 11, ys: 1, type: 2, damage: 100, BlockNumber: 8)
                    addDamageBlock(xp: 39, yp: 12, xs: 1, ys: 11, type: 2, damage: 100, BlockNumber: 9)
                    addmoveAction(xmove: 23, ymove: 0, time: 10.0, BlockNumber: 8, firstinterval: 2.0, type: 3)
                    addmoveAction(xmove: 23, ymove: 0, time: 10.0, BlockNumber: 9, firstinterval: 2.0, type: 3)
                    addrotateAction(dsita: 360, time: 10.0, BlockNumber: 8,interval: 2.0,firstinterval: 2.0)
                    addrotateAction(dsita: 360, time: 10.0, BlockNumber: 9,interval: 2.0,firstinterval: 2.0)
                }
            }
        }
        
        if stageNumber == 6{
            if sceneNumber == 0{
                BackGroundImage(imageName: "bg1_2", FrameSize: [20,20])
                addBlock(xp: -1, yp: 0, xs: 1, ys: 20, type: 3)
                addBlock(xp: 20, yp: 0, xs: 1, ys: 20, type: 3)
                addBlock(xp: 0, yp: 20, xs: 20, ys: 1, type: 3)
                
                addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 3)
                addplayer(px: 2, py: 5)
              
                if difficulty == 0{
                    addenemy(xp: 17, yp: 5, type: 10, HP: 60, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 16.5, yp: 4.5, Goaltype: 1, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, outtime: 0, intime: 1.0, SwitchNumbet: 1, incontact: false)
                }
                
                if difficulty == 1{
                    enemymax = 2
                    addenemy(xp: 18, yp: 5, type: 4, HP: 20, Damage: 10, direction: false, maxn: 999, interval: 20.0)
                    addenemy(xp: 17, yp: 5, type: 10, HP: 100, Damage: 30, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 16.5, yp: 4.5, Goaltype: 11, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, outtime: 0, intime: 1.0, SwitchNumbet: 1, incontact: false)
                }
            }
        }

        //6¥第２エリア森林
        //6_2_1
        if stageNumber == 7{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [108,42]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 102, py: 16)
                }else{
                    addplayer(px: 2, py: 8)
                    if difficulty == 0 { additem(xp: 102, yp: 16, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 102, yp: 16, type: 3, number: 11) }
                }
    
                addBlock(xp: 0, yp: 0, xs: 16, ys: 6, type: 1)
                addWater(xp: 16, yp: 0, Size: 3, Pattern: 1)
                
                addBlock(xp: 46, yp: 0, xs: 4, ys: 11, type: 1)
                addBlock(xp: 50, yp: 0, xs: 5, ys: 9, type: 1)
                addBlock(xp: 55, yp: 0, xs: 4, ys: 11, type: 1)
                
                addWater(xp: 59, yp: 0, Size: 3, Pattern: 1)
                
                addBlock(xp: 89, yp: 0, xs: 10, ys: 6, type: 1)
                addBlock(xp: 98, yp: 0, xs: 10, ys: 14, type: 1)
                if skillGet[7] == false{ additem(xp: 93, yp: 6, type: 1, number: 7) }
                addBlockO(xp: 106.5, yp: 20.5, Size: 14, type: 2)
                addvector(xp: 96, yp: 9, Angle: 180, Size: 3)
                
                addBlock(xp: 88, yp: 20, xs: 15, ys: 2, type: 1)
                addBlockO(xp: 87.5, yp: 28.5, Size: 14, type: 5)
                
                addBlock(xp: 96, yp: 28, xs: 9, ys: 2, type: 6)
                addvector(xp: 97, yp: 34, Angle: -135, Size: 3)
                
                
                addBlock(xp: 49, yp: 29, xs: 8, ys: 2, type: 6)
                addgoal(xp: 50.5, yp: 31.5)
                
                if difficulty == 0{
                    addenemy(xp: 13, yp: 8, type: 11, HP: 10, Damage: 10, direction: false, maxn: 2, interval: 2.0)
                    addBlock(xp: 18, yp: 7, xs: 5, ys: 1, type: 6)
                    addBlock(xp: 27, yp: 8, xs: 5, ys: 1, type: 6)
                    addBlock(xp: 36, yp: 9, xs: 5, ys: 1, type: 6)
                    
                    addenemy(xp: 56, yp: 13, type: 11, HP: 10, Damage: 15, direction: false, maxn: 2, interval: 3.0)
                    
                    addBlockO(xp: 63.5, yp: 9.5, Size: 6, type: 1)
                    addBlockO(xp: 72.5, yp: 8.5, Size: 6, type: 1)
                    addBlockO(xp: 81.6, yp: 8.5, Size: 6, type: 6)
                    
                    addenemy(xp: 93, yp: 24, type: 11, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 103, yp: 32, type: 11, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlockO(xp: 76.5, yp: 29.5, Size: 6, type: 1)
                    addBlockO(xp: 69.5, yp: 29.5, Size: 6, type: 1)
                    addBlockO(xp: 62.5, yp: 29.5, Size: 6, type: 1)
                }
                if difficulty == 1{
                    addenemy(xp: 13, yp: 8, type: 17, HP: 30, Damage: 30, direction: false, maxn: 2, interval: 2.0)
                    addBlock(xp: 19, yp: 7, xs: 3, ys: 1, type: 6)
                    addBlock(xp: 27, yp: 8, xs: 3, ys: 1, type: 6)
                    addBlock(xp: 35, yp: 9, xs: 3, ys: 1, type: 6)
                    
                    addenemy(xp: 56, yp: 13, type: 17, HP: 30, Damage: 30, direction: false, maxn: 2, interval: 3.0)
                    
                    addBlockO(xp: 64, yp: 9.5, Size: 4, type: 7)
                    addBlockO(xp: 72, yp: 8.5, Size: 4, type: 7)
                    addBlockO(xp: 80, yp: 8.5, Size: 4, type: 6)
                    
                    addenemy(xp: 90, yp: 9, type: 17, HP: 30, Damage: 30, direction: false, maxn: 2, interval: 3.0)
                    
                    addenemy(xp: 93, yp: 24, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 103, yp: 32, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 85, yp: 33, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                
                    addBlockO(xp: 76.5, yp: 29.5, Size: 6, type: 7)
                    addBlockO(xp: 69.5, yp: 29.5, Size: 6, type: 7)
                    addBlockO(xp: 61.5, yp: 28.5, Size: 6, type: 6)
                }
                
            }
        }
        //6_2_2
        if stageNumber == 8{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [68,100]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 2, py: 59)
                }else{
                    addplayer(px: 2, py: 92)
                    if difficulty == 0 { additem(xp: 2, yp: 59, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 2, yp: 59, type: 3, number: 11) }
                }
                addBlock(xp: 0, yp: 88, xs: 8, ys: 2, type: 6)
                addvector(xp: 18, yp: 86, Angle: 45, Size: 3)
                
                addBlock(xp: 5, yp: 63, xs: 19, ys: 3, type: 6)
                
                addvector(xp: 2, yp: 65, Angle: 0, Size: 3)
                
                addBlock(xp: 0, yp: 13, xs: 5, ys: 20, type: 6)
                addBlock(xp: 0, yp: 33, xs: 5, ys: 20, type: 6)
                addBlock(xp: 0, yp: 53, xs: 5, ys: 4, type: 6)
                addBlock(xp: 5, yp: 13, xs: 20, ys: 4, type: 6)
                addBlock(xp: 25, yp: 13, xs: 20, ys: 4, type: 6)
                addBlock(xp: 45, yp: 13, xs: 10, ys: 4, type: 6)
                addBlock(xp: 55, yp: 13, xs: 13, ys: 10, type: 6)
                addWater(xp: 5, yp: 17, Size: 5, Pattern: 2)
                addBlockO(xp: 9.5, yp: 53.5, Size: 10, type: 3)
                addBlockO(xp: 35.5, yp: 37.5, Size: 10, type: 3)
                
                if difficulty == 0{
                    addBlockO(xp: 12, yp: 88, Size: 7, type: 7)
                    addBlockO(xp: 20, yp: 82, Size: 7, type: 7)
                    addBlockO(xp: 29, yp: 77, Size: 7, type: 1)
                    addBlockO(xp: 38, yp: 74, Size: 7, type: 7)
                    addBlockO(xp: 30, yp: 66, Size: 7, type: 7)
                    addvector(xp: 32, yp: 71, Angle: 0, Size: 3)
                    
                    addDamageBlock(xp: 0, yp: 73, xs: 16, ys: 9, type: 2, damage: 50)
                    addDamageBlock(xp: 16, yp: 73, xs: 8, ys: 4, type: 2, damage: 50)
                    addDamageBlock(xp: 24, yp: 73, xs: 10, ys: 3, type: 2, damage: 50)
                    
                    addenemy(xp: 16, yp: 67, type: 11, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 13, yp: 67, type: 4, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 10, yp: 67, type: 11, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 7, yp: 67, type: 4, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 30, yp: 37, Size: 5, type: 4, damage: 20)
                    
                    addDamageBlock(xp: 47, yp: 28, xs: 2, ys: 2, type: 2, damage: 10, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 8, time: 5.0, BlockNumber: 1)
                    
                    addmoveStageO(xp: 66.5, yp: 23.5, Size: 2, moveStageN: 8, moveSceneN: 2, type: 1)
                    
                }
                if difficulty == 1{
                    addBlockO(xp: 12, yp: 88.5, Size: 3, type: 7)
                    addBlockO(xp: 20, yp: 83, Size: 3, type: 7)
                    addBlockO(xp: 27, yp: 77, Size: 3, type: 1)
                    addBlockO(xp: 35, yp: 74, Size: 3, type: 7)
                    addBlockO(xp: 28, yp: 66, Size: 3, type: 7)
                    addvector(xp: 32, yp: 71, Angle: -45, Size: 3)
                    
                    addDamageBlock(xp: 0, yp: 73, xs: 16, ys: 9, type: 2, damage: 200)
                    addDamageBlock(xp: 16, yp: 73, xs: 8, ys: 4, type: 2, damage: 200)
                    addDamageBlock(xp: 24, yp: 73, xs: 10, ys: 3, type: 2, damage: 200)
                    
                    addenemy(xp: 16, yp: 67, type: 14, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 13, yp: 67, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 10, yp: 67, type: 14, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 7, yp: 67, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 29, yp: 38, Size: 7, type: 4, damage: 20)
                    
                    addenemy(xp: 22, yp: 49, type: 14, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 46, yp: 35, type: 14, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 47, yp: 28, xs: 2, ys: 2, type: 2, damage: 50, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 8, time: 5.0, BlockNumber: 1)
                    
                    addmoveStageO(xp: 66.5, yp: 23.5, Size: 2, moveStageN: 8, moveSceneN: 12, type: 1)
                }
            }
            
            if sceneNumber == 2 || sceneNumber == 12{
                let StageDis:[CGFloat] = [42,96]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 92)
                
                
                addBlock(xp: 0, yp: 87, xs: 8, ys: 2, type: 6)
                addBlock(xp: 6, yp: 0, xs: 2, ys: 50, type: 6)
                addBlock(xp: 6, yp: 50, xs: 2, ys: 38, type: 6)
                addBlock(xp: 24, yp: 5, xs: 1, ys: 50, type: 6)
                addBlock(xp: 24, yp: 55, xs: 1, ys: 41, type: 6)
                
                addBlockO(xp: 15.5, yp: 85.5, Size: 16, type: 7)
                
                addvector(xp: 9, yp: 7, Angle: 45, Size: 3)
                addvector(xp: 15, yp: 7, Angle: 45, Size: 3)
                addvector(xp: 21, yp: 7, Angle: 45, Size: 3)
                
                addBlock(xp: 25, yp: 0, xs: 17, ys: 1, type: 1)
                addgoal(xp: 40.5, yp: 1.5)
                
                if difficulty == 0{
                    addDamageBlock(xp: 8, yp: 77, xs: 8, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 16, yp: 70, xs: 8, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 11, yp: 64, xs: 2, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 17, yp: 64, xs: 2, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 13, yp: 58, xs: 2, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 19, yp: 58, xs: 2, ys: 2, type: 2, damage: 20)
                    
                    addenemy(xp: 9, yp: 54, type: 1, HP: 10, Damage: 15, direction: true, maxn: 2, interval: 3.0)
                    addenemy(xp: 22, yp: 51, type: 1, HP: 10, Damage: 15, direction: false, maxn: 2, interval: 3.0)
                    addenemy(xp: 9, yp: 48, type: 1, HP: 10, Damage: 15, direction: true, maxn: 2, interval: 3.0)
                    
                    addDamageBlock(xp: 8, yp: 40, xs: 2, ys: 2, type: 2, damage: 10, BlockNumber: 1)
                    addDamageBlock(xp: 22, yp: 35, xs: 2, ys: 2, type: 2, damage: 10, BlockNumber: 2)
                    addDamageBlock(xp: 8, yp: 30, xs: 2, ys: 2, type: 2, damage: 10, BlockNumber: 3)
                    addmoveAction(xmove: 14, ymove: 0, time: 6.0, BlockNumber: 1)
                    addmoveAction(xmove: -14, ymove: 0, time: 6.0, BlockNumber: 2)
                    addmoveAction(xmove: 14, ymove: 0, time: 6.0, BlockNumber: 3)
                    
                    addenemy(xp: 9, yp: 25, type: 11, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 22, type: 11, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 9, yp: 19, type: 11, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 16, type: 11, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 37, yp: 3, type: 15, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addDamageBlock(xp: 8, yp: 77, xs: 8, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 20, yp: 77, xs: 4, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 8, yp: 70, xs: 4, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 16, yp: 70, xs: 8, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 8, yp: 64, xs: 11, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 22, yp: 64, xs: 2, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 8, yp: 58, xs: 2, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 13, yp: 58, xs: 11, ys: 2, type: 2, damage: 50)
                    
                    addenemy(xp: 9, yp: 54, type: 4, HP: 10, Damage: 30, direction: true, maxn: 2, interval: 3.0)
                    addenemy(xp: 22, yp: 51, type: 4, HP: 10, Damage: 30, direction: false, maxn: 2, interval: 3.0)
                    addenemy(xp: 9, yp: 48, type: 7, HP: 30, Damage: 30, direction: true, maxn: 2, interval: 3.0)
                    
                    addDamageBlock(xp: 8, yp: 40, xs: 3, ys: 2, type: 2, damage: 50, BlockNumber: 1)
                    addDamageBlock(xp: 22, yp: 35, xs: 3, ys: 2, type: 2, damage: 50, BlockNumber: 2)
                    addDamageBlock(xp: 8, yp: 29, xs: 3, ys: 3, type: 2, damage: 50, BlockNumber: 3)
                    addmoveAction(xmove: 13, ymove: 0, time: 6.0, BlockNumber: 1)
                    addmoveAction(xmove: -13, ymove: 0, time: 6.0, BlockNumber: 2)
                    addmoveAction(xmove: 13, ymove: 0, time: 6.0, BlockNumber: 3)
                    
                    addenemy(xp: 9, yp: 25, type: 14, HP: 10, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 22, type: 14, HP: 10, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 9, yp: 19, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 16, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 38, yp: 1, xs: 2, ys: 4, type: 5,BlockNumber: 10)
                    addBlock(xp: 40, yp: 3, xs: 2, ys: 2, type: 5,BlockNumber: 11)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 10, type: 4, outtime: 1.0, SwitchNumbet: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 11, type: 4, outtime: 1.0, SwitchNumbet: 2)
                    addenemy(xp: 36, yp: 3, type: 18, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0 , SwitchNumber: [1,2])

                }
            }
        }
        //6_2_3
        if stageNumber == 9{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [101,48]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 71, py: 37, DFlag: false)
                }else{
                    addplayer(px: 98, py: 3,DFlag: false)
                    if difficulty == 0 { additem(xp: 71, yp: 37, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 71, yp: 37, type: 3, number: 11) }
                }
                
                addBlock(xp: 88, yp: 0, xs: 13, ys: 1, type: 1)
                addBlock(xp: 82, yp: 0, xs: 6, ys: 4, type: 1)
                addBlock(xp: 69, yp: 0, xs: 13, ys: 10, type: 1)
                addBlock(xp: 36, yp: 0, xs: 33, ys: 7, type: 1)
                addBlock(xp: 12, yp: 0, xs: 24, ys: 2, type: 1)
                addBlockO(xp: 67, yp: 16, Size: 13, type: 5)
                addBlockO(xp: 57.5, yp: 14.5, Size: 16, type: 4)
                addBlockO(xp: 37, yp: 10, Size: 7, type: 2)
                addBlockO(xp: 30.5, yp: 9.5, Size: 16, type: 4)
                addBlockO(xp: 21.5, yp: 8.5, Size: 14, type: 5)
                addBlockO(xp: 7.5, yp: 6.5, Size: 28, type: 4)
                additem(xp: 48, yp: 7, type: 2, number: 1)
                
                addBlock(xp: 75, yp: 16, xs: 7, ys: 2, type: 1)
                addBlock(xp: 82, yp: 16, xs: 5, ys: 3, type: 1)
                addBlock(xp: 87, yp: 16, xs: 6, ys: 7, type: 1)
                addBlockO(xp: 80.5, yp: 21.5, Size: 8, type: 2)
                addBlockO(xp: 84, yp: 22, Size: 7, type: 5)
                addBlockO(xp: 93.5, yp: 26.5, Size: 8, type: 4)
            
                addBlock(xp: 99, yp: 29, xs: 2, ys: 1, type: 1)
                addBlockO(xp: 99.5, yp: 34.5, Size: 10, type: 2)
                
                addBlock(xp: 70, yp: 21, xs: 2, ys: 15, type: 6)
                addBlock(xp: 72, yp: 28, xs: 10, ys: 8, type: 6)
                addBlock(xp: 82, yp: 34, xs: 13, ys: 2, type: 6)
                
                if skillGet[2] == false{ additem(xp: 74, yp: 36, type: 1, number: 2) }
                
                addBlock(xp: 95, yp: 40, xs: 6, ys: 2, type: 6)
                
                addBlock(xp: 0, yp: 31, xs: 30, ys: 4, type: 6)
                addBlock(xp: 28, yp: 26, xs: 2, ys: 5, type: 6)
                addBlock(xp: 7, yp: 14, xs: 5, ys: 2, type: 6)
                addBlock(xp: 10, yp: 16, xs: 2, ys: 5, type: 6)
                addBlock(xp: 12, yp: 19, xs: 9, ys: 2, type: 6)
                addBlock(xp: 19, yp: 21, xs: 2, ys: 5, type: 6)
                addBlock(xp: 20, yp: 24, xs: 39, ys: 2, type: 6)
                addBlock(xp: 60, yp: 24, xs: 5, ys: 16, type: 6)
                addBlock(xp: 63, yp: 40, xs: 27, ys: 2, type: 6)
                addBlock(xp: 80, yp: 42, xs: 5, ys: 6, type: 6)
                addgoal(xp: 25.5, yp: 26.5)
                additem(xp: 9, yp: 16, type: 2, number: 1)
                
                if difficulty == 0{
                    addenemy(xp: 83, yp: 7, type: 11, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 77, yp: 12, type: 11, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 79, yp: 20, type: 12, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 84, yp: 25, type: 12, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 89, yp: 24, type: 12, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 83, yp: 37, type: 15, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 96, yp: 43, type: 12, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 88, yp: 43, type: 12, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 60, yp: 20, type: 11, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 59, yp: 21, type: 11, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 39, yp: 10, type: 12, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 40, yp: 10, type: 12, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 41, yp: 10, type: 12, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 29, yp: 14, type: 5, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 18, yp: 12, type: 5, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 12, yp: 12, type: 5, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 20, yp: 27, type: 16, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 27, type: 16, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addenemy(xp: 83, yp: 7, type: 14, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 77, yp: 12, type: 14, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 79, yp: 20, type: 15, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 84, yp: 25, type: 15, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 89, yp: 24, type: 18, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 83, yp: 37, type: 18, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 96, yp: 43, type: 18, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 88, yp: 43, type: 18, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 60, yp: 20, type: 11, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 59, yp: 21, type: 14, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 39, yp: 10, type: 18, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 40, yp: 10, type: 15, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 41, yp: 10, type: 12, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 29, yp: 14, type: 5, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 18, yp: 12, type: 5, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 12, yp: 12, type: 8, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 20, yp: 27, type: 19, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 27, type: 19, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                }
            }
        }
        //6_2_4
        if stageNumber == 10{
            if sceneNumber == 0{
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [101,72]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 67)
                addBlock(xp: 0, yp: 0, xs: 5, ys: 65, type: 6)
                addWater(xp: 5, yp: 0, Size: 9, Pattern: 2)
                addBlockO(xp: 9, yp: 61, Size: 9, type: 3)
                addBlock(xp: 26, yp: 52, xs: 1, ys: 1, type: 6)
                addBlock(xp: 32, yp: 48, xs: 1, ys: 1, type: 6)
                addBlock(xp: 41, yp: 43, xs: 2, ys: 1, type: 6)
                addBlock(xp: 64, yp: 29, xs: 2, ys: 1, type: 6)
                additem(xp: 76, yp: 23, type: 2, number: 2)
                addBlock(xp: 91, yp: 13, xs: 1, ys: 1, type: 6)
                
                addBlock(xp: 95, yp: 0, xs: 6, ys: 6, type: 1)
                
                if difficulty == 0 {
                    addDamageBlock(xp: 17, yp: 51, xs: 3, ys: 3, type: 2, damage: 15, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 10, time: 6.0, BlockNumber: 1)
                    
                    addenemy(xp: 26, yp: 53, type: 11, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 32, yp: 49, type: 1, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 41, yp: 44, type: 11, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 42, yp: 44, type: 1, HP: 10, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 53, yp: 32, xs: 1, ys: 11, type: 2, damage: 15, BlockNumber: 2)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 2)
                    
                    addenemy(xp: 64, yp: 30, type: 1, HP: 10, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 65, yp: 30, type: 11, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 86, yp: 13, xs: 2, ys: 2, type: 2, damage: 15, BlockNumber: 3)
                    addmoveAction(xmove: 0, ymove: 8, time: 5.0, BlockNumber: 3)
                    
                    addenemy(xp: 91, yp: 14, type: 11, HP: 20, Damage: 15, direction: false, maxn: 2, interval: 0.5)
                    
                    addmoveStageO(xp: 99.5, yp: 6.5, Size: 2, moveStageN: 10, moveSceneN: 1, type: 1)
                }
                
                if difficulty == 1 {
                    addDamageBlock(xp: 17, yp: 51, xs: 3, ys: 3, type: 2, damage: 30, BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: 10, time: 5.0, BlockNumber: 1)
                    
                    addenemy(xp: 26, yp: 53, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 32, yp: 49, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 41, yp: 44, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 42, yp: 44, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 53, yp: 32, xs: 1, ys: 11, type: 2, damage: 30, BlockNumber: 2)
                    addrotateAction(dsita: 90, time: 3.5, BlockNumber: 2)
                    
                    addenemy(xp: 64, yp: 30, type: 7, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 65, yp: 30, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 86, yp: 13, xs: 2, ys: 2, type: 2, damage: 30, BlockNumber: 3)
                    addmoveAction(xmove: 0, ymove: 8, time: 4.0, BlockNumber: 3)
                    
                    addenemy(xp: 91, yp: 14, type: 17, HP: 30, Damage: 30, direction: false, maxn: 2, interval: 0.5)
                    
                    addmoveStageO(xp: 99.5, yp: 6.5, Size: 2, moveStageN: 10, moveSceneN: 11, type: 1)
                }
            }
            
            if (1 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){

                let StageDis:[CGFloat] = [126,100]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 124, py: 36, DFlag: false)
                }else{
                    addplayer(px: 2, py: 96)
                    if difficulty == 0{ additem(xp: 121, yp: 30, type: 3, number: 2) }
                    if difficulty == 1{ additem(xp: 121, yp: 30, type: 3, number: 12) }
                }
                addBlock(xp: 123, yp: 34, xs: 3, ys: 1, type: 6)
                addvector(xp: 121, yp: 35, Angle: 0, Size: 3)

                addBlock(xp: 0, yp: 49, xs: 6, ys: 45, type: 6)
                addBlock(xp: 6, yp: 49, xs: 54, ys: 5, type: 6)
                addBlock(xp: 60, yp: 23, xs: 6, ys: 31, type: 6)
                addBlock(xp: 66, yp: 23, xs: 51, ys: 1, type: 6)
                addBlock(xp: 116, yp: 24, xs: 1, ys: 5, type: 6)
                addWater(xp: 6, yp: 54, Size: 5, Pattern: 2)
                addWater(xp: 56, yp: 54, Size: 1, Pattern: 1)
                addWater(xp: 66, yp: 24, Size: 5, Pattern: 2)
                addBlockO(xp: 10.5, yp: 88.5, Size: 10, type: 3, Angle: -30)
                addBlock(xp: 53, yp: 67, xs: 2, ys: 2, type: 6)
                addDamageO(xp: 55, yp: 60, Size: 5, type: 4, damage: 20)
                
                addBlockO(xp: 70.5, yp: 58.5, Size: 10, type: 3, Angle: -30)
                addBlock(xp: 91, yp: 51, xs: 4, ys: 1, type: 6)
                additem(xp: 77, yp: 57, type: 2, number: 1)
                
                addBlockO(xp: 120.5, yp: 27.5, Size: 8, type: 7)
                addBlockO(xp: 114.5, yp: 19.5, Size: 4, type: 6)
                
                addWater(xp: 116, yp: 11, Size: 1, Pattern: 1)
                addWater(xp: 116, yp: 5, Size: 1, Pattern: 1)
                addWater(xp: 86, yp: -7, Size: 3, Pattern: 3)
                addBlockO(xp: 111.5, yp: 15.5, Size: 10, type: 8, Angle: 30)
                
                addBlock(xp: 53, yp: 0, xs: 9, ys: 4, type: 1)
                addgoal(xp: 53.5, yp: 4.5)
                
                if difficulty == 0 {
                    addDamageBlock(xp: 21, yp: 82, xs: 1, ys: 11, type: 2, damage: 20, BlockNumber: 1)
                    addDamageBlock(xp: 31, yp: 76, xs: 1, ys: 11, type: 2, damage: 20, BlockNumber: 2)
                    addDamageBlock(xp: 42, yp: 70, xs: 1, ys: 11, type: 2, damage: 20, BlockNumber: 3)
                    addDamageBlock(xp: 37, yp: 75, xs: 11, ys: 1, type: 2, damage: 20, BlockNumber: 4)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 1)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 2)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 3)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    
                    addenemy(xp: 53.5, yp: 69.5, type: 15, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlockO(xp: 60, yp: 63, Size: 5, type: 6)
                    addBlockO(xp: 66, yp: 64, Size: 5, type: 6)
                    
                    addenemy(xp: 91.5, yp: 52.5, type: 15, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 93.5, yp: 52.5, type: 15, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 92, yp: 39, xs: 2, ys: 2, type: 2, damage: 20, BlockNumber: 5)
                    addDamageBlock(xp: 105, yp: 35, xs: 2, ys: 2, type: 2, damage: 20, BlockNumber: 6)
                    addDamageBlock(xp: 109, yp: 31, xs: 2, ys: 2, type: 2, damage: 20, BlockNumber: 7)
                    addmoveAction(xmove: 10.0, ymove: 0, time: 5.0, BlockNumber: 5)
                    addmoveAction(xmove: -10.0, ymove: 0, time: 5.0, BlockNumber: 6)
                    addmoveAction(xmove: 10.0, ymove: 0, time: 5.0, BlockNumber: 7)
                    
                    addDamageBlock(xp: 117, yp: 23, xs: 3, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 123, yp: 19, xs: 3, ys: 2, type: 2, damage: 20)
                    
                    addBlockO(xp: 82.5, yp: 0.5, Size: 6, type: 1)
                    addBlockO(xp: 74.5, yp: 0.5, Size: 6, type: 1)
                    addBlockO(xp: 66.5, yp: 0.5, Size: 6, type: 6)
                }
                
                if difficulty == 1 {
                    addDamageBlock(xp: 21, yp: 82, xs: 1, ys: 11, type: 2, damage: 40, BlockNumber: 1)
                    addDamageBlock(xp: 31, yp: 76, xs: 1, ys: 11, type: 2, damage: 40, BlockNumber: 2)
                    addDamageBlock(xp: 42, yp: 70, xs: 1, ys: 11, type: 2, damage: 40, BlockNumber: 3)
                    addDamageBlock(xp: 37, yp: 75, xs: 11, ys: 1, type: 2, damage: 40, BlockNumber: 4)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 1)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 2)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 3)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    
                    addenemy(xp: 53.5, yp: 69.5, type: 18, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlockO(xp: 60, yp: 63, Size: 3, type: 6)
                    addBlockO(xp: 66, yp: 64, Size: 3, type: 6)
                    
                    addenemy(xp: 91.5, yp: 52.5, type: 15, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 93.5, yp: 52.5, type: 18, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 92, yp: 39, xs: 2, ys: 2, type: 2, damage: 40, BlockNumber: 5)
                    addDamageBlock(xp: 105, yp: 35, xs: 2, ys: 2, type: 2, damage: 40, BlockNumber: 6)
                    addDamageBlock(xp: 109, yp: 31, xs: 2, ys: 2, type: 2, damage: 40, BlockNumber: 7)
                    addmoveAction(xmove: 10.0, ymove: 0, time: 5.0, BlockNumber: 5)
                    addmoveAction(xmove: -10.0, ymove: 0, time: 5.0, BlockNumber: 6)
                    addmoveAction(xmove: 10.0, ymove: 0, time: 5.0, BlockNumber: 7)
                    
                    addDamageBlock(xp: 117, yp: 23, xs: 5, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 121, yp: 18, xs: 5, ys: 2, type: 2, damage: 50)
                    
                    addBlockO(xp: 82.5, yp: 0.5, Size: 4, type: 7)
                    addBlockO(xp: 74.5, yp: 0.5, Size: 4, type: 7)
                    addBlockO(xp: 66.5, yp: 0.5, Size: 4, type: 6)
                }
            }
        }
        //6_2_5
        if stageNumber == 11{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [71,50]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11 {
                    addplayer(px: 25, py: 38)
                    if difficulty == 0 { additem(xp: 65, yp: 47, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 65, yp: 47, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 65, py: 47)
                    if difficulty == 0 { additem(xp: 25, yp: 30, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 25, yp: 30, type: 3, number: 11) }
                }else{
                    addplayer(px: 64, py: 4,DFlag: false)
                    if difficulty == 0 {
                        additem(xp: 25, yp: 30, type: 3, number: 1)
                        additem(xp: 65, yp: 47, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 25, yp: 30, type: 3, number: 11)
                        additem(xp: 65, yp: 47, type: 3, number: 12)
                    }
                }
                addBlock(xp: 0, yp: 0, xs: 71, ys: 2, type: 6)
                addBlock(xp: 38, yp: 2, xs: 17, ys: 7, type: 6)
                addvector(xp: 47, yp: 10, Angle: -90, Size: 3)
                addvector(xp: 50, yp: 14, Angle: 180, Size: 3)
                addDamageBlock(xp: 38, yp: 9, xs: 4, ys: 3, type: 2, damage: 200)
                
                addgoal(xp: 0.5, yp: 2.5)
                
                addBlock(xp: 0, yp: 6, xs: 17, ys: 10, type: 1)
                addBlock(xp: 17, yp: 14, xs: 21, ys: 2, type: 1)
                addBlock(xp: 38, yp: 12, xs: 11, ys: 4, type: 1)
                addBlockO(xp: 0.5, yp: 22.5, Size: 14, type: 2)
                
                addBlock(xp: 6, yp: 22, xs: 6, ys: 3, type: 1)
                addBlock(xp: 12, yp: 22, xs: 12, ys: 2, type: 1)
                addBlock(xp: 24, yp: 22, xs: 6, ys: 6, type: 1)
                addBlock(xp: 30, yp: 22, xs: 23, ys: 2, type: 1)
                
                addBlockO(xp: 31.5, yp: 36.5, Size: 18, type: 4)
                
                addBlock(xp: 0, yp: 32, xs: 1, ys: 18, type: 6)
                addBlock(xp: 1, yp: 32, xs: 22, ys: 2, type: 6)
                addBlock(xp: 12, yp: 34, xs: 4, ys: 4, type: 6)
                
                addBlock(xp: 4, yp: 38, xs: 4, ys: 2, type: 6)
                addBlock(xp: 6, yp: 40, xs: 2, ys: 5, type: 6)
                addBlock(xp: 8, yp: 43, xs: 21, ys: 2, type: 6)
                addvector(xp: 30, yp: 46, Angle: 45, Size: 3)
                
                addBlock(xp: 35, yp: 30, xs: 8, ys: 2, type: 6)
                addBlock(xp: 43, yp: 30, xs: 2, ys: 20, type: 6)
                addBlock(xp: 45, yp: 30, xs: 3, ys: 3, type: 6)
                
                
                addBlock(xp: 50, yp: 39, xs: 3, ys: 2, type: 6)
                addBlock(xp: 53, yp: 22, xs: 14, ys: 23, type: 6)
                addDamageBlock(xp: 58, yp: 45, xs: 4, ys: 5, type: 2, damage: 50)
                addvector(xp: 68.5, yp: 46.5, Angle: 0, Size: 4)
                if skillGet[6] == false{ additem(xp: 55, yp: 45, type: 1, number: 6) }
                
                if difficulty == 0 {
                    addenemy(xp: 27, yp: 18, type: 5, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 8.5, yp: 22.5, Size: 14, type: 2, damage: 20,BloclNumber: 2)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 2)
                    addDamageO(xp: 17.5, yp: 21.5, Size: 14, type: 2, damage: 20,BloclNumber: 3)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 3)
                    
                    addDamageO(xp: 31, yp: 36, Size: 17, type: 2, damage: 20,BloclNumber: 4)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 4)
                    
                    addenemy(xp: 14, yp: 38, type: 15, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 12, yp: 38, type: 15, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 6, yp: 34, type: 4, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 1, yp: 34, type: 4, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 10, yp: 46, type: 2, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 46, type: 2, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 46, type: 5, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 45, yp: 34, type: 14, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 52, yp: 42, type: 14, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 26, yp: 4, type: 13, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0, SwitchNumber: [1,2])
                    addenemyAction(xp: 36, yp: 4, type: 6, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 1, SwitchNumber: 4)
                    addenemyAction(xp: 18, yp: 4, type: 6, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 2, SwitchNumber: 3)
                    addenemyAction(xp: 36, yp: 4, type: 16, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 3, SwitchNumber: 5)
                    addenemyAction(xp: 18, yp: 4, type: 16, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 4 )
                    addBlock(xp: 15, yp: 2, xs: 2, ys: 4, type: 5,BlockNumber:1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 4, outtime: 1.0, intime: 0, SwitchNumbet: 5)
                    addenemy(xp: 8, yp: 3, type: 6, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 2, yp: 3, type: 6, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addenemy(xp: 27, yp: 18, type: 8, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 8.5, yp: 22.5, Size: 14, type: 2, damage: 50,BloclNumber: 2)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 2)
                    addDamageO(xp: 17.5, yp: 21.5, Size: 14, type: 2, damage: 50,BloclNumber: 3)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 3)
                    
                    addDamageO(xp: 31, yp: 36, Size: 17, type: 2, damage: 50,BloclNumber: 4)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 4)
                    
                    addenemy(xp: 14, yp: 38, type: 15, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 12, yp: 38, type: 18, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 6, yp: 34, type: 4, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 1, yp: 34, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 10, yp: 46, type: 5, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 46, type: 5, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 22, yp: 46, type: 8, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 45, yp: 34, type: 14, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 52, yp: 42, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 26, yp: 4, type: 13, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0, SwitchNumber: [1,2])
                    addenemyAction(xp: 36, yp: 4, type: 9, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 1, SwitchNumber: 4)
                    addenemyAction(xp: 18, yp: 4, type: 9, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 2, SwitchNumber: 3)
                    addenemyAction(xp: 36, yp: 4, type: 19, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 3, SwitchNumber: 5)
                    addenemyAction(xp: 18, yp: 4, type: 19, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 4 )
                    addBlock(xp: 15, yp: 2, xs: 2, ys: 4, type: 5,BlockNumber:1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 4, outtime: 1.0, intime: 0, SwitchNumbet: 5)
                    addenemy(xp: 8, yp: 3, type: 9, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 2, yp: 3, type: 9, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                }
            }
        }
        //6_2_6
        if stageNumber == 12{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [101,100]
                BackGroundImage(imageName: "bg2_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 87, py: 44, DFlag: false)
                    if difficulty == 0 { additem(xp: 76, yp: 26, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 76, yp: 26, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 76, py: 26)
                    if difficulty == 0 { additem(xp: 87, yp: 44, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 87, yp: 44, type: 3, number: 11) }
                }else{
                    addplayer(px: 2, py: 92)
                    if difficulty == 0 {
                        additem(xp: 87, yp: 44, type: 3, number: 1)
                        additem(xp: 76, yp: 26, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 87, yp: 44, type: 3, number: 11)
                        additem(xp: 76, yp: 26, type: 3, number: 12)
                    }
                }
        
                addBlock(xp: 0, yp: 89, xs: 7, ys: 1, type: 6)
                addvector(xp: 14, yp: 88, Angle: 90, Size: 3)
                addvector(xp: 23, yp: 85, Angle: 45, Size: 3)
                
                addBlock(xp: 28, yp: 80, xs: 8, ys: 2, type: 6)
                
                addDamageBlock(xp: 45, yp: 76, xs: 1, ys: 24, type: 1, damage: 50)
                addDamageBlock(xp: 81, yp: 64, xs: 1, ys: 36, type: 1, damage: 50)
                
                addDamageBlock(xp: 0, yp: 49, xs: 91, ys: 2, type: 2, damage: 200)
                
                addDamageBlock(xp: 92, yp: 38, xs: 9, ys: 2, type: 2, damage: 200)
                
                addvector(xp: 38, yp: 64, Angle: 90, Size: 3)
                addvector(xp: 38, yp: 68, Angle: 90, Size: 3)
                addvector(xp: 38, yp: 72, Angle: 90, Size: 3)
                
                addvector(xp: 80, yp: 60, Angle: 90, Size: 3)
                
                addBlock(xp: 83, yp: 33, xs: 9, ys: 9, type: 6)
                addDamageBlock(xp: 32, yp: 35, xs: 2, ys: 14, type: 2, damage: 200)
                
                addDamageBlock(xp: 9, yp: 21, xs: 25, ys: 2, type: 2, damage: 200)
                addDamageBlock(xp: 34, yp: 21, xs: 2, ys: 3, type: 2, damage: 200)
                addDamageBlock(xp: 34, yp: 24, xs: 12, ys: 2, type: 2, damage: 200)
                addDamageBlock(xp: 46, yp: 24, xs: 2, ys: 9, type: 2, damage: 200)
                addDamageBlock(xp: 48, yp: 33, xs: 37, ys: 2, type: 2, damage: 200)
                
                addBlock(xp: 32, yp: 11, xs: 6, ys: 5, type: 6)
                
                addDamageBlock(xp: 0, yp: 11, xs: 32, ys: 2, type: 2, damage: 200)
                addDamageBlock(xp: 38, yp: 11, xs: 36, ys: 2, type: 2, damage: 200)
                addBlock(xp: 74, yp: 11, xs: 9, ys: 13, type: 6)
                
                addvector(xp: 38.5, yp: 35, Angle: 0, Size: 3)
                addvector(xp: 38, yp: 30.5, Angle: -90, Size: 3)
                addvector(xp: 26.5, yp: 30.5, Angle: -90, Size: 3)
                addvector(xp: 8, yp: 25, Angle: -70, Size: 3)
                addvector(xp: 71, yp: 44, Angle: -90, Size: 3)
                addvector(xp: 7, yp: 20, Angle: 20, Size: 3)
                
                addBlock(xp: 69, yp: 5, xs: 13, ys: 2, type: 6)
                addBlockO(xp: 91.5, yp: 20.5, Size: 16, type: 6)
                addvector(xp: 91.5, yp: 24.5, Angle: 0, Size: 3)
                addvector(xp: 84, yp: 9, Angle: -45, Size: 3)
                addvector(xp: 89, yp: 9, Angle: -45, Size: 3)
                addvector(xp: 94, yp: 9, Angle: -45, Size: 3)
                addvector(xp: 99, yp: 9, Angle: -45, Size: 3)
                
                addgoal(xp: 69.5, yp: 7.5)
                if difficulty == 0 {
                    addBlockO(xp: 10.5, yp: 90.5, Size: 8, type: 7)
                    addDamageO(xp: 0, yp: 84, Size: 9, type: 5, damage: 20, BloclNumber: 1)
                    addmoveAction(xmove: 20, ymove: 0, time: 8.0, BlockNumber: 1, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 16, yp: 94, Size: 11, type: 5, damage: 50)
                    
                    addenemy(xp: 35, yp: 83, type: 15, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlockO(xp: 39.5, yp: 79.5, Size: 8, type: 7)
                    
                    addDamageO(xp: 31, yp: 68, Size: 11, type: 5, damage: 20, BloclNumber: 2)
                    addmoveAction(xmove: 20, ymove: 0, time: 8.0, BlockNumber: 2, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 58, yp: 57, Size: 11, type: 5, damage: 20, BloclNumber: 3,Angle: 90)
                    addmoveAction(xmove: 0, ymove: 20, time: 8.0, BlockNumber: 3, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 51, yp: 79, Size: 11, type: 5, damage: 20, BloclNumber: 4)
                    addmoveAction(xmove: 20, ymove: 0, time: 8.0, BlockNumber: 4, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 70, yp: 67, Size: 11, type: 3, damage: 20, BloclNumber: 5)
                    addrotateAction(dsita: -90, time: 3.0, BlockNumber: 5)
                    
                    addBlockO(xp: 85.5, yp: 56.5, Size: 8, type: 7)
                    addBlockO(xp: 95.5, yp: 49.5, Size: 8, type: 7)
                    
                    addBlockO(xp: 74.5, yp: 39.5, Size: 10, type: 7)
                    addBlockO(xp: 62.5, yp: 37.5, Size: 10, type: 1)
                    addBlockO(xp: 50.5, yp: 37.5, Size: 10, type: 1)
                    addBlockO(xp: 38.5, yp: 37.5, Size: 10, type: 7)
                    addBlockO(xp: 26.5, yp: 26.5, Size: 10, type: 1)
                    addBlockO(xp: 13.5, yp: 26.5, Size: 10, type: 7)
                    addBlockO(xp: 4, yp: 22, Size: 7, type: 6)
                    addBlockO(xp: 9, yp: 17, Size: 7, type: 6)
                    addBlockO(xp: 15.5, yp: 14.5, Size: 6, type: 6)
                    addBlockO(xp: 21.5, yp: 14.5, Size: 6, type: 6)
                    addBlockO(xp: 27.5, yp: 14.5, Size: 6, type: 6)
                    
                    addBlockO(xp: 42.5, yp: 16.5, Size: 6, type: 6)
                    addBlockO(xp: 48.5, yp: 17.5, Size: 6, type: 6)
                    addBlockO(xp: 54.5, yp: 18.5, Size: 6, type: 6)
                    addBlockO(xp: 60.5, yp: 19.5, Size: 6, type: 6)
                    addBlockO(xp: 66.5, yp: 20.5, Size: 6, type: 6)
                    addBlockO(xp: 71.5, yp: 21.5, Size: 4, type: 6)
                    
                    addDamageBlock(xp: 56, yp: 39, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 10)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 10,interval: 1.0)
                    addDamageBlock(xp: 44, yp: 33, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 11)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 11,interval: 1.0)
                    addDamageBlock(xp: 32, yp: 21, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 12)
                    addmoveAction(xmove: 0, ymove: 12, time: 6.0, BlockNumber: 12,interval: 1.0)
                    addDamageBlock(xp: 20, yp: 33, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 13)
                    addmoveAction(xmove: 0, ymove: -12, time: 6.0, BlockNumber: 13,interval: 1.0)
                    
                    addDamageBlock(xp: 83, yp: 0, xs: 8, ys: 2, type: 2, damage: 20,BlockNumber: 14)
                    addDamageBlock(xp: 93, yp: 0, xs: 8, ys: 2, type: 2, damage: 20,BlockNumber: 15)
                    addmoveAction(xmove: 0, ymove: 31, time: 20, BlockNumber: 14, interval: 0, firstinterval: 2.0, type: 3)
                    self.run(SKAction.wait(forDuration: 11.0)){
                        self.addmoveAction(xmove: 0, ymove: 31, time: 20, BlockNumber: 15, interval: 0, firstinterval: 2.0, type: 3)
                    }
                }
                
                if difficulty == 1 {
                    addBlockO(xp: 10.5, yp: 90.5, Size: 6, type: 7)
                    addDamageO(xp: 0, yp: 84, Size: 9, type: 5, damage: 200, BloclNumber: 1)
                    addmoveAction(xmove: 20, ymove: 0, time: 8.0, BlockNumber: 1, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 16, yp: 94, Size: 11, type: 5, damage: 200)
                    
                    addenemy(xp: 35, yp: 83, type: 18, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlockO(xp: 39.5, yp: 79.5, Size: 6, type: 7)
                    
                    addDamageO(xp: 31, yp: 68, Size: 11, type: 5, damage: 200, BloclNumber: 2)
                    addmoveAction(xmove: 20, ymove: 0, time: 8.0, BlockNumber: 2, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 58, yp: 57, Size: 11, type: 5, damage: 200, BloclNumber: 3,Angle: 90)
                    addmoveAction(xmove: 0, ymove: 20, time: 8.0, BlockNumber: 3, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 51, yp: 79, Size: 11, type: 5, damage: 200, BloclNumber: 4)
                    addmoveAction(xmove: 20, ymove: 0, time: 8.0, BlockNumber: 4, interval: 0, firstinterval: 3.0, type: 3)
                    addDamageO(xp: 70, yp: 67, Size: 11, type: 3, damage: 200, BloclNumber: 5)
                    addrotateAction(dsita: -90, time: 3.0, BlockNumber: 5)
                    
                    addBlockO(xp: 85.5, yp: 56.5, Size: 6, type: 7)
                    addBlockO(xp: 94.5, yp: 49.5, Size: 6, type: 7)
                    
                    addBlockO(xp: 74.5, yp: 39.5, Size: 8, type: 7)
                    addBlockO(xp: 62.5, yp: 37.5, Size: 8, type: 1)
                    addBlockO(xp: 50.5, yp: 37.5, Size: 8, type: 1)
                    addBlockO(xp: 38.5, yp: 37.5, Size: 8, type: 7)
                    addBlockO(xp: 26.5, yp: 26.5, Size: 8, type: 1)
                    addBlockO(xp: 14.5, yp: 26.5, Size: 8, type: 7)
                    addBlockO(xp: 3, yp: 22, Size: 7, type: 6)
                    addBlockO(xp: 9, yp: 17, Size: 7, type: 6)
                    addBlockO(xp: 15.5, yp: 14.5, Size: 5, type: 6)
                    addBlockO(xp: 21.5, yp: 14.5, Size: 5, type: 6)
                    addBlockO(xp: 27.5, yp: 14.5, Size: 5, type: 6)
                    
                    addBlockO(xp: 42.5, yp: 16.5, Size: 6, type: 6)
                    addBlockO(xp: 49.5, yp: 18.5, Size: 6, type: 6)
                    addBlockO(xp: 57.5, yp: 20.5, Size: 6, type: 6)
                    addBlockO(xp: 66.5, yp: 22.5, Size: 6, type: 6)
                    
                    addDamageBlock(xp: 56, yp: 39, xs: 2, ys: 2, type: 2, damage: 40,BlockNumber: 10)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 10,interval: 1.0)
                    addDamageBlock(xp: 44, yp: 33, xs: 2, ys: 2, type: 2, damage: 40,BlockNumber: 11)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 11,interval: 1.0)
                    addDamageBlock(xp: 32, yp: 21, xs: 2, ys: 2, type: 2, damage: 40,BlockNumber: 12)
                    addmoveAction(xmove: 0, ymove: 12, time: 6.0, BlockNumber: 12,interval: 1.0)
                    addDamageBlock(xp: 20, yp: 33, xs: 2, ys: 2, type: 2, damage: 40,BlockNumber: 13)
                    addmoveAction(xmove: 0, ymove: -12, time: 6.0, BlockNumber: 13,interval: 1.0)
                    
                    addDamageBlock(xp: 83, yp: 0, xs: 10, ys: 2, type: 2, damage: 50,BlockNumber: 14)
                    addDamageBlock(xp: 91, yp: 0, xs: 10, ys: 2, type: 2, damage: 50,BlockNumber: 15)
                    addmoveAction(xmove: 0, ymove: 31, time: 10, BlockNumber: 14, interval: 0, firstinterval: 2.0, type: 3)
                    self.run(SKAction.wait(forDuration: 6.0)){
                        self.addmoveAction(xmove: 0, ymove: 31, time: 10, BlockNumber: 15, interval: 0, firstinterval: 2.0, type: 3)
                    }
                }
            }
        }
        
        //6_2_7
        if stageNumber == 13{
            if sceneNumber == 0{
                //背景とステージ範囲を設定
                let StageDis:[CGFloat] = [33,25]
                BackGroundImage(imageName: "bg2_2", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 9, py: 5)
                addBlock(xp: 0, yp: 0, xs: 33, ys: 3, type: 6)
                addBlock(xp: 0, yp: 3, xs: 9, ys: 3, type: 6)
                addBlock(xp: 18, yp: 3, xs: 8, ys: 3, type: 6)
                addBlock(xp: 26, yp: 3, xs: 7, ys: 6, type: 6)
                addBlock(xp: 11, yp: 9, xs: 5, ys: 2, type: 6)
                
                if difficulty == 0 {
                    addgoal(xp: 13, yp: 11.5, Goaltype: 2, BlockNumber: 1)
                    addenemy(xp: 30, yp: 11, type: 20, HP: 80, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 1.0, SwitchNumbet: 1, incontact: false)
                }
                if difficulty == 1 {
                    enemymax = 2
                    addgoal(xp: 13, yp: 11.5, Goaltype: 12, BlockNumber: 1)
                    addenemy(xp: 30, yp: 11, type: 20, HP: 120, Damage: 30, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addenemy(xp: 22, yp: 9, type: 14, HP: 20, Damage: 15, direction: false, maxn: 999, interval: 20.0)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 1.0, SwitchNumbet: 1, incontact: false)
                }
            }
        }
    
        
        //6¥第３エリア洞窟
        if stageNumber == 14{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [131,43]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
               
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 73, py: 29)
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0 { additem(xp: 73, yp: 29, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 73, yp: 29, type: 3, number: 11) }
                }

                addBlock(xp: 0, yp: 0, xs: 26, ys: 3, type: 7)
                addBlock(xp: 29, yp: 1, xs: 7, ys: 3, type: 7)
                addBlock(xp: 29, yp: 1, xs: 7, ys: 3, type: 7)
                addBlock(xp: 40, yp: 4, xs: 7, ys: 7, type: 7)
                addBlock(xp: 29, yp: 9, xs: 7, ys: 7, type: 7)
                addBlock(xp: 40, yp: 16, xs: 7, ys: 7, type: 7)
                addBlock(xp: 50, yp: 22, xs: 7, ys: 7, type: 7)
                addBlock(xp: 60, yp: 20, xs: 7, ys: 7, type: 7)
                
                addBlock(xp: 102, yp: 33, xs: 8, ys: 1, type: 7,Angle:45)
                addActionBlockO(xp: 78.5, yp: 37.5, Size: 4, type: 1, time: [4.0,4.0])
                addActionBlockO(xp: 88.5, yp: 37.5, Size: 4, type: 1, time: [4.0,4.0])
                addActionBlockO(xp: 104.5, yp: 40.5, Size: 4, type: 1, time: [10.0,5.0])
                
                addBlock(xp: 118, yp: 29, xs: 7, ys: 3, type: 7)
                addBlock(xp: 127, yp: 34, xs: 4, ys: 4, type: 7)
                addgoal(xp: 129.5, yp: 38.5)
                
                if difficulty == 0{
                    addenemy(xp: 16, yp: 3, type: 22, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 6, type: 21, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 32, yp: 4, type: 23, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 43, yp: 7, type: 23, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 32, yp: 12, type: 23, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 43, yp: 19, type: 23, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 53, yp: 25, type: 24, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 63, yp: 23, type: 23, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 70, yp: 25, xs: 7, ys: 2, type: 7)
                    addBlock(xp: 81, yp: 25, xs: 6, ys: 2, type: 7)
                    addBlock(xp: 91, yp: 25, xs: 6, ys: 2, type: 7)
                    addBlock(xp: 101, yp: 25, xs: 30, ys: 2, type: 7)
                    
                    addenemy(xp: 121, yp: 32, type: 26, HP: 30, Damage: 20, direction: false, maxn: 3, interval: 1.0)
                }
                if difficulty == 1{
                    addenemy(xp: 16, yp: 3, type: 22, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 4, type: 22, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 6, type: 21, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 32, yp: 4, type: 23, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 43, yp: 7, type: 23, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 32, yp: 12, type: 23, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 43, yp: 19, type: 23, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 53, yp: 25, type: 23, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 53, yp: 25, type: 24, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 63, yp: 23, type: 23, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 63, yp: 23, type: 24, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 71, yp: 25, xs: 5, ys: 2, type: 7)
                    addBlock(xp: 81, yp: 25, xs: 6, ys: 2, type: 7)
                    addBlock(xp: 92, yp: 25, xs: 5, ys: 2, type: 7)
                    addBlock(xp: 102, yp: 25, xs: 29, ys: 2, type: 7)
                    addenemy(xp: 84, yp: 30, type: 29, HP: 50, Damage: 25, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 121, yp: 32, type: 26, HP: 30, Damage: 40, direction: false, maxn: 4, interval: 1.0)
                }
            }
        }
        if stageNumber == 15{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12) {
                let StageDis:[CGFloat] = [101,43]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 64, py: 20, DFlag: false)
                    if difficulty == 0 { additem(xp: 28, yp: 25, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 28, yp: 25, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 28, py: 25)
                    if difficulty == 0 { additem(xp: 64, yp: 20, type: 3, number: 11) }
                    if difficulty == 1 { additem(xp: 64, yp: 20, type: 3, number: 11) }
                }else{
                    addplayer(px: 98, py: 9 ,DFlag: false)
                    if difficulty == 0 {
                        additem(xp: 64, yp: 20, type: 3, number: 1)
                        additem(xp: 28, yp: 25, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 64, yp: 20, type: 3, number: 11)
                        additem(xp: 28, yp: 25, type: 3, number: 12)
                    }
                }
         
                addBlock(xp: 61, yp: 0, xs: 7, ys: 18, type: 7)
                addBlock(xp: 68, yp: 0, xs: 26, ys: 4, type: 7)
                addBlock(xp: 94, yp: 0, xs: 7, ys: 7, type: 7)
                addBlockO(xp: 88, yp: 8, Size: 5, type: 9,BloclNumber: 1)
                addBlockO(xp: 88, yp: 10, Size: 5, type: 9,BloclNumber: 2)
                addBlockO(xp: 88, yp: 12, Size: 5, type: 9,BloclNumber: 3)
                addmoveAction(xmove: -16, ymove: 0, time: 4.0, BlockNumber: 1, interval: 0, firstinterval: 4.0, Actiontype: 3)
                addmoveAction(xmove: -16, ymove: 0, time: 4.0, BlockNumber: 2, interval: 0, firstinterval: 2.0, Actiontype: 3)
                addmoveAction(xmove: -16, ymove: 0, time: 4.0, BlockNumber: 3, interval: 0, firstinterval: 0.0, Actiontype: 3)
                ONOFFAction(BlockNumber: 1, SwitchNumber: 1)
                ONOFFAction(BlockNumber: 2, SwitchNumber: 2)
                ONOFFAction(BlockNumber: 3, SwitchNumber: 3)
                addSwitch(xp: 70, yp: 4.5, SwitchNumberA: [1,2,3], SwitchNumberB: [1,2,3])
                
                addBlock(xp: 15, yp: 21, xs: 3, ys: 10, type: 7)
                addBlock(xp: 18, yp: 21, xs: 33, ys: 2, type: 7)
                addBlock(xp: 26, yp: 18, xs: 2, ys: 3, type: 7)
                addBlock(xp: 35, yp: 35, xs: 2, ys: 3, type: 7)
                addBlock(xp: 37, yp: 23, xs: 2, ys: 15, type: 7)
                addBlock(xp: 51, yp: 21, xs: 2, ys: 5, type: 7)
                addBlock(xp: 53, yp: 24, xs: 3, ys: 2, type: 7)
                addBlock(xp: 56, yp: 24, xs: 45, ys: 1, type: 7)
                
                
                addBlock(xp: 36, yp: 5, xs: 1, ys: 2, type: 7)
                addBlock(xp: 19, yp: 12, xs: 2, ys: 2, type: 7)
                
                addBlockO(xp: 55.5, yp: 16.5, Size: 6, type: 9, BloclNumber: 5)
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 5, firstinterval: 3.0, type: 4, SwitchNumber: 5)
                addSwitch(xp: 61.5, yp: 18.5, SwitchNumber: 5)
                
                addBlock(xp: 49, yp: 0, xs: 11, ys: 1, type: 14,BlockNumber: 6)
                addBlock(xp: 48, yp: 0, xs: 1, ys: 3, type: 14,BlockNumber: 7)
                addBlock(xp: 60, yp: 0, xs: 1, ys: 3, type: 14,BlockNumber: 8)
                addSwitch(xp: 54, yp: 1.5, SwitchNumberA: [6,7,8,9,10,11], SwitchNumberB: [6,7,8,9,10,11],BloclNumber: 9)   //停止
                addSwitch(xp: 49.5, yp: 1.5, SwitchNumberA: [12,13,14,15,16,17], SwitchNumberB: [12,13,14,15,16,17],BloclNumber: 10,Angle: -90) //左
                addSwitch(xp: 58.5, yp: 1.5, SwitchNumberA: [18,19,20,21,22,23], SwitchNumberB: [18,19,20,21,22,23],BloclNumber: 11,Angle: 90) //右
               
                addmoveAction(xmove: 0, ymove: 0, time: 5.0, BlockNumber: 6, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 6)
                addmoveAction(xmove: 0, ymove: 0, time: 5.0, BlockNumber: 7, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 7)
                addmoveAction(xmove: 0, ymove: 0, time: 5.0, BlockNumber: 8, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 8)
                addmoveAction(xmove: 0, ymove: 0, time: 5.0, BlockNumber: 9, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 9)
                addmoveAction(xmove: 0, ymove: 0, time: 5.0, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 10)
                addmoveAction(xmove: 0, ymove: 0, time: 5.0, BlockNumber: 11, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 11)
                
                addmoveAction(xmove: -5, ymove: 0, time: 5.0, BlockNumber: 6, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 12)
                addmoveAction(xmove: -5, ymove: 0, time: 5.0, BlockNumber: 7, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 13)
                addmoveAction(xmove: -5, ymove: 0, time: 5.0, BlockNumber: 8, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 14)
                addmoveAction(xmove: -5, ymove: 0, time: 5.0, BlockNumber: 9, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 15)
                addmoveAction(xmove: -5, ymove: 0, time: 5.0, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 16)
                addmoveAction(xmove: -5, ymove: 0, time: 5.0, BlockNumber: 11, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 17)
                
                addmoveAction(xmove: 5, ymove: 0, time: 5.0, BlockNumber: 6, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 18)
                addmoveAction(xmove: 5, ymove: 0, time: 5.0, BlockNumber: 7, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 19)
                addmoveAction(xmove: 5, ymove: 0, time: 5.0, BlockNumber: 8, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 20)
                addmoveAction(xmove: 5, ymove: 0, time: 5.0, BlockNumber: 9, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 21)
                addmoveAction(xmove: 5, ymove: 0, time: 5.0, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 22)
                addmoveAction(xmove: 5, ymove: 0, time: 5.0, BlockNumber: 11, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 23)
                
                addmoveAction(xmove: 0, ymove: 5, time: 5.0, BlockNumber: 6, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 24)
                addmoveAction(xmove: 0, ymove: 5, time: 5.0, BlockNumber: 7, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 25)
                addmoveAction(xmove: 0, ymove: 5, time: 5.0, BlockNumber: 8, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 26)
                addmoveAction(xmove: 0, ymove: 5, time: 5.0, BlockNumber: 9, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 27)
                addmoveAction(xmove: 0, ymove: 5, time: 5.0, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 28)
                addmoveAction(xmove: 0, ymove: 5, time: 5.0, BlockNumber: 11, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 29)
                
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 6, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 30)
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 7, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 31)
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 8, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 32)
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 9, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 33)
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 34)
                addmoveAction(xmove: 0, ymove: -5, time: 5.0, BlockNumber: 11, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 35)
                
                addSwitch(xp: 37.5, yp: 5.5, SwitchNumberA: [24,25,26,27,28,29], SwitchNumberB: [24,25,26,27,28,29],Angle: -90) //上
                addSwitch(xp: 26.5, yp: 16.5, SwitchNumberA: [30,31,32,33,34,35], SwitchNumberB: [30,31,32,33,34,35],Angle: 180) //下
                addSwitch(xp: 19.5, yp: 10.5, SwitchNumberA: [30,31,32,33,34,35], SwitchNumberB: [30,31,32,33,34,35],Angle: 180) //下
                addSwitch(xp: 33.5, yp: 0.5, SwitchNumberA: [24,25,26,27,28,29], SwitchNumberB: [24,25,26,27,28,29]) //上
                addSwitch(xp: 0.5, yp: 3.5, SwitchNumberA: [24,25,26,27,28,29], SwitchNumberB: [24,25,26,27,28,29],Angle: -90) //上
                addSwitch(xp: 0.5, yp: 13.5, SwitchNumberA: [24,25,26,27,28,29], SwitchNumberB: [24,25,26,27,28,29],Angle: -90) //上
                addSwitch(xp: 0.5, yp: 23.5, SwitchNumberA: [24,25,26,27,28,29], SwitchNumberB: [24,25,26,27,28,29],Angle: -90) //上
                
                addvector(xp: 39, yp: 4, Angle: 180, Size: 3)
                addvector(xp: 42, yp: 14, Angle: -90, Size: 3)
                addvector(xp: 29, yp: 16, Angle: 0, Size: 3)
                addvector(xp: 29, yp: 9, Angle: -90, Size: 3)
                addvector(xp: 17, yp: 10, Angle: 0, Size: 3)
                addvector(xp: 1, yp: 2, Angle: 180, Size: 3)
                addvector(xp: 1, yp: 12, Angle: 180, Size: 3)
                addvector(xp: 1, yp: 22, Angle: 180, Size: 3)
                addvector(xp: 7, yp: 27, Angle: 135, Size: 3)
                addvector(xp: 1, yp: 32, Angle: 90, Size: 3)
                addvector(xp: 7, yp: 32, Angle: 90, Size: 3)
                addvector(xp: 13, yp: 32, Angle: 90, Size: 3)
                addBlock(xp: 18, yp: 35, xs: 3, ys: 8, type: 7)
                addBlock(xp: 21, yp: 29, xs: 3, ys: 14, type: 7)
                
                if skillGet[8] == false{ additem(xp: 21, yp: 23, type: 1, number: 8) }
                
                addBlock(xp: 42, yp: 26, xs: 2, ys: 17, type: 7)
                addBlock(xp: 84, yp: 31, xs: 6, ys: 7, type: 7)
                addgoal(xp: 88.5, yp: 39.5)
                addvector(xp: 55, yp: 33, Angle: 135, Size: 3)
                addvector(xp: 71, yp: 29, Angle: 90, Size: 3)
                addvector(xp: 82, yp: 35, Angle: 180, Size: 3)
                
                if difficulty == 0{
                    addenemy(xp: 72, yp: 15, type: 25, HP: 10, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 73, yp: 7, type: 25, HP: 10, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 80, yp: 8, type: 25, HP: 10, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 86, yp: 7, type: 25, HP: 10, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 88, yp: 15, type: 25, HP: 10, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 23, yp: 0, xs: 13, ys: 7, type: 2, damage: 25)
                    addDamageBlock(xp: 35, yp: 0, xs: 3, ys: 5, type: 2, damage: 25)
                    addDamageBlock(xp: 35, yp: 7, xs: 3, ys: 5, type: 2, damage: 25)
                    addDamageBlock(xp: 12, yp: 4, xs: 2, ys: 17, type: 2, damage: 25)
                    addDamageBlock(xp: 14, yp: 12, xs: 9, ys: 9, type: 2, damage: 25)
                    addDamageBlock(xp: 23, yp: 18, xs: 26, ys: 3, type: 2, damage: 25)
                    addDamageBlock(xp: 0, yp: 8, xs: 2, ys: 2, type: 2, damage: 15,BlockNumber: 12)
                    addDamageBlock(xp: 10, yp: 18, xs: 2, ys: 2, type: 2, damage: 15,BlockNumber: 13)
                    addmoveAction(xmove: 10, ymove: 0, time: 5.0, BlockNumber: 12,interval: 1.0)
                    addmoveAction(xmove: -10, ymove: 0, time: 5.0, BlockNumber: 13,interval: 1.0)
                    
                    addDamageBlock(xp: 0, yp: 40, xs: 18, ys: 3, type: 2, damage: 50)
                    addDamageBlock(xp: 15, yp: 37, xs: 3, ys: 3, type: 2, damage: 50)
                    addBar(xp: 30, yp: 26)
                    addBar(xp: 30, yp: 32)
                    addBar(xp: 30, yp: 38)
                    
                    addDamageBlock(xp: 60, yp: 26, xs: 3, ys: 5, type: 2, damage: 20)
                    addDamageBlock(xp: 71, yp: 33, xs: 3, ys: 10, type: 2, damage: 20)
                    
                    addBlock(xp: 70, yp: 33, xs: 1, ys: 6, type: 7)
                    
                    addDamageBlock(xp: 56, yp: 25, xs: 9, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 72, yp: 25, xs: 29, ys: 1, type: 3, damage: 50)
                    
                    addBar(xp: 53, yp: 30)
                    addBar(xp: 57, yp: 33)
                    addBar(xp: 61, yp: 34)
                    addBar(xp: 68, yp: 29)
                    addBar(xp: 74, yp: 29)
                    addBar(xp: 79, yp: 29)
                    
                    addvector(xp: 64, yp: 34, Angle: 90, Size: 3)
                    addvector(xp: 81, yp: 31, Angle: 135, Size: 3)
                    
                }
                if difficulty == 1{
                    addenemy(xp: 72, yp: 15, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 73, yp: 7, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 80, yp: 8, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 80, yp: 14, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 86, yp: 7, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 88, yp: 15, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addDamageO(xp: 72, yp: 9, Size: 9, type: 5, damage: 200,Angle:90)
                    
                    addDamageBlock(xp: 48, yp: 4, xs: 13, ys: 3, type: 2, damage: 200, BlockNumber: 4)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 4, type: 4, outtime: 0.0, SwitchNumbet: 4)
                    addSwitch(xp: 59.5, yp: 9.5, SwitchNumber: 4,Angle: 90)
                    
                    addDamageBlock(xp: 23, yp: 4, xs: 13, ys: 3, type: 2, damage: 200)
                    addDamageBlock(xp: 35, yp: 0, xs: 3, ys: 5, type: 2, damage: 200)
                    addDamageBlock(xp: 35, yp: 7, xs: 3, ys: 5, type: 2, damage: 200)
                    addDamageBlock(xp: 12, yp: 4, xs: 2, ys: 17, type: 2, damage: 200)
                    addDamageBlock(xp: 14, yp: 12, xs: 9, ys: 9, type: 2, damage: 200)
                    addDamageBlock(xp: 23, yp: 18, xs: 26, ys: 3, type: 2, damage: 200)
                    addDamageBlock(xp: 0, yp: 8, xs: 3, ys: 3, type: 2, damage: 50,BlockNumber: 12)
                    addDamageBlock(xp: 9, yp: 18, xs: 3, ys: 3, type: 2, damage: 50,BlockNumber: 13)
                    addmoveAction(xmove: 10, ymove: 0, time: 5.0, BlockNumber: 12,interval: 1.0)
                    addmoveAction(xmove: -10, ymove: 0, time: 5.0, BlockNumber: 13,interval: 1.0)
                    
                    addDamageBlock(xp: 0, yp: 36, xs: 18, ys: 7, type: 2, damage: 200)
                    
                    addDamageBlock(xp: 24, yp: 29, xs: 2, ys: 2, type: 2, damage: 40,BlockNumber: 14)
                    addDamageBlock(xp: 35, yp: 29, xs: 2, ys: 2, type: 2, damage: 40,BlockNumber: 15)
                    addmoveAction(xmove: 11, ymove: 0, time: 5.0, BlockNumber: 14)
                    addmoveAction(xmove: -11, ymove: 0, time: 5.0, BlockNumber: 15)
                    addBar(xp: 30, yp: 26)
                    addBar(xp: 30, yp: 34)
                    
                    addDamageBlock(xp: 57, yp: 26, xs: 1, ys: 1, type: 2, damage: 200)
                    addDamageBlock(xp: 58, yp: 26, xs: 2, ys: 3, type: 2, damage: 200)
                    addDamageBlock(xp: 60, yp: 26, xs: 3, ys: 5, type: 2, damage: 200)
                    addDamageBlock(xp: 63, yp: 26, xs: 2, ys: 3, type: 2, damage: 200)
                    addDamageBlock(xp: 65, yp: 26, xs: 1, ys: 1, type: 2, damage: 200)
                    addDamageBlock(xp: 71, yp: 33, xs: 3, ys: 10, type: 2, damage: 200)
                    
                    addDamageBlock(xp: 56, yp: 25, xs: 45, ys: 1, type: 3, damage: 200)
                    
                    addBar(xp: 53, yp: 30)
                    addBar(xp: 61, yp: 34)
                    addBar(xp: 68, yp: 29)
                    addBar(xp: 77, yp: 29)
                    addvector(xp: 63, yp: 33, Angle: 60, Size: 3)
                    addvector(xp: 79, yp: 31, Angle: 135, Size: 3)
                    addvector(xp: 82, yp: 35, Angle: 180, Size: 3)
                }
            }
        }
        if stageNumber == 16{
            if (0 <= sceneNumber && sceneNumber <= 3) || (11 <= sceneNumber && sceneNumber <= 13){
                let StageDis:[CGFloat] = [98,40]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
            
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 39, py: 8, DFlag: false)
                    if difficulty == 0 {
                        additem(xp: 10, yp: 29, type: 3, number: 2)
                        additem(xp: 54, yp: 30, type: 3, number: 3)
                    }
                    if difficulty == 1 {
                        additem(xp: 10, yp: 29, type: 3, number: 12)
                        additem(xp: 54, yp: 32, type: 3, number: 13)
                    }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 10, py: 29)
                    if difficulty == 0 {
                        additem(xp: 39, yp: 8, type: 3, number: 1)
                        additem(xp: 54, yp: 30, type: 3, number: 3)
                    }
                    if difficulty == 1 {
                        additem(xp: 39, yp: 8, type: 3, number: 11)
                        additem(xp: 54, yp: 32, type: 3, number: 13)
                    }

                }else if sceneNumber == 3 || sceneNumber == 13{
                    addplayer(px: 54, py: 31)
                    if difficulty == 0 {
                        additem(xp: 10, yp: 29, type: 3, number: 2)
                        additem(xp: 39, yp: 8, type: 3, number: 1)
                    }
                    if difficulty == 1 {
                        additem(xp: 10, yp: 29, type: 3, number: 12)
                        additem(xp: 39, yp: 8, type: 3, number: 11)
                    }
                }else{
                    addplayer(px: 95, py: 4,DFlag: false)
                    if difficulty == 0 {
                        additem(xp: 39, yp: 8, type: 3, number: 1)
                        additem(xp: 10, yp: 29, type: 3, number: 2)
                        additem(xp: 54, yp: 30, type: 3, number: 3)
                    }
                    if difficulty == 1 {
                        additem(xp: 39, yp: 8, type: 3, number: 11)
                        additem(xp: 10, yp: 29, type: 3, number: 12)
                        additem(xp: 54, yp: 32, type: 3, number: 13)
                    }
                }

                addBlock(xp: 37, yp: 0, xs: 6, ys: 6, type: 7)
                addBlock(xp: 43, yp: 0, xs: 39, ys: 2, type: 7)
                addBlock(xp: 82, yp: 0, xs: 16, ys: 3, type: 7)
                addBlock(xp: 94, yp: 6, xs: 4, ys: 2, type: 7)
                addBlock(xp: 71, yp: 8, xs: 6, ys: 4, type: 7)
                addBlockO(xp: 86, yp: 8, Size: 5, type: 10,BloclNumber: 1)
                addmoveAction(xmove: -10, ymove: 0, time: 5, BlockNumber: 1, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 1)
                addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 1, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 2)
                addmoveAction(xmove: 0, ymove: 0, time: 5, BlockNumber: 1, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 3)
                addSwitch(xp: 83.5, yp: 3.5, SwitchNumberA: 1, SwitchNumberB: 3)
                addSwitch(xp: 96.5, yp: 8.5, SwitchNumberA: 2, SwitchNumberB: 2)
                addSwitch(xp: 61.5, yp: 3.5, SwitchNumberA: 3, SwitchNumberB: 1)
                
                addBlockO(xp: 11, yp: 8, Size: 5, type: 9)
                addBlockO(xp: 11, yp: 12, Size: 5, type: 9)
                addBlockO(xp: 18, yp: 13, Size: 5, type: 9)
                addBlockO(xp: 19, yp: 9, Size: 5, type: 9)
                addBlockO(xp: 24, yp: 6, Size: 5, type: 9)
                addBlockO(xp: 25, yp: 11, Size: 5, type: 9)
                addBlockO(xp: 32, yp: 13, Size: 5, type: 9)
                addBlockO(xp: 32, yp: 5, Size: 5, type: 9)
                addSwitch(xp: 18, yp: 14.5, SwitchNumber: 4)
                
                addBlock(xp: 7, yp: 21, xs: 12, ys: 6, type: 7)
                addBlock(xp: 19, yp: 21, xs: 12, ys: 5, type: 7)
                addBlock(xp: 31, yp: 21, xs: 12, ys: 7, type: 7)
                addBlock(xp: 43, yp: 21, xs: 8, ys: 1, type: 7)
                addBlock(xp: 50, yp: 21, xs: 8, ys: 5, type: 7)
                addBlock(xp: 58, yp: 21, xs: 19, ys: 4, type: 7)
                addBlock(xp: 37, yp: 12, xs: 1, ys: 9, type: 7)
                addBlock(xp: 38, yp: 12, xs: 60, ys: 1, type: 7)
                
                addBlock(xp: 84, yp: 18, xs: 14, ys: 2, type: 7)
                addvector(xp: 46, yp: 29, Angle: 135, Size: 4)
                
                addBlockO(xp: 15, yp: 30, Size: 5, type: 10,BloclNumber: 10)
                addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 10)
                addmoveAction(xmove: -10, ymove: 0, time: 5, BlockNumber: 10, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 11)
                addSwitch(xp: 17.5, yp: 27.5, SwitchNumberA: 10, SwitchNumberB: 11)
                addBlockO(xp: 54, yp: 29, Size: 5, type: 10,BloclNumber: 12)
                addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 12, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 12)  //右
                addmoveAction(xmove: -10, ymove: 0, time: 5, BlockNumber: 12, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 13) //左
                addmoveAction(xmove: 20, ymove: 0, time: 5, BlockNumber: 12, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 14)  //右速
                addmoveAction(xmove: 0, ymove: 0, time: 5, BlockNumber: 12, firstinterval: 0.0, type: 4, Actiontype: 2, SwitchNumber: 15)   //停止
                addSwitch(xp: 56.5, yp: 26.5, SwitchNumberA: 12, SwitchNumberB: 13)
                addSwitch(xp: 72, yp: 26.5, SwitchNumber: 14)
                addSwitch(xp: 48, yp: 14.5, SwitchNumberA: 15, SwitchNumberB: 13)
                addSwitch(xp: 55, yp: 14.5, SwitchNumberA: 15, SwitchNumberB: 13)
                addSwitch(xp: 62.5, yp: 14.5, SwitchNumberA: 15, SwitchNumberB: 13)
                addSwitch(xp: 69.5, yp: 14.5, SwitchNumberA: 15, SwitchNumberB: 13)
        
                addgoal(xp: 38.5, yp: 17.5)
                
                if difficulty == 0 {
                    addDamageBlock(xp: 43, yp: 2, xs: 39, ys: 1, type: 3, damage: 50)
                    
                    addDamageBlock(xp: 77, yp: 3, xs: 2, ys: 3, type: 2, damage: 20,BlockNumber: 2)
                    addDamageBlock(xp: 54, yp: 3, xs: 4, ys: 3, type: 2, damage: 20,BlockNumber: 3)
                    addmoveAction(xmove: 0, ymove: 6, time: 6.0, BlockNumber: 2)
                    addmoveAction(xmove: 0, ymove: 6, time: 6.0, BlockNumber: 3)
                    
                    addBlockO(xp: 14, yp: 4, Size: 5, type: 9)
                    addBlockO(xp: 21, yp: 2, Size: 5, type: 9)
                    addBlockO(xp: 28, yp: 1, Size: 5, type: 9)
                    addBlockO(xp: 3, yp: 9, Size: 7, type: 9,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: 16, time: 10.0, BlockNumber: 4,interval: 3.0, SwitchNumber: 4)
                    
                    addenemy(xp: 7, yp: 13, type: 26, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 7, yp: 6, type: 25, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 13, yp: 15, type: 25, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 10, type: 25, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 19, yp: 5, type: 25, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 14, type: 25, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 8, type: 25, HP: 20, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 19, yp: 26, xs: 12, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 31, yp: 28, xs: 12, ys: 1, type: 3, damage: 50)
                    
                    addDamageO(xp: 25.5, yp: 26.5, Size: 14, type: 3, damage: 20,BloclNumber: 5,Angle: 90)
                    addrotateAction(dsita: 45, time: 9.0, BlockNumber: 5, interval: 1.0, firstinterval: 1.0,type: 3)
                    
                    addDamageBlock(xp: 43, yp: 22, xs: 7, ys: 3, type: 2, damage: 25)
                    addDamageBlock(xp: 58, yp: 25, xs: 19, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 38, yp: 13, xs: 60, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 84, yp: 20, xs: 14, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 84, yp: 14, xs: 14, ys: 4, type: 2, damage: 50)
                    addDamageBlock(xp: 96, yp: 21, xs: 2, ys: 11, type: 2, damage: 50)
                    addSwitch(xp: 92, yp: 21.5, SwitchNumber: 13)
                    
                    addDamageBlock(xp: 44, yp: 19, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 6)
                    addmoveAction(xmove: 0, ymove: -5, time: 4.0, BlockNumber: 6)
                    addDamageBlock(xp: 51, yp: 19, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 7)
                    addmoveAction(xmove: 0, ymove: -5, time: 4.0, BlockNumber: 7)
                    addDamageBlock(xp: 58, yp: 19, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 8)
                    addmoveAction(xmove: 0, ymove: -5, time: 4.0, BlockNumber: 8)
                    addDamageBlock(xp: 66, yp: 14, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 9)
                    addmoveAction(xmove: 0, ymove: 5, time: 4.0, BlockNumber: 9)
                }
                
                if difficulty == 1 {
                    addDamageBlock(xp: 43, yp: 2, xs: 39, ys: 1, type: 3, damage: 200)
                    
                    addDamageBlock(xp: 77, yp: 3, xs: 3, ys: 3, type: 2, damage: 50,BlockNumber: 2)
                    addDamageBlock(xp: 53, yp: 3, xs: 5, ys: 3, type: 2, damage: 50,BlockNumber: 3)
                    addmoveAction(xmove: 0, ymove: 6, time: 6.0, BlockNumber: 2)
                    addmoveAction(xmove: 0, ymove: 6, time: 6.0, BlockNumber: 3)
                    
                    addBlockO(xp: 3, yp: 9, Size: 5, type: 9,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: 16, time: 10.0, BlockNumber: 4,interval: 0, SwitchNumber: 4)
                    
                    addenemy(xp: 7, yp: 13, type: 26, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 7, yp: 6, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 13, yp: 15, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 10, type: 29, HP: 50, Damage: 25, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 19, yp: 5, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 14, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 8, type: 25, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 19, yp: 26, xs: 12, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 31, yp: 28, xs: 12, ys: 1, type: 3, damage: 200)
                    
                    addDamageO(xp: 25.5, yp: 26.5, Size: 14, type: 3, damage: 20,BloclNumber: 5)
                    addrotateAction(dsita: -90, time: 18.0, BlockNumber: 5, interval: 0.0, firstinterval: 0.0)
                    
                    addDamageBlock(xp: 43, yp: 22, xs: 7, ys: 3, type: 2, damage: 200)
                    addDamageBlock(xp: 58, yp: 25, xs: 19, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 38, yp: 13, xs: 60, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 84, yp: 20, xs: 14, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 84, yp: 14, xs: 14, ys: 4, type: 2, damage: 200)
                    addDamageBlock(xp: 92, yp: 21, xs: 6, ys: 11, type: 2, damage: 200)
                    addSwitch(xp: 90, yp: 21.5, SwitchNumber: 13)
                    
                    addDamageBlock(xp: 44, yp: 19, xs: 3, ys: 2, type: 2, damage: 40,BlockNumber: 6)
                    addmoveAction(xmove: 0, ymove: -5, time: 4.0, BlockNumber: 6)
                    addDamageBlock(xp: 50, yp: 19, xs: 3, ys: 2, type: 2, damage: 40,BlockNumber: 7)
                    addmoveAction(xmove: 0, ymove: -5, time: 4.0, BlockNumber: 7)
                    addDamageBlock(xp: 58, yp: 19, xs: 3, ys: 2, type: 2, damage: 40,BlockNumber: 8)
                    addmoveAction(xmove: 0, ymove: -5, time: 4.0, BlockNumber: 8)
                    addDamageBlock(xp: 65, yp: 14, xs: 3, ys: 2, type: 2, damage: 40,BlockNumber: 9)
                    addmoveAction(xmove: 0, ymove: 5, time: 4.0, BlockNumber: 9)
                }
            }
        }
        if stageNumber == 17{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){
                let StageDis:[CGFloat] = [120,55]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 34, py: 50)
                    if difficulty == 0 { additem(xp: 98, yp: 52, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 98, yp: 52, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 98, py: 52)
                    if difficulty == 0 { additem(xp: 34, yp: 50, type: 3, number: 1)  }
                    if difficulty == 1 { additem(xp: 34, yp: 50, type: 3, number: 11)  }
                }else{
                    addplayer(px: 1, py: 4)
                    if difficulty == 0 {
                        additem(xp: 34, yp: 50, type: 3, number: 1)
                        additem(xp: 98, yp: 52, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 34, yp: 50, type: 3, number: 11)
                        additem(xp: 98, yp: 52, type: 3, number: 12)
                    }
                }

                addBlock(xp: 0, yp: 0, xs: 15, ys: 3, type: 7)

                addBlock(xp: 3, yp: 15, xs: 5, ys: 5, type: 7)
                addBlock(xp: 11, yp: 10, xs: 5, ys: 5, type: 7)
                addBlock(xp: 11, yp: 19, xs: 5, ys: 5, type: 7)
                addBlock(xp: 17, yp: 3, xs: 5, ys: 5, type: 7)
                addBlock(xp: 20, yp: 14, xs: 5, ys: 5, type: 7)
                addBlock(xp: 25, yp: 5, xs: 5, ys: 5, type: 7)
                addBlock(xp: 30, yp: 12, xs: 5, ys: 5, type: 7)
                addBlock(xp: 33, yp: 2, xs: 5, ys: 5, type: 7)
                addBlock(xp: 0, yp: 46, xs: 16, ys: 2, type: 7)
                addBlock(xp: 14, yp: 48, xs: 2, ys: 7, type: 7)
                addBlock(xp: 21, yp: 46, xs: 17, ys: 2, type: 7)
                addBlock(xp: 38, yp: 0, xs: 2, ys: 48, type: 7)
                addBlock(xp: 6, yp: 39, xs: 10, ys: 2, type: 7)
                addBlock(xp: 21, yp: 39, xs: 10, ys: 2, type: 7)
                addBlock(xp: 17, yp: 42, xs: 3, ys: 1, type: 7)
                addBar(xp: 2, yp: 39)
                addBar(xp: 2, yp: 32)
                addBar(xp: 6, yp: 35)
                addBar(xp: 7, yp: 29)
                addBar(xp: 12, yp: 26)
                addBar(xp: 14, yp: 31)
                addBar(xp: 18, yp: 39)
                addBar(xp: 18, yp: 28)
                addBar(xp: 19, yp: 35)
                addBar(xp: 22, yp: 23)
                addBar(xp: 28, yp: 24)
                addBar(xp: 32, yp: 28)
                addBar(xp: 34, yp: 39)
                addBar(xp: 35, yp: 34)

                if skillGet[4] == false{ additem(xp: 18, yp: 44, type: 1, number: 4)   }
                
                addBlock(xp: 69, yp: 30, xs: 10, ys: 2, type: 7)
                addBlockO(xp: 42.5, yp: 43.5, Size: 6, type: 11, Angle: -30)
                addWater(xp: 40, yp: 26, Size: 2, Pattern: 2)
                addBar(xp: 63, yp: 34)
                addvector(xp: 60, yp: 34.5, Angle: 90, Size: 3)
                addvector(xp: 67, yp: 34.5, Angle: 90, Size: 3)
                
                addBlock(xp: 84, yp: 50, xs: 17, ys: 1, type: 7)
                addBlock(xp: 110, yp: 50, xs: 10, ys: 1, type: 7)
                addBar(xp: 81, yp: 34)
                addBar(xp: 81, yp: 40)
                addBar(xp: 81, yp: 46)
                addBar(xp: 81, yp: 52)
                addvector(xp: 81, yp: 37, Angle: 180, Size: 3)
                addvector(xp: 81, yp: 43, Angle: 180, Size: 3)
                addvector(xp: 81, yp: 48, Angle: 180, Size: 3)
                additem(xp: 118, yp: 51, type: 2, number: 2)
                
                addBlockO(xp: 105, yp: 49, Size: 9, type: 7)
                addvector(xp: 105, yp: 52, Angle: 0, Size: 3)
                
                addBlock(xp: 40, yp: 7, xs: 61, ys: 1, type: 7)
                addDamageBlock(xp: 40, yp: 8, xs: 61, ys: 1, type: 3, damage: 50)
                
                addvector(xp: 104, yp: 5, Angle: -90, Size: 3)
                addBlock(xp: 84, yp: 0, xs: 16, ys: 2, type: 7)
                addgoal(xp: 84.5, yp: 2.5)
                
                if difficulty == 0{
                    addBar(xp: 12, yp: 35)
                    addBar(xp: 24, yp: 28)
                    addBar(xp: 25, yp: 35)
                    addBar(xp: 21, yp: 31)
                    addBar(xp: 29, yp: 32)
                    addenemy(xp: 3, yp: 21, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 10, yp: 31, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 12, yp: 8, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 17, yp: 17, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 31, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 11, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 35, yp: 26, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 35, yp: 1, type: 27, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 49, yp: 41, type: 21, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 54, yp: 38, type: 21, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 76.5, yp: 36, Size: 2, type: 1, damage: 20,BloclNumber: 1)
                    addDamageO(xp: 85.5, yp: 42, Size: 2, type: 1, damage: 20,BloclNumber: 2)
                    addDamageO(xp: 76.5, yp: 48, Size: 2, type: 1, damage: 20,BloclNumber: 3)
                    addmoveAction(xmove: 9, ymove: 0, time: 4.0, BlockNumber: 1)
                    addmoveAction(xmove: -9, ymove: 0, time: 4.0, BlockNumber: 2)
                    addmoveAction(xmove: 9, ymove: 0, time: 4.0, BlockNumber: 3)
                    
                    addenemy(xp: 97, yp: 42, type: 28, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 34, type: 28, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 21, type: 28, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 12, type: 28, HP: 10, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 46, type: 28, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 29, type: 28, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 12, type: 28, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addenemy(xp: 3, yp: 21, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 10, yp: 31, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 12, yp: 8, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 17, yp: 17, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 19, yp: 24, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 31, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 11, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 20, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 35, yp: 26, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 35, yp: 1, type: 27, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 49, yp: 41, type: 21, HP: 20, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 52, yp: 40, type: 21, HP: 20, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 54, yp: 38, type: 21, HP: 20, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 56, yp: 39, type: 21, HP: 20, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 76.5, yp: 37, Size: 2, type: 1, damage: 50,BloclNumber: 1)
                    addDamageO(xp: 85.5, yp: 43, Size: 2, type: 1, damage: 50,BloclNumber: 2)
                    addDamageO(xp: 76.5, yp: 48.5, Size: 2, type: 1, damage: 50,BloclNumber: 3)
                    addDamageO(xp: 85.5, yp: 48.5, Size: 2, type: 1, damage: 50,BloclNumber: 4)
                    addmoveAction(xmove: 9, ymove: 0, time: 4.0, BlockNumber: 1)
                    addmoveAction(xmove: -9, ymove: 0, time: 4.0, BlockNumber: 2)
                    addmoveAction(xmove: 9, ymove: 0, time: 4.0, BlockNumber: 3)
                    addmoveAction(xmove: -9, ymove: 0, time: 4.0, BlockNumber: 4)
                    
                    addenemy(xp: 97, yp: 42, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 34, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 26, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 21, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 12, type: 29, HP: 50, Damage: 25, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 46, type: 28, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 38, type: 28, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 29, type: 28, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 18, type: 28, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 113, yp: 12, type: 29, HP: 50, Damage: 25, direction: false, maxn: 1, interval: 1.0)
                }
            }
        }
        if stageNumber == 18{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){
                let StageDis:[CGFloat] = [101,47]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 24, py: 19)
                    if difficulty == 0{ additem(xp: 88, yp: 18, type: 3, number: 2) }
                    if difficulty == 1{ additem(xp: 88, yp: 18, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 88, py: 18)
                    if difficulty == 0{ additem(xp: 24, yp: 19, type: 3, number: 1) }
                    if difficulty == 1{ additem(xp: 24, yp: 19, type: 3, number: 11) }
                }else{
                    addplayer(px: 98, py: 5,DFlag: false)
                    if difficulty == 0{
                        additem(xp: 24, yp: 19, type: 3, number: 11)
                        additem(xp: 88, yp: 18, type: 3, number: 12)
                    }
                    if difficulty == 1{
                        additem(xp: 24, yp: 19, type: 3, number: 11)
                        additem(xp: 88, yp: 18, type: 3, number: 12)
                    }
                }
                
                addBlock(xp: 90, yp: 0, xs: 11, ys: 3, type: 14)
                addBlockO(xp: 24, yp: 15, Size: 9, type: 9)
                addBlockO(xp: 37, yp: 15, Size: 9, type: 9,Angle: -20)
                addBlockO(xp: 46, yp: 24, Size: 9, type: 9,Angle: 20)
                addBlockO(xp: 70, yp: 5, Size: 9, type: 9,Angle: -20)
                addBlockO(xp: 77, yp: 13, Size: 9, type: 9,Angle: 180)
                addBlockO(xp: 83, yp: 3, Size: 9, type: 9)
                addBlockO(xp: 83, yp: 32, Size: 9, type: 9)
                
                addBar(xp: 38, yp: 27)
                addBar(xp: 45, yp: 18)
                addBar(xp: 52, yp: 19)
                addBar(xp: 71, yp: 20)
                addBar(xp: 79, yp: 20)
                addvector(xp: 30, yp: 19, Angle: 90, Size: 3)
                addvector(xp: 38, yp: 30, Angle: 180, Size: 3)
                addvector(xp: 48, yp: 19, Angle: 110, Size: 3)
                addvector(xp: 55, yp: 20, Angle: 110, Size: 3)
                addvector(xp: 73, yp: 20, Angle: 110, Size: 3)
                addvector(xp: 81, yp: 19, Angle: 60, Size: 3)
                addvector(xp: 96, yp: 17, Angle: 180, Size: 3)
                addActionBlockO(xp: 44, yp: 33, Size: 5, type: 1, time: [20,15])
                addActionBlockO(xp: 74, yp: 27, Size: 5, type: 1, time: [20,15])
                addBlock(xp: 0, yp: 34, xs: 35, ys: 2, type: 14)
                addBlock(xp: 41, yp: 34, xs: 1, ys: 13, type: 14)
                
                if difficulty == 0{
                    addBlockO(xp: 24, yp: 6, Size: 9, type: 9,BloclNumber: 1)
                    addmoveAction(xmove: -11, ymove: 9, time: 6.0, BlockNumber: 1,interval: 3.0)
                    addBlockO(xp: 35, yp: 6, Size: 9, type: 9)
                    
                    addBlockO(xp: 46, yp: 8, Size: 9, type: 9)
                    addBlockO(xp: 59, yp: 7, Size: 9, type: 9)
                    addBlockO(xp: 63, yp: 17, Size: 9, type: 9)
                    addBlockO(xp: 88, yp: 14, Size: 9, type: 9)
                    addBlockO(xp: 96, yp: 15, Size: 9, type: 9,BloclNumber: 2)
                    addmoveAction(xmove: 0, ymove: 17, time: 10.0, BlockNumber: 2,interval: 3.0)
                    
                    addBlockO(xp: 53, yp: 25, Size: 9, type: 9)
                    addBlockO(xp: 62, yp: 28, Size: 9, type: 9,Angle: 10)
                    addBlockO(xp: 71, yp: 32, Size: 9, type: 9,Angle: 10)
                    
                    addenemy(xp: 52, yp: 37, type: 28, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 67, yp: 41, type: 28, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 80, yp: 41, type: 28, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 53, yp: 31, type: 26, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 67, yp: 36, type: 26, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addBar(xp: 38, yp: 32)
                    
                    addDamageO(xp: 7.5, yp: 36.5, Size: 2, type: 1, damage: 30, BloclNumber: 3)
                    addmoveAction(xmove: 9, ymove: 9, time: 3.0, BlockNumber: 3)
                    addDamageO(xp: 7.5, yp: 45.5, Size: 2, type: 1, damage: 30, BloclNumber: 4)
                    addmoveAction(xmove: 9, ymove: -9, time: 3.0, BlockNumber: 4)
                    addDamageO(xp: 25.5, yp: 36.5, Size: 2, type: 1, damage: 30, BloclNumber: 5)
                    addmoveAction(xmove: -9, ymove: 9, time: 3.0, BlockNumber: 5)
                    addDamageO(xp: 25.5, yp: 45.5, Size: 2, type: 1, damage: 30, BloclNumber: 6)
                    addmoveAction(xmove: -9, ymove: -9, time: 3.0, BlockNumber: 6)
                    
                    addmoveStageO(xp: 0.5, yp: 36.5, Size: 2, moveStageN: 18, moveSceneN: 3, type: 2)
                    
                }
                if difficulty == 1{
                    addBlockO(xp: 24, yp: 6, Size: 9, type: 9,BloclNumber: 1,Angle: -20)
                    addmoveAction(xmove: -11, ymove: 9, time: 6.0, BlockNumber: 1,interval: 0)
                    addBlockO(xp: 35, yp: 6, Size: 9, type: 9 , Angle: 20)
                    
                    addBlockO(xp: 46, yp: 8, Size: 9, type: 9,Angle: -20)
                    addBlockO(xp: 59, yp: 7, Size: 9, type: 9,Angle: 20)
                    addBlockO(xp: 63, yp: 17, Size: 9, type: 9,Angle: -20)
                    addBlockO(xp: 88, yp: 14, Size: 9, type: 9)
                    addBlockO(xp: 96, yp: 15, Size: 7, type: 9,BloclNumber: 2)
                    addmoveAction(xmove: 0, ymove: 17, time: 10.0, BlockNumber: 2)
                    
                    addBlockO(xp: 53, yp: 25, Size: 8, type: 9,Angle: 20)
                    addBlockO(xp: 62, yp: 28, Size: 8, type: 9,Angle: 20)
                    addBlockO(xp: 71, yp: 32, Size: 8, type: 9,Angle: 20)
                    
                    addenemy(xp: 52, yp: 34, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 67, yp: 38, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 80, yp: 39, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 97, yp: 37, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 53, yp: 31, type: 26, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 59, yp: 34, type: 26, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 59, yp: 37, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 67, yp: 36, type: 26, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addBar(xp: 38, yp: 34)
                    
                    addDamageO(xp: 7.5, yp: 36.5, Size: 2, type: 1, damage: 50, BloclNumber: 3)
                    addmoveAction(xmove: 9, ymove: 9, time: 3.0, BlockNumber: 3)
                    addDamageO(xp: 7.5, yp: 45.5, Size: 2, type: 1, damage: 50, BloclNumber: 4)
                    addmoveAction(xmove: 9, ymove: -9, time: 3.0, BlockNumber: 4)
                    addDamageO(xp: 25.5, yp: 36.5, Size: 2, type: 1, damage: 50, BloclNumber: 5)
                    addmoveAction(xmove: -9, ymove: 9, time: 3.0, BlockNumber: 5)
                    addDamageO(xp: 25.5, yp: 45.5, Size: 2, type: 1, damage: 50, BloclNumber: 6)
                    addmoveAction(xmove: -9, ymove: -9, time: 3.0, BlockNumber: 6)
                    addDamageO(xp: 7.5, yp: 36.5, Size: 2, type: 1, damage: 50, BloclNumber: 7)
                    addmoveAction(xmove: 0, ymove: 9, time: 2.0, BlockNumber: 7)
                    addDamageO(xp: 15.5, yp: 45.5, Size: 2, type: 1, damage: 50, BloclNumber: 8)
                    addmoveAction(xmove: 0, ymove: -9, time: 2.0, BlockNumber: 8)
                    addDamageO(xp: 25.5, yp: 36.5, Size: 2, type: 1, damage: 50, BloclNumber: 9)
                    addmoveAction(xmove: 0, ymove: 9, time: 2.0, BlockNumber: 9)
                    
                    addmoveStageO(xp: 0.5, yp: 36.5, Size: 2, moveStageN: 18, moveSceneN: 13, type: 2)
                }
            }
            
            if (3 <= sceneNumber && sceneNumber <= 5) || (13 <= sceneNumber && sceneNumber <= 15){
                let StageDis:[CGFloat] = [101,87]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 4 || sceneNumber == 14{
                    addplayer(px: 18, py: 50, DFlag: false)
                    if difficulty == 0 { additem(xp: 72, yp: 32, type: 3, number: 5) }
                    if difficulty == 1 { additem(xp: 79, yp: 37, type: 3, number: 15) }
                }else if sceneNumber == 5 || sceneNumber == 15{
                    addplayer(px: 79, py: 37, DFlag: false)
                    if difficulty == 0 { additem(xp: 18, yp: 50, type: 3, number: 4) }
                    if difficulty == 1 { additem(xp: 18, yp: 50, type: 3, number: 14) }
                }else{
                    addplayer(px: 98, py: 82,DFlag: false)
                    if difficulty == 0{
                        additem(xp: 18, yp: 50, type: 3, number: 4)
                        additem(xp: 72, yp: 32, type: 3, number: 5)
                    }
                    if difficulty == 1{
                        additem(xp: 18, yp: 50, type: 3, number: 14)
                        additem(xp: 79, yp: 37, type: 3, number: 15)
                    }
                }

                addBlock(xp: 91, yp: 47, xs: 5, ys: 33, type: 14)
                addBlock(xp: 96, yp: 75, xs: 5, ys: 5, type: 14)
                addWater(xp: 51, yp: 47, Size: 4, Pattern: 3)
                addBlockO(xp: 87, yp: 76, Size: 7, type: 11, Angle: 30)
                addBlock(xp: 8, yp: 46, xs: 14, ys: 2, type: 14)
                
                addWater(xp: 0, yp: 15, Size: 4, Pattern: 2)
                addBlockO(xp: 3, yp: 44, Size: 7, type: 11, Angle: -30)

                addBlock(xp: 77, yp: 0, xs: 5, ys: 35, type: 14)
                addBlock(xp: 82, yp: 24, xs: 4, ys: 23, type: 14)
                addBlockO(xp: 73, yp: 29, Size: 7, type: 11, Angle: 30)
                
                
                addgoal(xp: 17.5, yp: 3.5)
                
                if difficulty == 0{
                    addenemy(xp: 60, yp: 70, type: 28, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 69, yp: 76, type: 28, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 76, yp: 81, type: 28, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addBar(xp: 27, yp: 49)
                    addBar(xp: 32, yp: 50)
                    addBar(xp: 37, yp: 51)
                    addBar(xp: 42, yp: 52)
                    addBar(xp: 47, yp: 53)
                    addvector(xp: 25, yp: 50, Angle: -110, Size: 3)
                    addvector(xp: 30, yp: 50.5, Angle: -90, Size: 3)
                    addvector(xp: 35, yp: 51.5, Angle: -90, Size: 3)
                    addvector(xp: 40, yp: 52.5, Angle: -90, Size: 3)
                    addvector(xp: 45, yp: 53.5, Angle: -90, Size: 3)
                    addvector(xp: 50, yp: 56, Angle: -45, Size: 3)
                    additem(xp: 81, yp: 35, type: 2, number: 2)
                    
                    addenemy(xp: 15, yp: 38, type: 22, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 32, type: 22, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 36, yp: 25, type: 21, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addBar(xp: 42, yp: 24)
                    addBar(xp: 47, yp: 26)
                    addBar(xp: 52, yp: 28)
                    addBar(xp: 57, yp: 30)
                    addBar(xp: 62, yp: 32)
                    addBar(xp: 67, yp: 34)
                    addvector(xp: 44, yp: 25, Angle: 120, Size: 3)
                    addvector(xp: 49, yp: 27, Angle: 120, Size: 3)
                    addvector(xp: 54, yp: 29, Angle: 120, Size: 3)
                    addvector(xp: 59, yp: 31, Angle: 120, Size: 3)
                    addvector(xp: 64, yp: 32, Angle: 120, Size: 3)
                    
                    addenemy(xp: 65, yp: 15, type: 29, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addWater(xp: 27, yp: -6, Size: 5, Pattern: 3)
                    addBlock(xp: 15, yp: 0, xs: 16, ys: 3, type: 14)
                }
                if difficulty == 1{
                    addenemy(xp: 60, yp: 70, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 66, yp: 76, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 71, yp: 79, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 76, yp: 82, type: 28, HP: 20, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addBar(xp: 29, yp: 50)
                    addBar(xp: 39, yp: 52)
                    addBar(xp: 47, yp: 53)
                    addvector(xp: 26, yp: 50, Angle: -110, Size: 3)
                    addvector(xp: 36, yp: 52, Angle: -90, Size: 3)
                    addvector(xp: 44, yp: 53, Angle: -90, Size: 3)
                    addvector(xp: 50, yp: 56, Angle: -45, Size: 3)
                    
                    addenemy(xp: 15, yp: 38, type: 22, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 20, yp: 36, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 32, type: 22, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 29, yp: 31, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 32, yp: 28, type: 22, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 36, yp: 25, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addBar(xp: 42, yp: 24)
                    addBar(xp: 48, yp: 26)
                    addBar(xp: 54, yp: 28)
                    addBar(xp: 60, yp: 30)
                    addBar(xp: 66, yp: 32)
                    addBar(xp: 66, yp: 32)
                    
                    addvector(xp: 44, yp: 25, Angle: 120, Size: 3)
                    addvector(xp: 50, yp: 27, Angle: 120, Size: 3)
                    addvector(xp: 56, yp: 29, Angle: 120, Size: 3)
                    addvector(xp: 62, yp: 31, Angle: 120, Size: 3)
                    addvector(xp: 69, yp: 34, Angle: 120, Size: 3)
                    addvector(xp: 69, yp: 31, Angle: 80, Size: 3)
                    
                    addenemy(xp: 57, yp: 32, type: 29, HP: 50, Damage: 25, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 65, yp: 15, type: 29, HP: 50, Damage: 25, direction: true, maxn: 1, interval: 1.0)
                    addWater(xp: 37, yp: 0, Size: 4, Pattern: 3)
                    addBlock(xp: 15, yp: 0, xs: 14, ys: 3, type: 14)
                }
            }
        }
        if stageNumber == 19{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){
                let StageDis:[CGFloat] = [101,70]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 21, py: 35)
                    if difficulty == 0 { additem(xp: 11, yp: 2, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 11, yp: 2, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 11, py: 2)
                    if difficulty == 0 { additem(xp: 21, yp: 35, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 21, yp: 35, type: 3, number: 11) }
                }else{
                    addplayer(px: 3, py: 62)
                    if difficulty == 0 {
                        additem(xp: 21, yp: 35, type: 3, number: 1)
                        additem(xp: 11, yp: 2, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 21, yp: 35, type: 3, number: 11)
                        additem(xp: 11, yp: 2, type: 3, number: 12)
                    }
                }
 
                addBlock(xp: 0, yp: 53, xs: 5, ys: 8, type: 14)
                addBlock(xp: 5, yp: 53, xs: 8, ys: 6, type: 14)
                addBlock(xp: 13, yp: 53, xs: 65, ys: 1, type: 14)
                addBlockO(xp: 2, yp: 67, Size: 5, type: 10,BloclNumber: 1)
                addBlock(xp: 16, yp: 57, xs: 5, ys: 2, type: 14)
                addBlock(xp: 24, yp: 57, xs: 5, ys: 2, type: 14)
                addBlock(xp: 32, yp: 57, xs: 4, ys: 2, type: 14)
                addBlock(xp: 0, yp: 64, xs: 36, ys: 1, type: 14)
                addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 1)    //右１
                addmoveAction(xmove: 20, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 2)    //右２
                addmoveAction(xmove: 5, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 3)     //右３
                addmoveAction(xmove: -20, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 4)   //左２
                addmoveAction(xmove: -5, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 5)    //左３
                addmoveAction(xmove: 0, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 6)     //止める
                addSwitch(xp: 0.5, yp: 61.5, SwitchNumber: 3)
                addSwitch(xp: 59.5, yp: 55.5, SwitchNumberA: 6, SwitchNumberB: 1)
                addSwitch(xp: 71.5, yp: 55.5, SwitchNumber: 2)
                
                addBlock(xp: 85, yp: 48, xs: 16, ys: 1, type: 14)
                addBlock(xp: 9, yp: 41, xs: 92, ys: 1, type: 14)
                addBlock(xp: 19, yp: 47, xs: 6, ys: 1, type: 14)
                addBlock(xp: 29, yp: 47, xs: 4, ys: 1, type: 14)
                addBlock(xp: 37, yp: 47, xs: 4, ys: 1, type: 14)
                addSwitch(xp: 62.5, yp: 43.5, SwitchNumber: 5)
                addBar(xp: 55, yp: 47)
                addvector(xp: 58, yp: 44, Angle: -135, Size: 3)
                addvector(xp: 53, yp: 48, Angle: -110, Size: 3)
                addBlock(xp: 0, yp: 35, xs: 6, ys: 1, type: 14)
                addSwitch(xp: 0.5, yp: 37.5, SwitchNumber: 1)
                
                addBlock(xp: 0, yp: 23, xs: 32, ys: 7, type: 14)
                addBlock(xp: 19, yp: 30, xs: 7, ys: 3, type: 14)
                addBlock(xp: 32, yp: 23, xs: 20, ys: 2, type: 14)
                
                addBlock(xp: 70, yp: 31, xs: 25, ys: 1, type: 14)
                addBlock(xp: 94, yp: 28, xs: 1, ys: 3, type: 14)
                addBlock(xp: 40, yp: 29, xs: 9, ys: 1, type: 14)
                addBlock(xp: 43, yp: 30, xs: 3, ys: 3, type: 14)
                addBlock(xp: 54, yp: 26, xs: 4, ys: 1, type: 14)
                addBlock(xp: 58, yp: 26, xs: 3, ys: 5, type: 14)
                
                addBlock(xp: 26, yp: 11, xs: 8, ys: 1, type: 14)
                addBlock(xp: 34, yp: 16, xs: 34, ys: 1, type: 14)
                addBlock(xp: 6, yp: 4, xs: 10, ys: 1, type: 14)
                addBlock(xp: 15, yp: 5, xs: 1, ys: 3, type: 14)
                addBlock(xp: 15, yp: 8, xs: 49, ys: 1, type: 14)
                addBlock(xp: 54, yp: 5, xs: 7, ys: 3, type: 14)
                addBlock(xp: 64, yp: 8, xs: 8, ys: 4, type: 14)
                addBlock(xp: 71, yp: 12, xs: 1, ys: 6, type: 14)
                addBlock(xp: 71, yp: 18, xs: 17, ys: 1, type: 14)
                addBlock(xp: 87, yp: 19, xs: 1, ys: 9, type: 14)
                addBlock(xp: 88, yp: 27, xs: 12, ys: 1, type: 14)
                addBlock(xp: 66, yp: 17, xs: 2, ys: 1, type: 14)
                
                addBar(xp: 35, yp: 31)
                addBar(xp: 50, yp: 32)
                addBar(xp: 63, yp: 31)
                addBar(xp: 68, yp: 27)
                addvector(xp: 37, yp: 31, Angle: 100, Size: 3)
                addvector(xp: 52, yp: 31, Angle: 50, Size: 3)
                addvector(xp: 65, yp: 30, Angle: 60, Size: 3)
                addvector(xp: 70, yp: 27, Angle: 110, Size: 3)
                addvector(xp: 78, yp: 27, Angle: 135, Size: 3)
                addvector(xp: 74, yp: 22, Angle: -45, Size: 3)
                addvector(xp: 69, yp: 17, Angle: 0, Size: 3)
          
                addBlock(xp: 6, yp: 0, xs: 18, ys: 1, type: 14)
                addBlock(xp: 37, yp: 5, xs: 11, ys: 1, type: 14)
                addvector(xp: 31, yp: 2, Angle: 135, Size: 3)
                addBar(xp: 33, yp: 5)
                addBlockO(xp: 19, yp: 3, Size: 5, type: 10, BloclNumber: 12)
                
                addBlock(xp: 90, yp: 0, xs: 10, ys: 3, type: 14)
                addgoal(xp: 99.5, yp: 3.5)
                
                if difficulty == 0{
                    addenemy(xp: 22, yp: 60, type: 21, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 60, type: 21, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 42, yp: 60, type: 21, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 54, yp: 60, type: 21, HP: 20, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addDamageBlock(xp: 85, yp: 49, xs: 16, ys: 1, type: 3, damage: 30)
                    addenemy(xp: 93, yp: 56, type: 28, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addDamageBlock(xp: 13, yp: 54, xs: 65, ys: 1, type: 3, damage: 30)
                    addSwitch(xp: 99.5, yp: 50.5, SwitchNumber: 4)
                    addDamageBlock(xp: 62, yp: 55, xs: 2, ys: 2, type: 2, damage: 20,BlockNumber: 2)
                    addmoveAction(xmove: 0, ymove: 6, time: 3.0, BlockNumber: 2,interval: 2.0)
                    
                    addDamageBlock(xp: 9, yp: 42, xs: 92, ys: 1, type: 3, damage: 30)
                    addDamageBlock(xp: 19, yp: 43, xs: 31, ys: 4, type: 2, damage: 30)
                    addDamageBlock(xp: 94, yp: 43, xs: 7, ys: 4, type: 2, damage: 30)
                    addBlock(xp: 44, yp: 47, xs: 6, ys: 1, type: 14)
                    addBlock(xp: 44, yp: 48, xs: 1, ys: 1, type: 14)
                    addDamageBlock(xp: 0, yp: 36, xs: 6, ys: 1, type: 3, damage: 30)
                    
                    addDamageBlock(xp: 0, yp: 30, xs: 19, ys: 1, type: 3, damage: 30)
                    addDamageBlock(xp: 32, yp: 24, xs: 20, ys: 1, type: 3, damage: 30)
                    
                    addBlockO(xp: 92, yp: 34, Size: 5, type: 10, BloclNumber: 7)
                    addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 7)    //右１
                    addmoveAction(xmove: 5, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 8)     //右３
                    addmoveAction(xmove: -10, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 9)   //左1
                    addmoveAction(xmove: -5, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 10)    //左３
                    addSwitch(xp: 92.5, yp: 28.5, SwitchNumberA: 10, SwitchNumberB: 7)
                    
                    addDamageBlock(xp: 34, yp: 17, xs: 32, ys: 1, type: 3, damage: 30)
                    addDamageBlock(xp: 6, yp: 5, xs: 9, ys: 1, type: 3, damage: 30)
                    addDamageBlock(xp: 15, yp: 9, xs: 49, ys: 1, type: 3, damage: 30)
                    
                    addDamageBlock(xp: 70, yp: 32, xs: 22, ys: 9, type: 2, damage: 30)
                    addDamageBlock(xp: 38, yp: 18, xs: 28, ys: 5, type: 2, damage: 30)
                    addDamageBlock(xp: 42, yp: 10, xs: 2, ys: 3, type: 2, damage: 20)
                    addDamageBlock(xp: 47, yp: 13, xs: 2, ys: 3, type: 2, damage: 20)
                    addDamageBlock(xp: 53, yp: 10, xs: 2, ys: 3, type: 2, damage: 20)

                    addBar(xp: 63, yp: 13,BloclNumber: 11)
                    addmoveAction(xmove: -28, ymove: 0, time: 20, BlockNumber: 11, interval: 2.0, firstinterval: 2.0, Actiontype: 3)
                    ONOFFAction(BlockNumber: 11, SwitchNumber: 11)
                    addSwitch(xp: 64.5, yp: 12.5, SwitchNumber: 11)
                    
                    addBlock(xp: 76, yp: 21, xs: 9, ys: 3, type: 14)
                    addBlock(xp: 80, yp: 24, xs: 5, ys: 3, type: 14)
                    
                    addDamageO(xp: 52.5, yp: 27.5, Size: 2, type: 1, damage: 20, BloclNumber: 8)
                    addmoveAction(xmove: 0, ymove: 12, time: 7.0, BlockNumber: 8,interval: 2.0)
                    addDamageO(xp: 71.5, yp: 24.5, Size: 2, type: 1, damage: 20, BloclNumber: 21)
                    addmoveAction(xmove: 0, ymove: 5, time: 4.0, BlockNumber: 21,interval: 2.0)
                    addenemy(xp: 66, yp: 31, type: 21, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 82, yp: 28, type: 26, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 24, yp: 0, xs: 48, ys: 1, type: 3, damage: 30)
                    addDamageBlock(xp: 37, yp: 1, xs: 11, ys: 4, type: 2, damage: 30)
                    addmoveAction(xmove: 6, ymove: 0, time: 5, BlockNumber: 12, type: 4, Actiontype: 2, SwitchNumber: 12)    //右１
                    addmoveAction(xmove: 20, ymove: 0, time: 5, BlockNumber: 12, type: 4, Actiontype: 2, SwitchNumber: 13)    //右2
                    addSwitch(xp: 21.5, yp: 1.5, SwitchNumber: 12)
                    addSwitch(xp: 64.5, yp: 1.5, SwitchNumber: 13)
                    addDamageBlock(xp: 79, yp: 0, xs: 11, ys: 3, type: 2, damage: 30)
                    addDamageO(xp: 74.5, yp: 2.5, Size: 18, type: 5, damage: 20, Angle: -60)
                }
                if difficulty == 1{
                    addenemy(xp: 22, yp: 60, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 60, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 42, yp: 60, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 48, yp: 57, type: 22, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 54, yp: 60, type: 21, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addDamageBlock(xp: 85, yp: 49, xs: 16, ys: 1, type: 3, damage: 200)
                    addenemy(xp: 93, yp: 56, type: 28, HP: 20, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addDamageBlock(xp: 13, yp: 54, xs: 65, ys: 1, type: 3, damage: 200)
                    addSwitch(xp: 95.5, yp: 50.5, SwitchNumber: 4)
                    addDamageBlock(xp: 97, yp: 50, xs: 4, ys: 5, type: 2, damage: 200)
                    addDamageBlock(xp: 62, yp: 55, xs: 3, ys: 3, type: 2, damage: 50,BlockNumber: 2)
                    addmoveAction(xmove: 0, ymove: 6, time: 3.0, BlockNumber: 2,interval: 2.0)
                    
                    addDamageBlock(xp: 9, yp: 42, xs: 92, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 19, yp: 43, xs: 31, ys: 4, type: 2, damage: 200)
                    addDamageBlock(xp: 94, yp: 43, xs: 7, ys: 4, type: 2, damage: 200)
                    addBlock(xp: 46, yp: 47, xs: 4, ys: 1, type: 14)
                    addDamageO(xp: 26.5, yp: 47.5, Size: 2, type: 1, damage: 50, BloclNumber: 3)
                    addmoveAction(xmove: 0, ymove: 4, time: 2.0, BlockNumber: 3,interval: 3.0)
                    addDamageO(xp: 34.5, yp: 51.5, Size: 2, type: 1, damage: 50, BloclNumber: 20)
                    addmoveAction(xmove: 0, ymove: -4, time: 2.0, BlockNumber: 20,interval: 3.0)
                    addDamageBlock(xp: 0, yp: 36, xs: 6, ys: 1, type: 3, damage: 200)
                    
                    addDamageBlock(xp: 0, yp: 30, xs: 19, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 32, yp: 24, xs: 20, ys: 1, type: 3, damage: 200)
                    
                    addBlock(xp: 23, yp: 36, xs: 1, ys: 5, type: 14)
                    addBlock(xp: 24, yp: 36, xs: 46, ys: 1, type: 14)
                    addBlockO(xp: 26, yp: 39, Size: 5, type: 10, BloclNumber: 7)
                    addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 7)    //右１
                    addmoveAction(xmove: 5, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 8)     //右３
                    addmoveAction(xmove: -10, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 9)   //左1
                    addmoveAction(xmove: -5, ymove: 0, time: 5, BlockNumber: 7, type: 4, Actiontype: 2, SwitchNumber: 10)    //左３
                    addSwitch(xp: 92.5, yp: 28.5, SwitchNumberA: 10, SwitchNumberB: 7)
                    addSwitch(xp: 24.5, yp: 33.5, SwitchNumber: 8)
                    
                    addDamageBlock(xp: 34, yp: 17, xs: 32, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 6, yp: 5, xs: 9, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 15, yp: 9, xs: 49, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 74, yp: 19, xs: 13, ys: 1, type: 3, damage: 200)
                    
                    addDamageBlock(xp: 70, yp: 32, xs: 22, ys: 9, type: 2, damage: 200)
                    addDamageBlock(xp: 38, yp: 18, xs: 28, ys: 5, type: 2, damage: 200)
                    addDamageBlock(xp: 42, yp: 10, xs: 2, ys: 3, type: 2, damage: 50)
                    addDamageBlock(xp: 47, yp: 13, xs: 2, ys: 3, type: 2, damage: 50)
                    addDamageBlock(xp: 53, yp: 10, xs: 2, ys: 3, type: 2, damage: 50)

                    addBar(xp: 63, yp: 13,BloclNumber: 11)
                    addmoveAction(xmove: -28, ymove: 0, time: 20, BlockNumber: 11, interval: 2.0, firstinterval: 0, Actiontype: 3)
                    ONOFFAction(BlockNumber: 11, SwitchNumber: 11)
                    addSwitch(xp: 64.5, yp: 12.5, SwitchNumber: 11)
                    
                    addBlock(xp: 76, yp: 23, xs: 9, ys: 1, type: 14)
                    addBlock(xp: 80, yp: 24, xs: 5, ys: 3, type: 14)
                    
                    addDamageO(xp: 52.5, yp: 27.5, Size: 2, type: 1, damage: 50, BloclNumber: 8)
                    addmoveAction(xmove: 0, ymove: 7, time: 4.0, BlockNumber: 8,interval: 2.0)
                    addDamageO(xp: 71.5, yp: 24.5, Size: 2, type: 1, damage: 50, BloclNumber: 21)
                    addmoveAction(xmove: 0, ymove: 5, time: 4.0, BlockNumber: 21,interval: 2.0)
                    addenemy(xp: 66, yp: 31, type: 21, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 82, yp: 28, type: 26, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 24, yp: 0, xs: 48, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 37, yp: 1, xs: 11, ys: 4, type: 2, damage: 200)
                    
                    addmoveAction(xmove: 8, ymove: 0, time: 5, BlockNumber: 12, type: 4, Actiontype: 2, SwitchNumber: 12)    //右１
                    addmoveAction(xmove: 20, ymove: 0, time: 5, BlockNumber: 12, type: 4, Actiontype: 2, SwitchNumber: 13)    //右2
                    addSwitch(xp: 21.5, yp: 1.5, SwitchNumber: 12)
                    addSwitch(xp: 64.5, yp: 1.5, SwitchNumber: 13)
                    addDamageBlock(xp: 79, yp: 0, xs: 11, ys: 3, type: 2, damage: 200)
                    addDamageO(xp: 74.5, yp: 2.5, Size: 18, type: 5, damage: 200, Angle: -60)
                }
            }
        }
        if stageNumber == 20{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [40,32]
                BackGroundImage(imageName: "bg3_2", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                addplayer(px: 2, py: 4)
                
                addBlock(xp: 0, yp: 0, xs: 40, ys: 3, type: 14)
                addBlock(xp: 0, yp: 7, xs: 3, ys: 2, type: 14)
                addBlock(xp: 3, yp: 7, xs: 2, ys: 25, type: 14)
                addBlock(xp: 10, yp: 11, xs: 5, ys: 2, type: 14)
                addBlock(xp: 20, yp: 11, xs: 5, ys: 2, type: 14)
                addBlock(xp: 30, yp: 11, xs: 5, ys: 2, type: 14)
                addBlock(xp: 10, yp: 21, xs: 5, ys: 2, type: 14)
                addBlock(xp: 20, yp: 21, xs: 5, ys: 2, type: 14)
                addBlock(xp: 30, yp: 21, xs: 5, ys: 2, type: 14)
                addBar(xp: 7, yp: 7)
                addBar(xp: 7, yp: 13)
                addBar(xp: 7, yp: 19)
                addBar(xp: 7, yp: 25)
                addBar(xp: 12, yp: 28)
                addBar(xp: 17, yp: 6)
                addBar(xp: 17, yp: 12)
                addBar(xp: 17, yp: 18)
                addBar(xp: 17, yp: 24)
                addBar(xp: 22, yp: 28)
                addBar(xp: 27, yp: 6)
                addBar(xp: 27, yp: 12)
                addBar(xp: 27, yp: 18)
                addBar(xp: 27, yp: 24)
                addBar(xp: 32, yp: 28)
                addBar(xp: 37, yp: 7)
                addBar(xp: 37, yp: 13)
                addBar(xp: 37, yp: 19)
                addBar(xp: 37, yp: 25)
                
                if difficulty == 0{
                    addenemy(xp: 22, yp: 14, type: 30, HP: 100, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 22, yp: 3.5, Goaltype: 3, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 1.0, SwitchNumbet: 1)
                }
                
                if difficulty == 1{
                    enemymax = 2
                    addenemy(xp: 22, yp: 14, type: 30, HP: 140, Damage: 25, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addenemy(xp: 22, yp: 13, type: 28, HP: 20, Damage: 15, direction: false, maxn: 999, interval: 25.0)
                    addgoal(xp: 22, yp: 3.5, Goaltype: 13, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 1.0, SwitchNumbet: 1)
                }
            }
        }
        
        //6¥第４エリア火山
        if stageNumber == 21{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12){
                let StageDis:[CGFloat] = [71,57]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 65, py: 17,DFlag: false)
                    if difficulty == 0{ additem(xp: 7, yp: 39, type: 3, number: 2) }
                    if difficulty == 1{ additem(xp: 7, yp: 39, type: 3, number: 12) }

                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 7, py: 39)
                    if difficulty == 0{ additem(xp: 65, yp: 17, type: 3, number: 1) }
                    if difficulty == 1{ additem(xp: 65, yp: 17, type: 3, number: 11) }
                }else{
                    addplayer(px: 2, py: 4)
                    if difficulty == 0{
                        additem(xp: 65, yp: 17, type: 3, number: 1)
                        additem(xp: 7, yp: 39, type: 3, number: 2)
                    }
                    if difficulty == 1{
                        additem(xp: 65, yp: 17, type: 3, number: 11)
                        additem(xp: 7, yp: 39, type: 3, number: 12)
                    }
                }
 
                addBlock(xp: 0, yp: 0, xs: 29, ys: 3, type:8)
                addBlock(xp: 29, yp: 0, xs: 17, ys: 5, type: 8)
                addBlock(xp: 46, yp: 0, xs: 25, ys: 7, type: 8)
                addBlock(xp: 21, yp: 3, xs: 4, ys: 1, type: 8)
                addBlock(xp: 0, yp: 19, xs: 59, ys: 2, type: 9)
                addBlock(xp: 59, yp: 13, xs: 3, ys: 8, type: 9)
                addBlock(xp: 62, yp: 13, xs: 2, ys: 2, type: 9)
                addBlock(xp: 64, yp: 9, xs: 3, ys: 6, type: 9)
           
                addBar(xp: 22, yp: 24)
                addBar(xp: 29, yp: 24)
                addBar(xp: 36, yp: 24)
                addBar(xp: 1, yp: 24)
                addBar(xp: 1, yp: 29)
                addBar(xp: 1, yp: 34)
                addvector(xp: 1, yp: 26, Angle: 180, Size: 3)
                addvector(xp: 1, yp: 31, Angle: 180, Size: 3)
                
                addBlock(xp: 4, yp: 35, xs: 7, ys: 2, type: 9)
                addBlock(xp: 15, yp: 35, xs: 11, ys: 2, type: 9)
                addBlock(xp: 31, yp: 35, xs: 8, ys: 2, type: 9)
                
                addBlock(xp: 56, yp: 39, xs: 1, ys: 7, type: 9)
                
                addvector(xp: 54, yp: 44, Angle: -160, Size: 3)
                
                addBlock(xp: 0, yp: 46, xs: 51, ys: 2, type: 9)
                addgoal(xp: 0.5, yp: 48.5)
                
                
                if difficulty == 0{
                    addenemy(xp: 19, yp: 3, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 38, yp: 5, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 55, yp: 7, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 22.5, yp: 22.5, Size: 4, type: 8, damage: 25,BloclNumber: 1)
                    addmoveAction(xmove: 13, ymove: 0, time: 8.0, BlockNumber: 1)
                    addDamageO(xp: 14.5, yp: 22.5, Size: 6, type: 8, damage: 25,BloclNumber: 2)
                    addmoveAction(xmove: 0, ymove: 9, time: 4.0, BlockNumber: 2)
                    addDamageO(xp: 10.5, yp: 31.5, Size: 6, type: 8, damage: 25,BloclNumber: 3)
                    addmoveAction(xmove: 0, ymove: -9, time: 4.0, BlockNumber: 3)
                    addDamageO(xp: 6.5, yp: 22.5, Size: 6, type: 8, damage: 25,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: 9, time: 4.0, BlockNumber: 4)
                    additem(xp: 1, yp: 21, type: 2, number: 1)
                    
                    addenemy(xp: 58, yp: 22, type: 21, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 48, yp: 22, type: 4, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 22, type: 14, HP: 20, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 43, yp: 23, type: 14, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 24, yp: 37, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 37, yp: 37, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addBar(xp: 53, yp: 46)
                    
                    addBlock(xp: 45, yp: 35, xs: 9, ys: 2, type: 9)
                    addDamageBlock(xp: 11, yp: 35, xs: 4, ys: 2, type: 1, damage: 25)
                    addDamageBlock(xp: 26, yp: 35, xs: 5, ys: 2, type: 1, damage: 25)
                    addDamageBlock(xp: 39, yp: 35, xs: 6, ys: 2, type: 1, damage: 25)
                    addDamageBlock(xp: 54, yp: 35, xs: 17, ys: 2, type: 1, damage: 25)
                    addDamageBlock(xp: 57, yp: 37, xs: 3, ys: 20, type: 1, damage: 25)
                    
                    addDamageO(xp: 10.5, yp: 48.5, Size: 3, type: 8, damage: 25,BloclNumber: 5)
                    addmoveAction(xmove: 29, ymove: 0, time: 20, BlockNumber: 5)
                    addenemy(xp: 30, yp: 48, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 20, yp: 48, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                }
                if difficulty == 1{
                    addenemy(xp: 19, yp: 3, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 38, yp: 5, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 55, yp: 7, type: 31, HP: 30, Damage: 30, direction: false, maxn: 2, interval: 8.0)
                    
                    addDamageO(xp: 22.5, yp: 22.5, Size: 8, type: 8, damage: 50,BloclNumber: 1)
                    addmoveAction(xmove: 13, ymove: 0, time: 8.0, BlockNumber: 1)
                    addDamageO(xp: 14.5, yp: 22.5, Size: 8, type: 8, damage: 50,BloclNumber: 2)
                    addmoveAction(xmove: 0, ymove: 9, time: 4.0, BlockNumber: 2)
                    addDamageO(xp: 10.5, yp: 31.5, Size: 8, type: 8, damage: 50,BloclNumber: 3)
                    addmoveAction(xmove: 0, ymove: -9, time: 4.0, BlockNumber: 3)
                    addDamageO(xp: 6.5, yp: 22.5, Size: 8, type: 8, damage: 50,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: 9, time: 4.0, BlockNumber: 4)
                    
                    addenemy(xp: 58, yp: 22, type: 29, HP: 50, Damage: 25, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 48, yp: 22, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 22, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 43, yp: 23, type: 17, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 24, yp: 37, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 24, yp: 37, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 37, yp: 37, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addBlock(xp: 45, yp: 35, xs: 7, ys: 2, type: 9)
                    addDamageBlock(xp: 11, yp: 35, xs: 4, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 26, yp: 35, xs: 5, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 39, yp: 35, xs: 6, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 52, yp: 35, xs: 19, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 57, yp: 37, xs: 3, ys: 20, type: 1, damage: 200)
                    
                    addDamageO(xp: 10.5, yp: 48.5, Size: 4, type: 8, damage: 25,BloclNumber: 5)
                    addmoveAction(xmove: 29, ymove: 0, time: 20, BlockNumber: 5)
                    addenemy(xp: 30, yp: 48, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 20, yp: 48, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                }
            }
        }
        if stageNumber == 22{
            if (0 <= sceneNumber && sceneNumber <= 1) || sceneNumber == 11{
                let StageDis:[CGFloat] = [96,62]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 42, py: 59)
                }else {
                    addplayer(px: 2, py: 4)
                    if difficulty == 0{ additem(xp: 42, yp: 59, type: 3, number: 1) }
                    if difficulty == 1{ additem(xp: 42, yp: 59, type: 3, number: 11) }
                }
       
                addBlock(xp: 0, yp: 0, xs: 30, ys: 3, type: 8)
                addBlock(xp: 13, yp: 6, xs: 7, ys: 2, type: 8)
                addBar(xp: 9, yp: 6)
                addBar(xp: 16, yp: 11)
                addBar(xp: 16, yp: 17)
                addvector(xp: 16, yp: 13, Angle: 180, Size: 3)
                
                addBlock(xp: 37, yp: 56, xs: 7, ys: 2, type: 8)
        
                addBar(xp: 1, yp: 22)
                addBar(xp: 1, yp: 27)
                addBar(xp: 1, yp: 32)
                addBar(xp: 1, yp: 37)
                addBar(xp: 1, yp: 42)
                addBar(xp: 1, yp: 47)
                addBar(xp: 1, yp: 52)
                addBar(xp: 1, yp: 57)
                addBar(xp: 6, yp: 22)
                addBar(xp: 6, yp: 27)
                addBar(xp: 6, yp: 37)
                addBar(xp: 6, yp: 42)
                addBar(xp: 6, yp: 47)
                addBar(xp: 6, yp: 52)
                addBar(xp: 6, yp: 57)
                addBar(xp: 11, yp: 22)
                addBar(xp: 11, yp: 27)
                addBar(xp: 11, yp: 32)
                addBar(xp: 11, yp: 37)
                addBar(xp: 11, yp: 57)
                addBar(xp: 16, yp: 22)
                addBar(xp: 16, yp: 27)
                addBar(xp: 16, yp: 32)
                addBar(xp: 16, yp: 52)
                addBar(xp: 16, yp: 57)
                addBar(xp: 21, yp: 22)
                addBar(xp: 21, yp: 47)
                addBar(xp: 21, yp: 52)
                addBar(xp: 26, yp: 22)
                addBar(xp: 26, yp: 52)
                addBar(xp: 26, yp: 57)
                addBar(xp: 31, yp: 47)
                addBar(xp: 31, yp: 52)
                addBar(xp: 31, yp: 57)
                addvector(xp: 3, yp: 59, Angle: 90, Size: 3)
                addvector(xp: 33, yp: 57, Angle: 135, Size: 3)
          
                addBar(xp: 49.5, yp: 55.5, type: 2, BloclNumber: 15)
                addrotateAction(dsita: 90, time: 6.0, BlockNumber: 15, firstinterval: 0)
                
                addBar(xp: 55, yp: 46, type: 2, BloclNumber: 16)
                addrotateAction(dsita: -90, time: 6.0, BlockNumber: 16, firstinterval: 4.0)
                
                addBar(xp: 65, yp: 50, type: 2, BloclNumber: 17)
                addrotateAction(dsita: 90, time: 6.0, BlockNumber: 17, firstinterval: 0)
  
                addBar(xp: 69, yp: 43)
                addBar(xp: 74, yp: 32, type: 3, BloclNumber: 18,Angle: 30)
                addrotateAction(dsita: -100, time: 10.0, BlockNumber: 18, interval: 2.0, type: 2)
                
                addvector(xp: 83, yp: 37, Angle: 85, Size: 3)
                addvector(xp: 66, yp: 27, Angle: -100, Size: 3)
                addBar(xp: 88, yp: 36)
                addBar(xp: 93, yp: 36)
                addBar(xp: 93, yp: 31)
                addBar(xp: 93, yp: 26)
                addBar(xp: 88, yp: 26)
                addBar(xp: 83, yp: 26)
    
                if difficulty == 0{
                    addBar(xp: 11, yp: 42)
                    addBar(xp: 11, yp: 52)
                    addBar(xp: 16, yp: 37)
                    addBar(xp: 16, yp: 42)
                    addBar(xp: 16, yp: 47)
                    addBar(xp: 21, yp: 32)
                    addBar(xp: 21, yp: 37)
                    addBar(xp: 26, yp: 27)
                    addBar(xp: 26, yp: 32)
                    addBar(xp: 26, yp: 37)
                    addBar(xp: 26, yp: 42)
                    addBar(xp: 31, yp: 27)
                    addBar(xp: 31, yp: 32)
                    addBar(xp: 31, yp: 42)
                    addvector(xp: 32, yp: 22, Angle: 180, Size: 3)
                    
                    addDamageO(xp: 16, yp: 9, Size: 13, type: 9, damage: 20,BloclNumber: 1)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 1)
                    addDamageO(xp: 16, yp: 9, Size: 13, type: 9, damage: 20,BloclNumber: 2,Angle: 180)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 2)
    
                    addDamageO(xp: 3.5, yp: 59.5, Size: 3, type: 8, damage: 15,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: -11, time: 5.5, BlockNumber: 4,interval: 1.0)
                    addDamageO(xp: 8, yp: 59, Size: 3, type: 8, damage: 15,BloclNumber: 5)
                    addmoveAction(xmove: 16, ymove: 0, time: 8.0, BlockNumber: 5,interval: 1.0)
                    addDamageO(xp: 4.5, yp: 44.5, Size: 3, type: 8, damage: 15,BloclNumber: 6)
                    addmoveAction(xmove: 16.5, ymove: 0, time: 8.25, BlockNumber: 6,interval: 1.0)
                    addDamageO(xp: 31, yp: 39, Size: 3, type: 8, damage: 15,BloclNumber: 8)
                    addmoveAction(xmove: -16, ymove: 0, time: 8.0, BlockNumber: 8,interval: 1.0)
                    addDamageO(xp: 11, yp: 34.5, Size: 12, type: 9, damage: 15,BloclNumber: 9,Angle: -90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 9)
                    addDamageO(xp: 11, yp: 52, Size: 12, type: 9, damage: 15,BloclNumber: 10,Angle: 0)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 10)
                    addDamageO(xp: 21, yp: 52, Size: 12, type: 9, damage: 15,BloclNumber: 12,Angle: -90)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 12)
                    addDamageO(xp: 24, yp: 30, Size: 12, type: 9, damage: 15,BloclNumber: 13,Angle: 90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 13)
                    addDamageO(xp: 29, yp: 42, Size: 12, type: 9, damage: 15,BloclNumber: 14,Angle: 0)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 14)
                    addenemy(xp: 9, yp: 41, type: 31, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 24, type: 31, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 53, type: 31, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 31, yp: 58, type: 31, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    additem(xp: 38, yp: 58, type: 2, number: 2)
                    
                    addenemy(xp: 78, yp: 44, type: 28, HP: 10, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 70, yp: 20, type: 28, HP: 10, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 0, yp: 17, xs: 13, ys: 2, type: 1, damage: 50)
                    addDamageBlock(xp: 23, yp: 3, xs: 2, ys: 14, type: 1, damage: 50)
                    addDamageBlock(xp: 20, yp: 17, xs: 17, ys: 2, type: 1, damage: 50)
                    addDamageBlock(xp: 37, yp: 17, xs: 2, ys: 39, type: 1, damage: 50)
                    addDamageBlock(xp: 39, yp: 37, xs: 25, ys: 2, type: 1, damage: 50)
                    addDamageBlock(xp: 64, yp: 31, xs: 2, ys: 8, type: 1, damage: 50)
                    addDamageBlock(xp: 66, yp: 31, xs: 24, ys: 1, type: 1, damage: 50)
                    addDamageBlock(xp: 61, yp: 17, xs: 2, ys: 5, type: 1, damage: 200)
                    addDamageBlock(xp: 63, yp: 17, xs: 33, ys: 2, type: 1, damage: 200)
                    
                    addBlock(xp: 48, yp: 22, xs: 15, ys: 2, type: 8)
                    addgoal(xp: 48.5, yp: 24.5)
                }
               
                if difficulty == 1{
                    addDamageO(xp: 16, yp: 9, Size: 13, type: 9, damage: 40,BloclNumber: 1)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 1)
                    addDamageO(xp: 16, yp: 9, Size: 13, type: 9, damage: 40,BloclNumber: 2,Angle: 180)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 2)
                    
                    addDamageO(xp: 3.5, yp: 59.5, Size: 3, type: 8, damage: 30,BloclNumber: 4)
                    addmoveAction(xmove: 0, ymove: -11, time: 5.5, BlockNumber: 4,interval: 1.0)
                    addDamageO(xp: 8, yp: 59, Size: 3, type: 8, damage: 30,BloclNumber: 5)
                    addmoveAction(xmove: 16, ymove: 0, time: 8.0, BlockNumber: 5,interval: 1.0)
                    addDamageO(xp: 4.5, yp: 44.5, Size: 3, type: 8, damage: 30,BloclNumber: 6)
                    addmoveAction(xmove: 16.5, ymove: 0, time: 8.25, BlockNumber: 6,interval: 1.0)
                    addDamageO(xp: 18.5, yp: 36.5, Size: 3, type: 8, damage: 30,BloclNumber: 7)
                    addmoveAction(xmove: 0, ymove: 10.5, time: 5.25, BlockNumber: 7,interval: 1.0)
                    addDamageO(xp: 31, yp: 39, Size: 3, type: 8, damage: 30,BloclNumber: 8)
                    addmoveAction(xmove: -16, ymove: 0, time: 8.0, BlockNumber: 8,interval: 1.0)
                    addDamageO(xp: 11, yp: 34.5, Size: 12, type: 9, damage: 30,BloclNumber: 9,Angle: -90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 9)
                    addDamageO(xp: 11, yp: 52, Size: 12, type: 9, damage: 30,BloclNumber: 10,Angle: 0)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 10)
                    addDamageO(xp: 16, yp: 30, Size: 12, type: 9, damage: 30,BloclNumber: 11,Angle: 0)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 11)
                    addDamageO(xp: 21, yp: 52, Size: 12, type: 9, damage: 30,BloclNumber: 12,Angle: -90)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 12)
                    addDamageO(xp: 24, yp: 30, Size: 12, type: 9, damage: 30,BloclNumber: 13,Angle: 90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 13)
                    addDamageO(xp: 29, yp: 42, Size: 12, type: 9, damage: 30,BloclNumber: 14,Angle: 0)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 14)
                    addenemy(xp: 9, yp: 41, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 24, type: 47, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 53, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 31, yp: 58, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 78, yp: 44, type: 28, HP: 10, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 82, yp: 41, type: 28, HP: 10, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 70, yp: 20, type: 28, HP: 10, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 65, yp: 23, type: 28, HP: 10, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 93, yp: 26, Size: 11, type: 9, damage: 30,BloclNumber: 21)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 21)
                    
                    addDamageBlock(xp: 0, yp: 17, xs: 13, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 23, yp: 3, xs: 2, ys: 14, type: 1, damage: 200)
                    addDamageBlock(xp: 20, yp: 17, xs: 17, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 37, yp: 17, xs: 2, ys: 39, type: 1, damage: 200)
                    addDamageBlock(xp: 39, yp: 37, xs: 25, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 64, yp: 31, xs: 2, ys: 8, type: 1, damage: 200)
                    addDamageBlock(xp: 66, yp: 31, xs: 24, ys: 1, type: 1, damage: 200)
                    addDamageBlock(xp: 61, yp: 17, xs: 2, ys: 8, type: 1, damage: 200)
                    addDamageBlock(xp: 63, yp: 17, xs: 33, ys: 2, type: 1, damage: 200)
                    
                    addBlock(xp: 48, yp: 25, xs: 15, ys: 2, type: 8)
                    addgoal(xp: 48.5, yp: 27.5)
                }
            }
        }

        
        if stageNumber == 23{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [200,22]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 102, py: 6,DFlag: false)
                }else{
                    addplayer(px: 197, py: 5,DFlag: false)
                    if difficulty == 0 { additem(xp: 102, yp: 6, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 102, yp: 6, type: 3, number: 11) }
                }
                
                addBlock(xp: 190, yp: 0, xs: 10, ys: 3, type: 8)
                addDamageBlock(xp: 175, yp: 0, xs: 15, ys: 2, type: 1, damage: 200)
                addBar(xp: 185, yp: 6)
                addvector(xp: 183, yp: 7, Angle: -135, Size: 3)
                
                addBlock(xp: 164, yp: 0, xs: 11, ys: 3, type: 8)
                addDamageBlock(xp: 149, yp: 0, xs: 16, ys: 2, type: 1, damage: 200)
                addBar(xp: 159, yp: 6)
                addvector(xp: 157, yp: 7, Angle: -135, Size: 3)
                
                addBlock(xp: 132, yp: 0, xs: 17, ys: 3, type: 8)
                addDamageBlock(xp: 115, yp: 0, xs: 17, ys: 2, type: 1, damage: 200)
                addBar(xp: 127, yp: 6)
                addBar(xp: 123, yp: 6)
                addBar(xp: 119, yp: 6)
                addvector(xp: 71, yp: 10, Angle: -120, Size: 3)
                
                addBlock(xp: 99, yp: 0, xs: 15, ys: 4, type: 8)
                addDamageBlock(xp: 66, yp: 0, xs: 33, ys: 2, type: 1, damage: 200)
                addBar(xp: 94, yp: 7)
                addBar(xp: 94, yp: 11)
                addBar(xp: 89, yp: 7)
                addBar(xp: 89, yp: 11)
                addBar(xp: 84, yp: 7)
                addBar(xp: 84, yp: 11)
                addBar(xp: 79, yp: 7)
                addBar(xp: 79, yp: 11)
                addBar(xp: 74, yp: 7)
                addBar(xp: 74, yp: 11)
                
                addBlock(xp: 47, yp: 0, xs: 19, ys: 5, type: 8)
                addDamageBlock(xp: 9, yp: 0, xs: 38, ys: 1, type: 1, damage: 200)
                addBar(xp: 43, yp: 5)
                addBar(xp: 43, yp: 10)
                addBar(xp: 43, yp: 15)
                addBar(xp: 38, yp: 5)
                addBar(xp: 38, yp: 10)
                addBar(xp: 38, yp: 15)
                addBar(xp: 33, yp: 5)
                addBar(xp: 33, yp: 10)
                addBar(xp: 33, yp: 15)
                addBar(xp: 28, yp: 5)
                addBar(xp: 28, yp: 10)
                addBar(xp: 28, yp: 15)
                addBar(xp: 23, yp: 5)
                addBar(xp: 23, yp: 10)
                addBar(xp: 23, yp: 15)
                addBar(xp: 18, yp: 5)
                addBar(xp: 18, yp: 10)
                addBar(xp: 18, yp: 15)
                addBar(xp: 13, yp: 5)
                addBar(xp: 13, yp: 10)
                addBar(xp: 13, yp: 15)
                addvector(xp: 10, yp: 14, Angle: -120, Size: 3)
                
                addBlock(xp: 0, yp: 0, xs: 9, ys: 12, type: 8)
                addmoveStageO(xp: 0.5, yp: 12.5, Size: 2, moveStageN: 23, moveSceneN: 2, type: 2)

                if difficulty == 0{
                    addDamageO(xp: 162, yp: 4, Size: 5, type: 8, damage: 20,BloclNumber: 1)
                    addmoveAction(xmove: -12, ymove: 0, time: 6.0, BlockNumber: 1,interval: 1.0)
                    
                    addenemy(xp: 131, yp: 4, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 115, yp: 4, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 97, yp: 6, Size: 5, type: 8, damage: 20,BloclNumber: 2)
                    addmoveAction(xmove: -30, ymove: 0, time: 15, BlockNumber: 2)
                    addDamageO(xp: 67, yp: 12, Size: 5, type: 8, damage: 20,BloclNumber: 3)
                    addmoveAction(xmove: 30, ymove: 0, time: 15, BlockNumber: 3)
                    
                    addenemy(xp: 13, yp: 12, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 18, yp: 4, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 14, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 36, yp: 16, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 38, yp: 4, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 0.5, yp: 12.5, Size: 2, moveStageN: 23, moveSceneN: 2, type: 2)
                }
                
                if difficulty == 1{
                    addDamageO(xp: 162, yp: 4, Size: 5, type: 8, damage: 50,BloclNumber: 1)
                    addmoveAction(xmove: -12, ymove: 0, time: 3.0, BlockNumber: 1,interval: 0.0)
                    
                    addenemy(xp: 131, yp: 4, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 115, yp: 4, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 97, yp: 7, Size: 5, type: 8, damage: 20,BloclNumber: 2)
                    addmoveAction(xmove: -30, ymove: 0, time: 30, BlockNumber: 2)
                    addDamageO(xp: 67, yp: 11, Size: 5, type: 8, damage: 20,BloclNumber: 3)
                    addmoveAction(xmove: 30, ymove: 0, time: 30, BlockNumber: 3)
                    
                    addenemy(xp: 13, yp: 12, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 18, yp: 4, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 20, yp: 9, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 14, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 34, yp: 9, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 36, yp: 16, type: 31, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 38, yp: 4, type: 31, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 0.5, yp: 12.5, Size: 2, moveStageN: 23, moveSceneN: 12, type: 2)
                }
                
            }
            
            if (2 <= sceneNumber && sceneNumber <= 3) || (12 <= sceneNumber && sceneNumber <= 13){
                let StageDis:[CGFloat] = [101,41]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 3 || sceneNumber == 13{
                    addplayer(px: 47, py: 6, DFlag: false)
                }else{
                    addplayer(px: 98, py: 18,DFlag: false)
                    if difficulty == 0 { additem(xp: 47, yp: 6, type: 3, number: 3) }
                    if difficulty == 1 { additem(xp: 47, yp: 6, type: 3, number: 13) }
                }
                
                addBlock(xp: 91, yp: 0, xs: 10, ys: 16, type: 8)
                
                addBlock(xp: 35, yp: 29, xs: 3, ys: 3, type: 8)
                addBlock(xp: 40, yp: 31, xs: 3, ys: 3, type: 8)
                addBlock(xp: 45, yp: 31, xs: 6, ys: 4, type: 8)
                addBlock(xp: 54, yp: 26, xs: 6, ys: 4, type: 8)
                addBlock(xp: 45, yp: 21, xs: 6, ys: 4, type: 8)
                addBlock(xp: 38, yp: 14, xs: 4, ys: 6, type: 8)
                addBlock(xp: 45, yp: 11, xs: 6, ys: 4, type: 8)
                addBlock(xp: 36, yp: 6, xs: 6, ys: 4, type: 8)
                addBlock(xp: 44, yp: 3, xs: 10, ys: 2, type: 8)
                addBlock(xp: 56, yp: 5, xs: 2, ys: 2, type: 8)
                addBlock(xp: 58, yp: 7, xs: 2, ys: 2, type: 8)
                addBlock(xp: 60, yp: 9, xs: 2, ys: 2, type: 8)
                addBlock(xp: 62, yp: 11, xs: 2, ys: 2, type: 8)
                addBlock(xp: 64, yp: 13, xs: 7, ys: 2, type: 8)
                addBlock(xp: 75, yp: 14, xs: 5, ys: 2, type: 8)
                addBlock(xp: 83, yp: 13, xs: 5, ys: 2, type: 8)
                addDamageBlock(xp: 28, yp: 0, xs: 63, ys: 3, type: 1, damage: 200)
                
                addBlock(xp: 0, yp: 14, xs: 35, ys: 1, type: 8)
                addBlock(xp: 26, yp: 17, xs: 5, ys: 1, type: 8)
                addBlock(xp: 30, yp: 20, xs: 5, ys: 1, type: 8)
                addBlock(xp: 26, yp: 23, xs: 5, ys: 1, type: 8)
                addBlock(xp: 30, yp: 26, xs: 5, ys: 1, type: 8)
                addBlock(xp: 26, yp: 29, xs: 5, ys: 1, type: 8)
            
                addenemy(xp: 36, yp: 35, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
            
                addgoal(xp: 2.5, yp: 15.5)
                
                
                if difficulty == 0{
                    addenemy(xp: 80, yp: 15, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 70, yp: 15, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 61, yp: 9, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 35, yp: 14, xs: 3, ys: 15, type: 1, damage: 30)
                    addDamageBlock(xp: 25, yp: 17, xs: 1, ys: 24, type: 1, damage: 30)
                    
                    addDamageO(xp: 20, yp: 23, Size: 18, type:9, damage: 20,BloclNumber: 1)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 1)
                    addDamageO(xp: 38.5, yp: 30.5, Size: 18, type:9, damage: 20,BloclNumber: 3,Angle: 180.0)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 3)
                    addDamageO(xp: 47.5, yp: 15.5, Size: 18, type:9, damage: 20,BloclNumber: 4,Angle: 90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    addDamageO(xp: 54.5, yp: 28.5, Size: 18, type:9, damage: 20,BloclNumber: 5,Angle: -90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 5)
                    
                    additem(xp: 47, yp: 36, type: 2, number: 2)
                }
                if difficulty == 1{
                    addenemy(xp: 80, yp: 15, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 70, yp: 15, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 61, yp: 9, type: 32, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addDamageBlock(xp: 35, yp: 14, xs: 3, ys: 15, type: 1, damage: 200)
                    addDamageBlock(xp: 25, yp: 17, xs: 1, ys: 24, type: 1, damage: 200)
                    
                    addDamageO(xp: 20, yp: 23, Size: 18, type:9, damage: 40,BloclNumber: 1)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 1)
                    addDamageO(xp: 38.5, yp: 30.5, Size: 18, type:9, damage: 40,BloclNumber: 3,Angle: 180.0)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 3)
                    addDamageO(xp: 47.5, yp: 15.5, Size: 18, type:9, damage: 40,BloclNumber: 4,Angle: 90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    addDamageO(xp: 54.5, yp: 28.5, Size: 18, type:9, damage: 40,BloclNumber: 5,Angle: -90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 5)
                    addDamageO(xp: 36.5, yp: 9.5, Size: 18, type:9, damage: 40,BloclNumber: 4,Angle: 0)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    
                    
                }
                
            }
        }
        
        if stageNumber == 24{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12) {
                let StageDis:[CGFloat] = [124,36]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 63, py: 5)
                    if difficulty == 0 { additem(xp: 68, yp: 32, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 68, yp: 32, type: 3, number: 12) }
                }else if  sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 68, py: 32)
                    if difficulty == 0 { additem(xp: 63, yp: 5, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 63, yp: 5, type: 3, number: 11) }
                }else{
                    addplayer(px: 2, py: 3)
                    if difficulty == 0 {
                        additem(xp: 63, yp: 5, type: 3, number: 1)
                        additem(xp: 68, yp: 32, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 63, yp: 5, type: 3, number: 11)
                        additem(xp: 68, yp: 32, type: 3, number: 12)
                    }
                }
                
                
                addBlock(xp: 0, yp: 6, xs: 2, ys: 30, type: 9)
                addBlock(xp: 29, yp: 0, xs: 2, ys: 33, type: 9)
                addBlock(xp: 0, yp: 0, xs: 7, ys: 1, type: 9)
                addBlock(xp: 7, yp: 0, xs: 22, ys: 3, type: 9)
                addBlock(xp: 2, yp: 6, xs: 24, ys: 2, type: 9)
                addBlock(xp: 5, yp: 11, xs: 24, ys: 2, type: 9)
                addBlock(xp: 2, yp: 16, xs: 24, ys: 2, type: 9)
                addBlock(xp: 5, yp: 21, xs: 24, ys: 2, type: 9)
                addBlock(xp: 2, yp: 26, xs: 24, ys: 2, type: 9)
                addBlock(xp: 5, yp: 31, xs: 24, ys: 2, type: 9)
                
                addBlock(xp: 31, yp: 0, xs: 47, ys: 3, type: 9)
                addBlock(xp: 58, yp: 6, xs: 2, ys: 30, type: 9)
                addBlock(xp: 31, yp: 31, xs: 18, ys: 2, type: 9)
                addBlock(xp: 53, yp: 31, xs: 5, ys: 2, type: 9)
                
                addBlock(xp: 31, yp: 26, xs: 10, ys: 2, type: 9)
                addBlock(xp: 48, yp: 26, xs: 10, ys: 2, type: 9)
                addBlock(xp: 34, yp: 21, xs: 21, ys: 2, type: 9)
                addBlock(xp: 31, yp: 16, xs: 6, ys: 2, type: 9)
                addBlock(xp: 41, yp: 16, xs: 7, ys: 2, type: 9)
                addBlock(xp: 52, yp: 16, xs: 6, ys: 2, type: 9)
                addBlock(xp: 36, yp: 11, xs: 6, ys: 2, type: 9)
                addBlock(xp: 47, yp: 11, xs: 6, ys: 2, type: 9)
                addBlock(xp: 31, yp: 6, xs: 6, ys: 2, type: 9)
                addBlock(xp: 41, yp: 6, xs: 7, ys: 2, type: 9)
                addBlock(xp: 52, yp: 6, xs: 6, ys: 2, type: 9)
                
                addBlockO(xp: 75, yp: 5, Size: 5, type: 10,BloclNumber: 1)
                addmoveAction(xmove: 10, ymove: 0, time: 5, BlockNumber: 1, type: 4, Actiontype: 2, SwitchNumber: 1)
                addSwitch(xp: 77.5, yp: 3.5, SwitchNumber: 1)
                addBlock(xp: 65, yp: 28, xs: 7, ys: 2, type: 9)
                addDamageBlock(xp: 78, yp: 0, xs: 46, ys: 3, type: 1, damage: 200)
                addDamageBlock(xp: 60, yp: 11, xs:54, ys: 2, type: 1, damage: 200)
                addDamageBlock(xp: 65, yp: 18, xs: 7, ys: 10, type: 1, damage: 50)
                addDamageBlock(xp: 72, yp: 25, xs: 52, ys: 2, type: 1, damage: 200)
                
                addBar(xp: 121, yp: 7)
                addBlock(xp: 114, yp: 11, xs: 6, ys: 2, type: 9)
                
                addBar(xp: 100, yp: 17)
                addBar(xp: 96, yp: 20)
                addBar(xp: 91, yp: 20)
                addBar(xp: 86, yp: 20)
                addBar(xp: 81, yp: 20)
                addBar(xp: 76, yp: 20)
                addDamageO(xp: 80, yp: 14, Size: 5, type: 8, damage: 20)
                addDamageO(xp: 84, yp: 14, Size: 5, type: 8, damage: 20)
                addDamageO(xp: 88, yp: 14, Size: 5, type: 8, damage: 20)
                addDamageO(xp: 92, yp: 14, Size: 5, type: 8, damage: 20)
                addDamageO(xp: 96, yp: 14, Size: 5, type: 8, damage: 20)
                
                addBar(xp: 62, yp: 17)
                addvector(xp: 61, yp: 19, Angle: -170, Size: 3)
                
                addBar(xp: 74, yp: 31, BloclNumber: 5)
                addmoveAction(xmove: 19, ymove: 0, time: 10, BlockNumber: 5,interval: 3.0)
                addBar(xp: 117, yp: 31, BloclNumber: 6)
                addmoveAction(xmove: -19, ymove: 0, time: 10, BlockNumber: 6,interval: 3.0)
                
                addgoal(xp: 121.5, yp: 32.5)
                
                if difficulty == 0 {
                    addenemy(xp: 15, yp: 8, type: 32, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 15, yp: 19, type: 32, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 15, yp: 29, type: 32, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 28, type: 32, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 19, type: 32, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 12, type: 32, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 4, type: 32, HP: 50, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    additem(xp: 57, yp: 33, type: 2, number: 2)
                    additem(xp: 31, yp: 3, type: 2, number: 2)
                    
                    addDamageO(xp: 92, yp: 3, Size: 3, type: 8, damage: 20,BloclNumber: 2)
                    addmoveAction(xmove: 22, ymove: 0, time: 10.0, BlockNumber: 2)
                    
                    addBlockO(xp: 113, yp: 15, Size: 5, type: 10,BloclNumber: 3)
                    addmoveAction(xmove: -3.5, ymove: 0, time: 5, BlockNumber: 3, type: 4, Actiontype: 2, SwitchNumber: 3)
                    addSwitch(xp: 110.5, yp: 13.5, SwitchNumber: 3)
            
                    addvector(xp: 60.5, yp: 26.5, Angle: 135, Size: 3)
                    addBar(xp: 62, yp: 28)
                    
                    addDamageO(xp: 80, yp: 31, Size: 11, type: 9, damage: 20,BloclNumber: 7)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 7)
                    addDamageO(xp: 85, yp: 31, Size: 11, type: 9, damage: 20,BloclNumber: 8,Angle: 90)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 8)
                    
                    addDamageO(xp: 104, yp: 31, Size: 11, type: 9, damage: 20,BloclNumber: 9)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 9)
                    addDamageO(xp: 107, yp: 31, Size: 11, type: 9, damage: 20,BloclNumber: 10,Angle: 90)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 10)
                    addDamageO(xp: 110, yp: 31, Size: 11, type: 9, damage: 20,BloclNumber: 11,Angle: 180)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 11)
                }
                if difficulty == 1 {
                    addenemy(xp: 15, yp: 8, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 15, yp: 19, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 15, yp: 29, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 15, yp: 29, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 28, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 19, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 14, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 9, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 44, yp: 4, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 92, yp: 3, Size: 4, type: 8, damage: 40,BloclNumber: 2)
                    addmoveAction(xmove: 22, ymove: 0, time: 10.0, BlockNumber: 2)
                    
                    addBlockO(xp: 113, yp: 15, Size: 5, type: 10,BloclNumber: 3)
                    addmoveAction(xmove: -10, ymove: 0, time: 5, BlockNumber: 3, type: 4, Actiontype: 2, SwitchNumber: 2)
                    addmoveAction(xmove: -5, ymove: 0, time: 5, BlockNumber: 3, type: 4, Actiontype: 2, SwitchNumber: 3)
                    addSwitch(xp: 110.5, yp: 13.5, SwitchNumber: 2)
                    addSwitch(xp: 104.5, yp: 13.5, SwitchNumber: 3)
           
                    addvector(xp: 61, yp: 28, Angle: 135, Size: 3)
                    
                    addDamageO(xp: 80, yp: 31, Size: 11, type: 9, damage: 50,BloclNumber: 7)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 7)
                    addDamageO(xp: 85, yp: 31, Size: 11, type: 9, damage: 50,BloclNumber: 8,Angle: 90)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 8)
                    
                    addDamageO(xp: 104, yp: 31, Size: 11, type: 9, damage: 50,BloclNumber: 9)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 9)
                    addDamageO(xp: 107, yp: 31, Size: 11, type: 9, damage: 50,BloclNumber: 10,Angle: 90)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 10)
                    addDamageO(xp: 110, yp: 31, Size: 11, type: 9, damage: 50,BloclNumber: 11,Angle: 180)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 11)
                    
                    addDamageO(xp: 95.5, yp: 28, Size: 5, type: 8, damage: 50,BloclNumber: 12)
                    addmoveAction(xmove: 0, ymove: 8, time: 4.0, BlockNumber: 12,interval: 1.0)
                }
            }
        }
        
        if stageNumber == 25{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [101,40]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 86, py: 32, DFlag: false)
                }else{
                    addplayer(px: 97, py: 5, DFlag: false)
                    if difficulty == 0 { additem(xp: 86, yp: 32, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 86, yp: 32, type: 3, number: 1) }
                }
     
                addBlock(xp: 63, yp: 0, xs: 38, ys: 3, type: 9)
                addBlock(xp: 83, yp: 19, xs: 11, ys: 2, type: 9)
                addBlock(xp: 83, yp: 26, xs: 11, ys: 4, type: 9)
                addBlock(xp: 97, yp: 22, xs: 4, ys: 4, type: 9)
 
                addvector(xp: 84, yp: 10, Angle: 0, Size: 3)
                
                addBar(xp: 88, yp: 10, type: 2, BloclNumber: 1)
                addrotateAction(dsita: 90, time: 5.0, BlockNumber: 1)
                addBar(xp: 73.5, yp: 12.5, type: 3, BloclNumber: 2)
                addrotateAction(dsita: -90, time: 10.0, BlockNumber: 2)
                addvector(xp: 77, yp: 21, Angle: 110, Size: 3)
                
                addBar(xp: 56, yp: 33)
                addBar(xp: 61, yp: 33)
                addBar(xp: 66, yp: 33)
                addBar(xp: 71, yp: 33)
                addBar(xp: 76, yp: 33)
                addBar(xp: 81, yp: 33)
                addvector(xp: 56, yp: 31, Angle: 0, Size: 3)
                
                addBlock(xp: 0, yp: 0, xs: 61, ys: 3, type: 9)
                additem(xp: 60, yp: 3, type: 2, number: 2)
                
                if difficulty == 0 {
                    addDamageBlock(xp: 50, yp: 7, xs: 2, ys: 33, type: 1, damage: 40)
                    addDamageBlock(xp: 52, yp: 38, xs: 49, ys: 2, type: 1, damage: 40)
                    addDamageBlock(xp: 61, yp: 0, xs: 2, ys: 28, type: 1, damage: 40)
                    addDamageBlock(xp: 63, yp: 26, xs: 20, ys: 2, type: 1, damage: 40)
                    addDamageBlock(xp: 84, yp: 17, xs: 17, ys: 2, type: 1, damage: 40)
                    
                    addDamageO(xp: 67, yp: 4, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 67, yp: 11, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 67, yp: 14, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 67, yp: 20, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 73, yp: 18, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 79, yp: 14, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 82, yp: 15, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 85, yp: 15, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 88, yp: 4, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 88, yp: 7, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 88, yp: 10, Size: 5, type: 8, damage: 20)
                    
                    addDamageO(xp: 81, yp: 33, Size: 12, type: 9, damage: 20,BloclNumber: 3)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 3)
                    addmoveAction(xmove: -25, ymove: 0, time: 12, BlockNumber: 3,firstinterval: 0)
                    addDamageO(xp: 56, yp: 33, Size: 12, type: 9, damage: 20,BloclNumber: 4,Angle: 90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    addmoveAction(xmove: 25, ymove: 0, time: 12, BlockNumber: 4,firstinterval: 0)
                    
                    addenemy(xp: 39, yp: 4, type: 4, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 34, yp: 4, type: 14, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 8, type: 27, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 19, yp: 8, type: 27, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 4, type: 4, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 11, yp: 4, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 0.5, yp: 3.5, Size: 2, moveStageN: 25, moveSceneN: 2, type: 2)
                   
                }
                if difficulty == 1 {
                    addDamageBlock(xp: 50, yp: 7, xs: 2, ys: 33, type: 1, damage: 200)
                    addDamageBlock(xp: 52, yp: 38, xs: 49, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 61, yp: 0, xs: 2, ys: 28, type: 1, damage: 200)
                    addDamageBlock(xp: 63, yp: 26, xs: 20, ys: 2, type: 1, damage: 200)
                    addDamageBlock(xp: 84, yp: 17, xs: 17, ys: 2, type: 1, damage: 200)
                    
                    addDamageO(xp: 67, yp: 4, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 67, yp: 11, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 67, yp: 14, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 67, yp: 20, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 73, yp: 19, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 80, yp: 3, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 79, yp: 14, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 82, yp: 15, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 85, yp: 15, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 88, yp: 4, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 88, yp: 7, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 88, yp: 10, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 91, yp: 11, Size: 5, type: 8, damage: 50)
                    
                    addDamageO(xp: 81, yp: 33, Size: 12, type: 9, damage: 60,BloclNumber: 3)
                    addrotateAction(dsita: -90, time: 4.0, BlockNumber: 3)
                    addmoveAction(xmove: -25, ymove: 0, time: 12, BlockNumber: 3,firstinterval: 0)
                    addDamageO(xp: 56, yp: 33, Size: 12, type: 9, damage: 60,BloclNumber: 4,Angle: 90)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 4)
                    addmoveAction(xmove: 25, ymove: 0, time: 12, BlockNumber: 4,firstinterval: 0)
                    addDamageO(xp: 56, yp: 33, Size: 12, type: 9, damage: 60,BloclNumber: 5,Angle: 180)
                    addrotateAction(dsita: 90, time: 4.0, BlockNumber: 5)
                    addmoveAction(xmove: 25, ymove: 0, time: 12, BlockNumber: 5,firstinterval: 6.0)
                    
                    addenemy(xp: 39, yp: 4, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 34, yp: 4, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 8, type: 28, HP: 20, Damage: 30, direction: true, maxn: 2, interval: 4.0)
                    addenemy(xp: 19, yp: 8, type: 28, HP: 20, Damage: 30, direction: true, maxn: 2, interval: 4.0)
                    addenemy(xp: 16, yp: 4, type: 17, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 11, yp: 4, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 0.5, yp: 3.5, Size: 2, moveStageN: 25, moveSceneN: 12, type: 2)
                }
                
            }
            if (2 <= sceneNumber && sceneNumber <= 4) || (12 <= sceneNumber && sceneNumber <= 14){
                let StageDis:[CGFloat] = [101,100]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 3 || sceneNumber == 13{
                    addplayer(px: 15, py: 4, DFlag: false)
                    if difficulty == 0 { additem(xp: 19, yp: 93, type: 3, number: 4) }
                    if difficulty == 1 { additem(xp: 19, yp: 93, type: 3, number: 14) }
                }else if sceneNumber == 4 || sceneNumber == 14{
                    addplayer(px: 19, py: 93)
                    if difficulty == 0 { additem(xp: 15, yp: 4, type: 3, number: 3) }
                    if difficulty == 1 { additem(xp: 15, yp: 4, type: 3, number: 13) }
                }else{
                    addplayer(px: 98, py: 5, DFlag: false)
                    if difficulty == 0 {
                        additem(xp: 15, yp: 4, type: 3, number: 3)
                        additem(xp: 19, yp: 93, type: 3, number: 4)
                    }
                    if difficulty == 1 {
                        additem(xp: 15, yp: 4, type: 3, number: 13)
                        additem(xp: 19, yp: 93, type: 3, number: 14)
                    }
                }

                addBlock(xp: 89, yp: 0, xs: 12, ys: 3, type: 9)
                addBlock(xp: 0, yp: 0, xs: 18, ys: 3, type: 9)
                addDamageBlock(xp: 18, yp: 0, xs: 71, ys: 3, type: 1, damage: 200)
                addBlock(xp: 16, yp: 88, xs: 12, ys: 3, type: 9)
                addBlock(xp: 95, yp: 90, xs: 6, ys: 2, type: 9)
                addgoal(xp: 99.5, yp: 92.5)

                addBar(xp: 87, yp: 7, BloclNumber: 1)
                addmoveAction(xmove: -68, ymove: 0, time: 50, BlockNumber: 1, interval: 10.0, firstinterval: 5.0, SwitchNumber: 1)
                addSwitch(xp: 89.5, yp: 3.5, SwitchNumber: 1)
                
                addBar(xp: 5, yp: 6, BloclNumber: 6)
                addBar(xp: 12, yp: 6, BloclNumber: 7)
                addmoveAction(xmove: 0, ymove: 85, time: 70, BlockNumber: 6, interval: 10.0, firstinterval: 5.0, SwitchNumber: 2)
                addmoveAction(xmove: 0, ymove: 85, time: 70, BlockNumber: 7, interval: 10.0, firstinterval: 5.0, SwitchNumber: 3)
                addSwitch(xp: 9.5, yp: 3.5, SwitchNumber: [2,3])
                
                
                addvector(xp: 5, yp: 44, Angle: 135, Size: 3)
                addvector(xp: 12, yp: 61, Angle: -135, Size: 3)
                addvector(xp: 8, yp: 91, Angle: 90, Size: 3)
                
                addBar(xp: 29, yp: 94, BloclNumber: 13)
                addmoveAction(xmove: 65, ymove: 0, time: 50, BlockNumber: 13, interval: 10.0, firstinterval: 5.0, SwitchNumber: 4)
                addSwitch(xp: 26.5, yp: 91.5, SwitchNumber: 4)
                
                if difficulty == 0 {
                    addDamageO(xp: 74, yp: 4, Size: 5, type: 8, damage: 20)
                    addDamageO(xp: 74, yp: 6.5, Size: 5, type: 8, damage: 20)
                    
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 20,BloclNumber: 2,Angle: 0)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 2)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 2,firstinterval: 0)
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 20,BloclNumber: 3,Angle: 180)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 3)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 3,firstinterval: 5.0)
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 20,BloclNumber: 20,Angle: 90)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 20)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 20,firstinterval: 2.5)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 20,BloclNumber: 4,Angle: 0)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 4)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 4,firstinterval: 0)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 20,BloclNumber: 5,Angle: 180)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 5)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 5,firstinterval: 5.0)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 20,BloclNumber: 22,Angle: 90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 22)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 22,firstinterval: 2.5)
                    
                    addDamageO(xp: 4.5, yp: 15.5, Size: 14, type: 9, damage: 20,BloclNumber: 8,Angle: -90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 8)
                    addDamageO(xp: 4.5, yp: 23.5, Size: 14, type: 9, damage: 20,BloclNumber: 9,Angle: 90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 9)
                    addDamageO(xp: 4.5, yp: 32.5, Size: 14, type: 9, damage: 20,BloclNumber: 10,Angle: 0)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 10)
                    addDamageO(xp: 12.5, yp: 19.5, Size: 14, type: 9, damage: 20,BloclNumber: 11,Angle: 0)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 11)
                    addDamageO(xp: 12.5, yp: 27.5, Size: 14, type: 9, damage: 20,BloclNumber: 12,Angle: 180)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 12)
                    
                    addDamageO(xp: 5, yp: 55, Size: 15, type: 8, damage: 20)
                    addDamageO(xp: 12, yp: 71, Size: 15, type: 8, damage: 20)
                    addenemy(xp: 0, yp: 80, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 40, yp: 91, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 48, yp: 93, type: 31, HP: 30, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 56, yp: 95, type: 31, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 66, yp: 90, type: 32, HP: 50, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 77, yp: 97, type: 32, HP: 50, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 86, yp: 90, type: 32, HP: 50, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                }
                if difficulty == 1 {
                    addBar(xp: 78, yp: 10)
                    addBar(xp: 74, yp: 13)
                    addBar(xp: 70, yp: 10)
                    addDamageO(xp: 74, yp: 4, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 74, yp: 6.5, Size: 5, type: 8, damage: 50)
                    addDamageO(xp: 74, yp: 9, Size: 5, type: 8, damage: 50)
                    
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 2,Angle: 0)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 2)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 2,firstinterval: 0)
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 3,Angle: 180)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 3)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 3,firstinterval: 5.0)
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 20,Angle: 90)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 20)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 20,firstinterval: 2.5)
                    addDamageO(xp: 60.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 21,Angle: -90)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 21)
                    addmoveAction(xmove: -34, ymove: 0, time: 20, BlockNumber: 21,firstinterval: 7.5)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 4,Angle: 0)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 4)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 4,firstinterval: 0)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 5,Angle: 180)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 5)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 5,firstinterval: 5.0)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 22,Angle: 90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 22)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 22,firstinterval: 2.5)
                    addDamageO(xp: 26.5, yp: 8.5, Size: 14, type: 9, damage: 50,BloclNumber: 23,Angle: -90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 23)
                    addmoveAction(xmove: 34, ymove: 0, time: 20, BlockNumber: 23,firstinterval: 7.5)
                    
                    addDamageO(xp: 4.5, yp: 15.5, Size: 14, type: 9, damage: 50,BloclNumber: 8,Angle: -90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 8)
                    addDamageO(xp: 4.5, yp: 23.5, Size: 14, type: 9, damage: 50,BloclNumber: 9,Angle: 90)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 9)
                    addDamageO(xp: 4.5, yp: 32.5, Size: 14, type: 9, damage: 50,BloclNumber: 10,Angle: 0)
                    addrotateAction(dsita: 90, time: 5.0, BlockNumber: 10)
                    addDamageO(xp: 12.5, yp: 19.5, Size: 14, type: 9, damage: 50,BloclNumber: 11,Angle: 0)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 11)
                    addDamageO(xp: 12.5, yp: 27.5, Size: 14, type: 9, damage: 50,BloclNumber: 12,Angle: 180)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 12)
                    
                    addDamageO(xp: 5, yp: 55, Size: 20, type: 8, damage: 200)
                    addDamageO(xp: 12, yp: 71, Size: 20, type: 8, damage: 200)
                    addenemy(xp: 0, yp: 80, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 40, yp: 91, type: 32, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 48, yp: 93, type: 32, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 56, yp: 95, type: 32, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 66, yp: 90, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 77, yp: 97, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 86, yp: 90, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                }
            }
        }
        
        if stageNumber == 26{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [47,100]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                addplayer(px: 44, py: 5 ,DFlag:  false)
                addBlock(xp: 0, yp: 0, xs: 47, ys: 3, type: 9)
                
                addBlock(xp: 5, yp: 5, xs: 5, ys: 1, type: 9)
                addBlock(xp: 12, yp: 7, xs: 5, ys: 1, type: 9)
                addBlock(xp: 19, yp: 9, xs: 5, ys: 1, type: 9)
                addBlock(xp: 2, yp: 18, xs: 5, ys: 1, type: 9)
                addBlock(xp: 33, yp: 27, xs: 5, ys: 1, type: 9)
                addBlock(xp: 37, yp: 17, xs: 4, ys: 1, type: 9)
                addBlock(xp: 37, yp: 23, xs: 4, ys: 1, type: 9)
                addBlock(xp: 22, yp: 13, xs: 3, ys: 3, type: 9)
                addBlock(xp: 22, yp: 21, xs: 3, ys: 3, type: 9)
                addBlock(xp: 27, yp: 9, xs: 3, ys: 3, type: 9)
                addBlock(xp: 27, yp: 17, xs: 3, ys: 3, type: 9)
                addBlock(xp: 0, yp: 21, xs: 2, ys: 7, type: 9)
                addBlock(xp: 2, yp: 21, xs: 2, ys: 3, type: 9)
                addBlock(xp: 10, yp: 20, xs: 2, ys: 2, type: 9)
                addBlock(xp: 12, yp: 22, xs: 2, ys: 2, type: 9)
                addBlock(xp: 14, yp: 24, xs: 2, ys: 2, type: 9)
                addBlock(xp: 16, yp: 26, xs: 2, ys: 2, type: 9)
                
                addBlock(xp: 5, yp: 41, xs: 4, ys: 2, type: 9)
                addBlock(xp: 14, yp: 41, xs: 4, ys: 2, type: 9)
                addBlock(xp: 25, yp: 41, xs: 4, ys: 2, type: 9)
                addBlock(xp: 9, yp: 45, xs: 4, ys: 4, type: 9)
                addBlock(xp: 19, yp: 45, xs: 4, ys: 4, type: 9)
                addBlock(xp: 30, yp: 45, xs: 8, ys: 4, type: 9)
                
                addBar(xp: 2, yp: 54)
                addBar(xp: 2, yp: 62)
                addBar(xp: 3, yp: 66)
                addBar(xp: 5, yp: 50)
                addBar(xp: 6, yp: 60)
                addBar(xp: 9, yp: 53)
                addBar(xp: 10, yp: 63)
                addBar(xp: 12, yp: 59)
                addBar(xp: 14, yp: 55)
                addBar(xp: 14, yp: 65)
                addBar(xp: 15, yp: 50)
                addBar(xp: 18, yp: 62)
                addBar(xp: 19, yp: 53)
                addBar(xp: 20, yp: 57)
                addBar(xp: 23, yp: 63)
                addBar(xp: 24, yp: 54)
                addBar(xp: 26, yp: 50)
                addBar(xp: 26, yp: 59)
                addBar(xp: 27, yp: 65)
                addBar(xp: 29, yp: 53)
                addBar(xp: 31, yp: 63)
                addBar(xp: 33, yp: 57)
                addBar(xp: 36, yp: 53)
                addBar(xp: 37, yp: 63)
                addBar(xp: 38, yp: 66)
                addBar(xp: 39, yp: 60)
                
                addBlock(xp: 5, yp: 67, xs: 7, ys: 2, type: 9)
                addBlock(xp: 17, yp: 67, xs: 7, ys: 2, type: 9)
                addBlock(xp: 29, yp: 67, xs: 7, ys: 2, type: 9)
                addBlock(xp: 0, yp: 72, xs: 6, ys: 4, type: 9)
                addBlock(xp: 6, yp: 72, xs: 5, ys: 1, type: 9)
                addBlock(xp: 11, yp: 72, xs: 7, ys: 4, type: 9)
                addBlock(xp: 23, yp: 72, xs: 7, ys: 4, type: 9)
                addBlock(xp: 30, yp: 72, xs: 5, ys: 1, type: 9)
                addBlock(xp: 35, yp: 72, xs: 6, ys: 4, type: 9)
                
                addBlock(xp: 43, yp: 8, xs: 4, ys: 2, type: 9)
                addBlock(xp: 41, yp: 8, xs: 2, ys: 86, type: 9)
                addBlock(xp: 41, yp: 94, xs: 6, ys: 2, type: 8)
                
                addvector(xp: 1, yp: 92, Angle: 90, Size: 3)
                addvector(xp: 38, yp: 93, Angle: 135, Size: 3)
                
                if difficulty == 0 {
                    addenemy(xp: 20, yp: 3, type: 47, HP: 100, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 70, type: 47, HP: 100, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    additem(xp: 0, yp: 28, type: 2, number: 2)
                    additem(xp: 34, yp: 49, type: 2, number: 2)
                    additem(xp: 8, yp: 69, type: 2, number: 2)
                    additem(xp: 32, yp: 73, type: 2, number: 2)
                    additem(xp: 3, yp: 90, type: 2, number: 2)
                    
                    addBlock(xp: 5, yp: 13, xs: 5, ys: 3, type: 9)
                    addBlock(xp: 13, yp: 11, xs: 4, ys: 3, type: 9)
                    addBlock(xp: 15, yp: 17, xs: 5, ys: 3, type: 9)
                    addBlock(xp: 28, yp: 22, xs: 5, ys: 3, type: 9)
                    addBlock(xp: 32, yp: 13, xs: 4, ys: 3, type: 9)
                    
                    addBar(xp: 3, yp: 30)
                    addBar(xp: 3, yp: 36)
                    addBar(xp: 3, yp: 41)
                    addBar(xp: 7, yp: 33)
                    addBar(xp: 7, yp: 39)
                    addBar(xp: 11, yp: 30)
                    addBar(xp: 11, yp: 36)
                    addBar(xp: 11, yp: 41)
                    addBar(xp: 15, yp: 33)
                    addBar(xp: 15, yp: 38)
                    addBar(xp: 19, yp: 30)
                    addBar(xp: 19, yp: 36)
                    addBar(xp: 21, yp: 41)
                    addBar(xp: 23, yp: 33)
                    addBar(xp: 23, yp: 39)
                    addBar(xp: 27, yp: 30)
                    addBar(xp: 27, yp: 36)
                    addBar(xp: 31, yp: 33)
                    addBar(xp: 31, yp: 38)
                    addBar(xp: 32, yp: 41)
                    addBar(xp: 35, yp: 30)
                    addBar(xp: 35, yp: 36)
                    
                    addBlock(xp: 5, yp: 79, xs: 7, ys: 4, type: 9)
                    addBlock(xp: 17, yp: 79, xs: 7, ys: 4, type: 9)
                    addBlock(xp: 29, yp: 79, xs: 7, ys: 4, type: 9)
                    addBlock(xp: 0, yp: 86, xs: 6, ys: 4, type: 9)
                    addBlock(xp: 11, yp: 86, xs: 7, ys: 4, type: 9)
                    addBlock(xp: 23, yp: 86, xs: 7, ys: 4, type: 9)
                    addBlock(xp: 35, yp: 86, xs: 6, ys: 4, type: 9)
                    
                    addmoveStageO(xp: 45.5, yp: 96.5, Size: 2, moveStageN: 26, moveSceneN: 1, type: 1)
                }
                
                if difficulty == 1 {
                    addenemy(xp: 20, yp: 3, type: 47, HP: 999, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 76, type: 47, HP: 999, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    additem(xp: 0, yp: 28, type: 2, number: 2)
                    additem(xp: 32, yp: 73, type: 2, number: 2)
                    
                    addBlock(xp: 7, yp: 13, xs: 3, ys: 3, type: 9)
                    addBlock(xp: 13, yp: 11, xs: 3, ys: 3, type: 9)
                    addBlock(xp: 17, yp: 17, xs: 3, ys: 3, type: 9)
                    addBlock(xp: 29, yp: 22, xs: 3, ys: 3, type: 9)
                    addBlock(xp: 32, yp: 13, xs: 3, ys: 3, type: 9)
                    
                    addBlockO(xp: 2, yp: 40, Size: 5, type: 9,BloclNumber: 1)
                    addmoveAction(xmove: 3, ymove: -12, time: 10, BlockNumber: 1, interval: 3.0)
                    addBlockO(xp: 12, yp: 28, Size: 5, type: 9,BloclNumber: 2)
                    addmoveAction(xmove: -1, ymove: 12, time: 10, BlockNumber: 2, interval: 3.0)
                    addBlockO(xp: 21, yp: 40, Size: 5, type: 9,BloclNumber: 3)
                    addmoveAction(xmove: 0, ymove: -12, time: 10, BlockNumber: 3, interval: 3.0)
                    addBlockO(xp: 28, yp: 28, Size: 5, type: 9,BloclNumber: 4)
                    addmoveAction(xmove: 3, ymove: 12, time: 10, BlockNumber: 4, interval: 3.0)
                    
                    addBlock(xp: 7, yp: 79, xs: 3, ys: 4, type: 9)
                    addBlock(xp: 19, yp: 79, xs: 3, ys: 4, type: 9)
                    addBlock(xp: 31, yp: 79, xs: 3, ys: 4, type: 9)
                    addBlock(xp: 0, yp: 86, xs: 4, ys: 4, type: 9)
                    addBlock(xp: 13, yp: 86, xs: 3, ys: 4, type: 9)
                    addBlock(xp: 25, yp: 86, xs: 3, ys: 4, type: 9)
                    addBlock(xp: 37, yp: 86, xs: 4, ys: 4, type: 9)
                    
                    addmoveStageO(xp: 45.5, yp: 96.5, Size: 2, moveStageN: 26, moveSceneN: 11, type: 1)
                }
            }
            if sceneNumber == 1 || sceneNumber == 11 {
                let StageDis:[CGFloat] = [50,20]
                BackGroundImage(imageName: "bg4_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                addplayer(px: 2, py: 5)
                
                if skillGet[14] == false { additem(xp: 5, yp: 3, type: 1, number: 14)  }
                addBlock(xp: 0, yp: 0, xs: 50, ys: 3, type: 8)
                addBlock(xp: 0, yp: 8, xs: 7, ys: 2, type: 8)
                addBlock(xp: 7, yp: 8, xs: 2, ys: 12, type: 8)
                addBlock(xp: 38, yp: 8, xs: 2, ys: 12, type: 8)
                addBlock(xp: 40, yp: 8, xs: 10, ys: 2, type: 8)
                
                addBlock(xp: 11, yp: 8, xs: 5, ys: 1, type: 8)
                addBlock(xp: 11, yp: 14, xs: 5, ys: 1, type: 8)
                addBlock(xp: 16, yp: 5, xs: 5, ys: 1, type: 8)
                addBlock(xp: 16, yp: 11, xs: 5, ys: 1, type: 8)
                addBlock(xp: 16, yp: 17, xs: 5, ys: 1, type: 8)
                addBlock(xp: 21, yp: 8, xs: 5, ys: 1, type: 8)
                addBlock(xp: 21, yp: 14, xs: 5, ys: 1, type: 8)
                addBlock(xp: 26, yp: 5, xs: 5, ys: 1, type: 8)
                addBlock(xp: 26, yp: 11, xs: 5, ys: 1, type: 8)
                addBlock(xp: 26, yp: 17, xs: 5, ys: 1, type: 8)
                addBlock(xp: 31, yp: 8, xs: 5, ys: 1, type: 8)
                addBlock(xp: 31, yp: 14, xs: 5, ys: 1, type: 8)
                
                addBlock(xp: 38, yp: 3, xs: 2, ys: 5, type: 5,BlockNumber: 1)
                addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 4, outtime: 2.0, SwitchNumbet: 1)
                
                
                if difficulty == 0{
                    addenemy(xp: 13, yp: 4, type: 32, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 10, type: 32, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 4, type: 32, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 18, type: 47, HP: 60, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                }
                if difficulty == 1{
                    addenemy(xp: 13, yp: 4, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 10, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 4, type: 32, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 18, type: 47, HP: 250, Damage: 30, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                }
                addgoal(xp: 48.5, yp: 3.5)
            }
        }
        
        if stageNumber == 27{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [23,30]
                BackGroundImage(imageName: "bg4_2", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                addplayer(px: 0.5, py: 3.5)
                addBlock(xp: 0, yp: 0, xs: 23, ys: 3, type: 8)
                addBlock(xp: 3, yp: 7, xs: 6, ys: 1, type: 8)
                addBlock(xp: 14, yp: 7, xs: 6, ys: 1, type: 8)
                addBar(xp: 11, yp: 6)
      
                if difficulty == 0{
                    addenemy(xp: 11, yp: 5, type: 42, HP: 140, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 18.5, yp: 8.5, Goaltype: 4, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 2.0, SwitchNumbet: 1, incontact: false)
                }
                
                if difficulty == 1{
                    enemymax = 2
                    addenemy(xp: 11, yp: 7, type: 32, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 40.0)
                    addenemy(xp: 11, yp: 5, type: 42, HP: 180, Damage: 30, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 18.5, yp: 8.5, Goaltype: 14, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 2.0, SwitchNumbet: 1, incontact: false)
                }
            }
        }
        //6¥第５エリア雪山
        if stageNumber == 28{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [45,62]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
            
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 8, py: 56)
                }else{
                    addplayer(px: 41, py: 5,DFlag: false)
                    if difficulty == 0 { additem(xp: 8, yp: 56, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 8, yp: 56, type: 3, number: 11) }
                }
                
                addBlock(xp: 0, yp: 0, xs: 45, ys: 3, type: 18)
                addBlock(xp: 11, yp: 6, xs: 1, ys: 5, type: 18)
                addBlock(xp: 31, yp: 14, xs: 1, ys: 5, type: 18)
                addBlock(xp: 27, yp: 22, xs: 1, ys: 5, type: 18)
                addBlock(xp: 35, yp: 22, xs: 1, ys: 5, type: 18)
                
                addiceBlock(xp: 5, yp: 8, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 21, yp: 8, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 29, yp: 8, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 17, yp: 16, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 25, yp: 16, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 5, yp: 24, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 13, yp: 24, xs: 5, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 21, yp: 24, xs: 5, ys: 5, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 13.5, yp: 8, xs: 4, ys: 5, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 33.5, yp: 16, xs: 4, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 29.5, yp: 24, xs: 4, ys: 5, Shapetype: 4, type: 1)
                addiceBlock(xp: 37.5, yp: 24, xs: 4, ys: 5, Shapetype: 4, type: 1)
                
                
                addvector(xp: 29.5, yp: 29.5, Angle: -90, Size: 3)
                
                addBar(xp: 6, yp: 30)
                addBar(xp: 2, yp: 37)
                addBar(xp: 7, yp: 44)
                addBar(xp: 2, yp: 51)
                
                addiceBlock(xp: 1.5, yp: 31.5, xs: 4, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 7.5, yp: 38.5, xs: 4, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 1.5, yp: 45.5, xs: 4, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 7.5, yp: 52.5, xs: 4, ys: 4, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 14.5, yp: 51.5, xs: 10, ys: 6, Shapetype: 3, type: 1)
                addiceBlock(xp: 14.5, yp: 58, xs: 10, ys: 7, Shapetype: 3, type: 1,Angle: 180)
                addiceBlock(xp: 32, yp: 58, xs: 25, ys: 7, Shapetype: 4, type: 1)
                addiceBlock(xp: 10.5, yp: 41.5, xs: 2, ys: 14, Shapetype: 4, type: 1)
                addiceBlock(xp: 27, yp: 32.5, xs: 35, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 20.5, yp: 44, xs: 18, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 34.5, yp: 43.5, xs: 10, ys: 10, Shapetype: 3, type: 1)
            
                addgoal(xp: 13.5, yp: 37.5)
                
                if difficulty == 0{
                    addBlock(xp: 7, yp: 14, xs: 1, ys: 5, type: 18)
                    addiceBlock(xp: 9.5, yp: 16, xs: 4, ys: 5, Shapetype: 4, type: 1)
                    
                    addenemy(xp: 9, yp: 8, type: 33, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 16, type: 33, HP: 20, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 9, yp: 24, type: 33, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 4, yp: 42, type: 33, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    
                    addicicle(xp: 25, yp: 53.5, xs: 1, ys: 2, damage: 20, type: 1)
                    
                    addicicle(xp: 30, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 31, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 32, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 33, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 34, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 35, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 36, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 37, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    addicicle(xp: 38, yp: 37.5, xs: 1, ys: 2, damage: 20, type: 3)
                    
                    addicicle(xp: 18, yp: 41.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 20, yp: 41.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 22, yp: 41.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 24, yp: 41.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 26, yp: 41.5, xs: 1, ys: 2, damage: 20, type: 2)
                    
                    addBlock(xp: 12, yp: 46, xs: 12, ys: 3, type: 18)
                    addBlock(xp: 24, yp: 46, xs: 3, ys: 1, type: 18)
                    addBlock(xp: 27, yp: 46, xs: 3, ys: 3, type: 18)
                    
                    additem(xp: 13, yp: 27, type: 2, number: 2)
                }
                
                if difficulty == 1{
                    addiceBlock(xp: 9, yp: 16, xs: 4, ys: 5, Shapetype: 4, type: 1)
                    
                    addenemy(xp: 9, yp: 8, type: 33, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 5, yp: 16, type: 33, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 16, type: 33, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 9, yp: 24, type: 33, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 24, type: 33, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 4, yp: 42, type: 33, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    
                    addicicle(xp: 3, yp: 42.5, xs: 1, ys: 2, damage: 30, type: 1)
                    addicicle(xp: 7, yp: 35.5, xs: 1, ys: 2, damage: 30, type: 1)
                    addicicle(xp: 6, yp: 50.5, xs: 1, ys: 2, damage: 30, type: 1)
                    
                    addicicle(xp: 25, yp: 53.5, xs: 1, ys: 2, damage: 30, type: 1)
                    
                    addicicle(xp: 30, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 31, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 32, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 33, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 34, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 35, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 36, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 37, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 38, yp: 37.5, xs: 1, ys: 2, damage: 30, type: 2)
                    
                    addicicle(xp: 18, yp: 41.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 20, yp: 41.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 22, yp: 41.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 24, yp: 41.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 26, yp: 41.5, xs: 1, ys: 2, damage: 30, type: 2)
                    
                    addicicle(xp: 17, yp: 38.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 19, yp: 38.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 21, yp: 38.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 23, yp: 38.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 25, yp: 38.5, xs: 1, ys: 2, damage: 30, type: 2)
        
                    
                    addBlock(xp: 12, yp: 46, xs: 18, ys: 3, type: 18)
                    addBlock(xp: 27, yp: 49, xs: 3, ys: 2, type: 18)
                    
                }
            }
        }
        
        if stageNumber == 29{
            if 0 <= sceneNumber && sceneNumber <= 2 || 11 <= sceneNumber && sceneNumber <= 12{
                let StageDis:[CGFloat] = [60,55]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis,BoundryType: 2)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 6, py: 16)
                    if difficulty == 0 {
                        additem(xp: 11, yp: 50, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 11, yp: 50, type: 3, number: 12)
                    }
                    additem(xp: 11, yp: 50, type: 3, number: 12)
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 11, py: 50)
                    if difficulty == 0 {
                        additem(xp: 6, yp: 16, type: 3, number: 1)
                    }
                    if difficulty == 1 {
                        additem(xp: 6, yp: 16, type: 3, number: 11)
                    }
                }else{
                    addplayer(px: 57, py: 5,DFlag: false)
                    if difficulty == 0 {
                        additem(xp: 6, yp: 16, type: 3, number: 1)
                        additem(xp: 11, yp: 50, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 6, yp: 16, type: 3, number: 11)
                        additem(xp: 11, yp: 50, type: 3, number: 12)
                    }
                }
    
                addiceBlock(xp: 52, yp: 1, xs: 15, ys: 3, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 31, yp: 3, xs: 25, ys: 3, Shapetype: 3, type: 2)

                
                addiceBlock(xp: 13, yp: 1, xs: 9, ys: 3, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 3.5, yp: 2, xs: 8, ys: 5, Shapetype: 4, type: 2)
                addiceBlock(xp: 2, yp: 5.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                addiceBlock(xp: 0.5, yp: 7.5, xs: 2, ys: 2, Shapetype: 4, type: 2)
                
                addiceBlock(xp: 35, yp: 10.5, xs: 49, ys: 2, Shapetype: 4, type: 1)
                
                addBlock(xp: 4, yp: 11, xs: 7, ys: 3, type: 18)
                addDamageBlock(xp: 11, yp: 12, xs: 49, ys: 1, type: 4, damage: 200)
                
                
                addBar(xp: 9, yp: 17)
                addBar(xp: 26, yp: 22)
                addBar(xp: 9, yp: 28)
                addBar(xp: 9, yp: 34)
                addBar(xp: 3, yp: 41)
                addBar(xp: 6, yp: 45)
                
                addiceBlock(xp: 14, yp: 18.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                addiceBlock(xp: 21, yp: 19.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                addiceBlock(xp: 21, yp: 24.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                addiceBlock(xp: 14, yp: 25.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                addiceBlock(xp: 4, yp: 30.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                addiceBlock(xp: 4, yp: 36.5, xs: 5, ys: 2, Shapetype: 4, type: 2)
                
                addiceBlock(xp: 12, yp: 46, xs: 7, ys: 3, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 25, yp: 44.5, xs: 7, ys: 2, Shapetype: 4, type: 3)
                addiceBlock(xp: 31, yp: 42.5, xs: 9, ys: 2, Shapetype: 4, type: 3)
                
                addvector(xp: 23, yp: 41, Angle: 90, Size: 3)
                addvector(xp: 29, yp: 42, Angle: 135, Size: 3)
                addvector(xp: 36, yp: 31, Angle: 135, Size: 3)
                
                addiceBlock(xp: 42, yp: 29, xs: 7, ys: 3, Shapetype: 4, type: 1)
              
                addiceBlock(xp: 52.5, yp: 33.5, xs: 12, ys: 2, Shapetype: 1, type: 2)
                addiceBlock(xp: 43.5, yp: 36.5, xs: 12, ys: 2, Shapetype: 1, type: 2)
                addiceBlock(xp: 49.5, yp: 42.5, xs: 12, ys: 2, Shapetype: 4, type: 2)
                
                
                addiceBlock(xp: 40.5, yp: 49, xs: 6, ys: 1, Shapetype: 1, type: 2)
                addiceBlock(xp: 46.5, yp: 49, xs: 6, ys: 1, Shapetype: 1, type: 2)
                addiceBlock(xp: 52.5, yp: 49, xs: 5, ys: 1, Shapetype: 1, type: 2)
                addiceBlock(xp: 46, yp: 48, xs: 17, ys: 1, Shapetype: 4, type: 2)
                
                addBar(xp: 40, yp: 39)
                addBar(xp: 57, yp: 48)
                
                addgoal(xp: 39.5, yp: 51.5)
            
                if difficulty == 0{
                    addenemy(xp: 9, yp: 6, type: 33, HP: 20, Damage: 15, direction: true, maxn: 1, interval: 1.0)
                    addBar(xp: 2, yp: 10)
                    
                    addicicle(xp: 20, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 23, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 26, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 29, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 32, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 35, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 39, yp: 8.5, xs: 1, ys: 2, damage: 20, type: 2)
                    
                    addDamageBlock(xp: 29, yp: 13, xs: 2, ys: 25, type: 2, damage: 50)
                    addDamageBlock(xp: 24, yp: 43, xs: 2, ys: 12, type: 2, damage: 50)
                    addDamageBlock(xp: 36, yp: 35, xs: 2, ys: 20, type: 2, damage: 50)
                    
                    addBar(xp: 52, yp: 36)
                    
                    addBlock(xp: 56, yp: 43, xs: 4, ys: 2, type: 18)
                    
                    addicicle(xp: 45, yp: 54, xs: 1, ys: 1, damage: 20, type: 2)
                    addicicle(xp: 51, yp: 54, xs: 1, ys: 1, damage: 20, type: 2)
                    
                    addiceBlock(xp: 20, yp: 46.5, xs: 7, ys: 2, Shapetype: 4, type: 3)
                }
                
                if difficulty == 1{
                    addenemy(xp: 9, yp: 6, type: 34, HP: 40, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addicicle(xp: 20, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 23, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 26, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 29, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 32, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 35, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 39, yp: 7.5, xs: 1, ys: 4, damage: 40, type: 2)
                    
                    addicicle(xp: 7, yp: 9.5, xs: 1, ys: 2, damage: 40, type: 2)
                    
                    addDamageBlock(xp: 29, yp: 13, xs: 2, ys: 27, type: 2, damage: 200)
                    addDamageBlock(xp: 24, yp: 43, xs: 2, ys: 12, type: 2, damage: 200)
                    addDamageBlock(xp: 36, yp: 35, xs: 2, ys: 20, type: 2, damage: 200)
                    
                    addiceBlock(xp: 57, yp: 44, xs: 5, ys: 3, Shapetype: 2, type: 1)
                    
                    addicicle(xp: 26, yp: 30, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 22, yp: 31, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 18, yp: 32, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 14, yp: 33, xs: 1, ys: 3, damage: 40, type: 2)
                    
                    addicicle(xp: 9, yp: 42, xs: 1, ys: 3, damage: 40, type: 2)
                    
                    addicicle(xp: 3, yp: 48.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 5, yp: 50.5, xs: 1, ys: 4, damage: 40, type: 2)
                    addicicle(xp: 7, yp: 52.5, xs: 1, ys: 4, damage: 40, type: 2)
                    
                    addicicle(xp: 17, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 20, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 23, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    
                    addiceBlock(xp: 20, yp: 46.5, xs: 7, ys: 2, Shapetype: 4, type: 2)
                    
                    addicicle(xp: 42, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 45, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 48, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 51, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)
                    addicicle(xp: 54, yp: 53, xs: 1, ys: 3, damage: 40, type: 2)                 
                }
            }
        }
        
        if stageNumber == 30{
            enemymax = 5
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [41,40]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 15)
                
                addiceBlock(xp: 3.5, yp: 11.5, xs: 8, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 16, yp: 12.5, xs: 11, ys: 2, Shapetype: 4, type: 4)
                addiceBlock(xp: 29, yp: 12.5, xs: 9, ys: 2, Shapetype: 2, type: 4)
                addiceBlock(xp: 38, yp: 11.5, xs: 5, ys: 4, Shapetype: 4, type: 1)
                addBlock(xp: 0, yp: 0, xs: 41, ys: 3, type: 18)
                adddoor(xp: 39, yp: 14.5, movepx: 1, movepy: 37)
                
                addiceBlock(xp: 1.5, yp: 29.5, xs: 4, ys: 12, Shapetype: 4, type: 1)
                addiceBlock(xp: 9.5, yp: 29.5, xs: 12, ys: 12, Shapetype: 3, type: 1)
                addBlock(xp: 0, yp: 21, xs: 16, ys: 3, type: 18)
                addvector(xp: 13, yp: 30, Angle: 135, Size: 3)
                addvector(xp: 15, yp: 28, Angle: 135, Size: 3)
                addvector(xp: 17, yp: 26, Angle: 135, Size: 3)
                
                addBlock(xp: 22, yp: 21, xs: 19, ys: 3, type: 18)
                addiceBlock(xp: 33, yp: 27, xs: 15, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 31, yp: 31, xs: 19, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 31, yp: 35, xs: 19, ys: 1, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 21, yp: 35, xs: 1, ys: 9, Shapetype: 4, type: 1)
                
                addmoveStageO(xp: 2, yp: 3.5, Size: 2, moveStageN: 30, moveSceneN: 0, type: 41)
                
                if difficulty == 0{
                    addenemy(xp: 8, yp: 4, type: 1, HP: 20, Damage: 20, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 13, yp: 4, type: 1, HP: 20, Damage: 20, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 33, yp: 4, type: 1, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 36, yp: 4, type: 1, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 10.0)
                    
                    adddoor(xp: 39, yp: 24.5, movepx: 33, movepy: 29)
                    adddoor(xp: 27, yp: 28.5, movepx: 23, movepy: 25)
                    adddoor(xp: 39, yp: 28.5, movepx: 34, movepy: 33)
                    adddoor(xp: 23, yp: 32.5, movepx: 36, movepy: 29)
                    adddoor(xp: 39, yp: 32.5, movepx: 34, movepy: 37)
                    adddoor(xp: 39, yp: 36.5, movepx: 23, movepy: 25)
                    addmoveStageO(xp: 23, yp: 36.5, Size: 2, moveStageN: 30, moveSceneN: 1, type: 40)
                    
                    adddoor(xp: 20.5, yp: 21.5, movepx: 23, movepy: 25)
                    
                    addenemy(xp: 35, yp: 25, type: 33, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 29, type: 33, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 37, yp: 37, type: 33, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addenemy(xp: 8, yp: 4, type: 7, HP: 20, Damage: 30, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 13, yp: 4, type: 7, HP: 20, Damage: 30, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 33, yp: 4, type: 7, HP: 20, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 36, yp: 4, type: 7, HP: 20, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    
                    addicicle(xp: 13, yp: 19.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 32, yp: 19.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addenemy(xp: 15, yp: 15, type: 33, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 29, yp: 14, type: 33, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    addicicle(xp: 5, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 6, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 7, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 2)
                    
                    adddoor(xp: 39, yp: 24.5, movepx: 33, movepy: 29)
                    adddoor(xp: 27, yp: 28.5, movepx: 31, movepy: 33)
                    adddoor(xp: 39, yp: 28.5, movepx: 1, movepy: 37)
                    adddoor(xp: 23, yp: 32.5, movepx: 31, movepy: 37)
                    adddoor(xp: 39, yp: 32.5, movepx: 1, movepy: 37)
                    addmoveStageO(xp: 23, yp: 36.5, Size: 2, moveStageN: 30, moveSceneN: 0, type: 41)
                    addmoveStageO(xp: 39, yp: 36.5, Size: 2, moveStageN: 30, moveSceneN: 11, type: 41)
                    
                    addenemy(xp: 35, yp: 25, type: 34, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 29, type: 34, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 34, yp: 33, type: 34, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 37, yp: 37, type: 34, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addicicle(xp: 24, yp: 29.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 36, yp: 29.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 29, yp: 33.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 34, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                }
            }
            
            if sceneNumber == 1 || sceneNumber == 11 {
                enemymax = 4
                let StageDis:[CGFloat] = [41,40]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 20, py: 36)
                addiceBlock(xp: 20, yp: 33.5, xs: 5, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 11.5, yp: 31, xs: 12, ys: 9, Shapetype: 2, type: 1)
                addiceBlock(xp: 28.5, yp: 31, xs: 12, ys: 9, Shapetype: 3, type: 1)
                
                addBlock(xp: 0, yp: 0, xs: 41, ys: 3, type: 18)
                
                addgoal(xp: 20, yp: 30.5)
                addBar(xp: 20, yp: 25)
                addvector(xp: 16, yp: 21, Angle: 160, Size: 3)
                addvector(xp: 20, yp: 21, Angle: 180, Size: 3)
                addvector(xp: 24, yp: 21, Angle: -160, Size: 3)
                
                addiceBlock(xp: 20, yp: 17, xs: 1, ys: 1, Shapetype: 5, type: 1)
                addiceBlock(xp: 20, yp: 18, xs: 15, ys: 1, Shapetype: 4, type: 4)
                
                if difficulty == 0{
                    addicicle(xp: 7, yp: 38.5, xs: 1, ys: 2, damage: 20,type: 2)
                    addicicle(xp: 15, yp: 38.5, xs: 1, ys: 2, damage: 20,type: 2)
                    addicicle(xp: 29, yp: 38.5, xs: 1, ys: 2, damage: 20,type: 2)
                    addicicle(xp: 32, yp: 38.5, xs: 1, ys: 2, damage: 20,type: 2)
                    
                    addiceBlock(xp: 2, yp: 25, xs: 5, ys: 3, Shapetype: 4, type: 3)
                    addiceBlock(xp: 8, yp: 17, xs: 5, ys: 3, Shapetype: 4, type: 3)
                    addiceBlock(xp: 38, yp: 17, xs: 5, ys: 3, Shapetype: 4, type: 3)
                    addiceBlock(xp: 32, yp: 25, xs: 5, ys: 3, Shapetype: 4, type: 3)
                    
                    addBar(xp: 14, yp: 15)
                    addBar(xp: 20, yp: 12)
                    addBar(xp: 26, yp: 15)
                    
                    addBlock(xp: 17, yp: 3, xs: 2, ys: 5, type: 18)
                    addBlock(xp: 22, yp: 3, xs: 2, ys: 5, type: 18)
                    addenemy(xp: 3, yp: 4, type: 14, HP: 20, Damage: 20, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 6, yp: 4, type: 4, HP: 20, Damage: 20, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 12, yp: 4, type: 34, HP: 20, Damage: 20, direction: true, maxn: 999, interval: 10.0)
                    addenemy(xp: 28, yp: 4, type: 34, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 32, yp: 4, type: 32, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 37, yp: 4, type: 4, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 10.0)
                    
                    addmoveStageO(xp: 20, yp: 3.5, Size: 2, moveStageN: 30, moveSceneN: 1, type: 41)
                }
                
                if difficulty == 1{
                    addicicle(xp: 2, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 4, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 6, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 8, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 10, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 12, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 14, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 16, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 23, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 25, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 27, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 29, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 31, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 33, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 37, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    addicicle(xp: 39, yp: 38.5, xs: 1, ys: 2, damage: 30,type: 2)
                    
                    addiceBlock(xp: 1, yp: 26, xs: 3, ys: 3, Shapetype: 4, type: 3)
                    addiceBlock(xp: 8, yp: 17, xs: 3, ys: 3, Shapetype: 4, type: 3)
                    addiceBlock(xp: 32, yp: 17, xs: 3, ys: 3, Shapetype: 4, type: 3)
                    addiceBlock(xp: 39, yp: 26, xs: 3, ys: 3, Shapetype: 4, type: 3)
                    
                    addBlock(xp: 19, yp: 3, xs: 1, ys: 7, type: 18)
                    addBlock(xp: 22, yp: 3, xs: 1, ys: 7, type: 18)
                    
                    addenemy(xp: 3, yp: 4, type: 17, HP: 30, Damage: 30, direction: true, maxn: 999, interval: 6.0)
                    addenemy(xp: 6, yp: 4, type: 7, HP: 30, Damage: 30, direction: true, maxn: 999, interval: 6.0)
                    addenemy(xp: 11, yp: 4, type: 32, HP: 30, Damage: 30, direction: true, maxn: 999, interval: 6.0)
                    addenemy(xp: 14, yp: 4, type: 34, HP: 30, Damage: 30, direction: true, maxn: 999, interval: 6.0)
                    
                    addenemy(xp: 27, yp: 4, type: 34, HP: 30, Damage: 30, direction: false, maxn: 999, interval: 6.0)
                    addenemy(xp: 30, yp: 4, type: 32, HP: 30, Damage: 30, direction: false, maxn: 999, interval: 6.0)
                    addenemy(xp: 34, yp: 4, type: 17, HP: 30, Damage: 30, direction: false, maxn: 999, interval: 6.0)
                    addenemy(xp: 37, yp: 4, type: 7, HP: 30, Damage: 30, direction: false, maxn: 999, interval: 6.0)
                    
                    addmoveStageO(xp: 20, yp: 3.5, Size: 2, moveStageN: 30, moveSceneN: 11, type: 41)
                }
            }
        }
        
        if stageNumber == 31{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [50,50]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 1, py: 30)
                }else{
                    addplayer(px: 46, py: 46 ,DFlag: false)
                    if difficulty == 0 { additem(xp: 1, yp: 32, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 1, yp: 32, type: 3, number: 11) }
                }
                
                addiceBlock(xp: 46, yp: 43, xs: 7, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 42, yp: 35, xs: 1, ys: 19, Shapetype: 4, type: 1)
                addiceBlock(xp: 44, yp: 37, xs: 3, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 47, yp: 37, xs: 3, ys: 3, Shapetype: 4, type: 3)
                addiceBlock(xp: 44, yp: 31, xs: 3, ys: 3, Shapetype: 4, type: 3)
                addiceBlock(xp: 33.5, yp: 31.5, xs: 16, ys: 12, Shapetype: 2, type: 1)
                addiceBlock(xp: 32.5, yp: 44, xs: 10, ys: 9, Shapetype: 3, type: 1)
                addvector(xp: 27, yp: 28, Angle: -90, Size: 3)
                
                addBlock(xp: 20, yp: 24, xs: 1, ys: 26, type: 18)
                addBlock(xp: 21, yp: 24, xs: 29, ys: 1, type: 18)
                adddoor(xp: 22, yp: 25, movepx: 44, movepy: 40)
                adddoor(xp: 45, yp: 28, movepx: 1, movepy: 47)
                addvector(xp: 47, yp: 34, Angle: -90, Size: 3)
                
                addiceBlock(xp: 6.5, yp: 45, xs: 14, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 13, yp: 47.5, xs: 1, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 7, yp: 42.5, xs: 1, ys: 4, Shapetype: 4, type: 1)
                addiceBlock(xp: 1.5, yp: 40, xs: 4, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 12, yp: 39.5, xs: 15, ys: 12, Shapetype: 2, type: 1)
                addvector(xp: 5, yp: 36, Angle: -135, Size: 3)
                
                addwarp(xp: 11, yp: 48, movepx: 16, movepy: 47)
                addwarp(xp: 3, yp: 37, movepx: 5, movepy: 42)
                addvector(xp: 27, yp: 28, Angle: -90, Size: 3)
                
                
                addiceBlock(xp: 0, yp: 10.5, xs: 1, ys: 20, Shapetype: 4, type: 1)
                addiceBlock(xp: 24.5, yp: 0, xs: 50, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 1.5, yp: 11, xs: 2, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 1, yp: 24.5, xs: 3, ys: 8, Shapetype: 4, type: 1)
                addiceBlock(xp: 23.5, yp: 14.5, xs: 42, ys: 28, Shapetype: 3, type: 1)
                addiceBlock(xp: 33, yp: 22, xs: 1, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 36.5, yp: 20, xs: 8, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 43, yp: 19, xs: 1, ys: 9, Shapetype: 4, type: 1)
                addiceBlock(xp: 46.5, yp: 19.5, xs: 2, ys: 8, Shapetype: 4, type: 1)
                addiceBlock(xp: 46.5, yp: 15, xs: 6, ys: 1, Shapetype: 4, type: 1)
                addvector(xp: 41.5, yp: 20.5, Angle: 0, Size: 2)
                addvector(xp: 41.5, yp: 14.5, Angle: -10, Size: 3)
                
                adddoor(xp: 1, yp: 41.5, movepx: 1, movepy: 30)
                
                adddoor(xp: 1.5, yp: 3.5, movepx: 1, movepy: 30)
                adddoor(xp: 1.5, yp: 14.5, movepx: 1, movepy: 30)
                adddoor(xp: 44.5, yp: 18.5, movepx: 1, movepy: 30)
                adddoor(xp: 48.5, yp: 18.5, movepx: 1, movepy: 30)
                
                addvector(xp: 4, yp: 29, Angle: 45, Size: 3)
                addvector(xp: 12, yp: 23, Angle: 120, Size: 3)
                addvector(xp: 27, yp: 13, Angle: 120, Size: 3)
                addvector(xp: 37, yp: 6, Angle: 120, Size: 3)
                addvector(xp: 41.5, yp: 20.5, Angle: 0, Size: 2)
                addvector(xp: 41.5, yp: 14.5, Angle: 15, Size: 2)
                
                addwarp(xp: 18, yp: 30, movepx: 35, movepy: 22)
                
                
                if difficulty == 0{
                    addDamageBlock(xp: 21, yp: 31, xs: 6, ys: 19, type: 2, damage: 50)
                    addDamageBlock(xp: 25, yp: 25, xs: 25, ys: 1, type: 4, damage: 50)
                    addDamageBlock(xp: 43, yp: 26, xs: 1, ys: 4, type: 2, damage: 50)
                    addDamageBlock(xp: 47, yp: 26, xs: 3, ys: 6, type: 2, damage: 50)
                    
                    addDamageBlock(xp: 0, yp: 34, xs: 4, ys: 1, type: 4, damage: 50)
                    
                    addDamageBlock(xp: 1, yp: 6, xs: 2, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 1, yp: 17, xs: 2, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 44, yp: 20, xs: 2, ys: 2, type: 2, damage: 20)
                    addDamageBlock(xp: 48, yp: 20, xs: 2, ys: 2, type: 2, damage: 20)
                    
                    addmoveStageO(xp: 48.5, yp: 1.5, Size: 2, moveStageN: 31, moveSceneN: 2, type: 1)
                    
                    addwarp(xp: 14, yp: 21, movepx: 1.5, movepy: 19.5)
                    addwarp(xp: 23, yp: 19, movepx: 1.5, movepy: 8.5)
                    addwarp(xp: 29, yp: 11, movepx: 44.5, movepy: 22.5)
                    addwarp(xp: 39, yp: 4, movepx: 48.5, movepy: 22.5)
                }
                
                if difficulty == 1{
                    addDamageBlock(xp: 21, yp: 31, xs: 6, ys: 19, type: 2, damage: 200)
                    addDamageBlock(xp: 25, yp: 25, xs: 25, ys: 1, type: 4, damage: 200)
                    addDamageBlock(xp: 43, yp: 26, xs: 1, ys: 6, type: 2, damage: 200)
                    addDamageBlock(xp: 47, yp: 26, xs: 3, ys: 6, type: 2, damage: 200)
                    
                    addDamageBlock(xp: 0, yp: 34, xs: 4, ys: 1, type: 4, damage: 200)
                    
                    addDamageBlock(xp: 1, yp: 6, xs: 2, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 1, yp: 17, xs: 2, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 44, yp: 20, xs: 2, ys: 2, type: 2, damage: 50)
                    addDamageBlock(xp: 48, yp: 20, xs: 2, ys: 2, type: 2, damage: 50)
                    
                    addmoveStageO(xp: 48.5, yp: 1.5, Size: 2, moveStageN: 31, moveSceneN: 12, type: 1)
                    
                    addwarp(xp: 15, yp: 22, movepx: 1.5, movepy: 19.5)
                    addwarp(xp: 22, yp: 19, movepx: 1.5, movepy: 8.5)
                    addwarp(xp: 30, yp: 12, movepx: 44.5, movepy: 22.5)
                    addwarp(xp: 41, yp: 5, movepx: 48.5, movepy: 22.5)
                }
            }
            
            if 2 <= sceneNumber || 12 <= sceneNumber {
                let StageDis:[CGFloat] = [46,50]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 5)
                addiceBlock(xp: 2, yp: 2, xs: 5, ys: 3, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 8, yp: 4.5, xs: 1, ys: 8, Shapetype: 4, type: 1)
                addiceBlock(xp: 4, yp: 13, xs: 9, ys: 9, Shapetype: 3, type: 1)
                addiceBlock(xp: 18, yp: 4.5, xs: 13, ys: 8, Shapetype: 4, type: 1)
                addiceBlock(xp: 18, yp: 12.5, xs: 13, ys: 8, Shapetype: 1, type: 1)
                addiceBlock(xp: 34, yp: 4.5, xs: 13, ys: 8, Shapetype: 4, type: 1)
                addiceBlock(xp: 34, yp: 12.5, xs: 13, ys: 8, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 0, yp: 28.5, xs: 4, ys: 4, Shapetype: 5, type: 1)
                addiceBlock(xp: 3, yp: 35, xs: 3, ys: 3, Shapetype: 5, type: 1)
                addiceBlock(xp: 9, yp: 23, xs: 3, ys: 3, Shapetype: 5, type: 1)
                addiceBlock(xp: 12, yp: 29, xs: 3, ys: 3, Shapetype: 5, type: 1)
                addiceBlock(xp: 18, yp: 34, xs: 3, ys: 3, Shapetype: 5, type: 1)
                addiceBlock(xp: 29, yp: 28, xs: 3, ys: 3, Shapetype: 5, type: 1)
                
                addiceBlock(xp: 10, yp: 42, xs: 11, ys: 5, Shapetype: 1, type: 1)
                addiceBlock(xp: 26, yp: 42, xs: 11, ys: 5, Shapetype: 1, type: 1)
                addiceBlock(xp: 42, yp: 42, xs: 7, ys: 5, Shapetype: 2, type: 1)
                addiceBlock(xp: 37, yp: 34, xs: 11, ys: 5, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 15.5, yp: 20, xs: 6, ys: 3, Shapetype: 1, type: 1)
                addiceBlock(xp: 17.5, yp: 26, xs: 6, ys: 3, Shapetype: 1, type: 1)
                addiceBlock(xp: 25.5, yp: 33, xs: 6, ys: 3, Shapetype: 1, type: 1)
                addiceBlock(xp: 31.5, yp: 24, xs: 6, ys: 3, Shapetype: 1, type: 1)
                addiceBlock(xp: 39.5, yp: 19, xs: 6, ys: 3, Shapetype: 1, type: 1)
                addiceBlock(xp: 42.5, yp: 28, xs: 6, ys: 5, Shapetype: 2, type: 1)
                
                addwarp(xp: 2, yp: 47, movepx: 6, movepy: 2)
                addwarp(xp: 10, yp: 47, movepx: 10, movepy: 2)
                addwarp(xp: 18, yp: 47, movepx: 26, movepy: 2)
                addwarp(xp: 26, yp: 47, movepx: 40, movepy: 10)
                addwarp(xp: 35, yp: 47, movepx: 10, movepy: 15)
                addwarp(xp: 43, yp: 47, movepx: 26, movepy: 15)
                
                addvector(xp: 42, yp: 12, Angle: 0, Size: 3)
                
                addgoal(xp: 43, yp: 2)
                
                addBlock(xp: 0, yp: 0, xs: 46, ys: 1, type: 18)
                
                
                if difficulty == 0{
                    addDamageO(xp: 2, yp: 26, Size: 3, type: 1, damage: 20)
                    addDamageO(xp: 6, yp: 34, Size: 3, type: 1, damage: 20)
                    addDamageO(xp: 22, yp: 30, Size: 3, type: 1, damage: 20)
                    addDamageO(xp: 28, yp: 21, Size: 3, type: 1, damage: 20)
                    addDamageO(xp: 30, yp: 36, Size: 3, type: 1, damage: 20)
                    addDamageO(xp: 39, yp: 24, Size: 3, type: 1, damage: 20)
                    
                    addBar(xp: 5, yp: 30)
                    addBar(xp: 11, yp: 36)
                    addBar(xp: 23, yp: 27)
                    addBar(xp: 35, yp: 38)
                    addBar(xp: 38, yp: 29)
                    addBar(xp: 38, yp: 15)
                    addBar(xp: 41, yp: 15)
                    addBar(xp: 44, yp: 15)
                }
                
                if difficulty == 1{
                    addDamageO(xp: 5, yp: 26, Size: 3, type: 1, damage: 40)
                    addDamageO(xp: 8, yp: 32, Size: 3, type: 1, damage: 40)
                    addDamageO(xp: 20, yp: 30, Size: 3, type: 1, damage: 40)
                    addDamageO(xp: 25, yp: 23, Size: 3, type: 1, damage: 40)
                    addDamageO(xp: 30, yp: 36, Size: 3, type: 1, damage: 40)
                    addDamageO(xp: 40, yp: 23, Size: 3, type: 1, damage: 40)
                }
            }
        }
        if stageNumber == 32{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [69,25]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 5, py: 15)
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0 { additem(xp: 5, yp: 15, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 5, yp: 15, type: 3, number: 11) }
                }
                
                addBlock(xp: 0, yp: 0, xs: 27, ys: 3, type: 18)
                addBlock(xp: 8, yp: 3, xs: 5, ys: 2, type: 18)
                addBlock(xp: 16, yp: 3, xs: 8, ys: 2, type: 18)
                addBlock(xp: 24, yp: 5, xs: 3, ys: 2, type: 18)
                addBlock(xp: 27, yp: 0, xs: 42, ys: 1, type: 18)
                
                addiceBlock(xp: 45.5, yp: 3.5, xs: 38, ys: 6, Shapetype: 3, type: 1)
                
                adddoor(xp: 67.5, yp: 1.5, movepx: 2, movepy: 14)
                adddoor(xp: 0.5, yp: 20.5, movepx: 40, movepy: 14)
                
                addiceBlock(xp: 34, yp: 11, xs: 69, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 3.5, yp: 18.5, xs: 8, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 34, yp: 23.5, xs: 69, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 36.5, yp: 17.5, xs: 2, ys: 10, Shapetype: 4, type: 1)
                addiceBlock(xp: 43.5, yp: 17.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 53.5, yp: 17.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 63, yp: 17.5, xs: 5, ys: 2, Shapetype: 4, type: 1)
                
                addvector(xp: 33, yp: 14, Angle: -160, Size: 3)
                addwarp(xp: 9, yp: 19, movepx: 32, movepy: 15)
                addwarp(xp: 39.5, yp: 19.5, movepx: 66.5, movepy: 14.5)
                addwarp(xp: 47.5, yp: 20.5, movepx: 59.5, movepy: 18.5)
                addwarp(xp: 49.5, yp: 19.5, movepx: 66.5, movepy: 20.5)
                
                if difficulty == 0{
                    addmoveStageO(xp: 55, yp: 19.5, Size: 2, moveStageN: 32, moveSceneN: 2, type: 40)
                    
                    addicicle(xp: 11, yp: 9, xs: 1, ys: 1, damage: 10,type: 1)
                    addicicle(xp: 14, yp: 9, xs: 1, ys: 1, damage: 10,type: 1)
                    addicicle(xp: 16, yp: 9, xs: 1, ys: 1, damage: 10,type: 1)
                    addicicle(xp: 23, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    addicicle(xp: 31, yp: 8.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 46, yp: 7.5, xs: 1, ys: 5, damage: 10, type: 2)
                    
                    addicicle(xp: 34, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    addicicle(xp: 38, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    addicicle(xp: 42, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    addicicle(xp: 51, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    addicicle(xp: 52, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    addicicle(xp: 53, yp: 8.5, xs: 1, ys: 2, damage: 10,type: 1)
                    
                    addicicle(xp: 13, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    addicicle(xp: 16, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    addicicle(xp: 20, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    addicicle(xp: 21, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    addicicle(xp: 26, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    addicicle(xp: 30, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    addicicle(xp: 34, yp: 21, xs: 1, ys: 3, damage: 10, type: 2)
                    
                    addicicle(xp: 45, yp: 22, xs: 1, ys: 1, damage: 10, type: 2)
                    addicicle(xp: 54, yp: 22, xs: 1, ys: 1, damage: 10, type: 2)
                    addicicle(xp: 64, yp: 22, xs: 1, ys: 1, damage: 10, type: 2)
                    addicicle(xp: 59, yp: 21.5, xs: 1, ys: 2, damage: 10, type: 1)
                    
                    addicicle(xp: 44, yp: 15.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 52, yp: 15.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 55, yp: 15.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 62, yp: 15.5, xs: 1, ys: 2, damage: 10, type: 2)
                }
                if difficulty == 1{
                    addmoveStageO(xp: 55, yp: 19.5, Size: 2, moveStageN: 32, moveSceneN: 12, type: 40)
                    
                    addicicle(xp: 11, yp: 9, xs: 1, ys: 1, damage: 30,type: 1)
                    addicicle(xp: 14, yp: 9, xs: 1, ys: 1, damage: 30,type: 1)
                    addicicle(xp: 16, yp: 9, xs: 1, ys: 1, damage: 30,type: 1)
                    addicicle(xp: 23, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    
                    addicicle(xp: 31, yp: 8, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 46, yp: 6.5, xs: 1, ys: 6, damage: 30, type: 2)
                    
                    addicicle(xp: 34, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    addicicle(xp: 38, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    addicicle(xp: 42, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    addicicle(xp: 51, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    addicicle(xp: 52, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    addicicle(xp: 53, yp: 8.5, xs: 1, ys: 2, damage: 30,type: 1)
                    
                    addicicle(xp: 13, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 16, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 20, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 21, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 26, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 30, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 32, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    addicicle(xp: 34, yp: 21, xs: 1, ys: 3, damage: 30, type: 2)
                    
                    addicicle(xp: 45, yp: 22, xs: 1, ys: 1, damage: 30, type: 2)
                    addicicle(xp: 54, yp: 22, xs: 1, ys: 1, damage: 30, type: 2)
                    addicicle(xp: 64, yp: 22, xs: 1, ys: 1, damage: 30, type: 2)
                    addicicle(xp: 59, yp: 21.5, xs: 1, ys: 2, damage: 30, type: 1)
                    
                    addicicle(xp: 44, yp: 15.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 52, yp: 15.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 55, yp: 15.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 62, yp: 15.5, xs: 1, ys: 2, damage: 30, type: 2)
 
                }
            }
            
            if 2 <= sceneNumber && sceneNumber <= 3 || 12 <= sceneNumber && sceneNumber <= 13{
                let StageDis:[CGFloat] = [20,80]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 3 || sceneNumber == 13{
                    addplayer(px: 4, py: 26)
                }else{
                    addplayer(px: 2, py: 76)
                    if difficulty == 0 { additem(xp: 4, yp: 26, type: 3, number: 3) }
                    if difficulty == 1 { additem(xp: 4, yp: 26, type: 3, number: 13)}
                }
                
                addiceBlock(xp: 6.5, yp: 72.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 12.5, yp: 67.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 6.5, yp: 62.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 12.5, yp: 57.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 9.5, yp: 52.5, xs: 20, ys: 2, Shapetype: 4, type: 1)
                
                addwarp(xp: 18, yp: 55, movepx: 9, movepy: 49)
                
                addiceBlock(xp: 9.5, yp: 44.5, xs: 18, ys: 2, Shapetype: 4, type: 4)
                
                addwarp(xp: 13, yp: 36, movepx: 1, movepy: 27.5)
                addiceBlock(xp: 9.5, yp: 29.5, xs: 20, ys: 2, Shapetype: 4, type: 1)
                addDamageBlock(xp: 0, yp: 31, xs: 20, ys: 3, type: 2, damage: 50)
                
                addiceBlock(xp: 6.5, yp: 23.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 17, yp: 19.5, xs: 5, ys: 6, Shapetype: 2, type: 1)
                addiceBlock(xp: 12, yp: 17, xs: 5, ys: 1, Shapetype: 1, type: 1)
                addiceBlock(xp: 7, yp: 17, xs: 5, ys: 1, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 2, yp: 14.5, xs: 5, ys: 6, Shapetype: 3, type: 1)
                addiceBlock(xp: 7, yp: 12, xs: 5, ys: 1, Shapetype: 1, type: 1)
                addiceBlock(xp: 12, yp: 12, xs: 5, ys: 1, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 17, yp: 9.5, xs: 5, ys: 6, Shapetype: 2, type: 1)
                addiceBlock(xp: 12, yp: 7, xs: 5, ys: 1, Shapetype: 1, type: 1)
                addiceBlock(xp: 7, yp: 7, xs: 5, ys: 1, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 2, yp: 3, xs: 5, ys: 7, Shapetype: 3, type: 1)
                addiceBlock(xp: 7, yp: 0.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 12, yp: 0.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 17, yp: 0.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                
                addgoal(xp: 18.5, yp: 3.5)
                
                if difficulty == 0 {
                    addicicle(xp: 1, yp: 70.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 3, yp: 70.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 7, yp: 70.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 11, yp: 70.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 9, yp: 65.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 13, yp: 65.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 17, yp: 65.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 2, yp: 60.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 5, yp: 60.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 9, yp: 60.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 7, yp: 55.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 11, yp: 55.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 15.5, yp: 55.5, xs: 1, ys: 2, damage: 10, type: 2)
                    
                    addicicle(xp: 2, yp: 50.5, xs: 1, ys: 2, damage: 10, type: 1)
                    addicicle(xp: 7, yp: 50.5, xs: 1, ys: 2, damage: 10, type: 1)
                    addicicle(xp: 12, yp: 50.5, xs: 1, ys: 2, damage: 10, type: 1)
                    addicicle(xp: 17, yp: 50.5, xs: 1, ys: 2, damage: 10, type: 1)
                    
                    addicicle(xp: 6, yp: 27.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 10, yp: 27.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 2, yp: 21.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 8, yp: 21.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 13, yp: 15.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 17, yp: 15.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 3, yp: 10.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 9, yp: 10.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 7, yp: 5.5, xs: 1, ys: 2, damage: 10, type: 2)     
                    addicicle(xp: 15, yp: 5.5, xs: 1, ys: 2, damage: 10, type: 2)
                }
                
                if difficulty == 1 {
                    addicicle(xp: 1, yp: 70.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 3, yp: 70.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 7, yp: 70.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 11, yp: 70.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 9, yp: 65.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 13, yp: 65.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 17, yp: 65.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 2, yp: 60.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 5, yp: 60.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 9, yp: 60.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 7, yp: 55.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 11, yp: 55.5, xs: 1, ys: 2, damage: 30, type: 2)
                    addicicle(xp: 15.5, yp: 55.5, xs: 1, ys: 2, damage: 30, type: 2)
                    
                    addicicle(xp: 2, yp: 50.5, xs: 1, ys: 2, damage: 40, type: 1)
                    addicicle(xp: 7, yp: 50.5, xs: 1, ys: 2, damage: 40, type: 1)
                    addicicle(xp: 12, yp: 50.5, xs: 1, ys: 2, damage: 40, type: 1)
                    addicicle(xp: 17, yp: 50.5, xs: 1, ys: 2, damage: 40, type: 1)
                    
                    addicicle(xp: 6, yp: 27.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 10, yp: 27.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 13, yp: 27.5, xs: 1, ys: 2, damage: 20, type: 1)
                    addicicle(xp: 2, yp: 21.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 8, yp: 21.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 12, yp: 21.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 6, yp: 15.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 13, yp: 15.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 17, yp: 15.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 3, yp: 10.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 9, yp: 10.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 14, yp: 10.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 7, yp: 5.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 12, yp: 5.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 15, yp: 5.5, xs: 1, ys: 2, damage: 20, type: 2)
                }
                
            }
        }
        if stageNumber == 33{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [20,80]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 76)
                
                addiceBlock(xp: 6.5, yp: 72.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 12.5, yp: 67.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 6.5, yp: 62.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 12.5, yp: 57.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 9.5, yp: 52.5, xs: 20, ys: 2, Shapetype: 4, type: 1)
                
                addwarp(xp: 18, yp: 55, movepx: 9, movepy: 49)
                
                addiceBlock(xp: 9.5, yp: 44.5, xs: 18, ys: 2, Shapetype: 4, type: 4)
                
                addwarp(xp: 13, yp: 36, movepx: 1, movepy: 27.5)
                addiceBlock(xp: 9.5, yp: 29.5, xs: 20, ys: 2, Shapetype: 4, type: 1)
                addDamageBlock(xp: 0, yp: 31, xs: 20, ys: 3, type: 2, damage: 50)
                
                addiceBlock(xp: 6.5, yp: 23.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 17, yp: 19.5, xs: 5, ys: 6, Shapetype: 2, type: 1)
                addiceBlock(xp: 12, yp: 17.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 7, yp: 17.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 2, yp: 14.5, xs: 5, ys: 6, Shapetype: 3, type: 1)
                addiceBlock(xp: 7, yp: 12.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 12, yp: 12.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 17, yp: 9.5, xs: 5, ys: 6, Shapetype: 2, type: 1)
                addiceBlock(xp: 12, yp: 7.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 7, yp: 7.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                
                addiceBlock(xp: 2, yp: 3, xs: 5, ys: 7, Shapetype: 3, type: 1)
                addiceBlock(xp: 7, yp: 0.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 12, yp: 0.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
                addiceBlock(xp: 17, yp: 0.5, xs: 5, ys: 2, Shapetype: 1, type: 1)
  
                
                if difficulty == 0{
                    addmoveStageO(xp: 18, yp: 3.5, Size: 2, moveStageN: 33, moveSceneN: 1, type: 40)
                    addenemy(xp: 15, yp: 75, type: 48, HP: 999, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 5, yp: 48, type: 48, HP: 999, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 17, yp: 27, type: 48, HP: 999, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                }
                
                if difficulty == 1{
                    addmoveStageO(xp: 18, yp: 3.5, Size: 2, moveStageN: 33, moveSceneN: 11, type: 40)
                    addenemy(xp: 15, yp: 75, type: 48, HP: 999, Damage: 50, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 5, yp: 48, type: 48, HP: 999, Damage: 50, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 17, yp: 27, type: 48, HP: 999, Damage: 50, direction: false, maxn: 1, interval: 1.0)
                }
                
            }
            
            if sceneNumber == 1 || sceneNumber == 11{
                let StageDis:[CGFloat] = [36,61]
                BackGroundImage(imageName: "bg5_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 1, py: 2)
                
                addiceBlock(xp: 17.5, yp: 0, xs: 36, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 12.5, yp: 4, xs: 26, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 33, yp: 32, xs: 5, ys: 58, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 5.5, yp: 16.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 15, yp: 16.5, xs: 7, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 24.5, yp: 16.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 5, yp: 23.5, xs: 7, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 14.5, yp: 23.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 24, yp: 23.5, xs: 7, ys: 2, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 7, yp: 30.5, xs: 7, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 16.5, yp: 30.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 25.5, yp: 30.5, xs: 6, ys: 2, Shapetype: 4, type: 1)
                
                addBar(xp: 28, yp: 3)
                
                addBar(xp: 1, yp: 14)
                addBar(xp: 3, yp: 11)
                addBar(xp: 6, yp: 7)
                addBar(xp: 9, yp: 11)
                addBar(xp: 10, yp: 14)
                addBar(xp: 12, yp: 7)
                addBar(xp: 15, yp: 11)
                addBar(xp: 18, yp: 7)
                addBar(xp: 20, yp: 14)
                addBar(xp: 21, yp: 11)
                addBar(xp: 24, yp: 7)
                addBar(xp: 27, yp: 11)
                addBar(xp: 29, yp: 7)
                addBar(xp: 29, yp: 14)
                
                addwarp(xp: 6, yp: 21, movepx: 24, movepy: 21)
                addwarp(xp: 15, yp: 21, movepx: 6, movepy: 28)
                addwarp(xp: 6, yp: 35, movepx: 24, movepy: 35)
                addwarp(xp: 15, yp: 28, movepx: 15, movepy: 35)
                addwarp(xp: 24, yp: 28, movepx: 2, movepy: 42)
                
                addiceBlock(xp: 15, yp: 38.5, xs: 31, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 15, yp: 46.5, xs: 31, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 15, yp: 54.5, xs: 31, ys: 2, Shapetype: 4, type: 1)
                
                addwarp(xp: 29, yp: 42, movepx: 2, movepy: 51)
                addwarp(xp: 29, yp: 51, movepx: 29, movepy: 59)

                addgoal(xp: 34.5, yp: 2)
                
                if skillGet[15] == false { additem(xp: 2, yp: 56, type: 1, number: 15) }
                
                if difficulty == 0{
                    addBlock(xp: 31, yp: 1, xs: 2, ys: 3, type: 5,BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1,type: 4, SwitchNumbet: 1)
                    addenemy(xp: 24, yp: 9, type: 48, HP: 90, Damage: 20, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addenemy(xp: 15, yp: 43, type: 33, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 43, type: 33, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 51, type: 33, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    addicicle(xp: 7, yp: 52.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 8, yp: 52.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 13, yp: 52.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 21, yp: 52.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 22, yp: 52.5, xs: 1, ys: 2, damage: 10, type: 2)
                    
                    addicicle(xp: 5, yp: 59.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 9, yp: 59.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 18, yp: 59.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 23, yp: 59.5, xs: 1, ys: 2, damage: 10, type: 2)
                    addicicle(xp: 25, yp: 59.5, xs: 1, ys: 2, damage: 10, type: 2)
                    
                    addicicle(xp: 13, yp: 59.5, xs: 1, ys: 2, damage: 10, type: 1)
                }
                
                if difficulty == 1{
                    addBlock(xp: 31, yp: 1, xs: 1, ys: 3, type: 5,BlockNumber: 1)
                    addBlock(xp: 32, yp: 1, xs: 1, ys: 3, type: 5,BlockNumber: 2)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1,type: 4, SwitchNumbet: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 2,type: 4, SwitchNumbet: 2)
                    addenemy(xp: 24, yp: 9, type: 48, HP: 100, Damage: 50, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addenemy(xp: 15, yp: 43, type: 34, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 23, yp: 43, type: 34, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 16, yp: 51, type: 34, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 2, yp: 58, type: 48, HP: 100, Damage: 50, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 2)
                    
                    addicicle(xp: 7, yp: 52.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 8, yp: 52.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 13, yp: 52.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 21, yp: 52.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 22, yp: 52.5, xs: 1, ys: 2, damage: 20, type: 2)
                    
                    addicicle(xp: 5, yp: 59.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 9, yp: 59.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 18, yp: 59.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 23, yp: 59.5, xs: 1, ys: 2, damage: 20, type: 2)
                    addicicle(xp: 25, yp: 59.5, xs: 1, ys: 2, damage: 20, type: 2)
                    
                    addicicle(xp: 13, yp: 59.5, xs: 1, ys: 2, damage: 20, type: 1)
                }
            }
        }
        if stageNumber == 34{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [25,21]
                BackGroundImage(imageName: "bg5_2", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 1, py: 3)
                
                addiceBlock(xp: 12, yp: 0.5, xs: 25, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 12, yp: 7.5, xs: 25, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 12, yp: 14.5, xs: 25, ys: 2, Shapetype: 4, type: 1)
                
                addwarp(xp: 7, yp: 5.5, movepx: 7, movepy: 12.5)
                addwarp(xp: 17.5, yp: 12.5, movepx: 17, movepy: 19.5)
                
                if difficulty == 0{
                    addwarp(xp: 17, yp: 5.5, movepx: 7, movepy: 19.5)
                    addenemy(xp: 12, yp: 4, type: 43, HP: 140, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 21.5, yp: 16.5, Goaltype: 5, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 2.0, SwitchNumbet: 1, incontact: false)
                }
                
                if difficulty == 1{
                    enemymax = 2
                    addenemy(xp: 11, yp: 7, type: 34, HP: 20, Damage: 20, direction: false, maxn: 999, interval: 40.0)
                    addenemy(xp: 12, yp: 4, type: 43, HP: 200, Damage: 30, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                    addgoal(xp: 21.5, yp: 16.5, Goaltype: 15, BlockNumber: 1)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 2.0, SwitchNumbet: 1, incontact: false)
                }
                
            }
        }
        
        //6¥第６エリア天空
        //6_6_1
        if stageNumber == 35{
            if sceneNumber == 0{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [54,45]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                //敵の最大出現数
                enemymax = 5
                
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 2, py: 4)
                
                //通常ブロック作成
                addBlock(xp: 0, yp: 0, xs: 37, ys: 3, type: 13)
                addBlock(xp: 0, yp: 10, xs: 28, ys: 2, type: 13)
                
                //ダメージブロック(透過)
                addDamageBlock(xp: 0, yp: 12, xs: 28, ys: 2, type: 2, damage: 200)
                addDamageBlock(xp: 7, yp: 34, xs: 24, ys: 1, type: 2, damage: 200)
                
                //ダメージオブジェクト
                addDamageO(xp: 3, yp: 25, Size: 10, type: 5, damage: 50, Angle: 90)
                addDamageO(xp: 10, yp: 24, Size: 10, type: 5, damage: 50, Angle: 90)
                
                //雲(通常)
                //通常
                addcloud(xp: 4, yp: 14, xs: 7, ys: 4, type1: 1, type2: 1)
                //アクションあり
                addcloud(xp: 40, yp: 1, xs: 6, ys: 3, type1: 1, type2: 1, BlockNumber: 2)
                addcloud(xp: 47, yp: 19, xs: 6, ys: 3, type1: 1, type2: 1, BlockNumber: 3)
                addcloud(xp: 40, yp: 19, xs: 6, ys: 3, type1: 1, type2: 1, BlockNumber: 4)
                addcloud(xp: 34, yp: 37, xs: 6, ys: 3, type1: 1, type2: 1, BlockNumber: 5)
                addcloud(xp: 26, yp: 37, xs: 9, ys: 3, type1: 1, type2: 1, BlockNumber: 6)
                addmoveAction(xmove: 0, ymove: 9, time: 5.0, BlockNumber: 2, interval: 3.0)
                addmoveAction(xmove: 0, ymove: -9, time: 5.0, BlockNumber: 3, interval: 3.0)
                addmoveAction(xmove: 0, ymove: 9, time: 5.0, BlockNumber: 4, interval: 3.0)
                addmoveAction(xmove: 0, ymove: -9, time: 5.0, BlockNumber: 5, interval: 3.0)
                addmoveAction(xmove: -14, ymove: 0, time: 5.0, BlockNumber: 6, interval: 3.0)
                //緑
                addcloud(xp: 3, yp: 37, xs: 7, ys: 3, type1: 1, type2: 2)
                addcloud(xp: 11, yp: 27, xs: 7, ys: 3, type1: 1, type2: 2)
                //黄色
                addcloud(xp: 19, yp: 25, xs: 7, ys: 3, type1: 1, type2: 3)
                addcloud(xp: 11, yp: 17, xs: 7, ys: 3, type1: 1, type2: 3)
     
                //矢印
                addvector(xp: 7, yp: 30, Angle: 90, Size: 3)
                addvector(xp: 13, yp: 21, Angle: -90, Size: 3)
                
                //難易度ノーマル
                if difficulty == 0{
                    //スイッチブロックの作成
                    addBlock(xp: 26, yp: 3, xs: 2, ys: 7, type: 5,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチ（敵）
                    addenemy(xp: 21, yp: 7, type: 35, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)

                    //扉
                    addmoveStageO(xp: 4, yp: 15.5, Size: 2, moveStageN: 35, moveSceneN: 1, type: 41)
                }
                
                //難易度ハード
                if difficulty == 1{
                    //スイッチブロックの作成
                    addBlock(xp: 26, yp: 3, xs: 2, ys: 7, type: 5,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチ（敵）
                    addenemy(xp: 21, yp: 7, type: 35, HP: 50, Damage: 20, direction: false, maxn: 2, interval: 5.0, SwitchNumber: 1)
                    
                    //敵
                    addenemy(xp: 43, yp: 25, type: 35, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 5.0, SwitchNumber: 1)
                    
                    //竜巻
                    addtornado(xp: 17, yp: 43, damage: 15, count: 5, Right: false)
                    
                    //扉
                    addmoveStageO(xp: 4, yp: 15.5, Size: 2, moveStageN: 35, moveSceneN: 11, type: 41)
                }
            }
            
            if sceneNumber == 1 || sceneNumber == 11{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [57,46]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                //敵の最大出現数
                enemymax = 5
                
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 5, py: 12)
                
                //雲
                //通常
                addcloud(xp: 6, yp: 8.5, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 52, yp: 21, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 5, yp: 36.5, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 51, yp: 34, xs: 7, ys: 5, type1: 1, type2: 1)
                //アクションあり
                addcloud(xp: 15, yp: 4, xs: 7, ys: 5, type1: 1, type2: 1, BlockNumber: 1)
                addcloud(xp: 24, yp: 18, xs: 7, ys: 5, type1: 1, type2: 1, BlockNumber: 2)
                addcloud(xp: 33, yp: 7, xs: 7, ys: 5, type1: 1, type2: 1, BlockNumber: 3)
                addcloud(xp: 42, yp: 23, xs: 7, ys: 5, type1: 1, type2: 1, BlockNumber: 4)
                addmoveAction(xmove: 0, ymove: 9, time: 10.0, BlockNumber: 1, interval: 3.0)
                addmoveAction(xmove: 0, ymove: -9, time: 10.0, BlockNumber: 2, interval: 3.0)
                addmoveAction(xmove: 0, ymove: 9, time: 10.0, BlockNumber: 3, interval: 3.0)
                addmoveAction(xmove: 0, ymove: -9, time: 10.0, BlockNumber: 4, interval: 3.0)
                //赤
                addcloud(xp: 16, yp: 36, xs: 11, ys: 3, type1: 1, type2: 4)
                addcloud(xp: 29, yp: 35, xs: 10, ys: 3, type1: 1, type2: 4)
                addcloud(xp: 41, yp: 34, xs: 10, ys: 3, type1: 1, type2: 4)
                
                //扉
                adddoor(xp: 54.5, yp: 23.5, movepx: 5, movepy: 40)
                
                //ゴール
                addgoal(xp: 51, yp: 36.5)
                
                //難易度ノーマル
                if difficulty == 0{
                    //敵
                    addenemy(xp: 24, yp: 21, type: 35, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 42, yp: 17, type: 35, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0)
                }
                
                //難易度ハード
                if difficulty == 1{
                    //敵
                    addenemy(xp: 24, yp: 21, type: 36, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 33, yp: 12, type: 35, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 42, yp: 17, type: 36, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 18, yp: 42, type: 36, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 29, yp: 41, type: 35, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 41, yp: 40, type: 36, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                }
            }
        }
        //6_6_2
        if stageNumber == 36{
            if 0 <= sceneNumber && sceneNumber <= 2 || 11 <= sceneNumber && sceneNumber <= 12{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [74,55]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                //敵の最大出現数
                enemymax = 5
                     
                //プレイヤーおよびセーブ地点の作成
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 59, py: 33)
                    if difficulty == 0 { additem(xp: 14, yp: 49, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 14, yp: 49, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 14, py: 49)
                    if difficulty == 0 { additem(xp: 59, yp: 33, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 59, yp: 33, type: 3, number: 11) }
                }else{
                    addplayer(px: 3, py: 20)
                    if difficulty == 0 {
                        additem(xp: 59, yp: 33, type: 3, number: 1)
                        additem(xp: 14, yp: 49, type: 3, number: 2)
                    }
                    if difficulty == 1 {
                        additem(xp: 59, yp: 33, type: 3, number: 11)
                        additem(xp: 14, yp: 49, type: 3, number: 12)
                    }
                }
                
                //通常ブロック
                addBlock(xp: 64, yp: 10, xs: 1, ys: 19, type: 13)
                addBlock(xp: 19, yp: 43, xs: 55, ys: 4, type: 13)
 
                //ダメージブロック
                addDamageBlock(xp: 0, yp: 28, xs: 55, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 62, yp: 10, xs: 2, ys: 19, type: 2, damage: 200)
                addDamageBlock(xp: 10, yp: 42, xs: 64, ys: 1, type: 2, damage: 200)
                
                //雲
                //通常
                addcloud(xp: 2.5, yp: 17, xs: 8, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 15.5, yp: 16, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 29.5, yp: 17, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 43.5, yp: 18, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 67.5, yp: 2, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 59, yp: 29, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 46, yp: 31, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 33, yp: 31, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 20, yp: 31, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 8, yp: 31, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 14, yp: 45, xs: 11, ys: 5, type1: 1, type2: 1)
                //黄
                addcloud(xp: 56, yp: 17, xs: 10, ys: 5, type1: 1, type2: 3)
                //弾性
                //緑
                addcloud(xp: 73, yp: 5, xs: 4, ys: 4, type1: 2, type2: 2)
                addcloud(xp: 65, yp: 14, xs: 4, ys: 4, type1: 2, type2: 2)
                addcloud(xp: 70, yp: 21, xs: 4, ys: 4, type1: 2, type2: 2)
                addcloud(xp: 72, yp: 28, xs: 4, ys: 4, type1: 2, type2: 2)
                //赤　アクションあり
                addcloud(xp: 50.5, yp: 33.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 3)
                addcloud(xp: 9.5, yp: 33.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 4)
                addmoveAction(xmove: -41, ymove: 0, time: 15.0, BlockNumber: 3)
                addmoveAction(xmove: 41, ymove: 0, time: 15.0, BlockNumber: 4)
                
                //バー
                addBar(xp: 67, yp: 8)
                addBar(xp: 6, yp: 37)
                addBar(xp: 6, yp: 42)
                
                //矢印
                addvector(xp: 60, yp: 6, Angle: 90, Size: 3)
                
                //ゴール
                addgoal(xp: 71.5, yp: 47.5)
                
                //難易度ノーマル
                if difficulty == 0{
                    //スイッチ（敵）
                    addenemyAction(xp: 39, yp: 51, type: 35, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 2, SwitchNumber: 1)
                    addenemy(xp: 47, yp: 51, type: 35, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 2)
                    //スイッチブロック
                    addBlock(xp: 65, yp: 47, xs: 2, ys: 8, type: 5, BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    
                    //竜巻
                    addtornado(xp: 19, yp: 25, damage: 10, count: 3, Right: true, DelayTime: 0.0)
                    addtornado(xp: 40, yp: 26, damage: 10, count: 3, Right: false, DelayTime: 7.5)
                    addtornado(xp: 32, yp: 53, damage: 10, count: 3, Right: true, DelayTime: 0.0)
                    addtornado(xp: 54, yp: 53, damage: 10, count: 3, Right: false, DelayTime: 7.5)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //スイッチブロック
                    addBlock(xp: 65, yp: 47, xs: 1, ys: 8, type: 5, BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    addBlock(xp: 66, yp: 47, xs: 1, ys: 8, type: 5, BlockNumber: 13)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 13, SwitchNumbet: 13)
                    //スイッチ（敵）
                    addenemyAction(xp: 39, yp: 51, type: 35, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 2, SwitchNumber: 1)
                    addenemy(xp: 47, yp: 51, type: 35, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 2)
                    addenemyAction(xp: 47, yp: 51, type: 36, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 14, SwitchNumber: 13)
                    addenemy(xp: 39, yp: 51, type: 36, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 14)
                    
                    //赤　アクションあり
                    addcloud(xp: 39.5, yp: 29.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 10)
                    addcloud(xp: 26.5, yp: 40.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 11)
                    addcloud(xp: 13.5, yp: 29.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 12)
                    addmoveAction(xmove: 0, ymove: 10, time: 8.0, BlockNumber: 10)
                    addmoveAction(xmove: 0, ymove: -10, time: 8.0, BlockNumber: 11)
                    addmoveAction(xmove: 0, ymove: 10, time: 8.0, BlockNumber: 12)
                    
                    //竜巻
                    addtornado(xp: 19, yp: 25, damage: 20, count: 3, Right: true, DelayTime: 0.0)
                    addtornado(xp: 40, yp: 26, damage: 20, count: 3, Right: false, DelayTime: 7.5)
                    addtornado(xp: 42, yp: 26, damage: 20, count: 3, Right: true, DelayTime: 7.5)
                    addtornado(xp: 32, yp: 53, damage: 20, count: 3, Right: true, DelayTime: 0.0)
                    addtornado(xp: 54, yp: 53, damage: 20, count: 3, Right: false, DelayTime: 7.5)
                        
                }
            }
        }
        //6_6_3
        if stageNumber == 37{
            if sceneNumber == 0{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [60,47]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                //敵の最大出現数
                enemymax = 5
                     
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 57, py: 14,DFlag: false)
                
                //雲
                //通常
                addcloud(xp: 58, yp: 10, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 43.5, yp: 10, xs: 14, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 27, yp: 11, xs: 14, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 10.5, yp: 10, xs: 14, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 19.5, yp: 36, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 28.5, yp: 36, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 37.5, yp: 36, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 46, yp: 36, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 53.5, yp: 36, xs: 12, ys: 5, type1: 1, type2: 1)
                //弾性
                //赤　アクションあり
                addcloud(xp: 4, yp: 18.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 1)
                addcloud(xp: 14, yp: 24.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 2)
                addcloud(xp: 4, yp: 31.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 3)
                addcloud(xp: 35.5, yp: 39.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 4)
                addcloud(xp: 45.5, yp: 39.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 5)
                addcloud(xp: 45.5, yp: 45.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 6)
                addmoveAction(xmove: 10, ymove: 0, time: 5.0, BlockNumber: 1)
                addmoveAction(xmove: -10, ymove: 0, time: 4.0, BlockNumber: 2)
                addmoveAction(xmove: 10, ymove: 0, time: 3.0, BlockNumber: 3)
                addmoveAction(xmove: 0, ymove: 7, time: 4.0, BlockNumber: 4)
                addmoveAction(xmove: 0, ymove: 7, time: 4.0, BlockNumber: 5)
                addmoveAction(xmove: 0, ymove: -7, time: 4.0, BlockNumber: 6)
     
                //バー
                addBar(xp: 7, yp: 16)
                addBar(xp: 11, yp: 22)
                addBar(xp: 7, yp: 28)
                addBar(xp: 11, yp: 35)
            
                
                //難易度ノーマル
                if difficulty == 0{
                    //敵
                    addenemy(xp: 43, yp: 16, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 17, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 42, type: 36, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 40, yp: 42, type: 35, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    //扉
                    addmoveStageO(xp: 56.5, yp: 38.5, Size: 2, moveStageN: 37, moveSceneN: 1, type: 41)
                }
                
                //難易度ハード
                if difficulty == 1{
                    //赤　アクションあり
                    addcloud(xp: 51.5, yp: 4.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 11)
                    addcloud(xp: 35, yp: 18.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 12)
                    addcloud(xp: 18.5, yp: 5.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 13)
                    addcloud(xp: 35.5, yp: 45.5, xs: 2, ys: 2, type1: 2, type2: 3, BlockNumber: 14)
                    addmoveAction(xmove: 0, ymove: 13, time: 8.0, BlockNumber: 11)
                    addmoveAction(xmove: 0, ymove: -13, time: 8.0, BlockNumber: 12)
                    addmoveAction(xmove: 0, ymove: 13, time: 8.0, BlockNumber: 13)
                    addmoveAction(xmove: 0, ymove: -7, time: 4.0, BlockNumber: 14)
                    
                    //敵
                    addenemy(xp: 43, yp: 16, type: 36, HP: 50, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 25, yp: 17, type: 36, HP: 50, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 30, yp: 42, type: 36, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 40, yp: 42, type: 35, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    //竜巻
                    addtornado(xp: 14, yp: 45, damage: 15, count: 12, Right: true, DelayTime: 30.0)
                    addtornado(xp: 29, yp: 45, damage: 15, count: 12, Right: true, DelayTime: 0.0)
                    
                    //扉
                    addmoveStageO(xp: 56.5, yp: 38.5, Size: 2, moveStageN: 37, moveSceneN: 11, type: 41)
                }
            }
                 
            if 1 <= sceneNumber && sceneNumber <= 2 || 11 <= sceneNumber && sceneNumber <= 12{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [60,70]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                    
                //敵の最大出現数
                enemymax = 2
                     
                //プレイヤーおよびセーブ地点の作成
                if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 56, py: 52,DFlag: false)
                }else{
                    addplayer(px: 7, py: 62)
                    if difficulty == 0 { additem(xp: 56, yp: 52, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 56, yp: 52, type: 3, number: 12)}
                }
                
                //通常ブロック
                addBlock(xp: 13, yp: 57, xs: 42, ys: 2, type: 13)
                
                //ダメージオブジェクト
                addDamageO(xp: 2, yp: 58, Size: 5, type: 4, damage: 200, Angle: 90)
                
                //雲
                //通常
                addcloud(xp: 7.5, yp: 59, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 30.5, yp: 59, xs: 6, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 30.5, yp: 62, xs: 6, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 50.5, yp: 59, xs: 6, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 50.5, yp: 62, xs: 6, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 50.5, yp: 65, xs: 6, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 56, yp: 48, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 13, yp: 37, xs: 6, ys: 5, type1: 1, type2: 1)
                //緑
                addcloud(xp: 8, yp: 45, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 26, yp: 47, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 46, yp: 47, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 54, yp: 41, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 20, yp: 31, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 33, yp: 28, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 42, yp: 33, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 9, yp: 18, xs: 7, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 23.5, yp: 18, xs: 10, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 38.5, yp: 18, xs: 10, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 50, yp: 18, xs: 7, ys: 5, type1: 1, type2: 2)
                //黄
                addcloud(xp: 56, yp: 65, xs: 7, ys: 5, type1: 1, type2: 3)
                addcloud(xp: 8, yp: 31, xs: 8, ys: 5, type1: 1, type2: 3)
                addcloud(xp: 29.5, yp: 38, xs: 8, ys: 5, type1: 1, type2: 3)
                //赤
                addcloud(xp: 2, yp: 38, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 19, yp: 41, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 38, yp: 43, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 55, yp: 30, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 6, yp: 6, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 17, yp: 4, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 29, yp: 5, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 42, yp: 3, xs: 7, ys: 5, type1: 1, type2: 4)
                addcloud(xp: 54, yp: 5, xs: 7, ys: 5, type1: 1, type2: 4)
                //弾性
                //黄
                addcloud(xp: 7, yp: 48, xs: 3, ys: 3, type1: 2, type2: 1)
                addcloud(xp: 14, yp: 48, xs: 3, ys: 3, type1: 2, type2: 1)
                addcloud(xp: 33, yp: 46, xs: 3, ys: 3, type1: 2, type2: 1)
                addcloud(xp: 33, yp: 34, xs: 3, ys: 3, type1: 2, type2: 1)
                addcloud(xp: 46, yp: 37, xs: 3, ys: 3, type1: 2, type2: 1)
                addcloud(xp: 49, yp: 28, xs: 3, ys: 3, type1: 2, type2: 1)
                //緑　アクションあり
                addcloud(xp: 1, yp: 25, xs: 3, ys: 3, type1: 2, type2: 2, BlockNumber: 1)
                addcloud(xp: 58, yp: 25, xs: 3, ys: 3, type1: 2, type2: 2, BlockNumber: 2)
                addmoveAction(xmove: 57, ymove: 0, time: 10, BlockNumber: 1)
                addmoveAction(xmove: -57, ymove: 0, time: 10, BlockNumber: 2)
                //赤
                addcloud(xp: 0, yp: 12, xs: 3, ys: 3, type1: 2, type2: 3)
                addcloud(xp: 16, yp: 12, xs: 3, ys: 3, type1: 2, type2: 3)
                addcloud(xp: 30, yp: 15, xs: 5, ys: 5, type1: 2, type2: 3)
                addcloud(xp: 45, yp: 12, xs: 3, ys: 3, type1: 2, type2: 3)
                addcloud(xp: 59, yp: 11, xs: 3, ys: 3, type1: 2, type2: 3)
                
                //バー
                addBar(xp: 45, yp: 52)
                addBar(xp: 2, yp: 1)
                addBar(xp: 12, yp: 1)
                addBar(xp: 23, yp: 1)
                addBar(xp: 35, yp: 1)
                addBar(xp: 49, yp: 1)
                addBar(xp: 57, yp: 1)
                
                
                //矢印
                addvector(xp: 1, yp: 53, Angle: 0, Size: 3)
                addvector(xp: 4, yp: 10, Angle: 90, Size: 3)
                addvector(xp: 22, yp: 10, Angle: 45, Size: 3)
                addvector(xp: 38, yp: 10, Angle: -45, Size: 3)
                addvector(xp: 56, yp: 10, Angle: -90, Size: 3)
                
                //ゴール
                addgoal(xp: 29, yp: 2.5)
                
                     
                //難易度ノーマル
                if difficulty == 0{
                    //敵
                    addenemy(xp: 20, yp: 62, type: 36, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 20.0)
                    addenemy(xp: 41, yp: 66, type: 36, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 20.0)
                    addenemy(xp: 19, yp: 47, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 20.0)
                    addenemy(xp: 46, yp: 53, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 20.0)
                    addenemy(xp: 21, yp: 37, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 20.0)
                    addenemy(xp: 53, yp: 38, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 20.0)
                    addenemy(xp: 20, yp: 23, type: 36, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 20.0)
                    addenemy(xp: 43, yp: 23, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 20.0)
                    addenemy(xp: 12, yp: 9, type: 36, HP: 30, Damage: 10, direction: true, maxn: 1, interval: 20.0)
                    addenemy(xp: 50, yp: 9, type: 36, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 20.0)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //敵 無限湧き
                    addenemy(xp: 20, yp: 62, type: 36, HP: 30, Damage: 15, direction: false, maxn: 999, interval: 15.0)
                    addenemy(xp: 41, yp: 66, type: 36, HP: 30, Damage: 15, direction: false, maxn: 999, interval: 15.0)
                    addenemy(xp: 19, yp: 47, type: 36, HP: 30, Damage: 15, direction: true, maxn: 999, interval: 15.0)
                    addenemy(xp: 46, yp: 53, type: 36, HP: 30, Damage: 15, direction: true, maxn: 999, interval: 15.0)
                    addenemy(xp: 21, yp: 37, type: 36, HP: 30, Damage: 15, direction: true, maxn: 999, interval: 15.0)
                    addenemy(xp: 53, yp: 38, type: 36, HP: 30, Damage: 15, direction: true, maxn: 999, interval: 15.0)
                    addenemy(xp: 20, yp: 23, type: 36, HP: 30, Damage: 15, direction: false, maxn: 999, interval: 15.0)
                    addenemy(xp: 43, yp: 23, type: 36, HP: 30, Damage: 15, direction: true, maxn: 999, interval: 15.0)
                    addenemy(xp: 12, yp: 9, type: 36, HP: 30, Damage: 15, direction: true, maxn: 999, interval: 15.0)
                    addenemy(xp: 50, yp: 9, type: 36, HP: 30, Damage: 15, direction: false, maxn: 999, interval: 15.0)
                }
            }
        }
        //6_6_4
        if stageNumber == 38{
            if sceneNumber == 0{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [77,50]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                //敵の最大出現数
                enemymax = 2
                     
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 2, py: 10)
                
                //雲
                //通常
                addcloud(xp: 2, yp: 6.5, xs: 8, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 11.5, yp: 6.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 23, yp: 6.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 35, yp: 6.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 46, yp: 6.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 58, yp: 6.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 70, yp: 6.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 48, yp: 25, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 61, yp: 25, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 75, yp: 25, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 54, yp: 16, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 68, yp: 16, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 5, yp: 20.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 15.5, yp: 20.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 27, yp: 20.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 38, yp: 20.5, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 5, yp: 30, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 5, yp: 42, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 36, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 49.5, yp: 36, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 60, yp: 36, xs: 15, ys: 6, type1: 1, type2: 1)
                addcloud(xp: 71, yp: 36, xs: 15, ys: 6, type1: 1, type2: 1)
                
                //弾性
                //赤
                addcloud(xp: 17.5, yp: 24.5, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 23.5, yp: 33.5, xs: 4, ys: 4, type1: 2, type2: 3)
                
                //バー
                addBar(xp: 48, yp: 13)
                addBar(xp: 61, yp: 13)
                addBar(xp: 75, yp: 13)
                addBar(xp: 54, yp: 21)
                addBar(xp: 68, yp: 21)
                addBar(xp: 16, yp: 35)
                addBar(xp: 20, yp: 42)
                
                //回復アイテム
                additem(xp: 2, yp: 24, type: 2, number: 2)
                additem(xp: 71, yp: 40, type: 2, number: 3)
                    
                //難易度ノーマル
                if difficulty == 0{
                    //スイッチブロック
                    addBlock(xp: 43, yp: 9, xs: 2, ys: 10, type: 5,BlockNumber: 1)
                    addBlock(xp: 43, yp: 23, xs: 2, ys: 13, type: 5,BlockNumber: 2)
                    addBlock(xp: 43, yp: 38, xs: 2, ys: 12, type: 5,BlockNumber: 3)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 2, SwitchNumbet: 2)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 3, SwitchNumbet: 3)
                    //スイッチエネミー
                    addenemyAction(xp: 29, yp: 13, type: 36, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 4, SwitchNumber: 1)
                    addenemy(xp: 14, yp: 13, type: 35, HP: 30, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 4)
                    addenemy(xp: 61, yp: 30, type: 36, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 2)
                    addenemy(xp: 36, yp: 42, type: 36, HP: 50, Damage: 10, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 3)
                    
                    //敵無限湧き
                    addenemy(xp: 61, yp: 13, type: 35, HP: 20, Damage: 10, direction: false, maxn: 2, interval: 20.0)
                    addenemy(xp: 53, yp: 22, type: 35, HP: 20, Damage: 10, direction: false, maxn: 2, interval: 20.0)
                    addenemy(xp: 70, yp: 21, type: 35, HP: 20, Damage: 10, direction: true, maxn: 2, interval: 20.0)
                    addenemy(xp: 22, yp: 27, type: 35, HP: 20, Damage: 10, direction: true, maxn: 2, interval: 20.0)
                    addenemy(xp: 4, yp: 36, type: 35, HP: 20, Damage: 10, direction: true, maxn: 2, interval: 20.0)
                    addenemy(xp: 5, yp: 48, type: 36, HP: 20, Damage: 10, direction: true, maxn: 2, interval: 20.0)
                    
                    //扉
                    addmoveStageO(xp: 60, yp: 38.5, Size: 2, moveStageN: 38, moveSceneN: 1, type: 41)
         
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //スイッチブロック
                    addBlock(xp: 43, yp: 9, xs: 2, ys: 10, type: 5,BlockNumber: 1)
                    addBlock(xp: 43, yp: 23, xs: 2, ys: 13, type: 5,BlockNumber: 2)
                    addBlock(xp: 43, yp: 38, xs: 1, ys: 12, type: 5,BlockNumber: 3)
                    addBlock(xp: 44, yp: 38, xs: 1, ys: 12, type: 5,BlockNumber: 10)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 2, SwitchNumbet: 2)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 3, SwitchNumbet: 3)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 10, SwitchNumbet: 10)
                    //スイッチエネミー
                    addenemyAction(xp: 29, yp: 13, type: 36, HP: 30, Damage: 15, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 4, SwitchNumber: 1)
                    addenemy(xp: 14, yp: 13, type: 35, HP: 30, Damage: 15, direction: false, maxn: 2, interval: 5.0, SwitchNumber: 4)
                    addenemy(xp: 61, yp: 30, type: 36, HP: 50, Damage: 15, direction: false, maxn: 2, interval: 5.0, SwitchNumber: 2)
                    addenemy(xp: 5, yp: 48, type: 36, HP: 50, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 3)
                    addenemy(xp: 36, yp: 42, type: 36, HP: 50, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 10)
                    
                    //敵無限湧き
                    addenemy(xp: 61, yp: 13, type: 35, HP: 20, Damage: 15, direction: false, maxn: 999, interval: 20.0)
                    addenemy(xp: 53, yp: 22, type: 35, HP: 20, Damage: 15, direction: false, maxn: 999, interval: 20.0)
                    addenemy(xp: 70, yp: 21, type: 35, HP: 20, Damage: 15, direction: true, maxn: 999, interval: 20.0)
                    addenemy(xp: 22, yp: 27, type: 35, HP: 20, Damage: 15, direction: true, maxn: 999, interval: 20.0)
                    addenemy(xp: 4, yp: 36, type: 35, HP: 20, Damage: 15, direction: true, maxn: 999, interval: 20.0)
                    
                    //扉
                    addmoveStageO(xp: 60, yp: 38.5, Size: 2, moveStageN: 38, moveSceneN: 11, type: 41)
                }
            }
                 
            if sceneNumber == 1 || sceneNumber == 11{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [48,40]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                    
                //敵の最大出現数
                enemymax = 2
                     
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 13, py: 4)
                
                //雲
                //通常
                addcloud(xp: 4, yp: 0, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 12, yp: 0, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 20, yp: 0, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 28, yp: 0, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 0, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 44, yp: 0, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 4, yp: 8, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 3, yp: 17, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 17, yp: 9, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 33, yp: 9, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 44, yp: 16, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 13, yp: 25, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 20, yp: 25, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 27, yp: 25, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 35, yp: 25, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 12, yp: 34, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 39, yp: 34, xs: 11, ys: 5, type1: 1, type2: 1)
                //弾性
                //緑
                addcloud(xp: 16, yp: 11, xs: 3, ys: 3, type1: 2, type2: 2)
                addcloud(xp: 34, yp: 11, xs: 3, ys: 3, type1: 2, type2: 2)
                addcloud(xp: 0, yp: 19, xs: 3, ys: 3, type1: 2, type2: 2)
                addcloud(xp: 47, yp: 18, xs: 3, ys: 3, type1: 2, type2: 2)
                addcloud(xp: 25, yp: 27, xs: 3, ys: 3, type1: 2, type2: 2)
                
                //バー
                addBar(xp: 25, yp: 6)
                addBar(xp: 25, yp: 11)
        
                //竜巻
                addtornado(xp: 22, yp: 39, damage: 10, count: 5, Right: true, DelayTime: 0.0)
                addtornado(xp: 28, yp: 39, damage: 10, count: 5, Right: false, DelayTime: 12.5)
                
                //回復アイテム
                additem(xp: 12, yp: 37, type: 2, number: 1)
                additem(xp: 39, yp: 37, type: 2, number: 2)
                additem(xp: 1, yp: 11, type: 2, number: 1)
                
                //ゴール
                addgoal(xp: 3.5, yp: 4.5)
                     
                //難易度ノーマル
                if difficulty == 0{
                    //敵
                    addenemy(xp: 25, yp: 15, type: 35, HP: 20, Damage: 10, direction: true, maxn: 2, interval: 30.0)
                    
                    //スイッチブロック
                    addBlock(xp: 8, yp: 2, xs: 2, ys: 6, type: 5,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチエネミー
                    addenemy(xp: 25, yp: 32, type: 36, HP: 60, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //スイッチブロック
                    addBlock(xp: 8, yp: 2, xs: 1, ys: 6, type: 5,BlockNumber: 1)
                    addBlock(xp: 9, yp: 2, xs: 1, ys: 6, type: 5,BlockNumber: 2)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 2, SwitchNumbet: 2)
                    //スイッチエネミー
                    addenemy(xp: 25, yp: 15, type: 35, HP: 80, Damage: 20, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 3)
                    addenemy(xp: 25, yp: 32, type: 36, HP: 80, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 4)
                    addenemyAction(xp: 25, yp: 15, type: 35, HP: 80, Damage: 20, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 3, SwitchNumber: 1)
                    addenemyAction(xp: 25, yp: 32, type: 36, HP: 80, Damage: 20, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 4, SwitchNumber: 2)
                }
            }
        }
        //6_6_5
        if stageNumber == 39{
            if sceneNumber == 0{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [70,60]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                
                //敵の最大出現数
                enemymax = 5
                     
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 67, py: 10, DFlag: false)
                
                //雲
                //通常
                addcloud(xp: 65, yp: 6, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 40, yp: 9, xs: 17, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 5, yp: 15, xs: 17, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 14, yp: 34, xs: 17, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 18, yp: 41, xs: 9, ys: 4, type1: 1, type2: 1)
                addcloud(xp: 49, yp: 49, xs: 17, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 58, yp: 49, xs: 17, ys: 5, type1: 1, type2: 1)
                //弾性
                //黄
                addcloud(xp: 55, yp: 7, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 27, yp: 11, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 20, yp: 12, xs: 4, ys: 4, type1: 2, type2: 1)
                //赤
                addcloud(xp: 1, yp: 17, xs: 5, ys: 5, type1: 2, type2: 3)
                addcloud(xp: 16, yp: 44, xs: 4, ys: 6, type1: 2, type2: 3)
                
                //バー
                addBar(xp: 3, yp: 33)
                addBar(xp: 25, yp: 38)
                addBar(xp: 25, yp: 38)
                
                //矢印
                addvector(xp: 1, yp: 20, Angle: 170, Size: 3)
                addvector(xp: 16, yp: 38, Angle: 90, Size: 3)
                addvector(xp: 23, yp: 43, Angle: -100, Size: 3)
                addvector(xp: 18, yp: 46, Angle: 135, Size: 3)
                addvector(xp: 23, yp: 50, Angle: 125, Size: 3)
                addvector(xp: 29, yp: 52, Angle: 115, Size: 3)
                addvector(xp: 35, yp: 53, Angle: 100, Size: 3)
                addvector(xp: 40, yp: 54, Angle: 90, Size: 3)
   
                    
                //難易度ノーマル
                if difficulty == 0{
                    //扉
                    addmoveStageO(xp: 63.5, yp: 51.5, Size: 2, moveStageN: 39, moveSceneN: 1, type: 41)
                    //敵
                    addenemy(xp: 40, yp: 15, type: 35, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 13, yp: 41, type: 35, HP: 30, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //扉
                    addmoveStageO(xp: 63.5, yp: 51.5, Size: 2, moveStageN: 39, moveSceneN: 11, type: 41)
                    //敵
                    addenemy(xp: 40, yp: 15, type: 36, HP: 30, Damage: 20, direction: true, maxn: 2, interval: 5.0)
                    addenemy(xp: 13, yp: 41, type: 36, HP: 30, Damage: 20, direction: false, maxn: 2, interval: 5.0)
                }
            }
                 
            if 1 <= sceneNumber && sceneNumber <= 2 || 11 <= sceneNumber && sceneNumber <= 12{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [47,66]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                    
                //敵の最大出現数
                enemymax = 5
                     
                //プレイヤーおよびセーブ地点の作成
                if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 35, py: 5)
                }else{
                    addplayer(px: 3, py: 5)
                    if difficulty == 0 { additem(xp: 35, yp: 5, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 35, yp: 5, type: 3, number: 12)}
                }
                
                //通常ブロック
                addBlock(xp: 25, yp: 0, xs: 2, ys: 41, type: 13)
                
                //ダメージオブジェクト
                addDamageO(xp: 25.5, yp: 46, Size: 14, type: 5, damage: 200, Angle: 0)
                addDamageO(xp: 32, yp: 52, Size: 14, type: 5, damage: 200, Angle: 90)
                
                //雲
                //通常
                addcloud(xp: 2, yp: 1, xs: 10, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 7, yp: 1, xs: 10, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 21, yp: 1, xs: 10, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 30, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 38, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 44, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 4, yp: 11, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 21, yp: 18, xs: 10, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 2, yp: 34, xs: 10, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 46, xs: 10, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 41, yp: 53, xs: 14, ys: 5, type1: 1, type2: 1)
                //弾性
                //緑
                addcloud(xp: 10, yp: 49, xs: 5, ys: 5, type1: 2, type2: 2)
                addcloud(xp: 21, yp: 53, xs: 5, ys: 5, type1: 2, type2: 2)
                //赤
                addcloud(xp: 24, yp: 3, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 0, yp: 13, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 27, yp: 13, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 24, yp: 20, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 27, yp: 26, xs: 4, ys: 4, type1: 2, type2: 3)
                
                //敵
                addenemy(xp: 44, yp: 17, type: 36, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 44, yp: 29, type: 36, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                
                //バー
                addBar(xp: 42, yp: 6)
                addBar(xp: 38, yp: 10)
                addBar(xp: 44, yp: 12)
                addBar(xp: 39, yp: 17)
                addBar(xp: 33, yp: 18)
                addBar(xp: 42, yp: 21)
                addBar(xp: 40, yp: 26)
                addBar(xp: 38, yp: 30)
                addBar(xp: 34, yp: 33)
                addBar(xp: 43, yp: 33)
                addBar(xp: 36, yp: 37)
                addBar(xp: 32, yp: 41)
                addBar(xp: 29, yp: 45)
                
                
                //矢印
                addvector(xp: 22, yp: 5, Angle: -135, Size: 3)
                addvector(xp: 2, yp: 15, Angle: 135, Size: 3)
                addvector(xp: 22, yp: 22, Angle: -150, Size: 3)
                addvector(xp: 17, yp: 31, Angle: -135, Size: 3)
                addvector(xp: 10, yp: 36, Angle: -120, Size: 3)
                addvector(xp: 11.5, yp: 50.5, Angle: 145, Size: 3)
                addvector(xp: 22.5, yp: 54.5, Angle: 145, Size: 3)
                addvector(xp: 28, yp: 59, Angle: 75, Size: 3)
                
                //扉
                adddoor(xp: 45.5, yp: 55.5, movepx: 30, movepy: 5)
                
                //ゴール
                addgoal(xp: 36, yp: 47.5)
                     
                //難易度ノーマル
                if difficulty == 0{
                    addBar(xp: 3, yp: 40)
                    addBar(xp: 4, yp: 45)
                    addBar(xp: 5, yp: 50)
                    addBar(xp: 17, yp: 57)
                    addBar(xp: 32, yp: 8)
                    addBar(xp: 34, yp: 13)
                    addBar(xp: 34, yp: 23)
                    addBar(xp: 40, yp: 41)
                    addBar(xp: 44, yp: 45)
                    
                    //竜巻
                    addtornado(xp: 4, yp: 31, damage: 10, count: 7, Right: true, DelayTime: 0.0)
                    addtornado(xp: 20, yp: 31, damage: 10, count: 7, Right: false, DelayTime: 17.5)
                    addtornado(xp: 28, yp: 38, damage: 10, count: 9, Right: true, DelayTime: 0.0)
                    addtornado(xp: 44, yp: 38, damage: 10, count: 9, Right: false, DelayTime: 22.5)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    addcloud(xp: -0.5, yp: 37, xs: 4, ys: 4, type1: 2, type2: 3)
                    addvector(xp: 1, yp: 40, Angle: 160, Size: 3)
                    
                    //竜巻
                    addtornado(xp: 4, yp: 31, damage: 20, count: 7, Right: true, DelayTime: 0.0)
                    addtornado(xp: 20, yp: 31, damage: 20, count: 7, Right: false, DelayTime: 17.5)
                    addtornado(xp: 28, yp: 38, damage: 20, count: 9, Right: true, DelayTime: 0.0)
                    addtornado(xp: 44, yp: 38, damage: 20, count: 9, Right: false, DelayTime: 22.5)
                }
            }
        }
        //6_6_6
        if stageNumber == 40{
            if sceneNumber == 0{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [57,100]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                     
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 3, py: 5)
                     
                //雲
                //通常
                addcloud(xp: 4, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 12, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 20, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 28, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 44, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 52, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 10, yp: 15, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 50, yp: 14, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 22, yp: 21.5, xs: 8, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 21.5, xs: 8, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 29, yp: 31, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 4, yp: 29, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 52, yp: 29, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 10, yp: 43, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 28, yp: 43, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 46, yp: 43, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 4, yp: 68, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 12, yp: 68, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 20, yp: 68, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 68, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 44, yp: 68, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 52, yp: 68, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 28, yp: 92, xs: 11, ys: 5, type1: 1, type2: 1)
                //弾性
                //赤
                addcloud(xp: 29, yp: 3, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 7, yp: 18, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 53, yp: 17, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 1, yp: 32, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 29, yp: 33, xs: 4, ys: 4, type1: 2, type2: 3)
                addcloud(xp: 56, yp: 32, xs: 4, ys: 4, type1: 2, type2: 3)
                //アクションあり
                addcloud(xp: 25, yp: 24, xs: 4, ys: 4, type1: 2, type2: 3, BlockNumber: 1)
                addcloud(xp: 3, yp: 70, xs: 4, ys: 4, type1: 2, type2: 3, BlockNumber: 2)
                addcloud(xp: 53, yp: 70, xs: 4, ys: 4, type1: 2, type2: 3, BlockNumber: 3)
                addcloud(xp: 8, yp: 85, xs: 7, ys: 4, type1: 2, type2: 3, BlockNumber: 4)
                addcloud(xp: 48, yp: 85, xs: 7, ys: 4, type1: 2, type2: 3, BlockNumber: 5)
                addmoveAction(xmove: 8, ymove: 0, time: 3.0, BlockNumber: 1)
                addmoveAction(xmove: 50, ymove: 0, time: 20.0, BlockNumber: 2)
                addmoveAction(xmove: -50, ymove: 0, time: 20.0, BlockNumber: 3)
                addmoveAction(xmove: 40, ymove: 0, time: 15.0, BlockNumber: 4)
                addmoveAction(xmove: -40, ymove: 0, time: 15.0, BlockNumber: 5)
                
                //バー
                addBar(xp: 29, yp: 21)
                addBar(xp: 22, yp: 28)
                addBar(xp: 36, yp: 28)
                addBar(xp: 2, yp: 43)
                addBar(xp: 19, yp: 43)
                addBar(xp: 37, yp: 43)
                addBar(xp: 54, yp: 43)
                addBar(xp: 10, yp: 49)
                addBar(xp: 28, yp: 49)
                addBar(xp: 46, yp: 49)
                addBar(xp: 15, yp: 53)
                addBar(xp: 22, yp: 53)
                addBar(xp: 28, yp: 53)
                addBar(xp: 34, yp: 53)
                addBar(xp: 41, yp: 53)
                addBar(xp: 19, yp: 57)
                addBar(xp: 25, yp: 57)
                addBar(xp: 31, yp: 57)
                addBar(xp: 37, yp: 57)
                addBar(xp: 24, yp: 61)
                addBar(xp: 32, yp: 61)
                addBar(xp: 28, yp: 65)
                addBar(xp: 6, yp: 82)
                addBar(xp: 17, yp: 82)
                addBar(xp: 28, yp: 82)
                addBar(xp: 39, yp: 82)
                addBar(xp: 50, yp: 82)
                addBar(xp: 18, yp: 92)
                addBar(xp: 38, yp: 92)
                
                //矢印
                addvector(xp: 27, yp: 6, Angle: -145, Size: 3)
                addvector(xp: 29, yp: 6, Angle: 180, Size: 3)
                addvector(xp: 31, yp: 6, Angle: 145, Size: 3)
                addvector(xp: 9, yp: 20, Angle: 145, Size: 3)
                addvector(xp: 51, yp: 20, Angle: -145, Size: 3)
                addvector(xp: 1, yp: 35, Angle: 180, Size: 3)
                addvector(xp: 27, yp: 36, Angle: -145, Size: 3)
                addvector(xp: 31, yp: 36, Angle: 145, Size: 3)
                addvector(xp: 56, yp: 35, Angle: 180, Size: 3)
                addvector(xp: 10, yp: 75, Angle: 145, Size: 3)
                addvector(xp: 45, yp: 75, Angle: -145, Size: 3)
                
                //回復アイテム
                additem(xp: 1, yp: 71, type: 2, number: 2)
                additem(xp: 55, yp: 71, type: 2, number: 2)
                
                //難易度ノーマル
                if difficulty == 0{
                    //敵
                    addenemy(xp: 17, yp: 8, type: 49, HP: 100, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 75, type: 49, HP: 100, Damage: 10, direction: false, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 28, yp: 94.5, Size: 2, moveStageN: 40, moveSceneN: 1, type: 41)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //敵
                    addenemy(xp: 17, yp: 8, type: 49, HP: 10000, Damage: 25, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 28, yp: 75, type: 49, HP: 10000, Damage: 25, direction: false, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 28, yp: 94.5, Size: 2, moveStageN: 40, moveSceneN: 11, type: 41)
                }
            }
                 
            if sceneNumber == 1 || sceneNumber == 11{
                //ステージ枠の作成
                let StageDis:[CGFloat] = [60,100]
                BackGroundImage(imageName: "bg6_1", FrameSize: StageDis)
                addBoundaryBlock(Size: StageDis)
                     
                //プレイヤーおよびセーブ地点の作成
                addplayer(px: 6, py: 8)
                
                //スキルオーブ
                if skillGet[16] == false { additem(xp: 12, yp: 7, type: 1, number: 16) }
     
                //ダメージブロック
                addDamageBlock(xp: 0, yp: 35, xs: 44, ys: 2, type: 2, damage: 200)
                
                //雲
                addcloud(xp: 7, yp: 4, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 14, yp: 4, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 40, yp: 15, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 46, yp: 15, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 58, yp: 37, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 9, yp: 43, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 16, yp: 43, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 10, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 15, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 21, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 28, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 35, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 42, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 49, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 56, yp: 67, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 29, yp: 83, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 46, yp: 89, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 56, yp: 75, xs: 9, ys: 5, type1: 1, type2: 1)

                //矢印
                addvector(xp: 17, yp: 7, Angle: 135, Size: 3)
                addvector(xp: 22, yp: 12, Angle: 135, Size: 3)
                addvector(xp: 28, yp: 17, Angle: 125, Size: 3)
                addvector(xp: 34, yp: 19, Angle: 90, Size: 3)
                addvector(xp: 48, yp: 19, Angle: 160, Size: 3)
                addvector(xp: 51, yp: 26, Angle: 160, Size: 3)
                addvector(xp: 52, yp: 32, Angle: 180, Size: 3)
                addvector(xp: 54, yp: 41, Angle: -100, Size: 3)
                addvector(xp: 45, yp: 43, Angle: -100, Size: 3)
                addvector(xp: 35, yp: 45, Angle: -100, Size: 3)
                addvector(xp: 26, yp: 47, Angle: -100, Size: 3)
                addvector(xp: 8, yp: 49, Angle: -160, Size: 3)
                addvector(xp: 5, yp: 56, Angle: -165, Size: 3)
                addvector(xp: 3, yp: 62, Angle: -170, Size: 3)
                addvector(xp: 2, yp: 68, Angle: 180, Size: 3)
                addvector(xp: 21, yp: 73, Angle: 180, Size: 3)
                addvector(xp: 21, yp: 79, Angle: 180, Size: 3)
                addvector(xp: 38, yp: 73, Angle: 180, Size: 3)
                addvector(xp: 38, yp: 79, Angle: 180, Size: 3)
                addvector(xp: 23, yp: 85, Angle: 145, Size: 3)
                addvector(xp: 35, yp: 85, Angle: -145, Size: 3)
                addvector(xp: 37, yp: 88, Angle: 145, Size: 3)

                //ゴール
                addgoal(xp: 58.5, yp: 71.5)
                     
                     
                //難易度ノーマル
                if difficulty == 0{
                    //スイッチブロック
                    addBlock(xp: 53, yp: 69, xs: 2, ys: 6, type: 5 ,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチエネミー
                    addenemyAction(xp: 46, yp: 93, type: 49, HP: 50, Damage: 15, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 2, SwitchNumber: 1)
                    addenemy(xp: 29, yp: 86, type: 49, HP: 50, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 2)
                }
                     
                //難易度ハード
                if difficulty == 1{
                    //雲
                    addcloud(xp: 12, yp: 89, xs: 9, ys: 5, type1: 1, type2: 1)
                    
                    //矢印
                    addvector(xp: 20, yp: 88, Angle: -145, Size: 3)
                    
                    //スイッチブロック
                    addBlock(xp: 53, yp: 69, xs: 2, ys: 6, type: 5 ,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチエネミー
                    addenemyAction(xp: 12, yp: 93, type: 49, HP: 50, Damage: 20, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 2, SwitchNumber: 1)
                    addenemyAction(xp: 46, yp: 93, type: 49, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 3, SwitchNumber: 2)
                    addenemy(xp: 29, yp: 86, type: 49, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 3)
                }
            }
        }
        
        //6_6_7(ボス)
        if stageNumber == 41{
            
             //ステージ枠の作成
            let StageDis:[CGFloat] = [39,38]
            BackGroundImage(imageName: "bg6_2", FrameSize: StageDis)
            addBoundaryBlock(Size: StageDis)
                     
            //プレイヤーおよびセーブ地点の作成
            addplayer(px: 3, py: 6)
            //雲
            addcloud(xp: 3.5, yp: 1, xs: 12, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 12.5, yp: 1, xs: 12, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 21.5, yp: 1, xs: 12, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 30.5, yp: 1, xs: 12, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 39.5, yp: 1, xs: 12, ys: 5, type1: 1, type2: 1)
   
            //バー
            addBar(xp: 9, yp: 7)
            addBar(xp: 19, yp: 7)
            addBar(xp: 29, yp: 7)
            addBar(xp: 4, yp: 11)
            addBar(xp: 14, yp: 11)
            addBar(xp: 24, yp: 11)
            addBar(xp: 34, yp: 11)
            addBar(xp: 9, yp: 15)
            addBar(xp: 19, yp: 15)
            addBar(xp: 29, yp: 15)
            addBar(xp: 4, yp: 19)
            addBar(xp: 14, yp: 19)
            addBar(xp: 24, yp: 19)
            addBar(xp: 34, yp: 19)
            addBar(xp: 9, yp: 23)
            addBar(xp: 19, yp: 23)
            addBar(xp: 29, yp: 23)
            addBar(xp: 4, yp: 27)
            addBar(xp: 14, yp: 27)
            addBar(xp: 24, yp: 27)
            addBar(xp: 34, yp: 27)
            addBar(xp: 9, yp: 31)
            addBar(xp: 19, yp: 31)
            addBar(xp: 29, yp: 31)
            
            //難易度ノーマル
            if difficulty == 0{
                addenemy(xp: 19, yp: 19, type: 44, HP: 140, Damage: 15, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                addgoal(xp: 35, yp: 4, Goaltype: 6, BlockNumber: 1)
                addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 2.0, SwitchNumbet: 1, incontact: false)
            }
                     
            //難易度ハード
            if difficulty == 1{
                addenemy(xp: 19, yp: 19, type: 44, HP: 200, Damage: 30, direction: false, maxn: 1, interval: 1.0, SwitchNumber: 1)
                addgoal(xp: 35, yp: 4, Goaltype: 16, BlockNumber: 1)
                addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 3, intime: 2.0, SwitchNumbet: 1, incontact: false)
            }
        }
        
        //6¥第７エリア機械
        if stageNumber == 42{
            if sceneNumber == 0{
                
            }
        }
        
        //6¥第８エリア魔王城
        if stageNumber == 49{
            if sceneNumber == 0{
                
            }
        }
        
        //6¥裏エリア月
        if stageNumber == 56{
            if sceneNumber == 0{
                
            }
        }
        
        //6¥練習エリア
        if stageNumber == 70{ //ジャンプ１
            if sceneNumber == 0{
                let StageS:[CGFloat] = [42,18]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                
                SkillChange(SkillNumber: [0])
                
                addplayer(px: 2, py: 5)
                addBlock(xp: 0, yp: 0, xs: 14, ys: 3, type: 19)
                addBlock(xp: 14, yp: 0, xs: 7, ys: 5, type: 19)
                addBlock(xp: 21, yp: 0, xs: 7, ys: 7, type: 19)
                addBlock(xp: 28, yp: 0, xs: 7, ys: 9, type: 19)
                addBlock(xp: 35, yp: 0, xs: 7, ys: 11, type: 19)
                
                addgoal(xp: 40.5, yp: 11.5)
                
                addTV(xp: 6.5, yp: 6.5, Size: 4, number: 2)
            }
        }
        
        if stageNumber == 71{ //ジャンプ２
            if sceneNumber == 0{
                let StageS:[CGFloat] = [55,17]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [0])
                
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 17, ys: 3, type: 19)
                addBlock(xp: 17, yp: 0, xs: 6, ys: 6, type: 19)
                addBlock(xp: 26, yp: 5, xs: 7, ys: 2, type: 19)
                addBlock(xp: 37, yp: 6, xs: 7, ys: 2, type: 19)
                addBlock(xp: 48, yp: 6, xs: 7, ys: 2, type: 19)
                
                addgoal(xp: 53.5, yp: 10.5)
                
                addTV(xp: 6.5, yp: 6.5, Size: 4, number: 3)
                addTV(xp: 17.5, yp: 10.5, Size: 4, number: 22)
            }
        }
        if stageNumber == 72{ //ジャンプ３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [37,21]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [0])
                
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 13, ys: 3, type: 19)
                addBlock(xp: 27, yp: 0, xs: 10, ys: 3, type: 19)
                addBlock(xp: 32, yp: 4, xs: 5, ys: 1, type: 19,BlockNumber: 1)
                addmoveAction(xmove: 0, ymove: 8, time: 5.0, BlockNumber: 1,interval: 5.0)
                addBlock(xp: 24, yp: 12, xs: 5, ys: 2, type: 19)
                addBlock(xp: 0, yp: 12, xs: 12, ys: 2, type: 19)
                
                addvector(xp: 13, yp: 4, Angle: 135, Size: 3)
                addvector(xp: 34, yp: 4, Angle: 180, Size: 3)
                addvector(xp: 31, yp: 13, Angle: -135, Size: 3)
                addvector(xp: 23, yp: 15, Angle: -135, Size: 3)
                
                addDamageO(xp: 17.5, yp: 14, Size: 12, type: 5, damage: 200,Angle:90)
                
                addgoal(xp: 0.5, yp: 14.5)
                
                addTV(xp: 6.5, yp: 6.5, Size: 4, number: 4)
            }
        }
        if stageNumber == 73{ //回避１
            if sceneNumber == 0{
                let StageS:[CGFloat] = [48,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [5,6])
                
                addplayer(px: 2, py: 5)

                addBlock(xp: 0, yp: 0, xs: 48, ys: 3, type: 19)
                
                addDamageBlock(xp: 14, yp: 3, xs: 1, ys: 12, type: 2, damage: 200)
                addDamageBlock(xp: 21, yp: 3, xs: 1, ys: 12, type: 2, damage: 200)
                addDamageBlock(xp: 28, yp: 3, xs: 2, ys: 12, type: 2, damage: 200)
                addDamageBlock(xp: 39, yp: 3, xs: 5, ys: 12, type: 2, damage: 200)
                
                addgoal(xp: 46.5, yp: 3.5)
                
                addTV(xp: 6.5, yp: 6.5, Size: 4, number: 5)
                addTV(xp: 33.5, yp: 6.5, Size: 4, number: 6)
                
            }
        }
        if stageNumber == 74{ //回避２
            if sceneNumber == 0{
                let StageS:[CGFloat] = [56,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [5])
                
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 56, ys: 3, type: 19)
                
                addDamageBlock(xp: 12, yp: 3, xs: 1, ys: 12, type: 2, damage: 200,BlockNumber: 1)
                addmoveAction(xmove: 9, ymove: 0, time: 6.0, BlockNumber: 1,interval: 1.0)
                
                addDamageBlock(xp: 34, yp: 3, xs: 1, ys: 12, type: 2, damage: 200,BlockNumber: 2)
                addmoveAction(xmove: -8, ymove: 0, time: 6.0, BlockNumber: 2,interval: 1.0)
                
                addDamageBlock(xp: 39, yp: 3, xs: 2, ys: 12, type: 2, damage: 200,BlockNumber: 3)
                addmoveAction(xmove: 8, ymove: 0, time: 6.0, BlockNumber: 3,interval: 1.0)
                
                addgoal(xp: 54.5, yp: 3.5)
            }
        }
        
        if stageNumber == 75{ //回避３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [39,25]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [5])
                
                addplayer(px: 2, py: 23)
                
                addBlock(xp: 11, yp: 23, xs: 17, ys: 2, type: 19)
                addBlock(xp: 0, yp: 19, xs: 8, ys: 3, type: 19)
                addBlock(xp: 8, yp: 19, xs: 23, ys: 2, type: 19)
                addBlock(xp: 31, yp: 19, xs: 4, ys: 3, type: 19)
                addBlock(xp: 11, yp: 17, xs: 17, ys: 2, type: 19)
                addBlock(xp: 4, yp: 13, xs: 4, ys: 3, type: 19)
                addBlock(xp: 8, yp: 13, xs: 23, ys: 2, type: 19)
                addBlock(xp: 31, yp: 13, xs: 8, ys: 3, type: 19)
                addBlock(xp: 11, yp: 11, xs: 17, ys: 2, type: 19)
                addBlock(xp: 0, yp: 7, xs: 8, ys: 3, type: 19)
                addBlock(xp: 8, yp: 7, xs: 23, ys: 2, type: 19)
                addBlock(xp: 31, yp: 7, xs: 4, ys: 3, type: 19)
                addBlock(xp: 0, yp: 0, xs: 39, ys: 3, type: 19)
                
                addenemy(xp: 19, yp: 21, type: 2, HP: 100, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 28, yp: 21, type: 2, HP: 100, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 11, yp: 15, type: 5, HP: 100, Damage: 40, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 19, yp: 15, type: 5, HP: 100, Damage: 40, direction: true, maxn: 1, interval: 1.0)
                addenemy(xp: 19, yp: 9, type: 8, HP: 100, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 28, yp: 9, type: 8, HP: 100, Damage: 40, direction: false, maxn: 1, interval: 1.0)
                addenemy(xp: 19, yp: 3, type: 31, HP: 100, Damage: 40, direction: true, maxn: 1, interval: 1.0)
                
                addgoal(xp: 2.5, yp: 3.5)
            }
        }
        
        if stageNumber == 76{ //地上攻撃１
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [1])
                
                addplayer(px: 1, py: 8)
                
                addBlock(xp: 0, yp: 0, xs: 4, ys: 7, type: 19)
                addBlock(xp: 4, yp: 0, xs: 28, ys: 3, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 2, ys: 12, type: 5, BlockNumber: 1)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                addenemy(xp: 22, yp: 4, type: 1, HP: 10, Damage: 40, direction: false, maxn: 3, interval: 5.0, SwitchNumber: 1)
                
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 1.5, yp: 10.5, Size: 4, number: 7)
            }
        }
        if stageNumber == 77{ //地上攻撃２
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [1,2,5])
                
                addplayer(px: 1, py: 8)
                
                addBlock(xp: 0, yp: 0, xs: 4, ys: 7, type: 19)
                addBlock(xp: 4, yp: 0, xs: 28, ys: 3, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 2, ys: 12, type: 5, BlockNumber: 1)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                addenemy(xp: 22, yp: 4, type: 4, HP: 20, Damage: 40, direction: false, maxn: 3, interval: 7.0, SwitchNumber: 1)
                
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 1.5, yp: 10.5, Size: 4, number: 8)
            }
        }
        
        if stageNumber == 78{ //地上攻撃３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [1,2,5,6])
                
                addplayer(px: 2, py: 11)
                
                addBlock(xp: 0, yp: 8, xs: 12, ys: 2, type: 19)
                addBlock(xp: 0, yp: 0, xs: 32, ys: 3, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 1, ys: 12, type: 5, BlockNumber: 1)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                addenemy(xp: 22, yp: 4, type: 7, HP: 30, Damage: 40, direction: false, maxn: 2, interval: 10.0, SwitchNumber: 1)
                
                addBlock(xp: 27, yp: 3, xs: 1, ys: 12, type: 5, BlockNumber: 2)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 2, SwitchNumbet: 3)
                addenemy(xp: 3, yp: 4, type: 7, HP: 30, Damage: 40, direction: true, maxn: 2, interval: 10.0, SwitchNumber: 2)
                addenemyAction(xp: 3, yp: 4, type: 31, HP: 30, Damage: 40, direction: true, maxn: 2, interval: 10.0, StartSwitchNumber: 2, SwitchNumber: 3)
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 7.5, yp: 13.5, Size: 4, number: 9)
            }
        }
        if stageNumber == 79{ //空中攻撃１
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [3])
                
                addplayer(px: 1, py: 8)
                
                addBlock(xp: 0, yp: 0, xs: 4, ys: 7, type: 19)
                addBlock(xp: 4, yp: 0, xs: 28, ys: 3, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 2, ys: 12, type: 5, BlockNumber: 1)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                addenemy(xp: 22, yp: 4, type: 11, HP: 10, Damage: 40, direction: false, maxn: 3, interval: 5.0, SwitchNumber: 1)
                
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 1.5, yp: 10.5, Size: 4, number: 10)
            }
        }
        
        if stageNumber == 80{ //空中攻撃２
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [3])
                
                addplayer(px: 1, py: 8)
                
                addBlock(xp: 0, yp: 0, xs: 4, ys: 7, type: 19)
                addBlock(xp: 4, yp: 0, xs: 28, ys: 3, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 1, ys: 12, type: 5, BlockNumber: 1)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                addenemy(xp: 16, yp: 8, type: 27, HP: 10, Damage: 40, direction: false, maxn: 2, interval: 6.0, SwitchNumber: 1)
                
                addBlock(xp: 27, yp: 3, xs: 1, ys: 12, type: 5, BlockNumber: 2)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 2, SwitchNumbet: 2)
                addenemy(xp: 23, yp: 8, type: 27, HP: 10, Damage: 40, direction: false, maxn: 2, interval: 6.0, SwitchNumber: 2)
                
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 1.5, yp: 10.5, Size: 4, number: 11)
            }
        }
        if stageNumber == 81{ //空中攻撃３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [37,15]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [3,4])
                
                addplayer(px: 1, py: 8)
                
                addBlock(xp: 0, yp: 0, xs: 9, ys: 7, type: 19)
                addBlock(xp: 9, yp: 0, xs: 28, ys: 3, type: 19)
                
                addBlock(xp: 31, yp: 3, xs: 1, ys: 12, type: 5, BlockNumber: 1)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                addenemy(xp: 21, yp: 8, type: 28, HP: 20, Damage: 40, direction: false, maxn: 2, interval: 6.0, SwitchNumber: 3)
                addenemyAction(xp: 21, yp: 8, type: 29, HP: 30, Damage: 40, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 3, SwitchNumber: 1)
            
                addBlock(xp: 32, yp: 3, xs: 1, ys: 12, type: 5, BlockNumber: 2)
                addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 2, SwitchNumbet: 2)
                addenemy(xp: 28, yp: 8, type: 28, HP: 20, Damage: 40, direction: false, maxn: 2, interval: 6.0, SwitchNumber: 4)
                addenemyAction(xp: 28, yp: 8, type: 29, HP: 30, Damage: 40, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 4, SwitchNumber: 2)
                
                addgoal(xp: 35.5, yp: 3.5)
                
                addTV(xp: 1.5, yp: 10.5, Size: 4, number: 12)
                addTV(xp: 6.5, yp: 10.5, Size: 4, number: 23)
            }
        }
        
        if stageNumber == 82{ //壁登り１
            if sceneNumber == 0{
                
                
                let StageS:[CGFloat] = [30,24]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [7])
                
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 15, ys: 3, type: 19)
                addBlock(xp: 15, yp: 0, xs: 5, ys: 8, type: 19)
                addBlock(xp: 20, yp: 0, xs: 5, ys: 13, type: 19)
                addBlock(xp: 25, yp: 0, xs: 5, ys: 18, type: 19)
                
                addgoal(xp: 28.5, yp: 18.5)
                
                addTV(xp: 7.5, yp: 6.5, Size: 4, number: 13)
            }
        }
        if stageNumber == 83{ //壁登り２
            if sceneNumber == 0{
                let StageS:[CGFloat] = [30,33]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [7])
                
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 15, ys: 3, type: 19)
                addBlock(xp: 15, yp: 0, xs: 5, ys: 11, type: 19)
                addBlock(xp: 20, yp: 0, xs: 5, ys: 20, type: 19)
                addBlock(xp: 25, yp: 0, xs: 5, ys: 27, type: 19)
                
                addgoal(xp: 28.5, yp: 27.5)
                
                addTV(xp: 7.5, yp: 6.5, Size: 4, number: 14)
            }
        }
        
        if stageNumber == 84{ //壁登り３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [30,50]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [7])
                
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 30, ys: 3, type: 19)
                addBlock(xp: 28, yp: 5, xs: 2, ys: 15, type: 19)
                addBlock(xp: 27, yp: 20, xs: 3, ys: 2, type: 19)
                addBlock(xp: 13, yp: 13, xs: 10, ys: 2, type: 19)
                addBlock(xp: 7, yp: 17, xs: 5, ys: 16, type: 19)
                addBlock(xp: 17, yp: 24, xs: 7, ys: 2, type: 19)
                addBlock(xp: 0, yp: 35, xs: 5, ys: 15, type: 19)
                addBlock(xp: 10, yp: 42, xs: 7, ys: 2, type: 19)
                
                addvector(xp: 25, yp: 5, Angle: 135, Size: 3)
                addvector(xp: 27, yp: 13, Angle: -150, Size: 3)
                addvector(xp: 14, yp: 17, Angle: -135, Size: 3)
                addvector(xp: 12, yp: 24, Angle: 150, Size: 3)
                addvector(xp: 15, yp: 27, Angle: -135, Size: 3)
                addvector(xp: 7, yp: 35, Angle: -135, Size: 3)
                addvector(xp: 5, yp: 42, Angle: 150, Size: 3)
 
                addgoal(xp: 15.5, yp: 44.5)
               
                addTV(xp: 7.5, yp: 6.5, Size: 4, number: 15)
            }
        }
        if stageNumber == 85{ //テイルフック１
            if sceneNumber == 0{
                let StageS:[CGFloat] = [33,19]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [3,8])
                
                addplayer(px: 1, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 12, ys: 3, type: 19)
                addBlock(xp: 27, yp: 9, xs: 5, ys: 3, type: 19)
                
                addBar(xp: 13, yp: 6)
                addBar(xp: 18, yp: 8)
                addBar(xp: 23, yp: 10)
                
                addgoal(xp: 31.5, yp: 12.5)
                
                addTV(xp: 5.5, yp: 6.5, Size: 4, number: 16)
            }
        }
        
        if stageNumber == 86{ //テイルフック２
            if sceneNumber == 0{
      
                let StageS:[CGFloat] = [54,19]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [3,7,8])
                
                addplayer(px: 1, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 12, ys: 3, type: 19)
                addBlock(xp: 19, yp: 9, xs: 4, ys: 7, type: 19)
                addBlock(xp: 48, yp: 11, xs: 5, ys: 3, type: 19)
                
                addBar(xp: 14, yp: 6)
                addBar(xp: 26, yp: 14)
                addBar(xp: 33, yp: 10)
                addBar(xp: 40, yp: 13)
                
                addvector(xp: 28, yp: 13, Angle: 70, Size: 3)
                addvector(xp: 35, yp: 11, Angle: 110, Size: 3)
                addvector(xp: 42, yp: 14, Angle: 110, Size: 3)
                
                addgoal(xp: 52.5, yp: 14.5)
                
                addTV(xp: 5.5, yp: 6.5, Size: 4, number: 17)
            }
        }
        
        if stageNumber == 87{ //テイルフック３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [54,23]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [3,8])
                
                addplayer(px: 1, py: 4)
                
                addBlock(xp: 0, yp: 0, xs: 12, ys: 3, type: 19)
                addBlock(xp: 42, yp: 11, xs: 6, ys: 2, type: 19)
                addBlock(xp: 0, yp: 14, xs: 3, ys: 2, type: 19)
                
                addDamageBlock(xp: 23, yp: 2, xs: 2, ys: 3, type: 2, damage: 200)
                addDamageBlock(xp: 29, yp: 6, xs: 2, ys: 3, type: 2, damage: 200)
                addDamageBlock(xp: 34, yp: 2, xs: 2, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 34, yp: 8, xs: 2, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 39, yp: 2, xs: 2, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 39, yp: 7, xs: 2, ys: 2, type: 2, damage: 200)
                addDamageBlock(xp: 43, yp: 2, xs: 2, ys: 2, type: 2, damage: 200)
                addDamageBlock(xp: 43, yp: 8, xs: 2, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 31, yp: 15, xs: 2, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 21, yp: 14, xs: 2, ys: 3, type: 2, damage: 200)
                
                addBar(xp: 14, yp: 5, BloclNumber: 1)
                addBar(xp: 50, yp: 9)
                addBar(xp: 39, yp: 15, BloclNumber: 2)
                addBar(xp: 24, yp: 19)
                addBar(xp: 19, yp: 19)
                addmoveAction(xmove: 36, ymove: 0, time: 50, BlockNumber: 1, interval: 5.0, firstinterval: 5.0, SwitchNumber: 1)
                addmoveAction(xmove: -33, ymove: 0, time: 50, BlockNumber: 2, interval: 5.0, firstinterval: 5.0, SwitchNumber: 2)
                addSwitch(xp: 10.5, yp: 3.5, SwitchNumber: 1)
                addSwitch(xp: 42.5, yp: 13.5, SwitchNumber: 2)
                
                addvector(xp: 26, yp: 17, Angle: -135, Size: 3)
                addvector(xp: 21.5, yp: 19, Angle: -90, Size: 3)
                
                addgoal(xp: 0.5, yp: 16.5)
                
                addTV(xp: 5.5, yp: 6.5, Size: 4, number: 18)
                addTV(xp: 45.5, yp: 17.5, Size: 4, number: 24)
            }
        }
        
        if stageNumber == 88{ //スペシャル１
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,22]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [1,2,3,4,5,6,7,9,10,11,12,13,14])
                
                addplayer(px: 2, py: 18)
                
                addBlock(xp: 0, yp: 0, xs: 32, ys: 3, type: 19)
                addBlock(xp: 0, yp: 15, xs: 9, ys: 2, type: 19)
                addBlock(xp: 9, yp: 13, xs: 3, ys: 4, type: 19)
                addBlock(xp: 15, yp: 13, xs: 3, ys: 9, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 1, ys: 19, type: 5,BlockNumber: 1)
                addBlock(xp: 27, yp: 3, xs: 1, ys: 19, type: 5,BlockNumber: 2)
                addOutAction(interval: 0, outtime: 1.0, BlockNumber: 1, SwitchNumbet: 1)
                addOutAction(interval: 0, outtime: 1.0, BlockNumber: 2, SwitchNumbet: 2)
                
                addenemy(xp: 1, yp: 4, type: 1, HP: 80, Damage: 40, direction: true, maxn: 2, interval: 7.0, SwitchNumber: 3)
                addenemy(xp: 24, yp: 4, type: 1, HP: 80, Damage: 40, direction: false, maxn: 2, interval: 7.0, SwitchNumber: 4)
                addenemyAction(xp: 1, yp: 4, type: 14, HP: 80, Damage: 40, direction: true, maxn: 2, interval: 7.0, StartSwitchNumber: 3,SwitchNumber: 5)
                addenemyAction(xp: 24, yp: 4, type: 14, HP: 80, Damage: 40, direction: false, maxn: 2, interval: 7.0, StartSwitchNumber: 4,SwitchNumber: 6)
                addenemyAction(xp: 5, yp: 5, type: 26, HP: 80, Damage: 40, direction: true, maxn: 3, interval: 6.0, StartSwitchNumber: 5,SwitchNumber: 7)
                addenemyAction(xp: 20, yp: 5, type: 26, HP: 80, Damage: 40, direction: false, maxn: 3, interval: 6.0, StartSwitchNumber: 6,SwitchNumber: 8)
                addenemyAction(xp: 7, yp: 4, type: 47, HP: 200, Damage: 40, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 7,SwitchNumber: 1)
                addenemyAction(xp: 18, yp: 4, type: 47, HP: 200, Damage: 40, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 8,SwitchNumber: 2)
                
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 5.5, yp: 20.5, Size: 4, number: 19)
                addTV(xp: 10.5, yp: 20.5, Size: 4, number: 25)
            }
        }
        
        if stageNumber == 89{ //スペシャル２
            if sceneNumber == 0{
                let StageS:[CGFloat] = [32,22]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [1,2,3,4,5,6,7,9,10,11,12,13,15])
                
                addplayer(px: 2, py: 18)
                
                addBlock(xp: 0, yp: 0, xs: 32, ys: 3, type: 19)
                addBlock(xp: 0, yp: 15, xs: 9, ys: 2, type: 19)
                addBlock(xp: 9, yp: 13, xs: 3, ys: 4, type: 19)
                addBlock(xp: 15, yp: 13, xs: 3, ys: 9, type: 19)
                
                addBlock(xp: 26, yp: 3, xs: 1, ys: 19, type: 5,BlockNumber: 1)
                addBlock(xp: 27, yp: 3, xs: 1, ys: 19, type: 5,BlockNumber: 2)
                addOutAction(interval: 0, outtime: 1.0, BlockNumber: 1, SwitchNumbet: 1)
                addOutAction(interval: 0, outtime: 1.0, BlockNumber: 2, SwitchNumbet: 2)
                
                addenemy(xp: 1, yp: 4, type: 7, HP: 100, Damage: 40, direction: true, maxn: 3, interval: 5.0, SwitchNumber: 3)
                addenemy(xp: 24, yp: 4, type: 7, HP: 100, Damage: 40, direction: false, maxn: 3, interval: 5.0, SwitchNumber: 4)
                addenemyAction(xp: 1, yp: 4, type: 17, HP: 100, Damage: 40, direction: true, maxn: 3, interval: 5.0, StartSwitchNumber: 3,SwitchNumber: 5)
                addenemyAction(xp: 24, yp: 4, type: 17, HP: 100, Damage: 40, direction: false, maxn: 3, interval: 5.0, StartSwitchNumber: 4,SwitchNumber: 6)
                addenemyAction(xp: 5, yp: 5, type: 26, HP: 100, Damage: 40, direction: true, maxn: 3, interval: 5.0, StartSwitchNumber: 5,SwitchNumber: 7)
                addenemyAction(xp: 20, yp: 5, type: 26, HP: 100, Damage: 40, direction: false, maxn: 3, interval: 5.0, StartSwitchNumber: 6,SwitchNumber: 8)
                addenemyAction(xp: 8, yp: 4, type: 32, HP: 100, Damage: 40, direction: true, maxn: 2, interval: 10.0, StartSwitchNumber: 7,SwitchNumber: 9)
                addenemyAction(xp: 17, yp: 4, type: 32, HP: 100, Damage: 40, direction: false, maxn: 2, interval: 10.0, StartSwitchNumber: 8,SwitchNumber: 10)
                addenemyAction(xp: 7, yp: 5, type: 34, HP: 80, Damage: 40, direction: true, maxn: 2, interval: 10.0, StartSwitchNumber: 9,SwitchNumber: 11)
                addenemyAction(xp: 18, yp: 5, type: 34, HP: 80, Damage: 40, direction: false, maxn: 2, interval: 10.0, StartSwitchNumber: 10,SwitchNumber: 12)
                addenemyAction(xp: 7, yp: 5, type: 48, HP: 300, Damage: 40, direction: true, maxn: 1, interval: 1.0, StartSwitchNumber: 11,SwitchNumber: 1)
                addenemyAction(xp: 18, yp: 5, type: 48, HP: 300, Damage: 40, direction: false, maxn: 1, interval: 1.0, StartSwitchNumber: 12,SwitchNumber: 2)
                
                addgoal(xp: 30.5, yp: 3.5)
                
                addTV(xp: 5.5, yp: 20.5, Size: 4, number: 20)
                addTV(xp: 10.5, yp: 20.5, Size: 4, number: 25)
            }
        }
        
        if stageNumber == 90{ //スペシャル３
            if sceneNumber == 0{
                let StageS:[CGFloat] = [40,32]
                BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
                addBoundaryBlock(Size: StageS)
                SkillChange(SkillNumber: [5])
                SkillChange(SkillNumber: [1,2,3,4,5,6,7,9,10,11,12,13,16])
                addplayer(px: 2, py: 5)
                
                addBlock(xp: 0, yp: 0, xs: 21, ys: 3, type: 19)
                addBlock(xp: 0, yp: 25, xs: 14, ys: 2, type: 19)
                addBlock(xp: 26, yp: 17, xs: 6, ys: 1, type: 19)
                addBlock(xp: 26, yp: 18, xs: 1, ys: 5, type: 19)
                
                addDamageBlock(xp: 20, yp: 15, xs: 6, ys: 12, type: 1, damage: 200)
                addDamageBlock(xp: 26, yp: 15, xs: 6, ys: 2, type: 1, damage: 200)
                addDamageBlock(xp: 32, yp: 15, xs: 5, ys: 3, type: 1, damage: 200)
                addDamageBlock(xp: 37, yp: 15, xs: 3, ys: 17, type: 1, damage: 200)
                addDamageBlock(xp: 26, yp: 23, xs: 6, ys: 4, type: 1, damage: 200)
                
                addvector(xp: 16, yp: 5, Angle: 180, Size: 3)
                addvector(xp: 16, yp: 13, Angle: 180, Size: 3)
                addvector(xp: 16, yp: 20, Angle: 180, Size: 3)
                addvector(xp: 16, yp: 26, Angle: -135, Size: 3)
                addvector(xp: 16, yp: 28, Angle: 90, Size: 3)
                addvector(xp: 34, yp: 29, Angle: 0, Size: 3)
                addvector(xp: 34, yp: 20, Angle: -90, Size: 3)

                addgoal(xp: 27.5, yp: 18.5)
                
                addTV(xp: 6.5, yp: 6.5, Size: 4, number: 21)
                addTV(xp: 7.5, yp: 30.5, Size: 4, number: 26)
            }
        }
        
//6¥隠しステージ
//6_10_1
        if stageNumber == 100{
            if 0 <= sceneNumber && sceneNumber <= 1 || sceneNumber == 11 {
                let StageDis:[CGFloat] = [99,26]
                BackGroundImage(imageName: "bg10_1", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 1 || sceneNumber == 11 {
                    addplayer(px: 59, py: 23)
                }else{
                    addplayer(px: 2, py: 6)
                    if difficulty == 0 { additem(xp: 59, yp: 23, type: 3, number: 1) }
                    if difficulty == 1 { additem(xp: 59, yp: 23, type: 3, number: 11) }
                }

                addBlock(xp: 0, yp: 0, xs: 6, ys: 5, type: 17)
                addBlock(xp: 6, yp: 0, xs: 16, ys: 3, type: 17)
                addBlock(xp: 41, yp: 3, xs: 5, ys: 1, type: 17)
                
                addvector(xp: 31, yp: 9, Angle: -135, Size: 3)
                addvector(xp: 31, yp: 12, Angle: 110, Size: 3)
                addvector(xp: 36, yp: 12, Angle: 0, Size: 3)
                
                addBlock(xp: 46, yp: 3, xs: 5, ys: 5, type: 16, BlockNumber: 2, Pattern: 1)
                addBlock(xp: 42, yp: 7, xs: 5, ys: 5, type: 16, BlockNumber: 3, Pattern: 1)
                addBlock(xp: 46, yp: 12, xs: 5, ys: 5, type: 16, BlockNumber: 4, Pattern: 1)
                addBlock(xp: 42, yp: 16, xs: 5, ys: 5, type: 16, BlockNumber: 5, Pattern: 1)
                addBlock(xp: 46, yp: 20, xs: 5, ys: 5, type: 16, BlockNumber: 6, Pattern: 1)
                addrotateAction(dsita: -90, time: 2, BlockNumber: 2, interval: 5.0, firstinterval: 5.0, type: 2)
                addrotateAction(dsita: -90, time: 2, BlockNumber: 3, interval: 5.0, firstinterval: 5.0, type: 2)
                addrotateAction(dsita: -90, time: 2, BlockNumber: 4, interval: 5.0, firstinterval: 5.0, type: 2)
                addrotateAction(dsita: -90, time: 2, BlockNumber: 5, interval: 5.0, firstinterval: 5.0, type: 2)
                addrotateAction(dsita: -90, time: 2, BlockNumber: 6, interval: 5.0, firstinterval: 5.0, type: 2)
                
                addBlock(xp: 56, yp: 20, xs: 39, ys: 1, type: 17)
                addBlock(xp: 94, yp: 15, xs: 1, ys: 5, type: 17)
                addBlock(xp: 60, yp: 10, xs: 1, ys: 5, type: 17)
                addBlock(xp: 60, yp: 15, xs: 17, ys: 1, type: 17)
                addBlock(xp: 81, yp: 15, xs: 9, ys: 1, type: 17)
                addBlock(xp: 89, yp: 10, xs: 1, ys: 5, type: 17)
                addBlock(xp: 90, yp: 10, xs: 9, ys: 1, type: 17)
                addBlock(xp: 65, yp: 10, xs: 20, ys: 1, type: 17)
                addBlock(xp: 84, yp: 5, xs: 1, ys: 5, type: 17)
                addBlock(xp: 85, yp: 5, xs: 14, ys: 1, type: 17)
                addBlock(xp: 55, yp: 0, xs: 1, ys: 7, type: 17)
                addBlock(xp: 56, yp: 0, xs: 43, ys: 1, type: 17)
                addBlock(xp: 79, yp: 1, xs: 1, ys: 5, type: 17)
   
                if difficulty == 0 {
                    addenemy(xp: 18, yp: 5, type: 7, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addBlock(xp: 22, yp: 0, xs: 5, ys: 5, type: 17)
                    
                    addBlock(xp: 24, yp: 10, xs: 6, ys: 1, type: 17)
                    addBlock(xp:27, yp: 4, xs: 7, ys: 7, type: 16, BlockNumber: 1, Pattern: 1)
                    addrotateAction(dsita: 270, time: 2.0, BlockNumber: 1, interval: 12.0, firstinterval: 12.0, type: 2)
                    
                    addenemy(xp: 52, yp: 14, type: 17, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 44, yp: 18, type: 17, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1)
                    
                    addDamageO(xp: 41, yp: 11, Size: 9, type: 5, damage: 30)
                    addDamageO(xp: 41, yp: 20, Size: 9, type: 5, damage: 30)
                    addDamageO(xp: 45, yp: 25, Size: 9, type: 5, damage: 30,Angle:90)
                    addDamageO(xp: 55, yp: 9, Size: 5, type: 4, damage: 30)
                    addDamageO(xp: 55, yp: 16, Size: 9, type: 5, damage: 30)
                    
                    addenemy(xp: 73, yp: 22, type: 7, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 88, yp: 22, type: 7, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 67, yp: 12, type: 7, HP: 50, Damage: 20, direction: true, maxn: 1, interval: 1)
                    addenemy(xp: 76, yp: 7, type: 7, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 94, yp: 2, type: 7, HP: 50, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 62, yp: 17, type: 17, HP: 40, Damage: 20, direction: true, maxn: 1, interval: 1)
                    addenemy(xp: 96, yp: 7, type: 17, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 69, yp: 2, type: 17, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 75, yp: 2, type: 17, HP: 40, Damage: 20, direction: false, maxn: 1, interval: 1)
                    
                    addBlock(xp: 60, yp: 5, xs: 19, ys: 1, type: 17)
                    
                    addmoveStageO(xp: 97.5, yp: 1.5, Size: 2, moveStageN: 100, moveSceneN: 2, type: 1)
                }
                if difficulty == 1 {
                    enemymax = 4
                    addenemy(xp: 18, yp: 5, type: 9, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addBlock(xp: 22, yp: 0, xs: 5, ys: 3, type: 17)
                    
                    addBlock(xp: 24, yp: 10, xs: 4, ys: 1, type: 17)
                    addBlock(xp:27, yp: 4, xs: 7, ys: 7, type: 16, BlockNumber: 1, Pattern: 1)
                    addrotateAction(dsita: 270, time: 2.0, BlockNumber: 1, interval: 6.0, firstinterval: 6.0, type: 2)
                    
                    addenemy(xp: 52, yp: 14, type: 17, HP: 40, Damage: 30, direction: false, maxn: 3, interval: 6.0)
                    addenemy(xp: 44, yp: 18, type: 17, HP: 40, Damage: 30, direction: false, maxn: 3, interval: 6.0)
                    
                    addDamageO(xp: 41, yp: 11, Size: 9, type: 5, damage: 200)
                    addDamageO(xp: 41, yp: 20, Size: 9, type: 5, damage: 200)
                    addDamageO(xp: 45, yp: 25, Size: 9, type: 5, damage: 200,Angle:90)
                    addDamageO(xp: 55, yp: 9, Size: 5, type: 4, damage: 200)
                    addDamageO(xp: 55, yp: 16, Size: 9, type: 5, damage: 200)
                    
                    addenemy(xp: 73, yp: 22, type: 7, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 88, yp: 22, type: 7, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 67, yp: 12, type: 7, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1)
                    addenemy(xp: 64, yp: 7, type: 7, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 70, yp: 7, type: 7, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1)
                    addenemy(xp: 94, yp: 2, type: 7, HP: 50, Damage: 30, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 62, yp: 17, type: 17, HP: 40, Damage: 30, direction: true, maxn: 1, interval: 1)
                    addenemy(xp: 96, yp: 7, type: 17, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 69, yp: 2, type: 17, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1)
                    addenemy(xp: 75, yp: 2, type: 17, HP: 40, Damage: 30, direction: false, maxn: 1, interval: 1)
                    
                    addBlock(xp: 61, yp: 10, xs: 4, ys: 1, type: 17)
                    addBlock(xp: 67, yp: 6, xs: 1, ys: 4, type: 17)
                    addBlock(xp: 73, yp: 6, xs: 1, ys: 4, type: 5,BlockNumber: 10)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 10, type: 4, outtime: 2.0, SwitchNumbet: 1)
                    addSwitch(xp: 97.5, yp: 6.5, SwitchNumber: 1)
                    addBlock(xp: 94, yp: 1, xs: 1, ys: 4, type: 5,BlockNumber: 11)
                    addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 11, type: 4, outtime: 2.0, SwitchNumbet: 2)
                    addSwitch(xp: 68.5, yp: 6.5, SwitchNumber: 2)
                    
                    addBlock(xp: 60, yp: 5, xs: 15, ys: 1, type: 17)
                    
                    addmoveStageO(xp: 97.5, yp: 1.5, Size: 2, moveStageN: 100, moveSceneN: 12, type: 1)
                }
            }
            
            if (2 <= sceneNumber && sceneNumber <= 3) || (12 <= sceneNumber && sceneNumber <= 13) {
                let StageDis:[CGFloat] = [82,43]
                BackGroundImage(imageName: "bg10_1", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 3 || sceneNumber == 13{
                    addplayer(px: 26, py: 33)
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0 { additem(xp: 26, yp: 33, type: 3, number: 3) }
                    if difficulty == 1 { additem(xp: 26, yp: 33, type: 3, number: 3) }
                }
         
                addBlock(xp: 0, yp: 0, xs: 13, ys: 3, type: 17)
                addBlock(xp: 0, yp: 16, xs: 6, ys: 1, type: 17)
                addBlock(xp: 19, yp: 22, xs: 3, ys: 4, type: 17)
                addDamageO(xp: 30, yp: 15.5, Size: 5, type: 4, damage: 30)
                
                addBlock(xp: 15, yp: 3, xs: 6, ys: 6, type: 16, BlockNumber: 1, Pattern: 1, Angle: 0)
                addrotateAction(dsita: -90, time: 5.0, BlockNumber: 1, interval: 6.0, firstinterval: 6.0, type: 2)
                addBlock(xp: 15, yp: 8, xs: 6, ys: 6, type: 16, BlockNumber: 2, Pattern: 2, Angle: 0)
                addrotateAction(dsita: -90, time: 5.0, BlockNumber: 2, interval: 6.0, firstinterval: 6.0, type: 2)
                addBlock(xp: 5, yp: 13, xs: 6, ys: 6, type: 16, BlockNumber: 3, Pattern: 3, Angle: 0)
                addrotateAction(dsita: -90, time: 5.0, BlockNumber: 3, interval: 6.0, firstinterval: 6.0, type: 2)
                addBlock(xp: 10, yp: 18, xs: 6, ys: 6, type: 16, BlockNumber: 4, Pattern: 1, Angle: -90)
                addrotateAction(dsita: 90, time: 5.0, BlockNumber: 4, interval: 6.0, firstinterval: 6.0, type: 2)
                addBlock(xp: 20, yp: 13, xs: 6, ys: 6, type: 16, BlockNumber: 5, Pattern: 1, Angle: 0)
                addrotateAction(dsita: -180, time: 5.0, BlockNumber: 5, interval: 6.0, firstinterval: 6.0, type: 2)
                addBlock(xp: 20, yp: 18, xs: 6, ys: 6, type: 16, BlockNumber: 6, Pattern: 1, Angle: 0)
                addrotateAction(dsita: -90, time: 5.0, BlockNumber: 6, interval: 6.0, firstinterval: 6.0, type: 2)

                addBlock(xp: 35, yp: 8, xs: 6, ys: 6, type: 16, BlockNumber: 7, Pattern: 1, Angle: -90)
                addmoveAction(xmove: -10, ymove: 0, time: 5.0, BlockNumber: 7,interval: 6.0,firstinterval: 6.0)
                addBlock(xp: 45, yp: 13, xs: 6, ys: 6, type: 16, BlockNumber: 8, Pattern: 1, Angle: 0)
                addmoveAction(xmove: -15, ymove: 0, time: 5.0, BlockNumber: 8,interval: 6.0,firstinterval: 6.0)
                addBlock(xp: 45, yp: 3, xs: 6, ys: 6, type: 16, BlockNumber: 9, Pattern: 2, Angle: 0)
                addmoveAction(xmove: -20, ymove: 0, time: 5.0, BlockNumber: 9,interval: 6.0,firstinterval: 6.0)
                
                addBlock(xp: 31, yp: 32, xs: 14, ys: 2, type: 17)
                addBlock(xp: 43, yp: 30, xs: 2, ys: 2, type: 17)
                addBlock(xp: 43, yp: 28, xs: 15, ys: 2, type: 17)
                addBlock(xp: 56, yp: 18, xs: 2, ys: 10, type: 17)
                addBlock(xp: 56, yp: 14, xs: 8, ys: 4, type: 17)
                addBlock(xp: 64, yp: 14, xs: 12, ys: 2, type: 17)
                addBlock(xp: 73, yp: 12, xs: 2, ys: 2, type: 17)
                addBlock(xp: 62, yp: 10, xs: 2, ys: 4, type: 17)
                addBlock(xp: 62, yp: 8, xs: 20, ys: 2, type: 17)
                
                addBlock(xp: 63, yp: 28, xs: 2, ys: 15, type: 17)
                addBlock(xp: 65, yp: 28, xs: 17, ys: 2, type: 17)
                addBlock(xp: 66, yp: 21, xs: 8, ys: 2, type: 17)
                
                additem(xp: 60, yp: 18, type: 2, number: 2)
                
                addBlock(xp: 58, yp: 28, xs: 5, ys: 2, type: 5,BlockNumber: 10)
                addBlock(xp: 76, yp: 14, xs: 6, ys: 4, type: 5,BlockNumber: 11)
                addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 10, type: 4, outtime: 4.0, SwitchNumbet: 1)
                addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 11, type: 4, outtime: 4.0, SwitchNumbet: 2)
                
                if skillGet[9] == false{ additem(xp: 74, yp: 10, type: 1, number: 9) }
                addgoal(xp: 64.5, yp: 10.5)
                
                if difficulty == 0 {
                    addBlock(xp: 24, yp: 28, xs: 5, ys: 4, type: 17)
                    addenemy(xp: 59, yp: 33, type: 8, HP: 50, Damage: 15, direction: false, maxn: 2, interval: 15.0, SwitchNumber: 1)
                    addenemy(xp: 69.5, yp: 25, type: 18, HP: 50, Damage: 15, direction: false, maxn: 3, interval: 15.0, SwitchNumber: 2)
                }
                if difficulty == 1 {
                    enemymax = 3
                    
                    addenemy(xp: 17, yp: 16, type: 17, HP: 40, Damage: 30, direction: true, maxn: 2, interval: 10.0)
                    addBlock(xp: 25, yp: 28, xs: 3, ys: 4, type: 17)
                    addenemy(xp: 59, yp: 33, type: 8, HP: 50, Damage: 30, direction: false, maxn: 3, interval: 15.0, SwitchNumber: 1)
                    addenemy(xp: 69.5, yp: 25, type: 18, HP: 50, Damage: 30, direction: false, maxn: 5, interval: 15.0, SwitchNumber: 2)
                }
            }
        }
//6_10_2
        if stageNumber == 101{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [50,55]
                BackGroundImage(imageName: "bg3_1", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 5, py: 5)
                addBlock(xp: 0, yp: 0, xs: 45, ys: 3, type: 9)
                addBlock(xp: 45, yp: 0, xs: 5, ys: 3, type: 2)
                addBlock(xp: 45, yp: 6, xs: 3, ys: 14, type: 9)
                addBlock(xp: 45, yp: 3, xs: 3, ys: 3, type: 5,BlockNumber: 1)
                addinoutAction(outinterval: 0, ininterval: 0, firstinterval: 0, BlockNumber: 1, type: 4, outtime: 4.0, SwitchNumbet: 1)
                addenemy(xp: 22, yp: 5, type: 47, HP: 50, Damage: 20, direction: true, maxn: 1, interval: 1.0, SwitchNumber: 1)
                
                addmoveStageO(xp: 1, yp: 4, Size: 3, moveStageN: -4, moveSceneN: 101, type: 24)
                
                if difficulty == 0 { addmoveStageO(xp: 48.5, yp: 3.5, Size: 2, moveStageN: 101, moveSceneN: 1, type: 101) }
                if difficulty == 1 { addmoveStageO(xp: 48.5, yp: 3.5, Size: 2, moveStageN: 101, moveSceneN: 11, type: 101) }
            }
            if (1 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12) {
                let StageDis:[CGFloat] = [115,55]
                BackGroundImage(imageName: "bg10_2", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)

                if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 43, py: 19, DFlag: false)
                }else{
                    addplayer(px: 3, py: 5)
                    if difficulty == 0 { additem(xp: 43, yp: 19, type: 3, number: 2) }
                    if difficulty == 1 { additem(xp: 43, yp: 19, type: 3, number: 12) }
                }
  
                enemymax = 4
                addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 2)
                
                addONBlock(xp: 7, yp: 5, xs: 2, ys: 2)
                addOFFBlock(xp: 9, yp: 5, xs: 2, ys: 2)
                addONOFFBlock(xp: 11, yp: 5, xs: 2, ys: 2)
                addONSwitch(xp: 7, yp: 3)
                addOFFSwitch(xp: 12, yp: 3)
                
                addBlock(xp: 45, yp: 5, xs: 7, ys: 2, type: 2)
                addOFFSwitch(xp: 48, yp: 7)
                addONOFFBlock(xp: 63, yp: 7, xs: 5, ys: 1)
                addONOFFBlock(xp: 69, yp: 7, xs: 5, ys: 1)
                addONBlock(xp: 74, yp: 7, xs: 5, ys: 1)
                addONBlock(xp: 68, yp: 7, xs: 1, ys: 9)
                addONBlock(xp: 47, yp: 15, xs: 16, ys: 1)
                addONOFFBlock(xp: 63, yp: 15, xs: 1, ys: 12)
                addONOFFBlock(xp: 64, yp: 15, xs: 4, ys: 1)
                addOFFBlock(xp: 69, yp: 15, xs: 5, ys: 1)
                addOFFBlock(xp: 77, yp: 17, xs: 5, ys: 1)
                addOFFBlock(xp: 85, yp: 19, xs: 5, ys: 1)
                addOFFBlock(xp: 93, yp: 17, xs: 5, ys: 1)
                addOFFBlock(xp: 102, yp: 15, xs: 5, ys: 1)
                addONBlock(xp: 66, yp: 19, xs: 5, ys: 1)
                addONBlock(xp: 75, yp: 18, xs: 5, ys: 1)
                addONBlock(xp: 84, yp: 17, xs: 5, ys: 1)
                addONBlock(xp: 93, yp: 18, xs: 5, ys: 1)
                addONBlock(xp: 101, yp: 16, xs: 5, ys: 1)
                addONBlock(xp: 110, yp: 15, xs: 5, ys: 1)
                addONOFFBlock(xp: 91, yp: 0, xs: 1, ys: 27)
                addONSwitch(xp: 75, yp: 10)
                addOFFSwitch(xp: 68, yp: 20)
                addONSwitch(xp: 108, yp: 18)
                
                addBlock(xp: 0, yp: 15, xs: 47, ys: 2, type: 2)
                addBlock(xp: 63, yp: 27, xs: 52, ys: 2, type: 2)
                
                addvector(xp: 64, yp: 21, Angle: -45, Size: 3)
                
                addBlock(xp: 0, yp: 48, xs: 6, ys: 2, type: 2)
                addDamageO(xp: 23, yp: 23, Size: 5, type: 4, damage: 100,Angle:90)
                addDamageO(xp: 23, yp: 31, Size: 5, type: 4, damage: 100,Angle:90)
                addDamageO(xp: 38, yp: 27, Size: 5, type: 4, damage: 100,Angle:90)
                addDamageO(xp: 35.5, yp: 42, Size: 10, type: 5, damage: 100,Angle:90)
                
                addONBlock(xp: 26, yp: 19, xs: 5, ys: 5)
                addONBlock(xp: 36, yp: 28, xs: 5, ys: 4)
                addONBlock(xp: 16, yp: 37, xs: 5, ys: 13)
                addOFFBlock(xp: 31, yp: 19, xs: 10, ys: 5)
                addOFFBlock(xp: 21, yp: 24, xs: 10, ys: 3)
                addOFFBlock(xp: 21, yp: 32, xs: 15, ys: 5)
                addONOFFBlock(xp: 31, yp: 24, xs: 5, ys: 8)
                addONOFFBlock(xp: 21, yp: 37, xs: 5, ys: 5)
                addONOFFBlock(xp: 6, yp: 48, xs: 10, ys: 2)
                
                addDamageBlock(xp: 0, yp: 36, xs: 21, ys: 1, type: 1, damage: 200)
                
                
                if difficulty == 0 {
                    addONBlock(xp: 21, yp: 4, xs: 5, ys: 1)
                    addONBlock(xp: 29, yp: 5, xs: 5, ys: 1)
                    addONOFFBlock(xp: 37, yp: 6, xs: 5, ys: 1)
                    addOFFBlock(xp: 55, yp: 7, xs: 5, ys: 1)
                    
                    addenemy(xp: 27, yp: 5, type: 21, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 35, yp: 6, type: 21, HP: 20, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 62, yp: 13, type: 27, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 77, yp: 23, type: 27, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 87, yp: 25, type: 27, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 99, yp: 12, type: 27, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 99, yp: 24, type: 27, HP: 10, Damage: 20, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 52, yp: 17, type: 31, HP: 30, Damage: 20, direction: true, maxn: 1, interval: 1.0)
                    
                    addmoveStageO(xp: 0.5, yp: 50.5, Size: 2, moveStageN: 101, moveSceneN: 3, type: 2)
                    
                    addOFFSwitch(xp: 38, yp: 17)
                    addONSwitch(xp: 24, yp: 28)
                    addOFFSwitch(xp: 38, yp: 35)
                    addONSwitch(xp: 23, yp: 44)
                    addOFFSwitch(xp: 35, yp: 40)
                }
                if difficulty == 1 {
                    addONBlock(xp: 23, yp: 4, xs: 3, ys: 1)
                    addONBlock(xp: 31, yp: 5, xs: 3, ys: 1)
                    addONOFFBlock(xp: 39, yp: 6, xs: 3, ys: 1)
                    addOFFBlock(xp: 56, yp: 7, xs: 3, ys: 1)
                    
                    addenemy(xp: 27, yp: 5, type: 26, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    addenemy(xp: 35, yp: 6, type: 26, HP: 30, Damage: 30, direction: false, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 62, yp: 13, type: 27, HP: 10, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 77, yp: 23, type: 27, HP: 10, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 87, yp: 25, type: 27, HP: 10, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 99, yp: 12, type: 27, HP: 10, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 99, yp: 24, type: 27, HP: 10, Damage: 30, direction: false, maxn: 999, interval: 10.0)
                    addenemy(xp: 52, yp: 17, type: 32, HP: 50, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addenemy(xp: 22, yp: 29, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 21, yp: 43, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    addenemy(xp: 7, yp: 51, type: 7, HP: 30, Damage: 30, direction: true, maxn: 1, interval: 1.0)
                    
                    addDamageO(xp: 5.5, yp: 17.5, Size: 2, type: 1, damage: 50)
                    addDamageO(xp: 10.5, yp: 17.5, Size: 2, type: 1, damage: 50)
                    addDamageO(xp: 15.5, yp: 17.5, Size: 2, type: 1, damage: 50)
                    addDamageO(xp: 20.5, yp: 17.5, Size: 2, type: 1, damage: 50)
                    
                    addOFFSwitch(xp: 4, yp: 17)
                    addONSwitch(xp: 23, yp: 30)
                    addOFFSwitch(xp: 39, yp: 36)
                    addOFFSwitch(xp: 38, yp: 40)
                    addONSwitch(xp: 23, yp: 46)
 
                    addmoveStageO(xp: 0.5, yp: 50.5, Size: 2, moveStageN: 101, moveSceneN: 13, type: 2)
                }
            }
            if (3 <= sceneNumber && sceneNumber <= 5) || (13 <= sceneNumber && sceneNumber <= 15) {
                let StageDis:[CGFloat] = [60,40]
                BackGroundImage(imageName: "bg10_2", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                if sceneNumber == 4 || sceneNumber == 14{
                    addplayer(px: 7, py: 26)
                    if difficulty == 0 { additem(xp: 56, yp: 8, type: 3, number: 5) }
                    if difficulty == 1 { additem(xp: 56, yp: 8, type: 3, number: 5) }
                }else if sceneNumber == 5 || sceneNumber == 14{
                    addplayer(px: 56, py: 8, DFlag: false)
                    if difficulty == 0 { additem(xp: 7, yp: 26, type: 3, number: 4) }
                    if difficulty == 1 { additem(xp: 7, yp: 26, type: 3, number: 14) }
                }else{
                    addplayer(px: 57, py: 38,DFlag:  false)
                    if difficulty == 0 {
                        additem(xp: 7, yp: 26, type: 3, number: 4)
                        additem(xp: 56, yp: 8, type: 3, number: 5)
                    }
                    if difficulty == 1 {
                        additem(xp: 7, yp: 26, type: 3, number: 14)
                        additem(xp: 56, yp: 8, type: 3, number: 15)
                    }
                }

                addBlock(xp: 51, yp: 31, xs: 9, ys: 5, type: 2)
                addDamageO(xp: 40.5, yp: 38, Size: 5, type: 4, damage: 100)
                addDamageO(xp: 30.5, yp: 34, Size: 5, type: 4, damage: 100)
                addDamageBlock(xp: 5, yp: 31, xs: 46, ys: 1, type: 1, damage: 200)
                
                
                addONBlock(xp: 21, yp: 32, xs: 5, ys: 4)
                addONBlock(xp: 31, yp: 38, xs: 5, ys: 2)
                addONBlock(xp: 36, yp: 32, xs: 5, ys: 2)
                addONBlock(xp: 46, yp: 36, xs: 5, ys: 4)
                addOFFBlock(xp: 16, yp: 32, xs: 5, ys: 2)
                addOFFBlock(xp: 26, yp: 34, xs: 5, ys: 4)
                addOFFBlock(xp: 31, yp: 34, xs: 5, ys: 2)
                addOFFBlock(xp: 41, yp: 34, xs: 5, ys: 2)
                addOFFBlock(xp: 46, yp: 32, xs: 5, ys: 2)
                addONOFFBlock(xp: 31, yp: 32, xs: 5, ys: 2)
                addONOFFBlock(xp: 31, yp: 36, xs: 5, ys: 2)
                addONOFFBlock(xp: 41, yp: 32, xs: 5, ys: 2)
                addONOFFBlock(xp: 46, yp: 34, xs: 5, ys: 2)
                
                addBlock(xp: 5, yp: 22, xs: 6, ys: 2, type: 2)
                
                addDamageBlock(xp: 0, yp: 15, xs: 27, ys: 2, type: 1, damage: 200)
                addDamageBlock(xp: 27, yp: 15, xs: 7, ys: 10, type: 1, damage: 200)
                addDamageBlock(xp: 34, yp: 15, xs: 16, ys: 2, type: 1, damage: 200)
                addDamageBlock(xp: 50, yp: 15, xs: 6, ys: 7, type: 1, damage: 200)
                addDamageBlock(xp: 5, yp: 3, xs: 2, ys: 12, type: 1, damage: 200)
                addDamageBlock(xp: 12, yp: 3, xs: 5, ys: 2, type: 1, damage: 200)
                
                addOFFBlock(xp: 11, yp: 22, xs: 10, ys: 2,BlockNumber: 2)
                addmoveAction(xmove: 39, ymove: 0, time: 50, BlockNumber: 2,interval: 10.0, SwitchNumber: 1)
                addSwitch(xp: 7.5, yp: 24.5, SwitchNumber: 1)
                
                addBlock(xp: 27, yp: 29, xs: 7, ys: 2, type: 2)
                addONOFFBlock(xp: 15, yp: 24, xs: 2, ys: 7)
                addONOFFBlock(xp: 27, yp: 25, xs: 7, ys: 1)
                addONOFFBlock(xp: 48, yp: 24, xs: 2, ys: 7)

                addvector(xp: 57.5, yp: 20, Angle: 0, Size: 3)
                addBlock(xp: 50, yp: 5, xs: 10, ys: 2, type: 2)
                addONSwitch(xp: 51, yp: 7)
                addOFFSwitch(xp: 28, yp: 10)
                addONSwitch(xp: 8, yp: 10)
                
                addBlock(xp: 0, yp: 0, xs: 13, ys: 1, type: 2)
                addBlock(xp: 12, yp: 1, xs: 1, ys: 2, type: 2)
                
                if skillGet[11] == false{ additem(xp: 6, yp: 1, type: 1, number: 11) }
                addgoal(xp: 0.5, yp: 1.5)
                
                if difficulty == 0 {
                    addONSwitch(xp: 12, yp: 37)
                    addOFFSwitch(xp: 17, yp: 36)
                    addONSwitch(xp: 25, yp: 38)
                    addOFFSwitch(xp: 51, yp: 36)
                    addONSwitch(xp: 43, yp: 38)
                    addOFFSwitch(xp: 38, yp: 36)
                    
                    addONBlock(xp: 5, yp: 32, xs: 6, ys: 2)
                    addONOFFBlock(xp: 0, yp: 31, xs: 5, ys: 2,BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: -9, time: 6.0, BlockNumber: 1,interval: 4.0)
                    
                    addOFFSwitch(xp: 10, yp: 26)
                    addONSwitch(xp: 22, yp: 26)
                    addOFFSwitch(xp: 25, yp: 26)
                    addONSwitch(xp: 45, yp: 25)
                    addOFFSwitch(xp: 45, yp: 28)
                    addONSwitch(xp: 59, yp: 24)
                    
                    addONBlock(xp: 44, yp: 5, xs: 6, ys: 2,BlockNumber: 3)
                    addmoveAction(xmove: -13, ymove: 0, time: 10, BlockNumber: 3,interval: 6.0)
                    addOFFBlock(xp: 7, yp: 5, xs: 6, ys: 2,BlockNumber: 4)
                    addmoveAction(xmove: 13, ymove: 0, time: 10, BlockNumber: 4,interval: 6.0)
                    
                    addDamageBlock(xp: 7, yp: 3, xs: 1, ys: 2, type: 1, damage: 200)
                }
                if difficulty == 1 {
                    addONSwitch(xp: 10, yp: 37)
                    addOFFSwitch(xp: 15, yp: 34)
                    addONSwitch(xp: 21, yp: 36)
                    addOFFSwitch(xp: 51, yp: 36)
                    addONSwitch(xp: 41, yp: 38)
                    addOFFSwitch(xp: 40, yp: 37)
                    
                    addONBlock(xp: 7, yp: 32, xs: 3, ys: 2)
                    addONOFFBlock(xp: 2, yp: 31, xs: 1, ys: 2,BlockNumber: 1)
                    addmoveAction(xmove: 0, ymove: -9, time: 6.0, BlockNumber: 1,interval: 4.0)
                    
                    addOFFSwitch(xp: 9, yp: 25)
                    addONSwitch(xp: 23, yp: 26)
                    addOFFSwitch(xp: 24, yp: 26)
                    addONSwitch(xp: 45, yp: 26)
                    addOFFSwitch(xp: 45, yp: 27)
                    addONSwitch(xp: 59, yp: 24)
                    
                    addONBlock(xp: 45, yp: 5, xs: 3, ys: 2,BlockNumber: 3)
                    addmoveAction(xmove: -13, ymove: 0, time: 10, BlockNumber: 3,interval: 6.0)
                    addOFFBlock(xp: 9, yp: 5, xs: 3, ys: 2,BlockNumber: 4)
                    addmoveAction(xmove: 13, ymove: 0, time: 10, BlockNumber: 4,interval: 6.0)
                    addDamageBlock(xp: 7, yp: 3, xs: 2, ys: 2, type: 1, damage: 200)
                }
            }
        }
//6_10_3
        if stageNumber == 102{
            if (0 <= sceneNumber && sceneNumber <= 2) || (11 <= sceneNumber && sceneNumber <= 12) {
                let StageDis:[CGFloat] = [50,50]
                BackGroundImage(imageName: "bg10_3", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 19, py: 26)
                    if difficulty == 0{ additem(xp: 22, yp: 4, type: 3, number: 2) }
                    if difficulty == 1{ additem(xp: 22, yp: 4, type: 3, number: 12) }
                }else if sceneNumber == 2 || sceneNumber == 12{
                    addplayer(px: 22, py: 4)
                    if difficulty == 0{ additem(xp: 19, yp: 26, type: 3, number: 1) }
                    if difficulty == 1{ additem(xp: 19, yp: 26, type: 3, number: 11) }
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0{
                        additem(xp: 19, yp: 26, type: 3, number: 1)
                        additem(xp: 22, yp: 4, type: 3, number: 2)
                    }
                    if difficulty == 1{
                        additem(xp: 19, yp: 26, type: 3, number: 11)
                        additem(xp: 22, yp: 4, type: 3, number: 12)
                    }
                }
                
                addiceBlock(xp: 3, yp: 1, xs: 7, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 10, yp: 21, xs: 7, ys: 3, Shapetype: 4, type: 1)
                addDamageO(xp: 2, yp: 16, Size: 5, type: 4, damage: 30, Angle: 90)
                addDamageO(xp: 9, yp: 15, Size: 10, type: 5, damage: 30)
                
                addBar(xp: 5, yp: 6)
                
                addBar(xp: 6, yp: 14)
                addBar(xp: 12, yp: 16)
                addBar(xp: 15, yp: 10)
                
                addwarp(xp: 7, yp: 8, movepx: 3, movepy: 11)
                addwarp(xp: 6, yp: 17, movepx: 12, movepy: 13)
                addvector(xp: 13.5, yp: 11.5, Angle: -135, Size: 2)
                
                addiceBlock(xp: 15.5, yp: 30, xs: 14, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 19, yp: 23, xs: 7, ys: 3, Shapetype: 4, type: 1)
                addDamageO(xp: 15, yp: 25, Size: 10, type: 5, damage: 30)
                addBar(xp: 12, yp: 26)
                
                addiceBlock(xp: 22, yp: 1, xs: 7, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 24, yp: 10.5, xs: 1, ys: 6, Shapetype: 4, type: 1)
                
                addBar(xp: 26, yp: 27)
                addBar(xp: 34, yp: 29)
                addBar(xp: 5, yp: 44)
                addBar(xp: 16, yp: 42)
                addBar(xp: 26, yp: 42)
                addBar(xp: 35, yp: 45)
                addBar(xp: 43, yp: 36)
                addBar(xp: 45, yp: 44)
                addBar(xp: 32, yp: 20)
            
                addvector(xp: 34, yp: 6.5, Angle: 180, Size: 2)
                addvector(xp: 26, yp: 29, Angle: 180, Size: 2)
                addvector(xp: 36, yp: 28, Angle: 70, Size: 2)
                
                addwarp(xp: 40, yp: 24, movepx: 16, movepy: 45)
                addwarp(xp: 43, yp: 27, movepx: 40, movepy: 36)
                addwarp(xp: 40, yp: 30, movepx: 5, movepy: 41)
                addwarp(xp: 43, yp: 33, movepx: 43, movepy: 39)
                addwarp(xp: 46, yp: 36, movepx: 13, movepy: 42)
                addwarp(xp: 26, yp: 44, movepx: 45, movepy: 41)
                addwarp(xp: 19, yp: 42, movepx: 42, movepy: 44)
                addwarp(xp: 2, yp: 46, movepx: 38, movepy: 43)
                addwarp(xp: 8, yp: 46, movepx: 32, movepy: 43)
                addwarp(xp: 23, yp: 40, movepx: 38, movepy: 47)
                addwarp(xp: 29, yp: 40, movepx: 32, movepy: 47)
                addwarp(xp: 45, yp: 47, movepx: 32, movepy: 17)
                addwarp(xp: 35, yp: 20, movepx: 20, movepy: 11)
                
                if difficulty == 0{
                    addDamageO(xp: 23, yp: 34, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 29, yp: 28, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 29, yp: 34, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 37, yp: 5, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 18, yp: 8, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 18, yp: 17, Size: 10, type: 5, damage: 30)
                    
                    addDamageO(xp: 25, yp: 23, Size: 10, type: 5, damage: 30, Angle: 90)
                    addDamageO(xp: 24, yp: 14, Size: 10, type: 5, damage: 30, Angle: 90)
                    addDamageO(xp: 34.5, yp: 14, Size: 10, type: 5, damage: 30, Angle: 90)
                    addDamageO(xp: 45, yp: 14, Size: 10, type: 5, damage: 30, Angle: 90)
                    addDamageO(xp: 34, yp: 23, Size: 10, type: 5, damage: 30, Angle: 90)
                    
                    addDamageO(xp: 26, yp: 35, Size: 5, type: 4, damage: 30, Angle: 90)
                    
                    addmoveStageO(xp: 47.5, yp: 8.5, Size: 2, moveStageN: 102, moveSceneN: 3, type: 40)
                    
                    addBar(xp: 15, yp: 14)
                    
                    addBar(xp: 36, yp: 27)
                    addBar(xp: 40, yp: 27)
                    
                    addBar(xp: 3, yp: 20)
                    
                    addwarp(xp: 11, yp: 29, movepx: 15, movepy: 31, BloclNumber1: 1)
                    addmoveAction(xmove: 8, ymove: 0, time: 5.0, BlockNumber: 1)
                    
                    addwarp(xp: 26, yp: 32, movepx: 34, movepy: 26, BloclNumber1: 2)
                    addmoveAction(xmove: 0, ymove: -7, time: 5.0, BlockNumber: 2)
                    
                    addBar(xp: 27, yp: 5, BloclNumber: 10)
                    addmoveAction(xmove: 20, ymove: 0, time: 10, BlockNumber: 10, interval: 5.0, firstinterval: 5.0, SwitchNumber: 10)
                    addwarp(xp: 34, yp: 8, movepx: 40, movepy: 2)
                    addSwitch(xp: 24.5, yp: 3.5, SwitchNumber: 10)
                }
                if difficulty == 1{
                    addDamageO(xp: 23, yp: 34, Size: 10, type: 5, damage: 200)
                    addDamageO(xp: 29, yp: 28, Size: 10, type: 5, damage: 200)
                    addDamageO(xp: 29, yp: 34, Size: 10, type: 5, damage: 200)
                    addDamageO(xp: 37, yp: 5, Size: 10, type: 5, damage: 200)
                    addDamageO(xp: 18, yp: 8, Size: 10, type: 5, damage: 200)
                    addDamageO(xp: 18, yp: 17, Size: 10, type: 5, damage: 200)
                    
                    addDamageO(xp: 25, yp: 23, Size: 10, type: 5, damage: 200, Angle: 90)
                    addDamageO(xp: 24, yp: 14, Size: 10, type: 5, damage: 200, Angle: 90)
                    addDamageO(xp: 34.5, yp: 14, Size: 10, type: 5, damage: 200, Angle: 90)
                    addDamageO(xp: 45, yp: 14, Size: 10, type: 5, damage: 200, Angle: 90)
                    addDamageO(xp: 34, yp: 23, Size: 10, type: 5, damage: 200, Angle: 90)
                    
                    addDamageO(xp: 26, yp: 35, Size: 5, type: 4, damage: 200, Angle: 90)
                    
                    addmoveStageO(xp: 47.5, yp: 8.5, Size: 2, moveStageN: 102, moveSceneN: 13, type: 40)
                    
                    addBar(xp: 39, yp: 27)
                    
                    addBar(xp: 2, yp: 20)
                    
                    addwarp(xp: 11, yp: 29, movepx: 15, movepy: 31, BloclNumber1: 1)
                    addmoveAction(xmove: 8, ymove: 0, time: 3.0, BlockNumber: 1)
                    
                    addwarp(xp: 26, yp: 32, movepx: 34, movepy: 26, BloclNumber1: 2)
                    addmoveAction(xmove: 0, ymove: -7, time: 3.0, BlockNumber: 2)
                    
                    addBar(xp: 27, yp: 5, BloclNumber: 10)
                    addmoveAction(xmove: 20, ymove: 0, time: 5, BlockNumber: 10, interval: 3.0, firstinterval: 3.0, SwitchNumber: 10)
                    addwarp(xp: 34, yp: 8, movepx: 44, movepy: 2)
                    addSwitch(xp: 24.5, yp: 3.5, SwitchNumber: 10)
                }
            }
            
            if (3 <= sceneNumber && sceneNumber <= 5) || (13 <= sceneNumber && sceneNumber <= 15) {
                let StageDis:[CGFloat] = [60,45]
                BackGroundImage(imageName: "bg10_3", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                if sceneNumber == 4 || sceneNumber == 14{
                    addplayer(px: 53, py: 22 ,DFlag: false)
                    if difficulty == 0{ additem(xp: 8, yp: 19, type: 3, number: 5) }
                    if difficulty == 1{ additem(xp: 8, yp: 19, type: 3, number: 15) }
                }else if sceneNumber == 5 || sceneNumber == 15{
                    addplayer(px: 8, py: 19,DFlag: false)
                    if difficulty == 0{ additem(xp: 53, yp: 22, type: 3, number: 4) }
                    if difficulty == 1{ additem(xp: 53, yp: 22, type: 3, number: 14) }
                }else{
                    addplayer(px: 2, py: 5)
                    if difficulty == 0{
                        additem(xp: 53, yp: 22, type: 3, number: 4)
                        additem(xp: 8, yp: 19, type: 3, number: 5)
                    }
                    if difficulty == 1{
                        additem(xp: 53, yp: 22, type: 3, number: 14)
                        additem(xp: 8, yp: 19, type: 3, number: 15)
                    }
                }
                
                addiceBlock(xp: 3, yp: 1, xs: 7, ys: 3, Shapetype: 4, type: 1)
                
                addiceBlock(xp: 29.5, yp: 16.5, xs: 60, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 54.5, yp: 18.5, xs: 10, ys: 2, Shapetype: 4, type: 1)
                addiceBlock(xp: 38.5, yp: 22, xs: 10, ys: 3, Shapetype: 4, type: 1)
                addiceBlock(xp: 10, yp: 31, xs: 1, ys: 27, Shapetype: 4, type: 1)
                addiceBlock(xp: 36, yp: 35.5, xs: 1, ys: 8, Shapetype: 4, type: 1)
                addiceBlock(xp: 23, yp: 34, xs: 25, ys: 1, Shapetype: 4, type: 1)
                addiceBlock(xp: 29.5, yp: 40, xs: 38, ys: 1, Shapetype: 4, type: 1)
                
                addBlock(xp: 3, yp: 20, xs: 4, ys: 1, type: 18)
                addBlock(xp: 49, yp: 37, xs: 1, ys: 8, type: 18)
                addBlock(xp: 50, yp: 37, xs: 10, ys: 1, type: 18)

                addBar(xp: 50, yp: 23)
                addBar(xp: 56, yp: 31)
                
                addBar(xp: 39, yp: 38)
                
                
                addBar(xp: 2, yp: 23)
                addBar(xp: 2, yp: 29)
                addBar(xp: 2, yp: 35)
                addBar(xp: 2, yp: 41)
                addBar(xp: 7, yp: 23)
                addBar(xp: 7, yp: 29)
                addBar(xp: 7, yp: 35)
                addBar(xp: 7, yp: 41)
                
                addBar(xp: 14, yp: 29)
                addBar(xp: 19, yp: 29)
                addBar(xp: 21, yp: 21)
                addBar(xp: 34, yp: 27)
                addBar(xp: 37, yp: 28)
                addBar(xp: 41, yp: 27)

                //矢印
                addvector(xp: 19, yp: 6.5, Angle: 180, Size: 2)
                addvector(xp: 30, yp: 6.5, Angle: -150, Size: 2)
                addvector(xp: 43, yp: 6.6, Angle: 150, Size: 2)
                
                
                addvector(xp: 32.5, yp: 25.5, Angle: -45, Size: 2)
                addvector(xp: 31, yp: 23.5, Angle: -30, Size: 2)
                addvector(xp: 30, yp: 21.5, Angle: -15, Size: 2)
                addvector(xp: 29.5, yp: 19.5, Angle: 0, Size: 2)
                
                //ワープ
                addwarp(xp: 19, yp: 8, movepx: 25, movepy: 3)
                addwarp(xp: 29, yp: 8, movepx: 41, movepy: 3)
                addwarp(xp: 44, yp: 8, movepx: 48, movepy: 12)
                addwarp(xp: 58, yp: 5, movepx: 56, movepy: 23)
                
                addwarp(xp: 46, yp: 23, movepx: 56, movepy: 28,BloclNumber1: 20)
                addmoveAction(xmove: 4, ymove: 4, time: 5.0, BlockNumber: 20)
                
                addwarp(xp: 56, yp: 34, movepx: 39, movepy: 34)
                addwarp(xp: 13.5, yp: 43.5, movepx: 13.5, movepy: 38.5)
                addwarp(xp: 13.5, yp: 36.5, movepx: 19.5, movepy: 38.5)
                addwarp(xp: 30.5, yp: 43.5, movepx: 35.5, movepy: 43.5)
                addwarp(xp: 25.5, yp: 38.5, movepx: 29.5, movepy: 38.5)
                addwarp(xp: 34.5, yp: 37.5, movepx: 0.5, movepy: 18.5)
                addwarp(xp: 2, yp: 26, movepx: 7, movepy: 26)
                addwarp(xp: 2, yp: 32, movepx: 7, movepy: 32)
                addwarp(xp: 2, yp: 38, movepx: 7, movepy: 38)
                addwarp(xp: 4.5, yp: 43.5, movepx: 11.5, movepy: 18.5)
                addwarp(xp: 21, yp: 24, movepx: 14, movepy: 26)
                addwarp(xp: 22, yp: 31, movepx: 38, movepy: 26)
                
                //スキル
                if skillGet[12] == false{ additem(xp: 36, yp: 18, type: 1, number: 12) }
                
                //ゴール
                addgoal(xp: 41.5, yp: 19.5)
                
                //09.22変更
                addwarp(xp: 50, yp: 34, movepx: 54, movepy: 40)
                addwarp(xp: 51, yp: 40, movepx: 47, movepy: 43.5)
                addBar(xp: 43, yp: 36)
                addBar(xp: 47, yp: 35)
                addvector(xp: 52, yp: 39, Angle: -150, Size: 2)
             //   addvector(xp: 40.5, yp: 34, Angle: -90, Size: 2)
                
                
                if difficulty == 0{
                    addBar(xp: 9, yp: 5, BloclNumber: 1)
                    addmoveAction(xmove: 45, ymove: 0, time: 30.0, BlockNumber: 1, interval: 5.0, firstinterval: 5.0, SwitchNumber: 1)
                    addSwitch(xp: 5.5, yp: 3.5, SwitchNumber: 1)
                    
                    addBar(xp: 53, yp: 8)
                    
                    addDamageO(xp: 22, yp: 6, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 34, yp: 6, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 46, yp: 6, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 24.5, yp: 22, Size: 10, type: 5, damage: 30)
                    addDamageO(xp: 44, yp: 22, Size: 10, type: 5, damage: 30)
                    
                    addDamageO(xp: 17, yp: 22, Size: 10, type: 5, damage: 30, BloclNumber: 2)
                    addDamageO(xp: 32, yp: 29, Size: 10, type: 5, damage: 30, BloclNumber: 3)
                    addmoveAction(xmove: 15, ymove: 0, time: 10.0, BlockNumber: 2, interval: 2.0)
                    addmoveAction(xmove: -15, ymove: 0, time: 10.0, BlockNumber: 3, interval: 2.0)
                    
                    addDamageO(xp: 0, yp: 27, Size: 10, type: 5, damage: 30, BloclNumber: 8)
                    addDamageO(xp: 0, yp: 36, Size: 10, type: 5, damage: 30, BloclNumber: 9)
                    addmoveAction(xmove: 9 ,ymove: 0, time: 8.0, BlockNumber: 8, interval: 1.0)
                    addmoveAction(xmove: 9 ,ymove: 0, time: 8.0, BlockNumber: 9, interval: 1.0)
                
                    addDamageO(xp: 21, yp: 18, Size: 10, type: 5, damage: 30, BloclNumber: 4, Angle: 90)
                    addDamageO(xp: 28, yp: 33, Size: 10, type: 5, damage: 30, BloclNumber: 5, Angle: 90)
                    addmoveAction(xmove: 0, ymove: 15, time: 10.0, BlockNumber: 4, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -15, time: 10.0, BlockNumber: 5, interval: 2.0)
                    
                    addDamageO(xp: 40, yp: 31, Size: 10, type: 5, damage: 30, Angle: 90)
                    addDamageO(xp: 48, yp: 31, Size: 10, type: 5, damage: 30, Angle: 90)
                    addDamageO(xp: 57, yp: 26, Size: 10, type: 5, damage: 30, Angle: 90)
                    
                    addDamageO(xp: 22, yp: 13, Size: 5, type: 4, damage: 30)
                    addDamageO(xp: 34, yp: 13, Size: 5, type: 4, damage: 30)
                    addDamageO(xp: 46, yp: 13, Size: 5, type: 4, damage: 30)
                    addDamageO(xp: 44, yp: 29, Size: 5, type: 4, damage: 30)
                    
                    
                    addDamageO(xp: 25, yp: 42, Size: 5, type: 4, damage: 30, BloclNumber: 6)
                    addDamageO(xp: 24, yp: 37, Size: 5, type: 4, damage: 30, BloclNumber: 7)
                    addmoveAction(xmove: 15, ymove: 0, time: 10.0, BlockNumber: 6, interval: 2.0)
                    addmoveAction(xmove: 8, ymove: 0, time: 6.0, BlockNumber: 7, interval: 1.0)
                    
                    addDamageO(xp: 16, yp: 39, Size: 10, type: 3, damage: 30,BloclNumber: 10)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 10)
                    
                    //ツララ
                    addicicle(xp: 57.5, yp: 43.5, xs: 2, ys: 2, damage: 30, type: 1)
                    
                    //09.22変更
                    addDamageO(xp: 52, yp: 34, Size: 5, type: 4, damage: 30)
                }
                if difficulty == 1{
                    addBar(xp: 9, yp: 5, BloclNumber: 1)
                    addmoveAction(xmove: 45, ymove: 0, time: 20.0, BlockNumber: 1, interval: 3.0, firstinterval: 3.0, SwitchNumber: 1)
                    addSwitch(xp: 5.5, yp: 3.5, SwitchNumber: 1)
  
                    addDamageO(xp: 22, yp: 6, Size: 10, type: 5, damage: 80)
                    addDamageO(xp: 34, yp: 6, Size: 10, type: 5, damage: 80)
                    addDamageO(xp: 46, yp: 6, Size: 10, type: 5, damage: 80)
                    addDamageO(xp: 24.5, yp: 22, Size: 10, type: 5, damage: 80)
                    addDamageO(xp: 44, yp: 22, Size: 10, type: 5, damage: 80)
                    
                    addDamageO(xp: 17, yp: 22, Size: 10, type: 5, damage: 50, BloclNumber: 2)
                    addDamageO(xp: 32, yp: 29, Size: 10, type: 5, damage: 50, BloclNumber: 3)
                    addmoveAction(xmove: 15, ymove: 0, time: 10.0, BlockNumber: 2, interval: 2.0)
                    addmoveAction(xmove: -15, ymove: 0, time: 10.0, BlockNumber: 3, interval: 2.0)
                    
                    addDamageO(xp: 0, yp: 27, Size: 10, type: 5, damage: 50, BloclNumber: 8)
                    addDamageO(xp: 0, yp: 36, Size: 10, type: 5, damage: 50, BloclNumber: 9)
                    addmoveAction(xmove: 9 ,ymove: 0, time: 8.0, BlockNumber: 8, interval: 1.0)
                    addmoveAction(xmove: 9 ,ymove: 0, time: 8.0, BlockNumber: 9, interval: 1.0)
                    
                    addDamageO(xp: 21, yp: 18, Size: 10, type: 5, damage: 50, BloclNumber: 4, Angle: 90)
                    addDamageO(xp: 28, yp: 33, Size: 10, type: 5, damage: 50, BloclNumber: 5, Angle: 90)
                    addmoveAction(xmove: 0, ymove: 15, time: 10.0, BlockNumber: 4, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -15, time: 10.0, BlockNumber: 5, interval: 2.0)
                    
                    addDamageO(xp: 40, yp: 31, Size: 10, type: 5, damage: 80, Angle: 90)
                    addDamageO(xp: 48, yp: 31, Size: 10, type: 5, damage: 80, Angle: 90)
                    addDamageO(xp: 57, yp: 26, Size: 10, type: 5, damage: 80, Angle: 90)
                    
                    addDamageO(xp: 22, yp: 13, Size: 5, type: 4, damage: 80)
                    addDamageO(xp: 34, yp: 13, Size: 5, type: 4, damage: 80)
                    addDamageO(xp: 46, yp: 13, Size: 5, type: 4, damage: 80)
                    addDamageO(xp: 44, yp: 29, Size: 5, type: 4, damage: 80)
                    
                    
                    addDamageO(xp: 25, yp: 42, Size: 5, type: 4, damage: 50, BloclNumber: 6)
                    addDamageO(xp: 24, yp: 37, Size: 5, type: 4, damage: 50, BloclNumber: 7)
                    addmoveAction(xmove: 15, ymove: 0, time: 10.0, BlockNumber: 6, interval: 2.0)
                    addmoveAction(xmove: 8, ymove: 0, time: 6.0, BlockNumber: 7, interval: 1.0)
                    
                    addDamageO(xp: 16, yp: 39, Size: 10, type: 3, damage: 50,BloclNumber: 10)
                    addrotateAction(dsita: -90, time: 5.0, BlockNumber: 10)
                    
                    addDamageO(xp: 47, yp: 18, Size: 5, type: 4, damage: 80, Angle: 90)
                    
                    addicicle(xp: 57.5, yp: 43.5, xs: 3, ys: 2, damage: 50, type: 1)
                    
                    
                    //09.22変更
                    addDamageO(xp: 52, yp: 34, Size: 5, type: 4, damage: 80)
                    
                }
            }
        }
//6_10_4
        if stageNumber == 103{
            if (0 <= sceneNumber && sceneNumber <= 1) || sceneNumber == 11 {
                //ステージ枠の作成
                let StageDis:[CGFloat] = [69,100]
                BackGroundImage(imageName: "bg10_4", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                //ステージの条件
                enemymax = 5                        //敵の最大出現数
                NoMagicFlag = true
                     
                //プレイヤーおよびセーブ地点の作成
                if sceneNumber == 1 || sceneNumber == 11{
                    addplayer(px: 25, py: 54, DFlag: false)
                }else{
                    addplayer(px: 66, py: 5,DFlag: false)
                    if difficulty == 0{ additem(xp: 25, yp: 54, type: 3, number: 1) }
                    if difficulty == 1{ additem(xp: 25, yp: 54, type: 3, number: 11) }
                }
                
                //雲
                //通常
                addcloud(xp: 65.5, yp: 2, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 56.5, yp: 2, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 47.5, yp: 2, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 57.5, yp: 20.5, xs: 8, ys: 4, type1: 1, type2: 1)
                addcloud(xp: 30, yp: 11, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 22, yp: 11, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 14, yp: 11, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 25, yp: 49, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 41, yp: 52, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 49, yp: 52, xs: 12, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 42, yp: 92, xs: 12, ys: 5, type1: 1, type2: 1)
                
                //アイテム
                additem(xp: 45, yp: 5, type: 4, number: 2)
                additem(xp: 28, yp: 52, type: 4, number: 2)
                
                //バー
                addBar(xp: 9, yp: 67)
                addBar(xp: 64, yp: 83)
                
                //矢印
                addvector(xp: 49, yp: 5, Angle: 180, Size: 3)
                addvector(xp: 49, yp: 13, Angle: 180, Size: 3)
                addvector(xp: 51, yp: 21, Angle: 150, Size: 3)
                addvector(xp: 56, yp: 23, Angle: 180, Size: 3)
                addvector(xp: 58, yp: 30, Angle: -150, Size: 3)
                addvector(xp: 53, yp: 36, Angle: -140, Size: 3)
                addvector(xp: 48, yp: 40, Angle: -130, Size: 3)
                addvector(xp: 41, yp: 42, Angle: -90, Size: 3)
                addvector(xp: 35, yp: 41, Angle: -60, Size: 3)
                addvector(xp: 31, yp: 38, Angle: -30, Size: 3)
                addvector(xp: 29, yp: 32, Angle: 0, Size: 3)
                
                addvector(xp: 10, yp: 16, Angle: -150, Size: 3)
                addvector(xp: 7, yp: 22, Angle: -150, Size: 3)
                addvector(xp: 3, yp: 27, Angle: -130, Size: 3)
                addvector(xp: 3, yp: 33, Angle: 150, Size: 3)
                addvector(xp: 6, yp: 38, Angle: 150, Size: 3)
                addvector(xp: 9, yp: 44, Angle: 150, Size: 3)
                addvector(xp: 13, yp: 49, Angle: 150, Size: 3)
                addvector(xp: 17, yp: 53, Angle: 120, Size: 3)
                addvector(xp: 22, yp: 54, Angle: -160, Size: 3)
                addvector(xp: 19, yp: 60, Angle: -140, Size: 3)
                addvector(xp: 14, yp: 65, Angle: -120, Size: 3)
                addvector(xp: 8, yp: 69, Angle: -160, Size: 3)
                addvector(xp: 6, yp: 73, Angle: -160, Size: 3)
                addvector(xp: 4, yp: 77, Angle: -160, Size: 3)
                addvector(xp: 2, yp: 82, Angle: -160, Size: 3)
                addvector(xp: 2, yp: 87, Angle: 120, Size: 3)
                addvector(xp: 8, yp: 90, Angle: 120, Size: 3)
                addvector(xp: 15, yp: 93, Angle: 120, Size: 3)
                addvector(xp: 21, yp: 95, Angle: 120, Size: 3)
                addvector(xp: 51, yp: 57, Angle: 180, Size: 3)
                addvector(xp: 51, yp: 64, Angle: 180, Size: 3)
                addvector(xp: 52, yp: 70, Angle: 150, Size: 3)
                addvector(xp: 55, yp: 73, Angle: 90, Size: 3)
                addvector(xp: 58, yp: 70, Angle: 30, Size: 3)
                addvector(xp: 59, yp: 66, Angle: 0, Size: 3)
                addvector(xp: 58, yp: 63, Angle: -45, Size: 3)
                addvector(xp: 56, yp: 62, Angle: -90, Size: 3)
                addvector(xp: 56, yp: 66, Angle: 160, Size: 3)
                addvector(xp: 59, yp: 74, Angle: 160, Size: 3)
                addvector(xp: 62, yp: 80, Angle: 160, Size: 3)
                addvector(xp: 62, yp: 85, Angle: -140, Size: 3)
                addvector(xp: 57, yp: 90, Angle: -140, Size: 3)
                addvector(xp: 52, yp: 95, Angle: -120, Size: 3)
            
                //ワープ
                addwarp(xp: 28, yp: 96, movepx: 39, movepy: 57)
                
                //難易度ノーマルだけ
                if difficulty == 0{
                    //ブロック・ダメージブロック
                    addBlock(xp: 41, yp: 6, xs: 1, ys: 31, type: 2)
                    addDamageBlock(xp: 41, yp: 37, xs: 1, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 41, yp: 5, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 42, yp: 6, xs: 1, ys: 31, type: 6, damage: 50)
                    addDamageBlock(xp: 40, yp: 6, xs: 1, ys: 31, type: 7, damage: 50)
                    
                    addBlock(xp: 27, yp: 48, xs: 41, ys: 1, type: 2)
                    addDamageBlock(xp: 27, yp: 49, xs: 41, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 27, yp: 47, xs: 41, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 68, yp: 48, xs: 1, ys: 1, type: 6, damage: 50)
                    addDamageBlock(xp: 26, yp: 48, xs: 1, ys: 1, type: 7, damage: 50)
                    
                    addBlock(xp: 24, yp: 22, xs: 1, ys: 26, type: 2)
                    addDamageBlock(xp: 24, yp: 48, xs: 1, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 24, yp: 21, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 25, yp: 22, xs: 1, ys: 26, type: 6, damage: 50)
                    addDamageBlock(xp: 23, yp: 22, xs: 1, ys: 26, type: 7, damage: 50)
                    
                    addBlock(xp: 33, yp: 32, xs: 6, ys: 1, type: 2)
                    addDamageBlock(xp: 33, yp: 33, xs: 6, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 33, yp: 31, xs: 6, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 39, yp: 32, xs: 1, ys: 1, type: 6, damage: 50)
                    addDamageBlock(xp: 32, yp: 32, xs: 1, ys: 1, type: 7, damage: 50)
                    
                    addBlock(xp: 0, yp: 26, xs: 2, ys: 11, type: 2)
                    addDamageBlock(xp: 0, yp: 37, xs: 2, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 0, yp: 25, xs: 2, ys: 1, type: 5, damage: 50)
                    
                    addBlock(xp: 0, yp: 79, xs: 2, ys: 11, type: 2)
                    addDamageBlock(xp: 0, yp: 90, xs: 2, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 0, yp: 78, xs: 2, ys: 1, type: 5, damage: 50)
                    
                    addBlock(xp: 33, yp: 51, xs: 1, ys: 48, type: 2)
                    addDamageBlock(xp: 33, yp: 99, xs: 1, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 33, yp: 50, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 34, yp: 51, xs: 1, ys: 48, type: 6, damage: 50)
                    addDamageBlock(xp: 32, yp: 51, xs: 1, ys: 48, type: 7, damage: 50)
                    
                    addBlock(xp: 55, yp: 55, xs: 1, ys: 14, type: 2)
                    addDamageBlock(xp: 55, yp: 69, xs: 1, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 55, yp: 54, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 54, yp: 55, xs: 1, ys: 14, type: 7, damage: 50)
                    
                    //バー
                    addBar(xp: 62, yp: 56)
                    
                    //シーン移動
                    addmoveStageO(xp: 42, yp: 94.5, Size: 2, moveStageN: 103, moveSceneN: 2, type: 41)
                    
                    //矢印
                    addvector(xp: 29, yp: 22, Angle: 0, Size: 3)
                    
                    
                }
                //難易度ハードだけ
                if difficulty == 1{
                    //ブロック・ダメージブロック
                    addBlock(xp: 41, yp: 6, xs: 1, ys: 31, type: 2)
                    addDamageBlock(xp: 41, yp: 37, xs: 1, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 41, yp: 5, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 42, yp: 6, xs: 1, ys: 31, type: 6, damage: 200)
                    addDamageBlock(xp: 40, yp: 6, xs: 1, ys: 31, type: 7, damage: 200)
                    
                    addBlock(xp: 27, yp: 48, xs: 41, ys: 1, type: 2)
                    addDamageBlock(xp: 27, yp: 49, xs: 41, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 27, yp: 47, xs: 41, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 68, yp: 48, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 26, yp: 48, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    addBlock(xp: 24, yp: 22, xs: 1, ys: 26, type: 2)
                    addDamageBlock(xp: 24, yp: 48, xs: 1, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 24, yp: 21, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 25, yp: 22, xs: 1, ys: 26, type: 6, damage: 200)
                    addDamageBlock(xp: 23, yp: 22, xs: 1, ys: 26, type: 7, damage: 200)
                    
                    addBlock(xp: 33, yp: 32, xs: 6, ys: 1, type: 2)
                    addDamageBlock(xp: 33, yp: 33, xs: 6, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 33, yp: 31, xs: 6, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 39, yp: 32, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 32, yp: 32, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    addBlock(xp: 0, yp: 26, xs: 2, ys: 11, type: 2)
                    addDamageBlock(xp: 0, yp: 37, xs: 2, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 0, yp: 25, xs: 2, ys: 1, type: 5, damage: 200)
                    
                    addBlock(xp: 0, yp: 79, xs: 2, ys: 11, type: 2)
                    addDamageBlock(xp: 0, yp: 90, xs: 2, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 0, yp: 78, xs: 2, ys: 1, type: 5, damage: 200)
                    
                    addBlock(xp: 33, yp: 51, xs: 1, ys: 48, type: 2)
                    addDamageBlock(xp: 33, yp: 99, xs: 1, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 33, yp: 50, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 34, yp: 51, xs: 1, ys: 48, type: 6, damage: 200)
                    addDamageBlock(xp: 32, yp: 51, xs: 1, ys: 48, type: 7, damage: 200)
                    
                    addBlock(xp: 55, yp: 55, xs: 1, ys: 14, type: 2)
                    addDamageBlock(xp: 55, yp: 69, xs: 1, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 55, yp: 54, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 54, yp: 55, xs: 1, ys: 14, type: 7, damage: 200)
                    
                    addBlock(xp: 27, yp: 23, xs: 6, ys: 1, type: 2)
                    addDamageBlock(xp: 27, yp: 24, xs: 6, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 27, yp: 22, xs: 6, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 33, yp: 23, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 26, yp: 23, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    //シーン移動
                    addmoveStageO(xp: 42, yp: 94.5, Size: 2, moveStageN: 103, moveSceneN: 12, type: 41)
                    
                    //矢印
                    addvector(xp: 31, yp: 29, Angle: 45, Size: 3)
                    addvector(xp: 34, yp: 26, Angle: 45, Size: 3)
                    addvector(xp: 37, yp: 23, Angle: 0, Size: 3)
                    addvector(xp: 36, yp: 19, Angle: -45, Size: 3)
                    addvector(xp: 33, yp: 16, Angle: -45, Size: 3)
                }
            }
            
            if (2 <= sceneNumber && sceneNumber <= 3) || (12 <= sceneNumber && sceneNumber <= 13) {
                //ステージ枠の作成
                let StageDis:[CGFloat] = [101,100]
                BackGroundImage(imageName: "bg10_4", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                //ステージの条件
                enemymax = 5                        //敵の最大出現数
                NoMagicFlag = true
                     
                //プレイヤーおよびセーブ地点の作成
                if sceneNumber == 3 || sceneNumber == 13{
                    addplayer(px: 49, py: 48)
                }else{
                    addplayer(px: 2, py: 96)
                    if difficulty == 0{ additem(xp: 49, yp: 48, type: 3, number: 3) }
                    if difficulty == 1{ additem(xp: 49, yp: 48, type: 3, number: 13) }
                }
                
                //ブロック
                addBlock(xp: 0, yp: 92, xs: 18, ys: 2, type: 13)
                addBlock(xp: 18, yp: 92, xs: 7, ys: 3, type: 13)
                addBlock(xp: 25, yp: 92, xs: 7, ys: 4, type: 13)
                addBlock(xp: 10, yp: 97, xs: 3, ys: 3, type: 13)
                
                //ダメージブロック
                addDamageBlock(xp: 32, yp: 88, xs: 14, ys: 1, type: 2, damage: 200)
                addDamageBlock(xp: 59, yp: 88, xs: 19, ys: 1, type: 2, damage: 200)
                
                //雲
                //通常
                addcloud(xp: 11, yp: 79, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 17, yp: 81, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 23, yp: 83, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 12, yp: 37, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 12, yp: 22, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 49, yp: 44, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 55, yp: 44, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 32, yp: 2, xs: 9, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 66, yp: 58, xs: 9, ys: 5, type1: 1, type2: 1)
                
                //緑
                addcloud(xp: 5, yp: 78, xs: 9, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 18, yp: 37, xs: 9, ys: 5, type1: 1, type2: 2)
                addcloud(xp: 6, yp: 22, xs: 9, ys: 5, type1: 1, type2: 2)
                
                //アイテム
                additem(xp: 11, yp: 95, type: 4, number: 3)
                additem(xp: 6, yp: 8, type: 4, number: 2)
                additem(xp: 34, yp: 6, type: 4, number: 2)
                
                //バー
                addBar(xp: 41, yp: 35)
                
                //矢印
                addvector(xp: 5, yp: 75, Angle: 0, Size: 3)
                addvector(xp: 5, yp: 64, Angle: 0, Size: 3)
                addvector(xp: 5, yp: 52, Angle: 0, Size: 3)
                addvector(xp: 6, yp: 44, Angle: 45, Size: 3)
                addvector(xp: 18, yp: 39, Angle: 0, Size: 3)
                addvector(xp: 18, yp: 30, Angle: -45, Size: 3)
                addvector(xp: 6, yp: 24, Angle: 0, Size: 3)
                addvector(xp: 6, yp: 9, Angle: 180, Size: 3)
                addvector(xp: 15, yp: 26, Angle: 150, Size: 3)
                addvector(xp: 19, yp: 32, Angle: 180, Size: 3)
                addvector(xp: 20, yp: 37, Angle: -150, Size: 3)
                addvector(xp: 17, yp: 43, Angle: 135, Size: 3)
                addvector(xp: 22, yp: 47, Angle: 135, Size: 3)
                addvector(xp: 28, yp: 50, Angle: 110, Size: 3)
                addvector(xp: 35, yp: 52, Angle: 90, Size: 3)
                addvector(xp: 43, yp: 49, Angle: 60, Size: 3)
                addvector(xp: 37, yp: 6, Angle: 130, Size: 3)
                addvector(xp: 43, yp: 10, Angle: 110, Size: 3)
                addvector(xp: 51, yp: 13, Angle: 100, Size: 3)
                addvector(xp: 61, yp: 14, Angle: 90, Size: 3)
                addvector(xp: 71, yp: 12, Angle: 90, Size: 3)
                addvector(xp: 71, yp: 18, Angle: -145, Size: 3)
                addvector(xp: 66, yp: 23, Angle: -145, Size: 3)
                addvector(xp: 60, yp: 29, Angle: -145, Size: 3)
                addvector(xp: 54, yp: 33, Angle: -120, Size: 3)
                addvector(xp: 48, yp: 36, Angle: -90, Size: 3)
                addvector(xp: 43, yp: 36, Angle: 110, Size: 3)
                addvector(xp: 51, yp: 39, Angle: 90, Size: 3)
                addvector(xp: 60, yp: 40, Angle: 90, Size: 3)
                addvector(xp: 68, yp: 41, Angle: 90, Size: 3)
                addvector(xp: 76, yp: 42, Angle: 90, Size: 3)
                addvector(xp: 85, yp: 46, Angle: -150, Size: 3)
                addvector(xp: 82, yp: 52, Angle: -150, Size: 3)
                addvector(xp: 77, yp: 58, Angle: -130, Size: 3)
                
                //ドア
                adddoor(xp: 56.5, yp: 46.5, movepx: 31, movepy: 6)
                
                //難易度ノーマルだけ
                if difficulty == 0{
                    //スイッチブロック
                    addBlock(xp: 0, yp: 80, xs: 10, ys: 1, type: 5,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチエネミー
                    addenemy(xp: 6, yp: 84, type: 35, HP: 50, Damage: 20, direction: true, maxn: 2, interval: 10.0, SwitchNumber: 1)
                    
                    //ブロック・ダメージブロック
                    addBlock(xp: 12, yp: 65, xs: 88, ys: 1, type: 2)
                    addDamageBlock(xp: 12, yp: 66, xs: 88, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 100, yp: 65, xs: 1, ys: 1, type: 6, damage: 50)
                    addDamageBlock(xp: 11, yp: 65, xs: 1, ys: 1, type: 7, damage: 50)
                    
                    addBlock(xp: 60, yp: 45, xs: 1, ys: 20, type: 2)
                    addDamageBlock(xp: 60, yp: 44, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 61, yp: 45, xs: 1, ys: 20, type: 6, damage: 50)
                    addDamageBlock(xp: 59, yp: 45, xs: 1, ys: 20, type: 7, damage: 50)
                    
                    addBlock(xp: 87, yp: 36, xs: 2, ys: 29, type: 2)
                    
                    addBlock(xp: 25, yp: 1, xs: 1, ys: 43, type: 2)
                    addDamageBlock(xp: 25, yp: 44, xs: 1, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 25, yp: 0, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 26, yp: 1, xs: 1, ys: 43, type: 6, damage: 50)
                    addDamageBlock(xp: 24, yp: 1, xs: 1, ys: 43, type: 7, damage: 50)
                    
                    addBlock(xp: 28, yp: 43, xs: 17, ys: 1, type: 2)
                    addDamageBlock(xp: 28, yp: 44, xs: 17, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 28, yp: 42, xs: 17, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 45, yp: 43, xs: 1, ys: 1, type: 6, damage: 50)
                    addDamageBlock(xp: 27, yp: 43, xs: 1, ys: 1, type: 7, damage: 50)
                    
                    addBlock(xp: 28, yp: 19, xs: 36, ys: 1, type: 2)
                    addDamageBlock(xp: 28, yp: 20, xs: 36, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 28, yp: 18, xs: 36, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 64, yp: 19, xs: 1, ys: 1, type: 6, damage: 50)
                    addDamageBlock(xp: 27, yp: 19, xs: 1, ys: 1, type: 7, damage: 50)
                    
                    addBlock(xp: 73, yp: 0, xs: 2, ys: 26, type: 2)
                    addDamageBlock(xp: 73, yp: 26, xs: 2, ys: 1, type: 3, damage: 50)
                    
                    //シーン移動
                    addmoveStageO(xp: 65.5, yp: 60.5, Size: 2, moveStageN: 103, moveSceneN: 4, type: 41)
                    
                    //アクションあり
                    addcloud(xp: 34, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 2)
                    addcloud(xp: 70, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 3)
                    addcloud(xp: 76, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 4)
                    addcloud(xp: 97, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 5)
                    addcloud(xp: 91, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 6)
                    addcloud(xp: 73, yp: 81, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 7)
                    addcloud(xp: 67, yp: 81, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 8)
                    addcloud(xp: 55, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 9)
                    addcloud(xp: 49, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 10)
                    addcloud(xp: 43, yp: 69, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 11)
                    addcloud(xp: 37, yp: 69, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 12)
                    addmoveAction(xmove: 15, ymove: 0, time: 6.0, BlockNumber: 2, interval: 2.0)
                    addmoveAction(xmove: -15, ymove: 0, time: 6.0, BlockNumber: 3, interval: 2.0)
                    addmoveAction(xmove: 15, ymove: -12, time: 6.0, BlockNumber: 4, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -12, time: 6.0, BlockNumber: 5, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -24, time: 6.0, BlockNumber: 6, interval: 2.0)
                    addmoveAction(xmove: 12, ymove: -12, time: 6.0, BlockNumber: 7, interval: 2.0)
                    addmoveAction(xmove: -6, ymove: -12, time: 6.0, BlockNumber: 8, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -24, time: 6.0, BlockNumber: 9, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -12, time: 6.0, BlockNumber: 10, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: 12, time: 6.0, BlockNumber: 11, interval: 2.0)
                    addmoveAction(xmove: -8, ymove: 14, time: 6.0, BlockNumber: 12, interval: 2.0)
                }
                //難易度ハードだけ
                if difficulty == 1{
                    //スイッチブロック
                    addBlock(xp: 0, yp: 80, xs: 10, ys: 1, type: 5,BlockNumber: 1)
                    addOutAction(interval: 0.0, outtime: 2.0, BlockNumber: 1, SwitchNumbet: 1)
                    //スイッチエネミー
                    addenemy(xp: 6, yp: 84, type: 36, HP: 70, Damage: 30, direction: true, maxn: 2, interval: 10.0, SwitchNumber: 1)
                    
                    //ブロック・ダメージブロック
                    addBlock(xp: 12, yp: 65, xs: 88, ys: 1, type: 2)
                    addDamageBlock(xp: 12, yp: 66, xs: 88, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 100, yp: 65, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 11, yp: 65, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    addBlock(xp: 60, yp: 45, xs: 1, ys: 20, type: 2)
                    addDamageBlock(xp: 60, yp: 44, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 61, yp: 45, xs: 1, ys: 20, type: 6, damage: 200)
                    addDamageBlock(xp: 59, yp: 45, xs: 1, ys: 20, type: 7, damage: 200)
                    
                    addBlock(xp: 87, yp: 36, xs: 2, ys: 29, type: 2)
                    
                    addBlock(xp: 25, yp: 1, xs: 1, ys: 43, type: 2)
                    addDamageBlock(xp: 25, yp: 44, xs: 1, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 25, yp: 0, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 26, yp: 1, xs: 1, ys: 43, type: 6, damage: 200)
                    addDamageBlock(xp: 24, yp: 1, xs: 1, ys: 43, type: 7, damage: 200)
                    
                    addBlock(xp: 28, yp: 43, xs: 17, ys: 1, type: 2)
                    addDamageBlock(xp: 28, yp: 44, xs: 17, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 28, yp: 42, xs: 17, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 45, yp: 43, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 27, yp: 43, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    addBlock(xp: 28, yp: 19, xs: 36, ys: 1, type: 2)
                    addDamageBlock(xp: 28, yp: 20, xs: 36, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 28, yp: 18, xs: 36, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 64, yp: 19, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 27, yp: 19, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    addBlock(xp: 73, yp: 0, xs: 2, ys: 26, type: 2)
                    addDamageBlock(xp: 73, yp: 26, xs: 2, ys: 1, type: 3, damage: 200)
                    
                    //シーン移動
                    addmoveStageO(xp: 65.5, yp: 60.5, Size: 2, moveStageN: 103, moveSceneN: 14, type: 41)
                    
                    //アクションあり
                    addcloud(xp: 34, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 2)
                    addcloud(xp: 70, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 3)
                    addcloud(xp: 76, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 4)
                    addcloud(xp: 97, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 5)
                    addcloud(xp: 91, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 6)
                    addcloud(xp: 73, yp: 81, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 7)
                    addcloud(xp: 67, yp: 81, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 8)
                    addcloud(xp: 55, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 9)
                    addcloud(xp: 49, yp: 93, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 10)
                    addcloud(xp: 43, yp: 69, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 11)
                    addcloud(xp: 37, yp: 69, xs: 9, ys: 5, type1: 1, type2: 1, BlockNumber: 12)
                    addmoveAction(xmove: 15, ymove: 0, time: 4.0, BlockNumber: 2, interval: 2.0)
                    addmoveAction(xmove: -15, ymove: 0, time: 4.0, BlockNumber: 3, interval: 2.0)
                    addmoveAction(xmove: 15, ymove: -12, time: 4.0, BlockNumber: 4, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -12, time: 4.0, BlockNumber: 5, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -24, time: 4.0, BlockNumber: 6, interval: 2.0)
                    addmoveAction(xmove: 12, ymove: -12, time: 4.0, BlockNumber: 7, interval: 2.0)
                    addmoveAction(xmove: -6, ymove: -12, time: 4.0, BlockNumber: 8, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -24, time: 4.0, BlockNumber: 9, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: -12, time: 4.0, BlockNumber: 10, interval: 2.0)
                    addmoveAction(xmove: 0, ymove: 12, time: 4.0, BlockNumber: 11, interval: 2.0)
                    addmoveAction(xmove: -8, ymove: 14, time: 4.0, BlockNumber: 12, interval: 2.0)
                }
            }
            
            if (4 <= sceneNumber && sceneNumber <= 5) || (14 <= sceneNumber && sceneNumber <= 15) {
                //ステージ枠の作成
                let StageDis:[CGFloat] = [101,100]
                BackGroundImage(imageName: "bg10_4", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                //ステージの条件
                enemymax = 5                        //敵の最大出現数
                NoMagicFlag = true
                     
                //プレイヤーおよびセーブ地点の作成
                if sceneNumber == 5 || sceneNumber == 15{
                    addplayer(px: 38, py: 57)
                }else{
                    addplayer(px: 8, py: 6)
                    if difficulty == 0{ additem(xp: 38, yp: 57, type: 3, number: 5) }
                    if difficulty == 1{ additem(xp: 38, yp: 57, type: 3, number: 15) }
                }
                
                //スキル
                if skillGet[10] == false { additem(xp: 85, yp: 96, type: 1, number: 10) }
                
                //雲
                //通常
                addcloud(xp: 8, yp: 3, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 16, yp: 3, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 24, yp: 3, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 36, yp: 3, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 44, yp: 3, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 2, yp: 9, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 9, yp: 9, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 17, yp: 9, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 40, yp: 11, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 40, yp: 21, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 40, yp: 53, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 58, yp: 12, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 79, yp: 12, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 96, yp: 1, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 65, yp: 33, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 98, yp: 35, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 85, yp: 93, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 91, yp: 93, xs: 11, ys: 5, type1: 1, type2: 1)
                addcloud(xp: 97, yp: 93, xs: 11, ys: 5, type1: 1, type2: 1)
    
                //弾性
                //黄色
                addcloud(xp: 76, yp: 33, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 83, yp: 34, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 89, yp: 35, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 54, yp: 69, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 100, yp: 78, xs: 4, ys: 4, type1: 2, type2: 1)
                addcloud(xp: 85, yp: 85, xs: 4, ys: 4, type1: 2, type2: 1)
                //緑
                addcloud(xp: 63, yp: 81, xs: 4, ys: 4, type1: 2, type2: 2)
                //赤
                addcloud(xp: 30, yp: 3, xs: 3, ys: 5, type1: 2, type2: 3)
                addcloud(xp: 45, yp: 11, xs: 3, ys: 3, type1: 2, type2: 3)
                addcloud(xp: 63, yp: 12, xs: 3, ys: 3, type1: 2, type2: 3)
                
                //アイテム
                additem(xp: 19, yp: 6, type: 4, number: 3)
                additem(xp: 19, yp: 7, type: 4, number: 3)
                additem(xp: 96, yp: 4, type: 4, number: 1)
                additem(xp: 99, yp: 37, type: 4, number: 2)
                additem(xp: 42, yp: 56, type: 4, number: 2)
                
                //扉
                adddoor(xp: 99.5, yp: 3.5, movepx: 2, movepy: 13)
                adddoor(xp: 97, yp: 48.5, movepx: 2, movepy: 13)
                
                //ワープ
                addwarp(xp: 63, yp: 96, movepx: 96, movepy: 57)
                
                //バー
                addBar(xp: 47, yp: 26)
                addBar(xp: 51, yp: 29)
                addBar(xp: 55, yp: 32)
                
                //矢印
                addvector(xp: 30, yp: 10, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 15, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 20, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 25, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 30, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 35, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 40, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 45, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 50, Angle: 180, Size: 3)
                addvector(xp: 30, yp: 55, Angle: 90, Size: 3)
                addvector(xp: 30, yp: 60, Angle: 60, Size: 3)
                addvector(xp: 30, yp: 65, Angle: 45, Size: 3)
                addvector(xp: 30, yp: 70, Angle: 45, Size: 3)
                addvector(xp: 32, yp: 11, Angle: 135, Size: 3)
                addvector(xp: 32, yp: 21, Angle: 135, Size: 3)
                addvector(xp: 32, yp: 53, Angle: 135, Size: 3)
                addvector(xp: 46, yp: 12, Angle: 135, Size: 3)
                addvector(xp: 64, yp: 13, Angle: 135, Size: 3)
                addvector(xp: 91, yp: 7, Angle: 90, Size: 3)
                addvector(xp: 44, yp: 57, Angle: 160, Size: 3)
                addvector(xp: 47, yp: 64, Angle: 160, Size: 3)
                addvector(xp: 50, yp: 70, Angle: 160, Size: 3)
                addvector(xp: 55, yp: 72, Angle: 160, Size: 3)
                addvector(xp: 58, yp: 79, Angle: 160, Size: 3)
                addvector(xp: 63, yp: 85, Angle: 180, Size: 3)
                addvector(xp: 63, yp: 91, Angle: 180, Size: 3)
                addvector(xp: 98, yp: 80, Angle: -160, Size: 3)
                addvector(xp: 83, yp: 86, Angle: -120, Size: 3)
                addvector(xp: 77, yp: 89, Angle: -120, Size: 3)
                addvector(xp: 72, yp: 91, Angle: -160, Size: 3)
                addvector(xp: 72, yp: 95, Angle: 120, Size: 3)
                
                addvector(xp: 97, yp: 40, Angle: 180, Size: 3)
                addvector(xp: 97, yp: 45, Angle: 180, Size: 3)
                
                //ゴール
                addgoal(xp: 98.5, yp: 96.5)
                
                //難易度ノーマルだけ
                if difficulty == 0{
                    //ブロック・ダメージブロック
                    addBlock(xp: 46, yp: 52, xs: 54, ys: 1, type: 2)
                    addDamageBlock(xp: 46, yp: 53, xs: 54, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 46, yp: 51, xs: 54, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 100, yp: 52, xs: 1, ys: 1, type: 6, damage: 50)
                    addDamageBlock(xp: 45, yp: 52, xs: 1, ys: 1, type: 7, damage: 50)
                    
                    addBlock(xp: 70, yp: 55, xs: 1, ys: 44, type: 2)
                    addDamageBlock(xp: 70, yp: 99, xs: 1, ys: 1, type: 3, damage: 50)
                    addDamageBlock(xp: 70, yp: 54, xs: 1, ys: 1, type: 5, damage: 50)
                    addDamageBlock(xp: 71, yp: 55, xs: 1, ys: 31, type: 6, damage: 50)
                    addDamageBlock(xp: 69, yp: 55, xs: 1, ys: 44, type: 7, damage: 50)
                    
                    //雲
                    
                    //緑
                    addcloud(xp: 87.5, yp: 11, xs: 11, ys: 5, type1: 1, type2: 2)
                    
                    //弾性
                    //黄色
                    addcloud(xp: 91, yp: 66, xs: 4, ys: 4, type1: 2, type2: 1)
                    
                    //矢印
                    addvector(xp: 96, yp: 61, Angle: 180, Size: 3)
                    addvector(xp: 95, yp: 67, Angle: -160, Size: 3)
                    addvector(xp: 92, yp: 69, Angle: 160, Size: 3)
            
                }
                //難易度ハードだけ
                if difficulty == 1{
                    //ブロック・ダメージブロック
                    addBlock(xp: 46, yp: 52, xs: 54, ys: 1, type: 2)
                    addDamageBlock(xp: 46, yp: 53, xs: 54, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 46, yp: 51, xs: 54, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 100, yp: 52, xs: 1, ys: 1, type: 6, damage: 200)
                    addDamageBlock(xp: 45, yp: 52, xs: 1, ys: 1, type: 7, damage: 200)
                    
                    addBlock(xp: 70, yp: 55, xs: 1, ys: 44, type: 2)
                    addDamageBlock(xp: 70, yp: 99, xs: 1, ys: 1, type: 3, damage: 200)
                    addDamageBlock(xp: 70, yp: 54, xs: 1, ys: 1, type: 5, damage: 200)
                    addDamageBlock(xp: 71, yp: 55, xs: 1, ys: 31, type: 6, damage: 200)
                    addDamageBlock(xp: 69, yp: 55, xs: 1, ys: 44, type: 7, damage: 200)
                    
                    addDamageBlock(xp: 58, yp: 99, xs: 11, ys: 1, type: 5, damage: 100)
                    
                    //黄
                    addcloud(xp: 87.5, yp: 11, xs: 10, ys: 5, type1: 1, type2: 3)
                }
            }
            
        }
        
        
        
//6_10_5
        if stageNumber == 104{
            if sceneNumber == 0{
                let StageDis:[CGFloat] = [30,40]
                BackGroundImage(imageName: "bg10_5", FrameSize: StageDis )
                addBoundaryBlock(Size: StageDis)
                
                addplayer(px: 2, py: 5)
                addBlock(xp: 0, yp: 0, xs: 40, ys: 3, type: 20)
        
            }
        }
        
        //カメラ作成
        let CameraP = CGPoint(x: body.position.x, y: body.position.y + BSize * 2)
        cameraNode.position = CameraP
        if StageFrameFlag{
            if cameraNode.position.x <= w / 2{ cameraNode.position.x = w / 2}
            if cameraNode.position.x >= BSize * StagedX - w / 2 { cameraNode.position.x = BSize * StagedX - w / 2 }
            if cameraNode.position.y <= h / 2{ cameraNode.position.y = h / 2}
            if cameraNode.position.y >= BSize * StagedY - h / 2 { cameraNode.position.y = BSize * StagedY - h / 2 }
        }
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.addChild(moveBGimage)
    }
}





