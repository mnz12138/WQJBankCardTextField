//
//  WQJBankCardTextField.h
//  WQJBankCardTextField
//
//  Created by 王全金 on 2017/11/29.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WQJBankCardTextField : UITextField <UITextFieldDelegate>

/*输入的最大长度 默认是20*/
@property (nonatomic, assign) NSInteger maxLength;
/*空格间隔字符 默认是4*/
@property (nonatomic, assign) NSInteger whiteSpace;

@end

@interface NSString (BankCardTextFieldExtension)

+ (BOOL)isPureIntStr:(NSString*)string;
- (NSString *)stringByConvertingNormalNumToBankNumWithWhiteSpace:(NSInteger)whiteSpace;
- (NSString *)stringByConvertingBankNumToNormalNum;

@end
