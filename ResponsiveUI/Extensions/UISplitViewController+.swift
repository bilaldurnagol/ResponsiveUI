//
//  UISplitViewController+.swift
//  ResponsiveUI
//
//  Created by Bilal Durnagöl on 21.09.2022.
//

import SwiftUI

extension UISplitViewController {
    open override func viewDidLoad() {
        self.preferredDisplayMode = .twoOverSecondary
        self.preferredSplitBehavior = .displace
        
        // Updating primary view column fraction
        self.preferredPrimaryColumnWidthFraction = 0.3
        
        // Updating dinamically with the help of notificationcenter calls
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateView(notification:)),
            name: Notification.Name("UPDATEFRACTION"),
            object: nil
        )
    }
    
    
    @objc func updateView(notification: Notification) {
        if let info = notification.userInfo, let fraction = info["fraction"] as? Double {
            self.preferredPrimaryColumnWidthFraction = fraction
        }
    }
}
