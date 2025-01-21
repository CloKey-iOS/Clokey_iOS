import UIKit
import SnapKit
import Then

final class ClosetViewController: UIViewController {
    // MARK: - Properties
    private let closetView = ClosetView()
    private var products: [ClosetModel] = ClosetModel.getDummyData(for: 0) // 초기 데이터 설정

    // MARK: - Lifecycle
    override func loadView() {
        view = closetView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        closetView.ClosetCollectionView.dataSource = self
        closetView.ClosetCollectionView.delegate = self
    }

    // MARK: - Setup
    private func setupActions() {
        closetView.segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    // MARK: - Actions
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        let segmentIndex = sender.selectedSegmentIndex

        // 세그먼트 선택에 따라 데이터 갱신
        products = ClosetModel.getDummyData(for: segmentIndex)
        closetView.ClosetCollectionView.reloadData()

        // IndicatorBar 애니메이션
        let segmentWidth = closetView.segmentedControl.frame.width / CGFloat(closetView.segmentedControl.numberOfSegments)
        let targetX = CGFloat(segmentIndex) * segmentWidth + 19

        UIView.animate(withDuration: 0.3) {
            self.closetView.indicatorBar.snp.updateConstraints { make in
                make.leading.equalTo(self.closetView.segmentedControl.snp.leading).offset(targetX)
            }
            self.closetView.layoutIfNeeded()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension ClosetViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClosetCollectionViewCell.identifier, for: indexPath) as? ClosetCollectionViewCell else {
            fatalError("Unable to dequeue ClosetCollectionViewCell")
        }
        let product = products[indexPath.item]
        cell.productImageView.image = product.image
        cell.numberLabel.text = product.number
        cell.countLabel.text = product.count
        return cell
    }
}
