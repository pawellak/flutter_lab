//
//  SwiftUIView.swift
//  Runner
//
//  Created by Paweł Łąk on 03/07/2025.
//

import SwiftUI

struct SwiftUIView : View {
    
    @State private var isTapped = false
    
    var body : some View {
        VStack {
            Text("Hello, SwiftUI").font(.largeTitle).foregroundColor(isTapped ? Color.blue : Color.black).padding().onTapGesture {
               withAnimation {
                    self.isTapped.toggle()
                }
            }
            
            if isTapped {
                Image(systemName: "star.fill").foregroundColor(.yellow).font(.largeTitle).padding()
            }
        }
    }
}
