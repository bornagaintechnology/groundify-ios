//
//  SigninVC.m
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "SigninVC.h"
#import "MainHomeVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SVProgressHUD.h"

@interface SigninVC ()

@end

@implementation SigninVC

@synthesize m_usernameTextField,m_passwordTextFiled,m_logintbtn ,m_rememberbtn;

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
    self.navigationItem.title = @"Sign In";
    
    
    
    [self addGradient:(m_logintbtn)];
    [self addGradient:(m_rememberbtn)];
    [m_logintbtn setEnabled:YES];
    m_logintbtn.userInteractionEnabled = YES;
    
    // usernametextfield
    m_usernameTextField.layer.cornerRadius = 8.0;
    m_usernameTextField.layer.borderWidth = 2.0;
    m_usernameTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [m_usernameTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    // passwordtextfield
    m_passwordTextFiled.layer.cornerRadius = 8.0;
    m_passwordTextFiled.layer.borderWidth = 2.0;
    m_passwordTextFiled.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [m_passwordTextFiled setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - IBAction

- (IBAction)m_loginBtnAction:(id)sender
{
    
    [self.view endEditing:YES];
    
    if([[self.m_usernameTextField text] isEqualToString:@""] || [[self.m_passwordTextFiled text] isEqualToString:@""] ) {
        
        [self callalert:@"Please Enter Username and Password"];
    
    } else {
        
        [m_logintbtn setEnabled:NO];
        m_logintbtn.userInteractionEnabled = NO;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        device = [prefs objectForKey:@"TOKEN"];
         NSLog(@"token is ;%@", device);
        
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
        
        NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=login&username=%@&password=%@&type=%@&devicetoken=%@",self.m_usernameTextField.text,self.m_passwordTextFiled.text ,@"login",device];
        
        NSLog(@"%@",urlString);
        NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
       
        NSURLConnection *Connection=[[NSURLConnection alloc]initWithRequest:Request delegate:self];
     
  }
}


- (IBAction)m_rememberBtn:(id)sender
{
    
    if([[self.m_usernameTextField text] isEqualToString:@""] || [[self.m_passwordTextFiled text] isEqualToString:@""] ) {
    
        [self callalert:@"Please Enter Username and Password"];
        
    } else {
        
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
       [standardUserDefaults setObject:m_usernameTextField.text forKey:@"USERNAME"];
       [standardUserDefaults setObject:m_passwordTextFiled.text forKey:@"PASSWORD"];
    
       [standardUserDefaults synchronize];
    }
    
}

#pragma mark -TextField Delegate-
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.tag==1)
    {
        [m_passwordTextFiled becomeFirstResponder];
    }
   else
   {
       [m_passwordTextFiled resignFirstResponder];
       [self m_loginBtnAction: nil];
    }
    return YES;
}

#pragma mark - Custom
    -(void) addGradient:(UIButton *) _Button
{
        
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

-(void)callalert:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
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
   
    
     NSData* responseData = [[NSData alloc] initWithData:_responseData];
     NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
     NSLog(@"responseStr %@",responseStr);
     
     
     if ([responseData length]>0){
     
         NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
         NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
         NSString *result = [responseDict objectForKey:@"result"];
         NSLog(@"result %@",result);

        if ([result isEqualToString:@"success"]){
            
            // for getting userid
             NSArray *items = [responseDict valueForKeyPath:@"data"];
             NSString *userid = [items  valueForKey:@"userid"];
             NSLog(@"userid : %@",userid);
             NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
             [prefs setObject:userid forKey:@"user_id"];
             
              MainHomeVC *mainOB= nil; //[[MainHomeVC alloc] initWithNibName:@"MainHomeVC" bundle:nil];
              if ([UIScreen mainScreen].bounds.size.height==568)
              {
              mainOB=[[MainHomeVC alloc]initWithNibName:@"MainHomeVC_5" bundle:nil];
              }
              else
              {
              mainOB=[[MainHomeVC alloc]initWithNibName:@"MainHomeVC" bundle:nil];
              
              }
              [self.navigationController pushViewController:mainOB animated:YES];
            
              [SVProgressHUD dismiss];
             
         } else {
             
             [SVProgressHUD dismiss];
             m_usernameTextField.text = nil ;
             m_passwordTextFiled.text = nil;
             [m_logintbtn setEnabled:YES];
             m_logintbtn.userInteractionEnabled = YES;
             [self callalert:@"Wrong username or password.Please try again later"];

         }

     }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  
}


@end
