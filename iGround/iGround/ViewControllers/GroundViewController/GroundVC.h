//
//  GroundVC.h
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroundVC : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSString *userid , *childname , *conenddate,*child_id ;
    NSMutableData *_responseData;
    NSArray *childid;
}
@property (weak, nonatomic) IBOutlet UILabel *m_datetimeconlabel;
@property (weak, nonatomic) IBOutlet UILabel *m_datepickerlabelbtn;

@property (strong, nonatomic) IBOutlet UIView *m_viewdate;
@property (strong, nonatomic) IBOutlet UIView *m_viewpicker;
@property (weak, nonatomic) IBOutlet UILabel *m_fullcurrent;
@property (weak, nonatomic) IBOutlet UIDatePicker *m_datepicker;
@property (weak, nonatomic) IBOutlet UIPickerView *m_pickerView;
@property (weak, nonatomic) IBOutlet UIButton *m_childSelected;
@property (weak, nonatomic) IBOutlet UIButton *m_datentimebtn;
@property (weak, nonatomic) IBOutlet UILabel *m_curentDatenTime;
@property (weak, nonatomic) IBOutlet UIButton *m_continuebtn;
@property (weak, nonatomic) IBOutlet UILabel *m_selchidlabel;

- (IBAction)setConsequence:(id)sender;
- (IBAction)m_datepickerDonebtn:(id)sender;
- (IBAction)m_selectDateTime:(id)sender;
- (IBAction)m_pickerbtnaction:(id)sender;
- (IBAction)m_selectchildbtnaction:(id)sender;
@end
