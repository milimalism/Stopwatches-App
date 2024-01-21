//
//  NewStopwatch.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//


import SwiftUI

struct NewStopwatchSheet: View {
    @Binding var isPresentingNewScrumView: Bool
    @State private var newStopwatch = Stopwatch.emptyStopwatch
    @Binding var stopwatches: [Stopwatch]
    
    var body: some View {
        NavigationStack {
            EditView(stopwatch : $newStopwatch)
                .toolbar{
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss"){
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Add") {
                            stopwatches.append(newStopwatch)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewStopwatchSheet(isPresentingNewScrumView: .constant(true), stopwatches: .constant([]))
    }
}
