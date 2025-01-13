//
//  UserDetailViewController.swift
//  GithubUsers
//
//  Created by LAP15284 on 11/1/25.
//

import UIKit
import SwiftUI
import SnapKit

struct UserDetailViewControllerWrappper: UIViewControllerRepresentable {
    private let user: User
    init(user: User) {
        self.user = user
    }
    func makeUIViewController(context: Context) -> some UIViewController {
        let viewModel = UserDetailViewModel(user: user)
        let viewController = UserDetailViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

class UserDetailViewController: UIViewController {
    
    var viewModel: UserDetailViewModelProtocol?
    
    private lazy var userInfoCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.5
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.clipsToBounds = true
        imgView.image = UIImage(systemName: "person")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 25
        return imgView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var locationIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "location")
        return imgView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var followerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(followerIconImageView)
        stackView.addArrangedSubview(followerCountLabel)
        stackView.addArrangedSubview(followerLabel)
        
        return stackView
    }()
    
    private lazy var followerIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.and.person.fill")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var followerCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.text = "Followers"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(followingIconImageView)
        stackView.addArrangedSubview(followingCountLabel)
        stackView.addArrangedSubview(followingLabel)
        
        return stackView
    }()
    
    private lazy var followingIconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "person.badge.plus.fill")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var followingCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "Following"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var landingPageHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Blog"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var landingPageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(userInfoCardView)
        view.addSubview(followerStackView)
        view.addSubview(followingStackView)
        view.addSubview(landingPageHeaderLabel)
        view.addSubview(landingPageLabel)
        
        userInfoCardView.addSubview(avatarImageView)
        userInfoCardView.addSubview(nameLabel)
        userInfoCardView.addSubview(dividerView)
        userInfoCardView.addSubview(locationIconImageView)
        userInfoCardView.addSubview(locationLabel)
        
        userInfoCardView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(20)
            $0.height.equalTo(120)
        }
        
        avatarImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: 100, height: 100))
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(30)
            $0.top.equalToSuperview().offset(10)
        }
        
        dividerView.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(1)
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
        locationIconImageView.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(locationIconImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(30)
            $0.top.equalTo(dividerView.snp.bottom).offset(10)
        }
        
        followerStackView.snp.makeConstraints {
            $0.top.equalTo(userInfoCardView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        followerIconImageView.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        followingStackView.snp.makeConstraints {
            $0.top.equalTo(userInfoCardView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        
        followingIconImageView.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        landingPageHeaderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(followingStackView.snp.bottom).offset(10)
        }
        
        landingPageLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(landingPageHeaderLabel.snp.bottom).offset(10)
        }
                
        viewModel?.onUserReady = { [weak self] user in
            DispatchQueue.main.async {
                self?.displayUser(user: user)
            }
        }
        
        viewModel?.onUserDetailReady = { [weak self] userDetail in
            DispatchQueue.main.async {
                self?.displayUserDetail(userDetail: userDetail)
            }
        }
        
        viewModel?.loadData()
    }
    
    private func displayUser(user: User) {
        avatarImageView.kf.setImage(
            with: URL(string: user.avatarUrl),
            completionHandler: { [weak self] kfResult in
                switch kfResult {
                case .success(let imgResult):
                    CoreDataService.shared.addImageData(
                        path: user.avatarUrl,
                        data: imgResult.image.jpegData(compressionQuality: 1))
                case .failure(_):
                    if let data = CoreDataService.shared.getImageData(path: user.avatarUrl),
                       let image = UIImage(data: data) {
                        self?.avatarImageView.image = image
                    } else {
                        self?.avatarImageView.image = UIImage(systemName: "person")
                    }
                }
            })
        nameLabel.text = user.id
        landingPageLabel.text = user.landingPageUrl
    }
    
    private func displayUserDetail(userDetail: UserDetail) {
        avatarImageView.kf.setImage(
            with: URL(string: userDetail.avatarUrl),
            completionHandler: { [weak self] kfResult in
                switch kfResult {
                case .success(let imgResult):
                    CoreDataService.shared.addImageData(
                        path: userDetail.avatarUrl,
                        data: imgResult.image.jpegData(compressionQuality: 1))
                case .failure(_):
                    if let data = CoreDataService.shared.getImageData(path: userDetail.avatarUrl),
                       let image = UIImage(data: data) {
                        self?.avatarImageView.image = image
                    } else {
                        self?.avatarImageView.image = UIImage(systemName: "person")
                    }
                }
            })
        nameLabel.text = userDetail.id
        landingPageLabel.text = userDetail.landingPageUrl
        
        followerCountLabel.text = "\(userDetail.followers)"
        followingCountLabel.text = "\(userDetail.following)"
        
        if let location = userDetail.location {
            locationIconImageView.isHidden = false
            locationLabel.isHidden = false
            locationLabel.text = location
        } else {
            locationIconImageView.isHidden = true
            locationLabel.isHidden = true
        }
    }
}
