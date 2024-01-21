//
//  ThemePicker2.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//

import SwiftUI

struct ThemePicker2: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
        #if os(iOS)
        .pickerStyle(.navigationLink)
        #endif
    }
}

struct ThemePicker2_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker2(selection: .constant(.periwinkle))
    }
}

