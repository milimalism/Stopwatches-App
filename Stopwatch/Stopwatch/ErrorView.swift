//
//  ErrorView.swift
//  Stopwatch
//
//  Created by Mythili Mulani on 06/01/24.
//

import SwiftUI

struct ErrorView: View {
    let errorWrapper : ErrorWrapper
    
    ///With the @Environment property wrapper, you can read a value that the view’s environment stores, such as the view’s presentation mode, scene phase, visibility, or color scheme. In this case, you’ll access the view’s dismiss structure and call it like a function to dismiss the view.
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack {
                Text("An error has occurred!")
                    .font(.title)
                    .padding(.bottom)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                Text(errorWrapper.guidance)
                    .font(.caption)
                    .padding(.top)
                Spacer()
            }
            .padding()
            ///You’ll add a material to create a blur effect behind the view, like inserting a frosted-glass layer between the view and its background.
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dismiss"){
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    
    ///Your app can have a limited number of errors, and the system handles types that conform to Error.
    ///Enumerations represent a finite number of values, and conformance to Error is the Swift model for error handling.
    enum SampleError: Error {
        case errorRequired
    }
    
    static var wrapper : ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "You can safely ignore this error.")
    }
    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}

