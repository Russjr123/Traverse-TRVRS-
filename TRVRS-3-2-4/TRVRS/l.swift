//
//  l.swift
//  TRVRS
//
//  Created by Mohammad Muksith on 2/27/23.
//

//
//  LeadersTileView.swift
//  StairStepperMaster
//
//  Created by Saamer Mansoor on 6/5/22.
//
//
import SwiftUI

struct ViewMAG_MultiStep: View{

    @FocusState var isFocused: Bool

    @EnvironmentObject var p: Params

    @State private var showResults = false

    @State private var induction = 0.0

    var body: some View{

        List{

            Button("Compute") {

                calcMultiStep(p: p)

                showResults.toggle()

            }

            .sheet(isPresented: $showResults) {

                Text("\(induction)")

                Text("\(p.induction)")

                ProgressView("Progress", value: p.progress, total: 100)

            }

        }

        .navigationTitle("Multi-step")

    }

}

class Params: ObservableObject {

    @Published var progress = 0.0

    @Published var value = 0.0

    

    @Published var induction = 0.0

}

func calcMultiStep(p: Params) {

    var induction = 0.0

    DispatchQueue.global().async {

        for i in 0...5 {

//            induction += Double(i) * calcSingleStep(p: p)

            // from main thread

            DispatchQueue.main.async {

                p.progress += 10.0

            }

        }

        print("Final value of induction: \(induction)")

        // from main thread

        DispatchQueue.main.async {

            p.induction = induction

        }

    }

}
struct RingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ViewMAG_MultiStep()

    }
}
