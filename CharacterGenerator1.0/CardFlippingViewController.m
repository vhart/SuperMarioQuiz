//
//  CardFlippingViewController.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/14/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "CardFlippingViewController.h"

@interface CardFlippingViewController ()
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *buttonsArray;
@property (nonatomic) NSMutableArray *arrayOfCards;
@property (nonatomic) NSInteger counter;
@end

@implementation CardFlippingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.counter = 0;
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)timerFired:(NSTimer *)timer{
    int c = 0;
    
    for(UIButton *b in self.buttonsArray){
        if (c%2==self.counter) {
            [self buttonsAnimationSet:b];
        }
        else{
            [self buttonsAnimationDismiss:b];
        }
        c++;
    }
    
    if(self.counter == 2){
        [timer invalidate];
    }
    self.counter++;
    
}
-(void) buttonsAnimationSet:(UIButton *)button{
    [button setBackgroundImage:[UIImage animatedImageNamed:@"questionBox" duration:.5] forState:UIControlStateNormal];
}

- (void) buttonsAnimationDismiss:(UIButton *)button{
    [button setBackgroundImage:[UIImage imageNamed:@"questionBox1"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
