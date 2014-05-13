//
//  AppDelegate.m
//  PludForMac
//
//  Created by iTSangar on 07/03/14.
//  Copyright (c) 2014 3littlebit. All rights reserved.
//

#import "AppDelegate.h"
#import "DragStatusView.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // The text that will be shown in the menu bar
    _statusItem.title = @"";
    
    // The image that will be shown in the menu bar, a 16x16 black png works best
    _statusItem.image = [NSImage imageNamed:@"status_item_normal_mac"];
    
    // The highlighted image, use a white version of the normal image
    _statusItem.alternateImage = [NSImage imageNamed:@"status_item_normal_mac"];
    
    // The image gets a blue background when the item is selected
    _statusItem.highlightMode = YES;
    
    
    DragStatusView *dragView = [[DragStatusView alloc] initWithFrame:NSMakeRect(0, 0, 21, 21)];
    
    [_statusItem setView:dragView];
}

@end
