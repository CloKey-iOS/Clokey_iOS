

import UIKit
import SnapKit
import Then

class CategoryView: UIView {

    // MARK: - UI Components
    let headerView = UIView().then {
        $0.backgroundColor = .white
    }

    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "back_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
    }

    let titleLabel = UILabel().then {
        $0.text = "카테고리"
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 20)
        $0.textColor = .black
    }

    // CollectionView for 봄/여름/가을/겨울
    let springImageView = UIImageView().then{
        $0.image = UIImage(named: "spring")
        $0.contentMode = .scaleAspectFit
    }
    
    let summerImageView = UIImageView().then{
        $0.image = UIImage(named: "summer")
        $0.contentMode = .scaleAspectFit
    }
    
    let autumnImageView = UIImageView().then{
        $0.image = UIImage(named: "autumn")
        $0.contentMode = .scaleAspectFit
    }
    
    let winterImageView = UIImageView().then{
        $0.image = UIImage(named: "winter")
        $0.contentMode = .scaleAspectFit
    }
    
    let springLabel = UILabel().then {
        $0.text = "봄"
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = .black
    }
    
    let summerLabel = UILabel().then {
        $0.text = "여름"
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = .black
    }
    
    let autumnLabel = UILabel().then {
        $0.text = "가을"
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = .black
    }
    
    let winterLabel = UILabel().then {
        $0.text = "겨울"
        $0.font = UIFont.ptdRegularFont(ofSize: 12)
        $0.textColor = .black
    }
    

    // CollectionView for 카테고리버튼
    let CategoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical // 세로 스크롤 설정
        $0.minimumLineSpacing = 10
        $0.minimumInteritemSpacing = 10
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize // 셀 크기 자동 계산
    }).then {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = true
        //상의, 하의, 아우터, 기타 카테고리의 제목에 해당하는 CollectionView
        $0.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderView.identifier)
        //상의 카테고리라면 티셔츠, 니트/스웨터, 맨투맨 해당하는 CollectionView
        $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
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
        addSubview(springImageView)
        addSubview(summerImageView)
        addSubview(autumnImageView)
        addSubview(winterImageView)
        addSubview(springLabel)
        addSubview(summerLabel)
        addSubview(autumnLabel)
        addSubview(winterLabel)
        addSubview(CategoryCollectionView)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        // Header View
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68) // Safe area 고려
            make.height.equalTo(26)
            make.leading.trailing.equalToSuperview()
        }
        
        //뒤로가기 버튼
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        
        //"카테고리"
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(59)
        }

        // Season Button
        springImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalTo(springImageView).offset(27)
            make.height.width.equalTo(57)
        }
        
        summerImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalTo(summerImageView).offset(27)
            make.height.width.equalTo(57)
        }
        
        autumnImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalTo(autumnImageView).offset(27)
            make.height.width.equalTo(57)
        }
        
        winterImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalToSuperview().offset(39)
            make.height.width.equalTo(57)
        }
        
        springLabel.snp.makeConstraints { make in
            make.top.equalTo(summerImageView).offset(4)
            make.leading.equalToSuperview().offset(61)
        }
        
        springLabel.snp.makeConstraints { make in
            make.top.equalTo(summerImageView).offset(4)
            make.leading.equalToSuperview().offset(61)
        }
        
        summerLabel.snp.makeConstraints { make in
            make.top.equalTo(summerImageView).offset(4)
            make.leading.equalToSuperview().offset(140)
        }
        
        autumnLabel.snp.makeConstraints { make in
            make.top.equalTo(summerImageView).offset(4)
            make.leading.equalToSuperview().offset(226)
        }
        
        winterLabel.snp.makeConstraints { make in
            make.top.equalTo(summerImageView).offset(4)
            make.leading.equalToSuperview().offset(312)
        }

        // Category CollectionView
        CategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(summerLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func updateCollectionViewHeight() {
        // `UICollectionView`의 콘텐츠 높이를 계산하여 업데이트
        CategoryCollectionView.snp.updateConstraints { make in
            make.height.equalTo(CategoryCollectionView.collectionViewLayout.collectionViewContentSize.height)
        }
    }
}

