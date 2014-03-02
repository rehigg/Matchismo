//
//  PlayingCardViewController.m
//  Matchismo
//
//  Created by Roy Higgins on 3/1/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

@end
