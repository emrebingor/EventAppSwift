//
//  ViewModelEventPage.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import Foundation
import EventKit
import UIKit

class ViewModelEventPage: ObservableObject {
    @Published var events: [ModelLocalEvent] = []
    private let storage = LocalEventStorage()
    private let eventStore = EKEventStore()
    
    func getEvents() {
        events = storage.loadEvents()
    }
    
    func deleteEvent(at offsets: IndexSet) {
        offsets.forEach { index in
            let event = events[index]
            storage.delete(at: index)
            
            guard let eventId = event.eventId, let ekEvent = eventStore.event(withIdentifier: eventId) else { return }
            
            do {
                try eventStore.remove(ekEvent, span: .thisEvent, commit: true)
            } catch {
                print("Failed to remove event")
            }
        }
        
        events = storage.loadEvents()
    }
    
    func openCalendar(at date: Date) {
        let interval = date.timeIntervalSinceReferenceDate
        if let url = URL(string: "calshow:\(interval)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
