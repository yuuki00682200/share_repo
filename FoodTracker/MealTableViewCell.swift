//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by 冨田健介 on 2021/07/10.
//  Copyright © 2021 NeppsStaff. All rights reserved.
//

import UIKit

//14回 21ページ

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var RatingControl: RatingControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//Next... No.15
