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
                guard let url = URL(string: "\(APIManager.baseURL)/banner.json")
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
    
    func getAllAmount(isPullRequest: Bool = false, completion:(() -> Void)?) {
        Task {
            self.usdAmount = await getAmount(with: "usd", isPullRequest: isPullRequest)
            self.khrAmount = await getAmount(with: "khr", isPullRequest: isPullRequest)
            completion?()
        }
    }
    
    func getListFavarite(isPullRequest: Bool = false, completion:((_ result: Bool) -> Void)?) {
        Task {
            do {
                let name = isPullRequest ? "favoriteList" : "emptyFavoriteList"
                guard let url = URL(string: "\(APIManager.baseURL)/\(name).json")
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
    private func getAmount(with symbol: String, isPullRequest: Bool = false) async -> Double {
        let number = isPullRequest ? "2" : "1"
       let urlSaving = URL(string: "\(APIManager.baseURL)/\(symbol)Savings\(number).json")!
       let urlFixed = URL(string: "\(APIManager.baseURL)/\(symbol)Fixed\(number).json")!
       let urlDigital = URL(string: "\(APIManager.baseURL)/\(symbol)Digital\(number).json")!
       
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
