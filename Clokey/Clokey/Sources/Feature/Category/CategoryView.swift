

import UIKit
import SnapKit
import Then

class CategoryView: UIView {

    // MARK: - UI Components
    let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    let contentView = UIView()
    
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
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let summerLabel = UILabel().then {
        $0.text = "여름"
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let autumnLabel = UILabel().then {
        $0.text = "가을"
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = .black
    }
    
    let winterLabel = UILabel().then {
        $0.text = "겨울"
        $0.font = UIFont.ptdRegularFont(ofSize: 16)
        $0.textColor = .black
    }
    

    // CollectionView for 카테고리버튼
    let categoryCollectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
            $0.backgroundColor = .clear
            $0.showsVerticalScrollIndicator = false
            $0.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CategoryHeaderView.identifier)
            $0.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        }
    }()


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
        backgroundColor = .white
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)
        contentView.addSubview(springImageView)
        contentView.addSubview(summerImageView)
        contentView.addSubview(autumnImageView)
        contentView.addSubview(winterImageView)
        contentView.addSubview(springLabel)
        contentView.addSubview(summerLabel)
        contentView.addSubview(autumnLabel)
        contentView.addSubview(winterLabel)
        contentView.addSubview(categoryCollectionView)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview() // 가로 스크롤 막기 위해 width 고정
        }
        
        // Header View
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(61)
            make.height.equalTo(45)
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
            make.centerY.equalToSuperview()
        }

        // Season Button
        springImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(37)
            make.height.width.equalTo(57)
        }
        
        summerImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalTo(springImageView.snp.trailing).offset(27)
            make.height.width.equalTo(57)
        }
        
        autumnImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalTo(summerImageView.snp.trailing).offset(27)
            make.height.width.equalTo(57)
        }
        
        winterImageView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(29)
            make.leading.equalTo(autumnImageView.snp.trailing).offset(27)
            make.height.width.equalTo(57)
        }
        
        springLabel.snp.makeConstraints { make in
            make.top.equalTo(springImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(61)
        }
        
        summerLabel.snp.makeConstraints { make in
            make.top.equalTo(summerImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(140)
        }
        
        autumnLabel.snp.makeConstraints { make in
            make.top.equalTo(autumnImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(226)
        }
        
        winterLabel.snp.makeConstraints { make in
            make.top.equalTo(winterImageView.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(312)
        }

        // Category CollectionView
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(summerLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().inset(20)  // 🔥 leading은 유지
            make.trailing.lessThanOrEqualToSuperview().offset(-20) // 🔥 최대한 오른쪽 정렬
            make.width.greaterThanOrEqualTo(200) // 🔥 최소 width 보장 (뷰가 사라지는 걸 방지)
            make.height.equalTo(500)
            make.bottom.equalToSuperview().offset(-20)
        }


    }
    
//    func updateCollectionViewHeight() {
//        // `UICollectionView`의 콘텐츠 높이를 계산하여 업데이트
//        categoryCollectionView.snp.updateConstraints { make in
//            make.height.equalTo(categoryCollectionView.collectionViewLayout.collectionViewContentSize.height)
//        }
//    }
}

