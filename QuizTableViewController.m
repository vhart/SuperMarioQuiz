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


@interface QuizTableViewController ()

{
    AVAudioPlayer *_audioPlayer; // for jump sound
    AVAudioPlayer *_audioPlayer2; // for coin sound
}

@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *questionOneButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *questionTwoButtons;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *questionThreeButtons;

@property (nonatomic, weak) IBOutlet UIButton *tellMeButton; // for button customization

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
    
    self.tellMeButton.layer.cornerRadius = 10.0; // rounds button corners
    self.tellMeButton.layer.borderWidth = 3.0; // border width
    self.tellMeButton.layer.borderColor = [[UIColor blackColor]CGColor]; // set border color
    
}

- (IBAction)questionAnswered:(UIButton *)sender{
    BOOL found = NO;
    for (UIButton *button in self.questionOneButtons) {
        if (sender == button) {
            found = YES;
            [self enableButtonsDisableButton:button fromArray:self.questionOneButtons];
            
            self.food = [[button.currentTitle substringFromIndex:3]lowercaseString];
            return;
        }
    }
    
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
- (IBAction)tellMeButton:(id)sender { // added outlet method
     [_audioPlayer2 play]; // plays coin sound when pressed
}


#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameCharacter *character = [[GameCharacter alloc] initWithFood:self.food hobby:self.location goal:self.goal andGamerTag:self.gamerTag.text];
    
    [[CharacterModel sharedModel].characterData addObject:character];
    
    DetailViewForQuizSeg *view = [segue destinationViewController];
    
    view.characterToDisplay = character;
   
}


@end
