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

class StockCreateViewController: FormViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("新規スポット詳細")
            <<< TextRow("SpotNameRowTag"){ row in
                row.title = "スポットの名前"
                row.placeholder = "アイウエオ"
            }
            <<< TextRow("CatRowTag") { row in
                row.title = "カテゴリー"
            }
            <<< ImageRow("ImageRowTag") {
                $0.title = "スポット画像"
                $0.cell.height = {60}
            }
            <<< TextAreaRow("DescRowTag"){ row in
                row.placeholder = "なぜこのスポットが気になった？"
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
