//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Roy Higgins on 2/16/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (Card *)chooseCardAtIndex:(NSUInteger)index
            numberOfMatches:(NSUInteger)numberOfMatches;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
