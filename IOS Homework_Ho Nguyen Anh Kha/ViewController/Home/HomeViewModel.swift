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
    
    
    func getAmount() {
        let urlSaving = URL(string: "https://willywu0201.github.io/data/usdSavings1.json")!
        let urlFixed = URL(string: "https://willywu0201.github.io/data/usdFixed1.json")!
        let urlDigital = URL(string: "https://willywu0201.github.io/data/usdDigital1.json")!
        
        Task {
            do {
                var listBalance: [Balance] = [Balance]()

                let savingResp: SavingResponse = try await fetchAPI(url: urlSaving)
                listBalance += savingResp.result.savingsList
                
                let FixedDepositedResp: FixedDepositedResponse = try await fetchAPI(url: urlFixed)
                listBalance += FixedDepositedResp.result.fixedDepositList
                
                let digitalResp: DigitalResponse = try await fetchAPI(url: urlDigital)
                listBalance += digitalResp.result.digitalList
                
                self.usdAmount = self.geAmounttValue(with: listBalance)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getKHRAmount() {
        let urlSaving = URL(string: "https://willywu0201.github.io/data/khrSavings1.json")!
        let urlFixed = URL(string: "https://willywu0201.github.io/data/khrFixed1.json")!
        let urlDigital = URL(string: "https://willywu0201.github.io/data/khrDigital1.json")!
        Task {
            do {
                var listBalance: [Balance] = [Balance]()

                let savingResp: SavingResponse = try await fetchAPI(url: urlSaving)
                listBalance += savingResp.result.savingsList
                
                let FixedDepositedResp: FixedDepositedResponse = try await fetchAPI(url: urlFixed)
                listBalance += FixedDepositedResp.result.fixedDepositList
                
                let digitalResp: DigitalResponse = try await fetchAPI(url: urlDigital)
                listBalance += digitalResp.result.digitalList
                
                self.usdAmount = self.geAmounttValue(with: listBalance)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func geAmounttValue(with arr: [Balance]) -> Double {
       return arr.map({$0.balance}).reduce(0, +)
    }
}
