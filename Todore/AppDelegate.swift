//
//  AppDelegate.swift
//  Todore
//
//  Created by Manjot S Sandhu on 16/4/20.
//  Copyright © 2020 Manjot S Sandhu. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        //location of realm file
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
        // create new data
        // used context to commit current state to persistance container in this case realm databse
        
        do {
            _ = try Realm()
        } catch {
           print("Error initialising new realm, \(error)")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

}

