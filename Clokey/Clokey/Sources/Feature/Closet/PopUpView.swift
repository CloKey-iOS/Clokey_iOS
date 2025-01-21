//
//  PopUpView.swift
//  Clokey
//
//  Created by 한태빈 on 1/21/25.
//
/*
import UIKit
import SnapKit
import Then

class PopupView: UIView {

    // MARK: - UI Components
    let dateLabel = UILabel().then {
        $0.text = "2025.01.18 (SAT)"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .black
    }

    let closeButton = UIButton().then {
        $0.setImage(UIImage(named: "erase_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
    }

    let imageView = UIImageView().then {
        $0.image = UIImage(named: "top")
        $0.contentMode = .scaleAspectFit
    }

    let descriptionLabel = UILabel().then {
        $0.text = """
        후드티   봄  가능
        지금까지 총 n회 착용
        공개범위   공개
        브랜드 : 나이키
        url :
        """
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    let optionButton = UIButton().then {
        $0.setImage(UIImage(named: "dot3_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
    }

    let leftArrowButton = UIButton().then {
        $0.setImage(UIImage(named: "left_circle_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
    }

    let rightArrowButton = UIButton().then {
        $0.setImage(UIImage(named: "left_circle_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
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
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(dateLabel)
        addSubview(closeButton)
        addSubview(optionButton)
        addSubview(imageView)
        addSubview(descriptionLabel)
        addSubview(leftArrowButton)
        addSubview(rightArrowButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(21)
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(23)
        }
        
        optionButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(75)
            make.trailing.equalToSuperview().offset(-23)
            make.size.equalTo(24)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(29)
            make.centerX.equalToSuperview()
            make.width.equalTo(140)
            make.height.equalTo(167)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }

        leftArrowButton.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(104)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(18)//이거 18로 할ㄱ지 24로 할지
        }

        rightArrowButton.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(18)
        }
    }
}

*/
