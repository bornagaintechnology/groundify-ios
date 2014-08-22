//
//  MainHomeVC.h
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"


@interface MainHomeVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tabledata;
}
@property (strong, nonatomic) NSArray *tabledata;
@property (weak, nonatomic) IBOutlet UIButton *m_addchildbtn;
@property (weak, nonatomic) IBOutlet UIButton *m_delchildbtn;
@property (weak, nonatomic) IBOutlet UIButton *m_groundChild;
@property (weak, nonatomic) IBOutlet UIButton *m_consequence;
@property (weak, nonatomic) IBOutlet UITableView *m_maintableview;

- (IBAction)m_addChild:(id)sender;
- (IBAction)m_deleteChild:(id)sender;
- (IBAction)m_groundChild:(id)sender;
- (IBAction)consequence:(id)sender;
- (IBAction)groundchild:(id)sender;

@end
