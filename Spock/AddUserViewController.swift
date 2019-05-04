//
//  AddUserViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/05.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddUserViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: Any) {
        let user_name = userName.text!
        let pass_word = password.text!
        
        if let urlString = KeyManager().getValue(key: "user_key") as? String {
            let headers: HTTPHeaders = [
                "Contenttype": "application/json"
            ]
            let parameters = ["username": user_name, "password": pass_word]
            
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
                        let alert: UIAlertController = UIAlertController(title: "作成成功", message: "新規ユーザーが追加されました。\nログインしてください。", preferredStyle:  UIAlertController.Style.alert)
                        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                            // ボタンが押された時の処理を書く（クロージャ実装）
                            (action: UIAlertAction!) -> Void in
                            print("OK")
                        })
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                    case .failure:
                        print("Failure!")
                        let alert: UIAlertController = UIAlertController(title: "作成失敗", message: "正しい形式で入力してください。", preferredStyle:  UIAlertController.Style.alert)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
