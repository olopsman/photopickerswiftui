//
//  ContentView.swift
//  PhotoPickerSwiftUI
//
//  Created by Paulo Orquillo on 5/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State private var image = UIImage(named: "garage")!
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    shouldPresentActionScheet.toggle()
                }
        }
        .sheet(isPresented: $shouldPresentImagePicker) {
            PhotoPicker(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: $image)
        }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = true
            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                self.shouldPresentImagePicker = true
                self.shouldPresentCamera = false
            }), ActionSheet.Button.cancel()])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
