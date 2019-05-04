//
//  StockListViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/01.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class StockListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var StockList: UITableView!
    
    var userName:String!
    var password:String!
    
    var spots:[[String: String?]] = []
    var spotName:String!
    var memo:String!
    var photo_url:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StockList.dataSource = self
        StockList.delegate = self
        StockList.register (UINib(nibName: "StockListTableViewCell", bundle: nil),forCellReuseIdentifier:"StockListTableViewCell")
        getSpots()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockListTableViewCell") as! StockListTableViewCell
        let spot = spots[indexPath.row]
        let spot_photo_url = spot["photo_url"]!
        cell.spotName.text = spot["name"]!
        cell.memo.text = spot["memo"]!
        Alamofire.request(spot_photo_url!).responseImage { response in
            debugPrint(response)
            
            print(response.request)
            print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
                cell.spotImage.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let spot = spots[indexPath.row]
        spotName = spot["name"]!
        memo = spot["memo"]!
        photo_url = spot["photo_url"]!
        performSegue(withIdentifier: "toDetail",sender: nil)
    }
    
    func getSpots(){
        if let urlString = KeyManager().getValue(key: "login_key") as? String {
            let headers: HTTPHeaders = [
                "Contenttype": "application/json"
            ]
            let parameters = ["username": userName, "password": password]
            
            Alamofire.request(urlString, method: .post, parameters: parameters as Parameters, encoding: JSONEncoding.default, headers: headers).downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
                }.validate { request, response, data in
                    return .success
                }
                .responseJSON { response in
                    guard let object = response.result.value else {
                        return
                    }
                    
                    let json = JSON(object)
                    json.forEach { (_, json) in
                        let id = json["id"].int
                        let spot: [String: String?] = [
                            "id": String(id!),
                            "name": json["name"].string,
                            "memo": json["memo"].string,
                            "photo_url": json["photo_url"].string,
                            "user": json["user"].string
                        ]
                        self.spots.append(spot)
                    }
                    self.StockList.reloadData()
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        print("Success!")
                    case .failure:
                        print("Failure!")
                    }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail"{
            let stockDetailViewController = segue.destination as! StockDetailViewController
            stockDetailViewController.spotName = spotName
            stockDetailViewController.memo = memo
            stockDetailViewController.photo_url = photo_url
        }
    }
}


