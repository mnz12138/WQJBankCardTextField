//
//  WQJBankCardTextField.m
//  WQJBankCardTextField
//
//  Created by 王全金 on 2017/11/29.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "WQJBankCardTextField.h"

@interface WQJBankCardTextField () {
    BOOL _isAdd;
}

@end

@implementation WQJBankCardTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.maxLength = 20;
    self.whiteSpace = 4;
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setText:(NSString *)text {
    [super setText:[text stringByConvertingNormalNumToBankNumWithWhiteSpace:self.whiteSpace]];
}

- (NSString *)text {
    return [[super text] stringByConvertingBankNumToNormalNum];
}

- (void)textFieldDidChange:(NSNotification *)notification {
    UITextField *bankCardTextField = notification.object;
    if (bankCardTextField.text.length==0) {
        return;
    }
    UITextRange *range = bankCardTextField.selectedTextRange;
    NSInteger curOffset = [self curOffset];
    if (bankCardTextField.text.length >= self.maxLength) {
        bankCardTextField.text = [bankCardTextField.text substringWithRange:NSMakeRange(0, self.maxLength)];
        NSString *text = [bankCardTextField.text stringByConvertingNormalNumToBankNumWithWhiteSpace:self.whiteSpace];
        if (curOffset<(self.maxLength+self.whiteSpace)) {
            [self adjustTextFieldselectedTextRange:range curOffset:curOffset text:text];
        }
        return;
    }
    NSString *text = [bankCardTextField.text stringByConvertingNormalNumToBankNumWithWhiteSpace:self.whiteSpace];
    bankCardTextField.text = text;
    [self adjustTextFieldselectedTextRange:range curOffset:curOffset text:text];
}

- (void)adjustTextFieldselectedTextRange:(UITextRange *)range curOffset:(NSInteger)curOffset text:(NSString *)text {
    if (_isAdd) {
        NSString *blankStr = [text substringWithRange:NSMakeRange((curOffset-1), 1)];
        if ([blankStr isEqualToString:@" "]) {
            [self setSelectedRange:NSMakeRange(curOffset+1, 0)];
        }else{
            self.selectedTextRange = range;
        }
    }else{
        if (curOffset%(self.whiteSpace+1)==0) {
            [self setSelectedRange:NSMakeRange(curOffset-1, 0)];
        }else{
            self.selectedTextRange = range;
        }
    }
}

- (NSInteger)curOffset{
    // 基于文首计算出到光标的偏移数值。
    return [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
}

- (void)setSelectedRange:(NSRange)range {  // 备注：UITextField必须为第一响应者才有效
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (string.length>0&&[NSString isPureIntStr:string]==NO) {
        return NO;
    }
    _isAdd = string.length>0;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    _isAdd = NO;
}

@end

@implementation NSString (BankCardTextFieldExtension)

+ (BOOL)isPureIntStr:(NSString*)string {
    if (string.length==0) {
        return YES;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

// 正常号转银行卡号 － 增加4位间的空格
- (NSString *)stringByConvertingNormalNumToBankNumWithWhiteSpace:(NSInteger)whiteSpace {
    NSString *tmpStr = [self stringByConvertingBankNumToNormalNum];
    
    NSInteger size = (tmpStr.length / whiteSpace);
    
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    
    NSInteger lastCharactersLength = tmpStr.length % whiteSpace;
    if (lastCharactersLength) {
        [tmpStrArr addObject:[tmpStr substringWithRange:NSMakeRange(size*whiteSpace, lastCharactersLength)]];
    }
    
    tmpStr = [tmpStrArr componentsJoinedByString:@" "];
    
    return tmpStr;
}

// 银行卡号转正常号 － 去除4位间的空格
- (NSString *)stringByConvertingBankNumToNormalNum {
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

