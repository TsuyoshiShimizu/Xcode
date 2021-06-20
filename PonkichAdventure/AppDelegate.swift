//
//  AppDelegate.swift
//  gravity
//
//  Created by 清水健志 on 2018/07/28.
//  Copyright © 2018年 ponkitigames. All rights reserved.
//

import UIKit
import StoreKit
import Siren
//import NendAd


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //7¥データ記憶
        for n in 1...120{
            UserDefaults.standard.register(defaults: ["stageclear\(n)" : 0])       // ステージクリア状況
            UserDefaults.standard.register(defaults: ["stageScene\(n)" : 0])       // 通常ステージのシーンを記憶
        }
        for n in 1...20{
            UserDefaults.standard.register(defaults: ["SkillGet\(n)" : false])      //スキルを習得しているか
            UserDefaults.standard.register(defaults: ["SkillOn\(n)" : false])       //スキルを有効にしているか
            UserDefaults.standard.register(defaults: ["ClearItemn\(n)" : false])    //クリアアイテムの取得状況
            
            UserDefaults.standard.register(defaults: ["UpdateFirst\(n)" :true])
        }
        
        for n in 1 ... 31{
            UserDefaults.standard.register(defaults: ["PictureFlag\(n)": false])
        }
        
        UserDefaults.standard.register(defaults: ["SSSave" : -1])               //ステージセレクトシーンの記憶に使用
        UserDefaults.standard.register(defaults: ["SSBSave" : 0])               //ステージセレクトシーンの記憶に使用
        UserDefaults.standard.register(defaults: ["HAType" : 0])                //どのホールドスキルをセットしているか
        UserDefaults.standard.register(defaults: ["InterCountI" : 0])           //広告表示の有無
        UserDefaults.standard.register(defaults: ["Pointerflag" : true])        //ポインターを表示するか
        UserDefaults.standard.register(defaults: ["difficulty" :0])             //ゲーム難易度
        UserDefaults.standard.register(defaults: ["firstplay" :true])
        UserDefaults.standard.register(defaults: ["MoneyF" :false])             //広告非表示課金をしているか
        
        SKPaymentQueue.default().add(IAPManager.shared)
        
        forceUpdate()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

private extension AppDelegate {

    func forceUpdate() {
        
        let siren = Siren.shared
        // 言語を日本語に設定
        siren.presentationManager = PresentationManager(forceLanguageLocalization: .japanese)

        // ruleを設定
        siren.rulesManager = RulesManager(globalRules: .critical)

        // sirenの実行関数
        siren.wail { results in
            switch results {
            case .success(let updateResults):
                print("AlertAction ", updateResults.alertAction)
                print("Localization ", updateResults.localization)
                print("Model ", updateResults.model)
                print("UpdateType ", updateResults.updateType)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }

        // 以下のように、完了時の処理を無視して記述することも可能
        // siren.wail()
    }
}

