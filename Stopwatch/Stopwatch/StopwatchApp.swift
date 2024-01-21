//
//  StopwatchApp.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//

import SwiftUI

@main
struct StopwatchApp: App {
    @StateObject private var store = StopwatchStore()
    @State private var errorWrapper : ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            WatchListView(stopwatches: $store.stopwatches) {
                Task {
                    do {
                        try await store.save(stopwatches: store.stopwatches)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later")
                    }
                }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error,
                                                guidance: "Stopwatches will load sample data and continue.")
                }
            }
        }
    }
}
