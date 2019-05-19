//
//  NotificationBannerView.swift
//  NotificationBanner
//
//  Created by hesham ghalaab on 5/20/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

class NotificationBannerView: UIView {
    
    @IBOutlet weak private var mainView: UIView!
    @IBOutlet weak private var messageLabel: UILabel!
    
    var notificationBannerViewProtocol: NotificationBannerViewProtocol?
    private let identifier = "NotificationBannerView"
    
    /**
     taking the text message to alert the user.
     */
    var message = String(){
        didSet{
            self.messageLabel.text = message
        }
    }
    
    override init(frame: CGRect) { // for using it in code
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) { // for using it in IB
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        
        addMainView()
        addSwipeGesture()
        addMainViewShadow()
    }
    
    private func addMainView(){
        mainView.frame = self.bounds
        addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    private func addMainViewShadow(){
        layer.shadowRadius = 0.4
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.6
        layer.shadowColor = UIColor.black.cgColor
    }
    
    private func addSwipeGesture(){
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleBannerPan(recognizer:)))
        mainView.isUserInteractionEnabled = true
        mainView.addGestureRecognizer(panGesture)
    }
    
    @objc private func handleBannerPan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            notificationBannerViewProtocol?.willEndAfterEndingUserInteraction()
            
        case .changed:
            guard let rview = recognizer.view else { return }
            let changedPosition = rview.frame.origin.y + recognizer.translation(in: mainView).y
            guard changedPosition < 0 else { return }
            notificationBannerViewProtocol?.update(withValue: changedPosition)
            
        case .ended:
            notificationBannerViewProtocol?.didEnd()
        default: break
        }
    }
}
