//
//  StockListTableViewCell.swift
//  Spock
//
//  Created by 相川健太 on 2019/05/01.
//  Copyright © 2019 相川健太. All rights reserved.
//

import UIKit

class StockListTableViewCell: UITableViewCell {

    @IBOutlet weak var spotName: UILabel!
    @IBOutlet weak var memo: UILabel!
    @IBOutlet weak var spotImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
//        SpotName.text = nil
//        CategoryName.text = nil
//        Reason.text = nil
//    }
    
}
