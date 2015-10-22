//
//  ViewControllerThree.m
//  SMTNavigationBarDemo
//
//  Created by Steffi Tan on 10/12/15.
//  Copyright © 2015 iamsteffi.com. All rights reserved.
//

#import "ViewControllerThree.h"
#import "UIViewController+SMTNavigationBar.h"
@interface ViewControllerThree ()

@end

@implementation ViewControllerThree

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setRightBarButtonItemWithKey:@"rightBtn" isDefault:YES];
    [self setTitle:@"NANANANAN" key:@"title" isDefault:NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [self loadDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)pop:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    [self setRightBarButtonItemWithKey:@"rightBtn" isDefault:NO];
}

-(void)SMTNavigationBarDidTapLeftItem{

    [self.navigationController popViewControllerAnimated:YES];
    [self setRightBarButtonItemWithKey:@"rightBtn" isDefault:NO];
    
}


-(void)SMTNavigationBarDidTapRightItem{
    UIAlertController * c = [UIAlertController alertControllerWithTitle:@"Alert" message:@"You've tapped the right bar button item on third vc" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [c addAction:ok];

    [self.navigationController presentViewController:c animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
