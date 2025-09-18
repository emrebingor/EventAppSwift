//
//  ModelLocalEvent.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import Foundation

struct ModelLocalEvent: Codable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let startDate: Date
    let endDate: Date
    var eventId: String?
}
