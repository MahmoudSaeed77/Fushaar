//
//  DetailsApiManager.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DetailsDelegate {
    func completeGetFilm(response: Welcome)
    func failedGetFilm(error: String)
}

protocol FilmsDelegate {
    func completeGetFilms(response: [Movies])
    func failedGetFilms(error: String)
}

protocol DepartmentsDelegate {
    func completeGetDepartments(response: [Departments])
    func failedGetDepartments(error: String)
}
protocol BannerDelegate {
    func completeGetBanner(response: [BannerModel])
    func failedGetBanner(error: String)
}
protocol AdsDelegate {
    func completeGetAds(response: [AdsModel])
    func failedGetAds(error: String)
}

class DetailsApiManager {
    public static let sharedInstance = DetailsApiManager()
    
    func getAllFilms(pageNum: Int, header: HTTPHeaders, responseDelegate: FilmsDelegate?) {
        Alamofire.request(URLs.allPostsUrl+"\(pageNum)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            guard let data = response.data else {return}
            guard let delegete = responseDelegate else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSON(data: data)
                    var d = [Movies]()
                    for i in json {
                        let rate = i.1["movieinfo"]["rate"].string ?? ""
                        let img = i.1["jetpack_featured_media_url"].string ?? ""
                        let id = i.1["id"].int ?? 0
                        d.append(Movies(id: id, img1: img, rate: rate))
                    }
                    delegete.completeGetFilms(response: d)
                } catch let err {
                    print(err.localizedDescription)
                    delegete.failedGetFilms(error: err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
                delegete.failedGetFilms(error: err.localizedDescription)
            }
        }
    }
    
    
    func getFilmDetails(header: HTTPHeaders, id: String, responseDelegate: DetailsDelegate?) {
        Alamofire.request(URLs.baseUrl + id, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            debugPrint(response)
            guard let data = response.data else {return}
            guard let delegete = responseDelegate else {return}
            
            switch response.result {
            case .success(_):
                do {
                    print(response.description)
                    let json = try JSONDecoder().decode(Welcome.self, from: data)
                    delegete.completeGetFilm(response: json)
                } catch let err {
                    print(err.localizedDescription)
                    delegete.failedGetFilm(error: err.localizedDescription)
                }
            case .failure(let err):
                delegete.failedGetFilm(error: err.localizedDescription)
            }
        }
    }
    
    
    func getAllDepartments(header: HTTPHeaders, responseDelegate: DepartmentsDelegate?) {
        Alamofire.request(URLs.allDepartmentsUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            guard let data = response.data else {return}
            guard let delegete = responseDelegate else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSON(data: data)
                    var d = [Departments]()
                    for i in json {
                        let name = i.1["description"].string ?? ""
                        let id = i.1["id"].int ?? 0
                        d.append(Departments(id: id, name: name))
                    }
                    delegete.completeGetDepartments(response: d)
                } catch let err {
                    print(err.localizedDescription)
                    delegete.failedGetDepartments(error: err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
                delegete.failedGetDepartments(error: err.localizedDescription)
            }
        }
    }
    
    
    func getDepartmentMovies(header: HTTPHeaders, id: Int, responseDelegate: FilmsDelegate?) {
        Alamofire.request(URLs.departmentMoviesUrl + "\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            guard let data = response.data else {return}
            guard let delegete = responseDelegate else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSON(data: data)
                    var d = [Movies]()
                    for i in json {
                        let rate = i.1["movieinfo"]["rate"].string ?? ""
                        let img = i.1["jetpack_featured_media_url"].string ?? ""
                        let id = i.1["id"].int ?? 0
                        d.append(Movies(id: id, img1: img, rate: rate))
                    }
                    delegete.completeGetFilms(response: d)
                } catch let err {
                    print(err.localizedDescription)
                    delegete.failedGetFilms(error: err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
                delegete.failedGetFilms(error: err.localizedDescription)
            }
        }
    }
    
    func getBanners(header: HTTPHeaders, responseDelegate: BannerDelegate?) {
        Alamofire.request(URLs.bannerUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            debugPrint(response)
            
            guard let data = response.data else {return}
            guard let delegete = responseDelegate else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSON(data: data)
                    var d = [BannerModel]()
                    for i in json {
                        let imgurl = i.1["imgurl"].string ?? ""
                        let targeturl = i.1["targeturl"].string ?? ""
                        d.append(BannerModel(imgurl: imgurl, targeturl: targeturl))
                    }
                    delegete.completeGetBanner(response: d)
                } catch let err {
                    print(err.localizedDescription)
                    delegete.failedGetBanner(error: err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
                delegete.failedGetBanner(error: err.localizedDescription)
            }
        }
    }
    
    func getAds(header: HTTPHeaders, responseDelegate: AdsDelegate?) {
        Alamofire.request(URLs.adsUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            debugPrint(response)
            
            guard let data = response.data else {return}
            guard let delegete = responseDelegate else {return}
            
            switch response.result {
            case .success(_):
                do {
                    let json = try JSON(data: data)
                    var d = [AdsModel]()
                    for i in json {
                        let imgurl = i.1["imgurl"].string ?? ""
                        let targeturl = i.1["targeturl"].string ?? ""
                        let timer = i.1["timer"].string ?? ""
                        let position = i.1["position"].string ?? ""
                        d.append(AdsModel(position: position, imgurl: imgurl, targeturl: targeturl, timer: timer))
                    }
                    delegete.completeGetAds(response: d)
                } catch let err {
                    print(err.localizedDescription)
                    delegete.failedGetAds(error: err.localizedDescription)
                }
            case .failure(let err):
                    print(err.localizedDescription)
                delegete.failedGetAds(error: err.localizedDescription)
            }
        }
    }
    
}
