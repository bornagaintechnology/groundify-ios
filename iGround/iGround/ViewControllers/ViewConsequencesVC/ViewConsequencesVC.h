//
//  ViewConsequencesVC.h
//  iGround
//
//  Created by Mohit on 21/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewConsequencesVC : UIViewController
{
    NSMutableData *_responseData;
    NSString *userid;
    NSArray *consequence , *childname ,*contime ,*consequenceimages;
}
@property (weak, nonatomic) IBOutlet UITableView *viewconTV;
@property (nonatomic,retain) NSURLConnection *myConnection;
@property (nonatomic,retain) NSURLConnection *mySecondConnection;
@end
