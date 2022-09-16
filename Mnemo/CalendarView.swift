//
//  CalendarView.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import SwiftUI
import UIKit
import EventKit
import EventKitUI

struct CalendarView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = CalendarViewController
    
    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarViewController = CalendarViewController()
        return calendarViewController
    }
    
    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {}
    
}

