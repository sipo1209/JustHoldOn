//
//  JHOHabitsListViewController.m
//  JustHoldOn
//
//  Created by Heartunderblade on 12-11-23.
//  Copyright (c) 2012年 Heartunderblade. All rights reserved.
//

#import "JHOHabitsListViewController.h"
#import "JHOHabitListTableViewCell.h"
#import "JHOCustomizeHabitViewController.h"

@interface JHOHabitsListViewController ()

@end

@implementation JHOHabitsListViewController

#pragma mark - singleton default
@synthesize habitsListTableView = _habitsListTableView;
static JHOHabitsListViewController *sharedHabitsListViewController = nil;

+ (JHOHabitsListViewController *)shared
{
    if(sharedHabitsListViewController == nil)
    {
        sharedHabitsListViewController = [[JHOHabitsListViewController alloc] initWithNibName:@"JHOHabitsListViewController" bundle:nil];
    }
    return sharedHabitsListViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.items = [NSArray arrayWithObjects:@"Headlines", @"UK", @"International", @"Politics", @"Weather", @"Travel", @"Radio", @"Hollywood", @"Sports", @"Others", nil];
    [self.horizMenu reloadData];
    [self.horizMenu setSelectedIndex:0 animated:NO];
    [super viewDidLoad];
}

-(void) viewDidAppear:(BOOL)animated
{
}

- (void)viewDidUnload
{
    [self setHabitsListTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
{
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    return [self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    self.selectionItemLabel.text = [self.items objectAtIndex:index];
    [_habitsListTableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JHOCustomizeHabitViewController *cusHabit = [[JHOCustomizeHabitViewController alloc] initWithNibName:@"JHOCustomizeHabitViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cusHabit];
    [cusHabit release];
    [self presentModalViewController:nav animated:YES];
    [nav release];
}

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SystemHabitsCell";
        
    //    JHOHabitListTableViewCell *cell;
    JHOHabitListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[JHOHabitListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryView = nil;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@:每天八杯水", self.selectionItemLabel.text];
    cell.detailTextLabel.text = @"标签1;标签2;";
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"habittype%d", indexPath.row%4]]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}


- (void)dealloc {
    [_habitsListTableView release];
    [super dealloc];
}
@end
