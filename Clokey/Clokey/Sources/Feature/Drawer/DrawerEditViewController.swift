import UIKit
import SnapKit

// MARK: - Protocol
protocol DrawerEditViewControllerDelegate: AnyObject {
    func didSelectTags(_ tags: [(image: UIImage, title: String)])
}

// MARK: - DrawerEditViewController
class DrawerEditViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Types
    
    // 정렬 옵션 (중요)
    private enum SortOption: String {
        case wear = "WEAR"
        case notWear = "NOT_WEAR"
        case latest = "LATEST"
        case oldest = "OLDEST"
        
        static func from(_ text: String) -> SortOption {
            switch text {
            case "착용순": return .wear
            case "미착용순": return .notWear
            case "최신등록순": return .latest
            case "오래된순": return .oldest
            default: return .wear
            }
        }
    }
    
    // MARK: - Properties
    
    // 델리게이트
    weak var delegate: DrawerEditViewControllerDelegate?
    
    // 선택된 아이템 배열
    private var selectedItems: [(image: UIImage, title: String)] = [] {
        didSet {
            updateCompleteButtonState() // 선택/해제에 따라 확인 버튼 상태 업데이트
        }
    }
    
    // 정렬 옵션
    private var currentSort: SortOption = .wear
    
    // DrawerEditView (커스텀 뷰)
    private let drawerEditView = DrawerEditView()
    
    // 화면에 표시할 제품 데이터 (ClosetModel은 이미 정의되어 있다고 가정)
    private var products: [ClosetModel] = []
    
    // 확인 버튼 (선택된 아이템을 delegate로 전달)
    private lazy var completeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeButtonTapped))
        button.isEnabled = false // 초기에는 비활성화
        button.tintColor = .clear
        return button
    }()
    
    @objc private func completeButtonTapped() {
        let selectedData = selectedItems.map { (image: $0.image, title: $0.title) }
        delegate?.didSelectTags(selectedData)
        dismiss(animated: true)
        
        let drawerInfoVC = DrawerInfoViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(drawerInfoVC, animated: true)
        } else {
            print("❌ DrawerInfoViewController가 네비게이션 컨트롤러 안에 없음")
        }
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = drawerEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadDummyData()      // 더미 데이터 로드 (실제 프로젝트에서는 API 호출 등)
        setupActions()
        loadInitialData()
        setupSegmentedControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 세그먼트 컨트롤 indicator 위치 업데이트
        let initialIndex = drawerEditView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        drawerEditView.customTotalSegmentView.updateIndicatorPosition(for: initialIndex)
    }
    
    // MARK: - Setup Methods
    
    /// 네비게이션 바 및 타이틀 설정
    private func setupUI() {
        navigationItem.rightBarButtonItem = completeButton
        
        let navBarManager = NavigationBarManager() // 이미 구현된 네비게이션 바 관리 클래스
        navBarManager.addBackButton(
            to: navigationItem,
            target: self,
            action: #selector(backButtonTapped)
        )
        navBarManager.setTitle(
            to: navigationItem,
            title: "아이템 선택하기",
            font: .ptdBoldFont(ofSize: 20),
            textColor: .black
        )
    }
    
    /// CollectionView 설정
    private func setupCollectionView() {
        drawerEditView.collectionView.dataSource = self
        drawerEditView.collectionView.delegate = self
        drawerEditView.collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.identifier
        )
        drawerEditView.collectionView.allowsMultipleSelection = true
    }
    
    /// 세그먼트 컨트롤 이벤트 등록
    private func setupSegmentedControl() {
        drawerEditView.customTotalSegmentView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }
    
    /// 메뉴 버튼 액션 설정 (카테고리 화면 전환)
    private func setupActions() {
        drawerEditView.customTotalSegmentView.menuButton.addTarget(
            self,
            action: #selector(menuButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func menuButtonTapped() {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
        categoryVC.modalTransitionStyle = .coverVertical
        present(categoryVC, animated: true, completion: nil)
    }
    
    // MARK: - Data Handling
    
    /// 더미 데이터 로드 (실제 프로젝트에서는 API 호출 등으로 대체)
    private func loadDummyData() {
        products = ClosetModel.getDummyData(for: 0)
        drawerEditView.collectionView.reloadData()
    }
    
    /// 초기 데이터 로드
    private func loadInitialData() {
        let initialIndex = drawerEditView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    /// 세그먼트 변경 시 데이터 및 UI 업데이트
    private func updateContent(for index: Int) {
        products = ClosetModel.getDummyData(for: index)
        
        if index == 0 {
            // 전체 선택 시 카테고리 버튼 숨김
            drawerEditView.customTotalSegmentView.toggleCategoryButtons(isHidden: true)
            drawerEditView.contentView.snp.remakeConstraints { make in
                make.top.equalTo(drawerEditView.customTotalSegmentView.divideLine.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview().inset(20)
                make.bottom.equalToSuperview()
            }
        } else if let category = CustomCategoryModel.getCategories(for: index) {
            // 특정 카테고리 선택 시 카테고리 버튼 보이기 및 업데이트
            drawerEditView.customTotalSegmentView.toggleCategoryButtons(isHidden: false)
            drawerEditView.customTotalSegmentView.updateCategories(for: category.buttons)
            drawerEditView.contentView.snp.remakeConstraints { make in
                make.top.equalTo(drawerEditView.customTotalSegmentView.categoryScrollView.snp.bottom)
                make.leading.trailing.equalToSuperview().inset(20)
                make.bottom.equalToSuperview()
            }
        }
        
        drawerEditView.collectionView.reloadData()
        
        // 기존에 선택된 아이템이 있으면 복원
        for (index, product) in products.enumerated() {
            if selectedItems.contains(where: { $0.title == product.name }) {
                let indexPath = IndexPath(item: index, section: 0)
                drawerEditView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            }
        }
    }
    
    // MARK: - Button State
    /// 선택된 아이템이 없으면 확인 버튼 비활성화, 있으면 활성화
    private func updateCompleteButtonState() {
        completeButton.isEnabled = !selectedItems.isEmpty
        completeButton.tintColor = selectedItems.isEmpty ? .clear : UIColor(named: "pointOrange800")
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.identifier,
            for: indexPath
        ) as? CustomCollectionViewCell else {
            fatalError("Unable to dequeue CustomCollectionViewCell")
        }
        
        let product = products[indexPath.item]
        cell.productImageView.image = product.image
        cell.numberLabel.text = product.number
        cell.countLabel.text = product.count
        cell.nameLabel.text = product.name
        
        // **중요: 선택 가능하도록 설정**
        cell.isSelectable = true
        
        // 현재 선택된 상태에 따라 셀 UI 업데이트
        let isSelected = selectedItems.contains(where: { $0.title == product.name })
        cell.setSelected(isSelected)
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleItemSelection(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        handleItemDeselection(at: indexPath)
    }
    
    // 선택한 셀을 선택 상태로 변경하고, selectedItems 배열에 추가
    private func handleItemSelection(at indexPath: IndexPath) {
        guard let cell = drawerEditView.collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        let product = products[indexPath.item]
        cell.setSelected(true)
        if let currentImage = cell.productImageView.image {
            selectedItems.append((image: product.image, title: product.name))
        }
    }
    
    // 선택한 셀의 선택 상태를 해제하고, selectedItems 배열에서 제거
    private func handleItemDeselection(at indexPath: IndexPath) {
        guard let cell = drawerEditView.collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell else { return }
        let product = products[indexPath.item]
        cell.setSelected(false)
        selectedItems.removeAll { $0.title == product.name }
    }
    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        drawerEditView.customTotalSegmentView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }
}
