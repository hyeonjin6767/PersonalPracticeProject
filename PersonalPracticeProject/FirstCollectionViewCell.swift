//
//  FirstCollectionViewCell.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FirstCollectionViewCell"
    
    let anythingLabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        
        contentView.addSubview(anythingLabel)
        
        anythingLabel.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
    }
}
