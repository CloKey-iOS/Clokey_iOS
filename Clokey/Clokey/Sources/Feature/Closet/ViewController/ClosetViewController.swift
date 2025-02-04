import UIKit

final class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private let closetView = ClosetView()
    private var products: [ClosetModel] = [] //ClosetModel의 배열, UICollectionView에 표시될 데이터 저장
    private var drawers: [DrawerModel] = DrawerModel.makeDummy()
    // var drawerData: [DrawerModel] = [] // API에서 데이터를 채우는 방식으로 변경.. 이렇게 하면 되나요??
    
    private var backgroundView: UIView?// 배경 어둡게 하기 위해 선언
    
    // MARK: - Lifecycle
    override func loadView() {
        view = closetView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadInitialData()//첫 번째 세그먼트에 해당하는 데이터 로드
        setupSegmentedControl()
    }
    
    //얘는 레이아웃 변경 되면 indicator bar 위치 업데이트 하기 위해서
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let initialIndex = closetView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        closetView.customTotalSegmentView.updateIndicatorPosition(for: initialIndex)
    }
    // 이건 collectionView관련된 코드고
    private func setupCollectionView() {
        closetView.closetCollectionView.dataSource = self //ClosetCollectionView 데이터 연결
        closetView.closetCollectionView.delegate = self
        closetView.drawerCollectionView.dataSource = self //DrawerCollectionView 데이터 연결
        closetView.drawerCollectionView.delegate = self
    }
    //얘는 UISegmentControl 변경될때 SegmentChanged 메서드 실행되도록
    private func setupSegmentedControl() {
        closetView.customTotalSegmentView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }
    // 얘가 위에서 말한 segmentChanged 메서드, 사용자가 UISegmentControl 변경하면 실행
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        closetView.customTotalSegmentView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }
    
    //초기 인덱스 가져오는 역할, 시뮬레이터 돌리면 첫번쨰 세그먼트 띄워주기, 아까 ViewDidLoad에 있던 애
    private func loadInitialData() {
        let initialIndex = closetView.customTotalSegmentView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    //이게 segmentIntegrationView속 func toggleCategoryButtons에서 말한 부분인데 "전체"일때는 buttontoggle 숨기고, collectionView top관련 간격 재조정해줍니다. divideLine 아래로 바로 위치하게.
    private func updateContent(for index: Int) {
        if index == 0 {
            products = ClosetModel.getDummyData(for: index)
            closetView.customTotalSegmentView.toggleCategoryButtons(isHidden: true)
            closetView.closetCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(closetView.customTotalSegmentView.divideLine.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.width.equalTo(353)
                make.height.equalTo(354)
            }
            //반대로 "전체" 아닐땐 ishidden = false하고 collectionView 위치를 segmentIntegrationView안에 있는 categoryScrollView(버튼을 감쌋던 scrollView 아래로 위치하게 했어용
        } else {
            if let category = CategoryModel.getCategories(for: index) {
                products = ClosetModel.getDummyData(for: index)
                
                // categoryScrollView를 보임 처리
                closetView.customTotalSegmentView.categoryScrollView.isHidden = false
                
                // categoryScrollView 아래에 closetCollectionView 배치
                closetView.closetCollectionView.snp.remakeConstraints { make in
                    make.top.equalTo(closetView.customTotalSegmentView.categoryScrollView.snp.bottom)//.offset(6)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(353)
                    make.height.equalTo(354)
                }
                
                // 카테고리 버튼 업데이트
                closetView.customTotalSegmentView.updateCategories(for: category.buttons)
            }
        }
        closetView.closetCollectionView.reloadData()
    }
    
    // 얘넨 collectionView 관련된 건데 형은 다른 collectionView쓰시니까..
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == closetView.closetCollectionView {
            return products.count
        } else if collectionView == closetView.drawerCollectionView {
            return drawers.count // 🔹 서랍 개수 반환
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
    
    // ✅ UICollectionView 셀 클릭 시 PopUpView 띄우기
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == closetView.closetCollectionView {
            showPopUpView(for: products[indexPath.item])
        }
    }
    
    // ✅ PopUpView 띄우기
    private func showPopUpView(for product: ClosetModel) {
        guard let keyWindow = UIApplication.shared.connectedScenes
                    .compactMap({ ($0 as? UIWindowScene)?.windows.first })
                    .first else { return }//keywindow설정 하단 상단 바도 다 포함하는
        
        //뒷 배경 어둡게
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        bgView.alpha = 0
        keyWindow.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backgroundView = bgView
        
        let popUpView = TouchPopupView()
        popUpView.alpha = 0
        keyWindow.addSubview(popUpView)
        
        popUpView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(290)
            make.height.equalTo(448)
        }
        
        // 팝업 애니메이션 효과
        UIView.animate(withDuration: 0.3) {
            bgView.alpha = 1
            popUpView.alpha = 1
        }
        
        // ✅ closeButton 클릭 시 팝업 닫기 기능 추가
        popUpView.closeButton.addTarget(self, action: #selector(dismissPopUpView), for: .touchUpInside)
    }
    
    // ✅ PopUpView 닫기
    @objc private func dismissPopUpView() {
        guard let keyWindow = UIApplication.shared.connectedScenes
            .compactMap({ ($0 as? UIWindowScene)?.windows.first })
            .first else { return }

        // 🔹 keyWindow에서 PopUpView 찾기
        if let popUpView = keyWindow.subviews.first(where: { $0 is TouchPopupView }) {
            UIView.animate(withDuration: 0.3, animations: {
                self.backgroundView?.alpha = 0 // 배경도 함께 사라지게 함
                popUpView.alpha = 0
            }) { _ in
                self.backgroundView?.removeFromSuperview() // 배경 제거
                popUpView.removeFromSuperview()
                self.backgroundView = nil // 참조 해제
            }
        }
    }
}
//팝업 관련 공부(배경도)
