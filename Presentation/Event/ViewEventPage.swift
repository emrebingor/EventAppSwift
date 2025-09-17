//
//  ViewEventPage.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import SwiftUI

struct EventView: View {
    @StateObject var viewModel = ViewModelEventPage()
    
    var body: some View {
        ScrollView {
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
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.15), radius: 8, x: 2, y: 2)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .onAppear {
            viewModel.getEvents()
        }
    }
}



#Preview {
    EventView()
}
