//
//  FlightInterfaceController.swift
//  AirAber
//
//  Created by Hino Banzon on 3/31/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class FlightInterfaceController: WKInterfaceController {

    @IBOutlet var flightLabel: WKInterfaceLabel!
    @IBOutlet var routeLabel: WKInterfaceLabel!
    @IBOutlet var boardingLabel: WKInterfaceLabel!
    @IBOutlet var boardTimeLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var gateLabel: WKInterfaceLabel!
    @IBOutlet var seatLabel: WKInterfaceLabel!
    
    // Optional property of type Flight
    var flight: Flight? {
        // Property observer that is triggered whenever a property is set.
        didSet {
            // make sure there's an actual flight rather than a nil in the optional property,
            // we only want to proceed if we have an actual flight value
            if let flight = flight {
                
                // configure the labels using relevant properties of flight
                flightLabel.setText("Flight \(flight.shortNumber)")
                routeLabel.setText(flight.route)
                boardingLabel.setText("\(flight.number) Boards")
                boardTimeLabel.setText(flight.boardsAt)
                
                // if flight is delayed then change the text colour of the label to red.
                if flight.onSchedule {
                    statusLabel.setText("On Time")
                } else {
                    statusLabel.setText("Delayed")
                    statusLabel.setTextColor(UIColor.redColor())
                }
                gateLabel.setText("Gate \(flight.gate)")
                seatLabel.setText("Seat \(flight.seat)")
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let flight = context as? Flight {
            self.flight = flight
        }
    }
    
}
