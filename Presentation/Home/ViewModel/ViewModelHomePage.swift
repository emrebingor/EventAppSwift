//
//  ViewModelHomePage.swift
//  EventApp
//
//  Created by Emre Bingor on 9/15/25.
//

import Foundation
import EventKit
import SwiftUI

class ViewModelHomePage: ObservableObject {
    private let eventStore = EKEventStore()
    @Published var startDate = Date()
    @Published var endDate = Date().addingTimeInterval(3600)
    @Published var title = "My Event"
    @Published var showAlert = false
    @Published var alertTitle = ""
    @Published var alertMessage = ""
    
    @MainActor
    func requestCalendarAccess() {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { granted, error in
            Task {
                if granted {
                    print("Access granted")
                } else {
                    self.alertTitle = "Access Denied"
                    self.alertMessage = "Please allow calendar access in Settings to add events."
                    self.showAlert = true
                }
            }
        }
    }
    
    func addEvent() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty else {
            print("Title is empty")
            return
        }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            var localEvent = ModelLocalEvent(title: title, startDate: startDate, endDate: endDate)
            localEvent.eventId = event.eventIdentifier
            LocalEventStorage().save(event: localEvent)
            
            openCalendar(at: startDate)
        } catch {
            print("Error saving event: \(error.localizedDescription)")
        }
    }
    
    func openCalendar(at date: Date) {
        let interval = date.timeIntervalSinceReferenceDate
        if let url = URL(string: "calshow:\(interval)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

