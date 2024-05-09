//
//  HomeViewModel.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

final class HomeViewModel {
    var usdAmount: Double = 0
    var khrAmount: Double = 0
    var favoriteList: [Favorite] = [Favorite]()
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
    
    func getAllAmount(completion:(() -> Void)?) {
        Task {
            self.usdAmount = await getAmount(with: "usd")
            self.khrAmount = await getAmount(with: "khr")            
            completion?()
        }
    }
    
    func getListFavarite(completion:((_ result: Bool) -> Void)?) {
        Task {
            do {
                guard let url = URL(string: "https://willywu0201.github.io/data/favoriteList.json")
                else {
                    completion?(false)
                    return
                }
                let response: ListFavoriteResponse = try await fetchAPI(url: url)
                self.favoriteList = response.result.favoriteList
                completion?(true)
            }
            catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
    }
     
}

// MARK: - Private function
extension HomeViewModel {
    private func getAmount(with symbol: String) async -> Double {
       let urlSaving = URL(string: "https://willywu0201.github.io/data/\(symbol)Savings1.json")!
       let urlFixed = URL(string: "https://willywu0201.github.io/data/\(symbol)Fixed1.json")!
       let urlDigital = URL(string: "https://willywu0201.github.io/data/\(symbol)Digital1.json")!
       
       do {
           var listBalance: [Balance] = [Balance]()
           
           let savingResp: SavingResponse = try await fetchAPI(url: urlSaving)
           listBalance += savingResp.result.savingsList
           
           let FixedDepositedResp: FixedDepositedResponse = try await fetchAPI(url: urlFixed)
           listBalance += FixedDepositedResp.result.fixedDepositList
           
           let digitalResp: DigitalResponse = try await fetchAPI(url: urlDigital)
           listBalance += digitalResp.result.digitalList
           
           return self.geAmounttValue(with: listBalance)
       } catch {
           print(error.localizedDescription)
       }
       return 0
   }
   
   private func geAmounttValue(with arr: [Balance]) -> Double {
      return arr.map({$0.balance}).reduce(0, +)
   }
}
