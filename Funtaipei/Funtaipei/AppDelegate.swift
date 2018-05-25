//
//  AppDelegate.swift
//  funtaipei
//
//  Created by Hung Ricky on 2018/5/23.
//  Copyright © 2018年 Hung Ricky. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var myLocationManager: CLLocationManager!
    var myUserDefaults: UserDefaults!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        /*
         kCLLocationAccuracyBestForNavigation:精確度最高，適用於導航的定位。 
         kCLLocationAccuracyBest:精確度高。 
         kCLLocationAccuracyNearestTenMeters:精確度 10 公尺以內。 
         kCLLocationAccuracyHundredMeters:精確度 100 公尺以內。 
         kCLLocationAccuracyKilometer:精確度 1 公里以內。 
         kCLLocationAccuracyThreeKilometers:精確度 3 公里以內。
         */
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            
            // 設定後的動作請至委任方法
            // func locationManager(
            //   manager: CLLocationManager,
            //   didChangeAuthorizationStatus status: CLAuthorizationStatus)
            // 設置
        } else if (CLLocationManager.authorizationStatus() == .denied) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            
            self.myUserDefaults.synchronize()
        } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            // 更新記錄的座標 for 取得有限數量的資料
            for type in ["landmark", "park", "toilet", "hotel"] {
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLatitude")
                self.myUserDefaults.set(0.0, forKey: "\(type)RecordLongitude")
            }
            
            self.myUserDefaults.synchronize()
        }
        
        // 設定導覽列預設底色
        UINavigationBar.appearance().barTintColor = UIColor(red: 1, green: 0.9, blue: 0.7, alpha: 1)
        
        // 設定導覽列預設按鈕顏色
        UINavigationBar.appearance().tintColor = UIColor.black
        
        
        // 建立一個 UIWindow
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        // 建立 UITabBarController
        let myTabBar = UITabBarController()
        myTabBar.tabBar.backgroundColor = UIColor(red: 1, green: 0.9, blue: 0.7, alpha: 1)
        
        // 建立 景點 頁面
        let landmarkViewController = UINavigationController(rootViewController: LandmarkMainViewController())
        landmarkViewController.tabBarItem = UITabBarItem(title: "景點", image: nil, tag: 200)
        
        // 建立 公園 頁面
        let parkViewController = UINavigationController(rootViewController: ParkMainViewController())
        parkViewController.tabBarItem = UITabBarItem(title: "河濱公園", image: nil, tag: 300)
        
        // 建立 廁所 頁面
        let toiletViewController = UINavigationController(rootViewController: ToiletMainViewController())
        toiletViewController.tabBarItem = UITabBarItem(title: "廁所", image: nil, tag: 400)
        
        // 建立 住宿 頁面
        let hotelViewController = UINavigationController(rootViewController: HotelMainViewController())
        hotelViewController.tabBarItem = UITabBarItem(title: "住宿", image: nil, tag: 100)
        
        // 加入到 UITabBarController
        myTabBar.viewControllers = [landmarkViewController, parkViewController, toiletViewController, hotelViewController]
        
        // 設置根視圖控制器
        self.window!.rootViewController = myTabBar
        
        // 將 UIWindow 設置為可見的
        self.window!.makeKeyAndVisible()
        
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
    
    // MARK: CLLocationManagerDelegate Methods
    
    // 更改定位權限時執行
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController( title: "定位服務已關閉", message: "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
            
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        }
    }


}

