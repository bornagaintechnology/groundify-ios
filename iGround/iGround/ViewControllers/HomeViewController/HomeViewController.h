//
//  HomeViewController.h
//  iGround
//
//  Created by iMac on 07/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <GooglePlus/GooglePlus.h>
#import <GoogleOpenSource/GoogleOpenSource.h>
#import "SVProgressHUD.h"

@class GPPSignInButton;
@interface HomeViewController : UIViewController <GPPSignInDelegate ,NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
    NSData *device;
}


@property (retain, nonatomic) IBOutlet FBLoginView *loginView;
@property (retain, nonatomic) IBOutlet GPPSignInButton *googlePlusButton;
//@property (retain, nonatomic) IBOutlet UIButton *googlePlusButton;
@property (retain, nonatomic)  GPPSignIn *signIn ;
@property ( retain ,nonatomic) NSString *type ,*username , *password ;


- (IBAction)signUpButtonPressed:(id)sender;
- (IBAction)signInButtonPressed:(id)sender;
- (IBAction)facebookLoginButtonPressed:(id)sender;
- (IBAction)googlePlusLoginButtonPressed:(id)sender;

@end
