//
//  UserDefaultsManager.swift
//  Raqeb
//
//  Created by apple on 8/24/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation

class UserDefaultsManager {
    public static let sharedInstance = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    func saveUserToken(token: String) {
        defaults.set(token, forKey: "token")
    }
    
    func getUserToken() -> String {
        return defaults.value(forKey: "token") as? String ?? ""
    }
}
