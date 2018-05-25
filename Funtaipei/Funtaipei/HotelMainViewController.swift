//
//  HotelMainViewController.swift
//  funtaipei
//
//  Created by Hung Ricky on 2018/5/23.
//  Copyright © 2018年 Hung Ricky. All rights reserved.
//

import UIKit

class HotelMainViewController: BaseMainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 導覽列標題
        self.title = "住宿"
        
        // 獲取類型
        self.fetchType = "hotel"
        
        // 台北住宿資料 ID
        self.strTargetID = "6f4e0b9b-8cb1-4b1d-a5c4-febd90f62469" //&limit=3&offset=0"
        
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
        let title = thisData["stitle"] as? String ?? ""
        let intro = thisData["xbody"] as? String ?? ""
        let type = thisData["CAT2"] as? String ?? ""
        let address = thisData["address"] as? String ?? "無地址資訊"
        
        var latitude = 0.0
        if let num = thisData["latitude"] as? String {
            latitude = Double(num)!
        }
        
        var longitude = 0.0
        if let num = thisData["longitude"] as? String {
            longitude = Double(num)!
        }
        
        let info :[String:AnyObject] = [
            "title" : title as AnyObject,
            "intro" : intro as AnyObject,
            "type" : type as AnyObject,
            "address" : address as AnyObject,
            "latitude" : latitude as AnyObject,
            "longitude" : longitude as AnyObject,
            ]
        
        print(info["title"] as? String ?? "NO Title")
        
        let detailViewController = HotelDetailViewController()
        detailViewController.info = info
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }


}
