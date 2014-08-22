//
//  MainHomeVC.m
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "MainHomeVC.h"
#import "AddChildVC.h"
#import "GroundVC.h"
#import "DeleteChildVC.h"
#import "ViewConsequencesVC.h"
#import "SubmitVC.h"

@interface MainHomeVC ()

@end

@implementation MainHomeVC

@synthesize m_addchildbtn, m_delchildbtn , tabledata ,m_maintableview;

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabledata = [[NSArray alloc] initWithObjects:@"Add Child", @"Delete Child",
                       @"Ground Child", @"View Consequences", nil];
     m_maintableview.layer.cornerRadius=3.5;
    [m_maintableview.layer setBorderColor:[UIColor lightGrayColor].CGColor]; 
    [m_maintableview.layer setBorderWidth:1.0f];
   // self.m_maintableview.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
   
   

}
-(void)viewWillAppear:(BOOL)animated
{
   // self.m_maintableview.contentInset = UIEdgeInsetsMake(-10, 0, 0, 0);
    [self.navigationController setNavigationBarHidden:NO];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Home";
}
- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBAction

- (IBAction)m_addChild:(id)sender {
   
}

- (IBAction)m_deleteChild:(id)sender {
    
}

- (IBAction)consequence:(id)sender {
}

- (IBAction)groundchild:(id)sender {
   
}

#pragma mark - Table View Data source 

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tabledata count];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.tabledata objectAtIndex: [indexPath row]];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
 
    return cell;
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath{
    return 50;
}


#pragma mark - TableView delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            NSLog(@"Section:%d Row:%d selected and its data is %@",
                  indexPath.section,indexPath.row,cell.textLabel.text);
        {
            AddChildVC *addOB = nil;//[[AddChildVC alloc]initWithNibName:@"AddChildVC" bundle:nil];
            
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                addOB=[[AddChildVC alloc]initWithNibName:@"AddChildVC_5" bundle:nil];
            }
            else
            {
                addOB=[[AddChildVC alloc]initWithNibName:@"AddChildVC" bundle:nil];
                
            }
            
            [self.navigationController pushViewController:addOB animated:YES];
        }
            break;
        case 1:
        {
            DeleteChildVC *delOB= nil;
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                delOB=[[DeleteChildVC alloc]initWithNibName:@"DeleteChildVC_5" bundle:nil];
            }
            else
            {
                delOB=[[DeleteChildVC alloc]initWithNibName:@"DeleteChildVC" bundle:nil];
                
            }
            
            [self.navigationController pushViewController:delOB animated:YES];
        }
            break;
        case 2:
        {
            GroundVC *grdOB= nil; //[[GroundVC alloc] initWithNibName:@"GroundVC" bundle:nil];
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                grdOB=[[GroundVC alloc]initWithNibName:@"GroundVC_5" bundle:nil];
            }
            else
            {
                grdOB=[[GroundVC alloc]initWithNibName:@"GroundVC" bundle:nil];
                
            }
            
            [self.navigationController pushViewController:grdOB animated:YES];
        }
            break;
        case 3:
        {
            ViewConsequencesVC *vcOB= nil;
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                vcOB=[[ViewConsequencesVC alloc]initWithNibName:@"ViewConsequencesVC_5" bundle:nil];
            }
            else
            {
                vcOB=[[ViewConsequencesVC alloc]initWithNibName:@"ViewConsequencesVC" bundle:nil];
                
            }
            
            [self.navigationController pushViewController:vcOB animated:YES];
        }
            break;
            
        default:
            
            break;
    }
}
#pragma  mark - CUSTOM

-(void)backBtnClick
{
    //write your code to prepare popview
    [self.navigationController popViewControllerAnimated:YES];
}
@end
