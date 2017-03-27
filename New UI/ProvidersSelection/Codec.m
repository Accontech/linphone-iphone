//
//  Codec.m
//  linphone
//
//  Created by Norayr Harutyunyan on 3/27/17.
//
//

#import "Codec.h"

@implementation Codec

@synthesize name;
@synthesize priority;

- (id) initWithNSDictionary:(NSDictionary*)dict {
    self = [super init];
    
    if (self) {
        self.name = [dict objectForKey:@"name"];
        self.priority = [[dict objectForKey:@"priority"] intValue];
    }
    
    return self;
}

@end
