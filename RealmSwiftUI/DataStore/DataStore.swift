//
//  DataStore.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 21/03/24.
//

import Foundation
import SwiftUI
import RealmSwift

class DataStore: NSObject, ObservableObject{
    static let shared = DataStore()
    
    @Published
    var diaries: Results<Diary>?
    
    @Published
    var user: UserData?
    
    private var realm = try! Realm()
    
    // MARK: - Object Lifecycle
    override private init() {
        super.init()
        fetchData()
    }
    
    private func fetchData() {
        user = realm.objects(UserData.self).filter("userID = '\(uid!)'").first
        diaries = realm.objects(Diary.self)
    }
    
    func addDiary(title: String, mood: String, noChecked: Bool, value: String, completion: @escaping ((Bool)->Void)) {
        let diary = Diary()
        diary.title = title
        diary.date = Date().toString()
        diary.mood = mood
        diary.isPublic = String(noChecked)
        diary.value = value
        
        try! realm.write{
            realm.add(diary)
            self.fetchData()
           completion(true)
        }
    }
    
    func updateDiary(dbTitle: String, title: String, mood: String, noChecked: Bool, value: String, completion: @escaping ((Bool)->Void)) {

        guard let diaryValue = realm.objects(Diary.self).filter("title = '\(dbTitle)'").first else { return }
        
        try! realm.write {
            diaryValue.date = Date().toString()
            diaryValue.title = title
            diaryValue.mood = mood
            diaryValue.isPublic = String(noChecked)
            diaryValue.value = value
            self.fetchData()
            completion(true)
        }
    }
    
    func deleteDiary(dbTitle: String, completion: @escaping ((Bool)->Void)) {
        guard let diaryValue = realm.objects(Diary.self).filter("title = '\(dbTitle)'").first else { return }
        try! realm.write {
            realm.delete(diaryValue)
            self.fetchData()
            completion(true)
        }
    }
}
