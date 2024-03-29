//
//  AppActivityStatusProvider.swift
//  SecureAccessBLE
//
//  Created on 05.09.17.
//  Copyright © 2018 Huf Secure Mobile GmbH. All rights reserved.
//

import UIKit

class AppActivityStatusProvider: AppActivityStatusProviderType {
    var appDidBecomeActive: EventSignal<Bool> {
        return appDidBecomeActiveSubject.asSignal()
    }

    private let appDidBecomeActiveSubject = PublishSubject<Bool>()

    private let notificationCenter: NotificationCenter

    init(notificationCenter: NotificationCenter) {
        self.notificationCenter = notificationCenter
        notificationCenter.addObserver(
            self,
            selector: #selector(handleAppDidBecomeActive),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )

        notificationCenter.addObserver(
            self,
            selector: #selector(handleAppDidEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    @objc private func handleAppDidBecomeActive() {
        appDidBecomeActiveSubject.onNext(true)
    }

    @objc private func handleAppDidEnterBackground() {
        appDidBecomeActiveSubject.onNext(false)
    }
}
