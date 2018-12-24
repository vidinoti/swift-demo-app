//
//  AppDelegate.swift
//  MyARSwiftApp
//
//  Created by Johan Leuenberger on 21.12.18.
//  Copyright © 2018 Vidinoti. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // V-Director license key
    let licenseKey = "qv8db1pcnzc444ysnqtj"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // File path where the AR contents will be stored
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let documentPathString = documentPath.appendingPathComponent("models")

        // Initializes the Vidinoti SDK
        guard let controller = VDARSDKController.startSDK(documentPathString, withLicenseKey: licenseKey) else {
            fatalError("Error loading Vidinoti SDK")
        }

        // Initialize the camera used for the AR scanner
        controller.imageSender = VDARCameraImageSource()

        return true
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        VDARSDKController.sharedInstance()?.application(application, didReceive: notification)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        VDARSDKController.sharedInstance()?.save()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        VDARSDKController.sharedInstance()?.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Synchronizes with V-Director when the application becomes active.
        VidinotiService().synchronize()
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}
