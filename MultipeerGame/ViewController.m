//
//  ViewController.m
//  SimpleChat
//
//  Created by AJTech on 9/27/13.
//  Copyright (c) 2015 Ajay Venkat. All rights reserved.
//
#import "ViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface ViewController ()<MCBrowserViewControllerDelegate, MCSessionDelegate, UITextFieldDelegate> {
    int num;
    NSString *message;
    NSTimer *timer;
    BOOL isAllowed;
    
}

@property (nonatomic, strong) MCBrowserViewController *browserVC;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (nonatomic, strong) MCSession *mySession;
@property (nonatomic, strong) MCPeerID *myPeerID;




@end

@implementation ViewController
- (void)viewDidLoad
{

    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(move) userInfo:nil repeats:YES];
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
   
    //AF
    
    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer2];
    recognizer2.delegate = self;
     recognizer.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
    [self setUpMultipeer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setUpMultipeer{
    //  Setup peer ID
    self.myPeerID = [[MCPeerID alloc] initWithDisplayName:[UIDevice currentDevice].name];
    
    //  Setup session
    self.mySession = [[MCSession alloc] initWithPeer:self.myPeerID];
    self.mySession.delegate = self;
    
    //  Setup BrowserViewController
    self.browserVC = [[MCBrowserViewController alloc] initWithServiceType:@"chat" session:self.mySession];
    self.browserVC.delegate = self;
    
    //  Setup Advertiser
    self.advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:@"chat" discoveryInfo:nil session:self.mySession];
    [self.advertiser start];
}

- (void) showBrowserVC{
    [self presentViewController:self.browserVC animated:YES completion:nil];
}

- (void) dismissBrowserVC{
    [self.browserVC dismissViewControllerAnimated:YES completion:nil];
}

- (void) sendText{
    if (num == 10) {
        NSString* str = @"Right";
        NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        
    [self.mySession sendData:data toPeers:[self.mySession connectedPeers] withMode:MCSessionSendDataUnreliable error:&error];
    }
        
       else if (num == 100) {
            NSString* str = @"Left";
            NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error;
            
            [self.mySession sendData:data toPeers:[self.mySession connectedPeers] withMode:MCSessionSendDataUnreliable error:&error];
        }
        
    }




#pragma marks MCBrowserViewControllerDelegate


- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    [self dismissBrowserVC];
}


- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    [self dismissBrowserVC];
}

#pragma marks UITextFieldDelegate



#pragma marks MCSessionDelegate

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
    
    
}

#pragma marks UILabel

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
     isAllowed = YES;
    [self move];
message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", message);
    
   
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [label setText:message];
        NSLog(@"%@", label.text);
        
    });
    

    
   
    
       
}

-(void)move {
    if (isAllowed == YES) {
    if ([message isEqualToString:@"Right"]) {
        
        other.center = CGPointMake(other.center.x + 1, other.center.y + 0);

        
        
    }
    else if ([message isEqualToString:@"Left"]) {
        
        other.center = CGPointMake(other.center.x - 1, other.center.y + 0);

        
        
    }
        
    }
    
    else if (isAllowed == NO) {
        NSLog(@"NO");
        
    }
    

}

-(void)slideToRightWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{

    num = 10;
    [self sendText];
    

    }

-(void)slideToLeftWithGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer{
    
    num = 100;
    [self sendText];
}

-(IBAction)Start {
    [self showBrowserVC];
    
}


@end
