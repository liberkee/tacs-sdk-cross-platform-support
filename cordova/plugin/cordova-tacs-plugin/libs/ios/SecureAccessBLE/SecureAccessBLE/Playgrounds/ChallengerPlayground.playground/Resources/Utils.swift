//
//  Utils.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 26/08/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

import Foundation

func rotateLeft(v: UInt8, n: UInt8) -> UInt8 {
    return ((v << n) & 0xFF) | (v >> (8 - n))
}

func rotateLeft(v: UInt16, n: UInt16) -> UInt16 {
    return ((v << n) & 0xFFFF) | (v >> (16 - n))
}

func rotateLeft(v: UInt32, n: UInt32) -> UInt32 {
    return ((v << n) & 0xFFFF_FFFF) | (v >> (32 - n))
}

func rotateLeft(x: UInt64, n: UInt64) -> UInt64 {
    return (x << n) | (x >> (64 - n))
}

func rotateRight(x: UInt16, n: UInt16) -> UInt16 {
    return (x >> n) | (x << (16 - n))
}

func rotateRight(x: UInt32, n: UInt32) -> UInt32 {
    return (x >> n) | (x << (32 - n))
}

func rotateRight(x: UInt64, n: UInt64) -> UInt64 {
    return ((x >> n) | (x << (64 - n)))
}

func reverseBytes(value: UInt32) -> UInt32 {
    return ((value & 0x0000_00FF) << 24) | ((value & 0x0000_FF00) << 8) | ((value & 0x00FF_0000) >> 8) | ((value & 0xFF00_0000) >> 24)
}

func xor(a: [UInt8], b: [UInt8]) -> [UInt8] {
    var xored = [UInt8](count: a.count, repeatedValue: 0)
    for i in 0 ..< xored.count {
        xored[i] = a[i] ^ b[i]
    }
    return xored
}

func perf(text: String, closure: () -> Void) {
    let measurementStart = NSDate()

    closure()

    let measurementStop = NSDate()
    let executionTime = measurementStop.timeIntervalSinceDate(measurementStart)

    print("\(text) \(executionTime)")
}
