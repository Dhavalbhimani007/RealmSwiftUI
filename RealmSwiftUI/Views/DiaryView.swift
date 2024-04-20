//
//  DiaryView.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 21/03/24.
//

import SwiftUI
import RealmSwift

struct DiaryView: View {
    
    @ObservedObject
    var dataStore = DataStore.shared
    
    private var user: UserData? {
        dataStore.user
    }
    
    @State
    var presented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                                
                    if dataStore.diaries?.count == 0{
                        VStack {
                            
                            Label {
                                Text("No data found")
                                    .font(.body)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(nil)
                                    .padding(.all)
                                
                            }
                        icon: {
                        }
                        .foregroundColor(.indigo)
                        .background(Color.indigo.opacity(0.2))
                        .clipShape(Capsule())
                        }
                        .padding(.top)
                    }
                    else if let diaries = dataStore.diaries {
                        ForEach(diaries) { item in
                            ListView(
                                date: item.date,
                                title: item.title,
                                mood: item.mood,
                                value: item.value,
                                isPublic: item.isPublic
                            )
                                .padding(.horizontal)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                .navigationTitle("\(user?.name ?? "My") Diary")
                .toolbar{
                    Button(action: {
                        self.presented.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $presented){
                    Diaries(isPresented: $presented)
                }
            }
        }
        .navigationBarHidden(true)
        .navigationTitle("")
    }
}

struct Diaries: View{
    
    @State var title: String = ""
    var dbTitle: String = ""
    @State var mood: String = ""
    @State var main: String = ""
    @ObservedObject
    var dataStore = DataStore.shared
    @Binding var isPresented: Bool
    @State var noChecked: Bool = true
    @State var updateTriggered: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Enter a title")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                TextField("Title",text: $title)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5.0)
                                .stroke(lineWidth: 1.0))
                    .padding(.bottom, 20)
                
                Text("How are you feeling?")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                TextField("Mood",text: $mood)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 5.0)
                                .stroke(lineWidth: 1.0))
                    .padding(.bottom, 20)
                
                Text("Describe your feelings.")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                ZStack {
                    TextEditor(text: $main)
                        .overlay(RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 1.0))
                    Text(main).opacity(0).padding(.all, 8)
                }
                .padding(.bottom, 20)
                
                HStack {
                    Image(systemName: noChecked ? "square" : "checkmark.square.fill")
                        .foregroundColor(noChecked ? Color.secondary : Color(UIColor.systemBlue))
                        .onTapGesture {
                            self.noChecked.toggle()
                            
                        }
                        .padding(.trailing, 5)
                    
                    Text("Make the diary private")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
                
                Spacer()
                
                if(updateTriggered == true){
                    Button(action: {
                        dataStore.updateDiary(dbTitle: dbTitle, title: title, mood: mood, noChecked: noChecked, value: main) { isUpdated in
                            if isUpdated{
                                isPresented.toggle()
                            }
                        }
                    }){
                        Text("Update")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2.0)
                                        .shadow(color: .blue, radius: 10.0))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                } else {
                    Button(action: {
                        
                        print(Date().description.localizedLowercase)
                        dataStore.addDiary(title: title, mood: mood, noChecked: noChecked, value: main) { isAdded in
                            if isAdded{
                                isPresented.toggle()
                            }
                        }
                        
                    }){
                        Text("Save")
                            .padding(8)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(10)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(lineWidth: 2.0)
                                        .shadow(color: .blue, radius: 10.0))
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    .padding(.top, 20)
                    
                    .navigationTitle("Create a page")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding()
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryView()
    }
}
