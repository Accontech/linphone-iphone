//
//  Provider.h
//  linphone
//
//  Created by Norayr Harutyunyan on 3/27/17.
//
//

#import <Foundation/Foundation.h>
#import "Codec.h"

@interface Provider : NSObject

- (id) initWithNSDictionary:(NSDictionary*)dict;

@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) int port;
@property (nonatomic, retain) NSString *protocol;
@property (nonatomic, retain) NSString *proxy;
@property (nonatomic, retain) NSString *sipServer;
@property (nonatomic, retain) NSArray *codecs;

@end
