
//Draw view with save button

import SwiftUI
import PencilKit
import PhotosUI

struct DrawView: View {
    @State var saved: Bool = false
    let malva = Color(red: 0.54, green: 0.27, blue: 0.41)
    var canvasView = PKCanvasView()
   
    var body: some View {
        ZStack {
            CanvasView(canvasView: canvasView)
            
            Button(self.saved ? "Saved" : "Save", action: {
                UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
                canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)
                
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                if image != nil {
                    PHPhotoLibrary.shared().performChanges {
                        PHAssetChangeRequest.creationRequestForAsset(from: image!)
                    } completionHandler: { success, error in
                        if success {
                            self.saved = true
                        }
                    }
                }
            })
            .padding()
            .frame(width: 130)
            .background(malva)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .position(x: 80, y: 45)
            .disabled(self.saved)
            
            .alert(isPresented: $saved){
                Alert(title: Text("Well Done"), message: Text("Photo library has been updated"), dismissButton: .default(Text("Continue"), action: {
                    saved = false
                }))
            }
        }
    }
}

struct CanvasView: UIViewRepresentable {
    var canvasView: PKCanvasView
    let picker = PKToolPicker.init()
    
    func makeUIView(context: Context) -> PKCanvasView {
        self.canvasView.backgroundColor = .black
        self.canvasView.tool = PKInkingTool(.pen, color: .white, width: 15)
        self.canvasView.becomeFirstResponder()
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        picker.addObserver(canvasView)
        picker.setVisible(true, forFirstResponder: uiView)
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
            
        }
    }
}
