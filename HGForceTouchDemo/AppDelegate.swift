//
//  AppDelegate.swift
//  HGForceTouchDemo
//
//  Created by HamGuy on 3/24/16.
//  Copyright © 2016 HamGuy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    enum ShortcutType: String {
        case Green = "Green"
        case Red =   "Red"
        case Blue = "Blue"
        case Yellow = "Yellow"
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let launchFromShorCutItem = createDynamicShortcutsIfNeeded(application, launchOptions: launchOptions)
        
        return launchFromShorCutItem
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    func createDynamicShortcutsIfNeeded(application:UIApplication,launchOptions:[NSObject:AnyObject]?)->Bool{
        var launchedFromShortCut = false
        //Check for ShortCutItem
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedFromShortCut = true
            handleShortCutItem(shortcutItem)
        }
        
        
        if application.shortcutItems?.count == 0{
            let item1 = UIApplicationShortcutItem(type: ShortcutType.Red.rawValue, localizedTitle: "Red", localizedSubtitle: "Red Subtitle", icon: UIApplicationShortcutIcon(type:UIApplicationShortcutIconType.Compose), userInfo: nil)
            let item2 = UIApplicationShortcutItem(type: ShortcutType.Green.rawValue, localizedTitle: "Green", localizedSubtitle: "Green Subtitle", icon: UIApplicationShortcutIcon(type:UIApplicationShortcutIconType.Play), userInfo: nil)
            let item3 = UIApplicationShortcutItem(type: ShortcutType.Blue.rawValue, localizedTitle: "Blue", localizedSubtitle: "Blue Subtitle", icon: UIApplicationShortcutIcon(type:UIApplicationShortcutIconType.Search), userInfo: nil)
            let item4 = UIApplicationShortcutItem(type: ShortcutType.Yellow.rawValue, localizedTitle: "Yellow", localizedSubtitle: "Yellow Subtitle", icon: UIApplicationShortcutIcon(templateImageName:"heartIcon"), userInfo: nil)
            
            application.shortcutItems = [item1,item2,item3,item4]
        }
        
        // Return false incase application was lanched from shorcut to prevent
        // application(_:performActionForShortcutItem:completionHandler:) from being called
        return !launchedFromShortCut
    }

    func handleShortCutItem(item:UIApplicationShortcutItem){
        let itemType = item.type
        if let rootController = window?.rootViewController {
            let vc = TestViewController(type: AppDelegate.ShortcutType(rawValue: itemType)!)
            if rootController is UINavigationController{
               (rootController as! UINavigationController).pushViewController(vc, animated: true)
            }else{
                rootController.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        handleShortCutItem(shortcutItem)
        completionHandler(true)
    }
}

