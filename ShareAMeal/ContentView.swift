//
//  ContentView.swift
//  ShareAMeal
//
//  Created by Don Espe on 10/17/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(DataController.self) var dataController

    var body: some View {
        if let selectedFoodBank = dataController.selectedFoodBank {
            TabView {
                Text("Home")
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                Text("My Foodbank")
                    .tabItem {
                        Label("My Foodbank", systemImage: "building.2")
                    }

                Text("Drop-off Points")
                    .tabItem{
                        Label("Drop-off Points", systemImage: "basket")
                    }
            }
        } else {
            EnterLocationView()
        }
    }
}

#Preview {
    ContentView()
}
