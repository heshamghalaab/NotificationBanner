//
//  NotificationBanner.swift
//  NotificationBanner
//
//  Created by hesham ghalaab on 5/20/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

class NotificationBanner {
    
    private var bannerView: NotificationBannerView?
    private var bannerTopConstraint: NSLayoutConstraint?
    private var superView: UIView?
    
    private let animateDuration = 0.5
    private let bannerAppearanceDuration: TimeInterval = 2
    private let bannerHeight: CGFloat = 100
    private var bannerWidth = CGFloat()
    private var isUserInteractWithBanner = false
    
    /**
     it will show the NotificationBanner banner after calling another function that aims to handle the animation.
     - Parameter text: text to alert the user in the banner.
     */
    public func show(_ text: String) {
        initialization()
        addNotificationBannerView(withText: text)
        expandBanner()
        DispatchQueue.main.asyncAfter(deadline: .now() + bannerAppearanceDuration) { [weak self] in
            self?.collapseBanner()
        }
    }
    
    /**
     Init some views and constraints that will be used in the NotificationBanner.
     */
    private func initialization(){
        superView = UIApplication.shared.keyWindow?.rootViewController?.view
        guard let superView = superView else {return}
        bannerWidth = superView.bounds.size.width
    }
    
    /**
     adding NotificationBannerView and handle its constraints will adding the text to the view.
     - Parameter text: text to alert the user in the banner.
     */
    private func addNotificationBannerView(withText text: String){
        bannerView = NotificationBannerView(frame: CGRect(x: 0, y: -bannerHeight, width: bannerWidth, height: bannerHeight))
        
        bannerView?.translatesAutoresizingMaskIntoConstraints = false
        superView?.addSubview(bannerView!)
        
        bannerView?.widthAnchor.constraint(equalToConstant: bannerWidth).isActive = true
        bannerView?.leadingAnchor.constraint(equalTo: superView!.leadingAnchor).isActive = true
        bannerView?.trailingAnchor.constraint(equalTo: superView!.trailingAnchor).isActive = true
        bannerTopConstraint = bannerView?.topAnchor.constraint(equalTo: superView!.topAnchor)
        bannerTopConstraint?.isActive = true
        bannerView?.heightAnchor.constraint(equalToConstant: bannerHeight).isActive = true
        bannerView?.message = text
        bannerView?.notificationBannerViewProtocol = self
    }
    
    /**
     Expand the banner with animation to alert the user or warning him.
     */
    private func expandBanner(){
        UIView.animate(withDuration: animateDuration, delay: 0, options: [.curveEaseInOut], animations: {
            self.bannerTopConstraint?.constant = 0
            self.superView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    /**
     Collapse banner after it is success to alert the user, it has two cases: the first one if the user want to collabse it with a ban gesture ,the second one is after a delay of two seconds if the user has no interaction on the banner.
     - Parameter afterDelay: take 0 if user interact with it , and take 2 seconds if he has no interaction.
     */
    @objc private func collapseBanner(){
        UIView.animate(withDuration: animateDuration, delay: 0, options: [.curveEaseInOut], animations: {
            guard !self.isUserInteractWithBanner else {return}
            self.bannerTopConstraint?.constant = -self.bannerHeight
            self.superView?.layoutIfNeeded()
            
        }, completion: { finished in
            guard !self.isUserInteractWithBanner else {return}
            guard finished else { return }
            
            self.bannerView?.removeFromSuperview()
            self.bannerView = nil
        })
    }
    
}

extension NotificationBanner: NotificationBannerViewProtocol{
    func didEnd() {
        self.isUserInteractWithBanner = false
        self.collapseBanner()
    }
    
    func update(withValue value: CGFloat) {
        bannerTopConstraint?.constant = value
    }
    
    func willEndAfterEndingUserInteraction() {
        self.isUserInteractWithBanner = true
    }
}
