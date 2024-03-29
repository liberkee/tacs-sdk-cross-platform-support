//
//  DataFramePackage.swift
//  SecureAccessBLE
//
//  Created on 03.10.16.
//  Copyright © 2016 Huf Secure Mobile GmbH. All rights reserved.
//

/// Creates and holds data Frames for a SorcMessage
class DataFramePackage: NSObject {
    /// Date frame list
    var frames = [DataFrame]()
    /// start index
    var currentIndex = 0
    /// Dateframe current used
    var currentFrame: DataFrame? {
        if frames.isEmpty || currentIndex > frames.count - 1 {
            return nil
        } else {
            let frame = frames[currentIndex]
            return frame
        }
    }

    /// The message data the SorcMessage contains
    var message: Data {
        var data = Data()

        for frame in frames {
            data.append(frame.message)
        }
        return data
    }

    /**
     convenience initialization point

     - parameter messageData: the message data SorcMessage contains
     - parameter frameSize:   the data frame size

     - returns: Data frame package objec
     */
    convenience init(messageData: Data, frameSize: Int) {
        var frameStack = [DataFrame]()
        let messageSize = messageData.count
        var numberOfFrames = messageSize / frameSize
        if numberOfFrames == 0 || messageSize % frameSize != 0 {
            numberOfFrames += 1
        }

        // Create the frames
        for i in 0 ..< numberOfFrames {
            // Configure frame type
            let type = DataFramePackage.configureType(i, numberOfFrames: numberOfFrames)
            let sequence = i
            let location = i * frameSize
            let frameLength: Int = {
                if location + frameSize > messageSize {
                    return messageSize - location
                } else {
                    return frameSize
                }
            }()

            let messagePart = messageData.subdata(in: location ..< location + frameLength) // NSMakeRange(location, frameLength))
            let frame = DataFrame(message: messagePart, type: type, sequenceNumber: UInt8(sequence), completeMessageLength: UInt16(messageData.count))
            frameStack.append(frame)
        }

        self.init()
        frames = frameStack
    }

    // MARK: - Helper

    fileprivate class func configureType(_ sequence: Int, numberOfFrames: Int) -> DataFrameType {
        /// Start type as NotValid
        var type = DataFrameType.notValid
        if sequence == 0, numberOfFrames == 1 {
            type = .single
        } else if sequence == 0 {
            type = .sop
        } else if sequence == numberOfFrames - 1 {
            type = .eop
        } else {
            type = .frag
        }
        return type
    }
}
