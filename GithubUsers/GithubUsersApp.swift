//
//  GithubUsersApp.swift
//  GithubUsers
//
//  Created by LAP15284 on 10/1/25.
//

import SwiftUI

@main
struct GithubUsersApp: App {
    
    @StateObject private var dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            ListUserView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
