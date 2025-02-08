//
//  DrawerViewController.swift
//  Clokey
//
//  Created by 한태빈 on 2/8/25.
//

import UIKit

class DrawerAddViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private let drawerAddView = DrawerAddView()
    private var products: [ClosetModel] = []
    private var backgroundView: UIView? // 배경 어둡게 하기 위한 뷰
    
    // MARK: - Lifecycle
    override func loadView() {
        view = drawerAddView
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
        drawerAddView.customTotalSegmentView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
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
        let initialIndex = drawerAddView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        drawerAddView.customTotalSegmentView.updateIndicatorPosition(for: initialIndex)
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
            title: "아이템 선택하기",
            font: .ptdBoldFont(ofSize: 20),
            textColor: .black
        )
    }
    
    // MARK: - CollectionView 설정
    private func setupCollectionView() {
        drawerAddView.collectionView.dataSource = self
        drawerAddView.collectionView.delegate = self
        drawerAddView.collectionView.register(
            ClosetCollectionViewCell.self,
            forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier
        )
    }
    
    // MARK: - Segment Control 설정
    private func setupSegmentedControl() {
        drawerAddView.customTotalSegmentView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }

    // MARK: - Segment 변경 시 처리
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        drawerAddView.customTotalSegmentView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }
    
    // MARK: - 데이터 로드
    private func loadInitialData() {
        let initialIndex = drawerAddView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    // Segment 변경 시 데이터 업데이트
    private func updateContent(for index: Int) {
        products = ClosetModel.getDummyData(for: index)

        if index == 0 {
            // ✅ "전체" 선택 시 카테고리 버튼 숨김
            drawerAddView.customTotalSegmentView.toggleCategoryButtons(isHidden: true)
            
            drawerAddView.collectionView.snp.remakeConstraints {
                $0.top.equalTo(drawerAddView.customTotalSegmentView.divideLine.snp.bottom).offset(10)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        } else if let category = CustomCategoryModel.getCategories(for: index) {
            // ✅ 카테고리 데이터를 가져와 UI 업데이트
            drawerAddView.customTotalSegmentView.toggleCategoryButtons(isHidden: false)
            drawerAddView.customTotalSegmentView.updateCategories(for: category.buttons)
            
            drawerAddView.collectionView.snp.remakeConstraints {
                $0.top.equalTo(drawerAddView.customTotalSegmentView.categoryScrollView.snp.bottom)
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.bottom.equalToSuperview()
            }
        }

        drawerAddView.collectionView.reloadData()
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


    // MARK: - 네비게이션 뒤로 가기
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
