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

class SSStage: GameController{
    override func didMove(to view: SKView){
        let stageNumber = viewnode.getStageN()         //ステージナンバーを取得
        let sceneNumber = viewnode.getStageSceneN()  //シーンナンバーを取得
        //ステージクリア状況の読み込み
        let CFstatas:[Int] = viewnode.CFGet()
        let CFitemFlag = viewnode.getCFitemF()
        let difficulty = viewnode.getDifficulty()
        
        if stageNumber == -12 { PracticeFlag = true }
        SetUpStage()
        
        self.physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -gra * Double(impulseR) )
        
        //5¥最初のステージセレクトステージ
        if stageNumber == -1{
            let StageS:[CGFloat] = [52,100]
            BackGroundImage(imageName: "bg0_1", FrameSize: StageS)
            if sceneNumber == -2{
                addplayer(px: 44, py: 8,DFlag: false)
            }else if sceneNumber == -3{
                addplayer(px: 45, py: 17,DFlag: false)
            }else if sceneNumber == -4{
                addplayer(px: 9, py: 25)
            }else if sceneNumber == -5{
                addplayer(px: 44, py: 43,DFlag: false)
            }else if sceneNumber == -6{
                addplayer(px: 9, py: 43)
            }else if sceneNumber == -7{
                addplayer(px: 46, py: 67,DFlag: false)
            }else if sceneNumber == -8{
                addplayer(px: 9, py: 59)
            }else if sceneNumber == -9{
                addplayer(px: 33, py: 77,DFlag: false)
            }else if sceneNumber == -10{
                addplayer(px: 33, py: 77,DFlag: false)
            }else if sceneNumber == -12{
                addplayer(px: 39, py: 29)
            }else{
                addplayer(px: 10, py: 8)
            }
            
            addBoard(xp: 13.5, yp: 6.5, type:1, number: 2)
            addBoard(xp: 36.5, yp: 9.5, type: 1, number: 3)
            addBlock(xp: 35, yp: 8, xs: 4, ys: 1, type: 1)
           
            addBlock(xp: 0, yp: 0, xs: 20, ys: 6, type: 3)
            addBlock(xp: 20, yp: 0, xs:20, ys: 6, type: 3)
            addBlock(xp: 40, yp: 0, xs:12, ys: 6, type: 3)
            
            addBoundaryBlock(Size: StageS)
            
            addBoard(xp: 9, yp: 8.5, Size: 3, Number: 1)
            addBoard(xp: 39, yp: 29, Size: 7, Number: 1)
            
            if CFitemFlag[9]{
                addmoveStageO(xp: 2, yp: 8, Size: 5, moveStageN: 0, moveSceneN: 0, type: 50)
            }else{
                addmoveStageO(xp: 2, yp: 8, Size: 5, moveStageN: 0, moveSceneN: 0, type: 5)
            }
            addmoveStageO(xp: 49, yp: 8, Size: 5, moveStageN: -2, moveSceneN: 0, type: 6)
            
            addBlock(xp: 18, yp: 6, xs: 9, ys: 1, type: 3)
            addBlock(xp: 21, yp: 7, xs: 3, ys: 1, type: 3)
            
            addBlock(xp: 27, yp: 9, xs: 4, ys: 1, type: 6)
            addBlock(xp: 30, yp: 10, xs: 4, ys: 1, type: 6)
            addBlock(xp: 33, yp: 11, xs: 1, ys: 1, type: 6)
            addBlock(xp: 33, yp: 12, xs: 7, ys: 1, type: 6)
            addBlock(xp: 40, yp: 12, xs: 12, ys: 3, type: 1)
            
            addBlock(xp: 26, yp: 20, xs: 20, ys: 1, type: 6)
            addBlock(xp: 46, yp: 20, xs: 6, ys: 1, type: 6)
            
            addBlock(xp: 22, yp: 14, xs: 8, ys: 1, type: 6)
            
            addBlock(xp: 18, yp: 15, xs: 5, ys: 1, type: 7)
            addBlock(xp: 18, yp: 16, xs: 1, ys: 6, type: 7)
            addBlock(xp: 0, yp: 22, xs: 19, ys: 1, type: 7)
            addBlock(xp: 0, yp: 28, xs: 19, ys: 1, type: 7)
            
            addBlock(xp: 0, yp: 29, xs: 19, ys: 10, type: 10)
            addBlock(xp: 0, yp: 39, xs: 19, ys: 2, type: 18)
      
            addBlock(xp: 26, yp: 21, xs: 26, ys: 5, type: 8)
            addBlock(xp: 26, yp: 26, xs: 6, ys: 9, type: 8)
            addBlock(xp: 48, yp: 26, xs: 4, ys: 9, type: 8)
            addBlock(xp: 26, yp: 35, xs: 26, ys: 6, type: 8)
            
            addBlock(xp: 32, yp: 26, xs: 16, ys: 1, type: 19)
            addBlock(xp: 32, yp: 27, xs: 1, ys: 7, type: 19)
            addBlock(xp: 47, yp: 27, xs: 1, ys: 7, type: 19)
            addBlock(xp: 32, yp: 34, xs: 16, ys: 1, type: 19)
            addmoveStageO(xp: 34, yp: 28, Size: 3, moveStageN: -12, moveSceneN: 0, type: 28)
            
            addwarp(xp: 6.5, yp: 8.5, movepx: 44.5, movepy: 29.5)
            
            addBlock(xp: 18, yp: 52, xs: 1, ys: 18, type: 12)
            addBlock(xp: 26, yp: 52, xs: 20, ys: 1, type: 12)
            addBlock(xp: 46, yp: 52, xs: 6, ys: 1, type: 12)
            
            addBlock(xp: 18, yp: 70, xs: 20, ys: 5, type: 16)
            addBlock(xp: 38, yp: 70, xs: 14, ys: 5, type: 16)
            
            addBlock(xp: 19, yp: 57, xs: 5, ys: 4, type: 13)
            addBlock(xp: 29, yp: 54, xs: 5, ys: 1, type: 13)
            addBlock(xp: 37, yp: 56, xs: 6, ys: 4, type: 13)
            addBlock(xp: 45, yp: 62, xs: 7, ys: 4, type: 13)
     
            addBar(xp: 22, yp: 26)
            addBar(xp: 22, yp: 32)
            addBar(xp: 22, yp: 38)
            addBar(xp: 22, yp: 45)
            addBar(xp: 22, yp: 50)
            
            if CFitemFlag[1] == false && CFitemFlag[11] == false{
                addBlock(xp: 35, yp: 13, xs: 1, ys: 7, type: 5)
            }
            
            if (CFitemFlag[4] == false || CFitemFlag[5] == false) && (CFitemFlag[4] == false || CFitemFlag[15] == false)
            && (CFitemFlag[14] == false || CFitemFlag[5] == false) && (CFitemFlag[14] == false || CFitemFlag[15] == false){
                addBlock(xp: 19, yp: 52, xs: 7, ys: 1, type: 5)
            }
            addmoveStageO(xp: 52.5, yp: 17.5, Size: 10, moveStageN: -3, moveSceneN: 0, type: 21)
            addBlock(xp: 0, yp: 56, xs: 13, ys: 1, type: 15)

            addmoveStageO(xp: 1.5, yp: 26.5, Size: 8, moveStageN: -4, moveSceneN: 0, type: 22)
            addmoveStageO(xp: 52, yp: 46, Size: 11, moveStageN: -5, moveSceneN: 0, type: 25)
            
            addmoveStageO(xp: 2.5, yp: 43.5, Size: 6, moveStageN: -6, moveSceneN: 0, type: 26)
            
            addmoveStageO(xp: 52, yp: 68, Size: 7, moveStageN: -7, moveSceneN: 0, type: 30)
        }
        //5¥第１エリア草原
        if stageNumber == -2{
            let StageS:[CGFloat] = [31,56]
            BackGroundImage(imageName: "bg1_1", FrameSize: StageS)
            addBoundaryBlock(Size: StageS)
            
            if sceneNumber == 1{
                addplayer(px: 23, py: 4,DFlag: false)
            }else if sceneNumber == 2{
                addplayer(px: 26.5, py: 9.5,DFlag: false)
            }else if sceneNumber == 3{
                addplayer(px: 3.5, py: 11.5)
            }else if sceneNumber == 4{
                addplayer(px: 26, py: 20.5,DFlag: false)
            }else if sceneNumber == 5{
                addplayer(px: 5, py: 20.5)
            }else if sceneNumber == 6{
                addplayer(px: 11.5, py: 22.5,DFlag: false)
            }else if sceneNumber == 100{
                addplayer(px: 25, py: 50,DFlag: false)
            }else {
                addplayer(px: 7, py: 5)
            }
            addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 3)
            addBlock(xp: 20, yp: 0, xs: 11, ys: 3, type: 3)
            addmoveStageO(xp: 2, yp: 5, Size: 5, moveStageN: -1, moveSceneN: -2,  type: 6)
            
            addBlock(xp: 15, yp: 4, xs: 5, ys: 1, type: 1)
            addBlock(xp: 22, yp: 6, xs: 9, ys: 1, type: 1)
            addBlock(xp: 26, yp: 7, xs: 5, ys: 2, type: 1)
            
            addBlock(xp: 0, yp: 6, xs: 13, ys: 1, type: 1)
            addBlock(xp: 0, yp: 7, xs: 9, ys: 2, type: 1)
            addBlock(xp: 0, yp: 9, xs: 5, ys: 2, type: 1)
            
            addBlock(xp: 10, yp: 11, xs: 13, ys: 1, type: 1)
            addBlock(xp: 14, yp: 12, xs: 9, ys: 2, type: 1)
            addBlock(xp: 17, yp: 14, xs: 6, ys: 2, type: 1)
            addBlock(xp: 20, yp: 16, xs: 3, ys: 2, type: 1)
            addBlock(xp: 23, yp: 17, xs: 8, ys: 1, type: 1)
            addBlock(xp: 25, yp: 18, xs: 3, ys: 2, type: 1)
            
            addBlock(xp: 0, yp: 17, xs: 14, ys: 1, type: 1)
            addBlock(xp: 4, yp: 18, xs: 3, ys: 2, type: 1)
            
            addBlock(xp: 10, yp: 21, xs: 13, ys: 1, type: 1)
            addBlock(xp: 14, yp: 22, xs: 5, ys: 2, type: 1)
            
            if      CFstatas[1] == 1{ addmoveStageO(xp: 29.5, yp: 3.5, Size: 2, moveStageN: 1, moveSceneN: 0, type: 3)}
            else if CFstatas[1] == 2{ addmoveStageO(xp: 29.5, yp: 3.5, Size: 2, moveStageN: 1, moveSceneN: 0, type: 103)}
            else                    { addmoveStageO(xp: 29.5, yp: 3.5, Size: 2, moveStageN: 1, moveSceneN: 0, type: 1)}
            
            if CFstatas[1] >= 1{
                if      CFstatas[2] == 1{ addmoveStageO(xp: 29.5, yp: 9.5, Size: 2, moveStageN: 2, moveSceneN: 0, type: 3)}
                else if CFstatas[2] == 2{ addmoveStageO(xp: 29.5, yp: 9.5, Size: 2, moveStageN: 2, moveSceneN: 0, type: 103)}
                else                    { addmoveStageO(xp: 29.5, yp: 9.5, Size: 2, moveStageN: 2, moveSceneN: 0, type: 1)}
                
                if      CFstatas[3] == 1{ addmoveStageO(xp: 0.5, yp: 11.5, Size: 2, moveStageN: 3, moveSceneN: 0, type: 4)}
                else if CFstatas[3] == 2{ addmoveStageO(xp: 0.5, yp: 11.5, Size: 2, moveStageN: 3, moveSceneN: 0, type: 104) }
                else                    { addmoveStageO(xp: 0.5, yp: 11.5, Size: 2, moveStageN: 3, moveSceneN: 0, type: 2)}
            }
            
            if CFstatas[2] >= 1 && CFstatas[3] >= 1{
                if      CFstatas[4] == 1{ addmoveStageO(xp: 29.5, yp: 18.5, Size: 2, moveStageN: 4, moveSceneN: 0, type: 3)}
                else if CFstatas[4] == 2{ addmoveStageO(xp: 29.5, yp: 18.5, Size: 2, moveStageN: 4, moveSceneN: 0, type: 103)}
                else                    { addmoveStageO(xp: 29.5, yp: 18.5, Size: 2, moveStageN: 4, moveSceneN: 0, type: 1)}
                
                if      CFstatas[5] == 1{ addmoveStageO(xp: 0.5, yp: 18.5, Size: 2, moveStageN: 5, moveSceneN: 0, type: 4)}
                else if CFstatas[5] == 2{ addmoveStageO(xp: 0.5, yp: 18.5, Size: 2, moveStageN: 5, moveSceneN: 0, type: 104)}
                else                    { addmoveStageO(xp: 0.5, yp: 18.5, Size: 2, moveStageN: 5, moveSceneN: 0, type: 2)}
            }
            
            if difficulty >= 1{
                if CFstatas[1] >= 2 && CFstatas[2] >= 2 && CFstatas[3] >= 2 && CFstatas[4] >= 2 && CFstatas[5] >= 2{
                    if      CFstatas[6] == 1{ addmoveStageO(xp: 16, yp: 25, Size: 3, moveStageN: 6, moveSceneN: 0, type: 8) }
                    else if CFstatas[6] == 2{ addmoveStageO(xp: 16, yp: 25, Size: 3, moveStageN: 6, moveSceneN: 0, type: 51) }
                    else                    { addmoveStageO(xp: 16, yp: 25, Size: 3, moveStageN: 6, moveSceneN: 0, type: 7) }
                }
            }else{
                if CFstatas[1] >= 1 && CFstatas[2] >= 1 && CFstatas[3] >= 1 && CFstatas[4] >= 1 && CFstatas[5] >= 1{
                    if      CFstatas[6] == 1{ addmoveStageO(xp: 16, yp: 25, Size: 3, moveStageN: 6, moveSceneN: 0, type: 8) }
                    else if CFstatas[6] == 2{ addmoveStageO(xp: 16, yp: 25, Size: 3, moveStageN: 6, moveSceneN: 0, type: 51) }
                    else                    { addmoveStageO(xp: 16, yp: 25, Size: 3, moveStageN: 6, moveSceneN: 0, type: 7) }
                }
            }
            
            addBar(xp: 6, yp: 25)
            addBar(xp: 5, yp: 38)
            addBlock(xp: 9, yp: 30, xs: 2, ys: 18, type: 1)
            addBlock(xp: 11, yp: 46, xs: 20, ys: 2, type: 1)
            if CFstatas[100] == 1      { addmoveStageO(xp: 29.5, yp: 48.5, Size: 2, moveStageN: 100, moveSceneN: 0, type: 3) }
            else if CFstatas[100] == 2 { addmoveStageO(xp: 29.5, yp: 48.5, Size: 2, moveStageN: 100, moveSceneN: 0, type: 103) }
            else                       { addmoveStageO(xp: 29.5, yp: 48.5, Size: 2, moveStageN: 100, moveSceneN: 0, type: 101) }
        }
        
        //5¥第２エリア森林
        if stageNumber == -3{
            let StageS:[CGFloat] = [32,60]
            BackGroundImage(imageName: "bg2_1", FrameSize: StageS)
            
            if sceneNumber == 7{
                addplayer(px: 27, py: 5,DFlag: false)
            }else if sceneNumber == 8{
                addplayer(px: 27, py: 15,DFlag: false)
            }else if sceneNumber == 9{
                addplayer(px: 4, py: 13.5)
            }else if sceneNumber == 10{
                addplayer(px: 27.5, py: 27,DFlag: false)
            }else if sceneNumber == 11{
                addplayer(px: 4, py: 44)
            }else if sceneNumber == 12{
                addplayer(px: 28, py: 45,DFlag: false)
            }else if sceneNumber == 13{
                addplayer(px: 14, py: 57,DFlag: false)
            }else {
                addplayer(px: 8, py: 5)
            }
            
            addBoundaryBlock(Size: StageS)
            
            addBlock(xp: 0, yp: 0, xs: 20, ys: 3, type: 1)
            addBlock(xp: 20, yp: 0, xs: 12, ys: 3, type: 1)
            addBlock(xp: 13, yp: 3, xs: 4, ys: 1, type: 1)
            addmoveStageO(xp: 0.5, yp: 5.5, Size: 10, moveStageN: -1, moveSceneN: -3, type: 21)
            if      CFstatas[7] == 1 { addmoveStageO(xp: 30.5, yp: 3.5, Size: 2, moveStageN: 7, moveSceneN: 0, type: 3) }
            else if CFstatas[7] == 2 { addmoveStageO(xp: 30.5, yp: 3.5, Size: 2, moveStageN: 7, moveSceneN: 0, type: 103) }
            else                     { addmoveStageO(xp: 30.5, yp: 3.5, Size: 2, moveStageN: 7, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 20, yp: 5, xs: 5, ys: 1, type: 6)
            addBlock(xp: 23, yp: 6, xs: 2, ys: 7, type: 6)
            addBlock(xp: 25, yp: 12, xs: 7, ys: 1, type: 6)
            if      CFstatas[8] == 1  { addmoveStageO(xp: 30.5, yp: 13.5, Size: 2, moveStageN: 8, moveSceneN: 0, type: 3) }
            else if CFstatas[8] == 2  { addmoveStageO(xp: 30.5, yp: 13.5, Size: 2, moveStageN: 8, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 30.5, yp: 13.5, Size: 2, moveStageN: 8, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 0, yp: 8, xs: 10, ys: 5, type: 1)
            addBlock(xp: 10, yp: 12, xs: 9, ys: 1, type: 1)
            addBlockO(xp: 11, yp: 17, Size: 9, type: 5)
            if      CFstatas[9] == 1 { addmoveStageO(xp: 0.5, yp: 13.5, Size: 2, moveStageN: 9, moveSceneN: 0, type: 4) }
            else if CFstatas[9] == 2 { addmoveStageO(xp: 0.5, yp: 13.5, Size: 2, moveStageN: 9, moveSceneN: 0, type: 104) }
            else                     { addmoveStageO(xp: 0.5, yp: 13.5, Size: 2, moveStageN: 9, moveSceneN: 0, type: 2) }
            
            addBlock(xp: 0, yp: 16, xs: 5, ys: 3, type: 1)
            addBlock(xp: 3, yp: 15, xs: 2, ys: 1, type: 1)
            addBlockO(xp: 0.5, yp: 25.5, Size: 14, type: 2)
            
            addBlock(xp: 18, yp: 18, xs: 7, ys: 2, type: 1)
            addBlockO(xp: 25, yp: 23, Size: 7, type: 4)
            
            addBlock(xp: 27, yp: 23, xs: 5, ys: 2, type: 6)
            if      CFstatas[10] == 1 { addmoveStageO(xp: 30.5, yp: 25.5, Size: 2, moveStageN: 10, moveSceneN: 0, type: 3) }
            else if CFstatas[10] == 2 { addmoveStageO(xp: 30.5, yp: 25.5, Size: 2, moveStageN: 10, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 30.5, yp: 25.5, Size: 2, moveStageN: 10, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 5, yp: 25, xs: 3, ys: 1, type: 6)
            addBlock(xp: 8, yp: 25, xs: 10, ys: 3, type: 6)
            
            addBlock(xp: 13, yp: 30, xs: 8, ys: 4, type: 1)
            addBlockO(xp: 19.5, yp: 41.5, Size: 16, type: 4)
            
            addBlock(xp: 0, yp: 40, xs: 12, ys: 3, type: 6)
            addBlock(xp: 8, yp: 43, xs: 4, ys: 1, type: 6)
            if      CFstatas[11] == 1{ addmoveStageO(xp: 0.5, yp: 43.5, Size: 2, moveStageN: 11, moveSceneN: 0, type: 4) }
            else if CFstatas[11] == 2{ addmoveStageO(xp: 0.5, yp: 43.5, Size: 2, moveStageN: 11, moveSceneN: 0, type: 104) }
            else                     { addmoveStageO(xp: 0.5, yp: 43.5, Size: 2, moveStageN: 11, moveSceneN: 0, type: 2) }
            
            addBlock(xp: 24, yp: 40, xs: 8, ys: 3, type: 6)
            if      CFstatas[12] == 1 { addmoveStageO(xp: 30.5, yp: 43.5, Size: 2, moveStageN: 12, moveSceneN: 0, type: 3) }
            else if CFstatas[12] == 2 { addmoveStageO(xp: 30.5, yp: 43.5, Size: 2, moveStageN: 12, moveSceneN: 0, type: 103)  }
            else                      { addmoveStageO(xp: 30.5, yp: 43.5, Size: 2, moveStageN: 12, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 0, yp: 46, xs: 5, ys: 4, type: 6)
            addBlock(xp: 7, yp: 52, xs: 16, ys: 4, type: 6)
            
            if difficulty >= 1{
                if CFstatas[7] >= 2 && CFstatas[8] >= 2 && CFstatas[9] >= 2 && CFstatas[10] >= 2 && CFstatas[11] >= 2 && CFstatas[12] >= 2 {
                    if      CFstatas[13] == 1 { addmoveStageO(xp: 19, yp: 57, Size: 3, moveStageN: 13, moveSceneN: 0, type: 10) }
                    else if CFstatas[13] == 2 { addmoveStageO(xp: 19, yp: 57, Size: 3, moveStageN: 13, moveSceneN: 0, type: 52) }
                    else                      { addmoveStageO(xp: 19, yp: 57, Size: 3, moveStageN: 13, moveSceneN: 0, type: 9) }
                }
            }else{
                if CFstatas[7] >= 1 && CFstatas[8] >= 1 && CFstatas[9] >= 1 && CFstatas[10] >= 1 && CFstatas[11] >= 1 && CFstatas[12] >= 1 {
                    if      CFstatas[13] == 1 { addmoveStageO(xp: 19, yp: 57, Size: 3, moveStageN: 13, moveSceneN: 0, type: 10) }
                    else if CFstatas[13] == 2 { addmoveStageO(xp: 19, yp: 57, Size: 3, moveStageN: 13, moveSceneN: 0, type: 52) }
                    else                      { addmoveStageO(xp: 19, yp: 57, Size: 3, moveStageN: 13, moveSceneN: 0, type: 9) }
                }
            }
        }
        
        //5¥第３エリア洞窟
        if stageNumber == -4{
            let StageS:[CGFloat] = [62,67]
            BackGroundImage(imageName: "bg3_1", FrameSize: StageS)
            addBoundaryBlock(Size: StageS)
            
            if sceneNumber == 14{
                addplayer(px: 57, py: 4,DFlag: false)
            }else if sceneNumber == 15{
                addplayer(px: 4, py: 22)
            }else if sceneNumber == 16{
                addplayer(px: 4, py: 34)
            }else if sceneNumber == 17{
                addplayer(px: 57, py: 17,DFlag: false)
            }else if sceneNumber == 18{
                addplayer(px: 4, py: 52)
            }else if sceneNumber == 19{
                addplayer(px: 57, py: 52,DFlag: false)
            }else if sceneNumber == 20{
                addplayer(px: 31, py: 64)
            }else if sceneNumber == 101{
                addplayer(px: 56, py: 64,DFlag: false)
            }else {
                addplayer(px: 56, py: 35,DFlag: false)
            }
            
            addBlock(xp: 0, yp: 0, xs: 5, ys: 20, type: 7)
            addBlock(xp: 5, yp: 0, xs: 57, ys: 3, type: 7)
            addBlock(xp: 5, yp: 17, xs: 4, ys: 3, type: 7)
            if      CFstatas[15] == 1 { addmoveStageO(xp: 0.5, yp: 20.5, Size: 2, moveStageN: 15, moveSceneN: 0, type: 4) }
            else if CFstatas[15] == 2 { addmoveStageO(xp: 0.5, yp: 20.5, Size: 2, moveStageN: 15, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 20.5, Size: 2, moveStageN: 15, moveSceneN: 0, type: 2) }
            addBlockO(xp: 27, yp: 2, Size: 5, type: 9,BloclNumber: 1)
            addmoveAction(xmove: 0, ymove: 20, time: 10.0, BlockNumber: 1, interval: 3.0, firstinterval: 3.0, type: 3, SwitchNumber: 1)
            addSwitch(xp: 30.5, yp: 3.5, SwitchNumber: 1)
            
            addBlockO(xp: 11, yp: 2, Size: 5, type: 9,BloclNumber: 2)
            addmoveAction(xmove: 0, ymove: 15, time: 8.0, BlockNumber: 2, interval: 3.0, firstinterval: 1.0, type: 1, Actiontype: 3)
            ONOFFAction(BlockNumber: 2, SwitchNumber: 2)
            addSwitch(xp: 7.5, yp: 3.5, SwitchNumberA: 2,SwitchNumberB: 2)
            addSwitch(xp: 7.5, yp: 20.5, SwitchNumberA: 2,SwitchNumberB: 2)
            
            if      CFstatas[14] == 1 { addmoveStageO(xp: 60.5, yp: 3.5, Size: 2, moveStageN: 14, moveSceneN: 0, type: 3) }
            else if CFstatas[14] == 2 { addmoveStageO(xp: 60.5, yp: 3.5, Size: 2, moveStageN: 14, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 60.5, yp: 3.5, Size: 2, moveStageN: 14, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 0, yp: 27, xs: 18, ys: 5, type: 7)
            addBlock(xp: 14, yp: 11, xs: 4, ys: 16, type: 7)
            if      CFstatas[16] == 1 { addmoveStageO(xp: 0.5, yp: 32.5, Size: 2, moveStageN: 16, moveSceneN: 0, type: 4) }
            else if CFstatas[16] == 2 { addmoveStageO(xp: 0.5, yp: 32.5, Size: 2, moveStageN: 16, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 32.5, Size: 2, moveStageN: 16, moveSceneN: 0, type: 2) }
            
            addBlock(xp: 31, yp: 21, xs: 14, ys: 3, type: 7)
            addBlock(xp: 45, yp: 21, xs: 6, ys: 7, type: 7)
            addBlock(xp: 51, yp: 21, xs: 11, ys: 12, type: 7)
            addmoveStageO(xp: 60, yp: 34, Size: 3, moveStageN: -1, moveSceneN: -4, type: 23)
            addBlockO(xp: 38, yp: 27, Size: 5, type: 9)
            addBlockO(xp: 31, yp: 28.5, Size: 5, type: 9)
            addBlockO(xp: 23, yp: 30, Size: 5, type: 9)
            
            addBlock(xp: 56, yp: 9, xs: 6, ys: 7, type: 7)
            if      CFstatas[17] == 1{ addmoveStageO(xp: 60.5, yp: 16.5, Size: 2, moveStageN: 17, moveSceneN: 0, type: 3) }
            else if CFstatas[17] == 2{ addmoveStageO(xp: 60.5, yp: 16.5, Size: 2, moveStageN: 17, moveSceneN: 0, type: 103) }
            else                     { addmoveStageO(xp: 60.5, yp: 16.5, Size: 2, moveStageN: 17, moveSceneN: 0, type: 1) }
            addBar(xp: 44, yp: 6)
            addBar(xp: 50, yp: 12)
            addvector(xp: 46, yp: 9, Angle: 140, Size: 3)
            
            addBar(xp: 27, yp: 35)
            addBar(xp: 27, yp: 41)
            addBar(xp: 27, yp: 47)
            
            addBlock(xp: 0, yp: 42, xs: 18, ys: 8, type: 14)
            addBlock(xp: 18, yp: 38, xs: 6, ys: 12, type: 14)
            if      CFstatas[18] == 1 { addmoveStageO(xp: 0.5, yp: 50.5, Size: 2, moveStageN: 18, moveSceneN: 0, type: 4) }
            else if CFstatas[18] == 2 { addmoveStageO(xp: 0.5, yp: 50.5, Size: 2, moveStageN: 18, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 50.5, Size: 2, moveStageN: 18, moveSceneN: 0, type: 2) }
            
            addBlock(xp: 31, yp: 38, xs: 31, ys: 12, type: 14)
            if      CFstatas[19] == 1 { addmoveStageO(xp: 60.5, yp: 50.5, Size: 2, moveStageN: 19, moveSceneN: 0, type: 3) }
            else if CFstatas[19] == 2 { addmoveStageO(xp: 60.5, yp: 50.5, Size: 2, moveStageN: 19, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 60.5, yp: 50.5, Size: 2, moveStageN: 19, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 21, yp: 60, xs: 13, ys: 2, type: 14)
            
            if difficulty >= 1{
                if CFstatas[14] >= 2 && CFstatas[15] >= 2 && CFstatas[16] >= 2 && CFstatas[17] >= 2 && CFstatas[18] >= 2 && CFstatas[19] >= 2{
                    if      CFstatas[20] == 1 { addmoveStageO(xp: 27, yp: 63, Size: 3, moveStageN: 20, moveSceneN: 0, type: 12) }
                    else if CFstatas[20] == 2 { addmoveStageO(xp: 27, yp: 63, Size: 3, moveStageN: 20, moveSceneN: 0, type: 53) }
                    else                      { addmoveStageO(xp: 27, yp: 63, Size: 3, moveStageN: 20, moveSceneN: 0, type: 11) }
                }
            }else{
                if CFstatas[14] >= 1 && CFstatas[15] >= 1 && CFstatas[16] >= 1 && CFstatas[17] >= 1 && CFstatas[18] >= 1 && CFstatas[19] >= 1{
                    if      CFstatas[20] == 1 { addmoveStageO(xp: 27, yp: 63, Size: 3, moveStageN: 20, moveSceneN: 0, type: 12) }
                    else if CFstatas[20] == 2 { addmoveStageO(xp: 27, yp: 63, Size: 3, moveStageN: 20, moveSceneN: 0, type: 53) }
                    else                      { addmoveStageO(xp: 27, yp: 63, Size: 3, moveStageN: 20, moveSceneN: 0, type: 11) }
                }
            }

            addBar(xp: 18, yp: 53)
            addBar(xp: 36, yp: 53)
            addBar(xp: 18, yp: 59)
            addBar(xp: 36, yp: 59)
            
            addBar(xp: 41, yp: 62)
          
            addBlock(xp: 54, yp: 61, xs: 8, ys: 2, type: 9)
            if      CFstatas[101] == 1{ addmoveStageO(xp: 60.5, yp: 63.5, Size: 2, moveStageN: 101, moveSceneN: 0, type: 3) }
            else if CFstatas[101] == 2{ addmoveStageO(xp: 60.5, yp: 63.5, Size: 2, moveStageN: 101, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 60.5, yp: 63.5, Size: 2, moveStageN: 101, moveSceneN: 0, type: 1) }
        }
        //5¥第４エリア火山
        if stageNumber == -5{
            let StageS:[CGFloat] = [45,80]
            BackGroundImage(imageName: "bg4_1", FrameSize: StageS)
            addBoundaryBlock(Size: StageS)
            
            if sceneNumber == 21{
                addplayer(px: 40, py: 5, DFlag: false)
            }else if sceneNumber == 22{
                addplayer(px: 41, py: 26, DFlag: false)
            }else if sceneNumber == 23{
                addplayer(px: 4, py: 25)
            }else if sceneNumber == 24{
                addplayer(px: 40, py: 44, DFlag: false)
            }else if sceneNumber == 25{
                addplayer(px: 4, py: 51)
            }else if sceneNumber == 26{
                addplayer(px: 4, py: 66)
            }else if sceneNumber == 27{
                addplayer(px: 40, py: 75, DFlag: false)
            }else {
                addplayer(px: 5, py: 5)
            }
            
            addBlock(xp: 0, yp: 0, xs: 45, ys: 3, type: 8)
            addmoveStageO(xp: 1, yp: 4, Size: 3, moveStageN: -1, moveSceneN: -5, type: 24)
            if      CFstatas[21] == 1 { addmoveStageO(xp: 43.5, yp: 3.5, Size: 2, moveStageN: 21, moveSceneN: 0, type: 3) }
            else if CFstatas[21] == 2 { addmoveStageO(xp: 43.5, yp: 3.5, Size: 2, moveStageN: 21, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 43.5, yp: 3.5, Size: 2, moveStageN: 21, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 17, yp: 6, xs: 6, ys: 4, type: 8)
            addBar(xp: 25.5, yp: 15.5, type: 2, BloclNumber: 1)
            addrotateAction(dsita: 90, time: 5.0, BlockNumber: 1)
            
            addBlock(xp: 0, yp: 22, xs: 23, ys: 2, type: 8)
            if      CFstatas[23] == 1 { addmoveStageO(xp: 0.5, yp: 24.5, Size: 2, moveStageN: 23, moveSceneN: 0, type: 4) }
            else if CFstatas[23] == 2 { addmoveStageO(xp: 0.5, yp: 24.5, Size: 2, moveStageN: 23, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 24.5, Size: 2, moveStageN: 23, moveSceneN: 0, type: 2) }
            
            addBlock(xp: 29, yp: 22, xs: 16, ys: 2, type: 8)
            if      CFstatas[22] == 1 { addmoveStageO(xp: 43.5, yp: 24.5, Size: 2, moveStageN: 22, moveSceneN: 0, type: 3) }
            else if CFstatas[22] == 2 { addmoveStageO(xp: 43.5, yp: 24.5, Size: 2, moveStageN: 22, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 43.5, yp: 24.5, Size: 2, moveStageN: 22, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 5, yp: 27, xs: 4, ys: 3, type: 9)
            addBlock(xp: 9, yp: 27, xs: 4, ys: 2, type: 9)
            addBlock(xp: 12, yp: 32, xs: 9, ys: 4, type: 9)
            addBar(xp: 25, yp: 45.5, type: 3, BloclNumber: 2)
            addrotateAction(dsita: -90, time: 10.0, BlockNumber: 2, Actiontype: 2, SwitchNumber: 1)
            addrotateAction(dsita: 90, time: 10.0, BlockNumber: 2, Actiontype: 2, SwitchNumber: 2)
            addSwitch(xp: 16.5, yp: 36.5, SwitchNumberA: 1, SwitchNumberB: 2)
            
            addBlock(xp: 36, yp: 39, xs: 9, ys: 3, type: 9)
            if      CFstatas[24] == 1 { addmoveStageO(xp: 43.5, yp: 42.5, Size: 2, moveStageN: 24, moveSceneN: 0, type: 3) }
            else if CFstatas[24] == 2 { addmoveStageO(xp: 43.5, yp: 42.5, Size: 2, moveStageN: 24, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 43.5, yp: 42.5, Size: 2, moveStageN: 24, moveSceneN: 0, type: 1) }
            
            addBlock(xp: 0, yp: 46, xs: 14, ys: 3, type: 9)
            if      CFstatas[25] == 1 { addmoveStageO(xp: 0.5, yp: 49.5, Size: 2, moveStageN: 25, moveSceneN: 0, type: 4) }
            else if CFstatas[25] == 2 { addmoveStageO(xp: 0.5, yp: 49.5, Size: 2, moveStageN: 25, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 49.5, Size: 2, moveStageN: 25, moveSceneN: 0, type: 2) }
           
            addBlock(xp: 0, yp: 61, xs: 19, ys: 3, type: 9)
            addBlock(xp: 19, yp: 57, xs: 4, ys: 7, type: 9)
            addBlock(xp: 28, yp: 57, xs: 17, ys: 16, type: 9)
            addBar(xp: 25, yp: 60)
            addBar(xp: 25, yp: 67)
            if      CFstatas[26] == 1 { addmoveStageO(xp: 0.5, yp: 64.5, Size: 2, moveStageN: 26, moveSceneN: 0, type: 4) }
            else if CFstatas[26] == 2 { addmoveStageO(xp: 0.5, yp: 64.5, Size: 2, moveStageN: 26, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 64.5, Size: 2, moveStageN: 26, moveSceneN: 0, type: 2) }
            
            if difficulty >= 1{
                if CFstatas[21] >= 2 && CFstatas[22] >= 2 && CFstatas[23] >= 2 && CFstatas[24] >= 2 && CFstatas[25] >= 2 && CFstatas[26] >= 2{
                    if      CFstatas[27] == 1 { addmoveStageO(xp: 43.5, yp: 74, Size: 3, moveStageN: 27, moveSceneN: 0, type: 14) }
                    else if CFstatas[27] == 2 { addmoveStageO(xp: 43.5, yp: 74, Size: 3, moveStageN: 27, moveSceneN: 0, type: 54) }
                    else                      { addmoveStageO(xp: 43.5, yp: 74, Size: 3, moveStageN: 27, moveSceneN: 0, type: 13) }
                }
            }else{
                if CFstatas[21] >= 1 && CFstatas[22] >= 1 && CFstatas[23] >= 1 && CFstatas[24] >= 1 && CFstatas[25] >= 1 && CFstatas[26] >= 1{
                    if      CFstatas[27] == 1 { addmoveStageO(xp: 43.5, yp: 74, Size: 3, moveStageN: 27, moveSceneN: 0, type: 14) }
                    else if CFstatas[27] == 2 { addmoveStageO(xp: 43.5, yp: 74, Size: 3, moveStageN: 27, moveSceneN: 0, type: 54) }
                    else                      { addmoveStageO(xp: 43.5, yp: 74, Size: 3, moveStageN: 27, moveSceneN: 0, type: 13) }
                }
            }
        }
        //5¥第５エリア雪山
        if stageNumber == -6{
            let StageS:[CGFloat] = [60,85]
            BackGroundImage(imageName: "bg5_1", FrameSize: StageS)
            addBoundaryBlock(Size: StageS)
            
            if sceneNumber == 28{
                addplayer(px: 4, py: 5)
            }else if sceneNumber == 29{
                addplayer(px: 4, py: 16)
            }else if sceneNumber == 30{
                addplayer(px: 54, py: 29,DFlag: false)
            }else if sceneNumber == 31{
                addplayer(px: 4, py: 42)
            }else if sceneNumber == 32{
                addplayer(px: 55, py: 46,DFlag: false)
            }else if sceneNumber == 33{
                addplayer(px: 55, py: 61,DFlag: false)
            }else if sceneNumber == 34{
                addplayer(px: 8, py: 80)
            }else if sceneNumber == 102{
                addplayer(px: 5, py: 56)
            }else {
                addplayer(px: 50, py: 5,DFlag: false)
            }
            
            addBlock(xp: 0, yp: 0, xs: 70, ys: 3, type: 18)
            addmoveStageO(xp: 56.5, yp: 5.5, Size: 6, moveStageN: -1, moveSceneN: -6, type: 27)
            
            addiceBlock(xp: 39, yp: 4.5, xs: 11, ys: 4, Shapetype: 3, type: 1)
            addiceBlock(xp: 29.5, yp: 4.5, xs: 8, ys: 4, Shapetype: 4, type: 1)
            addiceBlock(xp: 29.5, yp: 7.5, xs: 8, ys: 2, Shapetype: 1, type: 1)
            addiceBlock(xp: 21.5, yp: 4.5, xs: 8, ys: 4, Shapetype: 4, type: 1)
            addiceBlock(xp: 13, yp: 4.5, xs: 9, ys: 4, Shapetype: 2, type: 1)
            
            addBar(xp: 19, yp: 10)
            
            addiceBlock(xp: 8, yp: 12, xs: 17, ys: 3, Shapetype: 4, type: 1)
            addBlock(xp: 8, yp: 17, xs: 4, ys: 3, type: 18)
            addBlock(xp: 12, yp: 18, xs: 4, ys: 7, type: 18)
            addBlock(xp: 16, yp: 23, xs: 4, ys: 7, type: 18)
            
            addBar(xp: 25, yp: 35)
            addBar(xp: 25, yp: 41)
            
            addiceBlock(xp: 10.5, yp: 36.5, xs: 22, ys: 4, Shapetype: 4, type: 1)
            addiceBlock(xp: 4.5, yp: 39.5, xs: 10, ys: 2, Shapetype: 4, type: 1)
            addiceBlock(xp: 15.5, yp: 39.5, xs: 12, ys: 2, Shapetype: 3, type: 1)
            
            addiceBlock(xp: 29.5, yp: 30.5, xs: 14, ys: 2, Shapetype: 4, type: 1)
            addiceBlock(xp: 32, yp: 36, xs: 9, ys: 9, Shapetype: 4, type: 1)
            addiceBlock(xp: 43, yp: 35, xs: 13, ys: 11, Shapetype: 3, type: 1)
            
            addiceBlock(xp: 54, yp: 20, xs: 11, ys: 13, Shapetype: 4, type: 1)
            addiceBlock(xp: 39, yp: 20, xs: 19, ys: 13, Shapetype: 2, type: 1)
            
            addBlock(xp: 31, yp: 44, xs: 5, ys: 5, type: 18)
            addBlock(xp: 36, yp: 52, xs: 5, ys: 5, type: 18)
            addBlock(xp: 45, yp: 42, xs: 15, ys: 2, type: 18)
            addBlock(xp: 55, yp: 57, xs: 5, ys: 2, type: 18)
            addiceBlock(xp: 45, yp: 46, xs: 19, ys: 5, Shapetype: 3, type: 1)
            addiceBlock(xp: 47.5, yp: 54, xs: 14, ys: 5, Shapetype: 4, type: 1)
            addiceBlock(xp: 47.5, yp: 57.5, xs: 14, ys: 2, Shapetype: 2, type: 1)
            addiceBlock(xp: 9, yp: 53, xs: 19, ys: 3, Shapetype: 4, type: 1)
            
            addiceBlock(xp: 9.5, yp: 69.5, xs: 20, ys: 16, Shapetype: 4, type: 1)
            addiceBlock(xp: 27.5, yp: 71, xs: 16, ys: 13, Shapetype: 3, type: 1)
            
            addiceBlock(xp: 38.5, yp: 63, xs: 14, ys: 3, Shapetype: 4, type: 1)
            addBar(xp: 48, yp: 61)
            
            addiceBlock(xp: 32, yp: 64, xs: 5, ys: 2, Shapetype: 1, type: 1,Angle: 135)
            addiceBlock(xp: 39.5, yp: 54, xs: 5, ys: 2, Shapetype: 1, type: 1,Angle: 90)
            addiceBlock(xp: 34, yp: 46, xs: 5, ys: 2, Shapetype: 1, type: 1,Angle: 45)
            addiceBlock(xp: 9, yp: 39, xs: 5, ys: 2, Shapetype: 1, type: 1,Angle: 0)
            
            addBar(xp: 26, yp: 78)
            addBar(xp: 31, yp: 73)
            addBar(xp: 36, yp: 69)
            
            if      CFstatas[28] == 1 { addmoveStageO(xp: 0.5, yp: 3.5, Size: 2, moveStageN: 28, moveSceneN: 0, type: 4) }
            else if CFstatas[28] == 2 { addmoveStageO(xp: 0.5, yp: 3.5, Size: 2, moveStageN: 28, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 3.5, Size: 2, moveStageN: 28, moveSceneN: 0, type: 2) }
            
            if      CFstatas[29] == 1 { addmoveStageO(xp: 0.5, yp: 14.5, Size: 2, moveStageN: 29, moveSceneN: 0, type: 4) }
            else if CFstatas[29] == 2 { addmoveStageO(xp: 0.5, yp: 14.5, Size: 2, moveStageN: 29, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 14.5, Size: 2, moveStageN: 29, moveSceneN: 0, type: 2) }
            
            if      CFstatas[30] == 1 { addmoveStageO(xp: 58.5, yp: 27.5, Size: 2, moveStageN: 30, moveSceneN: 0, type: 3) }
            else if CFstatas[30] == 2 { addmoveStageO(xp: 58.5, yp: 27.5, Size: 2, moveStageN: 30, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 58.5, yp: 27.5, Size: 2, moveStageN: 30, moveSceneN: 0, type: 1) }
            
            if      CFstatas[31] == 1 { addmoveStageO(xp: 0.5, yp: 41.5, Size: 2, moveStageN: 31, moveSceneN: 0, type: 4) }
            else if CFstatas[31] == 2 { addmoveStageO(xp: 0.5, yp: 41.5, Size: 2, moveStageN: 31, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 41.5, Size: 2, moveStageN: 31, moveSceneN: 0, type: 2) }
            
            if      CFstatas[32] == 1 { addmoveStageO(xp: 58.5, yp: 44.5, Size: 2, moveStageN: 32, moveSceneN: 0, type: 3) }
            else if CFstatas[32] == 2 { addmoveStageO(xp: 58.5, yp: 44.5, Size: 2, moveStageN: 32, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 58.5, yp: 44.5, Size: 2, moveStageN: 32, moveSceneN: 0, type: 1) }
            
            if      CFstatas[33] == 1 { addmoveStageO(xp: 58.5, yp: 59.5, Size: 2, moveStageN: 33, moveSceneN: 0, type: 3) }
            else if CFstatas[33] == 2 { addmoveStageO(xp: 58.5, yp: 59.5, Size: 2, moveStageN: 33, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 58.5, yp: 59.5, Size: 2, moveStageN: 33, moveSceneN: 0, type: 1) }
            
            if difficulty >= 1{
                if CFstatas[28] >= 2 && CFstatas[29] >= 2 && CFstatas[30] >= 2 && CFstatas[31] >= 2 && CFstatas[32] >= 2 && CFstatas[33] >= 2{
                    if      CFstatas[34] == 1 { addmoveStageO(xp: 3.5, yp: 79, Size: 3, moveStageN: 34, moveSceneN: 0, type: 16) }
                    else if CFstatas[34] == 2 { addmoveStageO(xp: 3.5, yp: 79, Size: 3, moveStageN: 34, moveSceneN: 0, type: 55) }
                    else                      { addmoveStageO(xp: 3.5, yp: 79, Size: 3, moveStageN: 34, moveSceneN: 0, type: 15) }
                }
            }else{
                if CFstatas[28] >= 1 && CFstatas[29] >= 1 && CFstatas[30] >= 1 && CFstatas[31] >= 1 && CFstatas[32] >= 1 && CFstatas[33] >= 1{
                    if      CFstatas[34] == 1 { addmoveStageO(xp: 3.5, yp: 79, Size: 3, moveStageN: 34, moveSceneN: 0, type: 16) }
                    else if CFstatas[34] == 2 { addmoveStageO(xp: 3.5, yp: 79, Size: 3, moveStageN: 34, moveSceneN: 0, type: 55) }
                    else                      { addmoveStageO(xp: 3.5, yp: 79, Size: 3, moveStageN: 34, moveSceneN: 0, type: 15) }
                }
            }
            
            if CFstatas[102] == 1      { addmoveStageO(xp: 0.5, yp: 55.5, Size: 2, moveStageN: 102, moveSceneN: 0, type: 4) }
            else if CFstatas[102] == 2 { addmoveStageO(xp: 0.5, yp: 55.5, Size: 2, moveStageN: 102, moveSceneN: 0, type: 104) }
            else                       { addmoveStageO(xp: 0.5, yp: 55.5, Size: 2, moveStageN: 102, moveSceneN: 0, type: 102) }
            
        }
        //5¥第６エリア天空
        if stageNumber == -7{
            //ステージ背景と外枠
            let StageS:[CGFloat] = [40,72]
            BackGroundImage(imageName: "bg6_1", FrameSize: StageS)
            addBoundaryBlock(Size: StageS)
            
            //プレイヤー開始地点
            if sceneNumber == 35{
                addplayer(px: 34, py: 4,DFlag: false)
            }else if sceneNumber == 36{
                addplayer(px: 35, py: 19,DFlag: false)
            }else if sceneNumber == 37{
                addplayer(px: 4, py: 28)
            }else if sceneNumber == 38{
                addplayer(px: 35, py: 33,DFlag: false)
            }else if sceneNumber == 39{
                addplayer(px: 5, py: 47)
            }else if sceneNumber == 40{
                addplayer(px: 34, py: 53,DFlag: false)
            }else if sceneNumber == 41{
                addplayer(px: 22, py:66)
            }else if sceneNumber == 103{
                addplayer(px: 3.5, py: 40)
            }else {
                addplayer(px: 7, py: 4)
            }
            
            //雲エリアの出口
            addmoveStageO(xp: 0, yp: 5, Size: 7, moveStageN: -1, moveSceneN: -7, type: 30)
            
            //ステージ入口
            //１ステージ
            if      CFstatas[35] == 1 { addmoveStageO(xp: 38.5, yp: 3.5, Size: 2, moveStageN: 35, moveSceneN: 0, type: 3) }
            else if CFstatas[35] == 2 { addmoveStageO(xp: 38.5, yp: 3.5, Size: 2, moveStageN: 35, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 38.5, yp: 3.5, Size: 2, moveStageN: 35, moveSceneN: 0, type: 1) }
            //２ステージ
            if      CFstatas[36] == 1 { addmoveStageO(xp: 38.5, yp: 18.5, Size: 2, moveStageN: 36, moveSceneN: 0, type: 3) }
            else if CFstatas[36] == 2 { addmoveStageO(xp: 38.5, yp: 18.5, Size: 2, moveStageN: 36, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 38.5, yp: 18.5, Size: 2, moveStageN: 36, moveSceneN: 0, type: 1) }
            //３ステージ
            if      CFstatas[37] == 1 { addmoveStageO(xp: 0.5, yp: 27.5, Size: 2, moveStageN: 37, moveSceneN: 0, type: 4) }
            else if CFstatas[37] == 2 { addmoveStageO(xp: 0.5, yp: 27.5, Size: 2, moveStageN: 37, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 27.5, Size: 2, moveStageN: 37, moveSceneN: 0, type: 2) }
            //４ステージ
            if      CFstatas[38] == 1 { addmoveStageO(xp: 38.5, yp: 32.5, Size: 2, moveStageN: 38, moveSceneN: 0, type: 3) }
            else if CFstatas[38] == 2 { addmoveStageO(xp: 38.5, yp: 32.5, Size: 2, moveStageN: 38, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 38.5, yp: 32.5, Size: 2, moveStageN: 38, moveSceneN: 0, type: 1) }
            //５ステージ
            if      CFstatas[39] == 1 { addmoveStageO(xp: 0.5, yp: 46.5, Size: 2, moveStageN: 39, moveSceneN: 0, type: 4) }
            else if CFstatas[39] == 2 { addmoveStageO(xp: 0.5, yp: 46.5, Size: 2, moveStageN: 39, moveSceneN: 0, type: 104) }
            else                      { addmoveStageO(xp: 0.5, yp: 46.5, Size: 2, moveStageN: 39, moveSceneN: 0, type: 2) }
            //６ステージ
            if      CFstatas[40] == 1 { addmoveStageO(xp: 38.5, yp: 52.5, Size: 2, moveStageN: 40, moveSceneN: 0, type: 3) }
            else if CFstatas[40] == 2 { addmoveStageO(xp: 38.5, yp: 52.5, Size: 2, moveStageN: 40, moveSceneN: 0, type: 103) }
            else                      { addmoveStageO(xp: 38.5, yp: 52.5, Size: 2, moveStageN: 40, moveSceneN: 0, type: 1) }
            //ボスステージ
            if difficulty >= 1{
                if CFstatas[35] >= 2 && CFstatas[36] >= 2 && CFstatas[37] >= 2 && CFstatas[38] >= 2 && CFstatas[39] >= 2 && CFstatas[40] >= 2{
                    if      CFstatas[41] == 1 { addmoveStageO(xp: 18.5, yp: 66, Size: 3, moveStageN: 41, moveSceneN: 0, type: 18) }
                    else if CFstatas[41] == 2 { addmoveStageO(xp: 18.5, yp: 66, Size: 3, moveStageN: 41, moveSceneN: 0, type: 56) }
                    else                      { addmoveStageO(xp: 18.5, yp: 66, Size: 3, moveStageN: 41, moveSceneN: 0, type: 17) }
                }
            }else{
                if CFstatas[35] >= 1 && CFstatas[36] >= 1 && CFstatas[37] >= 1 && CFstatas[38] >= 1 && CFstatas[39] >= 1 && CFstatas[40] >= 1{
                    if      CFstatas[41] == 1 { addmoveStageO(xp: 18.5, yp: 66, Size: 3, moveStageN: 41, moveSceneN: 0, type: 18) }
                    else if CFstatas[41] == 2 { addmoveStageO(xp: 18.5, yp: 66, Size: 3, moveStageN: 41, moveSceneN: 0, type: 56) }
                    else                      { addmoveStageO(xp: 18.5, yp: 66, Size: 3, moveStageN: 41, moveSceneN: 0, type: 17) }
                }
            }
            //隠しステージ
            if CFstatas[103] == 1      { addmoveStageO(xp: 0.5, yp: 39.5, Size: 2, moveStageN: 103, moveSceneN: 0, type: 4) }
            else if CFstatas[103] == 2 { addmoveStageO(xp: 0.5, yp: 39.5, Size: 2, moveStageN: 103, moveSceneN: 0, type: 104) }
            else                       { addmoveStageO(xp: 0.5, yp: 39.5, Size: 2, moveStageN: 103, moveSceneN: 0, type: 102) }
            
            //雲ブロック
            addBlock(xp: 0, yp: 0, xs: 40, ys: 3, type: 13)
            
            //雲(剛体)
            addcloud(xp: 9, yp: 9, xs: 6, ys: 4, type1: 1, type2: 1)
            addcloud(xp: 16, yp: 6, xs: 6, ys: 4, type1: 1, type2: 1)
            addcloud(xp: 22, yp: 11, xs: 6, ys: 4, type1: 1, type2: 1)
            addcloud(xp: 28, yp: 12, xs: 8, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 33, yp: 14, xs: 8, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 36.5, yp: 16, xs: 8, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 8.5, yp: 19, xs: 8, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 2, yp: 25, xs: 10, ys: 4, type1: 1, type2: 1)
            addcloud(xp: 36, yp: 30, xs: 9, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 2, yp: 37, xs: 7, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 7.5, yp: 44, xs: 20, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 34.5, yp: 50, xs: 11, ys: 5, type1: 1, type2: 1)
            addcloud(xp: 19.5, yp: 63, xs: 12, ys: 5, type1: 1, type2: 1)
            
            //雲(弾性弱)黄色
            addcloud(xp: 20.5, yp: 33, xs: 4, ys: 3, type1: 2, type2: 1)
            addcloud(xp: 24, yp: 39, xs: 4, ys: 3, type1: 2, type2: 1)
            addcloud(xp: 27, yp: 43, xs: 4, ys: 3, type1: 2, type2: 1)
            addcloud(xp: 30, yp: 30, xs: 4, ys: 3, type1: 2, type2: 1)
            addcloud(xp: 32, yp: 37, xs: 4, ys: 3, type1: 2, type2: 1)
            addcloud(xp: 37.5, yp: 41, xs: 4, ys: 3, type1: 2, type2: 1)
            
            //雲(弾性中)緑色
            addcloud(xp: 2, yp: 11, xs: 6, ys: 4, type1: 2, type2: 2)
            addcloud(xp: 22, yp: 47, xs: 4, ys: 3, type1: 2, type2: 2)
            addcloud(xp: 27, yp: 58, xs: 6, ys: 3, type1: 2, type2: 2)
            
            //雲(弾性大)赤色
            addcloud(xp: 25, yp: 20, xs: 7, ys: 5, type1: 2, type2: 3)
            addcloud(xp: 10, yp: 52, xs: 7, ys: 4, type1: 2, type2: 3)
            
            //テイルバー
            addBar(xp: 15, yp: 13)
            addBar(xp: 32, yp: 20)
            addBar(xp: 32, yp: 24)
            addBar(xp: 26, yp: 34)
            addBar(xp: 5, yp: 50)
            addBar(xp: 19, yp: 57)
            addBar(xp: 32, yp: 56)
            addBar(xp: 18, yp: 22)
            addBar(xp: 18, yp: 25)
            addBar(xp: 18, yp: 28)
            addBar(xp: 21, yp: 25)
            addBar(xp: 21, yp: 28)
            addBar(xp: 24, yp: 28)
            addBar(xp: 33, yp: 43)
            addBar(xp: 22, yp: 53)
        }
        //5¥第７エリア研究施設
        if stageNumber == -8{
            
        }
        //5¥第８エリア魔王城
        if stageNumber == -9{
            
        }
        //5¥第９エリア月
        if stageNumber == -10{
            
        }
        //5¥練習ステージ
        if stageNumber == -12{
            let StageS:[CGFloat] = [73,43]
            BackGroundImage(imageName: "bg11_1", FrameSize: StageS)
            addBoundaryBlock(Size: StageS)
            
            SkillChange(SkillNumber: [0])
            if      sceneNumber == 70   { addplayer(px: 55, py: 4,DFlag: false) }
            else if sceneNumber == 71   { addplayer(px: 61, py: 4,DFlag: false) }
            else if sceneNumber == 72   { addplayer(px: 67, py: 4,DFlag: false) }
            else if sceneNumber == 73   { addplayer(px: 56, py: 12) }
            else if sceneNumber == 74   { addplayer(px: 50, py: 12) }
            else if sceneNumber == 75   { addplayer(px: 44, py: 12) }
            else if sceneNumber == 76   { addplayer(px: 55, py: 18,DFlag: false) }
            else if sceneNumber == 77   { addplayer(px: 61, py: 18,DFlag: false) }
            else if sceneNumber == 78   { addplayer(px: 67, py: 18,DFlag: false) }
            else if sceneNumber == 79   { addplayer(px: 56, py: 25) }
            else if sceneNumber == 80   { addplayer(px: 50, py: 25) }
            else if sceneNumber == 81   { addplayer(px: 44, py: 25) }
            else if sceneNumber == 82   { addplayer(px: 55, py: 32,DFlag: false) }
            else if sceneNumber == 83   { addplayer(px: 61, py: 32,DFlag: false) }
            else if sceneNumber == 84   { addplayer(px: 67, py: 32,DFlag: false) }
            else if sceneNumber == 85   { addplayer(px: 56, py: 39) }
            else if sceneNumber == 86   { addplayer(px: 50, py: 39) }
            else if sceneNumber == 87   { addplayer(px: 44, py: 39) }
            else if sceneNumber == 88   { addplayer(px: 17, py: 39) }
            else if sceneNumber == 89   { addplayer(px: 11, py: 39) }
            else if sceneNumber == 90   { addplayer(px: 5, py: 39) }
            else                        { addplayer(px: 26, py: 30) }
            addmoveStageO(xp: 24, yp: 32, Size: 3, moveStageN: -1, moveSceneN: -12, type: 28)
            
            addBlock(xp: 0, yp: 0, xs: 34, ys: 2, type: 19)
            addBlock(xp: 0, yp: 9, xs: 34, ys: 2, type: 19)
            addBlock(xp: 0, yp: 18, xs: 34, ys: 2, type: 19)
            addBlock(xp: 0, yp: 27, xs: 39, ys: 2, type: 19)
            addBlock(xp: 0, yp: 36, xs: 39, ys: 2, type: 19)
            addBlock(xp: 21, yp: 29, xs: 2, ys: 7, type: 19)
            addBlock(xp: 37, yp: 29, xs: 2, ys: 7, type: 19)
            addBlock(xp: 34, yp: 0, xs: 5, ys: 29, type: 19)
            addBlock(xp: 34, yp: 36, xs: 5, ys: 7, type: 19)
            addBlock(xp: 39, yp: 0, xs: 34, ys: 3, type: 19)
            addBlock(xp: 39, yp: 8, xs: 34, ys: 2, type: 19)
            addBlock(xp: 39, yp: 15, xs: 34, ys: 2, type: 19)
            addBlock(xp: 39, yp: 22, xs: 34, ys: 2, type: 19)
            addBlock(xp: 39, yp: 29, xs: 34, ys: 2, type: 19)
            addBlock(xp: 39, yp: 36, xs: 34, ys: 2, type: 19)
            addwarp(xp: 13, yp: 4.5, movepx: 19, movepy: 13.5)
            addwarp(xp: 13, yp: 13.5, movepx: 19, movepy: 22.5)
            addwarp(xp: 13, yp: 22.5, movepx: 19, movepy: 31.5)
            addwarp(xp: 32, yp: 4.5, movepx: 40, movepy: 5.5)
            addwarp(xp: 1, yp: 4.5, movepx: 71, movepy: 12.5)
            addwarp(xp: 32, yp: 13.5, movepx: 40, movepy: 19.5)
            addwarp(xp: 1, yp: 13.5, movepx: 71, movepy: 26.5)
            addwarp(xp: 32, yp: 22.5, movepx: 40, movepy: 33.5)
            addwarp(xp: 1, yp: 22.5, movepx: 71, movepy: 40.5)
            addwarp(xp: 1, yp: 31.5, movepx: 32, movepy: 40.5)
            addwarp(xp: 19, yp: 4.5, movepx: 35.5, movepy: 32.5)
            
            addTV(xp: 30.5, yp: 31.5, Size: 4, number: 1)
  
            addBoard(xp: 26.5, yp: 4.5, Size: 8, Number: 2)
            addBoard(xp: 6.5, yp: 4.5, Size: 8, Number: 3)
            addBoard(xp: 26.5, yp: 13.5, Size: 8, Number: 4)
            addBoard(xp: 6.5, yp: 13.5, Size: 8, Number: 5)
            addBoard(xp: 26.5, yp: 22.5, Size: 8, Number: 6)
            addBoard(xp: 6.5, yp: 22.5, Size: 8, Number: 7)
            addBoard(xp: 6.5, yp: 31.5, Size: 8, Number: 8)
            addBoard(xp: 47.5, yp: 5.5, Size: 8, Number: 2)
            addBoard(xp: 63.5, yp: 12.5, Size: 8, Number: 3)
            addBoard(xp: 47.5, yp: 19.5, Size: 8, Number: 4)
            addBoard(xp: 63.5, yp: 26.5, Size: 8, Number: 5)
            addBoard(xp: 47.5, yp: 33.5, Size: 8, Number: 6)
            addBoard(xp: 63.5, yp: 40.5, Size: 8, Number: 7)
            addBoard(xp: 24.5, yp: 40.5, Size: 8, Number: 8)
            addBoard(xp: 16, yp: 5, Size: 3, Number: 12)
            addBoard(xp: 16, yp: 14, Size: 3, Number: 13)
            addBoard(xp: 16, yp: 23, Size: 3, Number: 14)
            addBoard(xp: 16, yp: 32, Size: 3, Number: 15)
            
            addBoard(xp: 55, yp: 5, Size: 3, Number: 9)
            addBoard(xp: 61, yp: 5, Size: 3, Number: 10)
            addBoard(xp: 67, yp: 5, Size: 3, Number: 11)
            addBoard(xp: 56, yp: 12, Size: 3, Number: 9)
            addBoard(xp: 50, yp: 12, Size: 3, Number: 10)
            addBoard(xp: 44, yp: 12, Size: 3, Number: 11)
            addBoard(xp: 55, yp: 19, Size: 3, Number: 9)
            addBoard(xp: 61, yp: 19, Size: 3, Number: 10)
            addBoard(xp: 67, yp: 19, Size: 3, Number: 11)
            addBoard(xp: 56, yp: 26, Size: 3, Number: 9)
            addBoard(xp: 50, yp: 26, Size: 3, Number: 10)
            addBoard(xp: 44, yp: 26, Size: 3, Number: 11)
            addBoard(xp: 55, yp: 33, Size: 3, Number: 9)
            addBoard(xp: 61, yp: 33, Size: 3, Number: 10)
            addBoard(xp: 67, yp: 33, Size: 3, Number: 11)
            addBoard(xp: 56, yp: 40, Size: 3, Number: 9)
            addBoard(xp: 50, yp: 40, Size: 3, Number: 10)
            addBoard(xp: 44, yp: 40, Size: 3, Number: 11)
            addBoard(xp: 17, yp: 40, Size: 3, Number: 9)
            addBoard(xp: 11, yp: 40, Size: 3, Number: 10)
            addBoard(xp: 5, yp: 40, Size: 3, Number: 11)
            
            if CFstatas[70] == 0{ addmoveStageO(xp: 57.5, yp: 5.5, Size: 2, moveStageN: 70, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 57.5, yp: 5.5, Size: 2, moveStageN: 70, moveSceneN: 0, type: 29) }
            if CFstatas[71] == 0{ addmoveStageO(xp: 63.5, yp: 5.5, Size: 2, moveStageN: 71, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 63.5, yp: 5.5, Size: 2, moveStageN: 71, moveSceneN: 0, type: 29) }
            if CFstatas[72] == 0{ addmoveStageO(xp: 69.5, yp: 5.5, Size: 2, moveStageN: 72, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 69.5, yp: 5.5, Size: 2, moveStageN: 72, moveSceneN: 0, type: 29) }
            
            if CFstatas[73] == 0{ addmoveStageO(xp: 53.5, yp: 12.5, Size: 2, moveStageN: 73, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 53.5, yp: 12.5, Size: 2, moveStageN: 73, moveSceneN: 0, type: 29) }
            if CFstatas[74] == 0{ addmoveStageO(xp: 47.5, yp: 12.5, Size: 2, moveStageN: 74, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 47.5, yp: 12.5, Size: 2, moveStageN: 74, moveSceneN: 0, type: 29) }
            if CFstatas[75] == 0{ addmoveStageO(xp: 41.5, yp: 12.5, Size: 2, moveStageN: 75, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 41.5, yp: 12.5, Size: 2, moveStageN: 75, moveSceneN: 0, type: 29) }
            
            if CFstatas[76] == 0{ addmoveStageO(xp: 57.5, yp: 19.5, Size: 2, moveStageN: 76, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 57.5, yp: 19.5, Size: 2, moveStageN: 76, moveSceneN: 0, type: 29) }
            if CFstatas[77] == 0{ addmoveStageO(xp: 63.5, yp: 19.5, Size: 2, moveStageN: 77, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 63.5, yp: 19.5, Size: 2, moveStageN: 77, moveSceneN: 0, type: 29) }
            if CFstatas[78] == 0{ addmoveStageO(xp: 69.5, yp: 19.5, Size: 2, moveStageN: 78, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 69.5, yp: 19.5, Size: 2, moveStageN: 78, moveSceneN: 0, type: 29) }
            
            if CFstatas[79] == 0{ addmoveStageO(xp: 53.5, yp: 26.5, Size: 2, moveStageN: 79, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 53.5, yp: 26.5, Size: 2, moveStageN: 79, moveSceneN: 0, type: 29) }
            if CFstatas[80] == 0{ addmoveStageO(xp: 47.5, yp: 26.5, Size: 2, moveStageN: 80, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 47.5, yp: 26.5, Size: 2, moveStageN: 80, moveSceneN: 0, type: 29) }
            if CFstatas[81] == 0{ addmoveStageO(xp: 41.5, yp: 26.5, Size: 2, moveStageN: 81, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 41.5, yp: 26.5, Size: 2, moveStageN: 81, moveSceneN: 0, type: 29) }
            
            if CFstatas[82] == 0{ addmoveStageO(xp: 57.5, yp: 33.5, Size: 2, moveStageN: 82, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 57.5, yp: 33.5, Size: 2, moveStageN: 82, moveSceneN: 0, type: 29) }
            if CFstatas[83] == 0{ addmoveStageO(xp: 63.5, yp: 33.5, Size: 2, moveStageN: 83, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 63.5, yp: 33.5, Size: 2, moveStageN: 83, moveSceneN: 0, type: 29) }
            if CFstatas[84] == 0{ addmoveStageO(xp: 69.5, yp: 33.5, Size: 2, moveStageN: 84, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 69.5, yp: 33.5, Size: 2, moveStageN: 84, moveSceneN: 0, type: 29) }
            
            if CFstatas[85] == 0{ addmoveStageO(xp: 53.5, yp: 40.5, Size: 2, moveStageN: 85, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 53.5, yp: 40.5, Size: 2, moveStageN: 85, moveSceneN: 0, type: 29) }
            if CFstatas[86] == 0{ addmoveStageO(xp: 47.5, yp: 40.5, Size: 2, moveStageN: 86, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 47.5, yp: 40.5, Size: 2, moveStageN: 86, moveSceneN: 0, type: 29) }
            if CFstatas[87] == 0{ addmoveStageO(xp: 41.5, yp: 40.5, Size: 2, moveStageN: 87, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 41.5, yp: 40.5, Size: 2, moveStageN: 87, moveSceneN: 0, type: 29) }
            
            if CFstatas[88] == 0{ addmoveStageO(xp: 14.5, yp: 40.5, Size: 2, moveStageN: 88, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 14.5, yp: 40.5, Size: 2, moveStageN: 88, moveSceneN: 0, type: 29) }
            if CFstatas[89] == 0{ addmoveStageO(xp: 8.5, yp: 40.5, Size: 2, moveStageN: 89, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 8.5, yp: 40.5, Size: 2, moveStageN: 89, moveSceneN: 0, type: 29) }
            if CFstatas[90] == 0{ addmoveStageO(xp: 2.5, yp: 40.5, Size: 2, moveStageN: 90, moveSceneN: 0, type: 28) }
            else                { addmoveStageO(xp: 2.5, yp: 40.5, Size: 2, moveStageN: 90, moveSceneN: 0, type: 29) }
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





