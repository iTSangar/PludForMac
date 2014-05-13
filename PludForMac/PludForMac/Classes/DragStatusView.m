//
//  DragStatusView.m
//  PludForMac
//
//  Created by iTSangar on 13/05/14.
//  Copyright (c) 2014 3littlebit. All rights reserved.
//

#import "DragStatusView.h"

@implementation DragStatusView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //register for drags
        [self registerForDraggedTypes:[NSArray arrayWithObjects: NSFilenamesPboardType, nil]];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    
    NSStatusItem *statusItem;
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    
    // The text that will be shown in the menu bar
    statusItem.title = @"";
    
    // The image that will be shown in the menu bar, a 16x16 black png works best
    statusItem.image = [NSImage imageNamed:@"status_item_normal_mac"];
    
    // The highlighted image, use a white version of the normal image
    statusItem.alternateImage = [NSImage imageNamed:@"status_item_normal_mac"];
    
    // The image gets a blue background when the item is selected
    statusItem.highlightMode = YES;
    
    [self addSubview:statusItem.view];

}
//- (void)drawRect:(NSRect)dirtyRect
//{
//    //the status item will just be a yellow rectangle
//    [[NSColor yellowColor] set];
//    NSRectFill([self bounds]);
//}

//we want to copy the files
- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

//perform the drag and log the files that are dropped
- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
    NSPasteboard *pboard;
    NSDragOperation sourceDragMask;
    
    sourceDragMask = [sender draggingSourceOperationMask];
    pboard = [sender draggingPasteboard];
    
    if ( [[pboard types] containsObject:NSFilenamesPboardType] ) {
        NSArray *files = [pboard propertyListForType:NSFilenamesPboardType];
        
        NSLog(@"Files: %@",files);
    }
    return YES;
}

@end
