//
//  CharacterModel.h
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterModel : NSObject

+ (CharacterModel *)sharedModel;

@property (nonatomic, strong) NSMutableArray *characterData;


@end
