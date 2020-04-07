//
//  RealmService.swift
//
//  Created by 鶴本賢太朗 on 2019/02/07.
//  Copyright © 2019 Kentarou. All rights reserved.
//

import RealmSwift
import Realm

class RealmService {
    
    private let realm: Realm
    internal static let shared: RealmService = RealmService()
    
    init() {
        try! self.realm = Realm()
    }
    
    internal func write(writeCode: () -> Void) {
        do {
            try self.realm.write {
                writeCode()
            }
        }
        catch {
            
        }
    }
    internal func add(object: Object, update: Realm.UpdatePolicy = .modified) {
        self.write(writeCode: { [weak self] in
            self?.realm.add(object, update: update)
        })
    }
    internal func add(objects: [Object], update: Realm.UpdatePolicy = .modified) {
        self.write(writeCode: { [weak self] in
            self?.realm.add(objects, update: update)
        })
    }
    internal func getAll<T: Object>(type: T.Type) -> Results<T> {
        return self.realm.objects(type)
    }
    internal func get<T: Object>(type: T.Type, primaryKey: AnyObject) -> T? {
        return self.realm.object(ofType: type, forPrimaryKey: primaryKey)
    }
    internal func delete(object: Object) {
        self.write(writeCode: { [weak self] in
            self?.realm.delete(object)
        })
    }
    internal func delete(objects: [Object]) {
        self.write(writeCode: { [weak self] in
            self?.realm.delete(objects)
        })
    }
    internal func delete<T: Object>(objects: Results<T>) {
        self.write(writeCode: { [weak self] in
            self?.realm.delete(objects)
        })
    }
    internal func deleteAll<T: Object>(type: T.Type) {
        let result: Results<T> = self.getAll(type: type)
        self.write(writeCode: { [weak self] in
            self?.realm.delete(result)
        })
    }
    internal func deleteAllObject() {
        self.realm.deleteAll()
    }
}
