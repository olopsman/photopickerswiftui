//
//  PhotoPicker.swift
//  PhotoPickerSwiftUI
//
//  Created by Paulo Orquillo on 5/12/21.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }
    
    // we are not going to update the view but this is still needed
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        //pass the instance of this Photopicker - self
        return Coordinator(photoPicker: self)
    }
    // needs to conform to NSObject, the picker has navigation delegate and picker delegate
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        //pass the photopicker to the coordinator to avoid recreating the bindings and assign them directly
        var photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        // UIImagePIckerControllerDelegate has method to return the media that was picked, we can inspect the info
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            //we can inspect the data returned by the media selected
            if let image = info[.originalImage] as? UIImage {
                photoPicker.image = image
            }
            //dismiss the view after selecting
            picker.dismiss(animated: true)
            
        }
    }
    
}
