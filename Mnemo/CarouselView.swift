//
//  CarouselView.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import UIKit

struct CarouselView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = CarouselViewController
    
    func makeUIViewController(context: Context) -> CarouselViewController {
        let carouselViewController = CarouselViewController()
        return carouselViewController
    }
    
    func updateUIViewController(_ uiViewController: CarouselViewController, context: Context) {}
    
}

