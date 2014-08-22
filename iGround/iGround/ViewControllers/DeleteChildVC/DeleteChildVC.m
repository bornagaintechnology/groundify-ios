//
//  DeleteChildVC.m
//  iGround
//
//  Created by Mohit on 21/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "DeleteChildVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SigninVC.h"
#import "HomeViewController.h"
#import "SubmitVC.h"

@interface DeleteChildVC ()

@end

@implementation DeleteChildVC
@synthesize childtableVU , myConnection ,mySecondConnection;
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
    //userid
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
    
    NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=selectChild&userid=%@",userid];
    NSLog(@"%@",urlString);
    NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    self.myConnection=[[NSURLConnection alloc] initWithRequest:Request delegate:self startImmediately:YES];
    
   
    
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
    self.navigationItem.title = @"Delete Child";
    [self callWebservice];
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
    return [child count];
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
    NSArray *reversedArray = [[child reverseObjectEnumerator] allObjects];
    cell.textLabel.text = [reversedArray  objectAtIndex: [indexPath row]];
   
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"child id array is %@ ",childid);
    NSLog(@"delete is %@ ",[childid objectAtIndex:indexPath.row]);
    NSArray *reversedchild_id = [[childid reverseObjectEnumerator] allObjects];
    NSString *child_id = [reversedchild_id objectAtIndex:indexPath.row];
    
    NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=deleteChild&userid=%@&childid=%@",userid , child_id];
    NSLog(@"%@",urlString);
    NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
   mySecondConnection=[[NSURLConnection alloc]initWithRequest:Request delegate:self ];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];


}
- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath{
    return 50;
}


# pragma mark - Custom

-(void)callWebservice{
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=selectChild&userid=%@",userid];
    NSLog(@"%@",urlString);
    NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    self.myConnection=[[NSURLConnection alloc]initWithRequest:Request delegate:self ];
}

-(void)callalert:(NSString *) message {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(void)backBtnClick
{
    //write your code to prepare popview
    [self.navigationController popViewControllerAnimated:YES];
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
   
    if (connection == myConnection){
        [SVProgressHUD dismiss];
        NSData* responseData = [[NSData alloc] initWithData:_responseData];
        NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        NSLog(@"responseStr %@",responseStr);
        
        if ([responseData length]>0){
            
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
            NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
            NSLog(@"responseDict %@",responseDict);
            
            NSLog(@"data= %@",[responseDict objectForKey:@"data"] );
            
            NSArray *items = [responseDict valueForKeyPath:@"data"];
            
            
            child = [items valueForKey:@"child_fname"];
            childid = [items valueForKey:@"childid"];
            

            [childtableVU reloadData];
            
        }
    }else if (connection == mySecondConnection){
        
        NSData* responseData = [[NSData alloc] initWithData:_responseData];
        NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        NSLog(@"responseStr %@",responseStr);
        
        if ([responseData length]>0){
            
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
            NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
            NSLog(@"responseDict %@",responseDict);
            
            NSLog(@"data= %@",[responseDict objectForKey:@"data"] );
            NSString *returndata = [responseDict objectForKey:@"result"];
            if ([returndata isEqualToString:@"success"]) {
                
                [SVProgressHUD dismiss];
                [self callWebservice];
                [self callalert:@"Child Deleted Successfully"];
      
            }else {
                
                [SVProgressHUD dismiss];
                [self callWebservice];
                [self callalert:@"There is some problem.please try later"];
            }
        }
    }
    
}
    


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}


@end
