//
//  RealmService.swift
//
//  Created by 鶴本賢太朗 on 2019/02/07.
//  Copyright © 2019 Kentarou. All rights reserved.
//

import RealmSwift
import Realm

class RealmService {
    private var rm: Realm {
        return try! Realm()
    }
    
    func write(_ onWrite: () -> Void) {
        try! rm.write {
            onWrite()
        }
    }
    
    func add(object: Object, update: Realm.UpdatePolicy = .all) {
        let realm: Realm = rm
        try! realm.write {
            realm.add(object, update: update)
        }
    }
    
    func add(objects: [Object], update: Realm.UpdatePolicy = .modified) {
        let realm: Realm = rm
        try! realm.write {
            realm.add(objects, update: update)
        }
    }
    
    func getAll<T: Object>(type: T.Type) -> Results<T> {
        return rm.objects(type)
    }
    
    func get<T: Object>(type: T.Type, primaryKey: AnyObject) -> T? {
        return rm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    
    func delete(object: Object) {
        let realm: Realm = rm
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func delete(objects: [Object]) {
        let realm: Realm = rm
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    func delete<T: Object>(objects: Results<T>) {
        let realm: Realm = rm
        try! realm.write {
            realm.delete(objects)
        }
    }
}
