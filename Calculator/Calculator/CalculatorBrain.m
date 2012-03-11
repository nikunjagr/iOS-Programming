//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Harjeet Taggar on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@property (nonatomic, strong) NSMutableDictionary *variableValues;
@end

@implementation CalculatorBrain
@synthesize programStack = _programStack;
@synthesize variableValues = _variableValues;


-(NSMutableArray *) programStack
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

-(NSMutableDictionary *) variableValues
{
    _variableValues = [[NSMutableDictionary alloc] init];
    [_variableValues setObject:[NSNumber numberWithDouble:5] forKey: @"~x"];
    [_variableValues setObject:[NSNumber numberWithDouble:10] forKey:@"~y"];
    [_variableValues setObject:[NSNumber numberWithDouble:25] forKey:@"~foo"];
    
    return _variableValues;
}

-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]];

}

-(void)pushVariable:(NSString *)variable
{
    NSString *var = [@"~" stringByAppendingString:variable];
    [self.programStack addObject:var];
    NSLog(@":stack - %@", self.programStack);
}

-(double)doCalculation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program
                   usingVariableValues:self.variableValues];
}

-(NSString *)descript
{
    return [CalculatorBrain descriptionOfProgram:self.program];
}

-(id)program
{
    return [self.programStack copy];
}

+ (NSString *)descriptionOfProgram:(id)program
{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
    return [self descriptionOfTopOfStack:stack];
}

+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack
{
    NSSet *operations = [NSSet setWithObjects:@"+", @"-", @"/", @"*", nil];
    NSMutableString *description = [[NSMutableString alloc] init];
    NSString *expression = [[NSString alloc] init];
 
    id topOfStack = [stack lastObject]; 
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        return [topOfStack stringValue];
        NSLog(@"value: %@", expression);
    } 
    
    else if ([operations containsObject:topOfStack]) {
        NSLog(@"descript now: %@", description);
        [description appendString:[self descriptionOfTopOfStack:stack]];
        [description insertString:topOfStack atIndex:0];
        [description insertString:[self descriptionOfTopOfStack:stack] atIndex:0];
        NSLog(@"description: %@", description);
    }
    
    return description;
}


+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    }
    else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"/" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] / [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] - [self popOperandOffStack:stack];
        }
    }
    return result;
}

+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues;

{
    NSMutableArray *stack;
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy];
    }
        
    for (id __strong obj in program) {
        if ([obj isKindOfClass:[NSString class]] && [obj hasPrefix:@"~"]) {
            [stack addObject:[variableValues valueForKey:obj]];
        } else {
            [stack addObject:obj];
        }
    }
    
    NSLog(@"the program stack is %@", stack);
    return [self popOperandOffStack:stack];
}

@end
