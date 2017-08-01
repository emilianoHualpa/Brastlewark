//
//  Gnome.m
//  Brastlewark
//
//  Created by Milo on 11/8/16.
//  Copyright © 2016 ar.com.milohualpa. All rights reserved.
//

#import "Gnome.h"

@implementation Gnome

NSString *const kGnomeId = @"id";
NSString *const kGnomeName = @"name";
NSString *const kGnomeThumbnailURL = @"thumbnail";
NSString *const kGnomeAge = @"age";
NSString *const KGnomeWeight = @"weight";
NSString *const kGnomeHeight = @"height";
NSString *const kGnomeHairColor = @"hair_color";
NSString *const kGnomeProfessions = @"professions";
NSString *const kGnomeFriends = @"friends";

- (instancetype) initWithConfiguration:(NSDictionary *)configuration {
    if(self = [self init]){
        if ([configuration isKindOfClass:[NSDictionary class]]) {
            self.gnomeId = [[configuration objectForKey:kGnomeId] integerValue];
            self.name = [configuration objectForKey:kGnomeName];
            self.thumbnailURL = [NSURL URLWithString:[configuration objectForKey:kGnomeThumbnailURL]];
            self.age = [[configuration objectForKey:kGnomeAge] integerValue];
            self.weight = [[configuration objectForKey:KGnomeWeight] doubleValue];
            self.height = [[configuration objectForKey:kGnomeHeight] doubleValue];
            self.hairColor = [configuration objectForKey:kGnomeHairColor];
            self.professions = [configuration objectForKey:kGnomeProfessions];
            self.friends = [configuration objectForKey:kGnomeFriends];
        }
    }
    return self;
}

#pragma mark Lazy instantiation

-(NSString *)friendsString {
    if(!_friendsString){
        
        if(self.friends.count > 0) {
            // Concatenate friends into String
            NSMutableString *friends = (NSMutableString*)[self.friends componentsJoinedByString:@", "];
            [friends appendString:@"."];
            _friendsString = friends;
        } else {
            _friendsString = @"Apparently I don't have any friends. 😢";
        }
    }
    return _friendsString;
}

-(NSString *)professionsString {
    if(!_professionsString){
        // Concatenate professions into String
        if(self.professions.count > 0) {
            NSMutableString *professions = (NSMutableString*)[self.professions componentsJoinedByString:@", "];
            [professions appendString:@"."];
            _professionsString = professions;
        } else {
            _professionsString = @"No professions found.";
        }
    }
    return _professionsString;
}

@end
