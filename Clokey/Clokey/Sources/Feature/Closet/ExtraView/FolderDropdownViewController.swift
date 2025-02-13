import UIKit
import SnapKit

class FolderDropDownViewController: UIViewController, FolderDropdownViewDelegate, UIGestureRecognizerDelegate {
    
    private let folderDropdownView = FolderDropdownView()
    
    var parentNav: UINavigationController?
    
    /// DrawerViewController에서 계산한 상단 오프셋 (예: 네비게이션바 하단 + 5)
    var dropdownTop: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 배경을 투명하게 설정
        view.backgroundColor = .clear
        
        // 드롭다운 외의 영역을 탭했을 때 dismiss하도록 제스처 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap(_:)))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
        view.addSubview(folderDropdownView)
        folderDropdownView.delegate = self
        
        folderDropdownView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(dropdownTop)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(143)
            make.height.equalTo(75)
        }
    }
    
    /// 배경을 탭했을 때 호출되어 드롭다운 모달을 닫습니다.
    @objc private func handleBackgroundTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIGestureRecognizerDelegate
    /// 드롭다운 뷰 내에서의 터치는 제스처 인식에서 제외시킵니다.
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if folderDropdownView.frame.contains(touch.location(in: view)) {
            return false
        }
        return true
    }
    
    // MARK: - FolderDropdownViewDelegate 구현
    
    func didSelectEditFolder() {
        guard let nav = parentNav else {
            print("❌ 네비게이션 컨트롤러를 찾을 수 없습니다.")
            return
        }
        dismiss(animated: false) {
            let drawerEditVC = DrawerEditViewController()
            nav.pushViewController(drawerEditVC, animated: true)
        }
    }

    func didSelectDeleteFolder() {
        guard let nav = parentNav else {
            print("❌ 네비게이션 컨트롤러를 찾을 수 없습니다.")
            return
        }
        dismiss(animated: false) {
            let closetVC = ClosetViewController()
            nav.pushViewController(closetVC, animated: true)
        }
    }

}
