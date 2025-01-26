import UIKit
import SnapKit
import Then

//얘는 관련 내용이 이거밖에 없는 거 같은데 segmentintegrationView에서 저 segment 구체적인 내용을 여기서 초기화(?)해줘야하더라구용
final class ClosetView: UIView {
    // MARK: - UI Components
    let segmentIntegrationView = SegmentIntegrationView(items: ["전체", "상의", "하의", "아우터", "기타"])//이거!
    
    
    let closetCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
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
    
    // MARK: - Setup UI and Constraints
    private func setupUI() {
        backgroundColor = .white
        addSubview(segmentIntegrationView)
        addSubview(closetCollectionView)
        addSubview(seeAllButton)
        addSubview(bannerView)
        addSubview(bannerImage)
        addSubview(bannerTitle)
        addSubview(bennerDescription)
        addSubview(bannerButton)
    }
    
    private func setupConstraints() {
        segmentIntegrationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(34)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(90)
        }
        closetCollectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentIntegrationView.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(228)
        }
        seeAllButton.snp.makeConstraints { make in
            make.top.equalTo(closetCollectionView.snp.bottom).offset(8)
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
            make.width.height.equalTo(70)
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

