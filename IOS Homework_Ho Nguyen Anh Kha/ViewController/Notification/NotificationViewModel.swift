//
//  NotificationViewModel.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import Foundation

final class NotificationViewModel {
    
    var listNotification = [Notification]()
    
    func getListNoti(isEmpty: Bool = false, completion:((_ result: Bool) -> Void)?) {
        Task {
            do {
                let name = isEmpty ? "emptyNotificationList" : "notificationList"
                guard let url = URL(string: "\(APIManager.baseURL)/\(name).json")
                else {
                    completion?(false)
                    return
                }
                let response: ListNotificationResponse = try await fetchAPI(url: url)
                self.listNotification = response.result.messages
                completion?(true)
            }
            catch {
                print(error.localizedDescription)
                completion?(false)
            }
        }
    }
}





