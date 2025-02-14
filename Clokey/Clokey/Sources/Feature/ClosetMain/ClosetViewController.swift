import UIKit
import SnapKit

final class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private let closetView = ClosetView()
    private var products: [ClosetModel] = []
    // ClosetModel의 배열, UICollectionView에 표시될 데이터 저장
    private var drawers: [DrawerModel] = DrawerModel.makeDummy()
    
    // (팝업 관련 배경뷰 등은 PopUpViewController로 분리하므로 삭제)
    
    // MARK: - Lifecycle
    override func loadView() {
        view = closetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupActions() // menuButton, seeAllButton, editDrawerButton 액션 등록
        loadInitialData() // 첫 번째 세그먼트에 해당하는 데이터 로드
        setupSegmentedControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let initialIndex = closetView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        closetView.customTotalSegmentView.updateIndicatorPosition(for: initialIndex)
    }
    
    // MARK: - Setup Methods
    private func setupActions() {
        closetView.customTotalSegmentView.menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        closetView.seeAllButton.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        closetView.editDrawerButton.addTarget(self, action: #selector(editDrawerButtonTapped), for: .touchUpInside)
    }
    
    // menuButton 클릭 시 CategoryViewController로 이동
    @objc private func menuButtonTapped() {
        let categoryVC = CategoryViewController()
        categoryVC.modalPresentationStyle = .fullScreen
        categoryVC.modalTransitionStyle = .coverVertical
        present(categoryVC, animated: true, completion: nil)
    }
    
    // 전체보기 버튼 클릭 시 DisplayAllViewController로 이동
    @objc private func seeAllButtonTapped() {
        let displayAllVC = DisplayAllViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(displayAllVC, animated: true)
        } else {
            print("❌ ClosetViewController가 네비게이션 컨트롤러 안에 없음")
        }
    }
    
    // editDrawerButton 클릭 시 DrawerEditViewController로 이동
    @objc private func editDrawerButtonTapped() {
        let drawerEditVC = DrawerEditViewController()
        if let navigationController = self.navigationController {
            navigationController.pushViewController(drawerEditVC, animated: true)
        } else {
            print("❌ ClosetViewController가 네비게이션 컨트롤러 안에 없음")
        }
    }
    
    /// UISegmentedControl 변경 시 세그먼트의 인디케이터 업데이트 및 데이터 갱신
    private func setupSegmentedControl() {
        closetView.customTotalSegmentView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        closetView.customTotalSegmentView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }
    
    /// 초기 인덱스에 해당하는 데이터를 로드
    private func loadInitialData() {
        let initialIndex = closetView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    /// 세그먼트 변경 시 데이터 및 UI 업데이트
    private func updateContent(for index: Int) {
        products = ClosetModel.getDummyData(for: index)
        
        if index == 0 {
            closetView.customTotalSegmentView.toggleCategoryButtons(isHidden: true)
            closetView.closetCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(closetView.customTotalSegmentView.divideLine.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.width.equalTo(353)
                make.height.equalTo(354)
            }
        } else if let category = CustomCategoryModel.getCategories(for: index) {
            closetView.customTotalSegmentView.toggleCategoryButtons(isHidden: false)
            closetView.customTotalSegmentView.updateCategories(for: category.buttons)
            closetView.closetCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(closetView.customTotalSegmentView.categoryScrollView.snp.bottom)
                make.centerX.equalToSuperview()
                make.width.equalTo(353)
                make.height.equalTo(354)
            }
        }
        
        closetView.closetCollectionView.reloadData()
    }
    
    // MARK: - CollectionView Setup
    private func setupCollectionView() {
        closetView.closetCollectionView.dataSource = self // ClosetCollectionView 데이터 연결
        closetView.closetCollectionView.delegate = self
        closetView.drawerCollectionView.dataSource = self // DrawerCollectionView 데이터 연결
        closetView.drawerCollectionView.delegate = self
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == closetView.closetCollectionView {
            return products.count
        } else if collectionView == closetView.drawerCollectionView {
            return drawers.count // 서랍 개수 반환
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == closetView.closetCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClosetCollectionViewCell.identifier, for: indexPath) as? ClosetCollectionViewCell else {
                fatalError("Unable to dequeue ClosetCollectionViewCell")
            }
            let product = products[indexPath.item]
            cell.productImageView.image = product.image
            cell.numberLabel.text = product.number
            cell.countLabel.text = product.count
            cell.nameLabel.text = product.name
            return cell
        } else if collectionView == closetView.drawerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DrawerCollectionViewCell.identifier, for: indexPath) as? DrawerCollectionViewCell else {
                fatalError("Unable to dequeue DrawerCollectionViewCell")
            }
            let drawer = drawers[indexPath.item]
            cell.productImageView.image = drawer.image
            cell.folderLabel.text = drawer.name
            cell.itemCountLabel.text = drawer.item
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == closetView.closetCollectionView {
            let product = products[indexPath.item]
            // PopUpViewController를 모달로 띄움
            let popUpVC = PopUpViewController()
            popUpVC.modalPresentationStyle = .overCurrentContext
            popUpVC.modalTransitionStyle = .crossDissolve
            present(popUpVC, animated: true, completion: nil)
            
        } else if collectionView == closetView.drawerCollectionView {
            let drawer = drawers[indexPath.item]
            // DrawerViewController는 선택한 drawer 데이터를 보여주는 뷰컨트롤러라고 가정합니다.
            let drawerVC = DrawerViewController()
            // drawerVC에 drawer 모델 데이터를 전달 (예: drawerVC.drawer = drawer)
            navigationController?.pushViewController(drawerVC, animated: true)
        }
    }

    
    // MARK: - Actions
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
