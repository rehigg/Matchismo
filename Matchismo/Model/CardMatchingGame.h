//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Roy Higgins on 2/16/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)indexl

@property (nonatomic, readonly) NSInteger score;

@end
