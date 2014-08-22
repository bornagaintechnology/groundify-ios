//
//  SubmitVC.m
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "SubmitVC.h"
#import "SignUpViewController.h"
#import "MainHomeVC.h"

@interface SubmitVC ()

@end

@implementation SubmitVC

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
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Thank You";
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
    [prefs setObject:userid forKey:@"user_id"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CUSTOM

-(void)backBtnClick
{
    //write your code to prepare popview
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - IBAction

- (IBAction)settingbtnaction:(id)sender {
    MainHomeVC *main=nil;
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        main=[[MainHomeVC alloc]initWithNibName:@"MainHomeVC_5" bundle:nil];
    }
    else
    {
        main=[[SubmitVC alloc]initWithNibName:@"MainHomeVC" bundle:nil];
        
    }
     [self.navigationController pushViewController:main animated:YES];
}

@end
