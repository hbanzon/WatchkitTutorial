//
//  BoardingPassInterfaceController.swift
//  AirAber
//
//  Created by Hino Banzon on 4/3/16.
//  Copyright © 2016 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class BoardingPassInterfaceController: WKInterfaceController {

    @IBOutlet var originLabel: WKInterfaceLabel!
    @IBOutlet var destinationLabel: WKInterfaceLabel!
    @IBOutlet var boardingPassImage: WKInterfaceImage!
    
    var flight: Flight? {
        didSet {
            if let flight = flight {
                originLabel.setText(flight.origin)
                destinationLabel.setText(flight.destination)
            }
            
            if let _ = flight?.boardingPass {
                showBoardingPass()
            }
        }
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if let flight = context as? Flight { self.flight = flight }
    }
    
    override func didAppear() {
        super.didAppear()
        
        // if we have a valid flight that has no boarding pass and watch connectivity is suported then send message
        if let flight = flight where flight.boardingPass == nil && WCSession.isSupported() {
            session = WCSession.defaultSession() // default singleton
            
            // fire off the message to the companion iphone app
            //  include a dictionary containing the flight reference that will be forwarded to the iPhone app
            session!.sendMessage(["reference": flight.reference], replyHandler: { (response) -> Void in
                // reply handler receives a dictionary, and is called by the iPhone app
                // extract the image data of the boarding pass from the dictionary before attempting to create an instance
                // of the image with it
                if let boardingPassData = response["boardingPassData"] as? NSData, boardingPass = UIImage(data: boardingPassData) {
                    // set the image as the flight's boarding pass and jump over to the main queue where you call showBoardingPass()
                    flight.boardingPass = boardingPass
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.showBoardingPass()
                    })
                }
                
                }, errorHandler: { (error) -> Void in
                    print(error)
            })
        }
    }
    
    // Watch connectivity session
    //   All communication between the watch and phone is handled by the WCSession
    var session: WCSession? {
        didSet {
            if let session = session {
                session.delegate = self
                session.activateSession()
            }
        }
    }
    
    private func showBoardingPass() {
        boardingPassImage.stopAnimating()
        boardingPassImage.setWidth(120)
        boardingPassImage.setHeight(120)
        boardingPassImage.setImage(flight?.boardingPass)
    }
    
}


extension BoardingPassInterfaceController : WCSessionDelegate {
    
}