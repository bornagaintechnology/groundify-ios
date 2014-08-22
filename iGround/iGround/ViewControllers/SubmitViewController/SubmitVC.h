//
//  SubmitVC.h
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitVC : UIViewController
{
    NSString *userid;
}
@property (weak, nonatomic) IBOutlet UIButton *m_settingbtn;
- (IBAction)settingbtnaction:(id)sender;
@end
