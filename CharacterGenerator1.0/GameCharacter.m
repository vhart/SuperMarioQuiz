//
//  GameCharacter.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "GameCharacter.h"

@interface GameCharacter()
@property (nonatomic) NSDictionary *options;


@end

@implementation GameCharacter

- (instancetype) initWithFood:(NSString *)food hobby:(NSString *)hobby goal:(NSString*)goal andGamerTag:(NSString *)gamerTag{
    self.options = @{
                 @"mamma's lasagna"            : @"Mario",
                 @"mamma's spaghetti"          : @"Luigi",
                 @"mushroom pizza"             : @"Toad",
                 @"kale salad"                 : @"Princess Peach",
                 
                 @"total world domination"     : @"Fight Bowser",
                 @"true love"                  : @"save Princess Peach",
                 @"i want to be rich"          : @"Get 100 coins!",
                 
                 @"at the beach"               : @"Your venturing through the Water World!",
                 @"in a volcano"               : @"Survive the Heat in the Lava World!",
                 @"in a tree"                  : @"Navigate the Jungle in the Forest World!",
                 };
    
    if (self = [super init]) {
        
        
        
        self.characterName = [self.options objectForKey:food];
        self.locationName  = [self.options objectForKey:hobby];
        self.mission       = [self.options objectForKey:goal];
        self.gamerTag = gamerTag;
        
        return self;
        
    }
    return nil;
}



@end
