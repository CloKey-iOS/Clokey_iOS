
/*
import UIKit
import SnapKit
import Then

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"
    
    let CategoryButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        config.baseForegroundColor = .black
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 14, bottom: 5, trailing: 14) // 내부 여백
        
        $0.configuration = config
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(named: "mainBrown600")!.cgColor
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(CategoryButton)
        CategoryButton.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20) // 셀의 크기에 따라 버튼 크기 조정
        }
    }
    
    func configure(with title: String) {
        CategoryButton.setTitle(title, for: .normal)
        CategoryButton.sizeToFit() // 텍스트 길이에 따라 너비 조정
        CategoryButton.snp.updateConstraints { make in
            make.height.equalTo(32) // 고정 높이
        }
    }
}
*/
