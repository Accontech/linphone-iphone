//
//  Provider.m
//  linphone
//
//  Created by Norayr Harutyunyan on 3/27/17.
//
//

#import "Provider.h"

@implementation Provider

@synthesize ID;
@synthesize logo;
@synthesize name;
@synthesize port;
@synthesize protocol;
@synthesize proxy;
@synthesize sipServer;
@synthesize codecs;

- (id) initWithNSDictionary:(NSDictionary*)dict {
    self = [super init];
    
    if (self) {
        self.ID = [dict objectForKey:@"_id"];
        self.logo = [dict objectForKey:@"logo"];
        self.name = [dict objectForKey:@"name"];
        self.port = [[dict objectForKey:@"port"] intValue];
        self.protocol = [dict objectForKey:@"protocol"];
        self.proxy = [dict objectForKey:@"proxy"];
        self.sipServer = [dict objectForKey:@"sipServer"];
        
        NSArray *array = [dict objectForKey:@"codecs"];
        NSMutableArray *arrayCodecs = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dictCodec in array) {
            Codec *codec = [[Codec alloc] initWithNSDictionary:dictCodec];
            [arrayCodecs addObject:codec];
        }
        
        self.codecs = (NSArray*)arrayCodecs;
    }
    
    return self;
}

@end
