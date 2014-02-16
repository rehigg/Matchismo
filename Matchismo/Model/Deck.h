//
//  Deck.h
//  Matchismo
//
//  Created by Roy Higgins on 2/9/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card;
- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
