//
//  QuizTableViewController.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "QuizTableViewController.h"
#import "CharacterModel.h"
#import "DetailViewForQuizSeg.h"
#import <AVFoundation/AVFoundation.h> // this allows us to include sounds! 


@interface QuizTableViewController () <UITextFieldDelegate>

{
    AVAudioPlayer *_audioPlayer; // for jump sound
    AVAudioPlayer *_audioPlayer2; // for coin sound
    AVAudioPlayer *_audioPlayer3; //  for pause sound
}

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *questionOneButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *questionTwoButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *questionThreeButtons;

@property (nonatomic, weak) IBOutlet UIButton *tellMeButton; // for button

@property (nonatomic) NSString *food;
@property (nonatomic) NSString *location;
@property (nonatomic) NSString *goal;
@property (nonatomic) NSString *savedGameTag;
@property (weak, nonatomic) IBOutlet UITextField *gamerTag;

-(void) enableButtonsDisableButton:(UIButton *)button fromArray:(NSArray *)array;


@end

@implementation QuizTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Tap Gesture
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    //gamerTag textField set delegate
    self.gamerTag.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // this adds jump noises
    NSString *path = [NSString stringWithFormat:@"%@/jump.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    // Create audio player object and initialize with URL to sound
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    // this adds coin noises
    NSString *path2 = [NSString stringWithFormat:@"%@/coin.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl2 = [NSURL fileURLWithPath:path2];
    // Create audio player object and initialize with URL to sound
    _audioPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl2 error:nil];
    
    // this adds pause noises
    NSString *path3 = [NSString stringWithFormat:@"%@/pause.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl3 = [NSURL fileURLWithPath:path3];
    // Create audio player object and initialize with URL to sound
    _audioPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl3 error:nil];

    
    self.tellMeButton.layer.cornerRadius = 10.0; // rounds corners
    self.tellMeButton.layer.borderWidth = 3.0; // border width
    self.tellMeButton.layer.borderColor = [[UIColor blackColor]CGColor]; // set border color
}

//determines which button to record as answer
- (IBAction)questionAnswered:(UIButton *)sender{
    //found is NO until the button is found
    BOOL found = NO;
    for (UIButton *button in self.questionOneButtons) {
        if (sender == button) {
            found = YES;
            //When YES, send the array and button over to be disabled
            [self enableButtonsDisableButton:button fromArray:self.questionOneButtons];
            
            self.food = [[button.currentTitle substringFromIndex:3]lowercaseString];
            return;
        }
    }
    //repeat for question 2 if the button wasn't found
    if (found == NO) {
        for (UIButton *button in self.questionTwoButtons) {
            if (sender == button) {
                found = YES;
                [self enableButtonsDisableButton:button fromArray:self.questionTwoButtons];
                self.location = [[button.currentTitle substringFromIndex:3]lowercaseString];
                return;
            }
        }
        
    }
    //repeat for question 3 if button wasn't found
    if (found == NO) {
        for (UIButton *button in self.questionThreeButtons) {
            if (sender == button) {
                found = YES;
                [self enableButtonsDisableButton:button fromArray:self.questionThreeButtons];
                self.goal = [[button.currentTitle substringFromIndex:3]lowercaseString];
                return;
            }
        }
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) enableButtonsDisableButton:(UIButton *)button fromArray:(NSArray *)array{
    //Cycle through array to disable clicked button
    for (UIButton *arrayButtons in array) {
        [_audioPlayer play]; // added for jump sound
        
        if (arrayButtons == button) {
            arrayButtons.enabled = NO;
        }
        else {
            arrayButtons.enabled = YES;
        }
    }
}


-(BOOL)quizCompleted{
    //makes sure user completed the quiz entirely
    if ([self.gamerTag.text isEqualToString: @""] || self.location == nil || self.food==nil || self.goal==nil){
        return NO;
    }
    
    return YES;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

//Called before prepare for segue, determines if to segue or not
- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    //if quiz completed comes back as NO, segue is not called
    if (![self quizCompleted]){
        
        //if quiz incomplete play the pause sound
        [_audioPlayer3 play];
        
        //Presents an AlertView to alert user that a field is missing
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incomplete!" message:@"We'd love to show you the result but it seems you forgot to answer one or more of the questions" delegate:self cancelButtonTitle:@"Got It!" otherButtonTitles: nil];
        [alert show];
        return NO;
        
    }
    
    //if quiz IS complete play the coin sound
    [_audioPlayer2 play];
    
    return YES;
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        GameCharacter *character = [[GameCharacter alloc] initWithFood:self.food hobby:self.location goal:self.goal andGamerTag:self.gamerTag.text];
    
    [[CharacterModel sharedModel].characterData addObject:character];
    
    DetailViewForQuizSeg *view = [segue destinationViewController];
    
    view.characterToDisplay = character;
   
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//selector for UIGestureRecognizer
-(void)dismissKeyboard{
    [self.gamerTag resignFirstResponder];
}
@end
