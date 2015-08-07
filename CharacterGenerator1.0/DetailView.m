//
//  DetailView.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "DetailView.h"
#import <AVFoundation/AVFoundation.h>
#import "GameCharacter.h"


@interface DetailView ()

{
    AVAudioPlayer *_audioPlayer; // added for sounds
    AVAudioPlayer *_audioPlayer2;
}
@property (weak, nonatomic) IBOutlet UILabel *SavedCharacterLabel;

@property (weak, nonatomic) IBOutlet UIButton *randomBox;

@property (weak, nonatomic) IBOutlet UIButton *coolGoBackButton;

@end

@implementation DetailView

- (void)viewDidLoad {
    self.SavedCharacterLabel.text = [NSString stringWithFormat:@"%@, you must %@ and %@", self.character.characterName, self.character.locationName, self.character.mission];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/coin.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    

    // added for random item sound
    NSString *path2 = [NSString stringWithFormat:@"%@/item.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    _audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    
    
    //if character doesn't have a random object yet, then the question box will appear animated
    if(!self.character.randomItemDecided){
        [self.randomBox setBackgroundImage:[UIImage animatedImageNamed:@"questionBox" duration:.7] forState:UIControlStateNormal];
    }
    
    //otherwise if the character has an object just display the object
    else{
        self.randomBox.enabled = NO;
        [self.randomBox setBackgroundImage:self.character.randomItem forState:UIControlStateDisabled];
    }

    
    self.coolGoBackButton.layer.cornerRadius = 10.0; // rounds corners
    self.coolGoBackButton.layer.borderWidth = 3.0; // border width
    self.coolGoBackButton.layer.borderColor = [[UIColor blackColor]CGColor]; // set border color

}
- (IBAction)goBack:(UIButton *)sender {
    [_audioPlayer play]; // added for sounds

    //Use this method to dismiss the viewcontroller programmatically, no segue needed
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

//if the random box button is enabled this will allow user to generate an object
- (IBAction)randomBoxSelected:(UIButton *)sender {
    [_audioPlayer2 play];
    [self.character generateRandomObject]; //generate
    self.randomBox.enabled = NO; //disable button
    
    //set image
    [self.randomBox setBackgroundImage:self.character.randomItem forState:UIControlStateDisabled];
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
