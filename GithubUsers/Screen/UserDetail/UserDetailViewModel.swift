//
//  UserDetailViewModel.swift
//  GithubUsers
//
//  Created by LAP15284 on 11/1/25.
//

protocol UserDetailViewModelProtocol: AnyObject {
    var onUserReady: ((User) -> Void)? { get set }
    var onUserDetailReady: ((UserDetail) -> Void)? { get set }
    func loadData()
}

class UserDetailViewModel: UserDetailViewModelProtocol {
    var onUserReady: ((User) -> Void)?
    var onUserDetailReady: ((UserDetail) -> Void)?
    
    private let apiManager = APIManager()
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    func loadData() {
        onUserReady?(user)
        Task {
            if let localData = try? await CoreDataService.shared.getUserDetailData(userId: user.id) {
                onUserDetailReady?(localData)
            } else {
                do {
                    let userDetail: UserDetail = try await apiManager.request(type: GithubUsersEndPoint.detail(username: user.id))
                    onUserDetailReady?(userDetail)
                    CoreDataService.shared.addUserDetailData(userDetail: userDetail)
                } catch {
                    print(error)
                }
            }
        }
    }
}
