//
//  ContentView.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 21/03/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    
    init (){
        
        _ = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        uid = String(app.currentUser?.id ?? "")
        print(uid as Any)
    }
    
    var body: some View {
        if app.currentUser != nil {
            BaseView()
        } else{
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
