//
//  UINavigationBar.swift
//  Pneumonia
//
//  Created by Carlos Chaguendo on 13/03/20.
//  Copyright © 2020 FUP. All rights reserved.
//

import UIKit

public extension UINavigationBar {

    func removeBottomBorder() {
        shadowImage = UIImage()
    }

    func setTransparent() {
        isTranslucent = true
        shadowImage = UIImage()
        //text color
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }

    func removeTransparent() {
        shadowImage = nil
        setBackgroundImage(nil, for: UIBarMetrics.default)
    }
}
