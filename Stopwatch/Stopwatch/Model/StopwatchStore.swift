//
//  StopwatchStore.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//


import Foundation

@MainActor
class StopwatchStore : ObservableObject {
    @Published var stopwatches : [Stopwatch] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("stopwatches.data")
    }
    
    /// read JSON data from the stopwatches.data file and decode the data to an array of  stopwatches.Reading from the file system can be slow. To keep the interface responsive, you’ll write an asynchronous function to load data from the file system. Making the function asynchronous lets the system efficiently prioritize updating the user interface instead of sitting idle and waiting while the file system reads data.
    /// If an asynchronous function also throws an error, the async keyword comes before the throws keyword.
    func load() async throws {
        let task = Task<[Stopwatch], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let stopWatches = try JSONDecoder().decode([Stopwatch].self, from: data)
            return stopWatches
        }
        let stopwatches = try  await task.value
        self.stopwatches = stopwatches
    }
    
    func save(stopwatches : [Stopwatch]) async throws{
        let task = Task {
            let fileURL = try Self.fileURL()
            let data = try JSONEncoder().encode(stopwatches)
            try data.write(to: fileURL)
        }
       _ = try await task.value
    }
}


