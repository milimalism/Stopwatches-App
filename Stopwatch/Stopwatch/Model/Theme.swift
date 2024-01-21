//
//  Theme.swift
//  Scrumdinger
//
//  Created by Mythili Mulani on 06/12/23.
//
//Color property is added from the SwiftUI framework. SwiftUI treaes colours as View instances

import SwiftUI

enum Theme : String, CaseIterable, Identifiable, Codable {

    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor : Color{
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
    //Color property called mainColor; creates a color using enums rawValue. It initialises a color from the asset catalog
    var mainColor : Color {
        Color(rawValue)
    }
    
    var name : String{
        rawValue.capitalized
    }
    
    var id : String {
        name
    }
    
    var themes : [Theme]{
        Theme.allCases
    }
}

extension Theme{
    static let sampleThemeData : [Theme] = Theme.allCases
}


