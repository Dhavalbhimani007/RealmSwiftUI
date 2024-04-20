//
//  ListView.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 21/03/24.
//

import SwiftUI

struct ListView: View {
    
    @State var date:String?
    @State var title:String?
    @State var mood:String?
    @State var value:String?
    @State var isPublic: String?
    @State var isOpen: Bool = false
    @State var isToggled: Bool = false
    @State var functionEnabled: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.indigo.opacity(0.2))
            HStack {
                VStack(alignment: .leading){
                    Spacer()
                    Text(date ?? Date().description.localizedLowercase)
                        .foregroundColor(.black)
                    Text(title ?? "Day 1")
                        .foregroundColor(.black)
                        .font(.title)
                    Text(mood ?? "Happy")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.indigo)
                    Spacer()
                    if(isOpen == true){
                        Text(value ?? "")
                            .foregroundColor(.black)
                    }
                    if(functionEnabled == true){
                        HStack {
                            Spacer()
                            
                            Button {
                                self.isToggled.toggle()
                            } label: {
                                Text("Edit")
                                    .fontWeight(.semibold)
                                    .padding(.trailing, 5)
                                    .foregroundStyle(Color(.orange))
                            }

                            Image(systemName: "trash.fill")
                                .foregroundColor(.black)
                                .onTapGesture {
                                    DataStore.shared.deleteDiary(dbTitle: title!) { isDeleted in
                                        
                                    }
                                }
                            
                            Image(systemName: buttonValue)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    isOpen.toggle()
                                }
                        }
                    }
                }
                .padding()
                Spacer()
                
            }
            .sheet(isPresented: $isToggled){
                Diaries(title: title!, dbTitle: title!, mood: mood!, main: value! ,isPresented: $isToggled, noChecked: Bool(isPublic!)!, updateTriggered: true )
            }
        }
    }
    
    var buttonValue: String {
        return isOpen ? "chevron.up.circle.fill" : "chevron.down.circle.fill"
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().previewLayout(.fixed(width: 300, height: 200))
    }
}
