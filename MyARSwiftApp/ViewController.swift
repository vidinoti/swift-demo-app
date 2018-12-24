//
//  ViewController.swift
//  MyARSwiftApp
//
//  Created by Johan Leuenberger on 21.12.18.
//  Copyright © 2018 Vidinoti. All rights reserved.
//

import UIKit

class ViewController: VDARLiveAnnotationViewController, RemoteControllerDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var progressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Make sure we don't lock the screen while experiencing AR
        UIApplication.shared.isIdleTimerDisabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicator.isHidden = true
        progressLabel.isHidden = true
        // Delegate for listening to the synchronization progress
        VDARRemoteController.sharedInstance()?.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        VDARRemoteController.sharedInstance()?.delegate = nil
    }

    func remoteController(_ controller: VDARRemoteController!, didProgress prc: Float, isReady: Bool, folder: String!) {
        if prc >= 1 || prc.isNaN || prc.isInfinite {
            self.progressLabel.isHidden = true
            self.activityIndicator.isHidden = true
        } else {
            let percent = Int(prc * 100)
            self.progressLabel.text = "\(percent)%"
            self.progressLabel.isHidden = false
            self.activityIndicator.isHidden = false
        }
    }
}

