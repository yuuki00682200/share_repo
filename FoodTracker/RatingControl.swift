//
//  RatingControl.swift
//  FoodTracker
//
//  Created by 冨田健介 on 2021/05/22.
//  Copyright © 2021 NeppsStaff. All rights reserved.
//

/*
 次回は12回 31ページから
 今のところ順調*/

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK:プロパティ
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 50.0, height: 50.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    //MARK: Intialization: 初期化
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("スタート済み")
        setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
        
    }
    
    //MARK: Private Methods(クラス内のみのメゾット)
    private func setupButtons(){
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        
        print("入力された値:" + String(starCount))
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        for i in 0..<starCount {
            //ボタン作成
            let button = UIButton()
            //button.backgroundColor = UIColor.red
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            
            //制約を追加
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            
            // ボタンのアクションをセットアップ
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //stackにボタンを追加
            addArrangedSubview(button)
            
            //レーティングボタンの列に追加
            ratingButtons.append(button)
            
            //
            button.accessibilityLabel = "星を\(starCount)個にする"
            
            //print("ボタンを作成済み:\(i + 1)個")
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            
            let hintString: String?
            if rating == index + 1{
                hintString = "レーティングをリセットするにはタップしてください"
            }else{
                hintString = nil
            }
            let valueString: String
            switch rating {
            case 0:
                valueString = "まだ設定されていません"
            default:
                valueString = "\(rating)個の星が設定されています"
            }
        }
    }
    
    //MARK: Button Action
    @objc func ratingButtonTapped(button: UIButton) {
        
        print("Buttonが押されました")
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("OH NO!")
            
        }
        
        let selectedRating = index + 1
        if selectedRating == rating{
            rating = 0
        } else {
            rating = selectedRating
        }
        
    }
    
}
