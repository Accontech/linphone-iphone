//
//  Codec.h
//  linphone
//
//  Created by Norayr Harutyunyan on 3/27/17.
//
//

#import <Foundation/Foundation.h>

@interface Codec : NSObject

- (id) initWithNSDictionary:(NSDictionary*)dict;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) int priority;

@end
