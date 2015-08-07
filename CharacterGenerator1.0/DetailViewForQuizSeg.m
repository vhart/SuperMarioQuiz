//
//  DetailViewForQuizSeg.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "DetailViewForQuizSeg.h"
#import "GameCharacter.h"
#import <AVFoundation/AVFoundation.h> // added for sounds


@interface DetailViewForQuizSeg ()

{
    AVAudioPlayer *_audioPlayer; // added for coin sounds
    AVAudioPlayer *_audioPlayer2; // added for random item sound
}

@property (weak, nonatomic) IBOutlet UILabel *labelDummy;
@property (weak, nonatomic) IBOutlet UIButton *coolBackButton; // button customization
@property (weak, nonatomic) IBOutlet UIButton *randomBoxButton;

@end

@implementation DetailViewForQuizSeg

- (void)viewDidLoad {
    self.labelDummy.text = [NSString stringWithFormat:@"%@, you must %@ and %@", self.characterToDisplay.characterName, self.characterToDisplay.locationName, self.characterToDisplay.mission];
    
    //if character doesn't have a random object yet, then the question box will appear animated
    if(!self.characterToDisplay.randomItemDecided){
        [self.randomBoxButton setBackgroundImage:[UIImage animatedImageNamed:@"questionBox" duration:.7] forState:UIControlStateNormal];
    }
    
    //otherwise if the character has an object just display the object
    else{
        [self.randomBoxButton setBackgroundImage:self.characterToDisplay.randomItem forState:UIControlStateNormal];
    }
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // added for coin sound
    NSString *path = [NSString stringWithFormat:@"%@/coin.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    // added for random item sound
    NSString *path2 = [NSString stringWithFormat:@"%@/item.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    _audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    
    self.coolBackButton.layer.cornerRadius = 10.0; // rounds corners
    self.coolBackButton.layer.borderWidth = 3.0; // border width
    self.coolBackButton.layer.borderColor = [[UIColor blackColor]CGColor]; // set border color
}
- (IBAction)goBack:(UIButton *)sender {
    [_audioPlayer play]; // added for coin sounds
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)randomBoxSelected:(UIButton *)sender {
    
    [self.characterToDisplay generateRandomObject];
    
    self.randomBoxButton.enabled = NO;
    
    [self.randomBoxButton setBackgroundImage:self.characterToDisplay.randomItem forState:UIControlStateDisabled];
    
    [_audioPlayer2 play]; // added for random item sound
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
