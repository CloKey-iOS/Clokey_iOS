import Foundation
import UIKit
import SnapKit
import Then

final class ClosetView: UIView {
    // MARK: - UI Components
    
    let menuButton = UIButton().then {
        $0.setImage(UIImage(named: "line3_icon"), for: .normal)
        $0.tintColor = .black
        $0.imageView?.contentMode = .scaleAspectFit
    }

    let segmentedControl = UISegmentedControl(items: ["전체", "상의", "하의", "아우터", "기타"]).then {
        $0.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .selected, barMetrics: .default)
        $0.setBackgroundImage(UIImage(), for: .highlighted, barMetrics: .default)
        $0.setDividerImage(UIImage(), forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        $0.selectedSegmentIndex = 0
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .light)
        ], for: .normal)
        $0.setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)
        ], for: .selected)
    }

    let divideLine = UIView().then {
        $0.backgroundColor = .lightGray
    }

    let indicatorBar = UIView().then {
        $0.backgroundColor = .brown
    }
    
    let ClosetCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
        $0.estimatedItemSize = .init(width: 80, height: 108)
        $0.minimumInteritemSpacing = 11
        $0.minimumLineSpacing = 12
    }).then {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.register(ClosetCollectionViewCell.self, forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier)
    }
 
    let seeAllButton = UIButton().then {
        $0.setTitle("전체보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
  
    
    let bannerView = UIView().then {
            $0.backgroundColor = UIColor(named: "pointOrange400")
            $0.layer.cornerRadius = 20
            $0.layer.masksToBounds = true
        }

    let bannerImage = UIImageView().then {
            $0.image = UIImage(named: "bannerimage")
            $0.contentMode = .scaleAspectFit
        }

    let bannerTitle = UILabel().then {
            $0.text = "이번 주 최다 착용 아이템은?"
            $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.textColor = UIColor(named: "pointOrange800")
        }

    let bennerDescription = UILabel().then {
            $0.text = "효율적인 옷장 관리를 위한 스마트 요약!"
            $0.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            $0.textColor = .black
        }

    let bannerButton = UIButton().then {
            $0.setTitle("스마트 요약 확인하기", for: .normal)
            $0.backgroundColor = UIColor(named: "pointOrange800")
            $0.setTitleColor(.white, for: .normal)
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            $0.layer.cornerRadius = 14
            $0.layer.masksToBounds = true
        }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .white
        addSubview(menuButton)
        addSubview(segmentedControl)
        addSubview(divideLine)
        addSubview(indicatorBar)
        addSubview(ClosetCollectionView)
        addSubview(seeAllButton)
        addSubview(bannerView)
        addSubview(bannerImage)
        addSubview(bannerTitle)
        addSubview(bennerDescription)
        addSubview(bannerButton)
    }

    private func setupConstraints() {
        
        menuButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(34)
            make.height.width.equalTo(24)
        }
        segmentedControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.leading.equalToSuperview().offset(60)
            make.height.equalTo(30)
        }

        divideLine.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(1)
            make.leading.equalTo(segmentedControl).offset(39)
            make.height.equalTo(1)
        }

        indicatorBar.snp.makeConstraints { make in
            make.bottom.equalTo(divideLine.snp.top)
            make.width.equalTo(39) // 고정된 너비
            make.height.equalTo(3)
            make.leading.equalTo(segmentedControl.snp.leading).offset(19)
        }
        
        ClosetCollectionView.snp.makeConstraints { make in
            make.top.equalTo(divideLine.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(228)
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.top.equalTo(ClosetCollectionView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(22)
        }
        
        
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(seeAllButton.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(95)
        }
        
        bannerImage.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.top).offset(13)
            make.leading.equalTo(bannerView.snp.leading).offset(20)
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
        
        bannerTitle.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.top).offset(14)
            make.leading.equalTo(bannerView.snp.leading).offset(99)
            
        }
        
        bennerDescription.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.top).offset(36)
            make.leading.equalTo(bannerView.snp.leading).offset(99)
        }
        
        bannerButton.snp.makeConstraints { make in
            make.top.equalTo(bannerView.snp.top).offset(61)
            make.leading.equalTo(bannerView.snp.leading).offset(94)
            make.width.equalTo(114)
            make.height.equalTo(19)
        }
    }
}
