//
//  RestManager.m
//  Brastlewark
//
//  Created by Milo on 8/1/17.
//  Copyright © 2017 ar.com.milohualpa. All rights reserved.
//

#import "RestManager.h"
#import <UIImageView+AFNetworking.h>

static NSString *const kBaseUrl = @"https://raw.githubusercontent.com/rrafols/";
static NSString *const kBrastlewarkTown = @"mobile_test/master/data.json";

@implementation RestManager

#pragma mark Singleton Methods

+ (id)sharedManager {
    static RestManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL* baseUrl = [NSURL URLWithString:kBaseUrl];
        sharedManager = [[self alloc]initWithBaseURL:baseUrl];
        sharedManager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *jsonPlainResponseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableSet *jsonAcceptableContentTypes = [NSMutableSet setWithSet:jsonPlainResponseSerializer.acceptableContentTypes];
        [jsonAcceptableContentTypes addObject:@"text/plain"];
        jsonPlainResponseSerializer.acceptableContentTypes = jsonAcceptableContentTypes;
        sharedManager.responseSerializer = jsonPlainResponseSerializer;
    });
    return sharedManager;
}


#pragma mark API

- (void)getGnomesForTown:(GnomesTown) town success:(completionSuccess) success failure:(completionFailure) failure{
    
    NSString *gnomeTown;
    
    switch (town) {
        case Brastlewark:
            gnomeTown = @"Brastlewark";
            [self getGnomes:gnomeTown success:success failure:failure];
            break;
            
        default:
            break;
    }
}

-(void)getImageForGnome:(UIImageView*)imageView fromURL:(NSURL*)url{
    
    // Download images asynchronously
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:url
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [imageView setImageWithURLRequest:imageRequest placeholderImage:[UIImage imageNamed:@"placeholder"] success:nil failure:nil];
    
    //return UIImageView.new;
}

#pragma mark Private

- (void)getGnomes:(NSString *)town success:(completionSuccess) success failure:(completionFailure) failure {
    [self GET:kBrastlewarkTown parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSArray *gnomesTown = (NSArray*)[responseObject objectForKey:town];
            success(gnomesTown);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


@end
