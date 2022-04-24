
//Intro and microanimations

import SwiftUI

struct IntroView: View {
    @Binding var index: Int
    @State var textIndex: Int = 0
    @State var animationPhase: Int = 0
    @State private var scale: CGFloat = 1
    @State private var textOpacity: CGFloat = 0.4
    @State private var textOffset: CGFloat = 0
    
    let malva = Color(red: 0.54, green: 0.27, blue: 0.41)
    let rouge = Color(red: 0.23, green: 0.05, blue: 0.14)
    var body: some View {
        ZStack{
            
            Text(speech[textIndex])
                .font(.system(size: 18))
                .bold()
                .foregroundColor(.white)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
            
            ForEach (0...3, id:\.self) {speechIndex in
                if speechIndex == textIndex{
                    Text(speech[textIndex])
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(.white)
                        .scaleEffect(scale)
                        .animation(speechIndex == 3 ? nil : .easeInOut(duration: 1).delay(speechIndex == 0 ? 0.5 : 0),  value: scale)
                        .opacity(textOpacity)
                        .animation(.easeInOut(duration: 1) .delay(speechIndex == 0 ? 0.5 : 0),  value: textOpacity)
                        .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
                        .offset(y: textOffset)
                        .animation(speechIndex != 3 ? nil : .easeInOut(duration: 1), value: textOffset)
                    
                        .onAppear{
                            self.textOpacity = 0
                            if speechIndex == 3 {
                                self.textOffset = 150
                            }
                            else {
                                self.scale = 2.5
                            }
                        }
                    
                }
            }
            
            if textIndex == speech.count - 1 {
                Button("Get Started", action: {
                    index+=1
                })
                .padding()
                .frame(width: 130)
                .background(malva)
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .rotationEffect(.degrees(animationPhase == 0 ? 0 : (animationPhase == 1 ? 5 : -5)))
                .animation(.easeInOut(duration: 0.1), value: animationPhase)
                .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-100)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.2, repeats: false) { _ in
                        
                        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                            if(animationPhase == 1) {
                                animationPhase = 2
                            }
                            else {
                                animationPhase = 1
                            }
                        }
                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                            timer.invalidate()
                            animationPhase = 0
                        }
                        
                        Timer.scheduledTimer(withTimeInterval: 3.5, repeats: true) { _ in
                            
                            let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                                if(animationPhase == 1) {
                                    animationPhase = 2
                                }
                                else {
                                    animationPhase = 1
                                }
                            }
                            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                timer.invalidate()
                                animationPhase = 0
                            }
                        }
                    }
                    
                    
                }
            }
            
        }
        .onTapGesture {
            if(textIndex < speech.count - 1) {
                scale = 1
                textOpacity = 0.4
                textIndex+=1
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            Rectangle()
                .foregroundColor(rouge))
        .ignoresSafeArea()
    }
}

let speech: [String] = [
    "Hello",
    "You love beautiful sounds",
    "What do they make you think of?",
    "Tap the bubbles and get inspired"
]

