//
//  PlayingCard.h
//  Matchismo
//
//  Created by Roy Higgins on 2/10/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
