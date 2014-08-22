//
//  AddConsequenceVC.m
//  iGround
//
//  Created by Mohit on 23/05/14.
//  Copyright (c) 2014 Developer. All rights reserved.
//

#import "AddConsequenceVC.h"
#import "SigninVC.h"
#import "HomeViewController.h"
#import "SubmitVC.h"
#import "SBJson.h"
#import "JSON.h"
#import "NSData+Base64.h"

@interface AddConsequenceVC ()

@end

@implementation AddConsequenceVC
@synthesize  m_addbutton , m_consequence ,consequenceimage ,imageuploadbtn ;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:NO];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70,34)];
    [button setImage:[UIImage imageNamed:@"back 2.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backBtnClick)
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.title = @"Add Consequence";
    
    // textfield
    m_consequence.layer.cornerRadius = 8.0;
    m_consequence.layer.borderWidth = 2.0;
    m_consequence.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [m_consequence setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    imageuploadbtn.layer.cornerRadius = 8.0;
    imageuploadbtn.layer.borderWidth = 2.0;
    imageuploadbtn.layer.borderColor =[UIColor blackColor].CGColor;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    userid = [prefs stringForKey:@"user_id"];
    NSLog(@"user is %@",userid);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    
    // continue button
    [self addGradient:(m_addbutton)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - IBAction

- (IBAction)imageuploadaction:(id)sender
{
    if([UIImagePickerController isSourceTypeAvailable:
        UIImagePickerControllerSourceTypePhotoLibrary])
    {
        UIImagePickerController *picker= [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentModalViewController:picker animated:YES];
        
    }
}


- (IBAction)addaction:(id)sender
{
    if([[self.m_consequence text] isEqualToString:@""] )
    {
        [self callalert:@"Please Consequence Name"];
        
    }else{
        
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
//        imagePath=[self uploadimage:imageselected];
        [self performSelector:@selector(uploadimage:) withObject:imageselected afterDelay:0.01];
//        if ([imagePath length]>0)
//       {
//           
//           NSString *url=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=setConsequenceImage&userid=%@&consequence_name=%@&consequence_image=%@",userid , m_consequence.text,imagePath];
//           NSLog(@"path is %@",url);
//           NSString *properlyEscapedURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//           NSURLRequest *connrequest=[NSURLRequest requestWithURL:[NSURL URLWithString:properlyEscapedURL]];
//           NSURLConnection *myconnection=[[NSURLConnection alloc]initWithRequest:connrequest delegate:self];
//           
//       }
    }
    
  
   
   
}
-(void)uploadimage:(NSData*)imagedata

{
  
    //    NSLog(@"%@",imagedata);
    
    //    NSString *urlString = @"http://deftsoft.info/familytree//iGroundApp/images/upload.php";
   

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    
    [request setURL:[NSURL URLWithString:@"http://deftsoft.info/familytree//iGroundApp/images/upload.php"]];
    
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imagedata]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
  

    NSLog(@"first operation");
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Return string is %@",returnString);
    
    NSString *strImageUrl=nil;
    
    if ([returnString length]>0)
        
    {
        strImageUrl=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/images/%@",returnString];
        
            imagePath = strImageUrl ;
        
            NSString *url=[NSString stringWithFormat:@"http://deftsoft.info/familytree//iGroundApp/igroundapi.php?method=setConsequenceImage&userid=%@&consequence_name=%@&consequence_image=%@",userid , m_consequence.text,strImageUrl];
            NSLog(@"path is %@",url);
            NSString *properlyEscapedURL = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURLRequest *connrequest=[NSURLRequest requestWithURL:[NSURL URLWithString:properlyEscapedURL]];
            NSURLConnection *myconnection=[[NSURLConnection alloc]initWithRequest:connrequest delegate:self];
       
        
    }else{
        
        [SVProgressHUD dismiss];
        [self callalert:@"An Error occured . Please try later."];
        
    }
    
  
}

 //[SVProgressHUD showProgress:(float)percentDone/100 * 0.7 status:@"Uploading" maskType:SVProgressHUDMaskTypeGradient];
- (IBAction)consequencelbl:(id)sender
{
    
}


#pragma mark -TextField Delegates

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -Imagepicker Delegates

-(void)imagePickerController:(UIImagePickerController *)picker
      didFinishPickingImage : (UIImage *)image
                 editingInfo:(NSDictionary *)editingInfo
{
    consequenceimage.image = image;
    imageselected = UIImagePNGRepresentation(consequenceimage.image);
    //NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //[prefs setObject:imageselected forKey:@"IMAGE"];
    [picker dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *) picker
{
    [picker dismissModalViewControllerAnimated:YES];

}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

#pragma mark - Custom

-(void) addGradient:(UIButton *) _Button {
    
    // Add Border
    CALayer *layer = _Button.layer;
    _Button.layer.cornerRadius = 10.0;
    _Button.layer.borderWidth = 2.0;
    _Button.layer.borderColor = [UIColor blackColor].CGColor;
    
    // Add Shine
    CAGradientLayer *shineLayer = [CAGradientLayer layer];
    shineLayer.frame = layer.bounds;
    shineLayer.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.75f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:0.4f alpha:0.2f].CGColor,
                         (id)[UIColor colorWithWhite:1.0f alpha:0.4f].CGColor,
                         nil];
    shineLayer.locations = [NSArray arrayWithObjects:
                            [NSNumber numberWithFloat:0.0f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.0f],
                            nil];
    [layer addSublayer:shineLayer];
}

-(void)backBtnClick
{
       [self.navigationController popViewControllerAnimated:YES];
}

-(void)callalert:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
}

#pragma mark - NSURLConnection Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    _responseData = [[NSMutableData alloc] init];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSData* responseData = [[NSData alloc] initWithData:_responseData];
    NSString *responseStr = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
    
    NSLog(@"responseStr %@",responseStr);
    
    
    if ([responseData length]>0){
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        
        NSDictionary *responseDict = [[NSDictionary alloc] initWithDictionary:[responseString JSONValue]];
        
        NSLog(@"responseDict %@",responseDict);
        NSString *result = [responseDict objectForKey:@"result"];
        
        
        if ([result isEqualToString:@"success"]){
            
            [SVProgressHUD dismiss];
            [self.delegate Add_ConseQuences:imagePath ];
             NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:m_consequence.text forKey:@"NAME"];
            [self callalert:@"Consequence Added Successfully"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else {
            
            [SVProgressHUD dismiss];
            [self callalert:@"An Error occured . Please try later."];
            
        }
        
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"error %@" ,error.description);
    [SVProgressHUD dismiss];
    [self callalert:@"An Error occured . Please try later."];
}

@end
