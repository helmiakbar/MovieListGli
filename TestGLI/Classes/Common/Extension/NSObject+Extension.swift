//
//  NSObject+Extension.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//
import Foundation

public extension NSObject {
    
    func className() -> String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }
    
    static func className() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
    
}
