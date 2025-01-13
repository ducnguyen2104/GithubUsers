//
//  User.swift
//  GithubUsers
//
//  Created by LAP15284 on 10/1/25.
//

public struct User: Decodable, Identifiable, Hashable {
    public let id: String //username
    public let avatarUrl: String
    public let landingPageUrl: String

    enum CodingKeys: String, CodingKey {
        case id = "login"
        case avatarUrl = "avatar_url"
        case landingPageUrl = "html_url"
    }
    
    init?(userLocal: UserLocal) {
        guard let id = userLocal.id,
              let avatarUrl = userLocal.avatarUrl,
              let landingPageUrl = userLocal.landingPageUrl else {
            return nil
        }
        self.id = id
        self.avatarUrl = avatarUrl
        self.landingPageUrl = landingPageUrl
    }
    
    public init(id: String, avatarUrl: String, landingPageUrl: String) {
        self.id = id
        self.avatarUrl = avatarUrl
        self.landingPageUrl = landingPageUrl
    }
}

extension User {
    static var dummy: User {
        .init(id: "ducnguyen",
              avatarUrl: "https://picsum.photos/200",
              landingPageUrl: "https://google.com/")
    }
}

extension User {
    public func isValid() -> Bool {
        return !id.isEmpty
    }
}
