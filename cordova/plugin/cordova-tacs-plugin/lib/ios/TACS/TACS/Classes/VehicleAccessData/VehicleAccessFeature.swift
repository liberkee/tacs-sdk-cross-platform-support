// VehicleAccessFeature.swift
// TACS

// Created on 24.04.19.
// Copyright © 2019 Huf Secure Mobile. All rights reserved.

import Foundation
import SecureAccessBLE

/// Enum describing possible vehicle access features
public enum VehicleAccessFeature: CaseIterable, Equatable {
    /// Feature for unlocking car doors
    case unlock
    /// Feature for locking car doors
    case lock
    /// Feature for enabling ignition
    case enableIgnition
    /// Feature for disabling ignition
    case disableIgnition
    /// Feature for calling up lock-status
    case lockStatus
    /// Feature for calling up ignition-status
    case ignitionStatus

    internal func serviceGrantID() -> ServiceGrantID {
        switch self {
        case .unlock:
            return 0x01
        case .lock:
            return 0x02
        case .lockStatus:
            return 0x03
        case .enableIgnition:
            return 0x04
        case .disableIgnition:
            return 0x05
        case .ignitionStatus:
            return 0x06
        }
    }

    internal init?(serviceGrantID: ServiceGrantID) {
        switch serviceGrantID {
        case 0x01: self = .unlock
        case 0x02: self = .lock
        case 0x03: self = .lockStatus
        case 0x04: self = .enableIgnition
        case 0x05: self = .disableIgnition
        case 0x06: self = .ignitionStatus
        default: return nil
        }
    }
}
