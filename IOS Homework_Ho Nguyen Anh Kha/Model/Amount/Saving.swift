//
//  Saving.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

struct Balance: Codable, Hashable {
    let account: String
    let curr: String
    let balance: Double
}

struct SavingResult: Codable, Hashable {
    let savingsList: [Balance]
}

struct SavingResponse: Codable, Hashable {
    let msgCode: String
    let msgContent: String
    let result: SavingResult
}
