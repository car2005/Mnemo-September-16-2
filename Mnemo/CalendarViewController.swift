//
//  CalendarViewController.swift
//  Mnemo
//
//  Created by Ana on 11/9/22.
//

import UIKit
import EventKit
import EventKitUI
import SwiftUI

class CalendarViewController: UIViewController, EKEventEditViewDelegate{
    
    let eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addEventButton(_ sender: Any) {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .notDetermined:
            eventStore.requestAccess(to: .event) { granted, error in
                if granted {
                    print("Authorized")
                    presentEventVC()
                }
            }
            print("Not determined")
        case .authorized:
            print("Authorized")
            presentEventVC()
        default:
            break
        }
        
        func presentEventVC() {
            let eventVC = EKEventEditViewController()
            eventVC.editViewDelegate = self
            eventVC.eventStore = EKEventStore()
            
            let event = EKEvent(eventStore: eventVC.eventStore)
            event.title = "Sample Event"
            event.startDate = Date()
            eventVC.event = event
            
            self.present(eventVC, animated: true, completion: nil)
        }
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}


