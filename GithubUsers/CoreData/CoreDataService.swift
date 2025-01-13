//
//  CoreDataService.swift
//  GithubUsers
//
//  Created by LAP15284 on 11/1/25.
//
import Foundation
import CoreData

class CoreDataService {
    
    private init() { }
    
    static let shared = CoreDataService()
    
    private var context: NSManagedObjectContext = DataController.shared.container.viewContext

    func addImageData(path: String, data: Data?) {
        let fetchRequest = ImageLocal.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "path == %@", path)
        do {
            let imgs = try context.fetch(fetchRequest)
            let imageLocal = imgs.first ?? ImageLocal(context: context)
            imageLocal.path = path
            imageLocal.data = data
            do {
                try context.save()
            } catch {
                print("error-Saving data")
            }
        } catch {
            print("error-Check exist data")
        }
    }
    
    func getImageData(path: String) -> Data? {
        let fetchRequest = ImageLocal.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "path == %@", path)
        let imgs = try? context.fetch(fetchRequest)
        if let imageLocal = imgs?.first {
            return imageLocal.data
        }
        return nil
    }
    
    func addUsersData(users: [User]) {
        users.forEach {
            let fetchRequest = UserLocal.fetchRequest()
            fetchRequest.fetchLimit =  1
            fetchRequest.predicate = NSPredicate(format: "id == %@", $0.id)
            do {
                let usersLocal = try context.fetch(fetchRequest)
                let userLocal = usersLocal.first ?? UserLocal(context: context)
                userLocal.id = $0.id
                userLocal.avatarUrl = $0.avatarUrl
                userLocal.landingPageUrl = $0.landingPageUrl
                do {
                    try context.save()
                } catch {
                    print("error-Saving data")
                }
            } catch {
                print("error-Check exist data")
            }
        }
    }
    
    func fetchUserData() async throws -> [User] {
        do {
            let fetchRequest = UserLocal.fetchRequest()
            let items = try context.fetch(fetchRequest)
            return items.compactMap { User(userLocal: $0) }
        } catch {
            print("error-Fetching data")
            throw error
        }
    }
    
    func addUserDetailData(userDetail: UserDetail) {
        let fetchRequest = UserDetailLocal.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", userDetail.id)
        do {
            let userDetailsLocal = try context.fetch(fetchRequest)
            let userDetailLocal = userDetailsLocal.first ?? UserDetailLocal(context: context)
            userDetailLocal.id = userDetail.id
            userDetailLocal.avatarUrl = userDetail.avatarUrl
            userDetailLocal.landingPageUrl = userDetail.landingPageUrl
            userDetailLocal.location = userDetail.location
            userDetailLocal.followers = Int64(userDetail.followers)
            userDetailLocal.following = Int64(userDetail.following)
            do {
                try context.save()
            } catch {
                print("error-Saving data")
            }
        } catch {
            print("error-Check exist data")
        }
    }
    
    func getUserDetailData(userId: String) async throws -> UserDetail? {
        do {
            let fetchRequest = UserDetailLocal.fetchRequest()
            fetchRequest.fetchLimit =  1
            fetchRequest.predicate = NSPredicate(format: "id == %@", userId)
            let userDetailsLocal = try context.fetch(fetchRequest)
            if let userDetailLocal = userDetailsLocal.first {
                return UserDetail(userDetailLocal: userDetailLocal)
            } else {
                return nil
            }
        } catch {
            print("error-Fetching data")
            throw error
        }
    }
}
