//
//  DrawerViewController.swift
//  Clokey
//
//  Created by 한태빈 on 2/8/25.
//

import UIKit

// MARK: - Protocol
// 태그된 아이템을 선택했을 때 델리게이트를 통해 전달하는 프로토콜
protocol DrawerEditViewControllerDelegate: AnyObject {
    func didSelectTags(_ tags: [(image: UIImage, title: String)])
}

class DrawerEditViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Properties
    weak var delegate: DrawerEditViewControllerDelegate?
    
    // 선택된 옷(아이템) 저장 배열
    private var selectedItems: [(image: UIImage, title: String)] = [] {
        didSet {
            updateConfirmButtonState()
        }
    }
    
    private let drawerEditView = DrawerEditView()
    // 화면에 표시할 옷(제품) 데이터
    private var products: [ClosetModel] = []
    
    // 확인 버튼 (선택된 아이템을 delegate로 넘김)
    private lazy var completeButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completeButtonTapped))
        button.isEnabled = false // 초기에는 비활성화
        button.tintColor = .clear
        return button
    }()
    
    // MARK: - Lifecycle
    override func loadView() {
        view = drawerEditView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        loadDummyData() // (필요하다면 더미 데이터 로드)
        setupActions()
        loadInitialData()
        setupSegmentedControl()
    }
    
    // MARK: - Setup Methods
    
    /// 메뉴 버튼을 누르면 카테고리 화면으로 전환하기 위한 액션 등록
    private func setupActions() {
        drawerEditView.customTotalSegmentView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
    }
    
    @objc private func menuButtonTapped() {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
        categoryVC.modalTransitionStyle = .coverVertical
        present(categoryVC, animated: true, completion: nil)
    }
    
    @objc private func completeButtonTapped() {
        let drawerInfoVC = DrawerInfoViewController()

        if let navigationController = self.navigationController {
            navigationController.pushViewController(drawerInfoVC, animated: true)
        } else {
            print("❌ DrawerInfoViewController가 네비게이션 컨트롤러 안에 없음")
        }
    }
    
    /// 뷰의 레이아웃 변경 시, 세그먼트 컨트롤의 indicator bar 위치를 업데이트
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let initialIndex = drawerEditView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        drawerEditView.customTotalSegmentView.updateIndicatorPosition(for: initialIndex)
    }
    
    /// 네비게이션 바와 타이틀 등의 UI 설정
    private func setupUI() {
        navigationItem.rightBarButtonItem = completeButton
        
        let navBarManager = NavigationBarManager()
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
            ClosetCollectionViewCell.self,
            forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier
        )
        drawerEditView.collectionView.allowsMultipleSelection = true
    }
    
    /// SegmentedControl 값 변경에 따른 이벤트 등록
    private func setupSegmentedControl() {
        drawerEditView.customTotalSegmentView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }
    
    // MARK: - Data Handling
    
    /// 더미 데이터 로드 (필요 시 추가)
    private func loadDummyData() {
        products = ClosetModel.getDummyData(for: 0)
        drawerEditView.collectionView.reloadData()
    }
    
    /// 초기 데이터 로드
    private func loadInitialData() {
        let initialIndex = drawerEditView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    /// 세그먼트 변경 시 데이터와 UI를 업데이트
    private func updateContent(for index: Int) {
        products = ClosetModel.getDummyData(for: index)
        
        if index == 0 {
            // "전체" 선택 시 카테고리 버튼 숨김 처리
            drawerEditView.customTotalSegmentView.toggleCategoryButtons(isHidden: true)
            
            drawerEditView.contentView.snp.remakeConstraints {
                $0.top.equalTo(drawerEditView.customTotalSegmentView.divideLine.snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        } else if let category = CustomCategoryModel.getCategories(for: index) {
            // 특정 카테고리 선택 시 카테고리 데이터를 가져와 UI 업데이트
            drawerEditView.customTotalSegmentView.toggleCategoryButtons(isHidden: false)
            drawerEditView.customTotalSegmentView.updateCategories(for: category.buttons)
            
            drawerEditView.contentView.snp.remakeConstraints {
                $0.top.equalTo(drawerEditView.customTotalSegmentView.categoryScrollView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        }
        
        drawerEditView.collectionView.reloadData()
        
        // 기존에 선택된 아이템이 있다면 복원
        for (index, product) in products.enumerated() {
            if selectedItems.contains(where: { $0.title == product.name }) {
                let indexPath = IndexPath(item: index, section: 0)
                drawerEditView.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            }
        }
    }
    
    // MARK: - Button State
    
    /// 선택된 아이템이 없으면 확인 버튼 비활성화, 있으면 활성화
    private func updateConfirmButtonState() {
        if selectedItems.isEmpty {
            completeButton.isEnabled = false
            completeButton.tintColor = .clear
        } else {
            completeButton.isEnabled = true
            completeButton.tintColor = UIColor(named: "pointOrange800")
        }
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
        
        // 셀의 선택 상태를 현재 selectedItems 배열에 따라 설정
        let isSelected = selectedItems.contains(where: { $0.title == product.name })
        cell.setSelected(isSelected)
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ClosetCollectionViewCell else { return }
        let product = products[indexPath.item]
        
        // 이미 선택된 아이템이면 해제, 아니면 선택 처리
        if selectedItems.contains(where: { $0.title == product.name }) {
            cell.setSelected(false)
            selectedItems.removeAll { $0.title == product.name }
            collectionView.deselectItem(at: indexPath, animated: true)
        } else {
            cell.setSelected(true)
            selectedItems.append((image: product.image, title: product.name))
        }
        
        updateConfirmButtonState()
    }
    
    // MARK: - Actions
    
    /// 뒤로 가기 버튼 (네비게이션 스택에서 pop)
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    /// 확인 버튼 클릭 시, 선택된 아이템을 delegate로 전달하고 이전 화면으로 이동
    @objc private func confirmButtonTapped() {
        let selectedData = selectedItems.map {
            (image: $0.image, title: $0.title) }
        delegate?.didSelectTags(selectedData)
        dismiss(animated: true)
    }
    
    // 세그먼트 컨트롤 변경 시 호출되는 메서드
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        drawerEditView.customTotalSegmentView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }
}
