//
//  ConsequenceVC.m
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "ConsequenceVC.h"
#import "GroundVC.h"
#import "customcell.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SigninVC.h"
#import "HomeViewController.h"
#import "AddConsequenceVC.h"
#import "SubmitVC.h"
#import "UIImageView+WebCache.h"

@interface ConsequenceVC ()

@end

@implementation ConsequenceVC

@synthesize m_setconbtn ,m_collectionview ,selectedItemIndexPath , myConnection , mySecondConnection;

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
    [self.m_collectionview reloadData];
    
    [self.navigationController setNavigationBarHidden:NO];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Consequences";
    
    [self addGradient:(m_setconbtn)];
   
    
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    currentdate = [prefs1 stringForKey:@"CURRENT_DATE"];
   
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    enddate = [prefs2 stringForKey:@"ENDDATE"];
   
    NSUserDefaults *prefs3 = [NSUserDefaults standardUserDefaults];
    selectedchild = [prefs3 stringForKey:@"CHILD"];
    
    NSUserDefaults *prefs5 = [NSUserDefaults standardUserDefaults];
    childid = [prefs5 stringForKey:@"CHILD_ID"];
    
    NSUserDefaults *prefs4 = [NSUserDefaults standardUserDefaults];
    consequence = [prefs4 stringForKey:@"NAME"];
    NSLog(@"consequence is %@", consequence);
    
    UICollectionViewFlowLayout *layout= [[UICollectionViewFlowLayout alloc]init];
    [m_collectionview setCollectionViewLayout:layout];
    [m_collectionview registerClass:[customcell class] forCellWithReuseIdentifier:@"test"];
    
    totalconsequences = [[NSMutableArray alloc]initWithObjects:@"img-1.png",
                         @"img-2.png",
                         @"img-3.png",
                         @"img-4.png",
                         @"img-5.png",
                         @"img-6.png", nil];
    NSLog(@"count is %d  and %@ ",totalconsequences.count,totalconsequences);
    
    NSString *url=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=getConsequenceImage&userid=%@",userid];
    NSLog(@"url is %@", url);
    
    NSString *properlyEscapedURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *connrequest=[NSURLRequest requestWithURL:[NSURL URLWithString:properlyEscapedURL]];
    myConnection =[[NSURLConnection alloc]initWithRequest:connrequest delegate:self];
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // userid
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction
- (IBAction)setConsequence:(id)sender{
    if(consequence.length == 0){
        
        [self callalert:@"Select any consequence"];
        
    } else {
        
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    NSString *url=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=setConsequence&userid=%@&child_name=%@&date_time=%@&con_datetime=%@&consequence=%@&image=%@&childid=%@",userid,selectedchild,currentdate,enddate,consequence,IMAGE,childid];
        NSString *properlyEscapedURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURLRequest *connrequest=[NSURLRequest requestWithURL:[NSURL URLWithString:properlyEscapedURL]];
      mySecondConnection=[[NSURLConnection alloc]initWithRequest:connrequest delegate:self];
    }
    
}

-(void)Add_ConseQuences:(NSString *)string
{
    IMAGE = string;
    // [self.m_collectionview reloadData];
   
}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return totalconsequences.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    
    NSMutableArray *indexPathsArray = [NSMutableArray arrayWithObject:indexPath];
    
    if (self.selectedItemIndexPath)
    {
        // if we had a previously selected cell
        
        if ([indexPath compare:self.selectedItemIndexPath] == NSOrderedSame)
        {
            // if it's the same as the one we just tapped on, then we're unselecting it
            
            self.selectedItemIndexPath = nil;
        }
        else
        {
            // if it's different, then add that old one to our list of cells to reload, and
            // save the currently selected indexPath
            
            [indexPathsArray addObject:self.selectedItemIndexPath];
            self.selectedItemIndexPath = indexPath;
        }
    }
    else
    {
        // else, we didn't have previously selected cell, so we only need to save this indexPath for future reference
        
        self.selectedItemIndexPath = indexPath;
       
    }
    [collectionView reloadItemsAtIndexPaths:indexPathsArray];

    if (indexPath.row==0){
      consequence = nil;
       consequence= @"Bed time";
        IMAGE =@"";
        
    }else if (indexPath.row==1){
        consequence = nil;
        consequence= @"Play time";
         IMAGE =@"";
        
    }else if (indexPath.row==2){
        consequence = nil;
        consequence= @"Phone";
         IMAGE =@"";
    }else if (indexPath.row==3){
        consequence = nil;
        consequence= @"TV time";
         IMAGE =@"";
    }else if (indexPath.row==4){
        consequence = nil;
        consequence= @"Music time";
         IMAGE =@"";
    }else if (indexPath.row==[totalconsequences count] - 1){
  
       NSString *nibNAme=@"AddConsequenceVC";
//        if ([UIScreen mainScreen].bounds.size.height==568)
//        {
            nibNAme=@"AddConsequenceVC_5";
//        }
        AddConsequenceVC *addOB =[[AddConsequenceVC alloc]initWithNibName:nibNAme bundle:nil];
        addOB.delegate=self;
        [self.navigationController pushViewController:addOB animated:YES];
    
    }else{
        IMAGE = [totalconsequences  objectAtIndex:indexPath.row];
        NSLog(@"image is %@",IMAGE);
        for(int j =0 ; j<updatename.count ; j++){
            if ([IMAGE isEqualToString:[updateconsequence objectAtIndex:j]]) {
                NSLog(@"name is %@",[updatename objectAtIndex:j]);
                consequence = nil ;
                consequence = [updatename objectAtIndex:j];
                break;
            }
            
        }
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customcell  *cell = [m_collectionview dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor] ;
    
   
    
    long row = [indexPath row];
    if (indexPath.row<5)
    {
        UIImage *image = [UIImage imageNamed:totalconsequences[row]];
        cell.imgview.image = image;
    }
    else
    {
      
        NSURL *url=[NSURL URLWithString:   [NSString stringWithFormat:@"%@",[totalconsequences objectAtIndex:indexPath.row]]];
        NSLog(@"url is %@ ",url);
        [cell.imgview setImageWithURL:url success:^(UIImage *image)
         {
            cell.imgview.image=image;

         }
            failure:^(NSError *error) {
                                   
        }];

    }
    
    [cell.cellbutton setBackgroundImage:[UIImage imageNamed:@"checkbox-unselect.png"] forState:UIControlStateNormal];
    [cell.cellbutton setBackgroundImage:[UIImage imageNamed:@"checkbox-select.png"] forState:UIControlStateSelected];
    
    if (self.selectedItemIndexPath != nil && [indexPath compare:self.selectedItemIndexPath] == NSOrderedSame) {
         [cell.cellbutton setSelected:YES];
       
    } else {
         [cell.cellbutton setSelected:NO];
         consequence = nil ;
    }
  
 
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(120, 120);
}



#pragma mark - Custom

-(void) addGradient:(UIButton *) _Button {
    
    // Add Border
    CALayer *layer = _Button.layer;
    _Button.layer.cornerRadius = 10.0;
    _Button.layer.borderWidth = 2.0;
    _Button.layer.borderColor = [UIColor blackColor].CGColor;
    
    // Add Shine
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [layer addSublayer:shineLayer];
}
-(void)callalert:(NSString *) message {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    
    [alert show];
    
}
-(void)backBtnClick
{
   
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
        NSData* responseData = [[NSData alloc] initWithData:_responseData];
        NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        
        NSLog(@"responseStr %@",responseStr);
        
        
        if ([responseData length]>0){
            
            NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
            
            NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
            
            NSLog(@"responseDict %@",responseDict);
            NSString *result = [responseDict objectForKey:@"result"];
           
            if ([result isEqualToString:@"success"]){
                NSLog(@"data= %@",[responseDict objectForKey:@"data"]  );
                NSArray *items = [responseDict valueForKeyPath:@"data"];
                
                updateconsequence = [items valueForKey:@"consequenceimage"];
                updatename =[items valueForKey:@"consequencename"];
                
                NSLog(@"count is %d  and %@ ",totalconsequences.count,totalconsequences);
                 NSLog(@" new count is %d  and %@ ",updateconsequence.count,updateconsequence);
               // [self downloadImages:updateconsequence];
                //UIImage *image=[[UIImage alloc]initwith:data];
                //[totalconsequences removeObjectAtIndex:totalconsequences.count-1];
                // [totalconsequences insertObject: atIndex:totalconsequences.count];
                // NSLog(@"count is %d  and %@ ",totalconsequences.count,totalconsequences);
                // [totalconsequences addObject:@""];
                
                for(int i=0 ; i<updateconsequence.count;i++){
                    [totalconsequences replaceObjectAtIndex:totalconsequences.count-1 withObject:updateconsequence[i]];
                    [totalconsequences insertObject:@"img-6.png"  atIndex:totalconsequences.count];
                  //  NSLog(@"count is %d  and %@ ",totalconsequences.count,totalconsequences);
                
                }
                [self.m_collectionview reloadData];
               
                
            }else {
                
               
            }
        }
        
    }else if (connection == mySecondConnection)
    {
    NSData* responseData = [[NSData alloc] initWithData:_responseData];
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    NSLog(@"responseStr %@",responseStr);
    
    
    if ([responseData length]>0){
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        
        NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
        
        NSLog(@"responseDict %@",responseDict);
        NSString *result = [responseDict objectForKey:@"result"];
      
        
        if ([result isEqualToString:@"success"]){
         
            [SVProgressHUD dismiss];
            [self callalert:@"Consequence Added Successfully"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD dismiss];
            [self callalert:@"An Error occured . Please try later."];
           
        }
    }
    }
}

-(void)downloadImages:(NSArray*)array
{
    for (int i=0; i<array.count; i++)
    {
        NSURL *url=[NSURL URLWithString:   [NSString stringWithFormat:@"%@",[array objectAtIndex:i]]];
        NSLog(@"url is %@ ",url);
          [imageView setImageWithURL:url success:^(UIImage *image)
           {
                [totalconsequences replaceObjectAtIndex:totalconsequences.count-1 withObject:image
                 ];
                [totalconsequences insertObject:@"img-6.png"  atIndex:totalconsequences.count];
                NSLog(@"count is %d  and %@ ",totalconsequences.count,totalconsequences);
                [self.m_collectionview reloadData];
          }
            failure:^(NSError *error) {
              
          }];
    }
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error %@" ,error.description);
    [SVProgressHUD dismiss];
    [self callalert:@"An Error occured . Please try later."];
}


@end
