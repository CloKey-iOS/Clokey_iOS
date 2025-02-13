import UIKit

class DrawerInfoViewController: UIViewController {
    
    private var products: [ClosetModel] = []  // 초기엔 빈 배열
    
    // 확인 버튼 (선택된 아이템을 delegate로 넘김)
    private lazy var createButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "생성", style: .done, target: self, action: #selector(createButtonTapped))
        button.isEnabled = false  // 초기에는 비활성화
        button.tintColor = .clear
        return button
    }()
    
    var drawerInfoView: DrawerInfoView {
        return view as! DrawerInfoView
    }
    
    override func loadView() {
        view = DrawerInfoView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupActions()
        loadDummyData()  // case1 데이터를 불러오도록 호출
    }
    
    // MARK: - UI 설정 (네비게이션 바)
    private func setupUI() {
        navigationItem.rightBarButtonItem = createButton
        
        let navBarManager = NavigationBarManager()
        navBarManager.addBackButton(
            to: navigationItem,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navBarManager.setTitle(
            to: navigationItem,
            title: "서랍 정보",
            font: .ptdBoldFont(ofSize: 20),
            textColor: .black
        )
    }
    
    private func setupCollectionView() {
        let collectionView = drawerInfoView.collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ClosetCollectionViewCell.self, forCellWithReuseIdentifier: ClosetCollectionViewCell.identifier)
        collectionView.reloadData()
    }
    
    private func setupActions() {
        // 폴더 텍스트필드의 입력 변화 감지 (텍스트가 채워지면 createButton 활성화)
        drawerInfoView.folderTextField.addTarget(self, action: #selector(folderTextFieldChanged(_:)), for: .editingChanged)
    }
    
    @objc private func folderTextFieldChanged(_ textField: UITextField) {
        // 입력된 텍스트의 공백 제거 후 검사
        let text = textField.text ?? ""
        let isTextFilled = !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        // 내비게이션 바의 createButton 업데이트
        createButton.isEnabled = isTextFilled
        createButton.tintColor = isTextFilled ? .black : .clear
    }
    
    @objc private func createButtonTapped() {
        let drawerVC = DrawerViewController()
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(drawerVC, animated: true)
        } else {
            print("❌ DrawerInfoViewController가 네비게이션 컨트롤러 안에 없음")
        }
    }
    
    // API 연결 전, 시범용으로 case1(상의) 더미 데이터를 로드합니다.
    private func loadDummyData() {
         products = ClosetModel.getDummyData(for: 1)
         drawerInfoView.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource & UICollectionViewDelegate
extension DrawerInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return products.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(
             withReuseIdentifier: ClosetCollectionViewCell.identifier,
             for: indexPath
         ) as? ClosetCollectionViewCell else {
             return UICollectionViewCell()
         }
         
         let product = products[indexPath.item]
         // numberLabel과 countLabel을 숨기도록 설정
         cell.configureCell(with: product, hideNumberLabel: true, hideCountLabel: true)
         return cell
     }
     
     // MARK: - 네비게이션 뒤로 가기
     @objc private func backButtonTapped() {
         navigationController?.popViewController(animated: true)
     }
}
