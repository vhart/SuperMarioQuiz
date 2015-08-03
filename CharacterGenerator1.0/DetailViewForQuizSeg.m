//
//  DetailViewForQuizSeg.m
//  CharacterGenerator1.0
//
//  Created by Varindra Hart on 8/2/15.
//  Copyright (c) 2015 Varindra Hart. All rights reserved.
//

#import "DetailViewForQuizSeg.h"
#import "GameCharacter.h"

@interface DetailViewForQuizSeg ()
@property (weak, nonatomic) IBOutlet UILabel *labelDummy;

@end

@implementation DetailViewForQuizSeg

- (void)viewDidLoad {
    self.labelDummy.text = [NSString stringWithFormat:@"%@ in %@.\nMission: %@", self.characterToDisplay.characterName, self.characterToDisplay.locationName, self.characterToDisplay.mission];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)goBack:(UIButton *)sender {
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
