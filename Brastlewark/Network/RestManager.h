//
//  RestManager.h
//  Brastlewark
//
//  Created by Milo on 8/1/17.
//  Copyright © 2017 ar.com.milohualpa. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef void(^completionSuccess)(NSArray* gnomes);
typedef void(^completionFailure)(NSError* error);

typedef enum GnomesTown {
    Brastlewark,
    Laekastel,
    Misarias,
    Remesiana,
    Ostenso,
} GnomesTown;

@interface RestManager : AFHTTPSessionManager

+ (id)sharedManager;

- (void)getGnomesForTown:(GnomesTown) town success:(completionSuccess) success failure:(completionFailure) failure;

-(void)getImageForGnome:(UIImageView*)imageView fromURL:(NSURL*)url;

@end
