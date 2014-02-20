//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Roy Higgins on 2/5/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) NSUInteger numberOfCardsToMatch;
@property (weak, nonatomic) IBOutlet UILabel *cardInfoLabel;
@property (weak, nonatomic) IBOutlet UIStepper *matchCountStepper;
@property (weak, nonatomic) IBOutlet UILabel *cardsToMatchLabel;
@end

@implementation CardGameViewController

- (NSUInteger)numberOfCardsToMatch
{
    if(!_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc]
                         initWithCardCount:[self.cardButtons count]
                         usingDeck:[self createDeck] ];
    return _game;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)cardsToMatchStep:(id)sender {
    self.numberOfCardsToMatch = [self.matchCountStepper value];
    self.cardsToMatchLabel.text = [NSString stringWithFormat:@"Cards to Match: %d", self.numberOfCardsToMatch];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    Card *card = [self.game chooseCardAtIndex:chosenButtonIndex numberOfMatches:self.numberOfCardsToMatch];
    self.cardInfoLabel.text = [NSString stringWithFormat:@"%@ card choosen.", card.contents];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (NSString *)titleForCard:(Card *) card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}


@end
