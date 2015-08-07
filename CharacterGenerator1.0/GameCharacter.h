//
//  GameCharacter.h
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GameCharacter : NSObject

@property (nonatomic) NSString *gamerTag;
@property (nonatomic) NSString *characterName;
@property (nonatomic) NSString *locationName;
@property (nonatomic) NSString *mission;
@property (nonatomic) NSString *item;
@property (nonatomic) BOOL randomItemDecided;
@property (nonatomic) UIImage *randomItem;

- (instancetype) initWithFood:(NSString *)food hobby:(NSString *)hobby goal:(NSString*)goal andGamerTag:(NSString *)gamerTag;
- (void)generateRandomObject;

@end
