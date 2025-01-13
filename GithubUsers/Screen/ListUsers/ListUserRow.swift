//
//  ListUserRow.swift
//  GithubUsers
//
//  Created by LAP15284 on 10/1/25.
//

import SwiftUI
import Kingfisher

struct ListUserRow: View {
    let user: User
    var body: some View {
        HStack(spacing: 20) {
            KFImage(URL(string: user.avatarUrl))
                .resizable()
                .onSuccess { r in
                    CoreDataService.shared.addImageData(
                        path: user.avatarUrl,
                        data: r.image.jpegData(compressionQuality: 1))
                }.placeholder {
                    if let data = CoreDataService.shared.getImageData(path: user.avatarUrl),
                       let image = UIImage(data: data) {
                        Image(uiImage: image)
                    } else {
                        Image(systemName: "person")
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(.rect(cornerRadius: 25))
            VStack(alignment: .leading) {
                Text(user.id)
                    .font(.headline)
                Divider()
                Text(.init(user.landingPageUrl))
            }
        }.padding()
    }
}

#Preview {
    ListUserRow(user: .dummy)
}
