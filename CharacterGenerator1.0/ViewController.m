//
//  ViewController.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "ViewController.h"
#import "CharacterModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CharacterModel sharedModel] doSomethingPlease];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
