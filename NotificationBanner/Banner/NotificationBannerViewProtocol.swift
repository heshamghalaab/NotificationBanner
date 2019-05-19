//
//  NotificationBannerViewProtocol.swift
//  NotificationBanner
//
//  Created by hesham ghalaab on 5/20/19.
//  Copyright © 2019 hesham ghalaab. All rights reserved.
//

import UIKit

/**
 NotificationBannerView Protocol is a protocol that make the communication betwwen NotificationBannerView and the NotificationBanner class which will show the alert, we can think of it like the NotificationBanner with show NotificationBannerView.
 */
protocol NotificationBannerViewProtocol {
    /**
     user didEnd ban gesture and the view now is ready to be collpsed.
     */
    func didEnd()
    
    /**
     update the constraints of the NotificationBannerView as the user making his ban gesture.
     - Parameter value: is the constant that will be added to the top constraint.
     */
    func update(withValue value: CGFloat)
    
    /**
     willEndAfterEndingUserInteraction mainly to handle if the animation of the collapse will be done according to the user gesture or after two seconds.
     */
    func willEndAfterEndingUserInteraction()
}
