//
//  ModelEventItem.swift
//  EventApp
//
//  Created by Emre Bingor on 9/15/25.
//

import Foundation

struct ModelEventItem: Codable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let date: Date
    let description: String
}
