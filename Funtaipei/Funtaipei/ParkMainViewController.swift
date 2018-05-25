//
//  ParkMainViewController.swift
//  funtaipei
//
//  Created by Hung Ricky on 2018/5/23.
//  Copyright © 2018年 Hung Ricky. All rights reserved.
//

import UIKit

class ParkMainViewController: BaseMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 導覽列標題
        self.title = "河濱公園"
        
        // 獲取類型
        self.fetchType = "park"
        
        // 台北景點資料 ID
        self.strTargetID = "c4f92891-4deb-43d6-ab36-5979651596fc"
        
        self.targetUrl = self.documentsPath + self.fetchType + ".json"
        
        // 取得 API 資料
        self.addData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func goDetail(_ index: Int) {
        let thisData = self.apiData[self.apiDataForDistance[index].index]
        let title = thisData["Name"] as? String ?? ""
        var parkingLot = thisData["Parking_Lot"] as? String ?? "未知"
        var area = thisData["Measure_of_Area"] as? String ?? "無面積資訊"
        
        parkingLot = "是否有停車場： " + parkingLot
        
        if area != "無面積資訊" {
            area = "面積： " + area + " 平方公尺"
        }
        
        var type : String? = ""
        if let district = thisData["District"] {
            type = district as? String ?? ""
        }
        if let river = thisData["River"] {
            type = "\(type ?? "") \(river ?? "")"
        }
        let location = thisData["Description"] as? String ?? "無地址資訊"
        
        var latitude = 0.0
        if let num = thisData["Latitude"] as? String {
            latitude = Double(num)!
        }
        
        var longitude = 0.0
        if let num = thisData["Longitude"] as? String {
            longitude = Double(num)!
        }
        
        let info :[String:AnyObject] = [
            "title" : title as AnyObject,
            "parkinglot" : parkingLot as AnyObject,
            "type" : type as AnyObject,
            "location" : location as AnyObject,
            "area" : area as AnyObject,
            "latitude" : latitude as AnyObject,
            "longitude" : longitude as AnyObject,
            ]
        
        print(info["title"] as? String ?? "NO Title")
        
        let detailViewController = ParkDetailViewController()
        detailViewController.info = info
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }

}
