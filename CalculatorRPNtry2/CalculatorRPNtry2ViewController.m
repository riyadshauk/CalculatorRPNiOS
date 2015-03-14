//
//  CalculatorRPNtry2ViewController.m
//  CalculatorRPNtry2
//
//  Created by Riyad Shauk on 6/16/13.
//  Copyright (c) 2013 Riyad Shauk. All rights reserved.
//

#import "CalculatorRPNtry2ViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorRPNtry2ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL userTypedADecimal;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorRPNtry2ViewController
@synthesize display = _display;
@synthesize displayToBrain = _displayToBrain;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;
@synthesize userTypedADecimal = _userTypedADecimal;
@synthesize brain = _brain;

- (CalculatorBrain *)brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
    NSString *digit = sender.currentTitle; //[sender currentTitle];
    // NSRange decimal = [self.display.text rangeOfString:@"."];
    if ([sender.currentTitle isEqualToString:@"."]) {
        self.userTypedADecimal = YES;
    }
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
        self.displayToBrain.text = [self.displayToBrain.text stringByAppendingString:digit];
    }
    else {
        self.display.text = digit;
        self.displayToBrain.text = [self.displayToBrain.text stringByAppendingString:digit];
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
}

- (IBAction)deleteDigit // incomplete implementation, but EC anyways.
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
       // self.display.text = [self.display.text substringToIndex:[self.display.text]-1];
        //[self.brain setOperandStack:_operandStack];
        self.displayToBrain.text = [self.displayToBrain.text stringByAppendingString:@"<--"];
    }
}

- (IBAction)clearDisplayC
{
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.display.text = nil;
    self.displayToBrain.text = @""; // (<-- cannot use stringByAppendingString if this text is nil.)
    [self.brain setOperandStack:nil]; // <-- dereferences (I think that's the term?) operandStack, but is this necessary..? What could go wrong if "C"-button didn't clear the operandStack? idk the bookkeeping involved (seems tedious)...
}


- (IBAction)enterPressed
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO; 
}
- (IBAction)operationPressed:(UIButton *)sender
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        self.displayToBrain.text = [self.displayToBrain.text stringByAppendingString:sender.currentTitle];
        if (self.userTypedADecimal) {
            self.displayToBrain.text = [self.displayToBrain.text stringByAppendingString:@" "];
        }
        [self enterPressed];
    } else {
    self.displayToBrain.text = [self.displayToBrain.text stringByAppendingString:sender.currentTitle];
    }
    double result = [self.brain performOperation:sender.currentTitle];
    NSString *resultString = [NSString stringWithFormat:@"%g", result];
    self.display.text = resultString;
}
@end
