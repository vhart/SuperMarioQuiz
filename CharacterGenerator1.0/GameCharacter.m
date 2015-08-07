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
@property (nonatomic) NSArray *randomObjects_Images;


@end

@implementation GameCharacter

- (instancetype) initWithFood:(NSString *)food hobby:(NSString *)hobby goal:(NSString*)goal andGamerTag:(NSString *)gamerTag{
    self.options = @{
                 @"mamma's lasagna"            : @"Mario",
                 @"mamma's spaghetti"          : @"Luigi",
                 @"mushroom pizza"             : @"Toad",
                 @"kale salad"                 : @"Princess Peach",
                 
                 @"world domination"           : @"fight Bowser!",
                 @"true love"                  : @"save Princess Peach!",
                 @"i want to be rich"          : @"get 100 coins!",
                 
                 @"go to the beach"            : @"venture through the Water World",
                 @"explore a volcano"          : @"survive the burning heat of the Lava World",
                 @"climb a tree"               : @"navigate the Jungle in the Forest World",
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

-(void) generateRandomObject{
    self.randomObjects_Images = @[
                                  [UIImage imageNamed:@"fireflower.png"],
                                  [UIImage imageNamed:@"ghost.png"],
                                  [UIImage imageNamed:@"mushroom.png"],
                                  [UIImage imageNamed:@"star.png"],
                                  ];
    NSInteger indexForObject = arc4random_uniform(4);
    self.randomItem = self.randomObjects_Images[indexForObject];
    self.randomItemDecided = YES;
    
}

@end
