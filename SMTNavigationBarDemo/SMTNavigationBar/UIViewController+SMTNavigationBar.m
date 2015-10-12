//
//  UIViewController+SMTNavigationBar.m
//  SMTNavigationBar
//
//  Created by Steffi Tan on 10/8/15.
//  Copyright © 2015 iamsteffi.com. All rights reserved.
//

#import "UIViewController+SMTNavigationBar.h"
#import "SMTSharedNavigationBar.h"


typedef enum BUTTON_SELECTORS{
    LEFT_BUTTON_ACTION,
    RIGHT_BUTTON_ACTION,
    POP_ACTION
    
}BUTTON_SELECTORS;

@implementation UIViewController (SMTNavigationBar)

#pragma mark - Navigationbar configs
#pragma mark -
-(void)willHideBackButton:(BOOL)willHide isAlways:(BOOL)isAlways{
    self.navigationItem.hidesBackButton = willHide;
    if(isAlways){
        [self getSharedNavBar].willHideBackBtnAlways = isAlways;
    }
}

#pragma mark - Create Button
#pragma mark -
-(void)createButtonWithKey:(NSString *)key button:(UIButton *)btn{
    [[self getSharedNavBar] addToButtonList:key button:btn];
}

#pragma mark - Left bar buttons
#pragma mark -

-(void)setLeftBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault isPop:(BOOL)isPop{
    //Removes the "..." appearing during transition
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    self.navigationItem.hidesBackButton = YES;
    UIButton * btn = (UIButton *)[[self getSharedNavBar].buttonList valueForKey:key];
    [self getSharedNavBar].defaultLeftButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    if(isPop){
        barBtn = [self convertToBarButtonItem:btn withSelector:POP_ACTION];
    }else{
        barBtn = [self convertToBarButtonItem:btn withSelector:LEFT_BUTTON_ACTION];
    }
    [self getSharedNavBar].defaultLeftPop = isPop;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.leftBarButtonItem = barBtn;
}

-(void)setLeftBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault withSelectorBlock:(LeftAction_BlockSelector)block{
    
    self.navigationItem.hidesBackButton = YES;
    [self getSharedNavBar].defaultLeftPop = NO;
    
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    UIButton * btn = (UIButton *)[snb.buttonList valueForKey:key];
    snb.defaultLeftButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    if((isDefault)&&(block)) {
        snb.leftActionBlock = block;
    }
    barBtn = [self convertToBarButtonItem:btn withSelector:LEFT_BUTTON_ACTION];
    self.navigationItem.leftBarButtonItem = barBtn;
}

#pragma mark - Right bar buttons
#pragma mark -
-(void)setRightBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    
    UIButton * btn = (UIButton *)[snb.buttonList valueForKey:key];
    snb.defaultRightButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    barBtn = [self convertToBarButtonItem:btn withSelector:RIGHT_BUTTON_ACTION];
    self.navigationItem.rightBarButtonItem = barBtn;
}

-(void)setRightBarButtonItemWithKey:(NSString *)key isDefault:(BOOL)isDefault withSelectorBlock:(RightAction_BlockSelector)block{
    
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    self.navigationItem.hidesBackButton = YES;
    UIButton * btn = (UIButton *)[snb.buttonList valueForKey:key];
    snb.defaultRightButton = isDefault? btn:nil;
    
    //Add selector and convert to bar button
    UIBarButtonItem * barBtn;
    
    if((isDefault)&&(block)){
        snb.rightActionBlock = block;
    }
    
    barBtn = [self convertToBarButtonItem:btn withSelector:RIGHT_BUTTON_ACTION];
    self.navigationItem.rightBarButtonItem = barBtn;
}

-(void)loadDefaults{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    //NSLog(@"load defaults");
    
    //Controller loses self reference when presented coming from a POP.
    //Sol: Update self reference
    [self updateSelfReference];
    
    self.navigationItem.hidesBackButton = snb.willHideBackBtnAlways;

    if(snb.defaultLeftButton){
        
        if(snb.defaultLeftPop){
             self.navigationItem.leftBarButtonItem = [self convertToBarButtonItem:snb.defaultLeftButton withSelector:POP_ACTION];
        }else{
            self.navigationItem.leftBarButtonItem = [self convertToBarButtonItem:snb.defaultLeftButton withSelector:LEFT_BUTTON_ACTION];
        }
    }
    
    if(snb.defaultRightButton){
        self.navigationItem.rightBarButtonItem = [self convertToBarButtonItem:snb.defaultRightButton withSelector:RIGHT_BUTTON_ACTION];
    }
}

-(UIBarButtonItem *)convertToBarButtonItem:(UIButton *)btn withSelector:(BUTTON_SELECTORS)selectors{
    
    //Safe mechanism: Need to clear targets to flush selectors associated with the btn.
    [self clearTargetOfBtn:btn];
    
    switch (selectors) {
        case 0:
            [btn addTarget:self action:@selector(SMTNavigationBarDidTapLeftItem) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 1:
            [btn addTarget:self action:@selector(SMTNavigationBarDidTapRightItem) forControlEvents:UIControlEventTouchUpInside];
            break;
        case 2:
            [btn addTarget:self action:@selector(SMTNavigationBarDidPop) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    
    UIBarButtonItem * barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    return barBtn;
}

#pragma mark - Target Selectors
#pragma mark -
-(void)SMTNavigationBarDidTapLeftItem{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    snb.selfReference = self;
    if(snb.leftActionBlock){
        [snb runLeftActionBlockSelector:nil];
    }
}

-(void)SMTNavigationBarDidTapRightItem{
    SMTSharedNavigationBar * snb = [self getSharedNavBar];
    snb.selfReference = self;
    if(snb.rightActionBlock){
        [snb runRightActionBlockSelector:nil];
    }
}

-(void)SMTNavigationBarDidPop{
    //NSLog(@"SELF before pop%@",[self getSharedNavBar].selfReference);
    [[self getSharedNavBar].selfReference.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Super Blocks
#pragma mark -
-(void)runLeftSuperBlock{
    [self getSharedNavBar].selfReference = self;
    [[self getSharedNavBar] runLeftActionBlockSelector:nil];
}

-(void)runRightSuperBlock{
    [self getSharedNavBar].selfReference = self;
    [[self getSharedNavBar] runRightActionBlockSelector:nil];
}


#pragma mark - Utility
#pragma mark -
-(SMTSharedNavigationBar *)getSharedNavBar{
    SMTSharedNavigationBar * snb = [SMTSharedNavigationBar sharedNavigationBar];
    return snb;
}

-(void)resetSMTNavigationBar{
    [[self getSharedNavBar] resetSMTNavigationBar];
}

-(void)updateSelfReference{
    [self getSharedNavBar].selfReference = self;
}

-(void)clearSMTNavigationBar{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)clearTargetOfBtn:(UIButton *)btn{
    [btn removeTarget:nil action:NULL forControlEvents:UIControlEventTouchUpInside];
}
@end
