/*import UIKit
 
 class SeasonViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
 
 private let categoryView = CategoryView()
 
 private var seasons: [SeasonModel] = SeasonModel.Makedummy() // 더미 데이터
 
 override func loadView() {
 view = categoryView
 }
 
 override func viewDidLoad() {
 super.viewDidLoad()
 setupCollectionView()
 }
 
 private func setupCollectionView() {
 categoryView.SeasonCollectionView.dataSource = self
 categoryView.SeasonCollectionView.delegate = self
 }
 
 // MARK: - UICollectionViewDataSource
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 return 1 // 섹션은 하나
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return seasons.count // 계절 데이터 개수
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.identifier, for: indexPath) as! SeasonCollectionViewCell
 let season = seasons[indexPath.item]
 cell.seasonImageView.image = season.image
 cell.seasonLabel.text = season.name
 return cell
 }
 
 // MARK: - UICollectionViewDelegate (셀 선택 시 처리)
 // MARK: - UICollectionViewDelegate
 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
 let selectedSeason = seasons[indexPath.item]
 print("선택된 계절: \(selectedSeason.name)")
 
 // 선택된 셀 가져오기
 if let cell = collectionView.cellForItem(at: indexPath) as? SeasonCollectionViewCell {
 cell.seasonImageView.layer.borderColor = UIColor(named: "mainBrown800")!.cgColor // 테두리 색상 설정
 cell.seasonImageView.layer.borderWidth = 3
 cell.seasonImageView.layer.cornerRadius = cell.seasonImageView.frame.height / 2 // 둥근 모서리
 cell.seasonImageView.clipsToBounds = true
 
 }
 }
 
 // MARK: - UICollectionViewDelegate
 func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
 // 이전에 선택된 셀의 테두리 초기화
 if let cell = collectionView.cellForItem(at: indexPath) as? SeasonCollectionViewCell {
 cell.seasonImageView.layer.borderWidth = 0
 cell.seasonImageView.layer.borderColor = nil
 }
 }
 
 }
 */
