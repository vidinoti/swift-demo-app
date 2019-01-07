//
//  VDARLocalizationManager.h
//  MyARSwiftApp
//
//  Created by Johan Leuenberger on 07.01.19.
//  Copyright © 2019 Vidinoti. All rights reserved.
//

// Empty class for avoiding crash on iOS 11 devices (see https://vidinoti.github.io/201812-ios-xcode-swift-crash/)

#import <Foundation/Foundation.h>

@interface VDARLocalizationManager : NSObject {

}

+ (VDARLocalizationManager*)sharedInstance;

@end
