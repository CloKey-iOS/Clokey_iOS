//import UIKit
//
//class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//
//    private let categoryView = CategoryView()
//    private var categories: [CategoryModel] = []
//
//    override func loadView() {
//        view = categoryView
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        categories = [
//            CategoryModel.getCategory(at: 0),
//            CategoryModel.getCategory(at: 1),
//            CategoryModel.getCategory(at: 2),
//            CategoryModel.getCategory(at: 3)
//        ].compactMap { $0 }  // nil 값 제거
//
//        setupCollectionView()
//        setupActions()
//    }
///*
//    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 10
//        layout.minimumInteritemSpacing = 13
//        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
//        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 27)
//
//        //layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//
//        categoryView.categoryCollectionView.collectionViewLayout = layout
//        categoryView.categoryCollectionView.dataSource = self
//        categoryView.categoryCollectionView.delegate = self
//        categoryView.categoryCollectionView.register(CategoryHeaderView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: CategoryHeaderView.identifier)
//        categoryView.categoryCollectionView.register(CategoryCollectionViewCell.self,
//            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
//    }
//
//*/
//    private func setupCollectionView() {
//        categoryView.categoryCollectionView.collectionViewLayout = createCompositionalLayout()
//        categoryView.categoryCollectionView.dataSource = self
//        categoryView.categoryCollectionView.delegate = self
//        categoryView.categoryCollectionView.register(CategoryHeaderView.self,
//            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//            withReuseIdentifier: CategoryHeaderView.identifier)
//        categoryView.categoryCollectionView.register(CategoryCollectionViewCell.self,
//            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
//    }
//
//    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
//        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(56), heightDimension: .absolute(27))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//            let groupSize = NSCollectionLayoutSize(
//                widthDimension: .fractionalWidth(1.0),
//                heightDimension: .absolute(27)
//            )
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//            group.interItemSpacing = .fixed(13) // 버튼 간격 유지
//            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0) // 좌우 패딩 설정
//
//            let section = NSCollectionLayoutSection(group: group)
//            section.interGroupSpacing = 10 // 줄 간 간격 설정
//            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 40, trailing: 0)
//
//            return section
//        }
//    }
//
//    private func setupActions() {
//        categoryView.backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//    }
//
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//
//    // MARK: - UICollectionViewDataSource
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return categories.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return categories[section].buttons.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        let item = categories[indexPath.section].buttons[indexPath.item]
//        cell.configure(with: item)
//        return cell
//    }
//
//    // MARK: - Header 설정 (섹션 헤더)
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            guard let header = collectionView.dequeueReusableSupplementaryView(
//                ofKind: kind,
//                withReuseIdentifier: CategoryHeaderView.identifier,
//                for: indexPath
//            ) as? CategoryHeaderView else {
//                return UICollectionReusableView()
//            }
//            let categoryName = categories[indexPath.section].name
//            header.configure(with: categoryName)
//            return header
//        }
//        return UICollectionReusableView()
//    }
//
//    // ✅ 줄바꿈 & 버튼 간격 문제 해결
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let text = categories[indexPath.section].buttons[indexPath.item]
//
//        // 텍스트의 크기에 맞는 버튼 크기 계산
//        let textWidth = text.size(withAttributes: [.font: UIFont.ptdRegularFont(ofSize: 16)]).width
//        let buttonWidth = textWidth + 28// 좌우 패딩 합 26에 border값 2
//
//        // 한 줄 최대 너비 설정 → categoryView.contentView 또는 superview 기준으로 변경
//        let maxRowWidth = (categoryView.frame.width - 40)
//
//        var totalWidth: CGFloat = 0
//        var rowCount: Int = 1
//
//        for i in 0..<indexPath.item {  // 🔥 현재 indexPath.item 이전의 아이템들만 고려
//            let prevText = categories[indexPath.section].buttons[i]
//            let prevTextWidth = prevText.size(withAttributes: [.font: UIFont.ptdRegularFont(ofSize: 16)]).width
//            let prevButtonWidth = prevTextWidth + 28
//
//            if totalWidth + prevButtonWidth > maxRowWidth {
//                rowCount += 1
//                totalWidth = prevButtonWidth  // 🔥 0이 아니라 현재 버튼 너비부터 시작해야 함
//            } else {
//                totalWidth += (prevButtonWidth + 13)
//            }
//        }
//
//        return CGSize(width: buttonWidth, height: 32)  // 버튼 높이는 고정
//
//    }
//}
import UIKit

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let categoryView = CategoryView()
    private var categories: [CategoryModel] = []

    override func loadView() {
        view = categoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        categories = [
            CategoryModel.getCategory(at: 0),
            CategoryModel.getCategory(at: 1),
            CategoryModel.getCategory(at: 2),
            CategoryModel.getCategory(at: 3)
        ].compactMap { $0 }  // nil 값 제거

        setupCollectionView()
        setupActions()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero // 🔥 자동 크기 조정 비활성화 (간격 강제 적용)
        layout.minimumInteritemSpacing = 13  // 버튼 간 간격 강제 유지
        layout.minimumLineSpacing = 10  // 줄 간 간격
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 40, right: 0)
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 27)

        categoryView.categoryCollectionView.collectionViewLayout = layout
        categoryView.categoryCollectionView.dataSource = self
        categoryView.categoryCollectionView.delegate = self
        categoryView.categoryCollectionView.register(CategoryHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: CategoryHeaderView.identifier)
        categoryView.categoryCollectionView.register(CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
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
        return categories[section].buttons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.identifier,
            for: indexPath
        ) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        let item = categories[indexPath.section].buttons[indexPath.item]
        cell.configure(with: item)
        return cell
    }

    // MARK: - Header 설정 (섹션 헤더)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: CategoryHeaderView.identifier,
                for: indexPath
            ) as? CategoryHeaderView else {
                return UICollectionReusableView()
            }
            let categoryName = categories[indexPath.section].name
            header.configure(with: categoryName)
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.section].buttons[indexPath.item]
        let textWidth = text.size(withAttributes: [.font: UIFont.ptdRegularFont(ofSize: 16)]).width
        let buttonWidth = textWidth + 28  // 좌우 패딩 포함
        let maxRowWidth = (categoryView.frame.width - 40) // 🔥 컬렉션 뷰 width 고려

        var totalWidth: CGFloat = 0
        var currentRowItems: [CGFloat] = [] // 현재 줄의 버튼 리스트

        for i in 0..<indexPath.item {
            let prevText = categories[indexPath.section].buttons[i]
            let prevTextWidth = prevText.size(withAttributes: [.font: UIFont.ptdRegularFont(ofSize: 16)]).width
            let prevButtonWidth = prevTextWidth + 28

            if totalWidth + prevButtonWidth > maxRowWidth {
                // 🔥 새로운 줄이 시작될 때, 현재 줄의 버튼들을 13 간격으로 배치
                adjustRowSpacing(items: &currentRowItems, maxWidth: maxRowWidth)

                totalWidth = prevButtonWidth // 새로운 줄 시작
                currentRowItems = [prevButtonWidth] // 새로운 줄의 첫 버튼 추가
            } else {
                totalWidth += (prevButtonWidth + 13) // 🔥 간격은 13으로 강제
                currentRowItems.append(prevButtonWidth)
            }
        }

        return CGSize(width: buttonWidth, height: 32)
    }
    
    private func adjustRowSpacing(items: inout [CGFloat], maxWidth: CGFloat) {
        guard !items.isEmpty else { return }

        let totalWidth = items.reduce(0, +) + CGFloat(items.count - 1) * 13
        let remainingSpace = maxWidth - totalWidth

        // 🔥 남은 공간을 무조건 오른쪽에 남기고, 간격 13 유지
        if remainingSpace < 10 {
            return
        }
    }


}
