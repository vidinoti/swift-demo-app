//
//  VidinotiService.swift
//  MyARSwiftApp
//
//  Created by Johan Leuenberger on 24.12.18.
//  Copyright © 2018 Vidinoti. All rights reserved.
//

import Foundation

// Defines whether a synchronization process is already running
fileprivate var syncing = false

class VidinotiService {

    // Synchronize with V-Director. It downloads the content of a given language (either English or French)
    func synchronize() {
        if syncing {
            return
        }
        syncing = true

        // Show how the multilingual synchronization can be done
        var tagName: String;
        if let langCode = Locale.current.languageCode, langCode == "fr" {
            tagName = "lang_fr"
        } else {
            // Default and fallback language
            tagName = "lang_en"
        }
        print("Synchronizing with tag name: \(tagName)")
        let priors: [Any] = [VDARTagPrior(tagName: tagName)]
        VDARSDKController.sharedInstance()?.afterLoadingQueue.addOperation {
            DispatchQueue.main.async {
                VDARRemoteController.sharedInstance()?.syncRemoteModelsAsynchronously(withPriors: priors, withCompletionBlock: {result, error in
                    syncing = false
                    print("Synchronization ended: \(String(describing: result))")
                    if let error = error {
                        print("The system got an error during synchronization: \(error)")
                    }
                    })
            }
        }
    }

}
