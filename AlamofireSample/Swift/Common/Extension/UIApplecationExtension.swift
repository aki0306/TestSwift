//
//  UIApplecationExtension.swift
//  AlamofireSample
//
//  Created by アキ on 2024/05/21.
//

import UIKit

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.connectedScenes
                                    .filter({$0.activationState == .foregroundActive})
                                    .compactMap({$0 as? UIWindowScene})
                                    .first?.windows
                                    .filter({$0.isKeyWindow}).first?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
