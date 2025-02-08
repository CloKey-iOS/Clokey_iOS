import UIKit

class DisplayAllViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private let displayAllView = DisplayAllView()
    private var products: [ClosetModel] = []
    private var backgroundView: UIView? // 배경 어둡게 하기 위한 뷰
    
    // MARK: - Lifecycle
    override func loadView() {
        view = displayAllView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupActions()
        loadInitialData()
        setupSegmentedControl()
    }
    
    // 카테고리 View로 넘어가기 위함
    private func setupActions() {
        displayAllView.customTotalSegmentView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func menuButtonTapped() {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
        categoryVC.modalTransitionStyle = .coverVertical
        present(categoryVC, animated: true, completion: nil)
    }
    
    // 레이아웃 변경 시 indicator bar 위치 업데이트
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let initialIndex = displayAllView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        displayAllView.customTotalSegmentView.updateIndicatorPosition(for: initialIndex)
    }

    // MARK: - UI 설정 (네비게이션 바)
    private func setupUI() {
        // 상환이형ㅈ tagclothViewcontroller 참고
        let navBarManager = NavigationBarManager()
        navBarManager.addBackButton(
            to: navigationItem,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navBarManager.setTitle(
            to: navigationItem,
            title: "내 옷장",
            font: .ptdBoldFont(ofSize: 20),
            textColor: .black
        )
    }
    
    // MARK: - CollectionView 설정
    private func setupCollectionView() {
        displayAllView.collectionView.dataSource = self
        displayAllView.collectionView.delegate = self
        displayAllView.collectionView.register(
            ClosetCollectionViewCell.self,
            forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier
        )
    }
    
    // MARK: - Segment Control 설정
    private func setupSegmentedControl() {
        displayAllView.customTotalSegmentView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }

    // MARK: - Segment 변경 시 처리
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        displayAllView.customTotalSegmentView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }
    
    // MARK: - 데이터 로드
    private func loadInitialData() {
        let initialIndex = displayAllView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    // Segment 변경 시 데이터 업데이트
    private func updateContent(for index: Int) {
        products = ClosetModel.getDummyData(for: index)

        if index == 0 {
            // ✅ "전체" 선택 시 카테고리 버튼 숨김
            displayAllView.customTotalSegmentView.toggleCategoryButtons(isHidden: true)
            
            displayAllView.contentView.snp.remakeConstraints {
                $0.top.equalTo(displayAllView.customTotalSegmentView.divideLine.snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        } else if let category = CustomCategoryModel.getCategories(for: index) {
            // ✅ 카테고리 데이터를 가져와 UI 업데이트
            displayAllView.customTotalSegmentView.toggleCategoryButtons(isHidden: false)
            displayAllView.customTotalSegmentView.updateCategories(for: category.buttons)
            
            displayAllView.contentView.snp.remakeConstraints {
                $0.top.equalTo(displayAllView.customTotalSegmentView.categoryScrollView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        }

        displayAllView.collectionView.reloadData()
    }

    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ClosetCollectionViewCell.identifier,
            for: indexPath
        ) as? ClosetCollectionViewCell else {
            fatalError("Unable to dequeue ClosetCollectionViewCell")
        }
        let product = products[indexPath.item]
        cell.productImageView.image = product.image
        cell.numberLabel.text = product.number
        cell.countLabel.text = product.count
        cell.nameLabel.text = product.name
        return cell
    }

    // MARK: - CollectionView Delegate (팝업 표시)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showPopUpView(for: products[indexPath.item])
    }
    
    // MARK: - PopUpView 관련 코드
    private func showPopUpView(for product: ClosetModel) {
        guard let keyWindow = UIApplication.shared.connectedScenes
                    .compactMap({ ($0 as? UIWindowScene)?.windows.first })
                    .first else { return }

        // ✅ 배경 뷰 추가 (어둡게)
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.alpha = 0
        keyWindow.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundView = bgView
        
        // ✅ PopUpView 추가
        let popUpView = TouchPopupView()
        popUpView.alpha = 0
        keyWindow.addSubview(popUpView)
        popUpView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(290)
            make.height.equalTo(448)
        }

        // ✅ 애니메이션 효과
        UIView.animate(withDuration: 0.3) {
            bgView.alpha = 1
            popUpView.alpha = 1
        }

        // ✅ closeButton 클릭 시 팝업 닫기 기능 추가
        popUpView.closeButton.addTarget(self, action: #selector(dismissPopUpView), for: .touchUpInside)
    }

    // MARK: - PopUpView 닫기
    @objc private func dismissPopUpView() {
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.windows.first })
            .first else { return }

        // ✅ keyWindow에서 PopUpView 찾기
        if let popUpView = keyWindow.subviews.first(where: { $0 is TouchPopupView }) {
            UIView.animate(withDuration: 0.3, animations: {
                self.backgroundView?.alpha = 0
                popUpView.alpha = 0
            }) { _ in
                self.backgroundView?.removeFromSuperview()
                popUpView.removeFromSuperview()
                self.backgroundView = nil
            }
        }
    }

    // MARK: - 네비게이션 뒤로 가기
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
