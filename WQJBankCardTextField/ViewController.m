//
//  ViewController.m
//  WQJBankCardTextField
//
//  Created by 王全金 on 2017/11/29.
//  Copyright © 2017年 mnz. All rights reserved.
//

#import "ViewController.h"
#import "WQJBankCardTextField/WQJBankCardTextField.h"

@interface ViewController ()

@property (nonatomic, strong) WQJBankCardTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.textField = [[WQJBankCardTextField alloc] initWithFrame:CGRectMake(0, 100, 200, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@",self.textField.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
