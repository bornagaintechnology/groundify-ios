//
//  customcell.m
//  iGround
//
//  Created by Mohit on 20/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "customcell.h"

@implementation customcell
@synthesize  cellbutton , imgview ;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 120, 120)];
        [self addSubview:imgview];
        cellbutton= [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cellbutton.frame = CGRectMake(93 ,93 ,22 ,22 );
        
        [cellbutton addTarget:self
                     action:@selector(selectedcheckbox:)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cellbutton];

    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)selectedcheckbox:(UIButton*)sender {
   /* if([cellbutton isSelected]==YES)
    {
        [cellbutton setSelected:NO];
    }
    else{
        [cellbutton setSelected:YES];
    }*/

}
@end
