//
//  BlankView.swift
//  Devotee
//
//  Created by Kulkarni, Pranav on 27/01/24.
//

import SwiftUI

struct BlankView: View {
    
    var backgroundColor: Color
    var backgroundOpacity: Double
    
    var body: some View {
        VStack {
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .background(backgroundColor.opacity(backgroundOpacity))
        .blendMode(.overlay)
        .ignoresSafeArea()
    }
}

#Preview {
    BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
        .background(BackgroundImageView())
        .background(backgroungGradient.ignoresSafeArea(.all))
}
