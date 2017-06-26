//
//  UICollectionViewUtility.swift
//  OpenWeather
//
//  Created by Ujwal Manjunath on 6/26/17.
//  Copyright © 2017 Win-kel. All rights reserved.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func registerCell(cellType:UICollectionViewCell.Type) {
        
        let bundle = Bundle(for: cellType)
        //TODO: Swift 3 : Use describing initializer of String class to initialize classname with string
        let className =  NSStringFromClass(cellType).components(separatedBy:".").last
        self.register(UINib(nibName: className!, bundle: bundle), forCellWithReuseIdentifier: className!)
    }
    
    func registerSupplementaryView(classType:UICollectionReusableView.Type, kind:String) {
        let bundle = Bundle(for: classType)
        //TODO: Swift 3 : Use describing initializer of String class to initialize classname with string
        let className =  NSStringFromClass(classType).components(separatedBy:".").last
        self.register(UINib(nibName: className!, bundle: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: className!)
    }
    
    func dequeue<T:UICollectionViewCell>(cellType:T.Type, indexPath:IndexPath) -> T {
        self.layer.shouldRasterize = true;
        self.layer.rasterizationScale = UIScreen.main.scale
        return self.dequeueReusableCell(withReuseIdentifier: cellType.id(), for: indexPath) as! T
    }
    
    
    func dequeueSupplementary<T:UICollectionReusableView>(reusableType:T.Type, kind:String, indexPath:IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reusableType.id(), for: indexPath) as! T
    }
}

public extension UICollectionReusableView {
    class func nib() -> UINib {
        var className = NSStringFromClass(self)
        
        if let range = className.range(of:".") {
            className = className.substring(from:range.upperBound)
        }
        
        return UINib(nibName: className, bundle: Bundle.main)
    }
    
    class func id() -> String {
        var className = NSStringFromClass(self)
        
        if let range = className.range(of:".") {
            className = className.substring(from:range.upperBound)
        } else {
            print("Found a mangled class name? \(className)")
        }
        
        return className
    }
}
