//
//  AdBanner.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

struct AdBanner: Codable, Hashable {
    let adSeqNo: Int
    let linkUrl: String
}

struct AdBannerResult: Codable, Hashable {
    let bannerList: [AdBanner]
}

struct AdBannerResponse: Codable, Hashable {
    let msgCode: String
    let msgContent: String
    let result: AdBannerResult
}
