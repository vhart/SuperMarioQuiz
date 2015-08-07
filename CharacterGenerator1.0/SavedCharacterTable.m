//
//  SavedCharacterTable.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart 👸, Shena Yoshida 🍄 and Bereket Ghebremedhin 🐸. All rights reserved.
//

#import "SavedCharacterTable.h"
#import "CharacterModel.h"
#import "GameCharacter.h"
#import "DetailView.h"
#import <AVFoundation/AVFoundation.h> // for sounds!!


@interface SavedCharacterTable ()
@property (nonatomic) AVAudioPlayer *player;

@end

@implementation SavedCharacterTable

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Instructions!" message:@"Welcome! To get started go ahead and press the '+' button in the upper right hand corner!" delegate:self cancelButtonTitle:@"Got it!" otherButtonTitles: nil];
    
    //path to mp3 as per Shena's example in the quizcontroller
    NSString *path = [NSString stringWithFormat:@"%@/oneup.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    //initialize player with mp3
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    [alert show];
    
    // adding animated header:
    animatedHeader.animationImages = [NSArray arrayWithObjects:
                                      [UIImage imageNamed:@"header01.png"],
                                      [UIImage imageNamed:@"header02.png"],
                                      [UIImage imageNamed:@"header03.png"],
                                      [UIImage imageNamed:@"header04.png"], nil];
  
    [animatedHeader setAnimationRepeatCount:0]; // 0 = it will run forever!!
    animatedHeader.animationDuration = 1.0; // will switch images every 1 second
    [animatedHeader startAnimating]; // start animation!
    
    
    
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [CharacterModel sharedModel].characterData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    GameCharacter *character = [[CharacterModel sharedModel].characterData objectAtIndex:indexPath.row];
    cell.textLabel.text = character.gamerTag;
    cell.textLabel.font = [UIFont fontWithName:@"emulogic" size:14];
    
    //if the character has a random object then set the image on the cell to that object
    if(character.randomItemDecided){
    cell.imageView.image = character.randomItem;
    }
    
    else{
        //otherwise it hasnt been set and should be a question mark box. 
        cell.imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"questionBox0"],[UIImage imageNamed:@"questionBox1"], nil];
        //load up images to be animated
        cell.imageView.animationDuration = .7;
        cell.imageView.animationRepeatCount = 0;//infite animation
        //begin animating
        [cell.imageView startAnimating];
    }
    
    //This code creates a fixed image frame
    CGSize itemSize = CGSizeMake(40, 40);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell.imageView.image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return cell;
}



- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //play sound when clicked
    [self.player play];
    
    GameCharacter *character = [CharacterModel sharedModel].characterData[indexPath.row];
    DetailView *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewFromTable"];
    nextView.character = character;
    [self.navigationController pushViewController:nextView animated:YES];
    
    
}


@end
