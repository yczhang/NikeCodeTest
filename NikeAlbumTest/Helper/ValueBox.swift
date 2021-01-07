//
//  LocalDataSource.swift
//  ValueBox
//
//  Created by YICHUN ZHANG on 1/6/21.
//
import Foundation

final class ValueBox<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
           listener?(value)
        }
    }
    
    init(_ value: T)
    {
        self.value = value
    }
    
    func bind(listener: Listener?)
    {
        self.listener = listener
        
        listener?(value)
    }
}
