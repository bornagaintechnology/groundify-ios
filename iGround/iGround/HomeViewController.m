//
//  HomeViewController.m
//  iGround
//
//  Created by iMac on 07/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "HomeViewController.h"
#import "SignUpViewController.h"
#import "SigninVC.h"
#import "MainHomeVC.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"
#import "SVProgressHUD.h"



@interface HomeViewController ()


@end

@implementation HomeViewController
@synthesize  googlePlusButton , type , username , password;
static NSString * const kClientId =@"82748208920-fmfc0obsj06lnucm3c0hg5njr287lna6.apps.googleusercontent.com";


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
   [self.navigationController setNavigationBarHidden:YES];
   
    
    for (UIButton *button in self.view.subviews) {
        button.layer.cornerRadius = 4.0;
        if (button.tag == 1 || button.tag == 2) { //check for signin and signup button
            button.layer.borderWidth = 1.0;
            button.layer.borderColor = [UIColor colorWithRed:111.0/255.0 green:159.0/255.0 blue:195.0/255.0 alpha:1.0].CGColor;
        }
    }
    self.signIn=[[GPPSignIn alloc]init];
    [GPPSignInButton class];
    googlePlusButton.frame = CGRectMake(12,363,20,10);
    
    [self.googlePlusButton setImage:[UIImage imageNamed:@"gpp_sign_in_light_button_normal"] forState:UIControlStateNormal];
    [self.googlePlusButton setImage:[UIImage imageNamed:@"gpp_sign_in_light_button_pressed"] forState:UIControlStateHighlighted];
    self.signIn = [GPPSignIn sharedInstance];
    
    //signIn.clientID = kClientId;
    self.signIn.scopes = [NSArray arrayWithObjects:kGTLAuthScopePlusLogin,kGTLAuthScopePlusMe,nil];
    [self.signIn plusService];
    self.signIn.shouldFetchGoogleUserEmail=YES;
    self.signIn.delegate = self;
    self.signIn.actions = [NSArray arrayWithObjects:
                           @"http://schemas.google.com/AddActivity",
                           @"http://schemas.google.com/BuyActivity",
                           @"http://schemas.google.com/CheckInActivity",
                           @"http://schemas.google.com/CommentActivity",
                           @"http://schemas.google.com/CreateActivity",
                           @"http://schemas.google.com/ListenActivity",
                           @"http://schemas.google.com/ReserveActivity",
                           @"http://schemas.google.com/ReviewActivity",
                           nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
}

#pragma mark - GPPDeepLinkDelegate
- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error
{
    if(!error) {
        // Get the email address.
        NSLog(@"email:%@", self.signIn.authentication.userEmail);
    }
    [self reportAuthStatus];
}

- (void)didDisconnectWithError:(NSError *)error
{
    if (error)
    {
        NSLog(@"Status: Failed to disconnect: %@", error);
    }
    else
    {
        
    }
}
- (void)reportAuthStatus
{
    if ([GPPSignIn sharedInstance].authentication)
    {
        NSLog( @"Status: Authenticated");
        [self retrieveUserInfo];
        
    }
    else
    {
        // To authenticate, use Google+ sign-in button.
        
    }
}
- (void)retrieveUserInfo
{
    
    NSLog(@"Email: %@",
          [GPPSignIn sharedInstance].authentication.userEmail);
    GTLServicePlus* plusService = [[GTLServicePlus alloc] init] ;
    plusService.retryEnabled = YES;
    [plusService setAuthorizer:[GPPSignIn sharedInstance].authentication];
    
    GTLQueryPlus *query = [GTLQueryPlus queryForPeopleGetWithUserId:@"me"];
    
    [plusService executeQuery:query
            completionHandler:^(GTLServiceTicket *ticket,
                                GTLPlusPerson *person,
                                NSError *error) {
                if (error)
                {
                    GTMLoggerError(@"Error: %@", error);
                } else
                {
                   
                    [person retain];
                    NSString *description = [NSString stringWithFormat:
                                             @"%@\n%@\n%@", person.displayName,
                                             person.image,person.name];
                    NSLog(@"description:%@\n@person:%@",description,person);
                    username = _signIn.authentication.userEmail ;
                   // username = person.displayName;
                    password = person.identifier ;
                    type = @"facebook";
                    //self.emailId=_signIn.authentication.userEmail;
                    [self redirect];
                }
            }];
}

#pragma mark - IBACTION

- (IBAction)signUpButtonPressed:(id)sender {
    
    SignUpViewController *vc = nil;
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        vc=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController_5" bundle:nil];
    }
    else
    {
        vc=[[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
        
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)signInButtonPressed:(id)sender {
    
    SigninVC *signOB= nil;//[[SigninVC alloc] initWithNibName:@"SigninVC" bundle:nil];
    if ([UIScreen mainScreen].bounds.size.height==568)
    {
        signOB=[[SigninVC alloc]initWithNibName:@"SigninVC_5" bundle:nil];
    }
    else
    {
        signOB=[[SigninVC alloc]initWithNibName:@"SigninVC" bundle:nil];
        
    }
    [self.navigationController pushViewController:signOB animated:YES];
    
}

- (IBAction)facebookLoginButtonPressed:(id)sender
    {
        [self openSessionWithAllowLoginUI:YES];
       
       // if (FBSession.activeSession.isOpen)
       // {
       //[self performSelector:@selector(signInButtonPressed:)];
       // }
       // else
       //{
        // [self openSessionWithAllowLoginUI:YES];
            
       // }
    }


- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error
{
    switch (state)
    {
        case FBSessionStateOpen:
            if (!error)
            {
                // We have a valid session
                [[FBRequest requestForMe] startWithCompletionHandler:^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error)
                 {
                      if (!error)
                         {
                           [SVProgressHUD dismiss];
                            NSLog(@"%@",user);
                            NSLog(@" Email = %@%@%@",[user objectForKey:@"email"],[user objectForKey:@"first_name"],[user objectForKey:@"last_name"]);
                             username = [user objectForKey:@"email"];
                             password = [user objectForKey:@"id"] ;
                             type = @"facebook";
                            [self redirect];
                         }
                        }];
              }
            
        break;
            
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
        break;
        default:
            break;
    }
    
    if (error)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI
{
    [FBSettings setLoggingBehavior:[NSSet setWithObjects:FBLoggingBehaviorFBRequests, FBLoggingBehaviorFBURLConnections, nil]];
    
    
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_actions", @"email",@"user_photos", nil];
    return [FBSession openActiveSessionWithPermissions:permissions allowLoginUI:allowLoginUI
                completionHandler:^(FBSession *session,FBSessionState state,NSError *error) {
                                [self sessionStateChanged:session state:state error:error];
                                }];
}
- (IBAction)googlePlusLoginButtonPressed:(id)sender {
  
}

#pragma mark- custom

-(void)redirect{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    device = [prefs objectForKey:@"TOKEN"];
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    NSString *urlString=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=login&username=%@&password=%@&devicetoken=%@",username,password,device];
    NSLog(@"%@",urlString);
    NSURLRequest *Request=[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *Connection=[[NSURLConnection alloc]initWithRequest:Request delegate:self];
    
}
-(void)callalert:(NSString *) message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
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
            NSString *userid = [[items objectAtIndex:0] objectForKey:@"userid"];
            NSLog(@"userid : %@",userid);
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:userid forKey:@"user_id"];
            
            MainHomeVC *mainOB= nil;
            
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
           
            [self callalert:@"Wrong username or password.Please try again later"];
            
        }
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
