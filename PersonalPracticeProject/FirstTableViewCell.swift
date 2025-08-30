//
//  FirstTableViewCell.swift
//  PersonalPracticeProject
//
//  Created by 박현진 on 8/30/25.
//

import UIKit

class FirstTableViewCell: UITableViewCell {

    static let identifier = "FirstTableViewCell"
   
    let anythingLabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
