//
//  CharacterModel.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "CharacterModel.h"

@implementation CharacterModel

+ (CharacterModel *)sharedModel {
    static CharacterModel *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        sharedMyManager.characterData = [[NSMutableArray alloc] init];
    });
    return sharedMyManager;
}



@end
