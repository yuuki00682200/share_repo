//
//  Meal.swift
//  FoodTracker
//
//  Created by 冨田健介 on 2021/06/26.
//  Copyright © 2021 NeppsStaff. All rights reserved.
//

//import Foundation
import UIKit

class Meal {
    //MARK:プロパティ
    var name :String
    var photo :UIImage? //ここはオプショナル型に、値が空になり得る
    var rating :Int
    
    //13回目から
    
    init?(name: String, photo:UIImage?, rating: Int) {
        if name.isEmpty || rating < 0{
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }

}
