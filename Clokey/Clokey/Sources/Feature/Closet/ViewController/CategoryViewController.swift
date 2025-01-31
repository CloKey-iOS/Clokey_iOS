
/* import UIKit
 
 class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
 private let categoryView = CategoryView()
 private var categories: [CategoryModel] = [] // 데이터 초기화
 
 override func loadView() {
 view = categoryView
 }
 
 override func viewDidLoad() {
 super.viewDidLoad()
 categories = CategoryDataManager.categories // 데이터 가져오기
 setupCollectionView()
 setupActions() // 뒤로가기 버튼 액션 추가
 }
 
 private func setupCollectionView() {
 categoryView.CategoryCollectionView.dataSource = self
 categoryView.CategoryCollectionView.delegate = self
 }
 
 private func setupActions() {
 categoryView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
 }
 
 @objc private func backButtonTapped() {
 navigationController?.popViewController(animated: true)
 }
 
 // MARK: - UICollectionViewDataSource
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 return categories.count
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return categories[section].items.count
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
 return UICollectionViewCell()
 }
     
 let item = categories[indexPath.section].items[indexPath.item]
 cell.configure(with: item)
 return cell
 }
 
 // MARK: - Header 설정
 func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
 if kind == UICollectionView.elementKindSectionHeader {
 guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CategoryHeaderView.identifier, for: indexPath) as? CategoryHeaderView else {
 return UICollectionReusableView()
 }
 let categoryName = categories[indexPath.section].categoryName
 header.configure(with: categoryName)
 return header
 }
 return UICollectionReusableView()
 }
 
 // MARK: - Header 크기 설정
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
 return CGSize(width: collectionView.frame.width, height: 20) // 헤더 높이를 40으로 설정
 }
 }
 
*/
