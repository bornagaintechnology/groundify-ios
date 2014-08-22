//
//  ViewConsequencesVC.m
//  iGround
//
//  Created by Mohit on 21/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "ViewConsequencesVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SigninVC.h"
#import "MainHomeVC.h"
#import "SubmitVC.h"
#import "UIImageView+WebCache.h"

@interface ViewConsequencesVC ()

@end

@implementation ViewConsequencesVC
@synthesize  viewconTV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Consequences";
    
   
        
    
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
        NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=getConsequence&userid=%@",userid];
        NSLog(@"%@",urlString);
        NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSURLConnection *Connection=[[NSURLConnection alloc]initWithRequest:Request delegate:self];
        
 
    
  
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableview delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [consequence count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    for(UIView *vw in cell.contentView.subviews)
    {
        [vw removeFromSuperview];
    }
   
    
    NSArray *reversedchildname= [[childname reverseObjectEnumerator] allObjects];
    UILabel *label1=[[UILabel alloc]initWithFrame :CGRectMake(80,5,80, 40)];
    label1.text=[reversedchildname  objectAtIndex: [indexPath row]];
    label1.tag = 1001;
    [cell.contentView addSubview:label1];
    
    NSArray *reversedcontime= [[contime reverseObjectEnumerator] allObjects];
    UILabel *label3=[[UILabel alloc]initWithFrame :CGRectMake(160,5, 150, 40)];
    label3.text=[reversedcontime  objectAtIndex: [indexPath row]];
    label3.tag = 1003;
    [cell.contentView addSubview:label3];
    
     NSArray *reversedconsequence= [[consequence reverseObjectEnumerator] allObjects];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(80,40, 150, 40)];
    label2.text=[reversedconsequence  objectAtIndex: [indexPath row]];
    label2.tag = 1002;
    [cell.contentView addSubview:label2];
    
    NSArray *reversedimages= [[consequenceimages reverseObjectEnumerator] allObjects];
     UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20,15, 50, 50)];
     NSString *conitems1 = [[NSString alloc] init];
     conitems1 = [reversedconsequence objectAtIndex:indexPath.row];
    
    NSURL *url=[NSURL URLWithString:   [NSString stringWithFormat:@"%@",[reversedimages objectAtIndex:indexPath.row]]];

    [imgView setImageWithURL:url success:^(UIImage *image)
     {
         imgView.image=image;
         [cell.contentView addSubview:imgView];
         
     }
        failure:^(NSError *error) {
                         
    }];
    
    
    if ([conitems1 isEqualToString:@"Bed time"]) {
        imgView.image = [UIImage imageNamed:@"img-1.png"];
        [cell.contentView addSubview:imgView];
    }else if([conitems1 isEqualToString: @"Play time"]){
        imgView.image = [UIImage imageNamed:@"img-2.png"];
        [cell.contentView addSubview:imgView];
    }else if([conitems1 isEqualToString: @"Phone"]){
        imgView.image = [UIImage imageNamed:@"img-3.png"];
        [cell.contentView addSubview:imgView];
    }else if([conitems1 isEqualToString: @"Tv time"]){
        imgView.image = [UIImage imageNamed:@"img-4.png"];
        [cell.contentView addSubview:imgView];
    }else if([conitems1 isEqualToString: @"Music time"]){
        imgView.image = [UIImage imageNamed:@"img-5.png"];
        [cell.contentView addSubview:imgView];
    }else{
       
    }
   
    return cell;
}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath{
    return 73;
}

#pragma mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
   
    _responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
   
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
   
    NSData* responseData = [[NSData alloc] initWithData:_responseData];
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"responseStr %@",responseStr);
    
    
    if ([responseData length]>0){
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
        NSLog(@"responseDict %@",responseDict);
        NSLog(@"data= %@",[responseDict objectForKey:@"data"]  );
        NSArray *items = [responseDict valueForKeyPath:@"data"];
        
        
        consequence = [items valueForKey:@"consequence"];
        contime = [items valueForKey:@"con_datetime"];
        childname = [items valueForKey:@"child_name"];
        consequenceimages = [items valueForKey:@"image"];

        [SVProgressHUD dismiss];
        [viewconTV reloadData];
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
   
}
#pragma mark - CUSTOM

-(void)backBtnClick
{

    [self.navigationController popViewControllerAnimated:YES];
}

@end

