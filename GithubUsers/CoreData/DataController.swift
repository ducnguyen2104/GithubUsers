//
//  DataController.swift
//  GithubUsers
//
//  Created by LAP15284 on 11/1/25.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    static let shared = DataController()

    let container = NSPersistentContainer(name: "GithubUsers")
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
