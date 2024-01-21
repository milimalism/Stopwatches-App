//
//  WatchView.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//
import SwiftUI

struct WatchView: View {
    let stopwatch : Stopwatch
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(stopwatch.title)
                    .bold()
                    .foregroundColor(stopwatch.theme.accentColor)
//                Text("\(stopwatch.time)")
//                    .foregroundColor(stopwatch.theme.accentColor)
            
            }
            Spacer()
            //increase button size
            VStack(alignment: .trailing){
                Button(action: {}){
                    Image(systemName: "clock")          .font(.system(size: 15))
                        .padding()
                        .cornerRadius(10)
                        .foregroundColor(stopwatch.theme.accentColor)
                }
                .buttonStyle(.plain)
                .frame(width: 50, height: 50)
                .background(stopwatch.theme.mainColor)
            }
        }
        .padding()
        .background(stopwatch.theme.mainColor)

    }
}

struct WatchView_Previews: PreviewProvider {
    static var stopwatch : Stopwatch = Stopwatch.sampleData[0]
    static var previews: some View {
        WatchView(stopwatch: stopwatch)
    }
}
