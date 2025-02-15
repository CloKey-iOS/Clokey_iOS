//
//  LottieViewController.swift
//  Clokey
//
//  Created by 황상환 on 2/15/25.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {
    private let animationView: LottieAnimationView
    var animationCompletionHandler: (() -> Void)?
    private let isLoading: Bool  // 로딩용인지 온보딩용인지 구분
    
    init(animationName: String = "Onboarding", isLoading: Bool = false) {
        self.animationView = LottieAnimationView(name: animationName)
        self.isLoading = isLoading
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }
    
    private func setupAnimation() {
        view.backgroundColor = .white
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = isLoading ? .playOnce : .playOnce
        animationView.animationSpeed = 1.0
        view.addSubview(animationView)
        
        animationView.play { [weak self] finished in
            if finished {
                self?.animationCompletionHandler?()
            }
        }
    }
}
