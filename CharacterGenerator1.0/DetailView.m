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
}
@property (weak, nonatomic) IBOutlet UILabel *SavedCharacterLabel;

@property (weak, nonatomic) IBOutlet UIButton *randomBox;


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
    

}
- (IBAction)goBack:(UIButton *)sender {
    [_audioPlayer play]; // added for sounds
    [self dismissViewControllerAnimated:YES completion:nil];
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
