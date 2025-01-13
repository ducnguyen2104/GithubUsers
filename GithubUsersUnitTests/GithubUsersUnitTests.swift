//
//  GithubUsersUnitTests.swift
//  GithubUsersUnitTests
//
//  Created by LAP15284 on 12/1/25.
//

import Testing
import GithubUsers

struct GithubUsersUnitTests {

    @Test func testValidUser() async throws {
        let user = User(id: "id",
                        avatarUrl: "avatar",
                        landingPageUrl: "landingPage")
        #expect(user.isValid())
    }
    
    @Test func testInvalidUser() async throws {
        let user = User(id: "",
                        avatarUrl: "avatar",
                        landingPageUrl: "landingPage")
        #expect(!user.isValid())
    }
    
    @Test func testRemoveInvalidNewUsers() async throws {
        let viewModel = ListUserViewModel()
        let invalidUser = User(id: "", avatarUrl: "avatar", landingPageUrl: "landingPage")
        let users = [
            User(id: "1", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "2", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "3", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "4", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            invalidUser,
            User(id: "5", avatarUrl: "avatar", landingPageUrl: "landingPage")
        ]
        let processed = viewModel.processListNewUsers(newUsers: users)
        //expect to remove invalid user
        #expect(processed.count == 5)
    }
    
    @Test func testRemoveDuplicateNewUsers() async throws {
        let viewModel = ListUserViewModel()
        let users = [
            User(id: "1", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "2", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "3", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "4", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "5", avatarUrl: "avatar", landingPageUrl: "landingPage")
        ]
        viewModel.setListTestUsers(users: users)
        let newUsers = [
            User(id: "1", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "5", avatarUrl: "avatar", landingPageUrl: "landingPage"),
            User(id: "7", avatarUrl: "avatar", landingPageUrl: "landingPage")
        ]
        let processed = viewModel.processListNewUsers(newUsers: newUsers)
        //expect users with id "1", and "5" will not be added
        #expect(processed.count == 1)
    }
}
