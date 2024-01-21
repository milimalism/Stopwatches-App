//
//  WatchListView.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//


import SwiftUI

struct WatchListView: View {
    
    @State private var newScrum = Stopwatch.emptyStopwatch
    @Binding var stopwatches : [Stopwatch]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewStopwatchView = false
    @State private var userInput = "blue"
    
    let saveAction : ()->Void
    
    var body: some View {
        //passing array and key path to the title property
        //list closure must return a view
        NavigationStack{ 
            List($stopwatches){ $stopwatch in
                NavigationLink(destination: DetailView(stopwatch: $stopwatch,  stopwatches: $stopwatches)){
                    WatchView(stopwatch: stopwatch)
                }
                .listRowBackground(stopwatch.theme.mainColor)
            }
            .navigationTitle("Stopwatches")
            .toolbar{
                Button(action: {
                    isPresentingNewStopwatchView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New stopwatch")
            }
            .sheet(isPresented: $isPresentingNewStopwatchView) {
                NewStopwatchSheet(isPresentingNewScrumView: $isPresentingNewStopwatchView, stopwatches: $stopwatches)
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {saveAction()
                }
            }
        }
    }
}

struct WatchListView_Previews: PreviewProvider {
    static let watches = Stopwatch.sampleData
    static var previews: some View {
        WatchListView(stopwatches: .constant(Stopwatch.sampleData), saveAction: {})
    }
}

//if you wanted to do an alert format:
//    .toolbar{
//        Button(action: {
//            isPresentingNewStopwatchView = true
//        }){
//            Image(systemName: "plus")
//        }
//        .accessibilityLabel("New stopwatch")
//    }
//    .alert("Enter your name", isPresented: $isPresentingNewStopwatchView) {
//                TextField("Enter your name", text: $userInput)
//                Button("OK", action: {
//                    stopwatches.append(Stopwatch(name: userInput))
//                })
//            } message: {
//                Text("Xcode will print whatever you type.")
//            }
