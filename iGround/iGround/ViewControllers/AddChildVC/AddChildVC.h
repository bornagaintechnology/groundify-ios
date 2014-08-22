//
//  AddChildVC.h
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface AddChildVC : UIViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    NSString *userid ,*monthval , *dateval, *yearval , *genderval;
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UITextField *m_firstnameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *m_lastnameTextfield;
@property (weak, nonatomic) IBOutlet UIButton *m_DOBaction;
@property (weak, nonatomic) IBOutlet UIButton *m_genderbtn;
@property (strong, nonatomic) IBOutlet UIView *m_genderVU;
@property (weak, nonatomic) IBOutlet UIPickerView *m_genderpickerVU;
@property (weak, nonatomic) IBOutlet UIButton *yearbtn;
@property (weak, nonatomic) IBOutlet UILabel *m_genderlabel;
@property (weak, nonatomic) IBOutlet UIButton *m_submitbtn;
@property (weak, nonatomic) IBOutlet UIButton *daybtn;
@property (weak, nonatomic) IBOutlet UIPickerView *m_monthpicker;
@property (strong, nonatomic) IBOutlet UIView *m_monthpickerVU;
@property (strong, nonatomic) IBOutlet UIView *m_dateVU;
@property (weak, nonatomic) IBOutlet UIPickerView *datepickerVU;
@property (strong, nonatomic) IBOutlet UIView *m_yearVU;
@property (weak, nonatomic) IBOutlet UIPickerView *yearpickerVU;

- (IBAction)m_genderaction:(id)sender;
- (IBAction)m_dateofbirth:(id)sender;
- (IBAction)genderDone:(id)sender;
- (IBAction)m_submitbtnaction:(id)sender;
- (IBAction)dateDone:(id)sender;
- (IBAction)monthDone:(id)sender;
- (IBAction)yearDone:(id)sender;
- (IBAction)yearaction:(id)sender;
- (IBAction)dayaction:(id)sender;
@end
