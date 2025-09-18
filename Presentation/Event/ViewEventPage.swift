//
//  ViewEventPage.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import SwiftUI
import EventKitUI

struct EventView: View {
    @StateObject var viewModel = ViewModelEventPage()
    
    var body: some View {
        List {
            ForEach(viewModel.events) { event in
                VStack(alignment: .leading, spacing: 8) {
                    Text(event.title)
                        .font(.headline)
                    
                    Text("Start Date: " + event.startDate.formatDateToString())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("End Date: " + event.endDate.formatDateToString())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        if let index = viewModel.events.firstIndex(where: { $0.id == event.id }) {
                            viewModel.deleteEvent(at: IndexSet(integer: index))
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                    
                    Button {
                        viewModel.openCalendar(at: event.startDate)
                    } label: {
                        Label("Calendar", systemImage: "calendar")
                    }
                    .tint(.blue)
                }
            }
        }
        .onAppear {
            viewModel.getEvents()
        }
    }
}
