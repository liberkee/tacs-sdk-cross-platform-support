//
//  SHA1.swift
//  CryptoSwift
//
//  Created by Marcin Krzyzanowski on 16/08/14.
//  Copyright (c) 2014 Marcin Krzyzanowski. All rights reserved.
//

import Foundation

final class SHA1: HashProtocol {
    var size: Int = 20 // 160 / 8
    let message: NSData

    init(_ message: NSData) {
        self.message = message
    }

    private let h: [UInt32] = [0x6745_2301, 0xEFCD_AB89, 0x98BA_DCFE, 0x1032_5476, 0xC3D2_E1F0]

    func calculate() -> NSData {
        let tmpMessage = prepare(64)

        // hash values
        var hh = h

        // append message length, in a 64-bit big-endian integer. So now the message length is a multiple of 512 bits.
        tmpMessage.appendBytes((message.length * 8).bytes(64 / 8))

        // Process the message in successive 512-bit chunks:
        let chunkSizeBytes = 512 / 8 // 64
        for chunk in NSDataSequence(chunkSize: chunkSizeBytes, data: tmpMessage) {
            // break chunk into sixteen 32-bit words M[j], 0 ≤ j ≤ 15, big-endian
            // Extend the sixteen 32-bit words into eighty 32-bit words:
            var M: [UInt32] = [UInt32](count: 80, repeatedValue: 0)
            for x in 0 ..< M.count {
                switch x {
                case 0 ... 15:
                    var le: UInt32 = 0
                    chunk.getBytes(&le, range: NSRange(location: x * sizeofValue(M[x]), length: sizeofValue(M[x])))
                    M[x] = le.bigEndian
                default:
                    M[x] = rotateLeft(M[x - 3] ^ M[x - 8] ^ M[x - 14] ^ M[x - 16], n: 1) // FIXME: n:
                }
            }

            var A = hh[0]
            var B = hh[1]
            var C = hh[2]
            var D = hh[3]
            var E = hh[4]

            // Main loop
            for j in 0 ... 79 {
                var f: UInt32 = 0
                var k: UInt32 = 0

                switch j {
                case 0 ... 19:
                    f = (B & C) | ((~B) & D)
                    k = 0x5A82_7999
                case 20 ... 39:
                    f = B ^ C ^ D
                    k = 0x6ED9_EBA1
                case 40 ... 59:
                    f = (B & C) | (B & D) | (C & D)
                    k = 0x8F1B_BCDC
                case 60 ... 79:
                    f = B ^ C ^ D
                    k = 0xCA62_C1D6
                default:
                    break
                }

                let temp = (rotateLeft(A, n: 5) &+ f &+ E &+ M[j] &+ k) & 0xFFFF_FFFF
                E = D
                D = C
                C = rotateLeft(B, n: 30)
                B = A
                A = temp
            }

            hh[0] = (hh[0] &+ A) & 0xFFFF_FFFF
            hh[1] = (hh[1] &+ B) & 0xFFFF_FFFF
            hh[2] = (hh[2] &+ C) & 0xFFFF_FFFF
            hh[3] = (hh[3] &+ D) & 0xFFFF_FFFF
            hh[4] = (hh[4] &+ E) & 0xFFFF_FFFF
        }

        // Produce the final hash value (big-endian) as a 160 bit number:
        let buf: NSMutableData = NSMutableData()
        for item in hh {
            var i: UInt32 = item.bigEndian
            buf.appendBytes(&i, length: sizeofValue(i))
        }

        return buf.copy() as! NSData
    }
}
