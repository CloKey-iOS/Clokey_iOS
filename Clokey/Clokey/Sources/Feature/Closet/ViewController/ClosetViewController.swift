import UIKit

final class ClosetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK: - Properties
    private let closetView = ClosetView()
    private var products: [ClosetModel] = []

    // MARK: - Lifecycle
    override func loadView() {
        view = closetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadInitialData()
        setupSegmentedControl()
    }
    //얘는 레이아웃 변경 되면 indicator bar 위치 업데이트 하기 위해서
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let initialIndex = closetView.segmentIntegrationView.segmentedControl.selectedSegmentIndex
        closetView.segmentIntegrationView.updateIndicatorPosition(for: initialIndex)
    }

    private func setupCollectionView() {
        closetView.closetCollectionView.dataSource = self
        closetView.closetCollectionView.delegate = self
    }
    //얘는 아까 그 코드랑 비슷한 역할이긴한데 해당 세그먼트에 맞는 컨텐츠(collectionView같은) 띄워주는 역할
    private func setupSegmentedControl() {
        closetView.segmentIntegrationView.segmentedControl.addTarget(
            self,
            action: #selector(segmentChanged(_:)),
            for: .valueChanged
        )
    }
    //초기 인덱스 가져오는 역할, 시뮬레이터 돌리면 첫번쨰 세그먼트 띄워주기
    private func loadInitialData() {
        let initialIndex = closetView.segmentIntegrationView.segmentedControl.selectedSegmentIndex
        updateContent(for: initialIndex)
    }
    
    //뭔가 이렇게 보니까 비슷한 느낌 함수를 많이 쓴 거 같은데 얘도 segment 변경했을 떄 updateContent불러와서 데이터 로드(제대로 안될 때마다 ViewController쪽에서 함수 하나씩 넣고 하다보니까 ViewController쪽은 좀 엉망이에요 엉엉)
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        closetView.segmentIntegrationView.updateIndicatorPosition(for: index)
        updateContent(for: index)
    }

    //이게 segmentIntegrationView속 func toggleCategoryButtons에서 말한 부분인데 "전체"일때는 buttontoggle 숨기고, collectionView top관련 간격 재조정해줍니다. divideLine 아래로 바로 위치하게.
    private func updateContent(for index: Int) {
        if index == 0 {
            products = ClosetModel.getDummyData(for: index)
            closetView.segmentIntegrationView.toggleCategoryButtons(isHidden: true)
            closetView.closetCollectionView.snp.remakeConstraints { make in
                make.top.equalTo(closetView.segmentIntegrationView.divideLine.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.width.equalTo(353)
                make.height.equalTo(228)
            }
    //반대로 "전체" 아닐땐 ishidden = false하고 collectionView 위치를 segmentIntegrationView안에 있는 categoryScrollView(버튼을 감쌋던 scrollView 아래로 위치하게 했어용
        } else {
            if let category = CategoryModel.getCategories(for: index) {
                products = ClosetModel.getDummyData(for: index)

                // categoryScrollView를 보임 처리
                closetView.segmentIntegrationView.categoryScrollView.isHidden = false

                // categoryScrollView 아래에 closetCollectionView 배치
                closetView.closetCollectionView.snp.remakeConstraints { make in
                    make.top.equalTo(closetView.segmentIntegrationView.categoryScrollView.snp.bottom).offset(6)
                    make.centerX.equalToSuperview()
                    make.width.equalTo(353)
                    make.height.equalTo(228)
                }

                // 카테고리 버튼 업데이트
                closetView.segmentIntegrationView.updateCategories(for: category.buttons)
            }
        }
        closetView.closetCollectionView.reloadData()
    }

    // 얘넨 collectionView 관련된 건데 형은 다른 collectionView쓰시니까..
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
        return cell
    }
}
