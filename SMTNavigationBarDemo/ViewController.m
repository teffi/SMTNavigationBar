//
//  ViewController.m
//  SMTNavigationBarDemo
//
//  Created by Steffi Tan on 10/9/15.
//  Copyright © 2015 iamsteffi.com. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+SMTNavigationBar.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self willHideBackButton:YES isAlways:YES];
   // [self setTitle:@"FIRST"];
    [self createButtons];
}

-(void)viewWillAppear:(BOOL)animated{
    [self clearSMTNavigationBar];
    [self resetSMTNavigationBar];
}

-(IBAction)bothCustomDefault:(id)sender{
    
    [self setLeftBarButtonItemWithKey:@"leftBtn" isDefault:YES isPop:YES];
    [self setRightBarButtonItemWithKey:@"rightBtn" isDefault:YES];
    
    [self performSegueWithIdentifier:@"pushSegue" sender:sender];
    // With selector
}

-(IBAction)leftCustomDefault:(id)sender{
    //Button with block selector

    [self setLeftBarButtonItemWithKey:@"leftBtn" isDefault:YES withSelectorBlock:^(UIViewController *vc) {
        
        //When controller is popped. VC becomes a uinavigationcontroller class.
        if([vc isKindOfClass:[UINavigationController class]]){
            UINavigationController * vcs = (UINavigationController *) vc;
            vc = [vcs viewControllers].lastObject;
        }
     NSLog(@"This is the block method generated on first VC but is now being presented in %@",vc.navigationItem.title);
        
     }];

    [self setRightBarButtonItemWithKey:@"rightBtn" isDefault:NO];
    
    [self performSegueWithIdentifier:@"pushSegue" sender:sender];
}

-(IBAction)rightCustomDefault:(id)sender{
    [self setRightBarButtonItemWithKey:@"rightBtn" isDefault:YES];
    
    [self performSegueWithIdentifier:@"pushSegue" sender:sender];
}

-(void)createButtons{
    //CREATE BUTTONS
    UIButton * leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [leftBtn setTitle:@"left" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [rightBtn setTitle:@"right" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    //Create key value buttons. Access universally via SMTNavigationBar
    [self createButtonWithKey:@"leftBtn" button:leftBtn];
    [self createButtonWithKey:@"rightBtn" button:rightBtn];
    
    [self setTitleViewWithImage:[UIImage imageNamed:@"logo.png"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)SMTNavigationBarDidTapRightItem{
    NSLog(@"v1 right");
}

/**  METHODS TO OVERRIDE BUTTON ACTIONS INCLUDING BLOCKS
 *
 *  -(void)SMTNavigationBarDidTapLeftItem
 *  -(void)SMTNavigationBarDidTapRightItem
 *  -(void)SMTNavigationBarDidPop
 **/
@end
