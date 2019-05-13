//
//  NetworkService.swift
//  SySDataTest
//
//  Created by Сергей Сивагин on 13/05/2019.
//  Copyright © 2019 sivahin. All rights reserved.
//

import Foundation

typealias CompletionBlock<T: Decodable> = ((_ data: T?, _ error: String?) -> Void)

enum MethodType: String {
    case post = "POST"
    case get = "GET"
}

class NetworkService: NSObject {
    
    private func getRequestURL(_ methodPath: String) -> URL {
        return URL(string: String(format: "%@/%@", Constants.serverPath, methodPath))!
    }
    
    func request<T: Decodable>(url: URL, method: MethodType, completion: CompletionBlock<T>?) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion?(nil, error?.localizedDescription)
                }
                return
            }
            let result = try? JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                completion?(result, error?.localizedDescription)
            }
        }.resume()
    }
}

// MARK: - Get users

extension NetworkService {
    
    func getUsers(offset: Int, completion: CompletionBlock<ResponseModel<UserModel>>?) {
        let path = String(format: "?results=%d", offset)
        let url = getRequestURL(path)
        request(url: url, method: .get, completion: completion)
    }
    
    func getUsers(page: Int, limit: Int, completion: CompletionBlock<ResponseModel<UserModel>>?) {
        let path = String(format: "?page=%d&results=%d", page, limit)
        let url = getRequestURL(path)
        request(url: url, method: .get, completion: completion)
    }
}
