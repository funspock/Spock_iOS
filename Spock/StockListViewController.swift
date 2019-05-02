//
//  StockListViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/01.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit

class StockListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var StockList: UITableView!
    var spotName:String!
    var categoryName:String!
    var reason:String!
    var spotNames:[String] = ["spot1","spot2","spot3"]
    var categoryNames:[String] = ["catname1","catname2","catname3"]
    var reasons:[String] = ["reason1","reason2","reason3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        StockList.dataSource = self
        StockList.delegate = self
        StockList.register (UINib(nibName: "StockListTableViewCell", bundle: nil),forCellReuseIdentifier:"StockListTableViewCell")

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spotNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockListTableViewCell") as! StockListTableViewCell
        cell.SpotName.text = spotNames[indexPath.row]
        cell.CategoryName.text = categoryNames[indexPath.row]
        cell.Reason.text = reasons[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spotName = spotNames[indexPath.row]
        categoryName = categoryNames[indexPath.row]
        reason = reasons[indexPath.row]
        performSegue(withIdentifier: "toDetail",sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let stockDetailViewController = segue.destination as! StockDetailViewController
            stockDetailViewController.spotName = spotName
            stockDetailViewController.categoryName = categoryName
            stockDetailViewController.reason = reason
            
        }
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
