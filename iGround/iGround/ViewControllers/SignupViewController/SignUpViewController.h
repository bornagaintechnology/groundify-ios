//
//  SignUpViewController.h
//  iGround
//
//  Created by iMac on 07/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface SignUpViewController : UIViewController <UITextFieldDelegate>
{
    NSString *share ;
    NSMutableData *_responseData;
    NSData *device;
}

//IBOUTLETS
@property (nonatomic, retain) IBOutlet UITextField*         m_FatherFirstTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_FatherLastTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_MotherFirstTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_MotherLastTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_StreetAdressTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_CityTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_StateTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_ZipTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_HomePhoneTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_WorkPhoneTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_EmailTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_UserNameTextField;
@property (nonatomic, retain) IBOutlet UITextField*         m_PassTextField;

@property (nonatomic, retain) IBOutlet UIButton*            m_CheckMarkButton;
@property (nonatomic, retain) IBOutlet UIButton*            m_SignUpButton;
@property (weak, nonatomic) IBOutlet UIScrollView *m_ScrollView;

//IBAction

- (IBAction)checkMarkButtonPressed:(id)sender;
- (IBAction)SignupButtonPressed:(id)sender;

@end
