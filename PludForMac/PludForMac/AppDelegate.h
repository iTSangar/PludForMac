//
//  AppDelegate.h
//  PludForMac
//
//  Created by iTSangar on 07/03/14.
//  Copyright (c) 2014 3littlebit. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end
