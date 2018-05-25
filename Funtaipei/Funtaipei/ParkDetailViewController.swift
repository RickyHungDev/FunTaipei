//
//  ParkDetailViewController.swift
//  funtaipei
//
//  Created by Hung Ricky on 2018/5/23.
//  Copyright © 2018年 Hung Ricky. All rights reserved.
//

import UIKit

class ParkDetailViewController: DetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.fetchType = "park"
        
        let latitude = info["latitude"] as? Double ?? 0.0
        let longitude = info["longitude"] as? Double ?? 0.0
        hasMap = latitude == 0.0 && longitude == 0.0 ? false : true
        
        // 設置資訊
        detail = [
            "地圖",
            info["type"] as? String ?? "",
            info["parkinglot"] as? String ?? "",
            info["location"] as? String ?? "",
            info["area"] as? String ?? "",
        ]
        
        self.title = info["title"] as? String ?? "標題"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate methods
    
    // 必須實作的方法：每一組有幾個 cell
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hasMap ? 5 : 4
    }

}
