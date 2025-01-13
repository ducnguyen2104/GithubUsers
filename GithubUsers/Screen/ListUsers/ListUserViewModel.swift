//
//  ListUserViewModel.swift
//  GithubUsers
//
//  Created by LAP15284 on 10/1/25.
//

import Foundation
import CoreData
import SwiftUI

public class ListUserViewModel: ObservableObject {
    
    public init() {
        
    }
    
    @Published var users: [User] = [ ]
    private var isLoading: Bool = false
    private var currentPage = 0
    private let numPerPage: Int = 20
    private let apiManager = APIManager()
    private let localPagesKey: String = "localPagesKey"
    
    func loadData() async {
        if let localPages = UserDefaults.standard.value(forKey: localPagesKey) as? Int,
            localPages >= 0 {
            currentPage = localPages
        }
        if let userFromLocal = try? await CoreDataService.shared.fetchUserData(),
            !userFromLocal.isEmpty {
            await MainActor.run {
                users = userFromLocal
            }
        } else {
            await loadListUsers()
        }
    }
    
    func loadMoreIfNeeded(currentUser: User) async {
        let thresholdIndex = users.index(users.endIndex, offsetBy: -5)
        if users.firstIndex(where: { $0.id == currentUser.id }) == thresholdIndex {
            await loadListUsers()
        }
    }
    
    private func loadListUsers() async {
        isLoading = true
        do {
            let response: [User] = try await apiManager.request(type: GithubUsersEndPoint.list(numPerPage: numPerPage, since: currentPage*numPerPage))
            let result = processListNewUsers(newUsers: response)
            await MainActor.run {
                self.users.append(contentsOf: result)
            }
            CoreDataService.shared.addUsersData(users: result)
            UserDefaults.standard.set(currentPage, forKey: localPagesKey)
            isLoading = false
            currentPage += 1
        }catch {
            isLoading = false
            print(error)
        }
    }
    
    public func processListNewUsers(newUsers: [User]) -> [User] {
        var newUsers = newUsers
        newUsers.removeAll(where: { newUser in
            !newUser.isValid() ||
            users.contains(where: { currentUser in
                currentUser.id == newUser.id
            })
        })
        return newUsers
    }
    
    public func setListTestUsers(users: [User]) {
        self.users = users
    }
}
