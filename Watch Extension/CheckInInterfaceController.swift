//
//  CheckInInterfaceController.swift
//  AirAber
//
//  Created by Hino Banzon on 4/3/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class CheckInInterfaceController: WKInterfaceController {

    @IBOutlet var backgroundGroup: WKInterfaceGroup!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    
    var flight: Flight? {
        didSet {
            if let flight = flight {
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let flight = context as? Flight {
            self.flight = flight
        }
    }
    
    @IBAction func checkInButtonTapped() {
        // define duration of the animation and delay after which the controller will be dismissed
        let duration = 0.35
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64((duration + 0.15) * Double(NSEC_PER_SEC)))
        
        // load a sequence of imaged named Progress and set them as the background image of the backgroundGroup
        backgroundGroup.setBackgroundImageNamed("Progress")
        
        // begin playback of the image sequence, the range supplied covers the entire sequence and a repeat
        // count of 1 means the animation will just play once
        backgroundGroup.startAnimatingWithImagesInRange(NSRange(location: 0, length: 10),
                                                        duration: duration, repeatCount: 1)
        
        // Use Grand Central Dispatch to eecute the closure after the given delay
        dispatch_after(delay, dispatch_get_main_queue()) { () -> Void in
            // in this closure, mark flight as checked-in and dismiss the controller
            self.flight?.checkedIn = true
            self.dismissController()
        }
        
    }
    
}
