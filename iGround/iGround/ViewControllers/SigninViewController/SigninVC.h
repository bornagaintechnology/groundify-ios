//
//  SigninVC.h
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"


@interface SigninVC : UIViewController<UITextFieldDelegate ,NSURLConnectionDelegate>
{
  NSMutableData *_responseData;
     NSData *device;
}
@property (weak, nonatomic) IBOutlet UITextField *m_usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *m_passwordTextFiled;
@property (weak, nonatomic) IBOutlet UIButton *m_logintbtn;
@property (nonatomic, retain) IBOutlet UIButton *m_rememberbtn;


- (IBAction)m_loginBtnAction:(id)sender;
- (IBAction)m_rememberBtn:(id)sender;

@end
