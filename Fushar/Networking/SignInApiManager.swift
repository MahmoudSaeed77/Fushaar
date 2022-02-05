//
//  SignInApiManager.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 2/1/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import Foundation
import Alamofire

protocol LoginDelegate {
    func completeLogin(response: LoginModel)
    func failedLogin(error: String)
}

class SignInApiManager {
    
    public static let sharedInstance = SignInApiManager()
    
    
    
    func login(email: String, pass: String, responseDelegate: LoginDelegate?) {
        Alamofire.request(URLs.login+"?email=\(email)&password=\(pass)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            debugPrint(response)
            
            guard let data = response.data else {return}
            guard let delegate = responseDelegate else {return}
            
            do {
                let json = try JSONDecoder().decode(LoginModel.self, from: data)
                if response.response?.statusCode == 200 {
                    delegate.completeLogin(response: json)
                } else {
                    delegate.failedLogin(error: "Error")
                }
            } catch let err {
                delegate.failedLogin(error: err.localizedDescription)
            }
        }
    }
    
    func getUserData(header: HTTPHeaders, responseDelegate: LoginDelegate?) {
        UserDefaults.standard.synchronize()
        let urlString = URLs.user+UserDefaultsManager.sharedInstance.getUserToken()
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),let url = URL(string: encoded) {
            print("jknvkjdfn", UserDefaultsManager.sharedInstance.getUserToken())
            Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                        debugPrint(response)
                        
                        guard let data = response.data else {return}
                        guard let delegate = responseDelegate else {return}
                        
                        do {
                            let json = try JSONDecoder().decode(LoginModel.self, from: data)
                            if response.response?.statusCode == 200 {
                                delegate.completeLogin(response: json)
                            } else {
                                delegate.failedLogin(error: "Error")
                            }
                        } catch let err {
                            delegate.failedLogin(error: err.localizedDescription)
                        }
                    }
        }
        
        
    }

}
