//
//  DrawerViewController.swift
//  Clokey
//
//  Created by 한태빈 on 2/8/25.
//

import UIKit
import SnapKit

class DrawerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private let drawerView = DrawerView()
    
    private var products: [ClosetModel] = []
    private var shouldHideNumberLabel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupView()
        loadInitialData()
    }
    
    private func setupUI() {
        let navBarManager = NavigationBarManager()
        navBarManager.addBackButton(
            to: navigationItem,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navBarManager.setTitle(
            to: navigationItem,
            title: "폴더명",
            font: .ptdBoldFont(ofSize: 20),
            textColor: .black
        )
    }
    
    private func setupView() {
        view.addSubview(drawerView)
        drawerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        drawerView.collectionView.dataSource = self
        drawerView.collectionView.delegate = self
    }
    
    func configure(with products: [ClosetModel], hideNumberLabel: Bool) {
        self.products = products
        self.shouldHideNumberLabel = hideNumberLabel
        drawerView.collectionView.reloadData()
    }
    
    private func loadInitialData() {
        products = ClosetModel.getDummyData(for: 0)
        drawerView.collectionView.reloadData()
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClosetCollectionViewCell.identifier, for: indexPath) as? ClosetCollectionViewCell else {
            fatalError("Unable to dequeue ClosetCollectionViewCell")
        }
        
        let product = products[indexPath.item]
        cell.configureCell(with: product, hideNumberLabel: shouldHideNumberLabel)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate (셀 선택 처리)
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item at index: \(indexPath.item)")
    }
}
