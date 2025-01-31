//
//  CategoryHeaderViewCollectionReusableView.swift
//  Clokey
//
//  Created by 한태빈 on 1/21/25.
//

import UIKit
import SnapKit

class CategoryHeaderView: UICollectionReusableView {
    static let identifier = "CategoryHeaderView"

    private let CategoryLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(CategoryLabel)
        CategoryLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20) // 여백 조정
        }
    }

    func configure(with title: String) {
        CategoryLabel.text = title
    }
}

