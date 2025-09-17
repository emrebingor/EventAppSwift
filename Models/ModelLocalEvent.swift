//
//  ModelLocalEvent.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import Foundation

struct ModelLocalEvent: Codable, Identifiable {
    let id: UUID
    let title: String
    let startDate: Date
    let endDate: Date
    
    init(id: UUID = UUID(), title: String, startDate: Date, endDate: Date) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
    }
}
