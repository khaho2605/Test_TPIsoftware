//
//  API.swift
//  IOS Homework_Ho Nguyen Anh Kha
//
//  Created by Kha on 8/5/24.
//

import UIKit
import Foundation

// MARK: Extensions
extension URLSession {
    func data(url: URL) async throws -> Data {
        try await withCheckedThrowingContinuation({ c in
            dataTask(with: url) { data, _, error in
                if let error = error {
                    c.resume(throwing: APIError.error(error.localizedDescription))
                } else {
                    if let data = data {
                        c.resume(returning: data)
                    } else {
                        c.resume(throwing: APIError.error("Bad response"))
                    }
                }
            }.resume()
        })
    }
}

// MARK: Fetch Functions

// MARK: ASYNC
func fetchAPI<T: Decodable>(url: URL) async throws -> T {
    let data = try await URLSession.shared.data(url: url)
    let decodeData = try JSONDecoder().decode(T.self, from: data)
    return decodeData
}

// MARK: GROUP APIs
func fetchAPIs<T: Decodable>(urls: [URL]) async throws -> [T] {
    try await withThrowingTaskGroup(of: T.self, body: { group in
        
        for url in urls {
            group.addTask {
                try await fetchAPI(url: url)
            }
        }
        
        var results = [T]()
        for try await result in group {
            results.append(result)
        }
        return results
    })
}

// MARK: COMPLETION HANDEL
func fetchAPI<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
            completion(.failure(APIError.error("Bad HTTP Response")))
            return
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedData))
        } catch {
            completion(.failure(error))
        }
    }
    .resume()
}

// MARK: - IMAGE DOWNLOADER
func fetchImage(url: URL, completion: @escaping (UIImage?) -> ()) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if error != nil {
            completion(nil)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
            completion(nil)
            return
        }
        
        let image = UIImage(data: data)
        completion(image)
    }
    .resume()
}

func fetchImage(url: URL) async throws -> UIImage? {
    let (data, _)  = try await URLSession.shared.data(from: url)
    return UIImage(data: data)

}
