//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Harjeet Taggar on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain; 
@property (nonatomic, strong) NSMutableArray *sentStack;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize sentdisplay = _sentdisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize brain = _brain;
@synthesize sentStack = _sentStack;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    [self.sentStack addObject:digit];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    NSString *operation = sender.currentTitle;
    [self.sentStack addObject:operation];
    NSString *sent = [[self.sentStack valueForKey:@"description"] componentsJoinedByString:@" "];
    if (sent == nil) {
        self.sentdisplay.text = @"nope";
    } else {
        self.sentdisplay.text = sent;
    }
    
    if (self.userIsInTheMiddleOfEnteringANumber) [self enterPressed];
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
  
}

- (void)viewDidUnload {
    [self setSentdisplay:nil];
    [super viewDidUnload];
}
@end
