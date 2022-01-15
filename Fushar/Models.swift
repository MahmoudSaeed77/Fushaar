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
