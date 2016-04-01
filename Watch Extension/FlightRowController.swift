//
//  FlightRowController.swift
//  AirAber
//
//  Created by Hino Banzon on 3/31/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit

class FlightRowController: NSObject {
    
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var flightNumberLabel: WKInterfaceLabel!
    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var planeImage: WKInterfaceImage!
    
    // optional property of type Flight
    var flight: Flight? {
        // triggered whenever the property is set
        didSet {
            // only execute if the flight is not nil
            if let flight = flight {
                // configure the labels of thte row
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
                flightNumberLabel.setText(flight.number)
                // change color based on flight status
                if flight.onSchedule {
                    statusLabel.setText("On Time")
                } else {
                    statusLabel.setText("Delayed")
                    statusLabel.setTextColor(UIColor.redColor())
                }
            }
        }
    }

}
