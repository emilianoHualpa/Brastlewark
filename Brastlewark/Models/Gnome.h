//
//  Gnome.h
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gnome : NSObject

@property (assign, nonatomic) NSInteger gnomeId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *thumbnailURL;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) double weight;
@property (assign, nonatomic) double height;
@property (strong, nonatomic) NSString *hairColor;
@property (strong, nonatomic) NSArray *professions;
@property (strong, nonatomic) NSString *professionsString;
@property (strong, nonatomic) NSArray *friends;
@property (strong, nonatomic) NSString *friendsString;

//Initializer
- (instancetype) initWithConfiguration:(NSDictionary *)configuration;

@end
