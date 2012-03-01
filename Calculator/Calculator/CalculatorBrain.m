//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Harjeet Taggar on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

-(NSMutableArray *) operandStack
{
    if (_operandStack == nil) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

-(void)pushOperand:(double)operand
{
    [self.operandStack addObject:[NSNumber numberWithDouble:operand]];
    
}

-(double)performOperation:(NSString *)operation
{
    double result = 0;
    return result;   
}

@end
