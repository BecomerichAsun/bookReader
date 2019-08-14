//
//  RelamManager.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/14.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager: NSObject {

    static let shared = RealmManager()

    private var realm: Realm = try! Realm()

    private override init() {}

    static func getLocalRealm() -> Realm {
        return RealmManager.shared.realm
    }

    static func insert<T: Object>(data: T) {
        RealmManager.shared.realm.add(data)
    }

    static func writeArray<T: Object>(data: [T]) {
        guard !data.isEmpty else { return }
        try? RealmManager.shared.realm.write {
            data.forEach({ (value) in
                RealmManager.insert(data: value)
            })
        }
    }

    static func realmPath() {
        AsunLog(RealmManager.shared.realm.configuration.fileURL!)
    }

    static func getObject<T: Object>(type: T.Type) -> Results<T>{
        return RealmManager.shared.realm.objects(type)
    }
}
