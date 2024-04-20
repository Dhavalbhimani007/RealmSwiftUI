//
//  Date+Extension.swift
//  RealmSwiftUI
//
//  Created by DREAMWORLD on 22/03/24.
//

import Foundation

extension Date{
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: self)
    }
}
