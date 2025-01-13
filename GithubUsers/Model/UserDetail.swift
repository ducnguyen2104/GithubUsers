//
//  UserDetail.swift
//  GithubUsers
//
//  Created by LAP15284 on 11/1/25.
//

struct UserDetail: Decodable, Identifiable, Hashable {
    
    let id: String //username
    let avatarUrl: String
    let landingPageUrl: String
    let location: String?
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "login"
        case avatarUrl = "avatar_url"
        case landingPageUrl = "html_url"
        case location
        case followers
        case following
    }
    
    init?(userDetailLocal: UserDetailLocal) {
        guard let id = userDetailLocal.id,
              let avatarUrl = userDetailLocal.avatarUrl,
              let landingPageUrl = userDetailLocal.landingPageUrl else {
            return nil
        }
        self.id = id
        self.avatarUrl = avatarUrl
        self.landingPageUrl = landingPageUrl
        self.location = userDetailLocal.location
        self.followers = Int(userDetailLocal.followers)
        self.following = Int(userDetailLocal.following)
    }
    
    init(id: String, avatarUrl: String, landingPageUrl: String, location: String, followers: Int, following: Int) {
        self.id = id
        self.avatarUrl = avatarUrl
        self.landingPageUrl = landingPageUrl
        self.location = location
        self.followers = followers
        self.following = following
    }
}

extension UserDetail {
    static var dummy: UserDetail {
        .init(id: "ducnguyen",
              avatarUrl: "https://picsum.photos/200",
              landingPageUrl: "https://google.com/",
              location: "HCMC",
              followers: Int.random(in: 0...1000),
              following: Int.random(in: 0...1000))
    }
}
