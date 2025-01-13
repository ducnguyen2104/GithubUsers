//
//  GithubUsersEndpoint.swift
//  GithubUsers
//
//  Created by LAP15284 on 10/1/25.
//
import Foundation

enum GithubUsersEndPoint {
    case list(numPerPage: Int, since: Int)
    case detail(username: String)
}

extension GithubUsersEndPoint: EndPointType {
    
    var baseURL: String {
        return "https://api.github.com/"
    }
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    var path: String {
        switch self {
        case .list(let numPerpage, let since):
            return "users?per_page=\(numPerpage)&since=\(since)"
        case .detail(username: let username):
            return "users/\(username)"
        }
    }
    
    var body: Encodable? {
        nil
    }

    var headers: [String : String]? {
        APIManager.commonHeaders
    }

    var method: HTTPMethod {
        .get
    }
    
}
