//
//  MainView.swift
//  ARSiri
//
//  Created by Surya Chappidi on 17/12/20.
//  Copyright © 2020 Surya Chappidi. All rights reserved.
//

import SwiftUI
import Speech

struct MainView: View {
    @EnvironmentObject var swiftUISpeech:SwiftUISpeech
    
    var body: some View {
        VStack {
            VStack{
                Text("\(swiftUISpeech.outputText)")// prints results to screen
                    .font(.title)
                    .bold()
                
            }.frame(width: 300,height: 400)
            
            VStack {// Speech button
                swiftUISpeech.getButton()
                Spacer()
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(SwiftUISpeech())
    }
}
