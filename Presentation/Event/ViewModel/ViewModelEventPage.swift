//
//  ViewModelEventPage.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import Foundation

class ViewModelEventPage: ObservableObject {
    @Published var events: [ModelLocalEvent] = []
    
    
    func getEvents() {
        events = LocalEventStorage().loadEvents()
    }
}
