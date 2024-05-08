//
//  Notification.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

struct Notification: Codable, Hashable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

struct NotificationResult: Codable, Hashable {
    let messages: [Notification]
}

struct ListNotificationResponse: Codable, Hashable {
    let msgCode: String
    let msgContent: String
    let result: NotificationResult
}
