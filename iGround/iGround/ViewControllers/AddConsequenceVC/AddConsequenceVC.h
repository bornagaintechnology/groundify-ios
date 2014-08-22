//
//  AddConsequenceVC.h
//  iGround
//
//  Created by Mohit on 23/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol nutritionVCProtocol<NSObject>
-(void)Add_ConseQuences:(NSString *)string;
@end

@interface AddConsequenceVC : UIViewController < UITextFieldDelegate , UIImagePickerControllerDelegate , NSURLConnectionDelegate>
{
    NSData *imageselected ;
    NSString *userid ,*imagePath;
    NSMutableData *_responseData;
}
@property (weak, nonatomic) IBOutlet UITextField *m_consequence;
@property (weak, nonatomic) IBOutlet UIButton *m_addbutton;
@property (weak, nonatomic) IBOutlet UIImageView *consequenceimage;
@property (weak, nonatomic) IBOutlet UIButton *imageuploadbtn;
@property (weak, nonatomic) IBOutlet UILabel *consequencelbl;

@property(nonatomic,assign)id delegate;
- (IBAction)imageuploadaction:(id)sender;
- (IBAction)addaction:(id)sender;
- (IBAction)consequencetextfield:(id)sender;

@end
