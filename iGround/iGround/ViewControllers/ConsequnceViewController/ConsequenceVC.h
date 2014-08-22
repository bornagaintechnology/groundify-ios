//
//  ConsequenceVC.h
//  iGround
//
//  Created by Mohit on 08/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsequenceVC : UIViewController < UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , NSURLConnectionDelegate>
{
    NSString *userid ,*currentdate , *selectedchild ,*enddate , *childid, *consequence,*IMAGE;
    NSMutableArray *totalconsequences;
    NSMutableData *_responseData , *selectedconsequence ;
    NSArray *updateconsequence,*updatename;
    
    UIImageView  *imageView;
}


@property (weak, nonatomic) IBOutlet UIButton *m_setconbtn;
@property (weak, nonatomic) IBOutlet UICollectionView *m_collectionview;
@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@property (nonatomic,retain) NSURLConnection *myConnection;
@property (nonatomic,retain) NSURLConnection *mySecondConnection;
- (IBAction)setConsequence:(id)sender;

@end
