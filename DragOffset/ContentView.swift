//
//  ContentView.swift
//  DragOffset
//
//  Created by Todd Hamilton on 3/13/22.
//

import SwiftUI

struct ContentView: View {
    
    @State var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.indigo
            VStack(alignment:.leading, spacing:0){
                Text("**Offset W**: \(dragOffset.width)")
                Text("**Offset H**: \(dragOffset.height)")
                Text("**Rotation**: \(getRotationAmount())")
            }
            .padding(8)
            .font(.system(size:11,weight:.regular, design: .monospaced))
            .foregroundColor(.white)
            .background(Color.black)
            .frame(maxWidth:.infinity,maxHeight:.infinity,alignment:.topLeading)
            .padding(8)
            
            RoundedRectangle(cornerRadius: 16)
                .background(.white)
                .frame(width:150, height:150)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.4), radius: 4, x: -dragOffset.width/4, y: -dragOffset.height/4)
                .overlay(
                    Image(systemName:"hand.draw")
                        .font(.system(size:60))
                        .foregroundColor(.black)
                )
                .offset(dragOffset)
                .rotation3DEffect(.degrees(getRotationAmount()), axis: (x:0, y:1, z:1), anchor: .center, anchorZ: .zero, perspective: 2)
                .gesture(
                    DragGesture()
                        .onChanged(){ value in
                            dragOffset = value.translation
                        }
                        .onEnded(){ value in
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.75, blendDuration: 0.1)){
                                dragOffset = .zero
                            }
                        }
                )
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity)
        .preferredColorScheme(.dark)
    }
    func getRotationAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width
        let currentAmount = dragOffset.width
        let degrees = currentAmount / max
        return (degrees * 100) / 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
