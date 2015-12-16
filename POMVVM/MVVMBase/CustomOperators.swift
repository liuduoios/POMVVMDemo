//
//  CustomOperators.swift
//  POMVVM
//
//  Created by 刘铎 on 15/12/15.
//  Copyright © 2015年 liuduoios. All rights reserved.
//

import Foundation
import Bond

// 单向绑定
infix operator --> { associativity left precedence 95 }

public func --> <O: EventProducerType, B: BindableType where B.Element == O.EventType>(source: O, destination: B) -> DisposableType {
    return source ->> destination
}

public func --> <O: EventProducerType, B: BindableType where B.Element == Optional<O.EventType>>(source: O, destination: B) -> DisposableType {
    return source ->> destination
}

// 双向绑定
infix operator <==> { associativity left precedence 95 }

public func <==> <B: BindableType where B: EventProducerType, B.Element == B.EventType>(source: B, destination: B) -> DisposableType {
    return source ->>< destination
}