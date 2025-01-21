//
//  CategoryView.swift
//  Clokey
//
//  Created by 한태빈 on 1/21/25.
//

/*
import UIKit
import SnapKit
import Then

class CategoryView: UIView {

    // MARK: - UI Components

    // Header View (카테고리 제목과 뒤로가기 버튼)
    let headerView = UIView().then {
        $0.backgroundColor = .white
    }

    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "back_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
    }

    let titleLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .black
    }

    // CollectionView for 봄/여름/가을/겨울
    let seasonCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 61, height: 87) // 이미지 + 텍스트
        $0.minimumInteritemSpacing = 25
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(CatrgoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }

    // TableView for 상의/하의/아우터/기타 ㅜㅜㅜㅜㅜㅜㅜㅜ
    let categoryTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI

    private func setupUI() {
        // Add subviews
        addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)
        addSubview(seasonCollectionView)
        addSubview(categoryTableView)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        // Header View
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68) // Safe area 고려
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(59)
            make.centerY.equalToSuperview()
        }

        // Season CollectionView
        seasonCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(87)
        }

        // Category TableView
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(seasonCollectionView.snp.bottom).offset(16)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
 */
