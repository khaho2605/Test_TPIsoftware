//
//  Digital.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

struct DigitalResult: Codable, Hashable {
    let digitalList: [Balance]
}

struct DigitalResponse: Codable, Hashable {
    let msgCode: String
    let msgContent: String
    let result: DigitalResult
}
