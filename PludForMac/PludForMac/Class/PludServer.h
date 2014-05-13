//
//  PludServer.h
//  PludForMac
//
//  Created by iTSangar on 13/05/14.
//  Copyright (c) 2014 3littlebit. All rights reserved.
//

#import "DTBonjourServer.h"

@interface PludServer : DTBonjourServer

- (id)initWithServerName:(NSString *)serverName;

@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSString *serverName;

@end
