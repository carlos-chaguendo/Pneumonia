//
//  PropertyBuilder.swift
//  Pneumonia
//
//  Created by Carlos Chaguendo on 5/03/20.
//  Copyright © 2020 FUP. All rights reserved.
//

import Foundation

public protocol PropertyBuilder: class {

}

extension PropertyBuilder where Self: AnyObject {

    @discardableResult
    public func set<Value>(_ key: ReferenceWritableKeyPath<Self, Value>, _ value: Value) -> Self {
        self[keyPath: key] = value
        return self
    }
}

extension NSObject: PropertyBuilder { }
