//
//  BaseView.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 19/04/24.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
//        TabView {
            DiaryView()
//                .tabItem {
//                    Image(systemName: "books.vertical.fill")
//                    Text("My Diary")
//                }
//        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
