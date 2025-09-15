//
//  ContentView.swift
//  EventApp
//
//  Created by Emre Bingor on 9/15/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ViewModelHomePage()
    
    var body: some View {
        VStack() {
            TextField("Event Title", text: $viewModel.title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Spacer().frame(height: 16)
            
            DatePicker("Start Date", selection: $viewModel.startDate)
            DatePicker("End Date", selection: $viewModel.endDate)
            
            Spacer().frame(height: 16)
            
            Button("Save to Calendar") {
                viewModel.addEvent()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Spacer()
        }
        .onAppear {
            viewModel.requestCalendarAccess()
        }
        .padding()
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .default(Text("Open Settings")) {
                    viewModel.openAppSettings()
                }
            )
        }
    }
}

#Preview {
    HomeView()
}
