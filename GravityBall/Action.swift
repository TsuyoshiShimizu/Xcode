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
    func addrepositionAction(distance:CGFloat , n:Int){
        let repA = Action[na[n] - 1]
        repcount = repcount + 1
        repAction.append(repA)
        repx[repcount] = repA.position.x
        repy[repcount] = repA.position.y
        dis[repcount] = distance
    }
  /*
    func addappearanceAction(distance:CGFloat ,disapper:Bool, n:Int){
        let appearA = Action[na[n] - 1]
        let appearB = Action[na[n] - 1]
        appearancecount += 1
        appearanceActuon.append(appearB)
        appeax[appearancecount] = appearB.position.x
        appeay[appearancecount] = appearB.position.y
        appeardis[appearancecount] = distance
        appearanceflag[appearancecount] = disapper
    }
 */
    func addcahinjoint(chainpx: CGFloat,chainpy: CGFloat,jointpx:CGFloat,jointpy:CGFloat,chainn: Int,objectn:Int){
        let chainobject = Action[na[chainn] - 1]
        let object = Action[na[objectn] - 1]
        chainobject.position = CGPoint(x: w / 20  + w / 10 * chainpx, y: w / 20 + w / 10 * chainpy)
        let jpx = w / 20  + w / 10 * jointpx
        let jpy = w / 20  + w / 10 * jointpy
//        let mAction = SKAction.move(to: CGPoint(x: w / 20  + w / 10 * chainpx, y: w / 20 + w / 10 * chainpy), duration: 1.0)
 //       let mAction = SKAction.moveBy(x: w / 20  + w / 10 * chainpx, y: w / 20 + w / 10 * chainpy, duration: 0.1)
//        chainobject.run(mAction)
  //      DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            let jointA = SKPhysicsJointPin.joint(withBodyA: chainobject.physicsBody!, bodyB: object.physicsBody!, anchor: CGPoint(x: (jpx + chainobject.position.x) / 2, y: (jpy + chainobject.position.y) / 2))
            self.physicsWorld.add(jointA)
   //     }
    }
    
    func addjointPoint(jointxp:CGFloat ,jointyp:CGFloat ,n:Int ){
        let object = Action[na[n] - 1]
        let f = SKShapeNode(circleOfRadius: 1)
        f.alpha = 0
        f.position = CGPoint(x: w / 10 * jointxp + w / 20, y:  w / 10 * jointyp + w / 20 )
        f.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        f.physicsBody?.isDynamic = false
        f.physicsBody?.affectedByGravity = false
        addChild(f)
        let jointA = SKPhysicsJointPin.joint(withBodyA: f.physicsBody!, bodyB: object.physicsBody!, anchor: f.position)
        physicsWorld.add(jointA)
    }
    
    func changephysicalproperties(restitution:CGFloat?,friction:CGFloat?,linearDamping:CGFloat?,angularDamping:CGFloat?,mass:CGFloat?,n:Int){
        let object = Action[na[n] - 1]
        if restitution != nil{
            object.physicsBody?.restitution = restitution!
        }
        if friction != nil{
            object.physicsBody?.friction = friction!
        }
        if linearDamping != nil{
            object.physicsBody?.linearDamping = linearDamping!
        }
        if angularDamping != nil{
            object.physicsBody?.angularDamping = angularDamping!
        }
        if mass != nil{
            object.physicsBody?.mass = mass!
        }
    }
    
    func changephysicalproperties(linearDamping:CGFloat?,angularDamping:CGFloat?,mass:CGFloat?,n:Int){
        let object = Action[na[n] - 1]
        if linearDamping != nil{
            object.physicsBody?.linearDamping = linearDamping!
        }
        if angularDamping != nil{
            object.physicsBody?.angularDamping = angularDamping!
        }
        if mass != nil{
            object.physicsBody?.mass = mass!
        }
    }
    
    func changephysicalproperties(restitution:CGFloat?,friction:CGFloat?,n:Int){
        let object = Action[na[n] - 1]
        if restitution != nil{
            object.physicsBody?.restitution = restitution!
        }
        if friction != nil{
            object.physicsBody?.friction = friction!
        }
    }

    func addjointObject(jointpx:CGFloat,jointpy:CGFloat,objectAn:Int,objectBn:Int){
        let objectA = Action[na[objectAn] - 1]
        let objectB = Action[na[objectBn] - 1]
        let jpx = w / 20  + w / 10 * jointpx
        let jpy = w / 20  + w / 10 * jointpy
        let jointA = SKPhysicsJointPin.joint(withBodyA: objectA.physicsBody!, bodyB: objectB.physicsBody!, anchor: CGPoint(x: jpx, y: jpy))
        physicsWorld.add(jointA)
    }
    func addjointObject2(objectAn:Int,objectBn:Int){
        let objectA = Action[na[objectAn] - 1]
        let objectB = Action[na[objectBn] - 1]
        let jointA = SKPhysicsJointPin.joint(withBodyA: objectA.physicsBody!, bodyB: objectB.physicsBody!, anchor: objectA.position)
        physicsWorld.add(jointA)
        let jointB = SKPhysicsJointPin.joint(withBodyA: objectA.physicsBody!, bodyB: objectB.physicsBody!, anchor: objectB.position)
        physicsWorld.add(jointB)
    }
    
    func addjointObject(objectAn:Int,objectBn:Int){
        let objectA = Action[na[objectAn] - 1]
        let objectB = Action[na[objectBn] - 1]
        let jpx = (objectA.position.x + objectB.position.x) / 2
        let jpy = (objectA.position.y + objectB.position.y) / 2
        let jointA = SKPhysicsJointPin.joint(withBodyA: objectA.physicsBody!, bodyB: objectB.physicsBody!, anchor: CGPoint(x: jpx, y: jpy))
        physicsWorld.add(jointA)
    }
    
    func addrvecterAction(interval: Double, time:Double,n:Int){
        let rvecterA = Action[na[n] - 1]
        let Dynamic = rvecterA.physicsBody?.isDynamic
        rvecterA.physicsBody?.isDynamic = true
        let rsita = Double(arc4random_uniform(360)) * .pi / 180.0
        
        let wateAction1 = SKAction.wait(forDuration: interval)
        let wateAvtion2 = SKAction.wait(forDuration: time)
        
        let rdynamicAction = SKAction.run {
            rvecterA.physicsBody?.isDynamic = Dynamic!
        }
        let rvercterAction = SKAction.run {
            rvecterA.physicsBody?.applyForce(CGVector(dx:1000.0 * cos(rsita), dy:1000.0 * sin(rsita)))
        }
        let sAction = SKAction.sequence([wateAction1,rvercterAction,wateAvtion2,rdynamicAction])
        rvecterA.run(sAction)
    }
    
    func addoutAction(interval: Double, time: Double, n:Int){
        let outA = Action[na[n] - 1]
        
        let wateAction = SKAction.wait(forDuration: interval)
        let oAction = SKAction.fadeOut(withDuration: time)
        let deleteAction = SKAction.removeFromParent()
        
        let sAction = SKAction.sequence([wateAction,oAction,deleteAction])
        outA.run(sAction)
    }
    
    func addreflection(interval: Double, time: Double,dyna: Bool, n:Int){
        let refA = Action[na[n] - 1]
        let Dynamic = refA.physicsBody?.isDynamic
        let restitution = refA.physicsBody?.restitution
        let collison = refA.physicsBody?.collisionBitMask
        
        let wateAction1 = SKAction.wait(forDuration: interval)
        let wateAction2 = SKAction.wait(forDuration: time)
        let refrecAction = SKAction.run {
            refA.physicsBody?.restitution = 1.0
            refA.physicsBody?.collisionBitMask = self.ballCategory + self.blockCategory + self.redblockCategory
            if dyna{
                refA.physicsBody?.isDynamic = true
            }
        }
        let ourrefrecAction = SKAction.run {
            refA.physicsBody?.restitution = restitution!
            refA.physicsBody?.collisionBitMask = collison!
            refA.physicsBody?.isDynamic = Dynamic!
        }
        let sAction = SKAction.sequence([wateAction1,refrecAction,wateAction2,ourrefrecAction])
        refA.run(sAction)
    }
    
    func addinoutAction(interval1:Double ,interval2:Double,time1:Double,time2:Double,n:Int){
        //interval1 開始何秒後に出現させるか
        //interval2 何秒間出現しているか
        //time1 フィードインにかかる時間
        //time2 フィードアウトにかかる時間
        let inoutA = Action[na[n] - 1]
        
        let categoryB = inoutA.physicsBody?.categoryBitMask
        let collisionB = inoutA.physicsBody?.collisionBitMask
        
        inoutA.physicsBody?.categoryBitMask = 0
        inoutA.physicsBody?.collisionBitMask = 0
        inoutA.alpha = 0
        
        //接触する物体に変更
        let physicsinAction = SKAction.run {
            inoutA.physicsBody?.categoryBitMask = categoryB!
            inoutA.physicsBody?.collisionBitMask = collisionB!
        }
        let wateAction1 = SKAction.wait(forDuration: interval1)
        let wateAction2 = SKAction.wait(forDuration: interval2)
        let inAction = SKAction.fadeIn(withDuration: time1)
        let oAction = SKAction.fadeOut(withDuration: time2)
        let deleteAction = SKAction.removeFromParent()
        
        let sAction = SKAction.sequence([wateAction1,physicsinAction,inAction,wateAction2,oAction,deleteAction])
        inoutA.run(sAction)
    }
    
    func addinoutAction2(interval1:Double ,interval2:Double,time1:Double,time2:Double,n:Int){
        //interval1 開始何秒後に出現させるか
        //interval2 何秒間出現しているか
        //time1 フィードインにかかる時間
        //time2 フィードアウトにかかる時間
        let inoutA = Action[na[n] - 1]
        
        let categoryB = inoutA.physicsBody?.categoryBitMask
        let collisionB = inoutA.physicsBody?.collisionBitMask
        
        inoutA.physicsBody?.categoryBitMask = 0
        inoutA.physicsBody?.collisionBitMask = 0
        inoutA.alpha = 0
        
        //接触する物体に変更
        let physicsinAction = SKAction.run {
            inoutA.physicsBody?.categoryBitMask = categoryB!
            inoutA.physicsBody?.collisionBitMask = collisionB!
        }
        let wateAction1 = SKAction.wait(forDuration: interval1)
        let wateAction2 = SKAction.wait(forDuration: interval2)
        let inAction = SKAction.fadeIn(withDuration: time1)
        let oAction = SKAction.fadeOut(withDuration: time2)
        let deleteAction = SKAction.removeFromParent()
        
        let sAction = SKAction.sequence([wateAction1,inAction,physicsinAction,wateAction2,oAction,deleteAction])
        inoutA.run(sAction)
    }
    
    func addinAction(interval:Double,time:Double,n:Int){
        //interval1 開始何秒後に出現させるか
        //interval2 何秒間出現しているか
        //time1 フィードインにかかる時間
        //time2 フィードアウトにかかる時間
        let inA = Action[na[n] - 1]
        
        let categoryB = inA.physicsBody?.categoryBitMask
        let collisionB = inA.physicsBody?.collisionBitMask
        
        inA.physicsBody?.categoryBitMask = 0
        inA.physicsBody?.collisionBitMask = 0
        inA.alpha = 0
        
        //接触する物体に変更
        let physicsinAction = SKAction.run {
            inA.physicsBody?.categoryBitMask = categoryB!
            inA.physicsBody?.collisionBitMask = collisionB!
        }
        let wateAction = SKAction.wait(forDuration: interval)
        let inAction = SKAction.fadeIn(withDuration: time)
        
        let sAction = SKAction.sequence([wateAction,physicsinAction,inAction])
        inA.run(sAction)
    }
    

    func addoutinAction(firstinterval:Double,outinterval:Double,ininterval:Double,time1:Double,time2:Double,n:Int ){
        let outinA = Action[na[n] - 1]
        let categoryB = outinA.physicsBody?.categoryBitMask
        let collisionB = outinA.physicsBody?.collisionBitMask
        
        let physicsinAction = SKAction.run {
            outinA.physicsBody?.categoryBitMask = categoryB!
            outinA.physicsBody?.collisionBitMask = collisionB!
        }
        let physicsoutAction = SKAction.run {
            outinA.physicsBody?.categoryBitMask = 0
            outinA.physicsBody?.collisionBitMask = 0
        }
        let wateAction1 = SKAction.wait(forDuration: outinterval)
        let wateAction2 = SKAction.wait(forDuration: ininterval)
        let wateAction3 = SKAction.wait(forDuration: firstinterval)
        let inAction = SKAction.fadeIn(withDuration: time1)
        let oAction = SKAction.fadeOut(withDuration: time2)
        
        let sAction = SKAction.sequence([wateAction1,oAction,physicsoutAction,wateAction2,inAction,physicsinAction])
        let repAction = SKAction.repeatForever(sAction)
        let sAction2 = SKAction.sequence([wateAction3,repAction])
        outinA.run(sAction2)
    }
    
    func addoutinAction2(firstinterval:Double,outinterval:Double,ininterval:Double,time1:Double,time2:Double,n:Int ){
        let outinA = Action[na[n] - 1]
        let categoryB = outinA.physicsBody?.categoryBitMask
        let collisionB = outinA.physicsBody?.collisionBitMask
        
        let physicsinAction = SKAction.run {
            outinA.physicsBody?.categoryBitMask = categoryB!
            outinA.physicsBody?.collisionBitMask = collisionB!
        }
        let physicsoutAction = SKAction.run {
            outinA.physicsBody?.categoryBitMask = 0
            outinA.physicsBody?.collisionBitMask = 0
        }
        let wateAction1 = SKAction.wait(forDuration: outinterval)
        let wateAction2 = SKAction.wait(forDuration: ininterval)
        let wateAction3 = SKAction.wait(forDuration: firstinterval)
        let inAction = SKAction.fadeIn(withDuration: time1)
        let oAction = SKAction.fadeOut(withDuration: time2)
        
        let sAction = SKAction.sequence([oAction,physicsoutAction,wateAction2,inAction,physicsinAction,wateAction1])
        let repAction = SKAction.repeatForever(sAction)
        let sAction2 = SKAction.sequence([wateAction3,repAction])
        outinA.run(sAction2)
    }
    
    func addmAction(xmove: Double, ymove: Double, interval: Double ,time: Double ,n:Int){
        let mA = Action[na[n] - 1]
        let obx = mA.position.x
        let oby = mA.position.y
        let mxp = obx + CGFloat(xmove) * w / 10
        let myp = oby + CGFloat(ymove) * w / 10
        
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: time)
        let rmoveAction = SKAction.move(to: CGPoint(x: obx, y: oby), duration: time)
        let wateAction = SKAction.wait(forDuration: interval)
        
        var repAction: SKAction
        var sAction: SKAction
        if interval == 0.0{
            sAction = SKAction.sequence([moveAction,rmoveAction])
        }else{
            sAction = SKAction.sequence([wateAction,moveAction,wateAction,rmoveAction])
        }
        repAction = SKAction.repeatForever(sAction)
        mA.run(repAction)
    }
    
    func addmAction2(xmove: Double, ymove: Double, interval: Double ,time: Double ,n:Int){
        let mA = Action[na[n] - 1]
        let obx = mA.position.x
        let oby = mA.position.y
        let mxp = obx + CGFloat(xmove) * w / 10
        let myp = oby + CGFloat(ymove) * w / 10
        
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: time)
        let rmoveAction = SKAction.move(to: CGPoint(x: obx, y: oby), duration: time)
        let wateAction = SKAction.wait(forDuration: interval)
        
        var repAction: SKAction
        var sAction: SKAction
        if interval == 0.0{
            sAction = SKAction.sequence([moveAction,rmoveAction])
        }else{
            sAction = SKAction.sequence([moveAction,wateAction,rmoveAction,wateAction])
        }
        repAction = SKAction.repeatForever(sAction)
        mA.run(repAction)
    }
    
    func addmAction3(xmove: Double, ymove: Double, interval1: Double ,interval2: Double,time: Double ,n:Int){
        let mA = Action[na[n] - 1]
        let obx = mA.position.x
        let oby = mA.position.y
        let mxp = obx + CGFloat(xmove) * w / 10
        let myp = oby + CGFloat(ymove) * w / 10
        
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: time)
        let wateAction1 = SKAction.wait(forDuration: interval1)
        let wateAction2 = SKAction.wait(forDuration: interval2)
        
        var repAction: SKAction
        var sAction: SKAction
        if interval1 == 0.0{
            sAction = SKAction.sequence([moveAction,wateAction2])
        }else if interval2 == 0.0{
            sAction = SKAction.sequence([wateAction1,moveAction])
        }else{
            sAction = SKAction.sequence([wateAction1,moveAction,wateAction2])
        }
        repAction = SKAction.repeatForever(sAction)
        mA.run(repAction)
    }
    
    func addmAction4(xmove: Double, ymove: Double, ininterval: Double, intime: Double ,moveinterval: Double,mtime: Double ,outinterval: Double,outtime: Double,n:Int){
        let mA = Action[na[n] - 1]
        let obx = mA.position.x
        let oby = mA.position.y
        let mxp = obx + CGFloat(xmove) * w / 10
        let myp = oby + CGFloat(ymove) * w / 10
        let categoryB = mA.physicsBody?.categoryBitMask
        let collisionB = mA.physicsBody?.collisionBitMask
        mA.physicsBody?.categoryBitMask = 0
        mA.physicsBody?.collisionBitMask = 0
        mA.alpha = 0
        
        let physicsinAction = SKAction.run {
            mA.physicsBody?.categoryBitMask = categoryB!
            mA.physicsBody?.collisionBitMask = collisionB!
        }
        let physicsoutAction = SKAction.run {
            mA.physicsBody?.categoryBitMask = 0
            mA.physicsBody?.collisionBitMask = 0
        }
        let inAction = SKAction.fadeIn(withDuration: intime)
        let oAction = SKAction.fadeOut(withDuration: outtime)
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: mtime)
        let wateAction1 = SKAction.wait(forDuration: ininterval)
        let wateAction2 = SKAction.wait(forDuration: moveinterval)
        let wateAction3 = SKAction.wait(forDuration: outinterval)
        let returnpositionAction = SKAction.move(to: CGPoint(x: obx, y: oby), duration: 0.0)
        
        var repAction: SKAction
        var sAction: SKAction
        var sAction2: SKAction
        
        sAction = SKAction.sequence([inAction,physicsinAction,wateAction2,moveAction,wateAction3,oAction,physicsoutAction,returnpositionAction])
        repAction = SKAction.repeatForever(sAction)
        sAction2 = SKAction.sequence([wateAction1,repAction])
        mA.run(sAction2)
    }
    
    func addmAction4(xmove: Double, ymove: Double, ininterval: Double, intime: Double ,moveinterval: Double,mtime: Double ,outinterval: Double,outtime: Double,nexttime: Double,n:Int){
        let mA = Action[na[n] - 1]
        let obx = mA.position.x
        let oby = mA.position.y
        let mxp = obx + CGFloat(xmove) * w / 10
        let myp = oby + CGFloat(ymove) * w / 10
        let categoryB = mA.physicsBody?.categoryBitMask
        let collisionB = mA.physicsBody?.collisionBitMask
        mA.physicsBody?.categoryBitMask = 0
        mA.physicsBody?.collisionBitMask = 0
        mA.alpha = 0
        
        let physicsinAction = SKAction.run {
            mA.physicsBody?.categoryBitMask = categoryB!
            mA.physicsBody?.collisionBitMask = collisionB!
        }
        let physicsoutAction = SKAction.run {
            mA.physicsBody?.categoryBitMask = 0
            mA.physicsBody?.collisionBitMask = 0
        }
        let inAction = SKAction.fadeIn(withDuration: intime)
        let oAction = SKAction.fadeOut(withDuration: outtime)
        let moveAction = SKAction.move(to: CGPoint(x: mxp, y: myp), duration: mtime)
        let wateAction1 = SKAction.wait(forDuration: ininterval)
        let wateAction2 = SKAction.wait(forDuration: moveinterval)
        let wateAction3 = SKAction.wait(forDuration: outinterval)
        let wateAction4 = SKAction.wait(forDuration: nexttime)
        let returnpositionAction = SKAction.move(to: CGPoint(x: obx, y: oby), duration: 0.0)
        
        var repAction: SKAction
        var sAction: SKAction
        var sAction2: SKAction
        
        sAction = SKAction.sequence([inAction,physicsinAction,wateAction2,moveAction,wateAction3,oAction,physicsoutAction,returnpositionAction,wateAction4])
        repAction = SKAction.repeatForever(sAction)
        sAction2 = SKAction.sequence([wateAction1,repAction])
        mA.run(sAction2)
    }
    
    func addmAction5(xmove: Double, ymove: Double,time: Double ,n:Int){
        let mA = Action[na[n] - 1]
        let mxp = CGFloat(xmove) * w / 10
        let myp = CGFloat(ymove) * w / 10
        let moveAction = SKAction.moveBy(x:mxp, y: myp, duration: time)
        let repAction = SKAction.repeatForever(moveAction)
        mA.run(repAction)
    }
    
    func addrAction(dsita: Double, interval: Double, re: Bool, time:Double , n:Int){
        let rA = Action[na[n] - 1]
        let angle = CGFloat(dsita / 180.0 * .pi)
        
        let lAction = SKAction.rotate(byAngle: angle, duration: time)
        let rlAction = SKAction.rotate(byAngle: -angle, duration: time)
        let wateAction = SKAction.wait(forDuration: interval)
        var sAction: SKAction
        var repAction: SKAction
        
        if re && interval == 0.0{
            sAction = SKAction.sequence([lAction,rlAction])
        }else if re && interval != 0.0{
            sAction = SKAction.sequence([wateAction,lAction,wateAction,rlAction])
        }else if interval == 0.0{
            sAction = SKAction.sequence([lAction])
        }else{
            sAction = SKAction.sequence([wateAction,lAction])
        }
        repAction = SKAction.repeatForever(sAction)
        rA.run(repAction)
    }
    
    func changeblueCategory(n:Int){
        let change = Action[na[n] - 1]
        change.physicsBody?.categoryBitMask = blueblockCategory
        change.physicsBody?.collisionBitMask = blueblockcontact
    }
    
    func addrAction2(dsita: Double, interval: Double, re: Bool, time:Double , n:Int){
        let rA = Action[na[n] - 1]
        let angle = CGFloat(dsita / 180.0 * .pi)
        
        let lAction = SKAction.rotate(byAngle: angle, duration: time)
        let rlAction = SKAction.rotate(byAngle: -angle, duration: time)
        let wateAction = SKAction.wait(forDuration: interval)
        var sAction: SKAction
        var repAction: SKAction
        
        if re && interval == 0.0{
            sAction = SKAction.sequence([lAction,rlAction])
        }else if re && interval != 0.0{
            sAction = SKAction.sequence([lAction,wateAction,rlAction,wateAction])
        }else if interval == 0.0{
            sAction = SKAction.sequence([lAction])
        }else{
            sAction = SKAction.sequence([lAction,wateAction])
        }
        repAction = SKAction.repeatForever(sAction)
        rA.run(repAction)
    }
    
    func addrAction4(originx:CGFloat,originy:CGFloat,dsita: Double, interval: Double, re: Bool, time:Double , n:Int){
        let rA = Action[na[n] - 1]
        let angle = CGFloat(dsita / 180.0 * .pi)
        
        let f = SKShapeNode(circleOfRadius: 1)
        f.position = CGPoint(x: w / 10 * originx + w / 20, y:  w / 10 * originy + w / 20)
        f.physicsBody = SKPhysicsBody(circleOfRadius: 1)
        f.physicsBody?.isDynamic = false
        f.physicsBody?.affectedByGravity = false
        f.physicsBody?.categoryBitMask = 0
        f.physicsBody?.collisionBitMask = 0
        addChild(f)
        
        rA.physicsBody?.isDynamic = true
        
        let jointA = SKPhysicsJointPin.joint(withBodyA: rA.physicsBody!, bodyB: f.physicsBody!, anchor: rA.position)
        physicsWorld.add(jointA)
        let jointB = SKPhysicsJointPin.joint(withBodyA: rA.physicsBody!, bodyB: f.physicsBody!, anchor: f.position)
        physicsWorld.add(jointB)
        
        let lAction = SKAction.rotate(byAngle: angle, duration: time)
        let rlAction = SKAction.rotate(byAngle: -angle, duration: time)
        let wateAction = SKAction.wait(forDuration: interval)
        var sAction: SKAction
        var repAction: SKAction
        
        if re && interval == 0.0{
            sAction = SKAction.sequence([lAction,rlAction])
        }else if re && interval != 0.0{
            sAction = SKAction.sequence([wateAction,lAction,wateAction,rlAction])
        }else if interval == 0.0{
            sAction = SKAction.sequence([lAction])
        }else{
            sAction = SKAction.sequence([wateAction,lAction])
        }
        repAction = SKAction.repeatForever(sAction)
        f.run(repAction)
    }
    
    func addrinvalid(n:Int){
        let rA = Action[na[n] - 1]
        rA.physicsBody?.allowsRotation = false
    }
    
    func addgraviy(n:Int){
        let gra = Action[na[n] - 1]
        gra.physicsBody?.affectedByGravity = true
        gra.physicsBody?.isDynamic = true
    }
    
    func adddina(n:Int){
        let dina = Action[na[n] - 1]
        dina.physicsBody?.isDynamic = true
    }

    
    func addrAction3(dsita: Double, interval1: Double, interval2: Double, time:Double , n:Int){
        let rA = Action[na[n] - 1]
        let angle = CGFloat(dsita / 180.0 * .pi)
        
        let lAction = SKAction.rotate(byAngle: angle, duration: time)
        let wateAction1 = SKAction.wait(forDuration: interval1)
        let wateAction2 = SKAction.wait(forDuration: interval2)
        
        var sAction: SKAction
        var repAction: SKAction
        
        if interval1 == 0.0{
            sAction = SKAction.sequence([lAction,wateAction2])
        }else if interval2 == 0.0{
            sAction = SKAction.sequence([wateAction1,lAction])
        }else{
            sAction = SKAction.sequence([wateAction1,lAction,wateAction2])
        }
        repAction = SKAction.repeatForever(sAction)
        rA.run(repAction)
    }
    
    func scaleAction(xscale: CGFloat,yscale: CGFloat,time:Double,n:Int){
        let SAction = Action[na[n] - 1]
        let xs = SAction.xScale
    //    let ys = SAction.yScale
        let scaleAx = SKAction.scaleX(to: -xs , duration: time)
  //      let scaleAy = SKAction.scaleY(to: yscale , duration: time)
        let repscaleAx = SKAction.scaleX(to: xs, duration: time)
  //      let repscaleAy = SKAction.scaleY(to: ys, duration: time)
        
        let sActionx = SKAction.sequence([scaleAx,repscaleAx])
   //     let sActiony = SKAction.sequence([scaleAy,repscaleAy])
        let repActionx = SKAction.repeatForever(sActionx)
   //     let repActiony = SKAction.repeatForever(sActiony)
        SAction.run(repActionx)
    //    SAction.run(repActiony)
    }
}
