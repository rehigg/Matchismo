//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Roy Higgins on 2/5/14.
//  Copyright (c) 2014 Roy Higgins. All rights reserved.
//
//  Abstract class.  Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
// protected
// for subclasses
- (Deck *)createDeck; //abstract

@end
