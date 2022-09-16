//
//  ViewController2View.swift
//  Mnemo
//
//  Created by Ana on 13/9/22.
//

import SwiftUI
import UIKit

struct ViewController2View: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ViewController2
    
    func makeUIViewController(context: Context) -> ViewController2 {
        let viewcontroller = ViewController2()
        return viewcontroller
    }
    
    func updateUIViewController(_ uiViewController: ViewController2, context: Context) {}
    
}

