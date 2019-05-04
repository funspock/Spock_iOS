//
//  StockCreateViewController.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/02.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Alamofire
import AlamofireImage

class StockCreateViewController: FormViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ImageRow.defaultCellUpdate = { cell, row in
            cell.accessoryView?.layer.cornerRadius = 17
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
            cell.height = ({return 100})
        }
        
        LabelRow.defaultCellUpdate = { cell, row in
            cell.contentView.backgroundColor = .red
            cell.textLabel?.textColor = .white
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 13)
            cell.textLabel?.textAlignment = .right
        }
        
        TextRow.defaultCellUpdate = { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        form +++ Section("新規スポット詳細")
            <<< TextRow("SpotNameRowTag"){ row in
                row.title = "スポットの名前"
                row.placeholder = "僕のお気に入りスポット"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnBlur
                }.cellUpdate{ cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }.onRowValidationChanged { cell, row in
                    let rowIndex = row.indexPath!.row
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, _) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = "スポットの名前を入力してください"
                                $0.cell.height = { 30 }
                            }
                            row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                        }
                    }
            }
            <<< ImageRow("ImageRowTag") {
                $0.title = "スポット画像"
                $0.cell.height = {60}
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnBlur
                }.onRowValidationChanged { cell, row in
                    let rowIndex = row.indexPath!.row
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, _) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = "画像を選択してください"
                                $0.cell.height = { 30 }
                            }
                            row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                        }
                    }
            }
            <<< TextAreaRow("DescRowTag"){ row in
                row.placeholder = "なぜこのスポットが気になった？"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnBlur
                }.onRowValidationChanged { cell, row in
                    let rowIndex = row.indexPath!.row
                    while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                        row.section?.remove(at: rowIndex + 1)
                    }
                    if !row.isValid {
                        for (index, _) in row.validationErrors.map({ $0.msg }).enumerated() {
                            let labelRow = LabelRow() {
                                $0.title = "入力してください"
                                $0.cell.height = { 30 }
                            }
                            row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                        }
                    }
        }
    }
    
    
    @IBAction func spotSave(_ sender: Any) {
        let errors = form.validate()
        guard errors.isEmpty else {
            print("validate errors:", errors)
            let alert: UIAlertController = UIAlertController(title: "エラー", message: "入力または選択されていない\n項目があります", preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let values = form.values()
        let userName: String? = userDefaults.object(forKey: "UserName") as? String
        let spotName = values["SpotNameRowTag"] as! String
        let memo = values["DescRowTag"] as! String
        let image = values["ImageRowTag"] as! UIImage
        
        if let urlString = KeyManager().getValue(key: "data_key") as? String {
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    // 送信する値の指定をここでします
                    let data = image.jpegData(compressionQuality: 0.5)
                    print(data!)
                    multipartFormData.append(data!, withName: "img", fileName: spotName + ".jpeg", mimeType: "image/jpeg")
                    multipartFormData.append(userName!.data(using: String.Encoding.utf8)!, withName: "username")
                    multipartFormData.append(memo.data(using: String.Encoding.utf8)!, withName: "memo")
                    multipartFormData.append(spotName.data(using: String.Encoding.utf8)!, withName: "spot_name")
            },
                to: urlString,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            // 成功
                            let responseData = response
                            print(responseData ?? "成功")
                        }
                    case .failure(let encodingError):
                        // 失敗
                        print(encodingError)
                    }
            }
            )        }
        
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
