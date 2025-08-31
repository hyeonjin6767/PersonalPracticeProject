//
//  ThirdCollectionViewCell.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ThirdCollectionViewCell"
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13)
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
