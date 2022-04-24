
//Colorful bubble view where you can choose a song by tapping them

import SwiftUI
import AVKit

struct BubbleView: View {
    @Binding var index: Int
    @Binding var songPath: String?
    
    @State var audio: AVAudioPlayer!
    @State var scale : CGFloat = 1
    
    let malva = Color(red: 0.54, green: 0.27, blue: 0.41)
    let rouge = Color(red: 0.23, green: 0.05, blue: 0.14)
    
    var body: some View {
        
        ZStack {
            ForEach (1...10, id:\.self) { circleIndex in
                Circle()
                    .foregroundColor(Color (red: .random(in: 0.3...1),
                                            green: .random(in: 0.3...1),
                                            blue: .random(in: 0.3...1)))
                
                    .blendMode(.colorDodge) // The bottom circle is lightened by the top layer
                    .animation ( Animation.spring (dampingFraction: 0.5)
                        .repeatForever()
                        .speed (.random(in: 0.05...0.4))
                        .delay(.random (in: 0...1)), value: scale
                    ) // move the circle to the target point and bounce back
                
                    .scaleEffect(self.scale * .random(in: 1...3))
                    .frame(width: .random(in: 20...100),
                           height: CGFloat.random (in:20...100),
                           alignment: .center)
                    .position(CGPoint(x: .random(in: 25...UIScreen.main.bounds.width-10),
                                      y: .random (in:25...UIScreen.main.bounds.height-200)))
                    .onTapGesture {
                        self.songPath = Bundle.main.path(forResource: "Song\(circleIndex).mp3", ofType: nil)
                        if(self.songPath != nil) {
                            let songUrl = URL(fileURLWithPath: songPath!)
                            self.audio = nil
                            self.audio = try! AVAudioPlayer(contentsOf: songUrl) //adds the music track
                            self.audio?.play()
                        }
                        
                    }
            }
            
            Button("Draw", action: {
                index+=1
            })
            .padding()
            .frame(width: 130)
            .background(malva)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .position(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height-100)
        }
        .onAppear {
            self.scale = 1.2 // default circle scale
        }
        
        .drawingGroup(opaque: false, colorMode: .linear) // makes the app faster, rendering the contents of the view into an off-screen image before putting it back onto the screen as a single rendered output
        .background(
            Rectangle()
                .foregroundColor(rouge))
        .ignoresSafeArea()
    }
}
