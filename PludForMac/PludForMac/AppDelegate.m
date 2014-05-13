//
//  AppDelegate.m
//  PludForMac
//
//  Created by iTSangar on 07/03/14.
//  Copyright (c) 2014 3littlebit. All rights reserved.
//

#import "AppDelegate.h"
#import "NSStatusItem+BCStatusItem.h"
#import "BCStatusItemView.h"
#import "PludServer.h"

@implementation AppDelegate

NSMutableArray *_createdServers;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    _createdServers = [[NSMutableArray alloc] init];
    
	_statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	
	[_statusItem setupView];
	
    // The text that will be shown in the menu bar
	[_statusItem setTitle:@""];
    
    // The menu when click in menu bar
	[_statusItem setMenu:_statusMenu];
    
    // The image gets a blue background when the item is selected
	[_statusItem setHighlightMode:YES];
	
    // The image that will be shown in the menu bar, a 16x16 black png works best
    NSImage *image = [NSImage imageNamed:@"status_item_normal_mac"];
	[_statusItem setImage:image];
    
    // The highlighted image, use a white version of the normal image
    NSImage *alternateImage = [NSImage imageNamed:@"status_item_active_mac"];
	[_statusItem setAlternateImage:alternateImage];
	
    
	[_statusItem setViewDelegate:self];
	[[_statusItem view] registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
}

#pragma mark - Drag/Drop BCStatusItem delegate
- (NSDragOperation)statusItemView:(BCStatusItemView *)view draggingEntered:(id <NSDraggingInfo>)info
{
	NSLog(@"Drag entered!");
	return NSDragOperationCopy;
}

- (void)statusItemView:(BCStatusItemView *)view draggingExited:(id <NSDraggingInfo>)info
{
	NSLog(@"Dragging exit");
}

- (BOOL)statusItemView:(BCStatusItemView *)view prepareForDragOperation:(id <NSDraggingInfo>)info
{
	NSLog(@"Prepare for drag");
	return YES;
}

- (BOOL)statusItemView:(BCStatusItemView *)view performDragOperation:(id <NSDraggingInfo>)info
{
	NSLog(@"Perform drag");
    
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [info draggingSourceOperationMask];
    pboard = [info draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        
        NSLog(@"Files: %@",files);
        
        // Init server from Bonjour
        PludServer *newServer = [[PludServer alloc] initWithServerName:[self nameMusicWithoutPath:files]];
        [_createdServers addObject:newServer];
        [newServer start];
    }
    return YES;
}

- (NSString *)nameMusicWithoutPath:(NSArray *)arrayFile
{
    NSString *file = [NSString stringWithFormat:@"%@", arrayFile];
    NSArray *slice = [file componentsSeparatedByString: @"/"];
    NSString* day = [slice lastObject];
    
    return day;
}

@end
