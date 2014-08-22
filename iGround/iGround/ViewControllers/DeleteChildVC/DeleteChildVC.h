//
//  DeleteChildVC.h
//  iGround
//
//  Created by Mohit on 21/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
@interface DeleteChildVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableData *_responseData ,*resdata;
  
    NSString *userid;
    NSArray *child ,*childid , *m_array;
    NSDictionary *activeMissions;
}


@property (weak, nonatomic) IBOutlet UITableView *childtableVU;
@property (nonatomic,retain) NSURLConnection *myConnection;
@property (nonatomic,retain) NSURLConnection *mySecondConnection;
@end
