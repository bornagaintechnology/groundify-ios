//
//  SignUpViewController.m
//  iGround
//
//  Created by iMac on 07/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "SignUpViewController.h"
#import "SubmitVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

@synthesize m_CheckMarkButton, m_SignUpButton, m_CityTextField, m_EmailTextField, m_FatherFirstTextField, m_FatherLastTextField, m_HomePhoneTextField, m_MotherFirstTextField, m_MotherLastTextField, m_PassTextField, m_StateTextField, m_StreetAdressTextField, m_UserNameTextField, m_WorkPhoneTextField, m_ZipTextField ;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Life Cycle Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
   
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
   // UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Create Account";
    
    [self addGradient:(m_SignUpButton)];
    
    
  //corner radius for all textfield
    m_StreetAdressTextField.layer.cornerRadius = m_CityTextField.layer.cornerRadius = m_StateTextField.layer.cornerRadius = m_ZipTextField.layer.cornerRadius = m_HomePhoneTextField.layer.cornerRadius = m_WorkPhoneTextField.layer.cornerRadius = m_EmailTextField.layer.cornerRadius = m_UserNameTextField.layer.cornerRadius = 8.0;
  //border width
     m_FatherFirstTextField.layer.borderWidth = m_FatherLastTextField.layer.borderWidth =m_MotherFirstTextField.layer.borderWidth=  m_MotherLastTextField.layer.borderWidth =m_StreetAdressTextField.layer.borderWidth =  m_CityTextField.layer.borderWidth =  m_StateTextField.layer.borderWidth =  m_ZipTextField.layer.borderWidth = m_HomePhoneTextField.layer.borderWidth = m_WorkPhoneTextField.layer.borderWidth = m_EmailTextField.layer.borderWidth = m_UserNameTextField.layer.borderWidth = m_PassTextField.layer.borderWidth = m_ZipTextField.layer.borderWidth = 2.0;
  //bordercolor
    m_FatherFirstTextField.layer.borderColor = m_FatherLastTextField.layer.borderColor= m_MotherFirstTextField.layer.borderColor =  m_MotherLastTextField.layer.borderColor = m_StreetAdressTextField.layer.borderColor =  m_CityTextField.layer.borderColor = m_StateTextField.layer.borderColor =m_ZipTextField.layer.borderColor = m_HomePhoneTextField.layer.borderColor = m_WorkPhoneTextField.layer.borderColor = m_EmailTextField.layer.borderColor = m_UserNameTextField.layer.borderColor = m_PassTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //placeholder color
    [m_FatherFirstTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_FatherLastTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_MotherFirstTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_MotherLastTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_StreetAdressTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_CityTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_StateTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_ZipTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_HomePhoneTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_WorkPhoneTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_EmailTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_UserNameTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [m_PassTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //checkboxes
    [[self.m_CheckMarkButton imageView] setContentMode: UIViewContentModeScaleAspectFit];
    [m_CheckMarkButton setBackgroundImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
   [m_CheckMarkButton setBackgroundImage:[UIImage imageNamed:@"checked_checkbox.png"] forState:UIControlStateSelected];
   
    [self.m_ScrollView setScrollEnabled:YES];
    [self.m_ScrollView setContentSize:CGSizeMake(320,500)];

  
}

- (void)viewDidLoad
{
   
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

#pragma mark - IBACTION

- (IBAction)checkMarkButtonPressed:(id)sender {
    if([m_CheckMarkButton isSelected]==YES)
    {
        [m_CheckMarkButton setSelected:NO];
    }
    else{
        [m_CheckMarkButton setSelected:YES];
    }
  
}

#pragma mark- textfiled Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==m_FatherFirstTextField)
    {
    //13
        
    }
    else if(textField==m_FatherLastTextField)
    {//12
        
    }
    else if (textField==m_MotherFirstTextField)
    {//11
        
    }
    
    else if (textField==m_MotherLastTextField)
    {//10
        
    }
    else if (textField==m_StreetAdressTextField)
    {//9
        
    }
    else if (textField==m_CityTextField)
    {//8
       self.m_ScrollView.contentOffset=CGPointMake(0, 120);
    }
    else if (textField==m_StateTextField)
    {//7
        
    }
    else if (textField==m_ZipTextField)
    {//6
        
    }
    else if (textField==m_HomePhoneTextField)
    {//5
        self.m_ScrollView.contentOffset=CGPointMake(0, 120);
    }
    else if (textField==m_WorkPhoneTextField)
    {//4
        
    }
    else if (textField==m_EmailTextField)
    {
        
    }
    
    else if (textField==m_UserNameTextField)
    {//2
  
    }
    else if (textField==m_PassTextField)
    {
        
    }
    self.m_ScrollView.contentOffset=CGPointMake(0, 0);
    
   	
    
     return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==m_FatherFirstTextField)
    {
        //13
        
    }
    else if(textField==m_FatherLastTextField)
    {//12
        
    }
    else if (textField==m_MotherFirstTextField)
    {//11
        
    }
    
    else if (textField==m_MotherLastTextField)
    {//10
        
    }
    else if (textField==m_StreetAdressTextField)
    {//9
        
    }
    else if (textField==m_CityTextField)
    {//8
        self.m_ScrollView.contentOffset=CGPointMake(0, 60);
 
    }
    else if (textField==m_StateTextField)
    {//7
        self.m_ScrollView.contentOffset=CGPointMake(0, 60);
  
    }
    else if (textField==m_ZipTextField)
    {//6
        self.m_ScrollView.contentOffset=CGPointMake(0, 80);
 
    }
    else if (textField==m_HomePhoneTextField)
    {//5
        self.m_ScrollView.contentOffset=CGPointMake(0, 80);
    }
    else if (textField==m_WorkPhoneTextField)
    { self.m_ScrollView.contentOffset=CGPointMake(0, 80);
        
    }
    else if (textField==m_EmailTextField)
    {//3
        self.m_ScrollView.contentOffset=CGPointMake(0, 120);
    }
    
    else if (textField==m_UserNameTextField)
    {//2
        self.m_ScrollView.contentOffset=CGPointMake(0, 140);
    }
    else if (textField==m_PassTextField)
    {//1
        self.m_ScrollView.contentOffset=CGPointMake(0, 180);
    }
    return YES;
    
    
    
}
- (IBAction)SignupButtonPressed:(id)sender {
    
    
    if([m_CheckMarkButton isSelected]==YES)
    {
       share = @"yes";
    }
    else{   NSLog(@"unseleceted");
        
      share = @"no";
    }
    
    if ([[self.m_FatherFirstTextField text] isEqualToString:@""] ||
        [[self.m_FatherLastTextField text] isEqualToString:@""] ||
        [[self.m_MotherFirstTextField text] isEqualToString:@""] ||
        [[self.m_MotherLastTextField text] isEqualToString:@""] ||
        [[self.m_StreetAdressTextField text] isEqualToString:@""] ||
        [[self.m_StateTextField text] isEqualToString:@""] ||
        [[self.m_ZipTextField text] isEqualToString:@""] ||
        [[self.m_WorkPhoneTextField text] isEqualToString:@""] ||
        [[self.m_EmailTextField text] isEqualToString:@""] ||
        [[self.m_UserNameTextField text] isEqualToString:@""] ||
        [[self.m_PassTextField text] isEqualToString:@""] ||
        [[self.m_HomePhoneTextField text] isEqualToString:@""] )
    {
        
        [self callalert:@"Fields are required"];
        
    
    }else if([self NSStringIsValidEmail:self.m_EmailTextField.text] ==NO )
    {
        [self callalert:@"Please enter Valid Email Id"];
    }
    else
    {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    device = [prefs objectForKey:@"TOKEN"];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=registration&username=%@&password=%@&email=%@&father_fname=%@&father_lname=%@&mother_fname=%@&mother_lname=%@&street_address=%@&city=%@&home_phone=%@&work_phone=%@&share_inforamtion=%@&state=%@&zip=%@&devicetoken=%@",self.m_UserNameTextField.text,self.m_PassTextField.text,self.m_EmailTextField.text,self.m_FatherFirstTextField.text,self.m_FatherLastTextField.text, self.m_MotherFirstTextField.text,self.m_MotherLastTextField.text,self.m_StreetAdressTextField.text,self.m_CityTextField.text,self.m_HomePhoneTextField.text,self.m_WorkPhoneTextField.text,share,self.m_StateTextField.text,self.m_ZipTextField.text,device] ;
   
    NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *Connection=[[NSURLConnection alloc]initWithRequest:Request delegate:self];
    
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
-(void)backBtnClick
{
    //write your code to prepare popview
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
-(void)callalert:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}
-(void)emptytextfields
{
   
}
#pragma mark -Validate Email-

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
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
        NSString *result = [responseDict objectForKey:@"result"];
        
        if ([result isEqualToString:@"success"]){
            
             NSArray *items = [responseDict valueForKeyPath:@"data"];
             NSString *userid = [[items objectAtIndex:0] objectForKey:@"userid"];
             NSLog(@"userid : %@",userid);
             NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
             [prefs setObject:userid forKey:@"user_id"];
            
            
             SubmitVC *submitOB=nil;
             if ([UIScreen mainScreen].bounds.size.height==568)
             {
             submitOB=[[SubmitVC alloc]initWithNibName:@"SubmitVC_5" bundle:nil];
             }
             else
             {
             submitOB=[[SubmitVC alloc]initWithNibName:@"SubmitVC" bundle:nil];
             
             }
            
             m_UserNameTextField.text= m_EmailTextField.text = m_PassTextField.text = m_FatherFirstTextField.text = m_FatherLastTextField.text = m_MotherFirstTextField.text = m_MotherLastTextField.text =m_StreetAdressTextField.text = m_CityTextField.text = m_StateTextField.text = m_ZipTextField.text = m_HomePhoneTextField.text = m_WorkPhoneTextField.text = nil ;
            
             [self.navigationController pushViewController:submitOB animated:YES];
             [SVProgressHUD dismiss];
            
        }else{
            
             [SVProgressHUD dismiss];
             [self callalert:@"Your Email or username already exist with us"];
             m_UserNameTextField.text= m_EmailTextField.text = m_PassTextField = nil ;
           
        }
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

}

@end
