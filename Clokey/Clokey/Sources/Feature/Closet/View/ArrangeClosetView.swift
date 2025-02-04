import UIKit
import SnapKit
import Then

class ArrangeClosetView: UIView {

    // 헤더 영역
    let headerView = UIView().then {
        $0.backgroundColor = .white
    }

    let backButton = UIButton().then {
        $0.setImage(UIImage(named: "back_icon"), for: .normal)
        $0.tintColor = UIColor(named: "mainBrown800")
    }

    let titleLabel = UILabel().then {
        $0.text = "정리할 옷"
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 20)
        $0.textColor = .black
    }
    
    // 배너 영역
    let BannerView = UIView().then {
        $0.backgroundColor = UIColor(named: "mainBrown200")
    }
    
    let bannerImage = UIImageView().then {
        $0.image = UIImage(named: "bannerimage2")
        $0.contentMode = .scaleAspectFit
    }
    
    let bannerDescription = UILabel().then {
        $0.text = "겨울 옷을 정리할 시간입니다!\nOO님의 겨울 옷들을 보여드릴게요."
        $0.font = UIFont.ptdMediumFont(ofSize: 16)
        $0.textColor = .black
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    // 세그먼트 컨트롤 (카테고리 필터)
    let customTotalSegmentView = CustomTotalSegmentView(items: ["전체", "상의", "하의", "아우터", "기타"])
    
    // 컬렉션 뷰 (옷 목록)
    let closetCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 111, height: 167)
        $0.minimumInteritemSpacing = 10
        $0.minimumLineSpacing = 20
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false // 스크롤뷰 내에서 개별 스크롤 방지
        $0.register(ClosetCollectionViewCell.self, forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier)
    }

    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)
        
        addSubview(BannerView)
        BannerView.addSubview(bannerImage)
        BannerView.addSubview(bannerDescription)
        
        addSubview(customTotalSegmentView)
        addSubview(closetCollectionView)
    }

    private func setupLayout() {
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(45)
        }

        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 24, height: 24))
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(backButton.snp.trailing).offset(15)
        }

        BannerView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(72)
            make.width.equalTo(353)//
        }

        bannerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 70, height: 70))
        }

        bannerDescription.snp.makeConstraints { make in
            make.top.edges.equalTo(BannerView.snp.bottom).offset(16)
            make.leading.equalTo(bannerImage.snp.trailing).offset(16)
        }

        customTotalSegmentView.snp.makeConstraints { make in
            make.top.equalTo(BannerView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(90)
        }

        closetCollectionView.snp.makeConstraints { make in
            make.top.equalTo(customTotalSegmentView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(354)
        }
    }
}
