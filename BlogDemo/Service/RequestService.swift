//
//  PostService.swift
//  BlogDemo
//
//  Created by Benoit PASQUIER on 25/04/2017.
//  Copyright © 2017 Benoit PASQUIER. All rights reserved.
//

import Foundation

final class RequestService {
    
    // todo add model
    func loadPosts(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return
        }
        
        let request = RequestFactory.request(method: .GET, url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}