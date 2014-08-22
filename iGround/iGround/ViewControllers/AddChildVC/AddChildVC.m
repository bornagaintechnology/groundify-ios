//
//  AddChildVC.m
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "AddChildVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SigninVC.h"
#import "HomeViewController.h"
#import "SubmitVC.h"

@interface AddChildVC ()
{ NSMutableArray *gender,*months , *days , *years;
}

@end

@implementation AddChildVC
@synthesize m_submitbtn, m_firstnameTextfield,m_lastnameTextfield ,m_genderbtn,m_genderlabel;

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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
    
    gender=[[NSMutableArray alloc] initWithObjects:@"MALE",@"FEMALE", nil];
    
    months =[[NSMutableArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"April",@"May",@"June",@"July",@"Aug" ,@"Sep",@"Oct",@"Nov",@"Dec", nil];
    
    days = [[NSMutableArray alloc] init];
    for (int j=1; j<=31; j++) {
        [days addObject:[NSString stringWithFormat:@"%d",j]];
    }
    
    //Get Current Year into i2
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int i2  = [[formatter stringFromDate:[NSDate date]] intValue];
    
    //Create Years Array from 1960 to This year
    years = [[NSMutableArray alloc] init];
    for (int i=1970; i<=i2; i++) {
        [years addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:NO];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Add Child";
    
    //submit button
    [self addGradient:(m_submitbtn)];
    
    //corner radius for all textfield
    m_firstnameTextfield.layer.cornerRadius = m_lastnameTextfield.layer.cornerRadius  = 8.0;
    //border width
    m_firstnameTextfield.layer.borderWidth = m_lastnameTextfield.layer.borderWidth = 2.0;
    //bordercolor
    m_firstnameTextfield.layer.borderColor = m_lastnameTextfield.layer.borderColor= [UIColor lightGrayColor].CGColor;
    
    //placeholder color
    [m_firstnameTextfield setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_lastnameTextfield setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
   //gender button
    m_genderlabel.layer.borderColor= [UIColor darkGrayColor].CGColor;
    m_genderlabel.layer.borderWidth = 2.0 ;
    m_genderlabel.layer.cornerRadius=6.0;
    
    
}
#pragma mark - IBAction
- (IBAction)m_dateofbirth:(id)sender {
    //self.m_dateVU.frame=CGRectMake(0,200,320,200);
//[self.view addSubview:self.m_dateVU];
    [self.view endEditing:YES];
    self.m_monthpickerVU.frame=CGRectMake(0,175, 310, 290);
    [self.view addSubview:self.m_monthpickerVU];
    
    
}
- (IBAction)dayaction:(id)sender {
    [self.view endEditing:YES];
    self.m_dateVU.frame=CGRectMake(0,175, 310, 290);
    [self.view addSubview:self.m_dateVU];
    
}
- (IBAction)yearaction:(id)sender {
    [self.view endEditing:YES];
    self.m_yearVU.frame=CGRectMake(0,175, 310, 290);
    [self.view addSubview:self.m_yearVU];
}
- (IBAction)m_genderaction:(id)sender {
    [self.view endEditing:YES];
    self.m_genderVU.frame=CGRectMake(0,230, 310, 250);
    [self.view addSubview:self.m_genderVU];
    
    
}

- (IBAction)dateDone:(id)sender {
    
    [self.m_dateVU removeFromSuperview];
    
}
- (IBAction)monthDone:(id)sender{
   
    [self.m_monthpickerVU removeFromSuperview];
}

- (IBAction)yearDone:(id)sender{
    
    [self.m_yearVU removeFromSuperview];
}

- (IBAction)genderDone:(id)sender {
    
    // self.m_genderbtn.titleLabel.text=[gender objectAtIndex:row];
    [self.m_genderVU removeFromSuperview];
}

// submit info
- (IBAction)m_submitbtnaction:(id)sender{
    [self.view endEditing:YES];
    NSLog(@"monthval is %@ and %d ",monthval,monthval.length);
    if( [monthval length] == 0  || [dateval length] == 0 || [yearval length] ==0 || [genderval length] ==0 ||[[self.m_firstnameTextfield text] isEqualToString:@""] || [[self.m_lastnameTextfield text] isEqualToString:@""]) {
        
        [self callalert:@"All fields are required"];
        [SVProgressHUD dismiss];
   
    }else{
        
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
        NSString *dob=[NSString stringWithFormat:@"%@/%@/%@",dateval,monthval,yearval];
        NSLog(@"dob= %@", dob);
        NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=addChild&userid=%@&child_fname=%@&child_lname=%@&dob=%@&gender=%@",userid, self.m_firstnameTextfield.text,self.m_lastnameTextfield.text,dob,genderval];
        NSLog(@"%@",urlString);
        NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSURLConnection *Connection=[[NSURLConnection alloc]initWithRequest:Request delegate:self];
   
    }
   
}



#pragma mark- textfield delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark- pickerView delegates

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.m_genderpickerVU){
      return [gender count];
    }else if (pickerView == self.m_monthpicker) {
      return [months count];
    }else if (pickerView == self.datepickerVU) {
      return [days count];
    } else{
      return [years count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     if (pickerView == self.m_genderpickerVU){
        return [gender objectAtIndex:row];
     }else if (pickerView == self.m_monthpicker) {
        return [months objectAtIndex:row];
     }else if (pickerView == self.datepickerVU) {
        return [days objectAtIndex:row];
     }else{
        return [years objectAtIndex:row];
     }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == self.m_genderpickerVU){
    //self.m_genderbtn.titleLabel.text=[gender objectAtIndex:row];
    // m_timeselected=[gender objectAtIndex:row];
        genderval = [gender objectAtIndex:row];
    [self.m_genderbtn setTitle:[gender objectAtIndex:row] forState:UIControlStateNormal];
    NSLog(@"gender selected %@",[gender objectAtIndex:row]);
    
    }else if (pickerView == self.m_monthpicker) {
        
        monthval = [months objectAtIndex:row];
        [self.m_DOBaction setTitle:[months objectAtIndex:row] forState:UIControlStateNormal];
        NSLog(@"month selected %@",[months objectAtIndex:row]);
        
    }else if (pickerView == self.datepickerVU) {
        
        dateval = [days objectAtIndex:row];
        [self.daybtn setTitle:[days objectAtIndex:row] forState:UIControlStateNormal];
        NSLog(@"day selected %@",[days objectAtIndex:row]);
    
    }else{
        yearval = [years objectAtIndex:row];
        [self.yearbtn setTitle:[years objectAtIndex:row] forState:UIControlStateNormal];
        NSLog(@"year selected %@",[years objectAtIndex:row]);
    }
    
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
        NSString *result = [responseDict objectForKey:@"result"];
     // NSLog(@"data= %@",[responseDict objectForKey:@"data"]  );
        
        if ([result isEqualToString:@"success"]){
            
            [SVProgressHUD dismiss];
            [self callalert:@"Child Added Successfully"];
            [self.navigationController popViewControllerAnimated:YES];
           
        } else{
            
            [self callalert:@"Please try later."];
            [SVProgressHUD dismiss];
        
        }
        
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
