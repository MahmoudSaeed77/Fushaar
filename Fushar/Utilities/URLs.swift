//
//  URLs.swift
//  Fushar
//
//  Created by Mohamed Ibrahem on 1/12/22.
//  Copyright © 2022 Mahmoud Saeed. All rights reserved.
//

import Foundation

class URLs {
    public static let baseUrl = "https://fushaar.app/api/posts-ios.php?id="
    public static let allPostsUrl = "https://www.fushaar.net/wp-json/wp/v2/posts/?per_page=50&page="
    public static let allDepartmentsUrl = "https://www.fushaar.net/wp-json/wp/v2/type"
    public static let departmentMoviesUrl = "https://www.fushaar.net/wp-json/wp/v2/posts?type="
    public static let bannerUrl = "https://fushaar.app/api/slider.php"
    public static let adsUrl = "https://fushaar.app/api/ads.php"
    public static let login = "https://www.fushaar.net/api/user/generate_auth_cookie/"
    public static let user = "https://www.fushaar.net/api/user/get_currentuserinfo/?cookie="
}
