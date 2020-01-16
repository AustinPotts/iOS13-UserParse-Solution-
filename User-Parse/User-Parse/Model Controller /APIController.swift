//
//  APIController.swift
//  User-Parse
//
//  Created by Austin Potts on 1/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class APIController {
    
    var user: [User] = []
    
    let baseURL = URL(string: "https://randomuser.me/api/?format=json&results=20")!
    
    typealias CompletionHandler = (Error?) -> Void
    
    func getUsers(completion: @escaping CompletionHandler) {
        
        URLSession.shared.dataTask(with: baseURL) {(data, _, error) in
            
            if let error = error {
                NSLog("Error getting users\(error)")
                completion(nil)
                return
                
            }
            
            guard let data = data else {
                NSLog("No data")
                completion(nil)
                return
            }
            
            do {
                
                let newUsers = try JSONDecoder().decode(UserResults.self, from: data)
                print(newUsers)
                self.user = newUsers.results
            } catch {
                NSLog("Error decoding users: \(error)")
                completion(error)
            }
            completion(nil)
        }.resume()
        
    }
    
    
    
    
}
