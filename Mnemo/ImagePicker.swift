//
//  ImagePicker.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import PhotosUI


struct ImagePicker: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(phot1: self)
    }

    @Binding var isShown: Bool
    @Binding var image: [UIImage]
    var any = PHPickerConfiguration(photoLibrary: .shared())

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
        var configu = PHPickerConfiguration()
        configu.filter = .images
        configu.selectionLimit = 10

        let picker = PHPickerViewController(configuration: configu)
        picker.delegate = context.coordinator
        return picker
        }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
            
        }


    }
    class Coordinator : NSObject, PHPickerViewControllerDelegate {
    var phot : ImagePicker
    init(phot1 : ImagePicker) {
        phot = phot1
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for photo in results {
            if photo.itemProvider.canLoadObject(ofClass: UIImage.self) {
                photo.itemProvider.loadObject(ofClass: UIImage.self) {
                    (imagen, err) in
                    guard let photo1 = imagen else {
                        print("\(String(describing: err?.localizedDescription))")
                        return
                    }
                    self.phot.image.append(photo1 as! UIImage)
                }
            } else {
                print("No photos or videos were loaded")
            }
        }
    }
}

struct CarouselButton : View {
    @State var showcarousel = true
    var body: some View {
        NavigationView {
            NavigationLink("Carousel", destination: CarouselView(), isActive: self.$showcarousel)
        }
    }
}
