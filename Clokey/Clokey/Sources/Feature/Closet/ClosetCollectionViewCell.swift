//
//  ClosetCollectionViewCell.swift
//  Clokey
//
//  Created by 한태빈 on 1/19/25.
//

import UIKit

class ClosetCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ClosetCollectionViewCell"
    
    let productImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
    }
    
    let numberLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        $0.textColor = .white
        $0.backgroundColor = UIColor.brown
        $0.textAlignment = .center
        $0.clipsToBounds = true
    }
    
    let countLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
        $0.backgroundColor = UIColor.brown
        $0.textAlignment = .center
        $0.clipsToBounds = true
        
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setupViews() {
        // 셀의 콘텐츠 뷰에 추가
        contentView.addSubview(productImageView)
        contentView.addSubview(numberLabel)
        contentView.addSubview(countLabel)
        
        // Auto Layout 설정
        productImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(108)
            make.width.equalTo(80)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.top).offset(6)
            make.leading.equalTo(productImageView)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        countLabel.snp.makeConstraints {make in
            make.top.equalTo(productImageView.snp.top).offset(84)
            make.centerX.equalTo(productImageView)
            make.width.equalTo(31)
            make.height.equalTo(17)
            
        }
        
        
    }
}
