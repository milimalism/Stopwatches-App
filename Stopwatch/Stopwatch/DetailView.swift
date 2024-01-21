//
//  DetailView.swift
//  Stopwatches
//
//  Created by Mythili Mulani on 07/12/23.
//

import SwiftUI

struct DetailView: View {
    /// Current progress time expresed in minutes
    //@Binding var progressTime: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var deleteStopwatchFlag = false
    @Binding var stopwatch : Stopwatch
    @Binding var stopwatches : [Stopwatch]
    @State private var editingStopwatch = Stopwatch.emptyStopwatch
    @State private var isPresentingEditView = false
    
    //@State var stopwatch : Stopwatch
    //@State var progressTime: Int = 800
    @State private var isRunning = false
    
    /// Computed properties to get the progressTime in hh:mm:ss format
    var days: Int {
        (stopwatch.progressTime / 86400) % 100
    }
    
    var hours: Int {
        (stopwatch.progressTime / 3600) % 24
    }
    
    var minutes: Int {
        (stopwatch.progressTime / 60) % 60
    }
    
    func TimeUnitStr(timeUnit: Int) -> String {
        let timeUnitStr = String(timeUnit)
        return timeUnit < 10 ? "0" + timeUnitStr : timeUnitStr
    }
    
    func updateData() {
        var lastTuple = CodableTuple(stopwatch.start ?? Date(), Date())
        stopwatch.time.append(lastTuple)
        var duration = Int(round(lastTuple.value2.timeIntervalSince(lastTuple.value1))) // / 60)) REMEMBER TO CHANGE TO ROUND TO MINUTES
        stopwatch.data.append(CodableTuple(lastTuple.value1 , duration))
        print("\(lastTuple)   \(duration)")
    }
    
    func deleteStopwatch() {
        print("abc")
        stopwatches.removeAll { $0.id == stopwatch.id }
        presentationMode.wrappedValue.dismiss() // Dismiss the EditView
    }
    
    /// Increase progressTime each second
    @State private var timer: Timer?
    
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                Text("\(TimeUnitStr(timeUnit: days))")
                    .font(.system(size: 48))
                    .offset(y: -18)
                Text(":")
                    .font(.system(size: 48))
                    .offset(y: -18)
                Text("\(TimeUnitStr(timeUnit: hours))")                    .font(.system(size: 48))
                    .offset(y: -18)
                Text(":")
                    .font(.system(size: 48))
                    .offset(y: -18)
                Text("\(TimeUnitStr(timeUnit: minutes))")                    .font(.system(size: 48))
                    .offset(y: -18)
            }
            Text("\(stopwatch.progressTime)")
            
            HStack (spacing: 50) {
                Button(action: {
                    if isRunning{
                        
                        updateData()
                        timer?.invalidate()
                    } else {
                        stopwatch.start = Date()
                        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                            stopwatch.progressTime += 1
                        })
                    }
                    isRunning.toggle() }){
                        Text(isRunning ? "Stop" : "Start")
                    }
                    .buttonStyle(BlueButtonStyle(theme: stopwatch.theme))
                Button(action: {
                    print("Pressed!")
                    stopwatch.progressTime = 0
                    isRunning = false
                }){
                    Text("Reset")
                }.buttonStyle(BlueButtonStyle(theme: stopwatch.theme))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            stopwatch.theme.mainColor.opacity(0.3)
                .ignoresSafeArea()
        }
        .navigationTitle(stopwatch.title)
        .navigationBarItems(trailing:
            HStack {
                Button("Edit") {
                    isPresentingEditView = true
                    editingStopwatch = stopwatch
                }
                Button("Delete") {
                    deleteStopwatchFlag = true
                }
            }
            .alert(isPresented: $deleteStopwatchFlag) {
                Alert(
                    title: Text("Delete Stopwatch"),
                    message: Text("Are you sure you want to delete this stopwatch?"),
                    primaryButton: .destructive(Text("Delete")) {
                        deleteStopwatch()
                    },
                    secondaryButton: .cancel()
                )
            }
        )
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button("Charts") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationStack {
                EditView(stopwatch: $editingStopwatch)
                    .navigationTitle(stopwatch.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                stopwatch = editingStopwatch
                            }
                        }
                    }
            }
        }
    }
    
}

struct BlueButtonStyle: ButtonStyle {
    var theme : Theme
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 100, height: 100)
            .foregroundColor(theme.accentColor)
            .background(theme.mainColor)
            .clipShape(Circle())
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(stopwatch: .constant(Stopwatch.sampleData[0]), stopwatches: .constant(Stopwatch.sampleData))
        }
    }
}
