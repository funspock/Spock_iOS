//
//  StockDetailViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/01.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var StockImage: UIImageView!
    @IBOutlet weak var StockTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StockImage.image = UIImage(named: "shop1.jpeg")
        StockTableView.tableFooterView = UIView()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return 1
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockDetailCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "スポット名：" + "aaaa"
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "カテゴリ名：" + "aaaa"
        } else if indexPath.section == 2 {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = "なぜ気になった？：" + "hogehoghehogehogehogehogehogehogehogehogehogehogehogehogehogehogehogehoghehogehogehogehogehogehogehogehogehogehogehogehogehogehoge"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
