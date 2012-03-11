//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Harjeet Taggar on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)value;
-(void)pushVariable:(NSString *)variable;
-(double)doCalculation:(NSString *)calculation;
-(NSString *)descript;

@property (readonly) id program;

+ (double)runProgram:(id)program
 usingVariableValues:(NSDictionary *)variableValues;


+ (NSString *)descriptionOfProgram:(id)program;
+ (NSString *)descriptionOfTopOfStack:(NSMutableArray *)stack;
@end
