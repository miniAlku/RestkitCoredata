//
//  RKObjectManager+Logging.m
//  SampleRestKit
//
//  Created by Thahir on 20/02/15.
//  Copyright (c) 2015 Thahir. All rights reserved.
//

#import "RKObjectManager+Logging.h"

@implementation RKObjectManager (Logging)

+ (void)initLogging {
    RKLogConfigureByName("RestKit", RKLogLevelWarning);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
}

@end
