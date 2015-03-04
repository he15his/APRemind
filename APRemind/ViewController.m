//
//  ViewController.m
//  APRemind
//
//  Created by he15his on 15/3/4.
//  Copyright (c) 2015年 he15his. All rights reserved.
//

#import "ViewController.h"
#import "APRemindView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.label.text = [NSString stringWithFormat:@"离顶部距离%.f", self.slider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sliderValueChanged:(UISlider *)sender {
    
    self.label.text = [NSString stringWithFormat:@"离顶部距离%.f", sender.value];
}

- (IBAction)sucessRemindAction:(id)sender {
    
    [APRemindView showSuccessWithStatus:@"成功提醒" ySpace:self.slider.value];
}

- (IBAction)faileRemindAction:(id)sender {
    
    [APRemindView showErrorWithStatus:@"失败提醒" ySpace:self.slider.value];
}
@end
