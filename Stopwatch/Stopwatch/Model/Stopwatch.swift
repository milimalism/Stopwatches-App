//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/12/23.
//

import Foundation
import SwiftUI

struct Stopwatch : Identifiable, Codable{
    let id = UUID()
    var title : String
    var start : Date?
    var theme : Theme
    var progressTime : Int
    //where date is the date of, int is the duration
    var data: [CodableTuple<Date, Int>]
    var time: [CodableTuple<Date, Date>]
    
    init(id: UUID = UUID(), title: String, start : Date , theme: Theme = .periwinkle, progressTime : Int = 0) {
        self.title = title
        self.start = nil
        self.theme = theme
        self.progressTime = progressTime
        self.data = [CodableTuple(Date(), 0)]
        self.time = [CodableTuple(Date(), Date())]
        }
    
    static var emptyStopwatch : Stopwatch{
        Stopwatch(title: "", start: Date(), theme: .periwinkle, progressTime: 0)
    }
}

extension Stopwatch {
    static let sampleData : [Stopwatch] =
    [ Stopwatch(title: "Shower", start: Date(), theme: .yellow, progressTime: 3602),
      Stopwatch(title: "Gym", start: Date(), theme: .orange, progressTime: 3604),
      Stopwatch(title: "Swim", start: Date(), theme: .poppy, progressTime: 3607),
    ]
}

struct CodableTuple<T: Codable & Hashable, U: Codable & Hashable>: Codable, Hashable {
    var value1: T
    var value2: U

    init(_ value1: T, _ value2: U) {
        self.value1 = value1
        self.value2 = value2
    }
}
