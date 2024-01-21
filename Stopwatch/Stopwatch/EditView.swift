//
//  EditVIew.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//


import SwiftUI

struct EditView: View {
    @Binding var stopwatch : Stopwatch
    var body: some View {
        Form{
            //Section(header: Text("Meeting Info")){
            //TextField takes a binding to a String. You can use the $ syntax to create a binding to stopwatch.title. The current view manages the state of the data property.
            VStack{
                TextField("Title" , text : $stopwatch.title)
                
#if os(iOS)
                ThemePicker2(selection: $stopwatch.theme)
#endif
            }
        }
        .padding()
        
    }

}


//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(stopwatch: .constant(Stopwatch.sampleData[0]))
//    }
//}


