import UIKit
import SnapKit
import Then

final class ClosetView: UIView {
    // MARK: - UI Components
    let segmentIntegrationView = SegmentIntegrationView(items: ["전체", "상의", "하의", "아우터", "기타"])

    let closetCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 111, height: 167)
        $0.minimumInteritemSpacing = 10
        $0.minimumLineSpacing = 20
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(ClosetCollectionViewCell.self, forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier)
    }

    let seeAllButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.ptdRegularFont(ofSize: 12)
    }

    // 🔹 배너를 담을 ScrollView 추가 (사용자가 직접 넘기는 방식)
    let bannerScrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.bounces = true
        $0.isScrollEnabled = true
    }

    private let bannerStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .fillEqually
    }

    let pageControl = UIPageControl().then {
        $0.numberOfPages = 2
        $0.currentPage = 0
        $0.pageIndicatorTintColor = .lightGray
        $0.currentPageIndicatorTintColor = UIColor(named: "pointOrange800")
    }

    let drawerTitle = UILabel().then {
        $0.text = "서랍"
        $0.font = UIFont.ptdSemiBoldFont(ofSize: 20)
        $0.textColor = .black
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        bannerScrollView.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI and Constraints
    private func setupUI() {
        backgroundColor = .white
        addSubview(segmentIntegrationView)
        addSubview(bannerScrollView)
        addSubview(pageControl)
        addSubview(closetCollectionView)
        addSubview(seeAllButton)
        addSubview(drawerTitle)

        // 배너 추가
        bannerScrollView.addSubview(bannerStackView)
        let banner1 = ArrangeClosetBannerView()
        let banner2 = SmartSummationBannerView()
        bannerStackView.addArrangedSubview(banner1)
        bannerStackView.addArrangedSubview(banner2)
    }

    private func setupConstraints() {
        segmentIntegrationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(90)
        }
        
        closetCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentIntegrationView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(354)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.top.equalTo(closetCollectionView.snp.bottom).offset(15)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(22)
        }
        
        bannerScrollView.snp.makeConstraints { make in
            make.top.equalTo(closetCollectionView.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(105) // banner기준 상하 5pt더 줌
        }

        bannerStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(95)
            make.width.equalToSuperview().multipliedBy(2) // 배너 2개라서 x2
        }

        pageControl.snp.makeConstraints { make in
            make.top.equalTo(bannerScrollView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }


        drawerTitle.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(22)
            make.leading.equalToSuperview().offset(20)
        }
    }
}

extension ClosetView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = pageIndex
    }
}
