//
//  ViewControllerView.swift
//  Mnemo
//
//  Created by Ana on 13/9/22.
//

import SwiftUI
import UIKit

struct ViewControllerView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ViewController
    
    func makeUIViewController(context: Context) -> ViewController {
        let viewcontroller = ViewController()
        return viewcontroller
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
    
}

