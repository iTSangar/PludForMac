//
//  PludServer.m
//  PludForMac
//
//  Created by iTSangar on 13/05/14.
//  Copyright (c) 2014 3littlebit. All rights reserved.
//

#import "PludServer.h"
#import "NSString+DTUtilities.h"
#import "DTBonjourDataConnection.h"

@implementation PludServer
{
	NSString *_serverName;
	NSString *_identifier;
}

- (id)initWithServerName:(NSString *)serverName
{
	self = [super initWithBonjourType:@"_pludboxapp._tcp."];
	
	if (self)
	{
		_serverName = [serverName copy];
		
		_identifier = [NSString stringWithUUID];
        
		[self _updateTXTRecord];
	}
	
	return self;
}

- (void)_updateTXTRecord
{
	self.TXTRecord = @{@"ID" : [_identifier dataUsingEncoding:NSUTF8StringEncoding], @"ServerName" : [_serverName dataUsingEncoding:NSUTF8StringEncoding]};
}

- (void)connection:(DTBonjourDataConnection *)connection didReceiveObject:(id)object
{
	// need to call super because this forwards the object to the server delegate
	[super connection:connection didReceiveObject:object];
	
	// we need to pass the object to all other connections so that they also see the messages
	for (DTBonjourDataConnection *oneConnection in self.connections)
	{
		if (oneConnection!=connection)
		{
			[oneConnection sendObject:object error:NULL];
		}
	}
}


@end
