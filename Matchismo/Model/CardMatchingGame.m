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
@property (nonatomic, strong, readwrite) NSMutableString *lastActionMessage;
- (void)matchCards:(NSMutableArray*)choosenCards
   numberOfMatches:(NSUInteger)numberOfMatches
       cardToMatch:(Card*)cardToMatch;
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
                } else {
                    self.lastActionMessage = [NSMutableString stringWithFormat:@"Choose %@.", card.contents];
                }
            }
            if ([choosenCards count] == numberOfMatches - 1) {
                [self matchCards:choosenCards numberOfMatches:numberOfMatches cardToMatch:card];
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    return card;
}

- (void)matchCards:(NSMutableArray*)choosenCards
   numberOfMatches:(NSUInteger)numberOfMatches
       cardToMatch:(Card*)cardToMatch
{
    int totalMatchScore = 0;
    int matches = 0;
    for (Card *otherChoosenCard in choosenCards) {
        int matchScore = [cardToMatch match:@[otherChoosenCard]];
        totalMatchScore += matchScore;
        if (matchScore) {
            matches += 1;
        }
    }
    if (matches == numberOfMatches - 1) {
        self.score += totalMatchScore * MATCH_BONUS;
            [self markCardsMatched:choosenCards cardToMatch:cardToMatch];
            cardToMatch.matched = YES;
        } else {
            self.score -= MISMATCH_PENALTY;
            [self markCardsNotChoosen:choosenCards cardToMatch:cardToMatch];
        }
}

- (void)markCardsMatched:(NSMutableArray*)choosenCards
             cardToMatch:(Card*)cardToMatch
{
    NSMutableString *contents = [[NSMutableString alloc] init];
    for (Card *otherChoosenCard in choosenCards) {
        otherChoosenCard.matched = YES;
        if ([contents length]) {
            [contents appendString:@" and "];
        }
        [contents appendString:otherChoosenCard.contents];
    }
    self.lastActionMessage = [NSMutableString stringWithFormat:@"%@ matches %@", cardToMatch.contents , contents];
}

- (void)markCardsNotChoosen:(NSMutableArray*)choosenCards
                cardToMatch:(Card*)cardToMatch
{
    NSMutableString *contents = [[NSMutableString alloc] init];
    for (Card *otherChoosenCard in choosenCards) {
        otherChoosenCard.chosen = NO;
        if ([contents length]) {
            [contents appendString:@" and "];
        }
        [contents appendString:otherChoosenCard.contents];
    }
    self.lastActionMessage = [NSMutableString stringWithFormat:@"%@ does not match %@", cardToMatch.contents , contents];
}


@end
