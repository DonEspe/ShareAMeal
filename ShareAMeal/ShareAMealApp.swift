//
//  ShareAMealApp.swift
//  ShareAMeal
//
//  Created by Don Espe on 10/17/23.
//

import SwiftUI

@main
struct ShareAMealApp: App {

    @State private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataController)
        }
    }
}
