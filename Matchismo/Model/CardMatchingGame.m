//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Roy Higgins on 2/16/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;  //of Card
@property (nonatomic, readwrite) NSUInteger cardsToMatch;
@property (nonatomic, strong, readwrite) NSMutableString *lastActionMessage;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];  //super's designated initializer
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (Card *)chooseCardAtIndex:(NSUInteger)index
            numberOfMatches:(NSUInteger)numberOfMatches
{
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSMutableArray *choosenCards = [[NSMutableArray alloc] init];
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [choosenCards addObject:otherCard];
                    int matchScore = [card match:@[otherCard]];
                    for (int i = 1; i < numberOfMatches; i++) {
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            self.lastActionMessage = [NSMutableString stringWithFormat:@"%@ matches %@", card.contents , otherCard.contents];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.lastActionMessage = [NSMutableString stringWithFormat:@"%@ does not match %@", card.contents , otherCard.contents];
                        }
                    }
                    break;
                } else {
                    self.lastActionMessage = [NSMutableString stringWithFormat:@"Choose %@.", card.contents];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    return card;
}


@end
