//
//  CalculatorBrain.m
//  CalculatorRPNtry2
//
//  Created by Riyad Shauk on 6/20/13.
//  Copyright (c) 2013 Riyad Shauk. All rights reserved.
//

#import "CalculatorRPNtry2ViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *programStack;
@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;

- (NSMutableArray *)programStack;
{
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}

// /* not needed, so @synthesize will work
-(void)setOperandStack:(NSMutableArray *)programStack
{
    _programStack = programStack;
}
// */

-(void)pushOperand:(double)operand
{
    [self.programStack addObject:[NSNumber numberWithDouble:operand]]; 
}

-(double)performOperation:(NSString *)operation
{
    [self.programStack addObject:operation];
    return [CalculatorBrain runProgram:self.program];
}

- (id)program // instead of @synthesize... Here is getter
{
    return [self.programStack copy]; // copy returns an immutable array so somebody couldn't use introspection to go in and edit the actual self.programStack
}

+ (NSString *)descriptionOfProgram:(id)program
{
    return @"A programmable calculator. Implement better desc in Assignment 2";
}

+ (double)popOperandOffStack:(NSMutableArray *)stack
{
    double result = 0;
    
    id topOfStack = [stack lastObject]; // have to use introspection to find out if this is an NSNumber w PopOperand or NSString w PerformOperation
    if (topOfStack) [stack removeLastObject];
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) {
        result = [topOfStack doubleValue];
    } else if ([topOfStack isKindOfClass:[NSString class]]) {
        NSString *operation = topOfStack;
        // calculate result;
        if ([operation isEqualToString:@"+"]) {
            result = [self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"*" isEqualToString:operation]) {
            result = [self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"-" isEqualToString:operation]) {
            result =  -[self popOperandOffStack:stack] + [self popOperandOffStack:stack];
        } else if ([@"/" isEqualToString:operation]) {
            result = 1/[self popOperandOffStack:stack] * [self popOperandOffStack:stack];
        } else if ([@"π" isEqualToString:operation]) {
            result = 3.14159265359;
        } else if ([@"√" isEqualToString:operation]) {
            result = sqrt([self popOperandOffStack:stack]);
        } else if ([@"cos" isEqualToString:operation]) {
            result = cos([self popOperandOffStack:stack]);
        } else if ([@"sin" isEqualToString:operation]) {
            result = sin([self popOperandOffStack:stack]);
        }
    }
    
    return result;
}

+ (double)runProgram:(id)program // runProgram using variable values / w a Dictionary (runProgram will take a Dictionary now... some stuff with NSSet...)
{
    NSMutableArray *stack; // already set to nil when initialized auto
    if ([program isKindOfClass:[NSArray class]]) {
        stack = [program mutableCopy]; // it's ok to assign an id to a static type...
    }
    return [self popOperandOffStack:stack];
}

@end
