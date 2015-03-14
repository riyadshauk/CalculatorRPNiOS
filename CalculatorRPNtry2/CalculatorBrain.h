//
//  CalculatorBrain.h
//  CalculatorRPNtry2
//
//  Created by Riyad Shauk on 6/20/13.
//  Copyright (c) 2013 Riyad Shauk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)setOperandStack:(NSMutableArray *)operandStack; // <-- my insertion to include implementation for clearDisplayC method.

@property (readonly) id program;

+ (double)runProgram:(id)program; // a class method
+ (NSString *)descriptionOfProgram:(id)program; // a class method

@end
