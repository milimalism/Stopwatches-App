//
//  ThemeView.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//

import SwiftUI

struct ThemeView: View {
    let theme : Theme
    var body: some View {
        Text(theme.name)
            .foregroundColor(theme.accentColor)
            .padding(4)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct ThemeView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeView(theme: Stopwatch.sampleData[0].theme)
    }
}
