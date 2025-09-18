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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack {
            if viewModel.events.isEmpty {
                Spacer()
                VStack(spacing: 16) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                    Text("No events available")
                        .foregroundColor(.secondary)
                        .font(.headline)
                }
                Spacer()
            } else {
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
            }
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                viewModel.eventStoreChanged()
            }
        }
    }
}
