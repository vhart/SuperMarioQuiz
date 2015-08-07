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
    AVAudioPlayer *_audioPlayer; // added for sounds
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
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/coin.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    self.coolBackButton.layer.cornerRadius = 10.0; // rounds corners
    self.coolBackButton.layer.borderWidth = 3.0; // border width
    self.coolBackButton.layer.borderColor = [[UIColor blackColor]CGColor]; // set border color
}
- (IBAction)goBack:(UIButton *)sender {
    [_audioPlayer play]; // added for sounds
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)randomBoxSelected:(UIButton *)sender {
    
    [self.characterToDisplay generateRandomObject];
    
    self.randomBoxButton.enabled = NO;
    
    [self.randomBoxButton setBackgroundImage:self.characterToDisplay.randomItem forState:UIControlStateDisabled];
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
