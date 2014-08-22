//
//  GroundVC.m
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "GroundVC.h"
#import "ConsequenceVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SigninVC.h"
#import "HomeViewController.h"
#import "SubmitVC.h"

@interface GroundVC ()
{
    NSMutableArray *gender;
}

@end

@implementation GroundVC
@synthesize m_continuebtn,m_datetimeconlabel,m_selchidlabel,m_fullcurrent,m_datepickerlabelbtn;

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
    
    //userid
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
    
    
    //  child selection from pickerview
    NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=selectChild&userid=%@",userid];
    NSLog(@"%@",urlString);
    NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *Connection=[[NSURLConnection alloc]initWithRequest:Request delegate:self];
  
    
    // for current date & time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    self.m_curentDatenTime.text=[formatter stringFromDate:[NSDate date]];
    NSString *currentdate = [formatter stringFromDate:[NSDate date]];
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    [prefs1 setObject:currentdate forKey:@"CURRENT_DATE"];
    
    // Do any additional setup after loading the view from its nib.
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
    self.navigationItem.title = @"Ground Child";
    
    // continue button
    [self addGradient:(m_continuebtn)];
    
    //date&time
    m_fullcurrent.layer.cornerRadius = m_datetimeconlabel.layer.cornerRadius = 5.0;
    m_fullcurrent.layer.borderWidth = m_datetimeconlabel.layer.borderWidth = 1.0;
    m_fullcurrent.layer.borderColor = m_datetimeconlabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    //selectchildlabel
    m_datepickerlabelbtn.layer.borderColor = m_selchidlabel.layer.borderColor= [UIColor darkGrayColor].CGColor;
    m_datepickerlabelbtn.layer.borderWidth = m_selchidlabel.layer.borderWidth = 2.0 ;
    m_datepickerlabelbtn.layer.cornerRadius = m_selchidlabel.layer.cornerRadius=6.0;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setConsequence:(id)sender {
    [self.view endEditing:YES];
   
    if( [childname length] == 0  || [conenddate length] == 0  ) {
        
        [self callalert:@"All fields are required"];
    
    } else{
        
        ConsequenceVC *conOB=nil;
        
        if ([UIScreen mainScreen].bounds.size.height==568)
        {
            conOB=[[ConsequenceVC alloc]initWithNibName:@"ConsequenceVC_5" bundle:nil];
        }
        else
        {
            conOB=[[ConsequenceVC alloc]initWithNibName:@"ConsequenceVC" bundle:nil];
            
        }
        
        [self.navigationController pushViewController:conOB animated:YES];
    }
   

}
//select date and time ****************
- (IBAction)m_selectDateTime:(id)sender {
    
    self.m_viewdate.frame=CGRectMake(0, 190, 320, 220);
    [self.view addSubview:self.m_viewdate];
    [self.m_viewpicker removeFromSuperview];
}
//Done with Date & Time***************
- (IBAction)m_datepickerDonebtn:(id)sender {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    self.m_datentimebtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    self.m_datentimebtn.titleLabel.text=[formatter stringFromDate:[self.m_datepicker date]];
    [self.m_viewdate removeFromSuperview];
    conenddate = [formatter stringFromDate:[self.m_datepicker date]] ;
    NSUserDefaults *prefs2 = [NSUserDefaults standardUserDefaults];
    [prefs2 setObject:self.m_datentimebtn.titleLabel.text forKey:@"ENDDATE"];
    
    
}


- (IBAction)m_pickerbtnaction:(id)sender {
    
    [self.m_viewpicker removeFromSuperview];
}

- (IBAction)m_selectchildbtnaction:(id)sender {
    
    self.m_viewpicker.frame=CGRectMake(0, 90, 320, 200);
    [self.view addSubview:self.m_viewpicker];
    [self.m_viewdate removeFromSuperview];
}


#pragma mark- pickerView delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [gender count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [gender objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    //  self.m_genderbtn.titleLabel.text=[gender objectAtIndex:row];
    [self.m_childSelected setTitle:[gender objectAtIndex:row] forState:UIControlStateNormal];
    // m_timeselected=[gender objectAtIndex:row];
    NSLog(@"child selected %@",[childid objectAtIndex:row]);
    childname =[gender objectAtIndex:row];
    child_id = [childid objectAtIndex:row];
    
    NSUserDefaults *prefs3 = [NSUserDefaults standardUserDefaults];
    [prefs3 setObject:[gender objectAtIndex:row] forKey:@"CHILD"];
    
    NSUserDefaults *prefs6 = [NSUserDefaults standardUserDefaults];
    [prefs6 setObject:[childid objectAtIndex:row] forKey:@"CHILD_ID"];
    
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
    //write your code to prepare popview
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSData* responseData = [[NSData alloc] initWithData:_responseData];
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    NSLog(@"responseStr %@",responseStr);
    
    
    if ([responseData length]>0){
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
        NSLog(@"responseDict %@",responseDict);
        NSLog(@"data= %@",[responseDict objectForKey:@"data"]  );
        NSArray *items = [responseDict valueForKeyPath:@"data"];
       
        gender = [items valueForKey:@"child_fname"];
        childid = [items valueForKey:@"childid"];
        NSLog(@"userid : %@",gender);
     
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
