//
//  HomeViewModel.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

final class HomeViewModel {
    var listAdBanner: [AdBanner] = [AdBanner]()
    
    func getAdBanner(completion:((_ result: Bool) -> Void)?) {
        Task {
            do {
                guard let url = URL(string: "https://willywu0201.github.io/data/banner.json")
                else {
                    completion?(false)
                    return
                }
                let response: AdBannerResponse = try await fetchAPI(url: url)
                self.listAdBanner = response.result.bannerList
                completion?(true)
            }
            catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
    }   
}
