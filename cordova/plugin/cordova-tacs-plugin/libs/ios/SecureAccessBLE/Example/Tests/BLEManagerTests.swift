//
//  BLEManagerTests.swift
//  SecureAccessBLE
//
//  Created on 03.10.16.
//  Copyright © 2016 Huf Secure Mobile GmbH. All rights reserved.
//

import CoreBluetooth
import CryptoSwift
@testable import SecureAccessBLE
import XCTest

// TODO: PLAM-1568 remove this file after ticket is done
/// This class is outdated, but maybe the comments give you some sample code how to test something
class BLEManagerTests: XCTestCase {
    //    var bleManager: BLEManager!
    //    var bleCommunicator: SorcDataCommunicator!
    //    let centralManagerMock = CBCentralManagerMock()
    //    var connectionManager: ConnectionManager!
    //
    //    override func setUp() {
    //        super.setUp()
    //        connectionManager = ConnectionManager(centralManager: centralManagerMock)
    //        bleCommunicator = SorcDataCommunicator(transporter: connectionManager)
    //        bleManager = BLEManager(sorcConnectionManager: connectionManager, communicator: bleCommunicator)
    //        bleCommunicator.delegate = bleManager
    //    }
    //
    //    /**
    //     To test changing connection state in connectionManager and communicator, and corresposing changed connection
    //     states for BLE-manager
    //     */
    //    func testChangingConnectionState() {
    //
    //        // power on
    //        centralManagerMock.state = .poweredOn
    //        connectionManager.centralManagerDidUpdateState_(centralManagerMock)
    //
    //        // assert not connected
    //        XCTAssertFalse(isBLEManagerConnected(), "BLE manager has wrong connection state")
    //
    //        // simulate SORC connection
    //        let leaseToken = LeaseToken(id: "id", leaseID: "leaseID", sorcID: "1a", sorcAccessKey: "key")
    //        let leaseTokenBlob = LeaseTokenBlob(messageCounter: 1, data: "")
    //        bleManager.connectToSorc(leaseToken: leaseToken, leaseTokenBlob: leaseTokenBlob)
    //        connectionManager.connectionChange.onNext(.init(state: .connected(sorcID: "1a"),
    //                                                        action: .connectionEstablished(sorcID: "1a")))
    //
    //        /// ble manager is not connected because crypto was Not established even with connected connectionManager
    //        XCTAssertFalse(isBLEManagerConnected(), "BLE manager has wrong connection state")
    //
    //        /// Mock session key for crypto
    //        let mockSessionKey = [0xA9, 0xBA, 0x14, 0xA1, 0x50, 0x20, 0x9F, 0xE2, 0x30, 0xE7, 0x1A, 0x2B, 0x78, 0x0F, 0x06, 0x45] as [UInt8]
    //
    //        /// To change crypto status in blemanager
    //        bleManager.challengerFinishedWithSessionKey(mockSessionKey)
    //
    //        /// The blemanager must be now connected because connectionManager connected and crypto established
    //        XCTAssertTrue(isBLEManagerConnected(), "BLE manager has wrong connection state")
    //    }
    //
    //    private func isBLEManagerConnected() -> Bool {
    //        if case .connected = bleManager.connectionChange.state { return true } else { return false }
    //    }
    //
    //    /**
    //     To test ble manager sending and receiving message
    //     */
    //    func testSendingAndReceivingMessage() {
    //
    //        // simulate SORC connection, which triggers an mtu message
    //        let leaseToken = LeaseToken(id: "id", leaseID: "leaseID", sorcID: "1a", sorcAccessKey: "key")
    //        let leaseTokenBlob = LeaseTokenBlob(messageCounter: 1, data: "")
    //        bleManager.connectToSorc(leaseToken: leaseToken, leaseTokenBlob: leaseTokenBlob)
    //        connectionManager.connectionChange.onNext(.init(state: .connected(sorcID: "1a"),
    //                                                        action: .connectionEstablished(sorcID: "1a")))
    //
    //        /// MTU response data with size
    //        let bytes = [0x07, 0x9B, 0x00] as [UInt8]
    //        bleCommunicator.delegate?.communicatorDidReceivedData(Data(bytes: bytes), count: 1)
    //
    //        /// MTU size for ios device is default 155
    //        XCTAssertEqual(BLEManager.mtuSize, 155, "BLE manager has wrong MTU Size number!")
    //    }
    //
    //    /**
    //     To test ble manager sending and receiving service Grant
    //     */
    //    func testSendingAndReceivingServiceGrant() {
    //        /// Mock session key for crypto
    //        let mockSessionKey = [0xA9, 0xBA, 0x14, 0xA1, 0x50, 0x20, 0x9F, 0xE2, 0x30, 0xE7, 0x1A, 0x2B, 0x78, 0x0F, 0x06, 0x45] as [UInt8]
    //        // let mockSessionKey = Cipher.randomIV(16) as [UInt8]
    //
    //        /// Ble manager with established AES crypto manager
    //        bleManager.challengerFinishedWithSessionKey(mockSessionKey)
    //
    //        /// Service grant for .Lockstatus will sent to SORC
    //        let payload = ServiceGrantRequest(grantID: FeatureServiceGrantID.lockStatus)
    //        let message = SorcMessage(id: SorcMessageID.serviceGrant, payload: payload)
    //
    //        /// Sending is success or not
    //        let sendingSuccess = bleManager.sendMessage(message)
    //
    //        /// Test if sending error was NIL
    //        XCTAssertNil(sendingSuccess.error, "Sending service grant message did failed!")
    //
    //        /// Test if sending if success
    //        XCTAssertTrue(sendingSuccess.success, "Sending service grant message did failed!")
    //
    //        bleCommunicator.delegate = bleManager
    //
    //        /// Mock data with service trigger status Locked
    //        let mockBytes = [0xD3, 0x7D, 0x36, 0x92, 0xBE, 0xB0, 0xF2, 0xDE, 0x36, 0xD8, 0x75, 0xF9, 0xBB, 0x4C, 0xF3, 0x00, 0xF5, 0xF9, 0x54, 0x83,
    //                         0x62, 0x54, 0xBF, 0xAF] as [UInt8]
    //        let mockReceivedData = Data(bytes: UnsafePointer<UInt8>(mockBytes), count: mockBytes.count)
    //
    //        /// ble manager will be reported for receiving data
    //        bleCommunicator.delegate?.communicatorDidReceivedData(mockReceivedData as Data, count: mockReceivedData.count / 4)
    //
    //        /// AES cryptor will initialized
    //        var cryptor = AesCbcCryptoManager(key: mockSessionKey)
    //        /// The received data must be decrpted
    //        let receivedMessage = cryptor.decryptData(mockReceivedData as Data)
    //
    //        /// service grant trigger builded from received message
    //        let serviceGrantTrigger = ServiceGrantTrigger(rawData: receivedMessage.message)
    //
    //        /// Testing if service grant trigger has ID .Lockstatus
    //        XCTAssertEqual(serviceGrantTrigger.id, FeatureServiceGrantID.lockStatus, "BLE manager received wrong service grant ID!")
    //
    //        /// Testing if service grant trigger has result .Locked
    //        XCTAssertEqual(serviceGrantTrigger.result, ServiceGrantTrigger.ServiceGrantResult.locked,
    //                       "BLE manager received wrong service grant result!")
    //    }
    //
    //    /**
    //     To test ble manager sending blob data
    //     */
    //    func testSendingBlob() {
    //        /// Mock session key for crypto
    //
    //        let mockSessionKey = [0xA9, 0xBA, 0x14, 0xA1, 0x50, 0x20, 0x9F, 0xE2, 0x30, 0xE7, 0x1A, 0x2B, 0x78, 0x0F, 0x06, 0x45] as [UInt8]
    //
    //        /// Ble manager with established AES crypto manager
    //        bleManager.challengerFinishedWithSessionKey(mockSessionKey)
    //
    //        /// Mock blob data for sending message
    // swiftlint:disable line_length
    //        let mockBlobData = "ASUL8kKdjE8oluIDDf5gG9gBAR0EAABk7qoX/DOQLkqSiekGa8Qif9oaLZFDT7hwQnTV4/in+63QEkOImLL0lu0hxrXy6U732cNU2m4eeEHtOaQuecEURgtD32S6Al2WDEuA891mJv/wbbexa2y1OprUef9WyO7xvvkeSGX0nnfaoPbpPePJJxqI/E/yaQyayQD8TLQqd9q4IYFoOxlchlKic/2nE7Hyvx+5oLIREipxIb92A8J8vGKLhDOglGFlI2QAIhe9vFRnCJ3r1TQ+ulsnLiyQ3OByChBp3rnQ0h9KnLWmiRYOHcZIRHGILPlBDaMYWp1lsvL86zqzyKMXjQ2u8I3kqrKanSOqQkoh4MvYbF+hXvO/nQf9yT6cdnr4sZKjLUOBqzBRnprK1D45f8tU6CMjqssc7o/iqwlWrouKHcr8vWatt9o82AyMSWm7O36UHUEdr29wbFgwTQNH0fOkuOOoy+Nf69MbD8oJeuwFFgXjrbW8coEHgUr7La2R5IW+HHGA+HaFrsWPMPJrqsUdcGIe8nPErmby2bhKu98AGcYYWdbFZHJ4fx4SBAW5sR5hgkx8Tj4IC/WVe0uUStbgVemxnviPSDAL8NkefytZbXEdWxxXyYagFnVb3Y+JXosh07LcuZswGc9uOlGm5b3yjQgB9gJyzs2kGIhLw6yiQhl8KYqsDr3cZitxv9c7eLOf1CzyLjMI0RU14qadxqQl/aOdIvY0r3MTmJmCTtFQyKXJ7xKWk2rBFA5dRTjq99Nw9w6weHN7mWBmuP7+SMMdeP6bcqnVq4BMc9Y/jpf6fjcPTdSsdMY4884m2zWOl1xU29uR9Zz5vi6SodJCXgdyYMXp3Uu7aYLsUVpQz0/FHGJbK9XZHJKMqgsooktSVf3ByCCK7OyFi3L4VU5BD/nCLUDiC1TzjfXRUSJCYFoVqIGaVm3ngtV9JjsZk3kjrXayv8fTzs+ytm/Q2/+NPl3v80CBSrgljdkKt2DORY38pkANSemnh6atWL2u318ORSqRS7qb5gqwZ6US9e4lkHz9dgmeMWbmMxrE9MM0XFfFFDK4Cx/hxkeelAQb7HT50GE1EWpUgF+CMBXm4d6t3XFHlpI4r7NjJp6gysLwl/O1859PurQV5F7kgrmATxF9+Xf76t6jzNbrjkwIC5RtV3K2FYR5H3ani2vJRKpkzPfpaChZUb8M"
    // swiftlint:enable line_length
    //        /// To build sending blob message
    //        let payload = LTBlobPayload(blobData: mockBlobData)
    //        let blobMessage = SorcMessage(id: .ltBlob, payload: payload!)
    //
    //        /// Sending success
    //        let sendingSuccess = bleManager.sendMessage(blobMessage)
    //
    //        /// Test if sending error was NIL
    //        XCTAssertNil(sendingSuccess.error, "Sending Lease token blob message did failed!")
    //
    //        /// Test if sending if success
    //        XCTAssertTrue(sendingSuccess.success, "Sending Lease token blob message did failed!")
    //    }
}
