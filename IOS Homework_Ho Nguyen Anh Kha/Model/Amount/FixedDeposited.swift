//
//  FixedDeposited.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

struct FixedDepositedResult: Codable, Hashable {
    let fixedDepositList: [Balance]
}

struct FixedDepositedResponse: Codable, Hashable {
    let msgCode: String
    let msgContent: String
    let result: FixedDepositedResult
}
