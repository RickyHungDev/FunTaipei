//
//  LandmarkDetailViewController.swift
//  funtaipei
//
//  Created by Hung Ricky on 2018/5/23.
//  Copyright © 2018年 Hung Ricky. All rights reserved.
//

import UIKit

class LandmarkDetailViewController: DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.fetchType = "landmark"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = latitude == 0.0 && longitude == 0.0 ? false : true
        
        // 設置資訊
        detail = [
            "地圖",
            info["type"] as? String ?? "",
            info["address"] as? String ?? "",
            info["openTime"] as? String ?? "",
            info["transportation"] as? String ?? "",
            info["intro"] as? String ?? "",
        ]
        
        self.title = info["title"] as? String ?? "標題"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
