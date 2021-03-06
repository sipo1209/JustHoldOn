//
//  JHOCustomizeHabitViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-12-21.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOCustomizeHabitViewController.h"
#import "JHOFilterControl.h"
#import "JHOPrivacySegmentedView.h"

@interface JHOCustomizeHabitViewController ()
{
    JHOFilterControl *control;
    JHOPrivacySegmentedView *segmentedView;
}
@end

@implementation JHOCustomizeHabitViewController
@synthesize habitNameLabel;
@synthesize baseScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"习惯定制";
        
        UIButton* backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 26)];
        [backButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleEdgeInsets:UIEdgeInsetsMake(1.0, 4, 0, 0.0)];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        //    [backButton setTitle:@"返回" forState:UIControlStateNormal];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
        [backButton release];
        [backItem release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    control = [[JHOFilterControl alloc] initWithFrame:CGRectMake(10, 146, 300, 38) titles:[NSArray arrayWithObjects:@"1天", @"2天", @"3天", @"4天", @"5天", @"6天", @"7天", nil]];
    [self.baseScrollView addSubview:control];
    [control release];
    
    segmentedView = [[JHOPrivacySegmentedView alloc] initWithFrame:CGRectMake(10, 309, 300, 27) titles:[NSArray arrayWithObjects:@"所有人", @"仅好友", @"仅自己", nil]];
    [self.baseScrollView addSubview:segmentedView];
    [segmentedView release];
    
    self.baseScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"签到流bg"]];
    self.baseScrollView.contentSize = CGSizeMake(320, 610);
    
    networkHelper.networkDelegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    habitNameLabel.text = _habitModel.habitName;
}

- (void)viewDidUnload
{
    [self setBaseScrollView:nil];
    [self setHabitNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [baseScrollView release];
    [habitNameLabel release];
    [super dealloc];
}

- (void)updateHabitModelWithHabit:(JHOHabitModel *)model
{
    _habitModel = model;
}

- (IBAction)customCompletePressed:(UIButton *)sender {
    NSMutableDictionary *_dic = [NSMutableDictionary dictionary];
    [_dic setObject:_habitModel.habitID forKey:@"habitid"]
    ;
    [_dic setValue:[NSNumber numberWithInt:(control.selectedIndex+1)] forKey:@"fre"];
    [_dic setValue:[NSNumber numberWithInt:(segmentedView.selectedIndex)] forKey:@"privacy"];
    [networkHelper addHabit:_dic];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NetworkTaskDelegate
- (void)task:(NetworkRequestOperation)tag didSuccess:(NSDictionary *)result
{

}
@end
