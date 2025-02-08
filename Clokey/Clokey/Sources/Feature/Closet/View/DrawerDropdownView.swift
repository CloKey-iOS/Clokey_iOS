//
//  DrawerDropdownView.swift
//  Clokey
//
//  Created by 한태빈 on 2/8/25.
//

import UIKit
import SnapKit
import Then

class DrawerDropdownView: UIView, UITableViewDataSource, UITableViewDelegate{
    
    // 옵션 버튼 목록
    private let options = ["추가하기", "삭제하기"]
    
    // 테이블 뷰
    private let tableView = UITableView().then {
        $0.register(DrawerDropdownCell.self, forCellReuseIdentifier: "DrawerDropdownCell")
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.rowHeight = 44
        $0.estimatedRowHeight = 44
    }
    
    // 버튼 클릭 시 동작할 핸들러
    var didSelectOption: ((String) -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 5
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DrawerDropdownCell", for: indexPath) as! DrawerDropdownCell
        cell.configure(with: options[indexPath.row], isLast: indexPath.row == options.count - 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectOption?(options[indexPath.row])
    }
}

// MARK: - Dropdown Cell
class DrawerDropdownCell: UITableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    
    private let iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let separatorView = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .white
        selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        
        iconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func configure(with title: String, isLast: Bool) {
        titleLabel.text = title
        iconImageView.image = title == "추가하기" ? UIImage(systemName: "plus") : UIImage(systemName: "trash")
        iconImageView.tintColor = UIColor.mainBrown800
        separatorView.isHidden = isLast
    }
}
