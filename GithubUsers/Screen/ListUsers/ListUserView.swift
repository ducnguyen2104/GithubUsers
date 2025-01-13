//
//  ListUserView.swift
//  GithubUsers
//
//  Created by LAP15284 on 10/1/25.
//

import SwiftUI

struct ListUserView: View {
    
    @StateObject var viewModel = ListUserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        ListUserRow(user: user)
                            .task {
                                await viewModel.loadMoreIfNeeded(currentUser: user)
                            }
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.white)
                            .shadow(radius: 3)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                                     )
                    )
                    .listRowSeparator(.hidden)
                    .listRowSpacing(10)
                }
            }
            .listStyle(.plain)
            .navigationBarTitle("Github Users")
            .task {
                await viewModel.loadData()
            }
        }
    }
}

#Preview {
    ListUserView()
}
