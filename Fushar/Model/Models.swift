//
//  Models.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import Foundation

struct MovieDetailsModel : Codable {
    var id : Int?
    var title : String?
    var arabicname : String?
    var url : String?
    var content : String?
    var date : String?
    var slug : String?
    var gerne : String?
    var img1 : String?
    var poster : String?
    var trailer : String?
    var speacialnote : String?
    var qlyt : String?
    var year : String?
    var rate : String?
    var duration : String?
    var parent : String?
    var boxoffice : String?
    var Access_denied_liste : String?
    var googlecloud : String?
    var uqload : String?
    var vidlox : String?
    var bunnycdnstreamid : String?
    var yandex : String?
    var cynfolder : String?
    var voe : String?
    var uptobox : String?
    var fushaar240 : String?
    var fushaar480 : String?
    var fushaar1080 : String?
    var cloud240 : String?
    var cloud480 : String?
    var cloud1080 : String?


}

typealias Welcome = [MovieDetailsModel]?


struct Movies {
    var id: Int?
    var img1: String?
    var rate: String?
}

class FilmId {
    public static var id: Int?
    public static var catId: Int?
}

struct Departments {
    var id: Int?
    var name: String?
}

struct BannerModel : Codable {
    var postid: String?
    var imgurl : String?
    var targeturl : String?
}
struct AdsModel : Codable {
    var position: String?
    var imgurl : String?
    var targeturl : String?
    var timer: String?
}
class Selected {
    public static var id: Int?
}


struct LoginModel : Codable {
    
    let status : String?
    let cookie : String?
    let cookie_admin : String?
    let cookie_name : String?
    let user : User?
    }
struct User : Codable {
    let id : Int?
    let username : String?
    let nicename : String?
    let email : String?
    let url : String?
    let registered : String?
    let displayname : String?
    let firstname : String?
    let lastname : String?
    let nickname : String?
    let description : String?
    let capabilities : String?
    let avatar : String?

enum CodingKeys: String, CodingKey {
    
    case id = "id"
    case username = "username"
    case nicename = "nicename"
    case email = "email"
    case url = "url"
    case registered = "registered"
    case displayname = "displayname"
    case firstname = "firstname"
    case lastname = "lastname"
    case nickname = "nickname"
    case description = "description"
    case capabilities = "capabilities"
    case avatar = "avatar"
    }

}
