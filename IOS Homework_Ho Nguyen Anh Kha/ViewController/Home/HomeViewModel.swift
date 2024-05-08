//
//  HomeViewModel.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation
import Alamofire

class HomeViewModel {
    var listAdBanner: [AdBanner] = [AdBanner]()
    
    func getListNoti() {
        AF.request("https://willywu0201.github.io/data/notificationList.json")
            .responseDecodable(of: ListNotificationResponse.self) { (response) in
            switch response.result {
            case .success(let data):
                print(data.result.messages.count)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getAdBanner(completion:((_ result: Bool) -> Void)?) {
        AF.request("https://willywu0201.github.io/data/banner.json")
            .responseDecodable(of: AdBannerResponse.self) { (response) in
            switch response.result {
            case .success(let data):
                self.listAdBanner = data.result.bannerList
                completion?(true)
            case .failure(let err):
                print(err.localizedDescription)
                completion?(false)
            }
        }
    }
}
