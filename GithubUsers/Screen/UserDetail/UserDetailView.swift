//
//  UserDetailView.swift
//  GithubUsers
//
//  Created by LAP15284 on 11/1/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    var body: some View {
        NavigationView {
            UserDetailViewControllerWrappper(user: user)
        }
        .navigationBarTitle("User detail")
    }
}

#Preview {
    UserDetailView(user: .dummy)
}
