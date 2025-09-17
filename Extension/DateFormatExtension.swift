//
//  DateFormatExtension.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import Foundation

extension Date {
    func formatDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy hh:mm a"
        return formatter.string(from: self)
    }
}
