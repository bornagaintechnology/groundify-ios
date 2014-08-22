//
//  customcell.h
//  iGround
//
//  Created by Mohit on 20/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customcell : UICollectionViewCell

- (IBAction)selectedcheckbox:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cellbutton;

@property (strong,nonatomic) UIImageView *imgview;
@end
