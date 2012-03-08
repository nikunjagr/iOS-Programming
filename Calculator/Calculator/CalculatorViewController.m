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
@property (nonatomic) BOOL isVariable;
@property (nonatomic, strong) CalculatorBrain *brain; 
@property (nonatomic, strong) NSMutableArray *sentStack;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize sentdisplay = _sentdisplay;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize isVariable = _isVariable;
@synthesize brain = _brain;
@synthesize sentStack = _sentStack;

-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

-(NSMutableArray *) sentStack
{
    if (_sentStack == nil) _sentStack = [[NSMutableArray alloc] init];
        return _sentStack;
}

- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = sender.currentTitle;
    
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}

- (IBAction)variablePressed:(UIButton *)sender
{
    NSString *variable = sender.currentTitle;
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:variable];
    } else {
        self.display.text = variable;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    self.isVariable = YES;
}

- (IBAction)enterPressed {
    // surely a more efficient way of writing this code?
    NSString *val = [[NSString alloc] init];
    val = self.display.text;
    
    if (self.isVariable == YES) {
        [self.brain pushVariable:val];
    } else {
        [self.brain pushOperand:[val doubleValue]];
    }
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.isVariable = NO;
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];   
    }
    double result = [self.brain doCalculation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
  
}

- (void)viewDidUnload {
    [self setSentdisplay:nil];
    [super viewDidUnload];
}
@end
