//
//  ViewTabPage.swift
//  EventApp
//
//  Created by Emre Bingor on 9/17/25.
//

import SwiftUI

struct ViewTabPage: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            EventView()
                .tabItem {
                    Label("Event", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ViewTabPage()
}
