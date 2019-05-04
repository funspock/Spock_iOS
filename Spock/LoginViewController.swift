//
//  ViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/01.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var topImage: UIImageView!
    var userName:String!
    var password:String!
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topImage.image = UIImage(named: "shop2.jpg")
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        userName = userNameField.text!
        password = passwordField.text!
        authorized()
        userDefaults.set(userName, forKey: "UserName")
        userDefaults.synchronize()
        print(userName!)
        print(password!)
    }
    
    func authorized(){
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
                    debugPrint(response)
                    switch response.result {
                    case .success:
                        print("Success!")
                        self.performSegue(withIdentifier: "toStockList", sender: nil)
                        let alert: UIAlertController = UIAlertController(title: "ログイン成功", message: "ログインしました", preferredStyle:  UIAlertController.Style.alert)
                        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                            // ボタンが押された時の処理を書く（クロージャ実装）
                            (action: UIAlertAction!) -> Void in
                            print("OK")
                        })
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                    case .failure:
                        print("Failure!")
                        self.navigationController?.popViewController(animated: true)
                        let alert: UIAlertController = UIAlertController(title: "ログイン失敗", message: "ユーザー名またはパスワードが\n間違っています", preferredStyle:  UIAlertController.Style.alert)
                        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                            // ボタンが押された時の処理を書く（クロージャ実装）
                            (action: UIAlertAction!) -> Void in
                            print("OK")
                        })
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                    }
            }
        }else{
            print("ipおかしいよー")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toStockList"{
            let stockListViewController = segue.destination as! StockListViewController
            stockListViewController.userName = userName
            stockListViewController.password = password
        }
    }
}

