//
//  FontExtension.swift
//  MusicApp
//
//  Created by G G on 12.12.2022.
//

import UIKit

extension UIFont {
    
    static func robotoRegular(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: 1)
    }
    
    static func robotoMedium(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Medium", size: size) ?? .systemFont(ofSize: 1)
    }
    
    static func robotoBold(size: CGFloat) -> UIFont? {
        return UIFont(name: "Roboto-Bold", size: size) ?? .systemFont(ofSize: 1)
    }
    
}
